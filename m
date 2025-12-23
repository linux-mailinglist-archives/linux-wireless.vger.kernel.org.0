Return-Path: <linux-wireless+bounces-30097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B515ECDAD56
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Dec 2025 00:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 780223022F24
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 23:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A4B27FD71;
	Tue, 23 Dec 2025 23:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY8s++sc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF80289378
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 23:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766532338; cv=none; b=trtk1XKl4eZzvF4kDua+JgdwXXlgZPt1P7s+XebEG2u1fbTNyzHqDaNmYVcyOjcppczS7AgnOrRVNUHdEOCrKOAdymQdlo4S2v+QxoZtsbhGiW35QWj4ziCU/EAoe+Ca1zhB5SyRjdYXkPsPIx/VjU7iXGeWdR4Y30QvrGYTJP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766532338; c=relaxed/simple;
	bh=M89RSQqXAFxpqcM0UUeTo1CqIK4+dvYCEs+yrpFUN+k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YUoiaT0CC99h7S6DL1fD1AmTXQi3tLDacb9yWkLorFe+BSz8H434XC5cXX2la+nmrQsi6M1h5SmfHYWblvQTpnfZC8Ac7sG85CaNBfc9QeVowLOn+11HNdsoYl7vSjCUDCRsnWc415pWo7/ozi3sajLC9kq56LB8dU4kqdjqbl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY8s++sc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47a80d4a065so28421945e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 15:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766532335; x=1767137135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hSso1vLweZxLaNEwNsTPsmk319MKQZdNmaseBd+DM3A=;
        b=TY8s++scEeu5659o9BhJmvjtXpPLJ02MkAXNoB3lO8zgXw0s33Z07f0akF2m6/08Sc
         T6mCJ9BA/dWTl9LseXU7TzDweYOfKeAWP8seBPFh+hZwdpzMZxWfcz8Z0FdtQA6G1MVT
         x622k8SkKW+3WfcDRW4q5eJO3WWG8EJaGwfIv+o/5Bufm2zCIeD24eAa8WRHFRivS2zK
         bDQOaczMs0EjttOKJOXSPkhR0N7Di02HYbeoPBE0XZ57wSFcl1OMFCImOo8BoEcZ6Ybe
         DMHwURBV+P34FOyGK77Uk/HlOJf3qNSQa+xZ1s1ycgkYzWtzkAfWkiJr2CSu089S+OzJ
         78Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766532335; x=1767137135;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSso1vLweZxLaNEwNsTPsmk319MKQZdNmaseBd+DM3A=;
        b=J66+aL4PCSSZlRfeSeJHEtgOmbMOWCmOalZXiKaNLX4qn5/V6lbrSRmbSITDevhn0d
         WluNtX2I5HHS17U9HeqT3P2nXQCNMOMKvhQb5gJnpken4u+GTt0YXOCtkZsutRGB8M6N
         mW+rKEw+yehzK+JkmnslpQBGOlh2iYk9g8mAH/ncG6TuXEEr9GAHJdE/myGjV4JZkkwG
         9d7s1nlTH6YyVxCQNoKf1jYLw6Bkc0saZ2RMS047ZMkAF6tf844fC59h7nqEyVlw6ZpV
         TxFt5+uSqwAxvTH8IpeO0+nY6ostQUOktr8kZsKEYtFQ1vYRqbzbSXnxPKHga78A8VxB
         uFIw==
X-Gm-Message-State: AOJu0YxH1ngRImwkmVY1SP8AQ8d/9OGN0xBJo+8juTx/RwRtqcXXvV4k
	DpHsrFKAtQf6sc1C0xnAsFUayU9IU1s6wUAnktgCrqx6ReORCAMn10lI+rI5GQ==
X-Gm-Gg: AY/fxX7c4BWY5BerH1ybnW67yZOkUVViXIY93s1uKt7NusJdf8SKUEKL2GsJdjLCyVA
	AZiJp2UujTPZa1hOYJxd/OFAs3uv3QcQLDdcfqwcvny6DjNOHQvT2s4NnFCKa9NFcR0PnNrVNdB
	STndNbl6l541M9281rx9if8Q36Yd7WSJPL9UgIJcv5MFBg2xNsIeFd4xdb7lZHVMe/mjcqKflV1
	kpEBYsHQGSpmdRhyVaBtl7BjBF/lFS7FTau6gL5bBZen6g+pOf2QDio1sAaQ7ADQk8tIba0QdUj
	ItfVmSqzukKbLJVUz6qum+M2Nez8+FePAN0UUt2a5FiW1seQ45yz0KV1GF1NvnV4XCOArkpRYFW
	yV3Fnz0XRZfKyfZAngvE4BUXRzYdu77o+Bh3dG9+NO2MdUte4sEvxa6YSsAxQH1uH3W/I0fqKtn
	L2foI7RO9jWyj8zUIEiRCMV2he0cI+1/I=
