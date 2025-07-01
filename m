Return-Path: <linux-wireless+bounces-24734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED11AEFF0D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 18:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602F73A4FB2
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 16:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839B527D782;
	Tue,  1 Jul 2025 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt0v0IdL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA327D77D
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385754; cv=none; b=Inf6n6CPngPPJ9jjEQZsSbszNqlsFmz9DI4S9Q1QT02CG0cZycWXo/fzy6cXz8A8TVFekMkdEYJu0pKBzFmTwcVqbfKrIu87u/NtM1PtuOnAprVpRECcfc0WeNGshuLlrdngW7z6hnvFFKhC8aR9YqpESxIJFChesnyylnkKAEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385754; c=relaxed/simple;
	bh=vfygOqqqTmndSBXRDBcf21C+Swv+lt1x2oyBjDAsCBk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NyBE3y4Zk0/dQG57PvMBXkqSEgQ0uOaaOvaziLbsCs8jwFfB6mrO3dlRQD5R/3hKk1I9DAPT8F3K7uYWpbgKbCenq44LAj2OwFe8/XSfQ6Sek/ZlpJL3G5MOeuShtutvFTNxjGjcKdQqyYUJvkPxMvhO3raXObu7JiXceSjnzkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wt0v0IdL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso2861717f8f.1
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751385751; x=1751990551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E083sghUhpLRpKnn/b0ldXUkUwYz4mce0ookhEyMj8c=;
        b=Wt0v0IdLm1QvzmHDQC0CnQPPkPN4pU5OuWoo+CNCcv1Z2N/6EEn7iaGkRIENh2f+IG
         1G+C/sr41sOYaup757AEXvySm1sigHNSCfRLf+LKV/iHZUtQ3wbhevxRfauEsHxr7xIz
         EhyrWjiXEe9304O/LVpWDxc3+N2E91gvuGsWqKhMpAxbbc8xWnugf8FAyckvM3BQq/E/
         6Um0QcLOMhoEdy8j/6YI7Woq2qHB0itTEfHO1yOMTH0DPMSaD/R5jL0Mr/mBUmpueQX5
         tqp9RAEI1Ki3wT7GLJoBwmd1RW/3JCaUM1k/kx8bnEFg9+LJgXv4YJsk8rinZdvhD7ng
         fHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751385751; x=1751990551;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E083sghUhpLRpKnn/b0ldXUkUwYz4mce0ookhEyMj8c=;
        b=aphJEsYqZIDLIFzTOy7B4a+1ngPIBXRNFcaBrjY7PbfDzys7BEDgxMoeW+pIfy6w3d
         X+S76pXHGUx9ALc1TFAcM1OpKCQMwG7xKINzZSkTZZOlEBohFrZbkLEzYaflMEcnS80f
         fj1wI7eVYImWLrhZa1xTeWYV/57g18Sd9PyZDpZcKIk+G2tZ0BE9C/et8QGOM8vxj8GM
         lzj1aCCUQDLzPQ+6KjKTH226X2k9Nai7fFys5JORdms4Hhpf5uLho5VwpXBwKOT/gXdF
         oCzSZuM1bRs2IdI0hGqaTWLjeVQXj3GinFo9qb/t9rnIA+gIqSzEPpj/bgQYeSEzGGn/
         p9rw==
X-Gm-Message-State: AOJu0Yyz+j1ECsBev9sxj+wbFKP9bBgZ0QuuTiXNjDhLGDVCDL/Fex8S
	4LlrrtJcKzQPrgUAtEqyERwgZtW+LxS0LH/asp5rXO83OQST59Mdegfnumw8dw==
X-Gm-Gg: ASbGncsGIlPNgo8h1Z1eB1qvRQTXH8Z207llOdoO9fRhD/Y9MgiIDHLKrWWA9TLVAaM
	/QzIR1yP9WJ++RKTlM6ImUOHijExHo6J37VGcR7P/zsxBIAehASdq8QDuqRjofONPGxTd0YUcer
	mHbSiJWxCCkUXbP1vJ0XOPKsMivy247+oU6mTFVP7jdo4DzASjbD7p6I5PFQQoFh+AE2xgctI4W
	K5h35snXtsWh+KVOs67gBo0KO5RWirsWQDTb+nrWcGX+4Jr/Rx0X/oJ1HN8Cg/7X+gJ+RATa9aL
	J/045INbtESnmonPlriQQuLhBBiImbuOxrpzY3ukaHOx66GYctjzLAf/kxy84hQee7fslA==
