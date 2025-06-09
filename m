Return-Path: <linux-wireless+bounces-23891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9796AD26A6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 21:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94FC21890E12
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 19:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F681218AAB;
	Mon,  9 Jun 2025 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGGKEEZP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A00619258E
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749496968; cv=none; b=OtKYC9pD8A4uDMxwJDpLMZkcf8zMXf/xxeXRKe/5CfrMJtZbmnrZdzjFqgPfratnZRH215ai609YhqBUHjqnfyroLmPi7lD87EUaMbXUvJb4qOCU8OAjK+buRVxWb+QMGkLVy8M16c1UyaVXCnFcb3CSNl/KhVj6PfOCoP/z5EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749496968; c=relaxed/simple;
	bh=2KgbPuuRYIzto7lAky48RUglS/GmcglC881crXki+4Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nYhUUVbs5gjIcwmvbO0NayI/iGgxvBa1dIYkDZUU9CfW4L9132rp/hO521Uz9Ye67KxbXTiNJTvEFMtD+xwd3N/bNRG0ol0hzZXyeE/Yk13+v1wVUpYhjNzjilrywPJde2e+ckznAJIj7tQGfBQ2AMpbxdHDRbb4cirvXG6SGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGGKEEZP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso5467949a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 12:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749496965; x=1750101765; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0k65nblJNdRjeWTIltQiuqe8647jB3PBovdIUnBfP0=;
        b=kGGKEEZPA3Otu168bQQEy6kJ/mhiytEOx4m8jNrECQ91kY9/ksUwGZ1YinDfwKxcuU
         sf8OWmubFxZFX3Ku9AKm0DPKCnlRhxSC3F3pnroSnLex30/+rz96MxHpoHr36fYt9WRJ
         rDKwXlJbldhiduoM5vjhLHyvxSGZsi/UspgdD+yRV0B9Om3ETcE7Gp6iFfomLFZuEEVG
         PD6TTQgJ5wvKHwq3GnTd6IbP/+jKLbjLNQQmrTd4I9sRbsi/A8zZjCRRdQepjomqGuqJ
         g875rUdcZ1uqSuIbi+yjskNZYZzTXPmgBdqXdTW9yalu/h7I/g9JJEsDiUviJiLn6hpG
         0WeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749496965; x=1750101765;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k0k65nblJNdRjeWTIltQiuqe8647jB3PBovdIUnBfP0=;
        b=YbCUe8/SYoYyHW6ThdIQPu3Z0hFbSE89Olzaca4NBB5AHv2x7m1mKKNTZnTWL9W5Hk
         sXoo23u+SHnaKWMSWg6u15vQvzW1IOOHvk2iYSvlXvtQ8QSqoEvUrWiIyxa+Wax/QsMn
         UAM6hYzHdkFCrwrUvlKmmPC/qLbCGVZFzus/SmGUDR3Z2NO3yBx8I1GMgAEVpdSjd+7i
         MEFxwlzBqZywXWFtBcH/MJLLUcmuSXzqcXqShl1aCIjTtKc4jAfhuX6dAaHcvSL76q6c
         rBEfMbJQKww6JbquUvZbCmDWL9gK1ahui6O4uvWkWb9tYq5rVAtp/SPsHAnJNJqoVkRY
         wqgg==
X-Gm-Message-State: AOJu0YzgS51f2EqbcjsQcyUI/iA3i+C/1ZRILdpFIriZc7phnxchU6kl
	5HV6pB0tHT2FovqUS6AcTrAdf526gO2piisJFNpqrX8M8RVAZf8J14xi2DcoFg==
