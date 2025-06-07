Return-Path: <linux-wireless+bounces-23827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9E0AD0ED2
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 20:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BD93A7428
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 18:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D422F14E2F2;
	Sat,  7 Jun 2025 18:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCahJTBT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8402F2E
	for <linux-wireless@vger.kernel.org>; Sat,  7 Jun 2025 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749319305; cv=none; b=HnBNzFMheS/8VcKnHo4U5N6XWnll37nipzeHxsWJHTwdV28p8Odd3Ul4uSUddeaqBmt/LS6Y4Vrw73Zj3EvW6XynDqdJk1eWBxverX0amuekDo1XPQrt6jkK/KbPHQyhmXrgloSWHW9Au/6DgiitfVE9Qy73Gj5q5hgn3QtpA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749319305; c=relaxed/simple;
	bh=4i6THDKe8QkinOFpCv9xcc3qkN4+hzC9yDG1Xvixbv0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IrXfojNXkBKBMCSFlaJjIcPC/1RACs8VKXTHQCwzZ/NopvwAFDxWb+gEBToVhtp1Oo4Pp4iEwuIPt8+pk7+3PDuNB5LyLv8WVTK//DcTSXA1KOBgIOYjm7SEUGaretY73Z5cxPkWPrpKHONIZhmlfCdw8tG9YO2s+CgJgdir4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCahJTBT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so3091214a12.3
        for <linux-wireless@vger.kernel.org>; Sat, 07 Jun 2025 11:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749319302; x=1749924102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5ieoGh2KX10s1vY4/EN199ENGnPVLeFo5RJKP4dQzRw=;
        b=NCahJTBTA4hC8G6ZDgWIUh2jL3FJa2W2BX7vGS5AF6AHZ/hyVrVq3JtZl2TamlkdPn
         eBbpowwcLKSToo0MhubHfYY468yvDyazsb5Nwd+lEN23bH4aydzPzhr87ru6mbQqbzMh
         F/B/nzojcTDa6DGpvwIJTywKQfdkAy47N9EHHOGbnDm7ivAniCMfH2WhJBmUJ0wilSht
         ePYuVqjRR59kJBYMMaP3yHmXXDxcBXSVKWRLkw8wEeHGukaY6/Jn33wyYIfNoGKf1Ll8
         EAF/8a40An3VOqipPJAlDywa+xlLTzezfAdgKhpOw3JL2BDNJLZ+B1naA6Frf1LCw3DL
         H7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749319302; x=1749924102;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ieoGh2KX10s1vY4/EN199ENGnPVLeFo5RJKP4dQzRw=;
        b=kWgiwGbpi0bloNSCvPMjeUhEbKn+RtYQFmpi8cNhSzTja0EZ2UG+I3g61tC51PmGgk
         /GtAHxT1prEpl+QaRECKiZiGhHvma7W/nZYYTt0X4dNE0ShmxbKjWL6S0ij/LLTLHJDk
         I2DRk6LiiQEdiG4sxgfsZuSfwPVFXI0hPQ0qiJmYFWeutEO2OGnYvihd4IMNQGUF4Clq
         lXkI2/EIhKNReTdzDOkU72kv3Pcpb5KMdNyptRduulqBnyXf4ujKr6tWzJ8EwBeCwmKr
         DO4GC4KSxbXD5jSxQ+lfHw31sEsjrae+fpfFeRrPhudZg+E2eLoq8rILV2uDAxGz3ORU
         93lw==
X-Gm-Message-State: AOJu0Yxqb3EuCO/ttdxpZzbh4bgMahtWmGSG7kYXNOcMZZPF2v22x/h3
	y7VO9ziyxcfqcKZYu72pUbMHNasuFTug7e9lyt6daWigSoNU7h9/bSBgTaBKhg==
X-Gm-Gg: ASbGncvf8zUUF+qBwDOLhHsQovqmRQ0bZVSfAHLSCefCTuY9M1KBf8Y5qM0yVRro8io
	Hk0cRlBUH75aAJFiXDv4Nmo/1pqAJJva0xRJWHDjienC8/x8ZN7/rQBLvVF/jYyoI7FE9DMaVBL
	yFC40MTLqWy/HMSUpVeQ9oUxFdODLGYyQjmq6xRZdMxgLxd7KSkQgm7QAjXDcIgIPARzbHKUjSY
	on1eV2Lfr5ES2da9KUKhAA/LU3P8BwFmwrgolfdgozhBYxFC7bdqPVU5u7lPR08Cy0BHasJry8E
	gCYAIY34TUp06VA86IQzy9e6FwILbHkg71aqpL5RzU7l2grFT3TnlWnRJUrayn/4ilNRsJgQo1E
	R871t
X-Google-Smtp-Source: AGHT+IHEI15AAQ/P1GLBdtcRBjMqtPnwzSBcKnciLkXTCORfx4B92uoyJSeXEqkQdnLnAjCkj8xpAA==
X-Received: by 2002:a05:6402:2696:b0:602:a0:1f3a with SMTP id 4fb4d7f45d1cf-60773514055mr7099030a12.13.1749319302100;
        Sat, 07 Jun 2025 11:01:42 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783decafsm2576107a12.65.2025.06.07.11.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jun 2025 11:01:40 -0700 (PDT)
Message-ID: <5ac60c1c-9cc8-41b8-871c-a067e74f70ea@gmail.com>
Date: Sat, 7 Jun 2025 21:01:38 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 2/2] wifi: rtw88: Enable AP and adhoc modes for SDIO
 again
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <bfb1099c-db52-4b25-b111-17ab712e9404@gmail.com>
Content-Language: en-US
In-Reply-To: <bfb1099c-db52-4b25-b111-17ab712e9404@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

AP mode can be enabled again for SDIO now that the problem was fixed
in commit b2effcdc2379 ("wifi: rtw88: sdio: map mgmt frames to queue
TX_DESC_QSEL_MGMT") and fc5f5a0ec463 ("wifi: rtw88: sdio: call
rtw_sdio_indicate_tx_status unconditionally").

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 88ff3edeaf47..781b6c113c62 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2218,7 +2218,6 @@ EXPORT_SYMBOL(rtw_core_deinit);
 
 int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 {
-	bool sta_mode_only = rtwdev->hci.type == RTW_HCI_TYPE_SDIO;
 	struct rtw_hal *hal = &rtwdev->hal;
 	int max_tx_headroom = 0;
 	int ret;
@@ -2248,12 +2247,9 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, TX_AMSDU);
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 
-	if (sta_mode_only)
-		hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
-	else
-		hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
-					     BIT(NL80211_IFTYPE_AP) |
-					     BIT(NL80211_IFTYPE_ADHOC);
+	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
+				     BIT(NL80211_IFTYPE_AP) |
+				     BIT(NL80211_IFTYPE_ADHOC);
 	hw->wiphy->available_antennas_tx = hal->antenna_tx;
 	hw->wiphy->available_antennas_rx = hal->antenna_rx;
 
@@ -2264,7 +2260,7 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 	hw->wiphy->max_scan_ssids = RTW_SCAN_MAX_SSIDS;
 	hw->wiphy->max_scan_ie_len = rtw_get_max_scan_ie_len(rtwdev);
 
-	if (!sta_mode_only && rtwdev->chip->id == RTW_CHIP_TYPE_8822C) {
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8822C) {
 		hw->wiphy->iface_combinations = rtw_iface_combs;
 		hw->wiphy->n_iface_combinations = ARRAY_SIZE(rtw_iface_combs);
 	}
-- 
2.49.0


