Return-Path: <linux-wireless+bounces-16572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D85769F72B5
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 03:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE37188BFA4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 02:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3A0190685;
	Thu, 19 Dec 2024 02:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQAYg0JK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186186328;
	Thu, 19 Dec 2024 02:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734575722; cv=none; b=OlNYlm3OKrhtM+wIwhpMfA3MwuG64nkNRuzbM1uQiWPe495TM1LA9aaNZ1PfhE0jhfmMYWc3Z9Tb/Ss452ZCz2Z33nvhDPwm2npNItgzQytx+39b9ah3IhTAusilXqpEdae0MqFRIlZx0RHNch0sGrs+ImdBPyc37kgLV75eLuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734575722; c=relaxed/simple;
	bh=uW6gREAjVtJ2OpRjMy/n/Vx7nbzOviJdyVpvyg6VGj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QoftRPDyod5EtycDT+MQ/98YLVdMzTxZun6BaN/KKbi1gTtePhuo4bdjOR/FCwvKvEGY6A+eivRB2auHwuZTdcRINIV0rAavkgC/HWvlkU54pcFfyUKHwL9AKV2uv/njlZ/k99EQP/O2VvHQiIbPvmOAmuCTzBN0l889DLHTel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQAYg0JK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7292a83264eso280665b3a.0;
        Wed, 18 Dec 2024 18:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734575720; x=1735180520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35FnTfH4WG+K4PY792luJMCXMpwCP4Hox12oxUuAxYU=;
        b=mQAYg0JKmLRdBr5/4QjBadhAuRHMwWvbEoS0m0hdxiUQSfMhUeCXIQz/XP/SDm53Ng
         8ZTSS07kKMFUiUcbc3o5L5PEl9uTW7vF+TWBat/+2C/VKaVbCDAmTjf2FALVI4eRnt8k
         mOul29gPoAkkg0PcYcF1ejYmhK0rOSj6oMKON9HTTrebw4mOYlax5FmgGh8+XaYhb0kJ
         KmV1E6Lg5ALR3G5fF9g6N/VKvcZKeV5caGItziYoS/7ntsaxRnmxVlVp+aq+UuAPDMhr
         eU5FfpQkRbuL5BOI3kI/XiapTdD6BPcRTob+rZ/qA0wALiBSLlveSkgzdz+Kwsd1vVVQ
         IK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734575720; x=1735180520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35FnTfH4WG+K4PY792luJMCXMpwCP4Hox12oxUuAxYU=;
        b=TDd1bY45qHi2XwCELq+soYWQBeI7NFLxKjExZv1CwAEaSp73fWP5gNrqBkqX/RKWJ9
         Tz6x9ticvyCQMeg1dirgmE0DkB716upMxPI+g3fyPU1XDOjTJFOJI2TdxP+FgiTxbfd6
         byIRSbgsntyhqDS0GkZlEoJwe0de62F/7jxjyDw2X3/Srac0Jld7luuuSuoG3z8C5jnL
         F0+30T6tfvnpr7x8Okl3aEgdmEZVn5JgBJi/V11bx+ypHAdd+RXitSuVIV70qAl+eeMq
         jAoKer7N0Z2sIQa7e4roI3vHImh5IKJ29tPfOuJMNuIepF+R7e+gYBeDVxsHbWY61Tnb
         QAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX44qiDMSSlJYZKAUvDOnO7cKC1fAlyr/vs33XupgqroBEtWMR9xPNVVB8dEMYCgSmzHPea3/T3GJPv2R4DaM=@vger.kernel.org, AJvYcCWKzu8Ourj9MRbKMxDvWvJn+psh4HU00VaCMZ2H0on30wO+OkuaJPYdg0RXDQejZ/c31Lbee2MkK5MdeyY=@vger.kernel.org, AJvYcCXxNEs+3GDcQjFKmgdCQs0t69i/oUjNewb1IM9gpcWJffNYFFwWAoJEhzccj2DEZLQuOVSjvshlXfxlKuK9p0RkppTDUA2F@vger.kernel.org
X-Gm-Message-State: AOJu0Yyykx27QYHcWuaDG/IeKS3QAKK9Xg6yQ72a/lTxbSp+7IOSIDOh
	xaIe5V8u2ukfMRIV73g2yY+wnJ+Qh8NmSSvPuWZVIvYiZX0Pn7KW
X-Gm-Gg: ASbGncu9eqymj31JBoc+8U1Cb22hm0EN7CzNGolSHRPVnJAlzy6Ni36Skg1A6+N9F4x
	PpMljKe/iw1T9rS7wJZNtKJ5XxX8xucfRiIePIgXRX4b5ESCKd/Oc0/pbds9X2vj6R85zsyhrxv
	caITcp466ashbEr3UcAwzBGPYXV60aFfIuTx7qH7k+RobB8F6abj2uMmKyOkI6XaSiBrzXpBDGl
	p8UiEoTBB3wI6fXHtwm4C1H+GNMTayGPLWtcoO9MN3JCmvAxCpClngz3bL3Q6xRSDV9SamtgeKR
	pM8BAJo=
X-Google-Smtp-Source: AGHT+IEYa8/cPCrPUtV+8BluujgYPFlXKrKcInk+YdaLokr+l/jazm3QEi9WUGXKVKTvc9yKVja0nA==
X-Received: by 2002:a05:6a00:9096:b0:725:e37d:cd35 with SMTP id d2e1a72fcca58-72a8d2c2269mr8262629b3a.18.1734575720422;
        Wed, 18 Dec 2024 18:35:20 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b821da83sm142163a12.40.2024.12.18.18.35.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Dec 2024 18:35:20 -0800 (PST)
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
	Paul Moore <paul@paul-moore.com>,
	Kees Cook <kees@kernel.org>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH v2 4/5] security: Remove get_task_comm() and print task comm directly
Date: Thu, 19 Dec 2024 10:34:51 +0800
Message-Id: <20241219023452.69907-5-laoar.shao@gmail.com>
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
Reviewed-by: Paul Moore <paul@paul-moore.com>
Acked-by: Kees Cook <kees@kernel.org>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
 security/yama/yama_lsm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index e1a5e13ea269..1a2d02fee09b 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -76,7 +76,6 @@ static void report_access(const char *access, struct task_struct *target,
 				struct task_struct *agent)
 {
 	struct access_report_info *info;
-	char agent_comm[sizeof(agent->comm)];
 
 	assert_spin_locked(&target->alloc_lock); /* for target->comm */
 
@@ -86,8 +85,7 @@ static void report_access(const char *access, struct task_struct *target,
 		 */
 		pr_notice_ratelimited(
 		    "ptrace %s of \"%s\"[%d] was attempted by \"%s\"[%d]\n",
-		    access, target->comm, target->pid,
-		    get_task_comm(agent_comm, agent), agent->pid);
+		    access, target->comm, target->pid, agent->comm, agent->pid);
 		return;
 	}
 
-- 
2.43.5