X-Google-Smtp-Source: AGHT+IFffM3fXMAGEC+AH4pXmBclgJhQi+FXoQ1GJnv9gJLtLlzXiRdIaN9vZ5J8KsXGLI+t5vtyXA==
X-Received: by 2002:a5d:5f4e:0:b0:3a4:dcb0:a4c with SMTP id ffacd0b85a97d-3a8f435e1b9mr14620563f8f.12.1751385749247;
        Tue, 01 Jul 2025 09:02:29 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3fe28dsm171009895e9.20.2025.07.01.09.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 09:02:28 -0700 (PDT)
Message-ID: <6557111a-e8d8-4d4b-8613-2c944e7b9586@gmail.com>
Date: Tue, 1 Jul 2025 19:02:27 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 2/6] wifi: rtw89: 8852b: Fix
 rtw8852b_pwr_{on,off}_func() for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
Content-Language: en-US
In-Reply-To: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are a few differences in the power on/off functions between PCIE
and USB. The changes in the power off function in particular are needed
for the RTL8832BU to be able to power on again after it's powered off.

While the RTL8832BU appears to work without the changes in the power on
function, it's probably best to implement them, in case they are needed
in some situations.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index b0b73a4a70a0..85b6849db798 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -299,7 +299,8 @@ static int rtw8852b_pwr_on_func(struct rtw89_dev *rtwdev)
 	rtw89_write8_clr(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
 
 	rtw89_write8_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
-	rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL, B_AX_PCIE_CALIB_EN_V1);
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL, B_AX_PCIE_CALIB_EN_V1);
 
 	rtw89_write32_set(rtwdev, R_AX_SYS_ADIE_PAD_PWR_CTRL, B_AX_SYM_PADPDN_WL_PTA_1P3);
 
@@ -361,7 +362,7 @@ static int rtw8852b_pwr_on_func(struct rtw89_dev *rtwdev)
 	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0, B_AX_VOL_L1_MASK, 0x9);
 	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0, B_AX_VREFPFM_L_MASK, 0xA);
 
-	if (rtwdev->hal.cv == CHIP_CBV) {
+	if (rtwdev->hal.cv == CHIP_CBV && rtwdev->hci.type == RTW89_HCI_TYPE_PCIE) {
 		rtw89_write32_set(rtwdev, R_AX_PMC_DBG_CTRL2, B_AX_SYSON_DIS_PMCR_AX_WRMSK);
 		rtw89_write16_mask(rtwdev, R_AX_HCI_LDO_CTRL, B_AX_R_AX_VADJ_MASK, 0xA);
 		rtw89_write32_clr(rtwdev, R_AX_PMC_DBG_CTRL2, B_AX_SYSON_DIS_PMCR_AX_WRMSK);
@@ -443,10 +444,22 @@ static int rtw8852b_pwr_off_func(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, SW_LPS_OPTION);
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, SW_LPS_OPTION);
+	else if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_SOP_EDSWR);
+
 	rtw89_write32_set(rtwdev, R_AX_SYS_SWR_CTRL1, B_AX_SYM_CTRL_SPS_PWMFREQ);
 	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0, B_AX_REG_ZCDC_H_MASK, 0x3);
-	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
+
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE) {
+		rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
+	} else if (rtwdev->hci.type == RTW89_HCI_TYPE_USB) {
+		val32 = rtw89_read32(rtwdev, R_AX_SYS_PW_CTRL);
+		val32 &= ~B_AX_AFSM_PCIE_SUS_EN;
+		val32 |= B_AX_AFSM_WLSUS_EN;
+		rtw89_write32(rtwdev, R_AX_SYS_PW_CTRL, val32);
+	}
 
 	return 0;
 }
-- 
2.49.0


