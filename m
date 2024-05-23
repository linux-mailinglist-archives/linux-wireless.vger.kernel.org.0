Return-Path: <linux-wireless+bounces-8013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEE58CD607
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 16:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5FA1F21CB3
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 14:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6A014A4F3;
	Thu, 23 May 2024 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmEq5bhu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E744413E032
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475356; cv=none; b=LmHOPVXuGooapZVSjPkVigI+VjGcjyMIccJ4+cec0i+717H1ck7JVyL1iccReYa87IMHocjvDeVtXZXc0PnwdzpFDbK3KwHwbe9STpck3FylDL6yxFs9bfdgkNQxDIGaTPX75ItTKJzvUAH77lcjkaXke35e5qVVYmrwfQUCeM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475356; c=relaxed/simple;
	bh=23fTcchMCNqlch0Pvx1AondlnD+5BgrLGdEZqs9Gyfk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=b9a5W6QtJVLgU2zuy+jFlZLBlSLK30B0l6UdvgUMUc+262O0FE3d7I00llv0dgb4xPbhMnBYqC0rj28O0OGK8HvG7/yhME+o78+qdAJhTfTZCzsJ8aASWrwr3fxKAHQfNCKPJEA2UyD+Pq/W3KOdm1gflxtWsvST+qt9+EeAq9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmEq5bhu; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e576057c2bso114869041fa.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716475353; x=1717080153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyem6y64CfMN+XlgChhooxs0wFAkPggaMyvlRa2SZJc=;
        b=OmEq5bhu5U5RAoj+fCG8eh+Ykywsa51uE6/Vwm0MqGM5OqXb3TP2gwFYoyeSaunDVo
         VlTWRotIm1VnhKJHWgZPozfNFTN32GLvIQE8qu15tFdhGH6jVPssX8XeUOCQnZo+oQRR
         yoSdsb7Xb6Q92W5/aSORVw3jYVJ3TxDfZsUExSFP9v7fhb8IOljrBanGWv1Fyrjvv8I1
         j1MQ2D76NiIAo4yIvx5oQIzmTBapyfJSnpJADfEXGxurJapvsDU5ItMAY1RtwCovqq5G
         b+lfGv5T9a/aYwtVulWyUNL35vaOaGuyNKac460tV0OsjV6vy+rJ52+IwEpmgFoa9BOE
         zWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716475353; x=1717080153;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pyem6y64CfMN+XlgChhooxs0wFAkPggaMyvlRa2SZJc=;
        b=V3LpMD4hvIyn7nIaP0WomYpHPPByczD2d5vxbU5ivo1Hd52hwKYX6bK6Y1uI7+GbWG
         MdOMUdj9G4j4HjXMQ1Yv4/MP5oI3oq4X7ajkMXgx+meWFO5kP4StIMfWz3dRSilMDY0p
         5BkFKgET1sw8pHAXq/8XRWf2JIWk84aS5mCr3dyyEI2gHcYhve5vvVUQXKn5t0QIL+uC
         qyM9vxoS8hbyIRmqk6tKcH1O4C7p4zcZVBvNjnbNGjswrViIOplh7aDQd6cd6Qgm60vr
         HuY/FOuH3ZlS4EV81XyWtAf7viVPPLsoIvGJsjgRTpLEStqofaoZSetDCF+J98cpFJ7g
         bR0w==
X-Gm-Message-State: AOJu0Yyem7G/da/7o7ZMNiK9c8sXB63sfMJ+eso7FB5qEe3K9wuCLIY9
	VZE7PhX/wE47LKA9UP9nEN205sR/hHxQwxHDxcvvXA7iHY+jw7vM2HQQig==
X-Google-Smtp-Source: AGHT+IH+1B+5hAl4J99Ys5i+AktGnXk29WnL56bHuH8jUm4LJMfQrA4tUhqxFV5SRyF/hkXy07yvLQ==
X-Received: by 2002:a05:651c:10a7:b0:2e9:485d:45a4 with SMTP id 38308e7fff4ca-2e949466b84mr40276111fa.16.1716475352814;
        Thu, 23 May 2024 07:42:32 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17cd0sm1939994966b.214.2024.05.23.07.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 07:42:32 -0700 (PDT)
Message-ID: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com>
Date: Thu, 23 May 2024 17:42:31 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v7 00/12] wifi: rtlwifi: Add new rtl8192du driver
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patch 1 renames some functions from rtl8192d. Patches 2-12 add a
driver for the RTL8192DU chip.

Power saving is disabled by default because it's not working.

Dual MAC chips are not tested.

