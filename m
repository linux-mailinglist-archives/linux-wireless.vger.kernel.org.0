Return-Path: <linux-wireless+bounces-16569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B6F9F72A8
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 03:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6996C169657
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 02:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B03886353;
	Thu, 19 Dec 2024 02:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfGqnsXh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A586350;
	Thu, 19 Dec 2024 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734575708; cv=none; b=mYpgrb/yveAwRdbMppWqc9vgGAlwzJBl0oeaE2mnX5Sn9GO/psOgfLMDT7eY+HdPSDi5Z8X22Fh841Fmo/dv72b1hS/EuDcUVf8odw76Dx+dPnQV/fK8N4RRFfcbrgOpd4yB9sVPNVe1Ff3kYG8q5TBiaD052XFC2NAM23ZEY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734575708; c=relaxed/simple;
	bh=yqzB/UQ5CgxwEer/KAHpFdkzi3xdVyXYQPOSmuyPZ6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7NuJA2rmFEgYMCanSqtwr0dwKdtCF/azhwM9F9zs/Vi6ZuNDBHRo6eJleZN/w675Yx3Txdzb2MgyH/RyhsVr2HFKZjcUlLq5MpTTlG6Z5PUrnLd9XEFA/AwoVsCncBUVOS2SjhC9t76tAvGFFIm3uueb+jwPgkBV5JgJnzjaXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfGqnsXh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-216395e151bso2164075ad.0;
        Wed, 18 Dec 2024 18:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734575706; x=1735180506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yZ75uwrgzXS/KAS9XiI4pfcH/Aa7U+Upt9QqSiD0i8=;
        b=CfGqnsXhJXA+m46v5RqUJAHNBloPxDHb57g8h4MKsyAeQu/vjT5mETOXizMHM51iWI
         Kwfbl4YSqMFOIyFR0Ix3Dkiq/ubZjSFsx5qAWBb+1I6H1dfX/zVglMZL+jtY8zO3Y2VI
         DfF/uZzUkdDscLZnLOmXXEKBBAOIMIK9vXUi27lhcKJcq1mZNfWh5Hho8DxnZ3WNUGRz
         ZcW01P6f92JdYvzBQskAYiQYQNJkMA2zQDNLEUJ+v95cqCl7mqnZn7fO0tvz9OHvmfcI
         R9qt4+/tO13z9zZw68Fh0ppidLoWOoPJn5DjPJ7VWOfPY+oxhdxO7d3L/hEj2K8FPTOb
         ZIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734575706; x=1735180506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yZ75uwrgzXS/KAS9XiI4pfcH/Aa7U+Upt9QqSiD0i8=;
        b=UZcVBN8vm7/BEW+Fx1j0eWIq30ILX5xhzdjZRpWyWaMnD3f4KTzpk+husRZ9Yg6df1
         3WG8eZwt5PbAHDMBqgq4Als9i1b9TehEvzW4YppgSC1yxVAXrLofrVkFJxqOj7WxfvQu
         Xr74EN+7G/KRXgaUshItRqqpm+vjORM6SHTM3q/v8TOtWm1N3V/f0b18Q1rKsCHywoPM
         EavoFjvy2Oc+KsRGuhPq5pTi9VqI4X02wEZleaX2WwRcfQtuMZxSj+yxanag2IeG8Bvj
         b5FW+VpVUPpG14H45iJBDtv/RWduMOPA6ODVrmWs2C+CG9ome+ONTlh8P1L/wKWEp9sl
         KP0g==
X-Forwarded-Encrypted: i=1; AJvYcCWGWeBjyQxiFvkm6H+vbnwzUDHt7a2//4yhgKIb3f02URzk0JiMnG+/A6KEaKHv/iZtIJji7ay/L7XmgoPov9w3VidEVtuv@vger.kernel.org, AJvYcCWKqMMy94bB/Kr/Nu+YIZ1Li8GhRUvRGkbO7j8lTUTAX9CZo+vhXrE05lkM1MQx1khi0B2ESpIMFuwlzoc=@vger.kernel.org, AJvYcCXwsibwNIP0aU9Wew5jgG4rB2QgVBEDqlE6QWFjFsbdofXyWV/kW/z3lIHhq4inBIUTP6vjg3WnhQf6SMJoVTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpVxMjhV7EC0n1/uTjYBpCRXz+9YJ1TTnSssbpIUBABuBllOky
	4zHzW/eiwbsNT69opaH6iGznqJJjqtHfbYQe/z6sncyRqMt2N/mX
X-Gm-Gg: ASbGnctTa9orhxfAjs/XfpzBVUter3LZKBqsvhoLNg4N2j7rCheRgzIHN3NnhtFCr8R
	e3ON1h3kfHTviso+Mdp1+63svKi6FTHGeAb+JDZCuMlptmLeEpwQqzbNL8k7Pmmyy6IMVOY7BpD
	UfMDB6KVqgEuw9g6V3JPsjP7Y6v32CHnNJ8X9aoWiXZWx/z0JzbFRLnDbipE0jy+yijYkVaWsMm
	XQCZPTdRf0VVioRZEwyM6p/9x8wHkjKwTMlF1kWeQ/6ya4y4G+mHeClgv9pFee6J0kWBhUhYTX7
	l6+MUKU=
X-Google-Smtp-Source: AGHT+IHDUXmWYVlYvXYhHIsD36N49JfOorXAToNFZUciCwG5nEYfG9fZ9g2sYrKUGUIeEzsd5pUGJQ==
X-Received: by 2002:a17:902:f689:b0:215:2d2c:dd0c with SMTP id d9443c01a7336-219da5e3b97mr23433885ad.14.1734575706180;
        Wed, 18 Dec 2024 18:35:06 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b821da83sm142163a12.40.2024.12.18.18.35.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Dec 2024 18:35:05 -0800 (PST)
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
	Serge Hallyn <serge@hallyn.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 1/5] kernel: Remove get_task_comm() and print task comm directly
Date: Thu, 19 Dec 2024 10:34:48 +0800
Message-Id: <20241219023452.69907-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20241219023452.69907-1-laoar.shao@gmail.com>
References: <20241219023452.69907-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since task->comm is guaranteed to be NUL-terminated, we can print it
directly without the need to copy it into a separate buffer. This
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
 kernel/capability.c     | 8 ++------
 kernel/futex/waitwake.c | 3 +--
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/capability.c b/kernel/capability.c
index dac4df77e376..e089d2628c29 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -38,10 +38,8 @@ __setup("no_file_caps", file_caps_disable);
 
 static void warn_legacy_capability_use(void)
 {
-	char name[sizeof(current->comm)];
-
 	pr_info_once("warning: `%s' uses 32-bit capabilities (legacy support in use)\n",
-		     get_task_comm(name, current));
+		     current->comm);
 }
 
 /*
@@ -62,10 +60,8 @@ static void warn_legacy_capability_use(void)
 
 static void warn_deprecated_v2(void)
 {
-	char name[sizeof(current->comm)];
-
 	pr_info_once("warning: `%s' uses deprecated v2 capabilities in a way that may be insecure\n",
-		     get_task_comm(name, current));
+		     current->comm);
 }
 
 /*
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 3a10375d9521..eb86a7ade06a 100644
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
 			pr_info_ratelimited("futex_wake_op: %s tries to shift op by %d; fix this program\n",
-					get_task_comm(comm, current), oparg);
+					    current->comm, oparg);
 			oparg &= 31;
 		}
 		oparg = 1 << oparg;
-- 
2.43.5


