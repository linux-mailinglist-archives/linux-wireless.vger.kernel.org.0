Return-Path: <linux-wireless+bounces-28462-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9542C2863B
	for <lists+linux-wireless@lfdr.de>; Sat, 01 Nov 2025 20:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C96AC4E3AE1
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Nov 2025 19:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88F038FA3;
	Sat,  1 Nov 2025 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DskFnt/A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325682C0F7D
	for <linux-wireless@vger.kernel.org>; Sat,  1 Nov 2025 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762025050; cv=none; b=W0X58j2J3ShZ01QIjnzzJL2CsbugquaR3pHXE+EghA+YLyLO8/kbCEqPF/JRvJ/f+iUtvAU+/9Dy/Ra14QbzH2XZx16RUgfmPcT+3ElUyb7JaL7ET4p0cEan5iEHlIOXvx+DtTF3lKhxyrjJxkBZyIO2j2JKYaNuhf08MaVocTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762025050; c=relaxed/simple;
	bh=SH2VQ9a5i6ZWn6CvNjgDITR3VuDXyHtF8M/vFoiPRpg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FVe/gicJeoOs636lwGR2vTrfGf8/DCbXGaQSHS4uyEe+6jvIP9mIuA9Ek6vL+TuD2Io3G7x5vztLKaNR1vyJDSMQFdmg8lyZ079HPDmCGe/H3Yl/INLbwczoTLeWFqgS9plNgN+vLsIFUOx5i18IA0pORqv9ne9au5teRjw5bnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DskFnt/A; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee130237a8so1942185f8f.0
        for <linux-wireless@vger.kernel.org>; Sat, 01 Nov 2025 12:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762025047; x=1762629847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gu3czQO7AP76o4uUCQrS3NMXd66xLN282JtomFePjFM=;
        b=DskFnt/Ar5sLvlR33UOVYuHhe5s6pMF0p3k++7lzvDOEOGY9uP5qqaz6jAGd3urKEX
         NTlbGRRU+Yzwnmp3pN/5UEERs9Y+FoFA2ozZCoVtMHPakkzprIBy7C/K7LtkTGK2AuFa
         CVxfiIyEttwQW85PSXjDyGA8UxDF3uTNrjCrFGLctzW49Ofzk7LB6wiArO5S8iLzOknb
         k2p7HoQVpD6bPKn6X/VRzEj03IblvFK9ZPQjWwX1Zn2ORYFckicdluxrdum3qGtEwP6w
         sDhJRT3BLshQa3Vk8Em0g4lTdB1MSHH5OGxyt/3QarevQzy1CKT6/A3/mtj2tCsNQLXI
         zs6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762025047; x=1762629847;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gu3czQO7AP76o4uUCQrS3NMXd66xLN282JtomFePjFM=;
        b=YGzxXqyacRf2RMOs0rciyX1Tl18xVEDVeonDrBLo/VgtGNVKjwGiIk0d7BVX7vqPyc
         +VzcEvdrDV8qhX+zPXwIyfDEmJisKHXtlCNc1lClA1VL443zmYf/E3/AynTq4yppf29I
         S96k7FOk1FnFR+Pg5qcijlfATXKASK4BiNrqecYDdPWCxwyJXfxsh0i1GFeuEWO1ASaU
         A0TYeF6V8TBD+529W4laeKDUb7ih/95pt3+0i74Kad6ovUmAZtdEOQnos+0rQAT+RaY2
         pX2KmgZod5mIdb3+b8iwjm68lNUlNIg0dBoF55J2Jus3eloyjA8kRlx0teKTgt5ih7c5
         GN9Q==
X-Gm-Message-State: AOJu0YwBPe+VNta9TKfIu7AHxbxFCaLypZhSIM7GBp1bjH/zVTlvM0hU
	+N5sFs34nWTq63YSqaD76ftGZtF7Qg03OgJpiwsilWYRCpyc1OQHf9moE18XzQ==
X-Gm-Gg: ASbGncv5QkbodAVOJaD+vCXnPqdP6aK7kF8qF+zA+9wYRdBkPgH0/tw/5HxESVBtKFT
	iP3+KapibMHKbxtlmppEdiX7SmsdEDUzmo6htNRNB9rPJcDGZ8LrmpgVHA7mCyq1wwW25QdP1Ka
	Oon2IS0rvKk54kUCGSiFj0qTCm2Xacd9Z5z1NuMxdzX6rh06uCL9FJiujYROCxBCFhqYhiJ1CfQ
	Q5F5cDm/2KmQnMAVRmnaxDtXM5royHd+cFkKKuaOT6vT15KB0LkYgCn5zbv9uwUZnW7zKjJxMBv
	XdZVGQLm7uLnyPhkVyL5EuO+uq9h0mcegjdVqioadPEbyAT8PK0FCBtKA5Huk77MED5giUMq47f
	WvzGp2c4xhqmw2Ttb6TFiuP6as1nRa7YoAm7Epu6lA1Yn4a84p9vIncaJd7qKYZcYBNDpvnD9ub
	/rLGLZNaY9hbfIXepWAP4=
X-Google-Smtp-Source: AGHT+IG8jUYJaLRy8yy59A7sygP285YvZ3kl7Yp4xuAz3Mf0f+1PAozBYPSS5AUhUEJV0sGm2uGfxg==
X-Received: by 2002:a05:6000:2012:b0:429:c709:7b54 with SMTP id ffacd0b85a97d-429c7097cc7mr2634978f8f.36.1762025047340;
        Sat, 01 Nov 2025 12:24:07 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c85ad188sm4634530f8f.20.2025.11.01.12.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 12:24:06 -0700 (PDT)
Message-ID: <d2250e72-0aa1-422c-8f7f-9aeb283ca376@gmail.com>
Date: Sat, 1 Nov 2025 21:24:05 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 06/12] wifi: rtw89: Fix
 rtw89_mac_dmac_func_pre_en_ax() for USB/SDIO
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Language: en-US
In-Reply-To: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Set the DMA mode according to the interface type.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Add Acked-by.

v4:
 - No change.
---
 drivers/net/wireless/realtek/rtw89/mac.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index df040b4e8855..b5309ae3fd57 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3984,8 +3984,15 @@ static void rtw89_mac_dmac_func_pre_en_ax(struct rtw89_dev *rtwdev)
 
 	val = rtw89_read32(rtwdev, R_AX_HAXI_INIT_CFG1);
 	val &= ~(B_AX_DMA_MODE_MASK | B_AX_STOP_AXI_MST);
-	val |= FIELD_PREP(B_AX_DMA_MODE_MASK, DMA_MOD_PCIE_1B) |
-	       B_AX_TXHCI_EN_V1 | B_AX_RXHCI_EN_V1;
+	val |= B_AX_TXHCI_EN_V1 | B_AX_RXHCI_EN_V1;
+
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		val |= FIELD_PREP(B_AX_DMA_MODE_MASK, DMA_MOD_PCIE_1B);
+	else if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		val |= FIELD_PREP(B_AX_DMA_MODE_MASK, DMA_MOD_USB);
+	else
+		val |= FIELD_PREP(B_AX_DMA_MODE_MASK, DMA_MOD_SDIO);
+
 	rtw89_write32(rtwdev, R_AX_HAXI_INIT_CFG1, val);
 
 	rtw89_write32_clr(rtwdev, R_AX_HAXI_DMA_STOP1,
-- 
2.51.1


