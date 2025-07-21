Return-Path: <linux-wireless+bounces-25691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F129B0B982
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 02:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD731896C9F
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 00:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2C223774;
	Mon, 21 Jul 2025 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LswYdb/0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EA73C30
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753057213; cv=none; b=AWIos7caP+KtZ0Vt29+mRF53C9F6jW9Hq2YzKCTaop2ykm9iPfW6XyHB2T8IhEoVzcpYovsERm+etUObdwqbIoX8o1JIXud5taRVB+jYwUDRnHVSEJLrgvzwmG0wRkTTMqqLrIpEPB4pWxuo26je0RoxnGCYH9ZQM21kcQovhnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753057213; c=relaxed/simple;
	bh=j0RhoELv43IzorvxXAMAOAvH9MncadUmyxHnz1raxkM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ivuS5wrTWfl/wn9U2eRMIVitKZGdCaxq7y6vFDaVY4/eXXzQm3ZqKRE0zuZI3T8wFOX6hGdEY/UYPtiImxbv901AzHUIV1zBJWXBbVoMF5As773VZd9Ux3A4ogch/yU/D5YS9BUV3Dv/+3d0wol/HZx3l949s8ZA6Rq/nSkWWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LswYdb/0; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74b52bf417cso2411408b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 17:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753057211; x=1753662011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vyWlu2cUWdrqQpfrqUVlBUqMrwZ+6//kKp0ufMv+PPw=;
        b=LswYdb/0cI6omFlHEqnMKsRR35de8X9q92BxQfQ6OYYImGMP8GovFSu6h0TOseIttB
         Lj0APy39E0PVHI+tfP6tL3HuB2ev3n8kPy7Kan0Dd6XJvnly5+9sAKBFxPzPBXaNUDxK
         LEXZwgA8MSDPku1xrJ4PKHxo3yGwmYN4i90DX7JDXv1t4FOhHoukOZUjYRh17FuFKXmk
         VoVSzmz5PaRga/Zrw6l1MUGW8U6G6piybz6GQGBD34/tu9mxJRoxZrPaBM0bHALVfshi
         lygFkZa7N5f8x/N0HuKr51KkqrknAgqW9zmVj6B2N07Dt96LEDq+dn7bK26whAJXeueR
         Wd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753057211; x=1753662011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyWlu2cUWdrqQpfrqUVlBUqMrwZ+6//kKp0ufMv+PPw=;
        b=QnCfEGVhONurYxRZZ0xJT2kpKAfErWF8FAYIMfCtJ7o9Er5K8MjLpP+l45Fyz2CpiQ
         RrAJ86EBRW97iHW2U9lfuIyO9cocWeLswG+owBRBRro/0wP6aDUbp5+SkdVzC+mTQlwH
         FRujcW0iOx5+JrRApYrX9ykOKVTNPNCZ5us/dLn33Nkyk/eaXoBKVpV1iioDv34/gU+K
         H8qzQ45tM8cU3j2IizAIxSF2SFWnhp0k9dBPGd1qM3BKaRorRjzUZSVflGdXjnwE53al
         LjgvKKmaU5R2YK6cuubVcTXw0biTx1MTv99mYEpYuXn61BGjLKifAbE4FoBhECXAb6P0
         WAIA==
X-Gm-Message-State: AOJu0YxrfS0/P+yaLky5mesHEm/wPnyhrN7Pca9DKia2Rt4bNUTGQjD+
	Up9nene+iLUV4vHcZfBdWQ/0oS88nVGiQqTFdn9Wzi6mBz+Tusu7MTSbbMsLhrCI
X-Gm-Gg: ASbGncsiVd2hMyfiLH0K104S3t6kJWILrp7P9w5hQHL4P2WB1hLq5T8v1TLRBKgkBqb
	r+kjSrGOGnw/Si8Ff4YXoKuopTutgn/JwN7ysCx8L/FlXP1/fnsBabHD7g6T8h/P1f/iPlQ21GC
	Y1xa1M8HS792qKA9TcIv8Y9LW8guhyX0a/nw3Fi+PWHxlGVwpjUIndPUtmBNQUmfdr0qLpQQk0P
	xn8tMJsCOcq06iDarD+h4atNEu+ugM0SZzRg/WoLg+kYshFw0GnQfWE/f839SEAotR+bTOUoMhA
	mZnJafC4hKTJgA7lR1+bOCT4gLl7JRV1e7WA7kBGpXrGNX+cFPvF6X7+5+omyEveS7NQ/cMtz57
	WdYq/OGTwLnH1JGj+IHeDV5Fct6KrswMPwm/ARVpctzi3wG4WlMSUJL8tN8xqLZXdgtrNDAoc4i
	k=
