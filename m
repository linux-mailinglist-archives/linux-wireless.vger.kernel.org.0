Return-Path: <linux-wireless+bounces-26098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C01FEB18860
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512351C27B50
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AF02139CE;
	Fri,  1 Aug 2025 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L85YAgbS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D17E1DE4DC
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081658; cv=none; b=IlMTTHkNtYl3F25rh90GBRxWtwdfWTcyVmNZj6RPM+k8qwiV8UHyhYHY+MzSsH4Ffyc5gqLPFSZ4s6eJiZde+Bd8jmuqEr0i0ERAIWpFnolsS3lp1kCo3f+JbvKG3H0GquZIrQclsr0woeo8D/VTOAw9n6bgiFWSTlYQxSjNKLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081658; c=relaxed/simple;
	bh=BrpmZrMicOZfA1f+aTmKpL6NWs+Qt9h6o+ZZOVeExHM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LRUctrypKbPTzWFFeLdSCjh+pu5Gst17+8NeVl7UOVHG2+V6pS/yEgkvGqoKvWx78W9sjzIRnIzeYWBfG00HMEHvrBu1Easp6BIYhqIw89rq3fNXhMA8hCDOb2mNK4LoSCV2LqkporT3ETTwof42A0DPZMMe+39CxCeCj+GXtkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L85YAgbS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae361e8ec32so466634866b.3
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754081655; x=1754686455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YsK7C9vnZj457XKsfkDGFx1B6YQfQMx/TW3QJHHa24o=;
        b=L85YAgbSzn6QcEwsDfZMDAiZFWplOJmlMPJ+rF0gH0kOocuHAjrWTxTJk2ami1F7qk
         Be/kLhIgtoWgw5NCC2FlfB5Mvy4AcWIY2vz3bh45y2p1ty1hYRBrxfRihJMhaqV8nPpz
         EF1U81EByxqJhovXfn1EpM8KIC5UdgCKugO6z/pWcWgFMVgsg9DPIhf7xKkidbzhHe/q
         qzc5w6XX2q11c8X9lz0APuiQOcguDaL2lR0CSIOCOrVh10rZTV80FJGHtgvTIQ/hLYKP
         u4wdBjq8AKWJtm3HIx+ecW6G8+W9hlRiTax2383A1dWxvW3G4kOGPlPO7bOrrxIxLWS3
         e47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754081655; x=1754686455;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsK7C9vnZj457XKsfkDGFx1B6YQfQMx/TW3QJHHa24o=;
        b=KsLDg/EtC44MFRnFQaXfsEDRTYnR0GHLndzIzPwIFY/BiIPVAOYk7pG3p8SoX34XWL
         9RhRNf53dRhPzrJorW5ZvHkWPJ87qu2pTnE3YbsEbUfnYWe4UIyHBI5pZ4Wd3EmFxify
         Zn7nqJjMWo4/xGKVE/8lOXlwICNQqDSFKv0fORAybdxfEm6bhC7sO4XZ8t/r32qtQ7Od
         LW+8cl6MHIoGpgl5l8qgMbuVMnZAW4eYNABQc8QR/UDpbIMovIE53ko8+eX/izZUzg4A
         ddD5qDIzP3wmuXKxWKHhcvHyvcIZ6K4QACv9qejTuYopkE/VHL1T7oIw6bHOP0K4dJwQ
         egnA==
X-Gm-Message-State: AOJu0YzCp6L4rIKwucMapwigVYslm9fmcTWTj5TyCDWoL+JnAW+7LMoj
	hRYqAogeims8NRCwX2OQhJFmGdyY6gO4L2GctsAVbZkB8As5iygNeh/UOM5HUQ==
X-Gm-Gg: ASbGnctdUIE1BZM4ca/WzK59S3wvBMcTfN2JXwr5T9sYoVM6fDCURrmoB6pyjZxivaJ
	MFKkAfEn6jL4QUb8KOSgKBw2nEAuICviF7x9V2mhNw5basWAyRJ2YgDeOpyYlSnE8fDy41y4f/i
	rQOMO/KvPJc25hSx0Uur5qKnMhNTuITGicVF/HZfJ9I4JQ8cNkfhxzHoQBKVrIhQ2f3NxUz6KED
	AiMtXERGI7jabiSzWp7OWXiVRPxkG7xPvVN5ixlEg/9vCPo5IR/mliWdDtrqAOK1HAVHS+STwER
	Gs4mNxuJQc7zo3Txy2IXqV2qe5jWarvjjJRVFWhF9jD0eM65n2n5ztjN60qczeV9QLQBL0aUiI9
	mfGfe+uHmvXkr7CS3w3qBhNmFZtjdsAXd0AYfcRn4
X-Google-Smtp-Source: AGHT+IExcuZu+wJX1RTf2kuyeBWpHQmPDcK3MYLQopBdGdAeHWneFHrIYJtgExKxLAVpF8lv9pRlKQ==
X-Received: by 2002:a17:907:7247:b0:ae0:df46:abd1 with SMTP id a640c23a62f3a-af9401c783emr120655066b.45.1754081654984;
        Fri, 01 Aug 2025 13:54:14 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0766e2sm331995866b.27.2025.08.01.13.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:54:14 -0700 (PDT)
Message-ID: <f7a422e4-ad0c-4ca0-ad2a-dc3604918232@gmail.com>
Date: Fri, 1 Aug 2025 23:54:13 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 05/11] wifi: rtw89: Fix
 rtw89_mac_dmac_func_pre_en_ax() for USB/SDIO
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Language: en-US
In-Reply-To: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Set the DMA mode according to the interface type.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change, messed up sending v1.
---
 drivers/net/wireless/realtek/rtw89/mac.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index fce48ac97a02..2d473f1bb66c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3979,8 +3979,15 @@ static void rtw89_mac_dmac_func_pre_en_ax(struct rtw89_dev *rtwdev)
 
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
2.50.0


