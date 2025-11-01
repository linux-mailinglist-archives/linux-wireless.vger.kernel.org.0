Return-Path: <linux-wireless+bounces-28466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77882C2864D
	for <lists+linux-wireless@lfdr.de>; Sat, 01 Nov 2025 20:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7475918922D9
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Nov 2025 19:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41222FF678;
	Sat,  1 Nov 2025 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njKyFHux"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1176B2FC86B
	for <linux-wireless@vger.kernel.org>; Sat,  1 Nov 2025 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762025234; cv=none; b=TCpK25GAw3bz85/hoNn1FaU4o68P2M23TLfo7dJ969sUKjdhJniTBJu7z4qJnb93ixMyA5AfgE+ZvcbOCoAH2YDJJdc9srOyVuOsQMbQ3mDSzRejYLj9hN2eGvToFj0BiN+0JUDv42gaViKo35aTNMSDdI1p/bZb90FGQ0ihYmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762025234; c=relaxed/simple;
	bh=Suxt249Jel700FCiuN9qWTxzeYVPJdMkv6nX2Trzblw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dADFh5Shhtr7XPRRhUMcZdHVkPYg2ZwhtouhhEBq70/VgR6B8zKADDVgCWgRmbWcTnZeVoAQkLzzMcOvnk+0D+hOHEWP9cwpl0H5iMhOJadlxeYtUlGR8D8MyL1kjIlBl8gqMXKUt1Pfiw+pRcvOUJtF9DFb4hoNEDYKR56pN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njKyFHux; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429c2f6a580so1327615f8f.1
        for <linux-wireless@vger.kernel.org>; Sat, 01 Nov 2025 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762025231; x=1762630031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tbAMSIxPUFNaZfeuYQhRw79ZTQhMaCBk53c6BXDwOVQ=;
        b=njKyFHuxu/y89s297bDeTrbfFTldp6eSLROi7Kjq0HDWtb2KxQ0Fj8wqj+fEPeXtyo
         z+d5BJr1oTVhmrp7h8sYiWWHkoijUqP9pPO8C2kMe7ziU3TMYyeKN9tgXJMbYTnhPU+E
         j14eXopE/EXU9BD/m1WrOWVNOds38OPZgncdlz3nkBUM9wUqP9tV0Al6UCpS0Cxlbvm+
         jpHzQkzULdMmt4tr/Yjcnc59MNz96AA9luGovMKjgrA9My05SmfeFrZnJ3WU30PZEG6k
         7HYM7yx+6xB6s1DLo0enOc4GMpxLUBCbWh57OBdj8dfeKal14TbjnaL+wIygCZ3Kvh+j
         gHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762025231; x=1762630031;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbAMSIxPUFNaZfeuYQhRw79ZTQhMaCBk53c6BXDwOVQ=;
        b=IF//gX49mqfgcdE0yDJxOZOYCpC6aTUkOGvT2CIF/Ydd28h8ncZD+hyNuahIopRT5X
         6dqDoX0qEPql1hplYnWBrbf1grm8O2eQ1ZvxCwmbytfQJAfmMZiNogGxY1eUUI7HP2XC
         w7qQNqHwlDYCk1xiSznl8/uuAyrEJzOcxv6WBpwd468xgZeUR4deu2qmz+wGGH/hnrqR
         1/zhun+ZuklzNEmdb/WnFrWCECXOwQ33LWC6Y+IHIkmfBlhv962WRnDPfR9eMzciEZtX
         u/tujiaNpndj2tVkIcLCmro+MAyY3aPc/1IDxNMHsAtxz5293zFQxCQ2JqX2DNKlONjU
         191Q==
X-Gm-Message-State: AOJu0YyOcVKaNHAFijvK1W86JHfs3sg+KsVN9j6N5IX71pI00ISwaYzL
	ojqlOdnywcOypk/WyMl1vEC5cG1VglhKJCIRHtjGTbY4cCEA/QrYKqqeb2fq3A==