X-Google-Smtp-Source: AGHT+IHFXchBJ9qd6Jb8klqnkLgHwA1PkJf4PoyOOSvvi/tY8VrVqOq2ZB+uHGjzzru4hZk+poC3Jg==
X-Received: by 2002:a05:6a00:4f86:b0:755:ad06:b6d1 with SMTP id d2e1a72fcca58-7572467447dmr23663553b3a.20.1753057210567;
        Sun, 20 Jul 2025 17:20:10 -0700 (PDT)
Received: from localhost.localdomain (syn-172-119-055-184.res.spectrum.com. [172.119.55.184])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d53fsm4661058b3a.105.2025.07.20.17.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 17:20:10 -0700 (PDT)
From: tnguy3333 <tnguy3333@gmail.com>
To: linux-wireless@vger.kernel.org,
	nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	tnguy3333 <tnguy3333@gmail.com>
Subject: [RFC PATCH 0/5] mt76: add initial support for MT7902 based on MT7921 driver
Date: Sun, 20 Jul 2025 17:19:00 -0700
Message-Id: <20250721001905.11614-1-tnguy3333@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Linux support for the MediaTek MT7902 is still very highly desired, because it is a card found in many Acer, ASUS, and HP laptops. This patch series adds support for the card to successfully download the firmware and scan nearby networks, and has been tested on a laptop that comes with the MT7902 PCI card. However, I need more information about the card and its firmware to continue development.

Right now, the problem is with the UNI commands timing out. I was actually able to get the card to connect to the internet briefly by changing all the UNI commands to EXT, disabling all offload tasks, and enabling fallback to software decryption of packets. However, I believe this is not the ideal solution because EXT commands are not used in the newer cards. So, I need some advice on how to implement the MCU commands correctly (dev_info_update, bss_info_update, sta_rec_update, and offload).

Hopefully, with a revised version of this patch, we can work up to a fully functional Linux driver.

Best regards,
Thomas Nguyen

tnguy3333 (5):
  copy mt7921 to use as mt7902 baseline
  add to build and add firmware paths
  fix dma register and add firmware ready check
  set fw download mode like mt7921
  replace UNI add dev with EXT cmd

 drivers/net/wireless/mediatek/mt76/Kconfig    |    1 +
 drivers/net/wireless/mediatek/mt76/Makefile   |    1 +
 .../net/wireless/mediatek/mt76/mt76_connac.h  |    5 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |    3 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |    2 +-
 .../net/wireless/mediatek/mt76/mt7902/Kconfig |   37 +
 .../wireless/mediatek/mt76/mt7902/Makefile    |   12 +
 .../wireless/mediatek/mt76/mt7902/debugfs.c   |  296 +++
 .../net/wireless/mediatek/mt76/mt7902/init.c  |  348 ++++
 .../net/wireless/mediatek/mt76/mt7902/mac.c   |  865 +++++++++
 .../net/wireless/mediatek/mt76/mt7902/main.c  | 1588 ++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7902/mcu.c   | 1593 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7902/mcu.h   |  120 ++
 .../wireless/mediatek/mt76/mt7902/mt7902.h    |  343 ++++
 .../net/wireless/mediatek/mt76/mt7902/pci.c   |  571 ++++++
 .../wireless/mediatek/mt76/mt7902/pci_mac.c   |  129 ++
 .../wireless/mediatek/mt76/mt7902/pci_mcu.c   |   63 +
 .../net/wireless/mediatek/mt76/mt7902/regs.h  |   81 +
 .../net/wireless/mediatek/mt76/mt7902/sdio.c  |  331 ++++
 .../wireless/mediatek/mt76/mt7902/sdio_mac.c  |  141 ++
 .../wireless/mediatek/mt76/mt7902/sdio_mcu.c  |  175 ++
 .../wireless/mediatek/mt76/mt7902/testmode.c  |  196 ++
 .../net/wireless/mediatek/mt76/mt7902/usb.c   |  345 ++++
 drivers/net/wireless/mediatek/mt76/mt792x.h   |    6 +
 24 files changed, 7250 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/Kconfig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/Makefile
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/debugfs.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/main.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/mcu.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/mt7902.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/pci.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/pci_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/pci_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/regs.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/sdio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/sdio_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/sdio_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/testmode.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/usb.c

-- 
2.39.5


