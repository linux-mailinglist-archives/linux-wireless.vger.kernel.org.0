Return-Path: <linux-wireless+bounces-16570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164A09F72AF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 03:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC65169933
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 02:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979A11487C8;
	Thu, 19 Dec 2024 02:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtfE3ODB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3C35960;
	Thu, 19 Dec 2024 02:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734575713; cv=none; b=P9yasWt+rrFmYCfCaAsbhf7fxBMmhtkzgZPgyET+QWI2jUQasGHSCvft81W4sVBSigJiv1Q4o5G//pMfFYhc0AroXjkEZNBCBtyFH8RCurWRciSSVp+DMKNokRW0CN+BLbTlKFo7z+DIxQ4zi3CXflTAMiroyLx77tnsaU90d30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734575713; c=relaxed/simple;
	bh=fjvo4dYkUreQMMEsg3L8KRAKXKBd4yx0ng+KH/F5vq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uhz5PMSOzmyyUwJit7Ip8pmZ/dGyrowAgz02zk9gYsu3zM8gd4JxVUku9qfB2iQ2osOYrYM7wFfufVu6CimgmSNlLToH2aiQKN1sudlwpVKKa01Rl8286dVCtg9uBRDGUzEtn0VTIbn46gpshIKS2maxoaKVODy7qr8er+U74k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtfE3ODB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728e1799d95so387803b3a.2;
        Wed, 18 Dec 2024 18:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734575711; x=1735180511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFcOX4O91tQFD6muydW9g9dtgYf4vZjGzF6jEGHBeGo=;
        b=PtfE3ODBCLFYmX/zn4C8k29GTQcB/j5+bdgyrajaZtlHrFu84fpY/6X3TzSaUgzFqy
         olra9hev3FHVGxd+7nZXDcRyj/KzzaeZHS0fxC7aa6xD4jxcU2K6e4thieZJaU4z05iI
         9LFfEeoAceRFMkSoaP0Yai/10HXIHa/PjM1J2a1cKKJoyBUBnRuKYhwIhiFB1ZeqR6Oe
         I4bsdPADpFFKHIhVsFzwem/h9/9Q1BQtaOHW35nBhZQYahtKoOesJLC6LLtIbxIUnHUz
         9uk/xaHOhmrueSa+zAoaCsrjr5plNtKnmLP7B+/Khc8BNvs3+w5w6r9BvNO6Arfsx35x
         kkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734575711; x=1735180511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFcOX4O91tQFD6muydW9g9dtgYf4vZjGzF6jEGHBeGo=;
        b=XRy2FjzIfEk4nvZyI3xrVuWjVX/xndZoR00tK9ICDysca9KLqUSjRn3vu26oWFfbe+
         eMgkE1UTVlFcTNunB7zTyYa9tGYznsz5a4a6epeIcreolc25WFsMvaAiIXRCJtPsvK8J
         Y7acSMCaeF2WIBWBMtK3ydyh7gBlBOhcBsYB7U9JTzaOZkH358ZC30QtCFpbmXOBj29v
         QH/xUwShd1cw53BfosBlllo385lWv4dKDNHSTzJVvOUZ6W5a58I5NF3FxZnkPDmSxCPA
         CG/gZ+e7xgqnhDTvz10NDdPazzgIm3AbX1dzUMLYPCLp2REsR8cVy2nqTBi7j4P+oY6Q
         aukg==
X-Forwarded-Encrypted: i=1; AJvYcCUMvQnAGddl/WVH4++x6DRGSg3XSqKgH11thKEFRmqLAtDjm9t/+PRVr3v/NYjykqs69wDB2CcwuCo36RY=@vger.kernel.org, AJvYcCVmMZb72x8Mk1+ZKDr2tc96gYfc2UCxJzkXzolOJdNRw9P0i1GDLcmV0yMzLLHG1ePx5pEBBTejtwBLPsqnN62l3eMLbt4S@vger.kernel.org, AJvYcCW12W+L1qmpgX3avhcIbc+O4Vrj4kAtC1hiJUsv5zCOVjAXwqgjfZ7mEchFPWj5PuXkrtE7KSFyTBOIfOA9iG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6fq2nMub5YkaL4T6+eloY5JO17ockS8j9Q+Y8D8L++pQmKc9T
	xp78ULdvptpk3erybUep6HvduQrxtFvYq7je3Q0KgPSmadA/9rMF
