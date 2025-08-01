Return-Path: <linux-wireless+bounces-26096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368A0B1885B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAAE3A475B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA922139CE;
	Fri,  1 Aug 2025 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWn1BHa8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44591DE4DC
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081591; cv=none; b=byAWoVFYIgjNSPG/E73g2x1myZqaz0qUOXlNFfn1fJqJcGuHWqxhuRBfu9Up+iImasd1e7SbGL3T/qar6X4FH8XNtJtMw97hc47HIh8jxmEPG+c8fdUVcEdsCVOtKD8rI1rattkslOkUh8nmxXvEA7OX374REpgz8xhkV9MU5JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081591; c=relaxed/simple;
	bh=UA+ZEz0aD8t0WnG6GQYRTkGug8n052aZmQQEiEwgfpE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fEWXs+EzZGB9BFs1WhfniIk1HuoFIAx+zZVS9mmobuda+eu9t46DN+zykjkCvfeC5JFTjp6krZGJaPK0K40J3lPhwsSsb1RMfsmRgPQZ4GjlUt47ayy7WV3nsjh6nho+h9YbEuamXoUquvlude+kKuX2f6WBTEmDk/bh+4CSRVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWn1BHa8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af0dc229478so201178066b.1
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754081588; x=1754686388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LSw5a3TZS8vEfgtPGDzY1wLAT/stI2pIPEHpB401XhM=;
        b=ZWn1BHa8M9QESw+L/oRJZJ629t/Wo1EqDRfPMDhzPuTVEvKIMWbpNQf3lc5HnDwJuG
         OjaHPgQfJKgZjOi5b0IvzgOyIW98YbtTA9BwI4Y6aoRPDrIZ5UX32MTLPPqsOYC4V+so
         n5P21JsEmNb9OGjmP88/mhMb5INrLD6keG6FOCH0bbutmZZK2UHEB06fqagjnIEA7q9K
         3xB2BePZiVafgTuWtPzW8fbrrFg6mMh4iwpsASnDJursBzSXOgLWSNu2wDvbbXeWXBjT
         fKWo/B5vePMNRjXxYk5RToThQaZF1aFXhgW93V35+xfjejtwBCeeiBlp6FX3kQbGUMH8
         BMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754081588; x=1754686388;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSw5a3TZS8vEfgtPGDzY1wLAT/stI2pIPEHpB401XhM=;
        b=KQ1YS42VA+dkxKwsj8A7H8aG9LgasCUSwzZMcOMLutMnBEcJ2f8Ih18wAAA2+7FhPF
         AdOb8s7ogH+JKxoN3RwzYUfMcgCoQNbySQClUDbwjBCj/cRH/ps/ZFEfo7i5MZC7MEl7
         v9NB/trgYvSFh1uhFl3BuVFbrUz8qF23o750aG77mx0VEKkmpA/PINNmQuTQsvZ5EuL6
         MZ93Es9MHcADhpVRYffV/bd3BCmQAXlu7kOxWkD4E/q7f2vA+yTAxkcR2fg8TULTFIXB
         YaloFF0by3dshti317M9rEsTMHqxgsBfdokdMWKSh/tJQUvv5ingkUT/nAE7aBBTnQwj
         0PdA==
X-Gm-Message-State: AOJu0YynwH4NCCrsyxzc6JCrBZUAOn5+7TET9wbmKUtADqnAbCCIQnuQ
	GeKPESSCp5cFTfNq8Usq6Bp+D1YGViI62mK9HVGY/edmHse96fWwl1zYMnYwcg==
X-Gm-Gg: ASbGnctgeu+nHjUPc8oefyTNOudBteZziaK3yaT7a/TNNFUgBEIqCFdVdw0jqTJeSUf
	0xbAgMJ+PnEACo+1qXURJdMDpa7lCl7SFqWKgfynjVwLUL72yswa+K9UHPUwbMfaoEbjZ2qEyKw
	F+pKvkT0EJAFX6DHhoYKXBhnkL13CTRCnmZcIVMaFY/85TiLBV1Fd1Nx/FNG8kmJ+gWb3m3Q3aQ
	2VcEcFfPqjBMQ9I56bt0wgSiuH/eukNX8WMXBPk9Gh3PoERPgsxcXPcrvv54wxvoSa6yVOs4cjN
	EW18HgTSw0XlwC0cITXCYjY17Ea8M3nQfgrc5Ry5lLFFS/oSr51UfxLaGqvYKayjFGbIclYHIwZ
	jjL4Mm6eRmdJZIT6jW+N9lTDYCghEkw==
