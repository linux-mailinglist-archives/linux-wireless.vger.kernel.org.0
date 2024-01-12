Return-Path: <linux-wireless+bounces-1847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8421C82C76C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 23:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C26A1F237BE
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 22:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6495618B0C;
	Fri, 12 Jan 2024 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5JK3yVd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E218AFA
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-337984681bcso696103f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 14:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705099824; x=1705704624; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bH8vcV2OGIj93iwnZZkZGR9G/M20tbOqyl5RT5WJZYU=;
        b=A5JK3yVdgnwwByzOdcUvnLx7CUQH6U5et5k8fdoEOwhX/7T3AmkGGfT6qNkUatfb8O
         oCKJJYQJD6tfSoRrexIkH5cZuKhiGYE4sIxKdm0uvH13UH0n45a7AIYDD7smjcwFp0Ot
         5kYhtJCovujANPJqWYwFzFSdsShLE+VK8n7Pg2dz6zi74C83V66i+hzs9wQEGsgKWX2t
         pobCbpJ9Snfhf3Q1oVo6aj/ml//goKTLLDuP+quB+rMQielteo/5ltbbzuXq4CTZ8bAm
         LHCzNjyprHZll3FHqG5UhcW6pedDqjfS2owAJXtPTgRajrz39+0a08gobt7ITjjPKbym
         gErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705099824; x=1705704624;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bH8vcV2OGIj93iwnZZkZGR9G/M20tbOqyl5RT5WJZYU=;
        b=WvQY9Cuwb07Vvr7aulELyEF6FsY3JNmtcPenQEwKDOSt6Qu5gKV3rFC3FrsXvha4Ry
         YaXh0np8RdW3w8W1ccjF4X+bs4xMFRItUMk9lka2dmYOmxrbj9BXT3c9LnGeKMlUVX1g
         sX5Koj5eRaaZLH3/3UEpSAKFm58cj3ttp/HJgghtoFD/lv/t0UUb4xiWQ5w1ueGXEGhS
         IUd4xxTHVfTuyEKcSFrJMNVnXTNbkoY9xaeV6ah5j54xG1dDvzbXJ3RhGIKIF0W/mVFg
         xMKv3KCTICni0SWkm4r6nrDyjWvw0wNayva/2SU5JyLUKlWNpcqgGk/2cegaEN2sxtKq
         xE0g==
X-Gm-Message-State: AOJu0YxeNdeHiQAX8IQXoX3qMAWWYjuuc5dUTozJdEpe546N4VOK4vdz
	lHXJpbteiDw3GcijkQT5tPxtOYxVj9A=
X-Google-Smtp-Source: AGHT+IGYbR7Iz0EtNGefr0n2wH7AJi0tOQ5JB4KhujENONMSrcm3ILRqoVo6eJxp4Jv3LvflUx9VAw==
X-Received: by 2002:a05:6000:1e91:b0:336:7758:c6f0 with SMTP id dd17-20020a0560001e9100b003367758c6f0mr1000460wrb.70.1705099823629;
        Fri, 12 Jan 2024 14:50:23 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id s27-20020adfa29b000000b003366cf8bda4sm5017806wra.41.2024.01.12.14.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 14:50:23 -0800 (PST)
Message-ID: <81b6c452-e940-423a-acf7-4a7b7c5e7847@gmail.com>
Date: Sat, 13 Jan 2024 00:50:21 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtlwifi: rtl8192de: Fix byte order of chip version
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The chip version stored in the efuse is currently assumed to be in
big endian order:

#define EEPROME_CHIP_VERSION_L			0x3FF
#define EEPROME_CHIP_VERSION_H			0x3FE

But other 2-byte things in the efuse are stored in little endian order.
For example, the EEPROM ID, the vendor ID, the product ID.

The out-of-kernel driver for the USB version of the chip uses the same
macros and version detection code as this driver. They recognise
0xaa55, 0x9966, and 0xcc33 as correct versions. With the original
macros, my device's version is the unrecognised value of 0x33cc. This
seems like a mistake.

Swap the addresses to fix the chip version detection.

Compile tested only.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/reg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/reg.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/reg.h
index 2783d7e7b227..bf15c636b092 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/reg.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/reg.h
@@ -657,8 +657,8 @@
 #define EEPROM_RF_OPT7				0xCC
 
 #define EEPROM_DEF_PART_NO			0x3FD    /* Byte */
-#define EEPROME_CHIP_VERSION_L			0x3FF
-#define EEPROME_CHIP_VERSION_H			0x3FE
+#define EEPROME_CHIP_VERSION_L			0x3FE
+#define EEPROME_CHIP_VERSION_H			0x3FF
 
 /*
  * Current IOREG MAP
-- 
2.43.0

