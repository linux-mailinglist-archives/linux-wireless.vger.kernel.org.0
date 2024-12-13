Return-Path: <linux-wireless+bounces-16347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE8D9F0455
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 06:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9937B18833DD
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 05:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8176C18BC06;
	Fri, 13 Dec 2024 05:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6hthnqi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A1418BBBB;
	Fri, 13 Dec 2024 05:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734068822; cv=none; b=UHaXOP/cYeQvPd0/c/M7ZK1q6KL3UgjI57RmveDskbUeJL4ZEu5VwNfmMuN9WLr3NAS2GpEMqLh/+am5Fv/zidijrLm0OybB5zFUYhQ1FN3rqt7hFMmDRpxdaRolf4iQtaOsmFqtHTBajrCCpTLUkPS7019di6IMknlUxiMAf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734068822; c=relaxed/simple;
	bh=PCh1gNdVkWHp7L2j8aSJAn81J3xtchPE0tLiHOyl/eU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYutrjLRryUeFpzOqIrs78a+j9PwZkE9yc7iR0fR49ALzWkS1lr3NULPydjcKNNhLxBUFb5iBsKlAwbQlrU7DZoaX+28VdHbbLFwnIUuN4+0cD6IKFzc4wZhge1kLmiEe1mkIZolwvTDknfn3agoQjSwLlWKKkfZqedmD4uSuJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6hthnqi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21636268e43so18023665ad.2;
        Thu, 12 Dec 2024 21:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734068819; x=1734673619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVaAhWgLsrOIaawWt+Es3lyBYssP2HU9Cngct4cKfGw=;
        b=j6hthnqiW0uRrSBBNpeFstiL3xuM4Qgv8z1P0+XCJnuxbmI0zub5Nk9V+90fK9fPsv
         IFdjrL+jez+oZFWJbnvD5/ejRxwWOX0DrzoTz0PcS39N4oMF0bJwe+5j81dPnAoipgWA
         2IdIqPf8GzMBJDKd5V0S+m3NSqdUfyrp4gC8GF3Ns/32LixwTjAW/6c2Xrvw6rdkT7hY
         Gc1//OVVzGKtRAJiw4uNcRx+53NaqR6/URjdcjPwPWNTQb7KhlLwUHiWV9okPYQySHx+
         uI1TJAYVxQ11HcCkUgj1wy9FEdrazUghEUcZfJ3B9c9/d9SBWkbsYZZ2TS7yLblnRdGr
         KpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734068819; x=1734673619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVaAhWgLsrOIaawWt+Es3lyBYssP2HU9Cngct4cKfGw=;
        b=TJ07awjO7PPBHXT9quL+5D1JeFcsGzHv/99g25L6/prT//p7W2b6VHkG8kwZ/Gr6jJ
         xM4Nt2lgc6maCiHCjb5pM+2kjyvQTM52k0e4pIRvE795zdpAp12i7bhb8JNrXH1mJT+x
         wg+Zs2ohx13Z0v+KHaFlieRWppXEDIICKd2lvjuf+8enAKvNMgc8VvkJw6BfFg3ucvqK
         HB4V7RZmHJ4ziDTAQeq8BHfZiOKOji1BPwwxh1qwp4KNXyTj82SPAJtqliSc90YS1MS2
         vW1f08dEJVDJYwyuUpeIDmdEEn+3yZuvQBAHXmZzjaaBoUKI9Rnp5+rd4ZPu0ihjJmkd
         S/MA==
X-Forwarded-Encrypted: i=1; AJvYcCUet/wZsca1OzU40p1FEBjOyfdMFdXZFpI94hZ1wpb7DGK7uwSV7OrYdSY5w09W+LoJ1xjCc/6RjQwMl19iBYt4ZIvCbNE=@vger.kernel.org, AJvYcCXHCChkaFw9eHpdWsQtstlRAK4rc1tAQRt83PbJV08FjcaR3Bi6Ir92q0RMlundzGPedAHO8F5KXq+PkGSNdGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEzr23w6qrGNFpLbmsEys9S0jSQ9no9/2Hkjlttv9q+Zm/cdPW
	408oiO0wVc8jepzoGVQQvEVKy54A9QWQ6+Y71ZJ4l6a0aZnjhRsO