X-Google-Smtp-Source: AGHT+IE9qI9qLTR58wo6DDc/rXeTaaMLInK1la1vYbLR8vfLYvIIl4HTtgMef6s8USiKjppfjh3zTw==
X-Received: by 2002:a17:907:3f99:b0:add:fe17:e970 with SMTP id a640c23a62f3a-af94000dddbmr129873666b.14.1754081587973;
        Fri, 01 Aug 2025 13:53:07 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a2437d3sm331593266b.136.2025.08.01.13.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:53:07 -0700 (PDT)
Message-ID: <e4911e9c-7a34-45c8-ba05-a6ff4649eb71@gmail.com>
Date: Fri, 1 Aug 2025 23:53:06 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 03/11] wifi: rtw89: usb: Fix
 rtw89_usb_ops_mac_pre_init() for RTL8852CU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Language: en-US
In-Reply-To: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The registers used in this function are located at different offsets in
RTL8852CU compared to other chips. Use the right registers for each
chip.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change, messed up sending v1.
---
 drivers/net/wireless/realtek/rtw89/usb.c | 29 ++++++++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index eb9978a60d04..e749a37ac1b5 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -726,20 +726,39 @@ static int rtw89_usb_ops_deinit(struct rtw89_dev *rtwdev)
 
 static int rtw89_usb_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 {
+	u32 usb_host_request_2, usb_wlan0_1, hci_func_en;
 	u32 val32;
 
-	rtw89_write32_set(rtwdev, R_AX_USB_HOST_REQUEST_2, B_AX_R_USBIO_MODE);
+	switch (rtwdev->chip->chip_id) {
+	case RTL8851B:
+	case RTL8852A:
+	case RTL8852B:
+		usb_host_request_2 = R_AX_USB_HOST_REQUEST_2;
+		usb_wlan0_1 = R_AX_USB_WLAN0_1;
+		hci_func_en = R_AX_HCI_FUNC_EN;
+		break;
+	case RTL8852C:
+		usb_host_request_2 = R_AX_USB_HOST_REQUEST_2_V1;
+		usb_wlan0_1 = R_AX_USB_WLAN0_1_V1;
+		hci_func_en = R_AX_HCI_FUNC_EN_V1;
+		break;
+	default:
+		rtw89_err(rtwdev, "%s: unknown chip\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	rtw89_write32_set(rtwdev, usb_host_request_2, B_AX_R_USBIO_MODE);
 
 	/* fix USB IO hang suggest by chihhanli@realtek.com */
-	rtw89_write32_clr(rtwdev, R_AX_USB_WLAN0_1,
+	rtw89_write32_clr(rtwdev, usb_wlan0_1,
 			  B_AX_USBRX_RST | B_AX_USBTX_RST);
 
-	val32 = rtw89_read32(rtwdev, R_AX_HCI_FUNC_EN);
+	val32 = rtw89_read32(rtwdev, hci_func_en);
 	val32 &= ~(B_AX_HCI_RXDMA_EN | B_AX_HCI_TXDMA_EN);
-	rtw89_write32(rtwdev, R_AX_HCI_FUNC_EN, val32);
+	rtw89_write32(rtwdev, hci_func_en, val32);
 
 	val32 |= B_AX_HCI_RXDMA_EN | B_AX_HCI_TXDMA_EN;
-	rtw89_write32(rtwdev, R_AX_HCI_FUNC_EN, val32);
+	rtw89_write32(rtwdev, hci_func_en, val32);
 	/* fix USB TRX hang suggest by chihhanli@realtek.com */
 
 	return 0;
-- 
2.50.0


