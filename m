Return-Path: <linux-wireless+bounces-35799-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBEQHPuM92mIiwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35799-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 19:59:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 622EA4B6E25
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 19:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DC4E30015BE
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2026 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC10F39A046;
	Sun,  3 May 2026 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DntaQs3+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2C30C601
	for <linux-wireless@vger.kernel.org>; Sun,  3 May 2026 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777831155; cv=none; b=GRMcbSMBF3PDwWTrhVOoyTWyMknDwA6R3UL8rd0rJsQLhVOt/xD0UL2LDvmRPL83Wfkynsl/rC7QEfbAGeaWbAZL5UITEsCGAjFqE92GmD8C6yRoyeOACyy0BWDx0rxag7s9KTBrvUDeNO2mFTfb4fCbVyc6bQKGiEVSA+od1Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777831155; c=relaxed/simple;
	bh=55hS+nkbs8cNwB/CscFBNjnUKq11eBxzc5WKp6ErFmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uTo4oIzl0PAU/bUbt9oGkmuFbDjp4Uw5Bwv5FsVoVAvQnhiqKQVJUOCuVTQUlcLflMNfJgdx3kDZv0U/8m0tvDeLr85H1sngjQEOQdPHcdvz6pD080PRj/F5zIKqKjMup/TQzHMh9N1982ilDtJ5BtoL3LbfxpfMRUrRaJogZ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DntaQs3+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48371104ffdso4117345e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 03 May 2026 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777831153; x=1778435953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FzylD/T8jSqe6CUhpsMK3i3vWHnrfWhou+rGEeiWrTI=;
        b=DntaQs3+RNNx/rvq5/XlExTsdTo+SopvJJm9pQ8ecKiiaX9IQka1Fj4Zia+AlFt6jG
         YQ9CH//fWG695QxdwcG9Qn50XrPCXv4k0VVRgF6XVIQQK5KdqMvossvmqvumc4F24g7q
         ZE8IPOPfeisEi5yInWRkd9/Q1SrwWqLzeoRmHhEbVkYwkI5ry8BZKfkGhnExXdB3tD1r
         q5Hga5W4K0tGSP8BBXFWVW8moI/15ocZUnQgL/9vE88UMYY5VNbXwf0v/JE4eetaUef3
         YYEso4iYpSTwX2h0Ihks8b39coJ7ZggxTcEWP2hRTrQYyFmAgho55nhYV23LWAi50lCV
         iG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777831153; x=1778435953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzylD/T8jSqe6CUhpsMK3i3vWHnrfWhou+rGEeiWrTI=;
        b=kMEcQ2ncEbkxrc3M6QwC949uXYET3VKJdqQsdaBSHhI2/qzOu6MHneHXmtEib14b04
         4wFn4h5wOw8N6818c4LWumLiaBjnWHjf2DYjylKMtqI724XTMdsMfiGHKQtXbloOkGXc
         a3+W4dNpvmQdZTetmlnlKWGhZcRd4QMpByyEJQQriJ9ZwOVQI6M3GJ0WLD5ZZV9sdTwu
         wN+eYeMND5iVx2ybWJPmF3ikJWAoK1zilcNs51iazhK+NpKXQLTDYGp4nMelhBlzGWnR
         8puOjRr1Pp0cdC5q0hAfwIujfbIQsXPPIR9yglBg+bnJSKFvpafh1lgwYz+Gkk+pH/Mb
         xVfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+cAptlg9Qq9WUrzd8EKtmIGXbDLBTqrr6o7/QkNKd3Mzw5wKEpXzdaKpxryC3sJ+aK0P6mp+PfWM/CbQXVvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYX4iJxgwcYcOeP2jYXkPh1xClvBYFeW9GWHdFLA1oI5Lrzedm
	Th8ld7UcHvd8g+EbdGOYmab9ZVaD2HQDk9bk0+F38Q4fztrcNb/cXANF
X-Gm-Gg: AeBDietCGpdbbnidbX+eisHXdiSuaarIMreZLy2E1evN2VVn1a5fS5sK+e6NzQaLjrl
	L0zHGquzQ7fsP6XjjMmILtR2hwEXCGdnBEhghAUfCsuOvHjBSwD7ZaBH4Y/5AELO/AiEtGPayZ8
	/hCM7P6kvgNxfuE1/E3j/WgYXzLKKyO4INPwWLMPCFnZ+0UPgFiWeS1+++hbqWxH6JcGXQCEsIX
	UU1ObVozPP+tv26kA7j0nl8yYUEDSeabKLP6QqWwFRc+XS6oKBiepxJiinOwOJ4a3pmuEdqXtiG
	VhVhEaQj6THln3+HKmOEMKDWyzfDd1gCUlOCnHNeaucqdKIrHUPSisHeKgvTGSKdhC/3bKXaba3
	h0Kq4eburVIxdfuq9ccn0Dghz7vil4Y3JExjvU5gLH0f9xyLl0OOMESBi04ZDPTwnNaVb8j2mhA
	PBSUkmoOFu+tGKqC17CLOOCIBAE8bnTAoHTINxGXdW/LooJVSXDUHd5zo=
X-Received: by 2002:a05:600c:1d21:b0:48a:5758:7999 with SMTP id 5b1f17b1804b1-48a9865e099mr52070525e9.4.1777831152797;
        Sun, 03 May 2026 10:59:12 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48af0d5a613sm63660635e9.2.2026.05.03.10.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 10:59:12 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: loic.poulain@oss.qualcomm.com
Cc: wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: [PATCH] wifi: wcn36xx: fix spelling mistakes in dxe header comment
Date: Sun,  3 May 2026 21:58:32 +0500
Message-Id: <20260503165832.1675-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 622EA4B6E25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-35799-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sozdayvek@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Fix three spelling mistakes in the DMA Transfer Engine (DXE)
description comment at the top of dxe.c.

No functional change.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index 5a0ef2295..44020ec26 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -16,8 +16,8 @@
 
 /* DXE - DMA transfer engine
  * we have 2 channels(High prio and Low prio) for TX and 2 channels for RX.
- * through low channels data packets are transfered
- * through high channels managment packets are transfered
+ * through low channels data packets are transferred
+ * through high channels management packets are transferred
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
2.33.0.windows.2


