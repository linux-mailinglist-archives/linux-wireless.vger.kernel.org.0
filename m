Return-Path: <linux-wireless+bounces-16350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD69F9F0461
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 06:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1A9283EE0
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 05:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9A218BC3B;
	Fri, 13 Dec 2024 05:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPKrle0X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9F18B492;
	Fri, 13 Dec 2024 05:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734068843; cv=none; b=PZC7yyX56gu3505qh4GHXPfWBfFze2+iVY3vemJ4lo7NdMSMuhRvUQ2sjcCuvdbH76EblaaQm901GfX9HRoLD58nIh1EVyZGa6bcU7K5pBLFJj3mIwNOAd3urpQ+vaZTUU75Rv7wsamarxBuDFeRL8hEL4lFjqM4MfNZC9OdPhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734068843; c=relaxed/simple;
	bh=HBeo4xWE6l5jixWcMRrsf7eVi0MSPm7+QXC8ECpQ+bA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TgZb/Xm8f3e0phMWn2evwx8BNWD3pgyoUiiYkSyQ+B4/P4D6m4DePw9IfyWRWNX3l314TiUkAZI87Lae5NN8CBw/fK617adhyH4oUoUqmdM9UM5GCAofP07MpBVXPUysHE+gIcR1p17ziW0/uQSkJdwZoLxSBHZTXzAe3ax5j6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPKrle0X; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2167141dfa1so12331955ad.1;
        Thu, 12 Dec 2024 21:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734068840; x=1734673640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQpRmGydqcdMOxZRzmLm98GnY2wtgMQ5ZotZeI2M2YQ=;
        b=TPKrle0XnYRDJSGGcZknbiE/AKtJt75+Yi14xorxMcXOLe8POzFqq1y4I3DV9POl3H
         daPSCgmdFAXQZfCJl6aAB9p2rd3wnueGfBAuEjqvsPJSJIfvoGZdnTWOgPnhYFbMGk/F
         npLilZNtlJ1tbpMRwy0pGjvgonn0TX/BIN6g+tP1EahqZVLyRVYAXUIRL3/Ey8gCbcGq
         AmToQoKnrAazxnf0cNlPXMhVbm8SQGpBaMiQaf7NhuEPlA8L7MEM0J87VQB5OdQVc+y0
         Xtd5g+3lTErBI2NuhWpP7eqiLNRdAAbJB8oyZI20RKHDWkDPzjgxy3IuShXKgbexjlcW
         9iQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734068840; x=1734673640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQpRmGydqcdMOxZRzmLm98GnY2wtgMQ5ZotZeI2M2YQ=;
        b=B/gbXtRl1cnwB2ZZrV+Rzr0eibEMxOPs75o3F6Au76D77nhSi3i9Nrp8fkwsVRoNeN
         sUeOHM/utk6jnA5cvurgv+hi/ARNjq1yAkaBXmC8rG2m34fZGTOPzK5r4ERrEu3gxeBJ
         WQ8NFtaaPrmPt4w+lKFqQikzpKTHm3KkvJUeMKDHtaf/TbMzjesfiqU5lFd9bQb8GxsW
         UKwtQF6ujNBhvLG25PFvnIFXyPZrELV6RV+XhaeF5BOC1UTYUaSIfV+hF24KChaBWmDo
         6AbahrhxGB0aYgYk7RcW7zJID8PByC15NQ+q93QU9nSb3dPMtnIQHRRZRDpYreTMSMOD
         kFxg==
X-Forwarded-Encrypted: i=1; AJvYcCVpk/FQ7vFwKHy+faWqSCqeS71X+FXFstBA5Nh9TsGpe/9dEohER1e4CDYQdaWHMeMnRolAevgS4q8dwIUrbFXD9AGXunI=@vger.kernel.org, AJvYcCXX9IbrgjpgcihmekaV6GGoNwzD32a3tjRx9qieb4OTDeh8ENpYPhxows+hqWqXargbemjjfw8XCubup34DgQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtQ/mOTBVDLbUIwdNxQK7C6fIDDh5YcR3B2Bf/9Y3utjxszfwt
	PawFGq0GlkU8WHoYEDiUb3TEcmt+rVcpWzvS6RThrRoBgNsWcKgL
X-Gm-Gg: ASbGnctibRhs9Zo/SRgwFTb8jDqzmyp6Vb+aWdp++uzQ/Bu8NIhXCKD8giqNaYuNH7W
	8uHGe19uA8rMo4VKjKhPjE7QRf7oFZl/HiENZU7nNFx5W0eFPbtOUIaZysiVh/4wVwGu5+SOUZb
	Ppv0tCSC1uGzqAWDIS3F9kEbgKvkUwuWMbcEQIpxHS0dG7XaXNi7nPSPttza1nnTcsVbsH3sYJ6
	7y7LoUaSLpvgtM3cQOHzaL3AlO3r96DzZOGN5RObFaTzWWBO/NW9rQ3hV8ISvU3aM5A6lvabRSr
	CLvBEGY=
X-Google-Smtp-Source: AGHT+IGy5lWO5x7q/SCrL+dH9NQnv1Rp0u2NkmqEtY14rjHQEczQdhUClmCmrxdf9miFcIspK1e1uA==
X-Received: by 2002:a17:902:d506:b0:215:9c06:272a with SMTP id d9443c01a7336-2178c872102mr82765085ad.24.1734068840305;
        Thu, 12 Dec 2024 21:47:20 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216483dd292sm82564985ad.226.2024.12.12.21.47.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Dec 2024 21:47:19 -0800 (PST)
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
	Kees Cook <kees@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH 5/7] security: Replace get_task_comm() with %pTN
Date: Fri, 13 Dec 2024 13:46:08 +0800
Message-Id: <20241213054610.55843-6-laoar.shao@gmail.com>
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
Cc: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
 security/yama/yama_lsm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index e1a5e13ea269..4bdfa51ea6fd 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -76,7 +76,6 @@ static void report_access(const char *access, struct task_struct *target,
 				struct task_struct *agent)
 {
 	struct access_report_info *info;
-	char agent_comm[sizeof(agent->comm)];
 
 	assert_spin_locked(&target->alloc_lock); /* for target->comm */
 
@@ -85,9 +84,8 @@ static void report_access(const char *access, struct task_struct *target,
 		 * Imagine angry ranting about procfs here.
 		 */
 		pr_notice_ratelimited(
-		    "ptrace %s of \"%s\"[%d] was attempted by \"%s\"[%d]\n",
-		    access, target->comm, target->pid,
-		    get_task_comm(agent_comm, agent), agent->pid);
+		    "ptrace %s of \"%pTN\"[%d] was attempted by \"%pTN\"[%d]\n",
+		    access, target, target->pid, agent, agent->pid);
 		return;
 	}
 
-- 
2.43.5


