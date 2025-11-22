Return-Path: <linux-wireless+bounces-29251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D422CC7CC7A
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 11:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4874347402
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 10:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B72B2FB986;
	Sat, 22 Nov 2025 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqagyHbV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBF525F7B9
	for <linux-wireless@vger.kernel.org>; Sat, 22 Nov 2025 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763806728; cv=none; b=Pw1t9EFWvRmgMgQxDNAnuJZWCuqnlHigW/CMNCyoWo7qhp9pd8HpoxywosM+bpiw+ItY3xo3Sbu4igMoNmF4hpQ7+fvIe5KF8gNJR1D3+pdMgSCtPIX8gPXxTK50PfXQNF7xg8oXARk9QJMpTW2bR115Hsydf+uP9XEeazqsc1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763806728; c=relaxed/simple;
	bh=QbPZipajEq0/83jfjCQehmX2C4Z5zNxc8erPR/a/IGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmtQ7yNRw7LKw4CUXT5erj64trbU7xeUji+NmPtLnb+zlK8RddQvPfesDXSlmTB+Jh0TbWJw6yIYXy0VQOE+kDxZRz4p3bpune0cCOslnV6HTGXm9i5DfuMidK02RuRbmG/yXHxprdH3X7lqx3SsAT5ngtZZoIRexCmRKnOypiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqagyHbV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-299d40b0845so45319675ad.3
        for <linux-wireless@vger.kernel.org>; Sat, 22 Nov 2025 02:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763806726; x=1764411526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JxloJdhlr8dfIXQBTNyveaWRibzvvrHbjdiZXjpwUKc=;
        b=PqagyHbV+/x/3McYEuyPCjUwt/GV0rbOnLtB2ZtnsooWrfX8yuAFx+a8ovJq/IMMRS
         SpTaMA6OQGUiabGaiK/VjwXfy5axxeRxRCI4E1BCsovAAb75CxHZVm9zQtLX7FY4OLcE
         D5F1Nukjut9SkGh9oDofc97G9PtTcf3GX00ESZzQKzEr5TMpCoPIAL2IYRqHky7y480w
         kZCCX+oJGdi7ytsxRsurLZZTiX8na4eqzmTpVSIG7kp2Es5cdGgEfKlIqYpD2UJqdRT7
         sSBhl9M8/qwwfYEJ5hQwBU4t3N5sL/TT7D9wZg32IwymDSeRSyW1s8ksXX0u0QYhPuoI
         thrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763806726; x=1764411526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxloJdhlr8dfIXQBTNyveaWRibzvvrHbjdiZXjpwUKc=;
        b=p1hKSa/nPbxa3bBSQ2PAARIrziBoOnw6gxjNGCYE3HZVdkoFO5Yt9Vr+mlBF/4eksq
         HDhni1bvm+TimI4n3kFMGzYH1xV1h39Qos5sZa3xZwQyeiJAJzAYGHe7fIgb0VqMJ9xP
         rWQYc645DgPVxLOVgxt+Zstnv5fr3Epri32afx5P//Bthd6z0Ku4KTVvimYS/HVLxOLA
         ePhhkzWRQV5TJ4BdxwISGHpdVANFvxUvB14TaXfI4H5xLo5z/jXr3RSWyvrg69CFod7r
         5xr44QnG1V1pgJtw8EIiZk3zwH5OG22kS8mzNCoEIvSShMxHTBeZpZ2codQPdAe1T7Tz
         RGAQ==
X-Gm-Message-State: AOJu0YzGMXPFa9x5uQHzZhlxYMMbuZaJQDHMaEXIOHYi0/dJj7WIaM4K
	xf42/0vB4X4uCo/afgM5JydA/88BPjJrQuZMxwmZldIrV835f/YeR967n18PEMv2WTbb6Q==
X-Gm-Gg: ASbGncsPrhS7EmZEsnE8ZyWTAddW7aUygYHdjnyfXcK157qL7MQp9u0/hH6utomSAXX
	sVUDqiCq7U9aRfGpLL3DxPj12l5E6d2ldDyxdwu7fkn35joFfDHEZZ1Twetm++LdTlTA3Nlnrt3
	Ne55iT9Qc9oZjICeR1VUjQD9oUcqnVdliOChmU/4FtM8SmaZNNeseYHWY7M5rllsg4FM2MGi06d
	F2Qj9hDAx20ejLWZ/eH4W7qTkHIzk1o72kCQUMixc+fcY9CnNBffsRwHH2/jFpYWrJF1zrcLtaD
	pGpWoKvNevMDKL5AqgMh/rsrhCWpbSF2LmbP6wRVGN3c7yGy159EZHRVepZ2JU3GIHjahfZHCe8
	7gyfy4qfJuZT686/qc97+CAlmJv0+s/pFehu23PQlAAaARn4c9Zt4/KOADwxsDaV259GXCGVia/
	xCGle5mQWnAaAFvv4uosnJFqOh004Ngv+LSb1zqtHEDR4Hah3U3+SA
X-Google-Smtp-Source: AGHT+IFwOVdGYWyOpHsOWllKX4EoqbrB1mIHu5yxaEz/D2uKvl5IwjShtELdDEpiB5EL7ULnRFn2Dw==
X-Received: by 2002:a17:903:1a8e:b0:298:46a9:df1f with SMTP id d9443c01a7336-29b6be78429mr70693365ad.12.1763806725711;
        Sat, 22 Nov 2025 02:18:45 -0800 (PST)
Received: from bill-manjaro (27-247-129-21.adsl.fetnet.net. [27.247.129.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b273c0asm81124695ad.71.2025.11.22.02.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 02:18:45 -0800 (PST)
From: Hsiu-Ming Chang <cges30901@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	cges30901@gmail.com
Subject: [PATCH] wifi: rtw88: rtw8821cu: Add ID for Mercusys MU6H
Date: Sat, 22 Nov 2025 18:17:05 +0800
Message-ID: <20251122101829.18319-1-cges30901@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Mercusys MU6H AC650 High Gain Wireless Dual Band USB Adapter
V1.30. It is based on RTL8811CU, usb device ID is 2c4e:0105.

Signed-off-by: Hsiu-Ming Chang <cges30901@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
index 7a0fffc35..8cd09d666 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
@@ -37,6 +37,8 @@ static const struct usb_device_id rtw_8821cu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edimax */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xd811, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edimax */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0105, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Mercusys */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8821cu_id_table);
-- 
2.52.0


