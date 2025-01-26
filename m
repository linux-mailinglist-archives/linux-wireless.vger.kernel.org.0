Return-Path: <linux-wireless+bounces-17943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DF2A1C83C
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 15:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F7EB7A2E49
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 14:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F8025A652;
	Sun, 26 Jan 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0I1ciqN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C18BEE
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900267; cv=none; b=dT2xs7SfD6xZFJKrrqHd7SiBVQEYoQ62pFDUDQ4/nva476h8XP9O9qkup4B8UkubQRAG9DIFpZfo/KBra5+6TIEvnpAxVV5SX0H5HY0bLbUQPAEso1TZv68Q4ZUmFHM927I1FAjy/ErhSOYqPE8mkKHySWAq7KihpFAp6DDDq7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900267; c=relaxed/simple;
	bh=x+hmgeKN1t8ciHF+CdlYl2CgafTTGxtLw6PXBzVr/KQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PFZtd1w2tKyhrqR1aqJw6o02S0VMKBNwhs+qW7wxR67JWy2DoE9uQM+eklJdiNQMpNwN1XDhj853sbFxXW4Oa4o1RbIWmVnB36FXDbz7D8D6CtHP509Ctv8tnFBcHiYknuJUP/t91oxAsN8rr3wlEkl/TkhYvR7BJl1vIc6TQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0I1ciqN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43621d27adeso23525715e9.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 06:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737900263; x=1738505063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tq3E3tLLV4EiHwUg0lh/om8Lkxq0Z5yyrR68BtCYVrg=;
        b=a0I1ciqNSHLXjvLdWr/YKEJpbuloA8oPfUOcJsztDyk6DiXSxKYDY7eC8jY6wKx0CX
         uenRrLprkmCkiNM7crnM6l70SPuxOg3ex13slvz4S51/dEPuBxDGyixhoM+LhPflvJq1
         zHAfyhpjwrejdQnIwSvAZljdq7JN4oqYDpDOiagnYZUdez4XGxI39uZVi/UcwMCVvjCN
         4nPoUeoRdplm+UEtPWAvUX6Cd29pn1Xhhy0XYnrQn86FB8cqXLc4v/etZrG5ws91YkL+
         GmdqqM2QW+n0gfv7aRFnryW+7MEGNsmz+wzVM5PhGPJ9oybyoRS3GhNistRXXFBgouiq
         azsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737900263; x=1738505063;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tq3E3tLLV4EiHwUg0lh/om8Lkxq0Z5yyrR68BtCYVrg=;
        b=NVMQPNw0RRMIHSDCl8n3NlqtNksKsJ7aNCsbXUmdbEjDluRx/EMRlHUX+5h6APE1jW
         a1WFx9Z9irttX8NZJqLYraTLHHY0vSolUtwgmyx4OII/SKjMJcCEJTYDreeCnVVBpDjW
         tUm4CrKBMvItx4ggSb/HU5+HWmo9fifI/4e5hUS/XGHsFXYYuNyWU1ipsf/E64ky+HpT
         34XJPXnF2pm5bFfOFjvGrf+isFcpcyEgSnHpHxz4PyCrjX26+/pBmrMTUTIjBLB/nnaf
         c+CjgiXR//vCzT0mNPH2zV4mx5n+eb9GDJ+rW9YQCS8VeyTZ6k7QTFzlqbjXqeeT0iy6
         JOog==
X-Gm-Message-State: AOJu0YwGandJMNE7cufxiF+nChZ8jwza4HB73v1o0VJflp+fylkHYuGU
	UG8jlBrBo+94oqA4+od6o0klRe0nezc1bL51gOoSU7SMH7x3N4pYJZkcfg==
