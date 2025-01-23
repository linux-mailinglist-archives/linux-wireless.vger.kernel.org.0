Return-Path: <linux-wireless+bounces-17855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AC5A19FF7
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 09:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF0A16795A
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 08:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5CB20B804;
	Thu, 23 Jan 2025 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0qg/WX2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829C520B80A;
	Thu, 23 Jan 2025 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621361; cv=none; b=OHmd3Hr9d11BYCqPqOTZldN7GzXpS7fpR4BJrGya5CaTUZICBN5uhGdaJNFRDQ2pA6Eq60VAt3oN+32ZzLou4NEQueiBeFDVWJyUQFqPQ44Vdjvp3ub8uwGWoqUMTPRhuy69ruAuaSFzgxBvbF/uluqFm+GVSk/ncuoseLBBXGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621361; c=relaxed/simple;
	bh=9d0NMu8Vr9pmkDsrgxwczUM/xGPN56RXc7d3r26kf7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSUvAR6aK4zpxQaKlRfvtYxSeeL9Q6UHZdM0+VnkA2Jm+A8mywhnfRatJvAAv6PZczXxT9vkE7MaPGFJ2eUWmwZNxRZHM+sau9jb9DU+4zaBk/dL6+Vj3C8Ei61PEsKv2JnD4PfPkVPdJqEf0zRaBttXVR5nbRwouD2IC8SDkNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0qg/WX2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2166651f752so12330905ad.3;
        Thu, 23 Jan 2025 00:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737621359; x=1738226159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nRuUrZ+X/fNLuM+96mPvasp0f1sEW4x60a4HaBMx6cw=;
        b=e0qg/WX2unK6eBl8n/UTS2n+cyfazYd5zPTNXCXn5kw3OdKZ1WOxxJsWTwH1kx4OEz
         i6gpbZ0B/uLYyd5EKJHNk9H+0yTxExUH0HoGEtF5bfkaWPy4djprcV42ltCqO7VOX8y9
         qIq6J+XSknJwabKyPa+/A2SBGRGVrKxBjBq9pgfJMTq0+ge4SjysoLw/Pqt9Ar5brXPp
         NRfkXRX73m5lDEn0bxQZkrz28KZjrmeU/FjLQpD6cpuToD/PIaVaYl0gqg+cPrvnUICH
         DajISJIzUx8+2vygfg88179NqM/nZ1D6nmUwbF4AUlxepFVqFNEosFaBSNzDdrR6wYHi
         sftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737621359; x=1738226159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRuUrZ+X/fNLuM+96mPvasp0f1sEW4x60a4HaBMx6cw=;
        b=Cf0UArz2gdIdRE7BJhm/+7YWLS51XEM51jgvLrAjR0nzNu7eJMQclEIIq78/WCqHH1
         KJ6nMaEYJVdxeIYJzOZ3/Zt9USS8xr4J0Vfyh7b+yeqsiyPqy4jmBNGCGEN4oqnT5MYT
         TNWFIUY6Q6nzh6n7OTDaK8sdxGcq3R34rGxQ4c2b//rWBVhd2jOu9E3RocBRlqDRwkpx
         TxPGl7sX3K3Jy7K+Oyyj1Gy4XSjrP89X/cEx03ydZSMViDs/1TRCJ2wLBZu2f+X/OfeM
         U8CeZPT8SUfAyUdUvHcUAG97H+RZMPB4AzNRqnPRQrj1g/wwdFEphqHt/+YAFx6XV/Pm
         udLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLTeC4qz+QG68UaAI3yqT8bUNba3wL9a2r0UT5EF99l1iK6eOgazuE6Sfad7Wlaxdpa1jvReXH3QbodCbB+Z8=@vger.kernel.org, AJvYcCXxazg0i0Ai44CnihVEtoBpFoqy0pDTgeLJp4hxDs1qMfoVCjp2sMhxk54SP5mwZJt2a+PzzSIw4XQ7iDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxopx9E15pc/kDkQ66ijHf6jmchjm6fSEN3z8djOQkXEfHXwH+d
	KJLlk9i15SJFUma4l6p3sDl5AutEdwddWs61uG/CT+inUuFSoxkQ8QhOIPXK
X-Gm-Gg: ASbGncurXwmsBzLM3CUXjQgRy/eK0qVJJg1fNiX3bcpLs6nkiTfwjlUGFWZ1e+hlzvQ
	4F6kelcavAEWXZAEwQIqiFqfoJMBKMM+y6sv/JwSSrNxENvo60L4KNAlioIAoTw5R4S9Ie8+N4x
	zCnQMooBO0qQbJ262figjzJabXJFmLa4XWaSczwUbH067TFchZdpOOvQrRrPPQHVUAErFQi4YUv
	tSgaDyOWA7l5SP3VPkWW80UHDhIyh8B+C9Li12d+1i1dTDIjeWEk9r8G9HrPgznwpH+NT967RdR
	ehY3R/SKOGqDVUTFpLWsw4rAuh4TU5DjQF+Mt1Dq
X-Google-Smtp-Source: AGHT+IHzBtes2/AcX/XzEEZhXMZD72Znl2Pf8eP22awI9v2aL/irqO6yWyjhrrziyaCoEGxFd235oA==
X-Received: by 2002:a05:6a00:369a:b0:726:f7c9:7b28 with SMTP id d2e1a72fcca58-72daf9bec24mr41966633b3a.8.1737621358930;
        Thu, 23 Jan 2025 00:35:58 -0800 (PST)
Received: from jren-d3.localdomain ([221.222.62.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab817385sm12982587b3a.68.2025.01.23.00.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 00:35:58 -0800 (PST)
From: Imkanmod Khan <imkanmodkhan@gmail.com>
To: stable@vger.kernel.org
Cc: patches@lists.linux.dev,
	kvalo@kernel.org,
	rand.sec96@gmail.com,
	m@bues.ch,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Imkanmod Khan <imkanmodkhan@gmail.com>
Subject: [PATCH 6.1.y] ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
Date: Thu, 23 Jan 2025 16:35:51 +0800
Message-ID: <20250123083551.3400-1-imkanmodkhan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rand Deeb <rand.sec96@gmail.com>

[ Upstream commit 789c17185fb0f39560496c2beab9b57ce1d0cbe7 ]

The ssb_device_uevent() function first attempts to convert the 'dev' pointer
to 'struct ssb_device *'. However, it mistakenly dereferences 'dev' before
performing the NULL check, potentially leading to a NULL pointer
dereference if 'dev' is NULL.

To fix this issue, move the NULL check before dereferencing the 'dev' pointer,
ensuring that the pointer is valid before attempting to use it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240306123028.164155-1-rand.sec96@gmail.com
Signed-off-by: Imkanmod Khan <imkanmodkhan@gmail.com>
---
 drivers/ssb/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index d52e91258e98..aae50a5dfb57 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -341,11 +341,13 @@ static int ssb_bus_match(struct device *dev, struct device_driver *drv)
 
 static int ssb_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-	struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
+	struct ssb_device *ssb_dev;
 
 	if (!dev)
 		return -ENODEV;
 
+	ssb_dev = dev_to_ssb_dev(dev);
+
 	return add_uevent_var(env,
 			     "MODALIAS=ssb:v%04Xid%04Xrev%02X",
 			     ssb_dev->id.vendor, ssb_dev->id.coreid,
-- 
2.25.1


