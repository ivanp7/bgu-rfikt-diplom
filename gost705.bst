%%
%% This is file `gost705.bst',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% gost705.dtx  (with options: `gost705')
%% 
%% Copyright (c) 2004-2014 Stanislav Kruchinin.
%% All rights reserved.
%% 
%% This file is part of the disser package.
%% 


ENTRY
  { address
    annote
    author
    booktitle
    bookauthor
    chapter
    edition
    editor
    compiler
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    numpages
    publisher
    school
    series
    title
    type
    volume
    year
    language
    booklanguage
    url
    urldate
    isbn
    doi
    archive
    archivePrefix
    primaryClass
    eprint
    authortype
    media
    location
    ipc
    holder
    credits
    reqnumber
    reqdate
    pubdate
    publication
    prdate
    prnumber
    prcountry
    pagetotal
  }
  {}
  { label }

INTEGERS { output.state before.all mid.sentence after.sentence after.block
after.dblslash after.slash after.colon after.semicolon after.dash }

FUNCTION {init.state.consts}
{
  #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
  #4 'after.dblslash :=
  #5 'after.slash :=
  #6 'after.colon :=
  #7 'after.semicolon :=
  #8 'after.dash :=
}

STRINGS { s t }

STRINGS { curlanguage }

FUNCTION {change.language}
{
  booklanguage empty$
    { "" }
    { booklanguage  'curlanguage :=
      "\selectlanguageifdefined{"
      curlanguage *
      "}" *
    }
  if$
}

