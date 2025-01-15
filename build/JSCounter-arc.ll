; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define void @JSCounter_eval(ptr %0) {
  %2 = load i1, ptr %0, align 1
  %3 = getelementptr i8, ptr %0, i32 3
  %4 = load i1, ptr %3, align 1
  store i1 %2, ptr %3, align 1
  %5 = xor i1 %4, %2
  %6 = and i1 %5, %2
  br i1 %6, label %7, label %22

7:                                                ; preds = %1
  %8 = getelementptr i8, ptr %0, i32 1
  %9 = load i1, ptr %8, align 1
  %10 = getelementptr i8, ptr %0, i32 2
  %11 = load i4, ptr %10, align 1
  %12 = xor i1 %9, true
  %13 = trunc i4 %11 to i1
  %14 = xor i1 %13, true
  %15 = lshr i4 %11, 1
  %16 = trunc i4 %15 to i3
  %17 = zext i3 %16 to i4
  %18 = zext i1 %14 to i4
  %19 = shl i4 %18, 3
  %20 = or i4 %17, %19
  %21 = select i1 %12, i4 0, i4 %20
  store i4 %21, ptr %10, align 1
  br label %22

22:                                               ; preds = %7, %1
  %23 = getelementptr i8, ptr %0, i32 2
  %24 = load i4, ptr %23, align 1
  %25 = getelementptr i8, ptr %0, i32 4
  store i4 %24, ptr %25, align 1
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