X-Google-Smtp-Source: AGHT+IEGZss6Wlm6jfhqh6gTGKNv/jMksmtquHfP4qALUzOy/MFp5KxUevvEDsVW5rxcKrtxoDoTqw==
X-Received: by 2002:a05:6000:1866:b0:431:8f8:7f19 with SMTP id ffacd0b85a97d-4324e50b8f2mr18793035f8f.47.1766532334491;
        Tue, 23 Dec 2025 15:25:34 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea2278dsm30906580f8f.18.2025.12.23.15.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 15:25:34 -0800 (PST)
Message-ID: <1aa7fdef-2d5b-4a31-a4e9-fac8257ed30d@gmail.com>
Date: Wed, 24 Dec 2025 01:25:32 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 2/3] wifi: rtw88: Use devm_kmemdup() in
 rtw_set_supported_band()
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6345300d-8c93-464c-9b05-d0d9af3c97ad@gmail.com>
Content-Language: en-US
In-Reply-To: <6345300d-8c93-464c-9b05-d0d9af3c97ad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Simplify the code by using device managed memory allocations.

This also fixes a memory leak in rtw_register_hw(). The supported bands
were not freed in the error path.

Copied from commit 145df52a8671 ("wifi: rtw89: Convert
rtw89_core_set_supported_band to use devm_*").

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 9470042b12a8..46af5bcbb8bc 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1664,11 +1664,13 @@ static u16 rtw_get_max_scan_ie_len(struct rtw_dev *rtwdev)
 static void rtw_set_supported_band(struct ieee80211_hw *hw,
 				   const struct rtw_chip_info *chip)
 {
-	struct rtw_dev *rtwdev = hw->priv;
 	struct ieee80211_supported_band *sband;
+	struct rtw_dev *rtwdev = hw->priv;
+	struct device *dev = rtwdev->dev;
 
 	if (chip->band & RTW_BAND_2G) {
-		sband = kmemdup(&rtw_band_2ghz, sizeof(*sband), GFP_KERNEL);
+		sband = devm_kmemdup(dev, &rtw_band_2ghz, sizeof(*sband),
+				     GFP_KERNEL);
 		if (!sband)
 			goto err_out;
 		if (chip->ht_supported)
@@ -1677,7 +1679,8 @@ static void rtw_set_supported_band(struct ieee80211_hw *hw,
 	}
 
 	if (chip->band & RTW_BAND_5G) {
-		sband = kmemdup(&rtw_band_5ghz, sizeof(*sband), GFP_KERNEL);
+		sband = devm_kmemdup(dev, &rtw_band_5ghz, sizeof(*sband),
+				     GFP_KERNEL);
 		if (!sband)
 			goto err_out;
 		if (chip->ht_supported)
@@ -1693,13 +1696,6 @@ static void rtw_set_supported_band(struct ieee80211_hw *hw,
 	rtw_err(rtwdev, "failed to set supported band\n");
 }
 
-static void rtw_unset_supported_band(struct ieee80211_hw *hw,
-				     const struct rtw_chip_info *chip)
-{
-	kfree(hw->wiphy->bands[NL80211_BAND_2GHZ]);
-	kfree(hw->wiphy->bands[NL80211_BAND_5GHZ]);
-}
-
 static void rtw_vif_smps_iter(void *data, u8 *mac,
 			      struct ieee80211_vif *vif)
 {
@@ -2323,10 +2319,7 @@ EXPORT_SYMBOL(rtw_register_hw);
 
 void rtw_unregister_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 {
-	const struct rtw_chip_info *chip = rtwdev->chip;
-
 	ieee80211_unregister_hw(hw);
-	rtw_unset_supported_band(hw, chip);
 	rtw_debugfs_deinit(rtwdev);
 	rtw_led_deinit(rtwdev);
 }
-- 
2.51.1


