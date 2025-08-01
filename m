Return-Path: <linux-wireless+bounces-26104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCBFB1888E
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 23:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE9C77A6359
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 21:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDAD217727;
	Fri,  1 Aug 2025 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSjpyO79"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E322036FE
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 21:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082449; cv=none; b=JuMhEpn+i0OCGgXNMs7YxMTbrpD8HTBrxpHA5+e9MB1w2cyJD8kO9FX4zUqngQMYRlQMohot1aa5uPO5KR9YnhaVMijHHMTczrnVlQ+YM1fxWuP2yQa+ZU+Q/xAAlgx4rHyHyTdO/pdjCGlsU0alHXvHJa4+/4cpBbIicUhC4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082449; c=relaxed/simple;
	bh=n2yPyFCBYmWRDdmfzKky1YgPKNCoJjPMTNbBKPgUBHA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=h/YVkyMlocmPppN7YFdQiAZL6gIPBIpa1fES2aFe4xg+2JYVTWymM3i96EUZegydVHqQ4wGa9SXbV6ImGwcgDrjf1Ob3xzD0C5Q3JdE1RhK4B248E5kMEhfEL7bchtGEUAmRVhPssLbCAN32CfIoF7xc0RvjfjrluA+TtEiC7EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSjpyO79; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-af934d7c932so159835366b.3
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 14:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754082446; x=1754687246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/+QJAxEEB29eIlOrD8zYopcmLhLYCLbIJ91lv2I/MLQ=;
        b=cSjpyO79WgQxykR08Lpwrs23BoN+pEfA8LuAt14751JJPGcoS0J3B+tJR9Ur3kNEyJ
         BKlPhPRxg9lmQHcaHZR4uxpiamgsZUyBU6ZrWSNHJjl03whBNsiw1M4UYO5nhFDQl6Kg
         pn/g3a5I1f9JfXlaXSowWW++0ydz1YuWfnSlTDS81kExM97xyqKweCPX5hBRwiSnHNA+
         CoWzaFxj5lMxDHEhtTMAcea06wo1haaWx/GX2T6QjfDS1AlbHaAxCc+pi7y35DLxIs9H
         YH0nj+fAa6CtcTN7wZA3v2sF/vKrpHpAG4b6ZKIxLzDOThXPaI34BXFiwQ9FUrkBGFqx
         MaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754082446; x=1754687246;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+QJAxEEB29eIlOrD8zYopcmLhLYCLbIJ91lv2I/MLQ=;
        b=VsU9VxRZkYLUID8lGrIkEtyGHM9U8FVtDf7jpkRTTEPfpoyLodhxltgj4H8jloK8FA
         kUDoTp0ZyPo8QCVQvEBO0KgukUMjzf2JBMn985rlmz0F2pdpTFOqHPrqrfp3yv9RavCf
         mTtShLAXbOsSc9uYoZrbGPASSSV7rZRz0fLceHEZgi8LHSuJs10ru+o7BlAnTpoZ9Khh
         vjl7G5zGUOXTdrMK3NB09pweoYHpXVvzBzshaaLp1SqRUvhjd86u7wRl2o95edfFlYv2
         fD/JKGsHBkYI6CPZlxoRxmXAAO0twVHbPvXBXtrwcjfpZxMDo4rG7sRH1XUKIrtO5f/t
         /TNw==
X-Gm-Message-State: AOJu0Yw0sj5pPfHQxNhrfd7ebqkZGrUwTU0MEQDAbVR8T+rx02BEjDiI
	1qcUID/w5WuxJQLu7goGOnM4YxXPBiuwvuh+F2g6jqBUjIvc1cWchMGaJDGsJw==
X-Gm-Gg: ASbGncvDRlaR6pNGns7AFIDCnZ+zUmxnquKsBlXXFzKNvTX3qq8tZX91sPiD/e8QdwA
	84aZsS5ldAOp5Hkvxkqm4BPZ1oN5JcBBAuQR4DQGTCJVDVw2CvBbx/ijS4E3uITgvG97aPyjNo1
	l+YEqQD1Lbs3yrHExf3uRpsmkR/cDIQFp/V/iTQbv+y+hDPN/cyTTet28BCRSJDoqVeqyvAAtBl
	RpQS5v8lh9XzQltiSe3/2Y2T8w6he9NVggSoDLajZOlX0AuR3z26CaJu0y8+2hs1WJLdBA/PZos
	wHiIVwYMXpIvfJDYhUE+uBWxVJ5LEayG5bQzULSwcRUkkO+Ur80N6Jic0+Fao/mRMzAimZgHSFO
	NAnLyAZ2ZjakLXCl7H5MOVhnoHSI+uA==
X-Google-Smtp-Source: AGHT+IF6bpOn6kDq8274KMNOpg8AYALmK8S4SLNCMmDeZVE1hu5XXRTlrXvq/5Y1BQZQFAMM0qiAew==
X-Received: by 2002:a17:907:3e8d:b0:adb:23e0:9297 with SMTP id a640c23a62f3a-af940014680mr113319166b.17.1754082445541;
        Fri, 01 Aug 2025 14:07:25 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0f4sm331722166b.106.2025.08.01.14.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 14:07:25 -0700 (PDT)
Message-ID: <cebbc7b8-5330-4f02-8aff-e56b60ce0b48@gmail.com>
Date: Sat, 2 Aug 2025 00:07:24 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 11/11] wifi: rtw89: Enable the new rtw89_8852cu
 module
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Language: en-US
In-Reply-To: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Tested mostly in station mode, and a little bit in AP mode.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change, messed up sending v1.
---
 drivers/net/wireless/realtek/rtw89/Kconfig  | 11 +++++++++++
 drivers/net/wireless/realtek/rtw89/Makefile |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
index 4288c30b400a..e89f7481475a 100644
--- a/drivers/net/wireless/realtek/rtw89/Kconfig
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -121,6 +121,17 @@ config RTW89_8852CE
 
 	  802.11ax PCIe wireless network (Wi-Fi 6E) adapter
 
+config RTW89_8852CU
+	tristate "Realtek 8852CU USB wireless network (Wi-Fi 6E) adapter"
+	depends on USB
+	select RTW89_CORE
+	select RTW89_USB
+	select RTW89_8852C
+	help
+	  Select this option will enable support for 8852CU chipset
+
+	  802.11ax USB wireless network (Wi-Fi 6E) adapter
+
 config RTW89_8922AE
 	tristate "Realtek 8922AE/8922AE-VS PCI wireless network (Wi-Fi 7) adapter"
 	depends on PCI
diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
index 23e43c444f69..e0d21972e57c 100644
--- a/drivers/net/wireless/realtek/rtw89/Makefile
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -75,6 +75,9 @@ rtw89_8852c-objs := rtw8852c.o \
 obj-$(CONFIG_RTW89_8852CE) += rtw89_8852ce.o
 rtw89_8852ce-objs := rtw8852ce.o
 
+obj-$(CONFIG_RTW89_8852CU) += rtw89_8852cu.o
+rtw89_8852cu-objs := rtw8852cu.o
+
 obj-$(CONFIG_RTW89_8922A) += rtw89_8922a.o
 rtw89_8922a-objs := rtw8922a.o \
 		    rtw8922a_rfk.o
-- 
2.50.0


