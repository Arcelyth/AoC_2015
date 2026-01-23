import scala.io.Source.fromFile
import scala.util.matching.Regex

@main
def part1() = 
  var replace: List[(String, String)] = List()
  var mole = ""
  var ans = Set[String]()
  val path = "../input"
  val source = fromFile(path)
  for line <- source.getLines() do
    val reg: Regex = """(\w+) => (\w+)""".r
    reg.findFirstMatchIn(line) match 
      case Some(pair) => 
        replace = (pair.group(1), pair.group(2)) :: replace
      case None => 
        if line != "" then
          mole = line
  for (from, to) <- replace do 
    val reg = from.r
    
    for m <- reg.findAllMatchIn(mole) do
      val newMole = mole.substring(0, m.start) + to + mole.substring(m.end)
      ans = ans + newMole
    end for
  end for
  println(s"Count: ${ans.size}")


