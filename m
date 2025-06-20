Return-Path: <linux-wireless+bounces-24293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DED3AE2288
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 20:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162AB3A5D52
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 18:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0F728DF50;
	Fri, 20 Jun 2025 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQwcWluF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C991FBEA6
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750445485; cv=none; b=VpfdUWzI17wqykgvC6nA2BVYOuFynzfM7fcy3fTLJAPOuq7N29G9mOWKIwB8JdqKryYqF67Mz5udH+AL/TVcIFBrK5L61fMKIlEx+FQpmlDosEZhQMIHn0CHnL8jNSTP8rgYWgLnkHWzf/A08ArWYnXE8fhvEsVycgFfiR6YoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750445485; c=relaxed/simple;
	bh=hVXnkceXwdrpyqLxwrxUWz+mq97f+sDGXIedQqfuQ4E=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tObvgxazrqdJCrFI7L04/7gIe8ZX6GmjukTfubhAZHwsKQlNrpZ7Pt4wOI9nmurCQ/4RoE5vBEuiz3LHJdhEJQsl63FCn21jpGGvPgdxi3vLVBpvsHNTvDeCBzSFIXyNFV9h/M1UzxC0TFUDSvUNQHMXhq1pVCZ2WeB70HfR5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQwcWluF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d6ade159so17247345e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750445482; x=1751050282; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWwA5GBLRnxt2hYrhuVxeUN7101ZlXXx2h96g4mLxgg=;
        b=RQwcWluF44WazWiRl7dTej5lkiSAowzmY5aOlBAVYfiAQB14TnozwFM6Ia/KQCltsG
         Fzot0RfnzB05SgFudaBO7IJNxJzJdRfl4j22jFX19Yvl0XFXa8czfIkC8/qQjmQCbM7w
         L3K7aKmwqdQrBL4ANlwlEA72dLBC/Khohu+A/BfIG4t5BxALHZHxO39erbHH4l2aUOwZ
         7ieJN/gkvS99Zz9pcM1KXjRJqDpZg/WVk/KJTILbs62PkLvqa1DstaXLEITOw1kfnPgM
         7m+aVQDz/dQ9vMl++ohU90xqwGG641kWxq2oyk4lY4fTRKY/5LQgmt/R7KLsqjkyNko8
         11Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750445482; x=1751050282;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PWwA5GBLRnxt2hYrhuVxeUN7101ZlXXx2h96g4mLxgg=;
        b=wgoE6pOa5SKWL4TofVOmuoa6hTiMYIVMabq9HE4UFmNZ0A3BQbsCeNE0FEVZ6NwawS
         plGjaJjPluc7vx3CMyiuS+L5pbJ2xCzQwbjCcSEkdNKKlQ10mkf3aLj9hjI2ZUNcJqsM
         RJ2dXubzMgdwunDC7W5kZDONNHUzB5uT9JJR2n7a37q/EHgdfPsJ0GNNGWTDnxRD8MYZ
         3MuIiOb/m33p13mGB9D7jCAb5ttXKiXOqgjyniypv4PngCfcgt+zF1gtPptp3dUvWS/W
         +haD+mvFfFCnMjTMpS7PE6Su4Zv98Z0026uwUJS7Ieduvvmxc7gRpctMsiglX7nXve0G
         Ew2A==
X-Gm-Message-State: AOJu0Yw3NgX5qXNLYQW1fa0tEcDAYdRtOBRQ3eTfQRXMC+rBnKz/L+xy
	72/mFu5k9903aL2cVsClhtEeXlx7bwKzYLIv24cjZQWIwUiuwEhcoYPXJdtvSg==
X-Gm-Gg: ASbGnctmGyUoBwUInU6FHxQy1VA/uKmxjlYMfoSnq54b8gwMovhgsdBHOdZ+g/0S1BI
	TtlxcMFOG/UD2eB6/F/gRIEkG5Ay4wM293gUo7cJVdZbuwpULRW9uyE2VTud7ACbImR1hlZhnKF
	u7lz9MnnaKbSkugAZLAtLvKaXXH+FTedCLVOVOXbMoC40hLM7zTG45ZqlGesmpdb5s+yk/kG/Rz
	plUvttMhziPKcFpKcO746LT4Gvc7P/siULLY5IGjM2hOjnYVdUWn6cusVKgOphKFdTNDVU/WSbs
	kNks1afaQWfSe6gAUgWNnWLv7ai94lv42oc+n/WtxssNMqvBNpD4JPJIzfDL3ujoTRysTC3KZe5
	GM6o/
X-Google-Smtp-Source: AGHT+IERXshKc3tGRXNqH2v1Rhyloj1+CscVIwaQClptSNbzmEe6kE1GWhe16yDsXZG4oIiRvTcyHg==
X-Received: by 2002:a05:600c:37c5:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-453657bf6aamr44597495e9.30.1750445481680;
        Fri, 20 Jun 2025 11:51:21 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646fd7aasm33090795e9.20.2025.06.20.11.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 11:51:21 -0700 (PDT)
Message-ID: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Date: Fri, 20 Jun 2025 21:51:20 +0300
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
Subject: [PATCH rtw-next v3 00/14] wifi: rtw89: Add support for USB devices
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
 drivers/net/wireless/realtek/rtw89/core.c     |    6 +
 drivers/net/wireless/realtek/rtw89/core.h     |   17 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   83 +-
 drivers/net/wireless/realtek/rtw89/mac.h      |    8 +
 drivers/net/wireless/realtek/rtw89/pci.c      |    1 +
 drivers/net/wireless/realtek/rtw89/phy.c      |    3 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |   31 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  115 +-
 .../net/wireless/realtek/rtw89/rtw8851bu.c    |   39 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |    4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |    4 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |    4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |    4 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |    4 +-
 drivers/net/wireless/realtek/rtw89/txrx.h     |    1 +
 drivers/net/wireless/realtek/rtw89/usb.c      | 1031 +++++++++++++++++
 drivers/net/wireless/realtek/rtw89/usb.h      |   60 +
 19 files changed, 1383 insertions(+), 52 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851bu.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/usb.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/usb.h

-- 
2.49.0