X-Gm-Gg: ASbGncvKincPcacOFRsNIzGaRMbfLbPoS6GB9x/CherAYsbBnZWQqvq2s8b54C1eMXs
	CPGDxyG52x71qkqwQjbtsTOmjEzZn6pu+DCNzVgcDEhcA4MnNKSl9bfWbB3e0HS3xl/VtwkLnnK
	m6WznM8g9EP1a32h/YQ7cnSSPr9i4l4UtA67225qWk2Q/z6DuPR4k6xwQkj6ev19zVwh5ez8GHf
	PVdHCwlWZKRzQ1FXZJMDl8GcL+tojh2PhBbsL+VVeULusiakTf+qyzi8buA+w/c/16SvNHcDAbg
	GpH0qWg=
X-Google-Smtp-Source: AGHT+IGnQMpyX4qO4c9TaUxIvkW9bvqpb4HtTDVE3C9gZFkXCVV6ksZB8lAWhFJzpiBj11HO1t8PNw==
X-Received: by 2002:a17:902:e88b:b0:212:615f:c1 with SMTP id d9443c01a7336-218929a19c2mr20599995ad.14.1734068819460;
        Thu, 12 Dec 2024 21:46:59 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216483dd292sm82564985ad.226.2024.12.12.21.46.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Dec 2024 21:46:58 -0800 (PST)
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
	Serge Hallyn <serge@hallyn.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 2/7] kernel: Replace get_task_comm() with %pTN
Date: Fri, 13 Dec 2024 13:46:05 +0800
Message-Id: <20241213054610.55843-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20241213054610.55843-1-laoar.shao@gmail.com>
References: <20241213054610.55843-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since task->comm is guaranteed to be NUL-terminated, we can print it
directly without the need to copye it into a separate buffer. This
simplifies the code and avoids unnecessary operations.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "André Almeida" <andrealmeid@igalia.com>
---
 kernel/capability.c     | 12 ++++--------
 kernel/futex/waitwake.c |  5 ++---
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/kernel/capability.c b/kernel/capability.c
index dac4df77e376..4512cd797f49 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -38,10 +38,8 @@ __setup("no_file_caps", file_caps_disable);
 
 static void warn_legacy_capability_use(void)
 {
-	char name[sizeof(current->comm)];
-
-	pr_info_once("warning: `%s' uses 32-bit capabilities (legacy support in use)\n",
-		     get_task_comm(name, current));
+	pr_info_once("warning: `%pTN' uses 32-bit capabilities (legacy support in use)\n",
+		     current);
 }
 
 /*
@@ -62,10 +60,8 @@ static void warn_legacy_capability_use(void)
 
 static void warn_deprecated_v2(void)
 {
-	char name[sizeof(current->comm)];
-
-	pr_info_once("warning: `%s' uses deprecated v2 capabilities in a way that may be insecure\n",
-		     get_task_comm(name, current));
+	pr_info_once("warning: `%pTN' uses deprecated v2 capabilities in a way that may be insecure\n",
+		     current);
 }
 
 /*
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 3a10375d9521..df8f8c85d776 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -210,13 +210,12 @@ static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
 
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28)) {
 		if (oparg < 0 || oparg > 31) {
-			char comm[sizeof(current->comm)];
 			/*
 			 * kill this print and return -EINVAL when userspace
 			 * is sane again
 			 */
-			pr_info_ratelimited("futex_wake_op: %s tries to shift op by %d; fix this program\n",
-					get_task_comm(comm, current), oparg);
+			pr_info_ratelimited("futex_wake_op: %pTN tries to shift op by %d; fix this program\n",
+					    current, oparg);
 			oparg &= 31;
 		}
 		oparg = 1 << oparg;
-- 
2.43.5


