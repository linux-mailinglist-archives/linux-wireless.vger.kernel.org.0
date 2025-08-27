Return-Path: <linux-wireless+bounces-26718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB953B3881F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 18:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8253B79B8
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 16:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6252D0621;
	Wed, 27 Aug 2025 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lvc6C69/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A65E225761
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313901; cv=none; b=B1qmDNqoKJ7Nq+39bSb3cXkwgWQcArWKt/u0xTiIdwCMNMVypKK53CtWQf56And8AO01kdeMDIrFjyJZRGv3XAELu+35aUx+N5GWKO1hdz6dnp3GmLAvCiX1zEvajdYWA1VmQw/Qv8pdnHOdYcOTIZBd3sbjxVUKbAAlI+1XDTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313901; c=relaxed/simple;
	bh=HfuWJ2SkReQlJBBW8fRXWvKfmYq+Tr+mVQjmU5ABdJo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OADCNohrWoQa1H+qyxTZgsiFPJL5Cy5Fni4iM3WHORvQ5D/K5Izttmcll1dm+3j3YL9K+LfeWhn43gRuHJfrVy/DoUiEG3fSH27GFxNUAzmWz9V2Ozez6ZO0/RKC/WfeKKr6bBfBfPzJJjUoiE7fBlTHB8Ewm8agvfqwuQCICoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lvc6C69/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3cbb0df3981so10485f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756313898; x=1756918698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FOodM6vz2nlT0CsVDTqsMNHvmaJB8JFsaETqO+8ALC4=;
        b=Lvc6C69/qnCD4xDLKWw1/inzxIsXtXp+j0GWjBQjRT0ViFKLxiPYyJQZlsTyxcUok0
         0M0eW/pF9psFQALlgwSR0rSLKiR8pf6X6tcALO5I3ddU+Lqu6Hiaxz29T9yVIZn+aOuh
         zCicufOchXlrfY4mWJYNApXfI8mqj7iHjrnVsk+ZTzFXWalUFJjE0wMp3U4NcJ3Y3BxZ
         pFCrde3igH+edxDEm6uBOl07P9E5ruJ9sZuon+JI49baxZVF3LYWwaP7TxYNKALbKdQR
         rZdoZCU1hgJ/HGNqaXDPZOZPDuMQZqoGbLnO+1nvC3fN5OylB2cuXJpbUI74g9r5ttdi
         ZKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313898; x=1756918698;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOodM6vz2nlT0CsVDTqsMNHvmaJB8JFsaETqO+8ALC4=;
        b=Q8vYbq1l8EuStV5UTYSYgFy/btr4sg0GwfYVO/NZnU2vKxX+FCRyo+2bwLzu82DF3n
         b11L91zSkYDsmLonYkGGh2PfxWab6a6FsA+w7bLqB6VQMxHMpvUcSs31xsbXrmfmVt9g
         F+aZdL9IsQIu5Sj7ht4MJsLn/XZOTwHzQgmsZblh3oOKs9/IlUiihFBgaciZUTqdZbRh
         2BltCfJdZ1GPb0SAokVZaTnl+9geRTqmvQV6fb1AmfwVvDe+C3pB5rdgz6jG+DASRcpA
         cZ1bDH/UTN1iRD1TXwBqT1ocvnsK8lkYVlJDpitTJRkH1knmwNXkOAFtjrS0sbTxTrzl
         d+eA==
X-Gm-Message-State: AOJu0YzycwK+2N/gQ0GM/yGjxK4U8wOK0yd6QONQuhO8JhPIcvTTjm9q
	enDg7WPbi9yd6ZjT2gxTyZgUJKatCn6/WGNI22Fypix9EVwqgsYAWlp6ahn3PA==
X-Gm-Gg: ASbGncvZ0pxFfPTVJd+xNhJP2GvUW8LsmirxANocsQci4iC6m2q95RkdBX9G7o6AyXa
	KekhOJoYwhOJu9HYjb5gDHAKbno1R0HAWe0uw9h5k73F67OFZo4cjKSjNxGaQGEka7xFinF1hFK
	xy7i9GSg+ALsX8VFR25AIiA9hoFJCQx7oordrNWjdyczD+erOtTVEVmhcPtq+QKJ0WTgvj9Nv4F
	M5URTFPN7jjx1vWTBnXZf0VB2MhJsi5fWGPwMnPDvS6s1v70zn+cZwQPG3THpWtvZxNLnCbsDCs
	k9wmuTrqX1x2PbUIL2z8GeykopWD8C5QGW+edOGDIwDLnegkxNGXkboxMFta7x6ncKu3/kkWWtq
	C/rbR8C0mgzmUpG7ZM1qj3jPPVd6npg==
X-Google-Smtp-Source: AGHT+IEmQcmhmgM8YLzom529M5htGKptsA4SS4PW1TAlZBcUM6GiugilfAOy5fDDFEVxuVaeIg4QFA==
X-Received: by 2002:a05:6000:40dd:b0:3c3:973a:fe40 with SMTP id ffacd0b85a97d-3c5de349863mr18145205f8f.58.1756313898206;
        Wed, 27 Aug 2025 09:58:18 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f3125ccsm37350155e9.19.2025.08.27.09.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 09:58:17 -0700 (PDT)
Message-ID: <e75c6536-6266-4597-b106-9f046ed7ce11@gmail.com>
Date: Wed, 27 Aug 2025 19:58:16 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 11/11] wifi: rtw89: Enable the new rtw89_8852cu
 module
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Language: en-US
In-Reply-To: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Tested mostly in station mode, and a little bit in AP mode.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Add Acked-by.
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
2.50.1