X-Gm-Gg: ASbGncvVOUKIgV6NUF5wcSuwBlPKtd4IdRVeQgAi9WTnwb/j3Cf3F307jUrQ6Qid6I6
	zP8KdN3syF7NKbd8WdgKLDUOkZ39k6fg0VYSfQzyEQJKRbutQIwIoPLELN/juSHe2c3pvlipikb
	4SMTpOWhkdLjW9R5eMUeQrArfBzlz/DvK76tF5OvXFSzH0cy4rjz9seJpvgRZmaA4icygpi5vAs
	XWhrIoQuAyP9i2EMO8t0q/FitAZjZkC4b0Ip1ObYiVB9c8zBWqmP4pQKdTy3EzSEioO4yRrpcTz
	69qFlKGGm/ETNtIdW1IqjNx2gyKeH1VFJwU9dcM2KH0oqFQFY4bL3jxk/UcHvqs66I7mrAv5W9F
	HP895
X-Google-Smtp-Source: AGHT+IFhVVZXrkc+4I2bmyHaKZHT2y2fuYSej2Q0vqic/qpWZTP16iccv0ykF7MpPgpcjo75Cs1O8w==
X-Received: by 2002:a17:907:60c9:b0:ad8:93a3:29b7 with SMTP id a640c23a62f3a-ade1a905ab7mr1270071866b.18.1749496964636;
        Mon, 09 Jun 2025 12:22:44 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade2ea143a6sm525337866b.53.2025.06.09.12.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 12:22:44 -0700 (PDT)
Message-ID: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Date: Mon, 9 Jun 2025 22:22:43 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next v2 00/14] wifi: rtw89: Add support for USB devices
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add support for USB devices, starting with just RTL8851BU.
RTL8832BU/RTL8852BU can be supported easily later. RTL8832CU/RTL8852CU
can be supported as well, but it keeps losing the connection.

This is based on rtw88_usb, rtw89_pci, and the official rtl8851bu driver
v1.19.10-70-g84e35c28d.20231019 from here:
https://github.com/fofajardo/rtl8851bu

Bitterblue Smith (14):
  wifi: rtw89: 8851b: Accept USB devices and load their MAC address
  wifi: rtw89: Make dle_mem in rtw89_chip_info an array
  wifi: rtw89: Make hfc_param_ini in rtw89_chip_info an array
  wifi: rtw89: Add rtw8851b_dle_mem_usb{2,3}
  wifi: rtw89: Add rtw8851b_hfc_param_ini_usb
  wifi: rtw89: Disable deep power saving for USB/SDIO
  wifi: rtw89: Add extra TX headroom for USB
  wifi: rtw89: Hide some errors when the device is unplugged
  wifi: rtw89: 8851b: Modify rtw8851b_pwr_{on,off}_func() for USB
  wifi: rtw89: Fix rtw89_mac_power_switch() for USB
  wifi: rtw89: Add some definitions for USB
  wifi: rtw89: Add usb.{c,h}
  wifi: rtw89: Add rtw8851bu.c
  wifi: rtw89: Enable the new USB modules

 drivers/net/wireless/realtek/rtw89/Kconfig    |   14 +
 drivers/net/wireless/realtek/rtw89/Makefile   |    6 +
 drivers/net/wireless/realtek/rtw89/core.c     |    3 +
 drivers/net/wireless/realtek/rtw89/core.h     |   17 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   62 +-
 drivers/net/wireless/realtek/rtw89/mac.h      |    8 +
 drivers/net/wireless/realtek/rtw89/pci.c      |    1 +
 drivers/net/wireless/realtek/rtw89/phy.c      |    3 +-
 drivers/net/wireless/realtek/rtw89/ps.c       |    3 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |   30 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  115 +-
 .../net/wireless/realtek/rtw89/rtw8851bu.c    |   39 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |    4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |    4 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |    4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |    4 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |    4 +-
 drivers/net/wireless/realtek/rtw89/txrx.h     |    1 +
 drivers/net/wireless/realtek/rtw89/usb.c      | 1011 +++++++++++++++++
 drivers/net/wireless/realtek/rtw89/usb.h      |   59 +
 20 files changed, 1354 insertions(+), 38 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851bu.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/usb.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/usb.h

-- 
2.49.0


