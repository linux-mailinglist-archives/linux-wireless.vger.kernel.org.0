Return-Path: <linux-wireless+bounces-24846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6DFAFA19C
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 21:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC3667AFE13
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 19:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC931C84A5;
	Sat,  5 Jul 2025 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuKl4QBh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0650A217F26
	for <linux-wireless@vger.kernel.org>; Sat,  5 Jul 2025 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751744366; cv=none; b=dEfUUliGsiVQ1Px9lRrhlRTrEQCoQfqJ8mALSWDhKOkIoWu41fa4v6iwkkRiWgunIBFccCEU4vKKQxULVj/XFQ49VGJpiuphRiGT9CcXhUuS2XP2pf6FaMnbp+UY6WsrvnIoCNH7+F2EQ02j8zwlvX68C2FxtQjRu49Jx+MSWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751744366; c=relaxed/simple;
	bh=6nnnYj/8M/crsozG2v4QhkSSGWXvBKgCoUOxmAirwzU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rhiJIOFxFXs+f417YAu/5SBe3VaV5+B207XWDRm7EaeNc+TcbSz5qHMHWFDDTkV7kXsC9E7uFLnnaRbYYESthLGBwgnHfFT1vTQCln6slf218qpQbMEbkWhZFIFhVoXQwaVqwRCoJa6wedUy+JqJpyDv14ULMC8n2QiIYghaG5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuKl4QBh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso13873835e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 05 Jul 2025 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751744363; x=1752349163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3eQQ/FPE32QxDF7HfgHxRphY5764BqrUx4NIht8XQkM=;
        b=WuKl4QBhpvJgqZ0JaOV4jzcJZn0XNg5If7Jz24xvydbmKwxTfwkxrD29d7a0CAj1wZ
         2Yljz6ZGgXe1b82jYA4uogyGZPCBlzZ42QfNiHRIPiwK2yCtuOpsrmzAMF1lCzTThxU/
         pMngOMtT9XjDUo2Eac7dqrCp+7/0YejiHa8n52HIwtt3J3npyv46Ou6pUnNC0psPzU2y
         xS0gyHp1c4+tr1cenx1esH2pF/G7NLCis7SEJxXZiDLKC/IGnEW4PEm55TFt4xJzTXa5
         6JzO1jK5lL/yHdq5B47l5Cq842jlcrB1xxXQvHuXBOxHIgQH6jSoiCMt1x5isbFTNGMu
         JdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751744363; x=1752349163;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eQQ/FPE32QxDF7HfgHxRphY5764BqrUx4NIht8XQkM=;
        b=TS/2jVIH7+P+yUB0c3RQ6iBH9AkNS7Lp44JPouelGwTQgSY4H5W0/tADAgpDD8dhYP
         +3n2Ud0SUETzWxo3h9Hp4p4Ftyh01wjfFwC6c2apk4tWFsrlzqoZl5Sd96RpBLZkpmJe
         90Xl6yuSIAe3ToKaT9o/FIt+W/2rMRW97rHtg/U8O91DDFZLrWG3aoSehEarukMMUBaY
         iExiW4bNCMdWe6QgiJ+1UUem7t4SkXmsuAr5tXIrG8pN6Dd5fucMnc9kyMxxXyV1YegM
         AwhyDJ7ruIrBPRXhbQIB3AnicFsVG29/DXufb6rU/1CeB0IdPDwoUkwvWrg+KcM4EAs7
         2gBA==
X-Gm-Message-State: AOJu0Yx+QcBNFItD7t1bWc4Os1i4gMumKpu4zdvk6uFxDW0JaNA6y0KN
	MK2t1MNzP8B42WHGlodRNxrVfChGf47mSS9t10ypr/KnO9vAlZCVXRUM2tnHLQ==
X-Gm-Gg: ASbGncti2tj1vUOTTDxPanHGrw7jHpo6Nc6Mj/pqaXPVwRtgpHft+N1aL1bWPr2Q6Cl
	uU5MOm0syEMzzcLf8C/AqkPBvXc+T/23qqvXy0ziJMTbTfmfsb+eRGjVzW6weh5yGFU2BJ5c61r
	iVCNcjsaxOfFeNmEfa3hOdgsyAU5lg5FubFx7TepME1/Yevc8eV1FvOXQO8cvL2xy+rGv9/LbN1
	YENb5zyXDrGZYWqwera68bIffU0/JKx50SMOkBZBNj4zApSqzQ+eblOHOTh8r2LT/ymO2Jp+Tcq
	W2kuGgVf6bYd7JdQu0zQqgiWNT8dIJpob3GVjUMKFbBlLOwYbQjYfl26mXMgGj2K6KnFQH2lFQK
	lC8Ij
X-Google-Smtp-Source: AGHT+IFRwC5Q2LSb289m92cW90Z6YoI+aP2bNQjGuvSoAV76Xhp0cmvWj1nV1+bJ8ErICITj8i9KNw==
X-Received: by 2002:a5d:5f50:0:b0:3a4:e841:b236 with SMTP id ffacd0b85a97d-3b49aa77499mr2360182f8f.33.1751744363277;
        Sat, 05 Jul 2025 12:39:23 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d07ffsm5859008f8f.31.2025.07.05.12.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jul 2025 12:39:22 -0700 (PDT)
Message-ID: <627e9e92-6f10-45de-a340-19b10d7bad82@gmail.com>
Date: Sat, 5 Jul 2025 22:39:21 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 6/6] wifi: rtw89: Enable the new rtw89_8852bu
 module
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <e6538194-116b-49b6-b2d5-2dbc69aa1a11@gmail.com>
Content-Language: en-US
In-Reply-To: <e6538194-116b-49b6-b2d5-2dbc69aa1a11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Enable compilation of the new rtw89_8852bu module.

Tested mostly in station mode, and a little bit in AP mode.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
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


