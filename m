Return-Path: <linux-wireless+bounces-16348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6769F045A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 06:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D0E18833E0
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 05:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA4618A6D7;
	Fri, 13 Dec 2024 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6tG50JL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F0D18A6BC;
	Fri, 13 Dec 2024 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734068829; cv=none; b=d3je9aYgrGkVAAmkPNIYOOCRcsKOBywPEFxlMtQTxAl7ZOq+EpLpoosgA5iJkOiZ/VjNjRyz5FAERmrhYAAPPgcysH9+Dx+Ul4rZRPmoXVxbxqIUxRzo4dr7EL92fSvOh3+HZaGJfv6dVLs1PgNZz8TqiRAMW7jXrppfiZPi1BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734068829; c=relaxed/simple;
	bh=HwkMe9hq5hr2QRbPNXcqLtCxfZxrGOY1qad0lN7B90M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h1oXSl0jyEO2hh4DjkkNEQO1GpLDR5fwhFsMilXyjRHsHtNnMhNZvYpmIR78GSEI1YAYkj43Fm1ES9IVdO6FL5V7dhRfuzP0kqREZCbpST28N6b7OfT4PBfP0RjRbQnirxXS+fBd4lJsNPyo8bqpJ6cZEb3w+2ohSibY+Zyvm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6tG50JL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2165448243fso14748965ad.1;
        Thu, 12 Dec 2024 21:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734068827; x=1734673627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmVT0W96xTTbgIHaje9qHPh+sH+dkYFHuEVe3qXraIA=;
        b=l6tG50JLpSTdsDtWqfqvnzqzDF9HmSfga8IwvtVVfkGg6uszZJUPGDlvglSs/mRd7I
         3OznjyRkFbtWxcj7EKOsmxNWTKaAPggPZuAO6OLMOCLDIoBFSEAZefiEp3pz0FVt9TNK
         54SxAl28+xxATGwZ7o3Ti0Lf3abJ80/IESobOxfL9iyCw1zowOzp3ha8ZLMYyjA8KO1Q
         EzKIupYhIaK70BF8oQMFm5KKCP1ftQzE6fBWPds/eDSTVqcSx0almV3LBq06yuNyUkwI
         f72pMrw1wTPLE9fEywnicopucedEXYphtHv+o8Uyu5m5lFDRHTeeAk0m85KreBiJNj9d
         +C9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734068827; x=1734673627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmVT0W96xTTbgIHaje9qHPh+sH+dkYFHuEVe3qXraIA=;
        b=qVhRv20IapUVSoME52dsb8k9FhDpp8IjTPSM98nGNUXVYC7L/XOfLwU//MQq3WDXTo
         Zqxwwqasqn4opXTLHNmNChO3O+mXDkSKRhaZ8KNT5OJSW/jQ2gnMLb9iEHXLFklH1azB
         K3FEywUnur8LO/SEnTpPQWahNM0JliHfB0UK/0HIckl2QoMPywVM1LS8ThbhDUvnU3/n
         6Xq7KoSIkDr+qhS0Y/zX8XTbQOMxhW2C1+iTYGWpNHROZxdzew1fn/jbg83ofZ6D2HA8
         SYjUP0dDwqdR6O+2DGVkzZw4Rd6byTvB2zgebT441elQSqpoIJhj6D9z67omnuPbqlbv
         CPOA==
X-Forwarded-Encrypted: i=1; AJvYcCWA21OX5tCLdBNBmdXa8KqcJ2L96klyV96A5jUnuFvqLI37Dna3bk5HzN5iUxXafL4CTMT/1/G+9o3C/Wv31C4=@vger.kernel.org, AJvYcCXpeROyOZToNx5MtS53fb47GUTdIpuEEpfdPBaMnkKAH3bW9mT4tz2+bT0cRodPL9VYgH+KYTYmhCeJ39NQyj3izzuO35g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbR1OmDMoc79R8V0+9pctFOOG14JsLX7eoevQ3MOtWDXYWWb1E
	on15sJj/8EAbRkjpk6szOkr56kgk6b51PfyiCjMBs/JM+poWm1Xo