X-Gm-Gg: ASbGncuQQaKOE7tLpFSMCp5P/4pjwNp/B7xTDtqaU+MYdhWzwtXrYok49e1PixxR9N+
	MKCiKQpCb+F8E3oQn8wccyH7kaghji9ISwAVvcutnQqcrWHiM2Vd81OXgj+3UzzEvEoCoh/2PDB
	Kt3KI1GoM8GRCDXLmD4s6hl0+RkuOXZg31o/vIZR6/aS5/oXgQB3DOzglj8KhQUiFqO4ccdu+eJ
	wACBdKNfk73mXi8Xpco9Kd+MG5iL5g+Lzylby5Y9xQ7KMZEiI0THf6vDxZ6N72IlW2gURrJ3Ma9
	kmE4SPAV5Uxvr9byANvD9dnPdGcB+Q/CchztxJhYXWg7HoNow+Dwi1r0osrgSoR5HfM+RhCvJsc
	ZyTzJRQmEEAhE5dvLdSudSiorLB9Y+uToM2y/jRl62M3ONt3vjOsvWm15tMeTDeRM6QnkwGncDh
	CtK+UEi3kS
X-Google-Smtp-Source: AGHT+IGVdvLZ3fLJcwrTDUkkAm0g3QZvpqsLkKE/aOZagwE8FYB6NUIIkxClTb/Iufk/C/Oa6kPrVg==
X-Received: by 2002:a05:6000:25c2:b0:429:b718:167c with SMTP id ffacd0b85a97d-429bd68847fmr6025524f8f.28.1762025231371;
        Sat, 01 Nov 2025 12:27:11 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c102dfd2sm10612290f8f.0.2025.11.01.12.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 12:27:11 -0700 (PDT)
Message-ID: <78138507-99ea-4a58-a02b-f4d11dbfba3b@gmail.com>
Date: Sat, 1 Nov 2025 21:27:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 10/12] wifi: rtw89: 8852c: Accept USB devices and
 load their MAC address
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Language: en-US
In-Reply-To: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make rtw8852c_read_efuse() accept USB devices and load the MAC
address from the correct offset.

Also fix the offset of the MAC address because it was wrong.

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
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 16 +++++++---------
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |  2 +-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 10e3963b692c..8550ae3bcb64 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -480,14 +480,6 @@ static int rtw8852c_pwr_off_func(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static void rtw8852c_e_efuse_parsing(struct rtw89_efuse *efuse,
-				     struct rtw8852c_efuse *map)
-{
-	ether_addr_copy(efuse->addr, map->e.mac_addr);
-	efuse->rfe_type = map->rfe_type;
-	efuse->xtal_cap = map->xtal_k;
-}
-
 static void rtw8852c_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
 					struct rtw8852c_efuse *map)
 {
@@ -596,12 +588,18 @@ static int rtw8852c_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 
 	switch (rtwdev->hci.type) {
 	case RTW89_HCI_TYPE_PCIE:
-		rtw8852c_e_efuse_parsing(efuse, map);
+		ether_addr_copy(efuse->addr, map->e.mac_addr);
+		break;
+	case RTW89_HCI_TYPE_USB:
+		ether_addr_copy(efuse->addr, map->u.mac_addr);
 		break;
 	default:
 		return -ENOTSUPP;
 	}
 
+	efuse->rfe_type = map->rfe_type;
+	efuse->xtal_cap = map->xtal_k;
+
 	rtw89_info(rtwdev, "chip rfe_type is %d\n", efuse->rfe_type);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.h b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
index 77b05daedd10..8585921ac6c4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
@@ -11,7 +11,7 @@
 #define BB_PATH_NUM_8852C 2
 
 struct rtw8852c_u_efuse {
-	u8 rsvd[0x38];
+	u8 rsvd[0x88];
 	u8 mac_addr[ETH_ALEN];
 };
 
-- 
2.51.1