X-Gm-Gg: ASbGncta9bAy3JF/eoq96i4RNIQOx/4SWRVVJ6vEOAgwwNdlvVM4giAzaciKqs8uPaz
	9E96f0Y2q3bJttw/YNLoQNnhWeCIQ6H/2GYjB7ilRfZNi5dz+Tn+gCOEBgbqs9YcKp38N7WxpR9
	kgA+5K1heHsYLZdI8oRGQFTwiMGz1rr6PfjnGa3G19veUA6agTsoW7HeqBGxRVeoGXwq05bMqV+
	cc/X+xuug5+HKtuj+5RYSI0gulLD1ITe5/xY3DKdojVJ3OEZQqRLfcYUgma6+jF7MOTTtP9rf3u
	wEMvPWU=
X-Google-Smtp-Source: AGHT+IF8uDHPAeHRKoSWXDpZOfxN83+9I3jRkG5wW7qXuv+87XI+9vIxsP70Tcc6kEOf0TdmQfwRSg==
X-Received: by 2002:a05:6a20:c6c2:b0:1e1:ca25:8da3 with SMTP id adf61e73a8af0-1e5b4820f26mr9200947637.20.1734575711218;
        Wed, 18 Dec 2024 18:35:11 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b821da83sm142163a12.40.2024.12.18.18.35.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Dec 2024 18:35:10 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	pmladek@suse.com,
	kvalo@kernel.org,
	bp@alien8.de,
	andriy.shevchenko@linux.intel.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
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
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 2/5] arch: Remove get_task_comm() and print task comm directly
Date: Thu, 19 Dec 2024 10:34:49 +0800
Message-Id: <20241219023452.69907-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20241219023452.69907-1-laoar.shao@gmail.com>
References: <20241219023452.69907-1-laoar.shao@gmail.com>
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
 arch/arc/kernel/unaligned.c | 5 ++---
 arch/x86/kernel/vm86_32.c   | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arc/kernel/unaligned.c b/arch/arc/kernel/unaligned.c
index d2f5ceaaed1b..3b2d8b1bd271 100644
--- a/arch/arc/kernel/unaligned.c
+++ b/arch/arc/kernel/unaligned.c
@@ -200,7 +200,6 @@ int misaligned_fixup(unsigned long address, struct pt_regs *regs,
 		     struct callee_regs *cregs)
 {
 	struct disasm_state state;
-	char buf[TASK_COMM_LEN];
 
 	/* handle user mode only and only if enabled by sysadmin */
 	if (!user_mode(regs) || !unaligned_enabled)
@@ -212,11 +211,11 @@ int misaligned_fixup(unsigned long address, struct pt_regs *regs,
 			     " performance significantly\n. To enable further"
 			     " logging of such instances, please \n"
 			     " echo 0 > /proc/sys/kernel/ignore-unaligned-usertrap\n",
-			     get_task_comm(buf, current), task_pid_nr(current));
+			     current->comm, task_pid_nr(current));
 	} else {
 		/* Add rate limiting if it gets down to it */
 		pr_warn("%s(%d): unaligned access to/from 0x%lx by PC: 0x%lx\n",
-			get_task_comm(buf, current), task_pid_nr(current),
+			current->comm, task_pid_nr(current),
 			address, regs->ret);
 
 	}
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index e9e803a4d44c..e6cc84143f3e 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -246,9 +246,8 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 
 	/* VM86_SCREEN_BITMAP had numerous bugs and appears to have no users. */
 	if (v.flags & VM86_SCREEN_BITMAP) {
-		char comm[TASK_COMM_LEN];
-
-		pr_info_once("vm86: '%s' uses VM86_SCREEN_BITMAP, which is no longer supported\n", get_task_comm(comm, current));
+		pr_info_once("vm86: '%s' uses VM86_SCREEN_BITMAP, which is no longer supported\n",
+			     current->comm);
 		return -EINVAL;
 	}
 
-- 
2.43.5