X-Gm-Gg: ASbGnctVd50g0jmJWxRK08fyazl5PZYozVT3v7E0X1iRiNRqSr4+AFV6nznY94gWA7v
	lqHCS7bRWsBUcl7TgOBxJRALQCkkr4S7sjlDXfStbDAzHBPVStGe2BYn5drNDlJHNLPKv2f31XB
	WVVLuIkUHPXjwLmLOES57XyvG1J+5Rl7xgENF0PDe5M/0BSO3CAs3+4lmW6uzPZNiE+2X42SPPQ
	uJVFZj4nN57+a4RVq3M2/hBTlL2mVYm99nBBfcJV6Wgi+CzUZNiqvHid9tb76VN4h5YOT1zzF9C
	3bjq9BQ=
X-Google-Smtp-Source: AGHT+IGGw/OV/ScatMLc+XWrd5qwOO8iHzpYdxpzWycga8KUsVtQ1P1ntSP55wYL5SQs/JpC5cq7/g==
X-Received: by 2002:a17:902:d484:b0:215:431f:268f with SMTP id d9443c01a7336-21892999536mr21105555ad.10.1734068827157;
        Thu, 12 Dec 2024 21:47:07 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216483dd292sm82564985ad.226.2024.12.12.21.47.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Dec 2024 21:47:06 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	x86@kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	ocfs2-devel@lists.linux.dev,
	Yafang Shao <laoar.shao@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 3/7] arch: Replace get_task_comm() with %pTN
Date: Fri, 13 Dec 2024 13:46:06 +0800
Message-Id: <20241213054610.55843-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20241213054610.55843-1-laoar.shao@gmail.com>
References: <20241213054610.55843-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since task->comm is guaranteed to be NUL-terminated, we can print it
directly without the need to copy it into a separate buffer. This
simplifies the code and avoids unnecessary operations.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/arc/kernel/unaligned.c | 9 ++++-----
 arch/x86/kernel/vm86_32.c   | 5 ++---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arc/kernel/unaligned.c b/arch/arc/kernel/unaligned.c
index d2f5ceaaed1b..fb8e995823e3 100644
--- a/arch/arc/kernel/unaligned.c
+++ b/arch/arc/kernel/unaligned.c
@@ -200,23 +200,22 @@ int misaligned_fixup(unsigned long address, struct pt_regs *regs,
 		     struct callee_regs *cregs)
 {
 	struct disasm_state state;
-	char buf[TASK_COMM_LEN];
 
 	/* handle user mode only and only if enabled by sysadmin */
 	if (!user_mode(regs) || !unaligned_enabled)
 		return 1;
 
 	if (no_unaligned_warning) {
-		pr_warn_once("%s(%d) made unaligned access which was emulated"
+		pr_warn_once("%pTN(%d) made unaligned access which was emulated"
 			     " by kernel assist\n. This can degrade application"
 			     " performance significantly\n. To enable further"
 			     " logging of such instances, please \n"
 			     " echo 0 > /proc/sys/kernel/ignore-unaligned-usertrap\n",
-			     get_task_comm(buf, current), task_pid_nr(current));
+			     current, task_pid_nr(current));
 	} else {
 		/* Add rate limiting if it gets down to it */
-		pr_warn("%s(%d): unaligned access to/from 0x%lx by PC: 0x%lx\n",
-			get_task_comm(buf, current), task_pid_nr(current),
+		pr_warn("%pTN(%d): unaligned access to/from 0x%lx by PC: 0x%lx\n",
+			current, task_pid_nr(current),
 			address, regs->ret);
 
 	}
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index e9e803a4d44c..1f55d5c2628d 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -246,9 +246,8 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 
 	/* VM86_SCREEN_BITMAP had numerous bugs and appears to have no users. */
 	if (v.flags & VM86_SCREEN_BITMAP) {
-		char comm[TASK_COMM_LEN];
-
-		pr_info_once("vm86: '%s' uses VM86_SCREEN_BITMAP, which is no longer supported\n", get_task_comm(comm, current));
+		pr_info_once("vm86: '%pTN' uses VM86_SCREEN_BITMAP, which is no longer supported\n",
+			     current);
 		return -EINVAL;
 	}
 
-- 
2.43.5


