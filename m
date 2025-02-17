Return-Path: <linux-wireless+bounces-19079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FCFA38FA2
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 00:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407283A1DCD
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 23:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A6F1A5B83;
	Mon, 17 Feb 2025 23:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1pDD2ZT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0787015666D
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739835054; cv=none; b=ljrCIEK9O2A9ei42viYbLee1jyPDm+UGv/S4pAevcfHUDeRHKZmJE5hXzYxOD/51BbpiE2oAHgGP5k9eSzJnX0XSwnXncaZxT6h9to36YD/+k4qRn0cVoX8zlGbE0Kmg2fbWvffBl/EBwASDoY4dzTqSXCDanZ5xAJCoGiEbpBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739835054; c=relaxed/simple;
	bh=i508IQ9BIulfXt0/xMP6knSCCB2j1mSPLSL6LM2R8Uw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RgT7cKaUqZdIln2XilUPGYskhKRXLpNducId9AdHS6Orwuzd60ltUAUddDAEusamIjTMOUg93qxdYMKFLvwpQx6IoYl1Zp+7mUzXjNqsTMkbZq79onJuzeu3aMbdJxIxj3oGPn9NIi+wvO7utL6LeNIXmVzraw0OJDCv+kjZRqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1pDD2ZT; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso9031140a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 15:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739835051; x=1740439851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j9+0WbLdJmq9JwU/NA/F6n/jrHoGCq84n462D9F9BKE=;
        b=m1pDD2ZTxMF/XnOoSubrd1Vm4BhoetI16v+orKQIi9pkOcYJItyagrLxfbb9Q8KsEl
         hj8W5Y6PAVmDK/R4bhWVMZqcQ/U2bba7Yk64vWiJ/dsYQ4hJTQRWPCYgwg/esoB3v5vo
         RUNBzpu1WtZRDwRKP78OuCgsuPWyJ4uwWxDIwQZq37eWkUqqdorAkBuNMWWQJI1cw2Z2
         VJ1ZfnqJJt2zhqqI6tP2IX6jEckWncak76v083u5OCRXxk+pwUMF+XYGm0lnAkJmzVgb
         DB2ra2sxMapShKI5KRS9yacoeR9agoX/BWg4kkhJnManJmBdcoYHHnoPfe9QQWN/kkUN
         Zz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739835051; x=1740439851;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9+0WbLdJmq9JwU/NA/F6n/jrHoGCq84n462D9F9BKE=;
        b=ZRbAZWD6258T5jcicb2UgGhvh+w5maPnOfBDyE3hr7lbXDbMz4rF9Jce+2uCk7ION9
         rsTrem5Tv0C7+RWEFm/hqSCnqFbH1CwH5ZCe5TAnq1bTU8eCZ8dJkLoUpy94yIvcB5CK
         kV7XdPrWc1lJSc/Z5aErgT6HIdCRba+LLacwqrKIg/k3qSHU6zxCakWcyETnnvQcwIbe
         XLIU4vdHO9z+pBLOrwjY+b4U2wbxIonsS5M+GyATKfoDeuBKfi6rpwLe7u82IyDsvuwH
         ehEwKX7AEzSvQygl83TWpXRx82kdRpKH2IL3fWUpq4ytDr7umzQNPCiVR7vVlXLFbgth
         a/QQ==
X-Gm-Message-State: AOJu0YwX696dnMEjyU9YDc4FDYtgHjrNn83wP2nYYL8VDosHENWoWkFi
	oqeZoJvBLezS7Bwc8bCgBvkssYVsZnDmWWKaS7It4vphX49vUG7ss/IvfQ==
X-Gm-Gg: ASbGncuwb5sbhGv2uDLzp2voU+FoPVgz7UrIPahkGY0vQwZlpFHJG88ChoQIbVhFxIH
	SUPDIvA/NouWLlxAN5PK3jU5llayc2dxWmj99C86leU0+Doe35SmAIce83Iz3xR+X0FhkgF3mL8
	YkehQjj9k09L2vQamKBEsATmUO2/q0VGG4aN6RnHwXK9HYBmvCJF8kp4r59mxllYWutPkgLOwQB
	U9qCx9jD/EL0bLsMyq7AGgpEYcZgdIWVej4UzNGwT4Yx1YzRB3/+wbGmU4H/h7tK8HxywMj/dee
	OSXSHoSglnrwpFrgKqnopOt8
X-Google-Smtp-Source: AGHT+IFNPqx3skx+PUSf59DLKdKTAC5aw6OohH8Ht88WNibhDLpybP87ixEM6c5ckXPEMBtWwjU8QA==
X-Received: by 2002:a05:6402:2114:b0:5da:b64:e5d4 with SMTP id 4fb4d7f45d1cf-5e0361ca74fmr10449718a12.25.1739835051034;
        Mon, 17 Feb 2025 15:30:51 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270b17sm7805694a12.62.2025.02.17.15.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 15:30:50 -0800 (PST)
Message-ID: <e86aa009-b5bf-4b3a-8112-ea5e3cd49465@gmail.com>
Date: Tue, 18 Feb 2025 01:30:48 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 4/8] wifi: rtw88: Fix rtw_init_vht_cap() for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
Content-Language: en-US
In-Reply-To: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Set the MCS maps and the highest rates according to the number of
spatial streams the chip has. For RTL8814AU that is 3.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.

v3:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/main.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 3319bb5044c3..959f56a3cc1a 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1596,8 +1596,9 @@ static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
 			     struct ieee80211_sta_vht_cap *vht_cap)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	u16 mcs_map;
+	u16 mcs_map = 0;
 	__le16 highest;
+	int i;
 
 	if (efuse->hw_cap.ptcl != EFUSE_HW_CAP_IGNORE &&
 	    efuse->hw_cap.ptcl != EFUSE_HW_CAP_PTCL_VHT)
@@ -1620,21 +1621,15 @@ static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
 	if (rtw_chip_has_rx_ldpc(rtwdev))
 		vht_cap->cap |= IEEE80211_VHT_CAP_RXLDPC;
 
-	mcs_map = IEEE80211_VHT_MCS_SUPPORT_0_9 << 0 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 4 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 6 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 8 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 10 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 12 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 14;
-	if (efuse->hw_cap.nss > 1) {
-		highest = cpu_to_le16(780);
-		mcs_map |= IEEE80211_VHT_MCS_SUPPORT_0_9 << 2;
-	} else {
-		highest = cpu_to_le16(390);
-		mcs_map |= IEEE80211_VHT_MCS_NOT_SUPPORTED << 2;
+	for (i = 0; i < 8; i++) {
+		if (i < efuse->hw_cap.nss)
+			mcs_map |= IEEE80211_VHT_MCS_SUPPORT_0_9 << (i * 2);
+		else
+			mcs_map |= IEEE80211_VHT_MCS_NOT_SUPPORTED << (i * 2);
 	}
 
+	highest = cpu_to_le16(390 * efuse->hw_cap.nss);
+
 	vht_cap->vht_mcs.rx_mcs_map = cpu_to_le16(mcs_map);
 	vht_cap->vht_mcs.tx_mcs_map = cpu_to_le16(mcs_map);
 	vht_cap->vht_mcs.rx_highest = highest;
-- 
2.48.1


