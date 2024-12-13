Return-Path: <linux-wireless+bounces-16352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2167D9F0468
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 06:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CF8168106
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 05:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F6D1898ED;
	Fri, 13 Dec 2024 05:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCbBD2l/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E736F30F;
	Fri, 13 Dec 2024 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734068970; cv=none; b=Yzn59xzhPPeYRolW14sMbwpoMTaX/NSvVWguUpOa4Rfg4iam65oCGycPL06Tcj8vSVrYI8KNcfA0Q5VNlh157OJPHaZZteeBXK9m/RdMIAm+WMMYfciSjNNb0cGcnpRDUpXe+eID2ejiUZfvmzlA11EJbfP1r8FZU7TJ6z+FVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734068970; c=relaxed/simple;
	bh=v+pMu9kg4VrTuiGatKb8KwXRW5PcoI6cotIuO17+lWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jPxpaKWuYAbP+SGnwRcJNaUeFBzXjnJ7cKXh01h2tumJu+Ht3PiVaBRUtjd+/pFbTmULyQ7GWte9OFy8YZNbljc3gcQA72ge+WOzssoY94da7r4JmitktEpoBYH/VOGY9EzrXjALuRFxrvkmTYWeLqyuA65llzggR2GGIfz9K64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCbBD2l/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728eccf836bso1246952b3a.1;
        Thu, 12 Dec 2024 21:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734068967; x=1734673767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m2jUPvsdlfQUhZsdbtI4Ke1sLD5+tvHbQzW9Gl1gyas=;
        b=ZCbBD2l/iDb6PloRpo6uwogSXrPVaRPybOnJpvUXAAqBE4iaxKmnBDaEoZQHBZEelq
         0D0iyl8IbBXki3HI8bf7SXXmbKAOHm+iws9cHNceUCY9mx18wdN0B/iK1EtBAgEmyFZn
         5MamgtFvy7tfPk5fKQ4/zTUOLPktjV8xo+B0D5mAFparK2iGyNGVob+i1vIWEEFSTstt
         XAyQMM+YxLVeG8psVABNEIWQjUQFYae8yQdOknEjPMCL+y6clEHWdtf6uQSmPbFrRJRT
         VliSDTFJixovDD7Y3L6q0OIiNfYSKEoJMuIKGgyoglFLuM6yQETn9b7mhORNIJQEPUT8
         JQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734068967; x=1734673767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2jUPvsdlfQUhZsdbtI4Ke1sLD5+tvHbQzW9Gl1gyas=;
        b=owTKe5vO3KzMyZZWMLQVfdRCl64A1Rn5PogPS8KWjV7smqUN0hL26mCIZlwCVXOED8
         C4jDv9/Zkf94QL98izvQb1iyrveV0yVnoQRyzuHFLw9bFC7Z0fU7ZSVZIIu5zkJf/Hnp
         UMXbCWzsH8cheAem0FkYOWissJ5F0HUfeduFDG8i58x4O59wyPY+Sy/A1zw/XHKtJ44f
         +iBCQd8l1Mvys9WDiq800iYbze5HZs1mTkQFHybkPnbT359fd/7curXMsMZb9OTOJ4N+
         4W+0jWEJjo+nt7BIvVP1RBl9sA4NL9FyL8elB5ZadBF9P509XpQt7W3xANx+EIsIkvjZ
         LVQA==
X-Forwarded-Encrypted: i=1; AJvYcCUd2zmuJ/dv12lELyIjSrePyEyx8ajHDZOJ2SSNKFvu2TXcKFmtm2FJtxhmKORhwRaZQD7WbfV5pPWLB0wJQCanM5Vvh24=@vger.kernel.org, AJvYcCVdLGVmBuJOknoQGa171CuanOXH/y81/CTALCDn4aMlDkLyN9qPc8SD1KVg68WeZhMwvFGxcE3kVLMyD/OjucU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqtOoVRqqtUd4enpDt6WO7rZDX7eq89UWM4JjwK3CQZSPkRAF7
	sjrSvMO22tgxgTK/1SovuA/DSjxYPJZe5VF6gx3SL2nB570k/gtemphsSltbolM=
X-Gm-Gg: ASbGncu/8ThEtqlfXKdqcz0JB9GLTllJpWjxNfaqmHjiRxE/C6GDOQfCkA2mzkmH911
	2z1rSXa4GbB8WumHFwhjsLa6bda+AZZ8vWicEoNMeOOl/5w858VQLFY18hWG0Tiwhin2iq/5bee
	jiRzW9b3zkOR9327lKByPDiyVI9Qkm2M8Q3YzdmvnxuVM7BDxWZ1F+JH8WHj5qZseBcF+oqoYmH
	M8mhDJCmertlcWAW6M/tW/o2l4XnhbkGcYZDSFskKQV/GdMahSL2XW9N/V9pHGL8hEUcmTjMwJx
	6n2k/Vw=
X-Google-Smtp-Source: AGHT+IGsjn2HsD9B470GSaZ7/WuS4a1ciiqbzWwWUR77XR0Zla03DKiQ+x82aV6yWtJ1LuxULtoYsw==
X-Received: by 2002:a05:6a00:b46:b0:71e:4786:98ee with SMTP id d2e1a72fcca58-7290c2702e3mr2257553b3a.21.1734068967116;
        Thu, 12 Dec 2024 21:49:27 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725ee10f928sm8166032b3a.32.2024.12.12.21.49.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Dec 2024 21:49:26 -0800 (PST)
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
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 7/7] fs: Use %pTN to print task name
Date: Fri, 13 Dec 2024 13:49:18 +0800
Message-Id: <20241213054918.56441-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
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
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ocfs2/cluster/netdebug.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/cluster/netdebug.c b/fs/ocfs2/cluster/netdebug.c
index bc27301eab6d..039d99f951ea 100644
--- a/fs/ocfs2/cluster/netdebug.c
+++ b/fs/ocfs2/cluster/netdebug.c
@@ -122,11 +122,10 @@ static int nst_seq_show(struct seq_file *seq, void *v)
 	send = ktime_to_us(ktime_sub(now, nst->st_send_time));
 	status = ktime_to_us(ktime_sub(now, nst->st_status_time));
 
-	/* get_task_comm isn't exported.  oh well. */
 	seq_printf(seq, "%p:\n"
 		   "  pid:          %lu\n"
 		   "  tgid:         %lu\n"
-		   "  process name: %s\n"
+		   "  process name: %pTN\n"
 		   "  node:         %u\n"
 		   "  sc:           %p\n"
 		   "  message id:   %d\n"
@@ -137,7 +136,7 @@ static int nst_seq_show(struct seq_file *seq, void *v)
 		   "  wait start:   %lld usecs ago\n",
 		   nst, (unsigned long)task_pid_nr(nst->st_task),
 		   (unsigned long)nst->st_task->tgid,
-		   nst->st_task->comm, nst->st_node,
+		   nst->st_task, nst->st_node,
 		   nst->st_sc, nst->st_id, nst->st_msg_type,
 		   nst->st_msg_key,
 		   (long long)sock,
-- 
2.43.5