X-Gm-Gg: ASbGncskQIvbHDzVxcnaHCpnUUKIOqHNNa9sjjwqT8mmzT2GTV42B8juEVR5XTGubl6
	4b7SdUve7J+5eoD9HTf9ERwAuelEHwL+r8shmQkFrphgPRQYpvA+OG1LB7LTNtPtXkQdHxQfBWb
	RLiDXgOztZuMIZgopkBEvzputiap00YprG38cOIroULkWdCOfM6DvjYIKO/+YR2eMHi0OgABeDx
	7n+vRptt4TB3UDyD+q5MRwV+r/zC7snez6iyzmkBpNVo+pEv13Q3EjT5SG5v6ir/wtXnjhsZ1r3
	XoxUDjsbbaXx
X-Google-Smtp-Source: AGHT+IGFoihMSfko3Nf8EErKKSuwtRjkmBPlCYZWhuAbbGxgK7wLDWcpts6P1RmLuMFTXFrtXaxWrg==
X-Received: by 2002:a05:600c:4ec8:b0:434:f219:6b28 with SMTP id 5b1f17b1804b1-43891435c37mr323548735e9.24.1737900263203;
        Sun, 26 Jan 2025 06:04:23 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d6besm8215645f8f.27.2025.01.26.06.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 06:04:22 -0800 (PST)
Message-ID: <fe42858c-9b9f-4f03-9aaa-737472c2cd90@gmail.com>
Date: Sun, 26 Jan 2025 16:04:21 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] wifi: rtw88: Don't use static local variable in
 rtw8821c_set_tx_power_index_by_rate
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <8a60f581-0ab5-4d98-a97d-dd83b605008f@gmail.com>
Content-Language: en-US
In-Reply-To: <8a60f581-0ab5-4d98-a97d-dd83b605008f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Some users want to plug two identical USB devices at the same time.
This static variable could theoretically cause them to use incorrect
TX power values.

Move the variable to the caller and pass a pointer to it to
rtw8821c_set_tx_power_index_by_rate().

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index eb7e34c545d0..cc152248407c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -680,11 +680,11 @@ static void query_phy_status(struct rtw_dev *rtwdev, u8 *phy_status,
 }
 
 static void
-rtw8821c_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
+rtw8821c_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path,
+				    u8 rs, u32 *phy_pwr_idx)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	static const u32 offset_txagc[2] = {0x1d00, 0x1d80};
-	static u32 phy_pwr_idx;
 	u8 rate, rate_idx, pwr_index, shift;
 	int j;
 
@@ -692,12 +692,12 @@ rtw8821c_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
 		rate = rtw_rate_section[rs][j];
 		pwr_index = hal->tx_pwr_tbl[path][rate];
 		shift = rate & 0x3;
-		phy_pwr_idx |= ((u32)pwr_index << (shift * 8));
+		*phy_pwr_idx |= ((u32)pwr_index << (shift * 8));
 		if (shift == 0x3 || rate == DESC_RATEVHT1SS_MCS9) {
 			rate_idx = rate & 0xfc;
 			rtw_write32(rtwdev, offset_txagc[path] + rate_idx,
-				    phy_pwr_idx);
-			phy_pwr_idx = 0;
+				    *phy_pwr_idx);
+			*phy_pwr_idx = 0;
 		}
 	}
 }
@@ -705,6 +705,7 @@ rtw8821c_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
 static void rtw8821c_set_tx_power_index(struct rtw_dev *rtwdev)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
+	u32 phy_pwr_idx = 0;
 	int rs, path;
 
 	for (path = 0; path < hal->rf_path_num; path++) {
@@ -712,7 +713,8 @@ static void rtw8821c_set_tx_power_index(struct rtw_dev *rtwdev)
 			if (rs == RTW_RATE_SECTION_HT_2S ||
 			    rs == RTW_RATE_SECTION_VHT_2S)
 				continue;
-			rtw8821c_set_tx_power_index_by_rate(rtwdev, path, rs);
+			rtw8821c_set_tx_power_index_by_rate(rtwdev, path, rs,
+							    &phy_pwr_idx);
 		}
 	}
 }
-- 
2.48.1