Until Ping-Ke Shih will add the firmware to the linux-firmware
repository, the driver can be tested with the firmware from Larry
Finger's repository:
https://github.com/lwfinger/rtl8192du/blob/master/rtl8192dufw.bin

v4 of the series also included the creation of the rtl8192d-common
module, but it was becoming too long. rtl8192d-common was sent
separately and it's merged already.

v7:
 - Simplify initialisation of result in rtl92du_phy_iq_calibrate.
 - Fix the module name in some error messages.
 - Patch 1 is new.

v6:
 - Avoid "allyesconfig" build errors.
 - Update the copyright year.
 - A little cleanup.
 - More details about the changes can be found in each patch.

v5:
 - Call it 802.11n instead of 802.11an in the module description and
   Kconfig.
 - Patch 3 is new.

Bitterblue Smith (12):
  wifi: rtlwifi: rtl8192d: Use "rtl92d" prefix
  wifi: rtlwifi: Add rtl8192du/table.{c,h}
  wifi: rtlwifi: Add new members to struct rtl_priv for RTL8192DU
  wifi: rtlwifi: Add rtl8192du/hw.{c,h}
  wifi: rtlwifi: Add rtl8192du/phy.{c,h}
  wifi: rtlwifi: Add rtl8192du/trx.{c,h}
  wifi: rtlwifi: Add rtl8192du/rf.{c,h}
  wifi: rtlwifi: Add rtl8192du/fw.{c,h} and rtl8192du/led.{c,h}
  wifi: rtlwifi: Add rtl8192du/dm.{c,h}
  wifi: rtlwifi: Constify rtl_hal_cfg.{ops,usb_interface_cfg} and
    rtl_priv.cfg
  wifi: rtlwifi: Add rtl8192du/sw.c
  wifi: rtlwifi: Enable the new rtl8192du driver

 drivers/net/wireless/realtek/rtlwifi/Kconfig  |   12 +
 drivers/net/wireless/realtek/rtlwifi/Makefile |    1 +
 drivers/net/wireless/realtek/rtlwifi/base.c   |    2 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/sw.c   |    3 +-
 .../realtek/rtlwifi/rtl8192d/hw_common.c      |   94 +-
 .../realtek/rtlwifi/rtl8192d/hw_common.h      |   28 +-
 .../realtek/rtlwifi/rtl8192d/trx_common.c     |   92 +-
 .../realtek/rtlwifi/rtl8192d/trx_common.h     |   16 +-
 .../wireless/realtek/rtlwifi/rtl8192de/hw.c   |   18 +-
 .../wireless/realtek/rtlwifi/rtl8192de/sw.c   |   20 +-
 .../wireless/realtek/rtlwifi/rtl8192de/trx.c  |    2 +-
 .../realtek/rtlwifi/rtl8192du/Makefile        |   13 +
 .../wireless/realtek/rtlwifi/rtl8192du/dm.c   |  120 +
 .../wireless/realtek/rtlwifi/rtl8192du/dm.h   |   10 +
 .../wireless/realtek/rtlwifi/rtl8192du/fw.c   |   63 +
 .../wireless/realtek/rtlwifi/rtl8192du/fw.h   |    9 +
 .../wireless/realtek/rtlwifi/rtl8192du/hw.c   | 1212 +++++++
 .../wireless/realtek/rtlwifi/rtl8192du/hw.h   |   22 +
 .../wireless/realtek/rtlwifi/rtl8192du/led.c  |   10 +
 .../wireless/realtek/rtlwifi/rtl8192du/led.h  |    9 +
 .../wireless/realtek/rtlwifi/rtl8192du/phy.c  | 3123 +++++++++++++++++
 .../wireless/realtek/rtlwifi/rtl8192du/phy.h  |   32 +
 .../wireless/realtek/rtlwifi/rtl8192du/rf.c   |  240 ++
 .../wireless/realtek/rtlwifi/rtl8192du/rf.h   |   11 +
 .../wireless/realtek/rtlwifi/rtl8192du/sw.c   |  395 +++
 .../realtek/rtlwifi/rtl8192du/table.c         | 1675 +++++++++
 .../realtek/rtlwifi/rtl8192du/table.h         |   29 +
 .../wireless/realtek/rtlwifi/rtl8192du/trx.c  |  372 ++
 .../wireless/realtek/rtlwifi/rtl8192du/trx.h  |   60 +
 drivers/net/wireless/realtek/rtlwifi/usb.c    |    2 +-
 drivers/net/wireless/realtek/rtlwifi/usb.h    |    2 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |   12 +-
 32 files changed, 7566 insertions(+), 143 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/Makefile
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.h

-- 
2.45.1