FUNCTION {output.nonnull}
{
  swap$
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
        { add.period$ " " * write$
          newline$
          "\newblock " write$
        }
        { output.state before.all =
          'write$
            { output.state after.dblslash =
                { "~//" * change.language * " " * write$ }
                { output.state after.slash =
                    { "~/ " * write$ }
                    { output.state after.colon =
                        { ": " * write$ }
                        { output.state after.semicolon =
                            { "; " * write$ }
                            { output.state after.dash =
                                { "~--- " * write$ }
                                { add.period$ " " * write$ }
                              if$
                            }
                          if$
                        }
                      if$
                    }
                  if$
                }
              if$
            }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
}

FUNCTION {output}
{
  duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{
  't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {fin.entry}
{
  add.period$
  write$
  newline$
}

FUNCTION {new.block}
{
  output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.dblslash}
{
  output.state before.all =
    'skip$
    { after.dblslash 'output.state := }
  if$
}

FUNCTION {new.slash}
{
  output.state before.all =
    'skip$
    { after.slash 'output.state := }
  if$
}

FUNCTION {new.colon}
{
  output.state before.all =
    'skip$
    { after.colon 'output.state := }
  if$
}

FUNCTION {new.semicolon}
{
  output.state before.all =
    'skip$
    { after.semicolon 'output.state := }
  if$
}

FUNCTION {new.dash}
{
  output.state before.all =
    'skip$
    { after.dash 'output.state := }
  if$
}

FUNCTION {new.sentence}
{
  output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {add.blank} { " " * before.all 'output.state := }

FUNCTION {not}
{
    { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{
    'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{
    { pop$ #1 }
    'skip$
  if$
}

FUNCTION {non.stop}
{
  duplicate$
  "}" * add.period$
  #-1 #1 substring$ "." =
}

FUNCTION {new.block.checka}
{
  empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb}
{
  empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {new.sentence.checka}
{
  empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.sentence.checkb}
{
  empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}

FUNCTION {field.or.null}
{
  duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{
  duplicate$ empty$
    { pop$ "" }
    { "\BibEmph{" swap$ * "}" * }
  if$
}

FUNCTION {space.word} { " " swap$ * " " * }

FUNCTION {bbl.edby} % { "\bbledby{}" }
{
  curlanguage "english" =
  { "Ed. by " }
    { curlanguage "german" =
      { "ed. " }
        { curlanguage "russian" =
          { "{\cyr\CYRP\cyro\cyrd\ \cyrr\cyre\cyrd.\ }" }
          { "language is not defined: " language  "edited by" * *
           warning$ "edited by" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.cmplr}
{
  curlanguage "english" =
  { "Compiler " }
    { curlanguage "german" =
      { "Hrsg. " }
        { curlanguage "russian" =
        { "{\cyr\CYRS\cyro\cyrs\cyrt.\ }" }
        { "language is not defined: " language  "compiler" * * warning$ "compiler" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.edition} % { "\bbledition{}" }
{
  curlanguage "english" =
   { "edition" }
   { curlanguage "german" =
     { "Aufl." }
       { curlanguage "russian" =
         { "{\cyr\cyri\cyrz\cyrd.}" }
         { "language is not defined: " language  "edition" * * warning$ "edition" }
       if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.vvolume} % { "\bblVolume{}" }
{
  curlanguage "english" =
    { "Volume" }
    { curlanguage "german" =
      { "Band" }
      { curlanguage "russian" =
        { "{\cyr\CYRT\cyro\cyrm}" }
        { "language is not defined: " language  "Volume" * * warning$ "Volume" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.vvol} % { "\bblVol{}" }
{
  curlanguage "english" =
    { "Vol." }
    { curlanguage "german" =
      { "Bd." }
      { curlanguage "russian" =
        { "{\cyr\CYRT.}" }
        { "language is not defined: " language  "Vol." * * warning$ "Vol." }
        if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.iissue} % { "\bblIssue{}" }
{
  curlanguage "english" =
    { "Issue" }
    { curlanguage "german" =
      { "Heft" }
      { curlanguage "russian" =
        { "{\cyr\CYRV\cyrery\cyrp\cyru\cyrs\cyrk}" }
        { "language is not defined: " language * warning$ "Issue" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.iiss} % { "\bblIss{}" }
{
  curlanguage "english" =
    { "Iss." }
    { curlanguage "german" =
      { "H." }
      { curlanguage "russian" =
        { "{\cyr\CYRV\cyrery\cyrp.}" }
        { "language is not defined: " language * warning$ "Iss." }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.of} % { "\bblof{}" }
{
  curlanguage "english" =
    { "of" }
    { curlanguage "german" =
      { "von" }
      { curlanguage "russian" =
        { "{\cyr\cyri\cyrz}" }
        { "language is not defined: " language * warning$ "of" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.etal} % { "\bblof{}" }
{
  curlanguage "english" =
    { "et~al." }
    { curlanguage "german" =
      { "u.~a." }
      { curlanguage "russian" =
        { "{\cyr\cyri~\cyrd\cyrr.}" }
        { "language is not defined: " language * warning$ "etal" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.nnumber} % { "\bblNumber{}" }
{
  curlanguage "english" =
    { "Number" }
    { curlanguage "german" =
      { "Heft" }
      { curlanguage "russian" =
        { "{\cyr\CYRN\cyro\cyrm\cyre\cyrr}" }
        { "language is not defined: " language * warning$ "Number" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.number} % { "\bblnumber{}" }
{
  curlanguage "english" =
    { "number" }
    { curlanguage "german" =
      { "Heft" }
      { curlanguage "russian" =
        { "{\cyr\cyrn\cyro\cyrm\cyre\cyrr}" }
        { "language is not defined: " language * warning$ "number" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.nr} % { "\bblno{}" }
{
  curlanguage "english" =
    { "no." }
    { curlanguage "german" =
      { "H." }
      { curlanguage "russian" =
        { "{\cyr\textnumero}" }
        { "language is not defined: " language * warning$ "no" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.nnr} % { "\bblno{}" }
{
  curlanguage "english" =
    { "No." }
    { curlanguage "german" =
      { "H." }
      { curlanguage "russian" =
        { "{\cyr\textnumero}" }
        { "language is not defined: " language * warning$ "No" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.in} % { "\bblin{}" }
{
  curlanguage "english" =
    { "in" }
    { curlanguage "german" =
      { "in" }
    { curlanguage "russian" =
      { "{\cyr\cyrv}" }
      { "language is not defined: " language * warning$ "in" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.iin} % { "\bblIn{}" }
{
  curlanguage "english" =
    { "In" }
    { curlanguage "german" =
      { "In" }
      { curlanguage "russian" =
        { "{\cyr\CYRV}" }
        { "language is not defined: " language * warning$ "In" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.pages} % { "\bblpp." }
{
  curlanguage "english" =
    { "p." }
    { curlanguage "german" =
      { "S." }
      { curlanguage "russian" =
        { "{\cyr\cyrs.}" }
        { "language is not defined: " language * warning$ "p." }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.page} % { "\bblp." }
{
  curlanguage "english" =
    { "p." }
    { curlanguage "german" =
      { "S." }
      { curlanguage "russian" =
        { "{\cyr\cyrs.}"}
        { "language is not defined: " language * warning$ "p." }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.ppages} % { "\bblPp." }
{
  curlanguage "english" =
    { "P." }
    { curlanguage "german" =
      { "S." }
      { curlanguage "russian" =
        { "{\cyr\CYRS.}" }
        { "language is not defined: " language * warning$ "P." }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.ppage} % { "\bblP." }
{
  curlanguage "english" =
    { "P." }
    { curlanguage "german" =
      { "S." }
      { curlanguage "russian" =
        { "{\cyr\CYRS.}" }
        { "language is not defined: " language * warning$ "P." }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.techrep}
{
  curlanguage "english" =
    { "Tech.~Rep." }
    { curlanguage "german" =
      { "Tech.~Bericht" }
      { curlanguage "russian" =
        { "{\cyr\CYRT\cyre\cyrh.\ \cyrd\cyro\cyrk\cyrl\cyra\cyrd.}" }
        { "language is not defined: " language * warning$ "Tech Rep" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.mthesis}
{
  curlanguage "english" =
    { "Master's thesis" }
    { curlanguage "german" =
      { "Diss.~Mag." }
      { curlanguage "russian" =
        { "{\cyr\CYRM\cyra\cyrg\cyri\cyrs\cyrt\cyre\cyrr\cyrs\cyrk\cyra\cyrya\ "
          "\cyrd\cyri\cyrs\cyrs\cyre\cyrr\cyrt\cyra\cyrc\cyri\cyrya}" * }
         { "language is not defined: " language * warning$ "Master thesis" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.phdthesis}
{
  curlanguage "english" =
    { "Ph.\,D. thesis" }
    { curlanguage "german" =
      { "Diss.~Ph.\,D." }
      { curlanguage "russian" =
        { "{\cyr\CYRK\cyra\cyrn\cyrd\cyri\cyrd\cyra\cyrt\cyrs\cyrk\cyra\cyrya\ "
          "\cyrd\cyri\cyrs\cyrs\cyre\cyrr\cyrt\cyra\cyrc\cyri\cyrya}" * }
        { "language is not defined: " language * warning$ "PhD thesis" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.docdisser}
{
  curlanguage "english" =
    { "Dr.\,Sci. dissertation" }
    { curlanguage "german" =
      { "Diss.~Dr." }
      { curlanguage "russian" =
        { "{\cyr\CYRD\cyro\cyrk\cyrt\cyro\cyrr\cyrs\cyrk\cyra\cyrya\ "
          "\cyrd\cyri\cyrs\cyrs\cyre\cyrr\cyrt\cyra\cyrc\cyri\cyrya}" * }
        { "language is not defined: " language * warning$ "Dr. Sci. dissertation" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.req}
{
  curlanguage "english" =
    { "req." }
    { curlanguage "german" =
      { "ang." }
      { curlanguage "russian" =
        { "{\cyr\cyrz\cyra\cyrya\cyrv\cyrl.}" }
        { "language is not defined: " language * warning$ "req" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.publ}
{
  curlanguage "english" =
    { "publ." }
    { curlanguage "german" =
      { "ausg." }
      { curlanguage "russian" =
        { "{\cyr\cyro\cyrp\cyru\cyrb\cyrl.}" }
        { "language is not defined: " language * warning$ "In" }
      if$
      }
    if$
    }
  if$
}

FUNCTION {bbl.prio}
{
  curlanguage "english" =
    { "priority" }
    { curlanguage "german" =
      { "Prioritat" }
      { curlanguage "russian" =
        { "{\cyr\cyrp\cyrr\cyri\cyro\cyrr\cyri\cyrt\cyre\cyrt}" }
        { "language is not defined: " language * warning$ "In" }
      if$
      }
    if$
    }
  if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{
  's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{vv~}{ll}{~f.}{, jj}" format.name$ 't :=
      nameptr #1 >
        { nameptr #4 =
          numnames #4 > and
            { "others" 't :=
              #1 'namesleft := }
            'skip$
          if$
          namesleft #1 >
            { ", " * t * }
            { t "others" =
              t "~others" =
              or
                { " " * bbl.etal * }
                { ", " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.names.rev}
{
  's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{f.}{~vv}{~ll}{, jj}" format.name$ 't :=
      nameptr #1 >
        { nameptr #4 =
          numnames #4 > and
            { "others" 't :=
              #1 'namesleft := }
            'skip$
          if$
          namesleft #1 >
            { ", " * t * }
            { t "others" =
              t "~others" =
              or
                { " " * bbl.etal * }
                { ", " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.authors}
{
  author empty$
    { "" }
    { author format.names emphasize }
  if$
}

FUNCTION {format.bookauthors}
{
  bookauthor empty$
    { "" }
    { bookauthor format.names }
  if$
}

FUNCTION {format.authors.after}
{
  author empty$
    { "" }
    { author format.names.rev }
  if$
}

FUNCTION {format.bookauthors.after}
{
  bookauthor empty$
    { "" }
    { bookauthor format.names.rev }
  if$
}

FUNCTION {format.editors.after}
{
  editor empty$
    { "" }
    { bbl.edby editor format.names.rev * }
  if$
}

FUNCTION {format.compiler.after}
{
  compiler empty$
    { "" }
    { bbl.cmplr compiler format.names.rev * }
  if$
}

FUNCTION {format.title}
{
  title empty$
    { "" }
    { title }
  if$
}

FUNCTION {format.date}
{
  year empty$
    { month empty$
        { "" }
        { "there's a month but no year in " cite$ * warning$ month }
      if$
    }
    { month empty$
        'year
        { year ". " quote$ "--- " month * * * * }
      if$
    }
  if$
}

FUNCTION {output.address.publisher.date}
{
  address empty$
    'skip$
    { address output
      publisher empty$
        'skip$
        { new.colon }
      if$
    }
  if$
  publisher output
  format.date output
}

FUNCTION {output.bibitem}
{
  newline$
  "\bibitem" "{" * write$
  cite$ write$
  "}" write$
  newline$
  language empty$
    { "english" 'curlanguage := }
    { language  'curlanguage := }
  if$
  "\selectlanguageifdefined{" write$
  curlanguage write$
  "}" write$ newline$
  ""
  before.all 'output.state :=
}

FUNCTION {n.dashify}
{
  't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "--" *
              t #2 global.max$ substring$ 't :=
            }
            {   { t #1 #1 substring$ "-" = }
                { "-" *
                  t #2 global.max$ substring$ 't :=
                }
              while$
            }
          if$
        }
        { t #1 #1 substring$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}

FUNCTION {word.in} { bbl.iin " " * }

FUNCTION {format.btitle} { title }

FUNCTION {tie.or.space.connect}
{
  duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {tie.connect} { "~" swap$ * * }

FUNCTION {either.or.check}
{
  empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{
  volume empty$
    { "" }
    { bbl.vvol volume tie.connect
      series empty$
        'skip$
        { bbl.of space.word * series emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.number.series}
{
  volume empty$
    { number empty$
        { series field.or.null }
        { series empty$
            { "there's a number but no series in " cite$ * warning$
              bbl.nnr
            }
            { new.sentence
              bbl.iiss series tie.or.space.connect
              ", " * bbl.nr
              tie.or.space.connect
            }
          if$
          number tie.or.space.connect
        }
      if$
    }
    { "" }
  if$
}

FUNCTION {is.num}
{
  chr.to.int$
  duplicate$ "0" chr.to.int$ < not
  swap$ "9" chr.to.int$ > not and
}

FUNCTION {extract.num}
{
  duplicate$ 't :=
  "" 's :=
    { t empty$ not }
    { t #1 #1 substring$
      t #2 global.max$ substring$ 't :=
      duplicate$ is.num
        { s swap$ * 's := }
        { pop$ "" 't := }
      if$
    }
  while$
  s empty$
    'skip$
    { pop$ s }
  if$
}

FUNCTION {convert.edition} { edition }

FUNCTION {format.edition}
{
  edition empty$
    { "" }
    { output.state mid.sentence =
        { convert.edition "l" change.case$ " " * bbl.edition * }
        { convert.edition "t" change.case$ " " * bbl.edition * }
      if$
    }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{
  't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{
  pages empty$
    { "" }
    { pages multi.page.check
        { bbl.ppages pages n.dashify tie.connect }
        { bbl.ppage pages tie.connect }
      if$
    }
  if$
}

FUNCTION {format.pages.page}
{
  pages empty$
    { numpages empty$
        { "" }
        { numpages bbl.pages tie.connect }
      if$
    }
    { format.pages }
  if$
}

FUNCTION {format.vol.num.pages}
{
  volume field.or.null
  number empty$
    'skip$
    { ", no." number tie.or.space.connect *
      volume empty$
        { "there's a number but no volume in " cite$ * warning$ }
        'skip$
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
        { pop$ format.pages }
        { ": " * pages n.dashify * }
      if$
    }
  if$
}

FUNCTION {format.volume}
{
  volume empty$
    { "" }
    { bbl.vvol volume tie.or.space.connect }
  if$
}

FUNCTION {format.number}
{ number empty$
    { "" }
    { bbl.nr number tie.or.space.connect }
  if$
}

FUNCTION {empty.misc.check}
{
  author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
  key empty$ not and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {format.thesis.type}
{
  type empty$
    'skip$
    { pop$
      type "t" change.case$
    }
  if$
}

FUNCTION {format.tr.number}
{
  type empty$
    { bbl.techrep }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}

FUNCTION {author.before}
{
  author empty$
    'skip$
    { format.authors output
      new.sentence
    }
  if$
}

FUNCTION {bookauthor.before}
{
  bookauthor empty$
    'skip$
    { format.bookauthors output
      new.sentence
    }
  if$
}

FUNCTION {author.after}
{
  author empty$
    'skip$
    { author num.names$ #3 >
      { format.authors.after output
        new.semicolon
      }
      'skip$
    if$
    }
  if$
}

FUNCTION {bookauthor.after}
{
  bookauthor empty$
    'skip$
    { bookauthor num.names$ #3 >
      { format.bookauthors.after output
        new.semicolon
      }
      'skip$
    if$
    }
  if$
}

FUNCTION {editor.organization.after}
{
  compiler empty$
    'skip$
    { format.compiler.after output
      new.semicolon
    }
  if$
  editor empty$
    'skip$
    { format.editors.after output
      new.semicolon
    }
  if$
  organization empty$
    'skip$
    { organization output
      new.semicolon
    }
  if$
}

FUNCTION {format.annote}
{
  annote empty$
    { "" }
    { after.sentence 'output.state :=
      "\BibAnnote{" annote add.period$ * "}" *
    }
  if$
}

FUNCTION {format.url}
{
  url empty$
    { "" }
    { "\BibUrl{" url * "}" * }
  if$
}

FUNCTION {format.urldate}
{
  urldate empty$
    { "" }
    { add.blank
      "\BibUrlDate{" urldate * "}" *
    }
  if$
}

FUNCTION {output.url}
{
  url empty$
    'skip$
    { format.url output
      format.urldate output
    }
  if$
}

FUNCTION {format.isbn}
{
  isbn empty$
    { "" }
    { "ISBN:~\href{http://isbndb.com/search-all.html?kw=" isbn *
      "}{" * isbn * "}" *
    }
  if$
}

FUNCTION {add.doi.url}
{ duplicate$ empty$
    'skip$
    { doi empty$
      { url empty$
          'skip$
          { "\href{" url * "}{" * swap$ * "}" * }
        if$
      }
      { "\href{http://dx.doi.org/" doi * "}{" * swap$ * "}" * }
      if$
    }
  if$
}

FUNCTION {format.eprint}
{ eprint empty$
    { "" }
    { primaryClass empty$
       { " \href{http://arxiv.org/abs/" eprint * "}" *
       "{" * eprint * "}" *
        }
        { archivePrefix empty$
            { " \href{http://arxiv.org/abs/" eprint * "}" *
             "{" * primaryClass * "/" * eprint * "}" *
            }
            { " \href{http://arxiv.org/abs/" eprint * "}" *
           "{" * archivePrefix * ":" * primaryClass * "/" * eprint * "}" *
            }
          if$
        }
     if$
    }
  if$
}

FUNCTION {add.number}
{ duplicate$ empty$
    { "" }
    { bbl.nr swap$ tie.or.space.connect }
  if$
}

FUNCTION {in.square.brackets}
{
  duplicate$ empty$
    { pop$ "" }
    { "[" swap$ * "]" * }
  if$
}

FUNCTION {in.round.brackets}
{
  duplicate$ empty$
    { pop$ "" }
    { "(" swap$ * ")" * }
  if$
}

FUNCTION {format.type.number}
{
  type empty$
    { "" }
    {
      number empty$
      { "" }
      { type number tie.or.space.connect }
    if$
    }
  if$
}

FUNCTION {format.reqdate}
{ reqdate empty$
    { "" }
    { bbl.req reqdate tie.or.space.connect }
  if$
}

FUNCTION {format.pubdate}
{ pubdate empty$
    { "" }
    { bbl.publ pubdate tie.or.space.connect }
  if$
}

FUNCTION {format.prdate}
{ prdate empty$
    { "" }
    { bbl.prio prdate tie.or.space.connect }
  if$
}

FUNCTION {article}
{
  output.bibitem
  author.before
  format.title "title" output.check
  new.dblslash
  journal emphasize add.doi.url "journal" output.check
  new.block
  format.date output
  new.block
  format.volume output
  format.number output
  new.block
  format.pages.page output
  new.block
  note output
  new.sentence
  format.eprint output
  new.block
  output.url
  format.annote output
  fin.entry
}

FUNCTION {book}
{
  output.bibitem
  author.before
  format.btitle add.doi.url "title" output.check
  new.slash
  editor.organization.after
  new.sentence
  format.number.series output
  new.block
  format.edition output
  new.block
  output.address.publisher.date
  new.block
  format.bvolume output
  new.block
  format.pages.page output
  new.block
  format.isbn output
  new.block
  note output
  new.sentence
  format.eprint output
  new.block
  output.url
  format.annote output
  fin.entry
}

FUNCTION {booklet}
{
  output.bibitem
  author.before
  format.title "title" output.check
  editor.organization.after
  new.block
  howpublished output
  address output
  format.date output
  new.block
  note output
  new.sentence
  format.eprint output
  new.block
  output.url
  format.annote output
  fin.entry
}

FUNCTION {inbook}
{
  output.bibitem
  author.before
  format.btitle add.doi.url "title" output.check
  new.dblslash
  bookauthor.before
  booktitle "booktitle" output.check
  editor.organization.after
  new.block
  format.edition output
  new.block
  format.number.series output
  new.sentence
  output.address.publisher.date
  new.block
  format.bvolume output
  new.block
  format.pages.page output
  new.block
  format.isbn output
  new.block
  note output
  new.sentence
  format.eprint output
  new.block
  output.url
  format.annote output
  fin.entry
}

FUNCTION {incollection}
{
  output.bibitem
  author.before
  new.sentence
  format.title add.doi.url "title" output.check
  new.dblslash
  booktitle "booktitle" output.check
  new.slash
  editor.organization.after
  new.block
  output.address.publisher.date
  new.block
  format.bvolume output
  format.number.series output
  new.block
  format.pages.page output
  new.block
  note output
  new.block
  format.eprint output
  new.block
  output.url
  format.annote output
  fin.entry
}

FUNCTION {inproceedings}
{
  output.bibitem
  author.before
  new.sentence
  format.title add.doi.url "title" output.check
  new.dblslash
  booktitle "booktitle" output.check
  new.slash
  editor.organization.after
  new.block
  format.bvolume output
  format.number.series output
  new.block
  address empty$
    { publisher output
      format.date "year" output.check
    }
    { address output.nonnull
      new.colon
      publisher output
      format.date "year" output.check
    }
  if$
  new.block
  format.pages.page output
  new.block
  note output
  new.sentence
  format.eprint output
  new.block
  output.url
  format.annote output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{
  output.bibitem
  author empty$
    { organization empty$
        'skip$
        { organization output.nonnull
          address output
        }
      if$
    }
    { format.authors output.nonnull }
  if$
  new.block
  format.btitle "title" output.check
  author empty$
    { organization empty$
        { address new.block.checka
          address output
        }
        'skip$
      if$
    }
    { organization address new.block.checkb
      organization output
      address output
    }
  if$
  format.edition output
  format.date output
  new.block
  note output
  new.sentence
  format.eprint output
  new.block
  output.url
  format.annote output
  fin.entry
}

FUNCTION {mastersthesis}
{
  output.bibitem
  format.authors "author" output.check
  new.block
  format.btitle add.doi.url "title" output.check
  new.block
  bbl.mthesis format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  new.block
  note output
  new.block
  format.eprint output
  new.block
  output.url
  format.annote output
  fin.entry
}

FUNCTION {misc}
{
  output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  howpublished output
  new.block
  format.date output
  new.block
  note output
  new.sentence
  format.eprint output
  new.block
  output.url
  format.annote output
  fin.entry
}

FUNCTION {phdthesis}
{
  output.bibitem
  format.authors "author" output.check
  new.sentence
  format.btitle add.doi.url "title" output.check
  new.colon
  bbl.phdthesis format.thesis.type output.nonnull
  new.slash
  school "school" output.check
  new.block
  output.address.publisher.date
  new.block
  format.pages.page output
  note output
  new.sentence
  format.eprint output
  new.block
  output.url
  format.annote output
  fin.entry
}

FUNCTION {docdisser}
{
  output.bibitem
  format.authors "author" output.check
  new.sentence
  format.btitle add.doi.url "title" output.check
  new.colon
  bbl.docdisser format.thesis.type output.nonnull
  new.slash
  school "school" output.check
  new.block
  output.address.publisher.date
  new.block
  format.pages.page output
  note output
  new.sentence
  format.eprint output
  new.block
  output.url
  format.annote output
  fin.entry
}

FUNCTION {proceedings}
{
  output.bibitem
  format.btitle add.doi.url "title" output.check
  new.slash
  editor.organization.after
  new.block
  format.bvolume output
  format.number.series output
  address empty$
    { publisher output
      format.date "year" output.check
    }
    { address output.nonnull
      format.date "year" output.check
      new.sentence
      publisher output
    }
  if$
  new.block
  note output
  new.sentence
  format.eprint output
  new.block
  output.url
  format.annote output
  fin.entry
}

FUNCTION {techreport}
{
  output.bibitem
  author.before
  new.sentence
  format.title add.doi.url "title" output.check
  new.colon
  format.tr.number output.nonnull
  editor.organization.after
  new.block
  address output
  new.colon
  institution "institution" output.check
  format.date "year" output.check
  new.block
  note output
  new.sentence
  format.eprint output
  new.block
  output.url
  format.annote output
  fin.entry
}

FUNCTION {patent}
{
  output.bibitem
  title output.nonnull
  add.blank
  media in.square.brackets output
  new.colon
  format.type.number output
  add.blank
  location output
  new.colon
  ipc output
  new.slash
  format.authors.after "author" output.check
  add.blank
  authortype in.round.brackets output.nonnull
  new.semicolon
  holder output.nonnull
  new.semicolon
  credits output.nonnull
  new.dash
  reqnumber add.number output
  new.semicolon
  format.reqdate output
  new.semicolon
  format.pubdate output
  publication output
  new.semicolon
  format.prdate output
  prnumber output
  prcountry in.round.brackets output
  new.block
  note output
  new.sentence
  output.url
  format.annote output
  new.block
  pagetotal output
  fin.entry
}

FUNCTION {unpublished}
{
  output.bibitem
  author.before
  format.btitle add.doi.url "title" output.check
  editor.organization.after
  new.block
  note "note" output.check
  new.sentence
  format.eprint output
  new.block
  output.url
  format.annote output
  fin.entry
}

FUNCTION {default.type} { misc }

MACRO {jan} {"\bbljan{}"}
MACRO {feb} {"\bblfeb{}"}
MACRO {mar} {"\bblmar{}"}
MACRO {apr} {"\bblapr{}"}
MACRO {may} {"\bblmay{}"}
MACRO {jun} {"\bbljun{}"}
MACRO {jul} {"\bbljul{}"}
MACRO {aug} {"\bblaug{}"}
MACRO {sep} {"\bblsep{}"}
MACRO {oct} {"\bbloct{}"}
MACRO {nov} {"\bblnov{}"}
MACRO {dec} {"\bbldec{}"}

MACRO {aa}{"Astron. \& Astrophys."}
MACRO {aasup}{"Astron. \& Astrophys. Suppl. Ser."}
MACRO {aj} {"Astron. J."}
MACRO {aph} {"Acta Phys."}
MACRO {advp} {"Adv. Phys."}
MACRO {ajp} {"Amer. J. Phys."}
MACRO {ajm} {"Amer. J. Math."}
MACRO {amsci} {"Amer. Sci."}
MACRO {anofd} {"Ann. Fluid Dyn."}
MACRO {am} {"Ann. Math."}
MACRO {ap} {"Ann. Phys. (NY)"}
MACRO {adp} {"Ann. Phys. (Leipzig)"}
MACRO {ao} {"Appl. Opt."}
MACRO {apl} {"Appl. Phys. Lett."}
MACRO {app} {"Astroparticle Phys."}
MACRO {apj} {"Astrophys. J."}
MACRO {apjsup} {"Astrophys. J. Suppl."}
MACRO {apss} {"Astrophys. Space Sci."}
MACRO {araa} {"Ann. Rev. Astron. Astrophys."}
MACRO {baas} {"Bull. Amer. Astron. Soc."}
MACRO {baps} {"Bull. Amer. Phys. Soc."}
MACRO {cmp} {"Comm. Math. Phys."}
MACRO {cpam} {"Commun. Pure Appl. Math."}
MACRO {cppcf} {"Comm. Plasma Phys. \& Controlled Fusion"}
MACRO {cpc} {"Comp. Phys. Comm."}
MACRO {cqg} {"Class. Quant. Grav."}
MACRO {cra} {"C. R. Acad. Sci. A"}
MACRO {fed} {"Fusion Eng. \& Design"}
MACRO {ft} {"Fusion Tech."}
MACRO {grg} {"Gen. Relativ. Gravit."}
MACRO {ieeens} {"IEEE Trans. Nucl. Sci."}
MACRO {ieeeps} {"IEEE Trans. Plasma Sci."}
MACRO {ijimw} {"Interntl. J. Infrared \& Millimeter Waves"}
MACRO {ip} {"Infrared Phys."}
MACRO {irp} {"Infrared Phys."}
MACRO {jap} {"J. Appl. Phys."}
MACRO {jasa} {"J. Acoust. Soc. America"}
MACRO {jcp} {"J. Comp. Phys."}
MACRO {jchp} {"J. Chem. Phys."}
MACRO {jetp} {"Sov. Phys.--JETP"}
MACRO {jfe} {"J. Fusion Energy"}
MACRO {jfm} {"J. Fluid Mech."}
MACRO {jmp} {"J. Math. Phys."}
MACRO {jne} {"J. Nucl. Energy"}
MACRO {jnec} {"J. Nucl. Energy, C: Plasma Phys., Accelerators, Thermonucl. Res."}
MACRO {jnm} {"J. Nucl. Mat."}
MACRO {jpc} {"J. Phys. Chem."}
MACRO {jpp} {"J. Plasma Phys."}
MACRO {jpsj} {"J. Phys. Soc. Japan"}
MACRO {jsi} {"J. Sci. Instrum."}
MACRO {jvst} {"J. Vac. Sci. \& Tech."}
MACRO {nat} {"Nature"}
MACRO {nature} {"Nature"}
MACRO {nedf} {"Nucl. Eng. \& Design/Fusion"}
MACRO {nf} {"Nucl. Fusion"}
MACRO {nim} {"Nucl. Inst. \& Meth."}
MACRO {nimpr} {"Nucl. Inst. \& Meth. in Phys. Res."}
MACRO {np} {"Nucl. Phys."}
MACRO {npb} {"Nucl. Phys. B"}
MACRO {nt/f} {"Nucl. Tech./Fusion"}
MACRO {npbpc} {"Nucl. Phys. B (Proc. Suppl.)"}
MACRO {inc} {"Nuovo Cimento"}
MACRO {nc} {"Nuovo Cimento"}
MACRO {pf} {"Phys. Fluids"}
MACRO {pfa} {"Phys. Fluids A: Fluid Dyn."}
MACRO {pfb} {"Phys. Fluids B: Plasma Phys."}
MACRO {pl} {"Phys. Lett."}
MACRO {pla} {"Phys. Lett. A"}
MACRO {plb} {"Phys. Lett. B"}
MACRO {prep} {"Phys. Rep."}
MACRO {pnas} {"Proc. Nat. Acad. Sci. USA"}
MACRO {pp} {"Phys. Plasmas"}
MACRO {ppcf} {"Plasma Phys. \& Controlled Fusion"}
MACRO {phitrsl} {"Philos. Trans. Roy. Soc. London"}
MACRO {prl} {"Phys. Rev. Lett."}
MACRO {pr} {"Phys. Rev."}
MACRO {physrev} {"Phys. Rev."}
MACRO {pra} {"Phys. Rev. A"}
MACRO {prb} {"Phys. Rev. B"}
MACRO {prc} {"Phys. Rev. C"}
MACRO {prd} {"Phys. Rev. D"}
MACRO {pre} {"Phys. Rev. E"}
MACRO {ps} {"Phys. Scripta"}
MACRO {procrsl} {"Proc. Roy. Soc. London"}
MACRO {rmp} {"Rev. Mod. Phys."}
MACRO {rsi} {"Rev. Sci. Inst."}
MACRO {science} {"Science"}
MACRO {sciam} {"Sci. Am."}
MACRO {sam} {"Stud. Appl. Math."}
MACRO {sjpp} {"Sov. J. Plasma Phys."}
MACRO {spd} {"Sov. Phys.--Doklady"}
MACRO {sptp} {"Sov. Phys.--Tech. Phys."}
MACRO {spu} {"Sov. Phys.--Uspekhi"}
MACRO {st} {"Sky and Telesc."}

MACRO {appopt} {"Appl. Opt."}
MACRO {bell} {"Bell Syst. Tech. J."}
MACRO {ell} {"Electron. Lett."}
MACRO {jasp} {"J. Appl. Spectr."}
MACRO {jqe} {"IEEE J. Quantum Electron."}
MACRO {jlwt} {"J. Lightwave Technol."}
MACRO {jmo} {"J. Mod. Opt."}
MACRO {josa} {"J. Opt. Soc. America"}
MACRO {josaa} {"J. Opt. Soc. Amer.~A"}
MACRO {josab} {"J. Opt. Soc. Amer.~B"}
MACRO {jdp} {"J. Phys. (Paris)"}
MACRO {oc} {"Opt. Commun."}
MACRO {ol} {"Opt. Lett."}
MACRO {os} {"Opt. Spectrosc."}
MACRO {phtl} {"IEEE Photon. Technol. Lett."}
MACRO {pspie} {"Proc. Soc. Photo-Opt. Instrum. Eng."}
MACRO {sjot} {"Sov. J. Opt. Technol."}
MACRO {sjqe} {"Sov. J. Quantum Electron."}
MACRO {sleb} {"Sov. Phys.--Leb. Inst. Rep."}
MACRO {stph} {"Sov. Phys.--Techn. Phys."}
MACRO {stphl} {"Sov. Techn. Phys. Lett."}
MACRO {vr} {"Vision Res."}
MACRO {zph} {"Z. f. Physik"}
MACRO {zphb} {"Z. f. Physik~B"}
MACRO {zphd} {"Z. f. Physik~D"}

MACRO {sse} {"Solid-State Electron."}
MACRO {pss} {"Phys. Sol. State"}
MACRO {sst} {"Semicond. Sci. Tech."}
MACRO {nl} {"Nano Lett."}

READ


STRINGS { longest.label }

INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{
  "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{
  number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\ifx\undefined\BibEmph\def\BibEmph#1{#1}\else\fi"
  write$ newline$
  "\ifx\undefined\href\def\href#1#2{#2}\else\fi"
  write$ newline$
  "\ifx\undefined\url\def\url#1{\texttt{#1}}\else\fi"
  write$ newline$
  "\ifx\undefined\urlprefix\def\urlprefix{URL: }\else\fi"
  write$ newline$
  "\ifx\undefined\BibUrl\def\BibUrl#1{\urlprefix\url{#1}}\else\fi"
  write$ newline$
  "\ifx\undefined\BibUrlDate\long\def\BibUrlDate#1{({%"
  write$ newline$
  "\cyr\cyrd\cyra\cyrt\cyra\ %"
  write$ newline$
  "\cyro\cyrb\cyrr\cyra\cyrshch\cyre\cyrn\cyri\cyrya}: #1)}\else\fi"
  write$ newline$
  "\ifx\undefined\BibAnnote\long\def\BibAnnote#1{#1}\else\fi"
  write$ newline$
  "\begin{thebibliography}{" longest.label  * "}" *
  write$ newline$
  "\def\selectlanguageifdefined#1{"
  write$ newline$
  "\expandafter\ifx\csname date#1\endcsname\relax"
  write$ newline$
  "\else\language\csname l@#1\endcsname\fi}"
  write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{
  newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}

