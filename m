Return-Path: <linux-wireless+bounces-18694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DD5A2E57F
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 08:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA823A10AB
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 07:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8615D13AA53;
	Mon, 10 Feb 2025 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqD2Axeu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A301A3159
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739172977; cv=none; b=QBvWBINegQdMxmxn8NVAajGK+pWxewJbhyvLPtVYnBpMxZirOGpwxbg1Hq0uI3MOzqjuZaSELwjFT8FI3p99uQ9pBe/LQCP/x7oTMDmlip2L9VEagApM2KsASE9KupzQtiiNr7GoF5Ub2y2p2I5jvMOir8v1tGEn8H8/dt04KTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739172977; c=relaxed/simple;
	bh=v9p7vqksGFPURHt6Oz0XK/zpXBeAdjg5MdF/mkfmJsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVvTDNe6CyVRzUHvaDz0oWzM8a1LVzOuIXh3Us8majx2XAd2S2udvJhgJqFC/xKXcDYV6Tajz4j2tFL7ilyx78k7R0RAtkxmfBoxo9FYAzgCnxExPdh9nnvxqtlRzbE31DUMvfpeimnnv2JUX7et3vW46jIJIOWLhQnX6j56yU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqD2Axeu; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fa4493a695so2267215a91.0
        for <linux-wireless@vger.kernel.org>; Sun, 09 Feb 2025 23:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739172975; x=1739777775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kug1DUQoBcdOv6CsZnwJOIn+H5pElkz8+OhEdonIJrg=;
        b=MqD2Axeu9gqjRMDMZHgyqnO31+ds8pWYFmb/Ey3RxuL36q5MxVYMKvPWTUu0cqhUXD
         lDl8MBptVED+6OZd5+hJCkifUsz93n6qH2sdw6pOMz0XuZgyoOIK5Evkan7G27PCNt/v
         Z4qQiBA1mD4YbjVVuQLYIGqBW+aBIIFb4d8uwtKEHeLOusSmJ42eKnQKU9Gz5gI6m3VU
         aa+r9P0uaLzrUEG4+2Sx1sTDI4O56mhXn/wKpVpkj5ZffnzcaTlv6k2AO5DClHImvMt7
         r0mQVJPoUpeKdCnn0CwCfhsf/wsRzDwwiPe41fJ36mjSGtehF8mSZjrrhZWgo8pPw5MM
         h/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739172975; x=1739777775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kug1DUQoBcdOv6CsZnwJOIn+H5pElkz8+OhEdonIJrg=;
        b=bQRkhcsqBwixWIBE5ms7DRTHEC+NRLhH2MHLlYEa1Z7+YA8Wea0TfLXps+2/rYhVFF
         syd5NVM9WGoqeXflvuYMoVEIQ8lDocguZ4LYrYoD/FrxBTrsIzAUPP0imSJ21fkXO04c
         fKHN0vURQPKXWth64PTlC4sKG0ewnC/OYUXnuVybFXSzCxWTUF6vlJu/wKIKO8BwEQeG
         pPVTxAiPWudbKRAlTXNIlHM+AOP1NkCL+TviSrBzCWXjpccG0b35FtnVwithOmaUHAT6
         edJARre2GwBxALf109WU7mizbeXRD6tyWnH2tHEHb8LZyLSY967jQDwxyOROGo+H1JFj
         2OPg==
X-Gm-Message-State: AOJu0YzNtH5N1WStbcLoCPlvJTkRaZ1Sd58PsxsyudB64hxdnWAu+uPY
	tNAj+S1GVQd6tB954PS6Y/fCu3kH+tsG2B4FBHJQv2dU7aYv9G5rQAuSvKYM
X-Gm-Gg: ASbGncszdf4Y/ihcuZOiHZuWw5aMmr1A/g+CtwsYcccH19dLZmdPbW76O4jYyJtUOAI
	VGUK2WFLHfb1yNzWZgWsOeff3Zv0PGIIPsb4u2ZxCcASwKi2xFOvURpc1kuy0GMiZQ5qPPfIFGN
	SbX7hcvsHkIzae1HvGehlFZ0fCf0VnfhoxzNxj4AGZSqwkvM1TlB45ukD/EA7Vqj4y4colZoNcL
	8sTIytu8rMmcAB7YSQ24FUYitUYSQFlZ76yOfVEu55Z8tmMzF+zhPjHcDzWd4n+vo+DjBBk68VZ
	K7NOCfoH4+3QS4lmkKLE+2J/xtg6vZkxkubquDgOd5Wg8mfi8awBFinB/LV+5YRHXA==
X-Google-Smtp-Source: AGHT+IH6UrKyM6q8pTrF5T3gg+ScSgwto/tPBUjP40n2pyW/EiwKQPNpo5f0wg6Vx0Lmc9nQG4K0vg==
X-Received: by 2002:a17:90b:4aca:b0:2ee:f80c:6889 with SMTP id 98e67ed59e1d1-2fa243ef19cmr22490053a91.33.1739172974990;
        Sun, 09 Feb 2025 23:36:14 -0800 (PST)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21f3650cddcsm71934065ad.20.2025.02.09.23.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:36:14 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	Zenm Chen <zenmchen@gmail.com>
Subject: [PATCH] wifi: rtw88: Add support for Mercusys MA30N and D-Link DWA-T185 rev. A1
Date: Mon, 10 Feb 2025 15:36:10 +0800
Message-ID: <20250210073610.4174-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two more USB IDs found in
https://github.com/RinCat/RTL88x2BU-Linux-Driver
to support Mercusys MA30N and D-Link DWA-T185 rev. A1.

Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
Related discussions:
https://github.com/RinCat/RTL88x2BU-Linux-Driver/issues/237
https://github.com/RinCat/RTL88x2BU-Linux-Driver/issues/146
---
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
index 8883300fc6ad..572d1f31832e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
@@ -73,6 +73,10 @@ static const struct usb_device_id rtw_8822bu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* ELECOM WDB-867DU3S */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0107, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* Mercusys MA30H */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x010a, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* Mercusys MA30N */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3322, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* D-Link DWA-T185 rev. A1 */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8822bu_id_table);
-- 
2.48.1


