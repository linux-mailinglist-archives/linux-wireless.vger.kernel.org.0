Return-Path: <linux-wireless+bounces-24738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D3AAEFF18
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 18:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24D63AF591
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 16:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A4B347D5;
	Tue,  1 Jul 2025 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyR/ZVM2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF41B0F0A
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385944; cv=none; b=u28TtAEIkMTI1fakzkL8tuNx7LykRyYT+/gV6DCtTfwAHPdDzCCkjAr0fQ92aQ6HxqJF/KRo9/ckMTnxGMYJcb12c6+scP1ZdD1QKylytX2sm/aqQIPoLg7w3xa2nFmu9zEUnVT05QQM71VoknyRMVfaIdhdUdEWVd/FB7GO604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385944; c=relaxed/simple;
	bh=M3VORN/QHBUl9MuolNjKFuOXKE2s4e07nvrZCyUmYkM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IEsNCaONeJcHI1ZbTmaM9oqiaUxwr4AYjPstCZ6lIlnYC98jQgow3JvX7T48o5Z+pnZP86E7GZ46vvCGS7Qvmt5Ndzc8tjneD3GGB8nI5FY4hl73I7k1zU2LggGj0CkNIT/sszpEMHdim6SNw1CRp0JObfqJ3yvO5f0L2ktzWY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyR/ZVM2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso58403875e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751385942; x=1751990742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=djsa9oG8I50LoiYAfASC39jvv74Y+bSEaBGzSbPly48=;
        b=OyR/ZVM2qIUEfu8/DUuaajCp1Ey2mTdkPBxK+Feh+U1pcqXzrX+G7SG3cBg5/4kous
         RDx3Hp6iDI8/z4blYfajGoPwal0nbji3U8/hcPq2Y0ymgEygIQyHRSu2+7RjjM02yjsB
         T2qgCcpLm1j9LptV1DzySayV0Y8Smj3vQttlRTtRR1ALdmPScAEjVRQoobGH15t78S+4
         WkZ/gOCwoYeHwFo2Yk0f2j1r2ZZyYkZqhu5/LP2xTb0Dw9Fv9p63+8hVC5CNM9hE6sON
         rfXmLYePikV4G7RV7Sxa7tvveGBEa6EJmMh55EaylH+ZLnU0xOXqstuNuyM6Pepa7TIS
         uRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751385942; x=1751990742;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djsa9oG8I50LoiYAfASC39jvv74Y+bSEaBGzSbPly48=;
        b=ZeI9iEUmWftQkgO5z+6QO2gWzuUj7aX1ARPbFaQB8UrZpeLIXCaZyeP3kkpCcRBS46
         u9VFSDGKb46F1wWASaLtYdxueQggyb/Bbf5gPv25CESYyQ//HkpqWYEhRUZSr5/L9cGx
         Fvi6Sq535GKJE390T/glOWuQg6sCWfGZUkbax6vkCRFtvw9J2gOmn/+bv/Citxxx11C4
         st2cpWfW1MzTHJDUDFHOTw3WYXlOwacMTOwTsIzEKc5cHFaJ4PSw3DUikJCrMr7lluRR
         JjvBdRSYsCXEv+BHW8vONp9evj0QY48QdaKHxQ7E9tDvDbvKkNJgq6Ouux4MXJhPa4Hx
         YKSg==
X-Gm-Message-State: AOJu0YwQFX41MEYrpaZpKc4P2CSLYDoPCeZwZ+tLoMBcP5f8oHV0vvOV
	gnKgqvKwvuuIW1Dceh/FcOPwXQBw3bJ/7kRmvKhmX0V3SES3JGrxe3x6MOK3aQ==
X-Gm-Gg: ASbGncvWEZFlOLEgyDoPd3vU0twnZZRzhC7fAaJ9gHjwtvT+AGktIKKVQOPtbqiXPTg
	qLrZtWBkzE1GVN6cZtfCuceDrMaa4i+2ykK5IWqZi/arjyLeD9jk7I8LWzTDaZ+EUkm6CiSbsGq
	ywGwe8fpIs4D8nbYhjef2wHu/bhRrgKxbDVeDespN5we1tiTS7z9IxWTJvI519oLpH3aVVbXl9/
	xFkIsbuvocpbtKhfT2UNrVUxkEMhGU7GTl9WmdQAXNNcOQ7vxHLv5qWXVdJyaAHHMkVvfjREeOj
	lCYjOXapzwTdaJmWNGDvpu07XxL9gdfqrFR7sp9k7nl4WjkeSmbE0TYE8JcydBvxH4qmLA==
X-Google-Smtp-Source: AGHT+IGtnj3L3BSZX4IcVChP27JBBEIOcc8g0IC8kURJRdNB9Qp1CQi6HkWKKi1ibS/pnnGC7fp8MQ==
X-Received: by 2002:a05:600c:a48:b0:453:58e8:a445 with SMTP id 5b1f17b1804b1-45396a94e32mr123593685e9.11.1751385939847;
        Tue, 01 Jul 2025 09:05:39 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823c42e1sm198813955e9.37.2025.07.01.09.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 09:05:39 -0700 (PDT)
Message-ID: <9da12cb0-d364-41bd-a62d-4c1f87e14a16@gmail.com>
Date: Tue, 1 Jul 2025 19:05:38 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 6/6] wifi: rtw89: Enable the new rtw89_8852bu module
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
Content-Language: en-US
In-Reply-To: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Enable compilation of the new rtw89_8852bu module.

Tested mostly in station mode, and a little bit in AP mode.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/Kconfig  | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw89/Makefile |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
index bd180f3369c3..4288c30b400a 100644
--- a/drivers/net/wireless/realtek/rtw89/Kconfig
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -86,6 +86,18 @@ config RTW89_8852BE
 
 	  802.11ax PCIe wireless network (Wi-Fi 6) adapter
 
+config RTW89_8852BU
+	tristate "Realtek 8852BU USB wireless network (Wi-Fi 6) adapter"
+	depends on USB
+	select RTW89_CORE
+	select RTW89_USB
+	select RTW89_8852B
+	select RTW89_8852B_COMMON
+	help
+	  Select this option will enable support for 8852BU chipset
+
+	  802.11ax USB wireless network (Wi-Fi 6) adapter
+
 config RTW89_8852BTE
 	tristate "Realtek 8852BE-VT PCI wireless network (Wi-Fi 6) adapter"
 	depends on PCI
diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
index 891e2d55c335..23e43c444f69 100644
--- a/drivers/net/wireless/realtek/rtw89/Makefile
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -55,6 +55,9 @@ rtw89_8852b-objs := rtw8852b.o \
 obj-$(CONFIG_RTW89_8852BE) += rtw89_8852be.o
 rtw89_8852be-objs := rtw8852be.o
 
+obj-$(CONFIG_RTW89_8852BU) += rtw89_8852bu.o
+rtw89_8852bu-objs := rtw8852bu.o
+
 obj-$(CONFIG_RTW89_8852BT) += rtw89_8852bt.o
 rtw89_8852bt-objs := rtw8852bt.o \
 		    rtw8852bt_rfk.o \
-- 
2.49.0


