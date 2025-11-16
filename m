Return-Path: <linux-wireless+bounces-29008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DC2C61C56
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Nov 2025 21:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 515A64E2580
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Nov 2025 20:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31CC1465B4;
	Sun, 16 Nov 2025 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWhNmih5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0728D2940D
	for <linux-wireless@vger.kernel.org>; Sun, 16 Nov 2025 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763325107; cv=none; b=Rma9qKHyQ7l23c74bkLOF///aWmSsH0IvkvrqMccNwmGnbuduWLp4uRI9VsC4ha9tRe/vpnaAZY+jM11IwZguqrIi5Z3DSlV7/8xaCY15xxJ8eoYiK4sJRycNr2KrcIp13j/5jHAJJND5/zWGnOlVLLfAHYwjDJip3aBIW1J2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763325107; c=relaxed/simple;
	bh=uakwij2hi7o5SOb34Bw7TfQdWHD6BXj8w0sv/dvefXg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BiIYN/c8jZd8CrAVrzghYykir8pbRfttQIkwYTvuVRVHyxMEmBdXirgmgOtXj+GWL8GbW1mhukedTTCkEtC4s/kr2M/mnoCAG+pOtitRD7A5l9mVLaQRiogSPFQzoZNjsZz7iA340e6MoirLI1F3aEIuEj75UTYuVSctGNC3AKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWhNmih5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso6269725e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 16 Nov 2025 12:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763325104; x=1763929904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=epulH580bxtxdv4mFEtU33BuMgFGQ5tMkHFAdouZB7s=;
        b=YWhNmih5OhjGn55zVhCcBFf3tQx+blbmbxGTSAP3aqTBTvPwxYWvVl32QxoX+Z3eFF
         nkat1dCj6JxqaWoiEFWvNubqXPdQsOBZpQEkqJoCd4XGlWbspn1rSCGgZyg9T6RawRYV
         aZVyqGzdNepEagSVjzYYvl5ZxBaoPdedQV5wL1/nPMaB8MpOw7n8yyWIVllIi6X1yzwN
         Nafx658nCYYFRQsRSyrQz42nUTqD0jy3vFWEhG06HVBoQ3ee6PEr2SWo9ZBpY06NsKYA
         ylwbbKCFN4GMRdy0EBaOLJjBgxCnKavE/78EEt0b2b4i3gCpnwRcJAFqgOI36DFLvbD5
         N09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763325104; x=1763929904;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=epulH580bxtxdv4mFEtU33BuMgFGQ5tMkHFAdouZB7s=;
        b=YgIF3mqtm9h9r8z93oltH3Mh8RlME1lR2BUui1qxrwC4hx3Lw4IM9uBfA8g9KIAPuG
         jrXkBLLVicOFy7bJHhBbWXNYHlvsisgRQ+cnnVh4RNJU2WqnlMvrBcDeAvBKBCJi15OE
         r208UYmElCJbHa7ZoETMlR/NhPtC918RFoht7dHRziG4E0T+Vnytv4+WmiGRbMvPJ94E
         o/QQXkvggXOKoGHcXbpa1VEZFmDvcgZVU+wCMv+Ke4/icHBkgbkA6EhusiOWJ/ufAO2i
         IC3n6ss0wPtuXRTzjXBGhD4JM9hXJuslVKsxi+Y48Pt47u90dZYCXqszvb97RnTDlut7
         TAAw==
X-Gm-Message-State: AOJu0Yz0v0o5I+OX5UoZt7yieI9TMNs7bNRjUP9WcwBf21IEgpqTvOmi
	wiN8AtcEFPMU9Ne7B7Yomgdhth6dh8b/W9KUmKq1u9QR4unPlloeXYRjAzPjNA==
X-Gm-Gg: ASbGncvt7BILGGlKVNL19Sq9BHoe9YNzMyRW/b2TKdHFrPaRTPVvGNfTSVc9qtkx+zy
	O88vLaxYPjnqSaItbR44k7XXHvVJ99lhOIHhAo1x8AQ/5QWe2pNuDrrKf4N/2yUXBk3Q/akc9OG
	VqBY9UC9mYDLnWMfG0s4nUfiNvlg86yV68O2OU/2C53Em1OmVuQFD5yKtkT8XVgoe8N+596jtZD
	yDeqo7+9Sv8ncQk16Vqwfa4EHwcGXP/ow8Zktxom3ZQmTpBUIn1hFJPRA8dgaSOr/kLCOJS6EnO
	+8HQYDMPGdP8tVDxV9X/JVNQEfYYSZYbjSpiYy+2zPDKmLLfekXpwE4pIaC3/yBatfWDfghQ94D
	m2HEHSkvChE3YI0yg0wCL3QXAi33RqkKLcVxiMhON4JtCAh2WZpohmM0qTzHvuSk45o/XwIbYYu
	4xrt4fpzug/bk3B/WNjU0=
X-Google-Smtp-Source: AGHT+IEX+NlBDFOdqlw7urwwUyYSgX602KkH93FIuJssmS1tudLH4oieX+eSWq2jHROc2q1OreGRug==
X-Received: by 2002:a05:6000:4006:b0:428:56ed:c68e with SMTP id ffacd0b85a97d-42b527bdb18mr13877109f8f.9.1763325104005;
        Sun, 16 Nov 2025 12:31:44 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e846afsm22540930f8f.13.2025.11.16.12.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Nov 2025 12:31:43 -0800 (PST)
Message-ID: <5000a39b-0d0b-4625-aafb-be6fc668d6cd@gmail.com>
Date: Sun, 16 Nov 2025 22:31:42 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 5/5] wifi: rtl8xxxu: Enable 40 MHz width by default
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
References: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
Content-Language: en-US
In-Reply-To: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

40 MHz support is hidden behind the ht40_2g module parameter with
this comment:

/*
 * Some APs will negotiate HT20_40 in a noisy environment leading
 * to miserable performance. Rather than defaulting to this, only
 * enable it if explicitly requested at module load time.
 */

This parameter was added in commit 26f1fad29ad9 ("New driver:
rtl8xxxu (mac80211)"). Back then rtl8xxxu only supported RTL8723AU
and the RTL8192CU family. It's entirely possible the miserable
performance was due to mistakes in the channel switching function,
which were fixed in a previous patch.

Delete the ht40_2g module parameter. If someone still needs to
disable 40 MHz support, cfg80211 has the module parameter
cfg80211_disable_40mhz_24ghz. That works too.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 668018229f7c..12935b196520 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -20,7 +20,6 @@
 #define DRIVER_NAME "rtl8xxxu"
 
 int rtl8xxxu_debug;
-static bool rtl8xxxu_ht40_2g;
 static bool rtl8xxxu_dma_aggregation;
 static int rtl8xxxu_dma_agg_timeout = -1;
 static int rtl8xxxu_dma_agg_pages = -1;
@@ -45,8 +44,6 @@ MODULE_FIRMWARE("rtlwifi/rtl8192fufw.bin");
 
 module_param_named(debug, rtl8xxxu_debug, int, 0600);
 MODULE_PARM_DESC(debug, "Set debug mask");
-module_param_named(ht40_2g, rtl8xxxu_ht40_2g, bool, 0600);
-MODULE_PARM_DESC(ht40_2g, "Enable HT40 support on the 2.4GHz band");
 module_param_named(dma_aggregation, rtl8xxxu_dma_aggregation, bool, 0600);
 MODULE_PARM_DESC(dma_aggregation, "Enable DMA packet aggregation");
 module_param_named(dma_agg_timeout, rtl8xxxu_dma_agg_timeout, int, 0600);
@@ -4896,8 +4893,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 				sgi = 1;
 
 			highest_rate = fls(ramask) - 1;
-			if (rtl8xxxu_ht40_2g &&
-			    (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40))
+			if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40)
 				bw = RATE_INFO_BW_40;
 			else
 				bw = RATE_INFO_BW_20;
@@ -7851,7 +7847,8 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	sband->ht_cap.ht_supported = true;
 	sband->ht_cap.ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
 	sband->ht_cap.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16;
-	sband->ht_cap.cap = IEEE80211_HT_CAP_SGI_20 | IEEE80211_HT_CAP_SGI_40;
+	sband->ht_cap.cap = IEEE80211_HT_CAP_SGI_20 | IEEE80211_HT_CAP_SGI_40 |
+			    IEEE80211_HT_CAP_SUP_WIDTH_20_40;
 	memset(&sband->ht_cap.mcs, 0, sizeof(sband->ht_cap.mcs));
 	sband->ht_cap.mcs.rx_mask[0] = 0xff;
 	sband->ht_cap.mcs.rx_mask[4] = 0x01;
@@ -7860,15 +7857,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		sband->ht_cap.cap |= IEEE80211_HT_CAP_SGI_40;
 	}
 	sband->ht_cap.mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
-	/*
-	 * Some APs will negotiate HT20_40 in a noisy environment leading
-	 * to miserable performance. Rather than defaulting to this, only
-	 * enable it if explicitly requested at module load time.
-	 */
-	if (rtl8xxxu_ht40_2g) {
-		dev_info(&udev->dev, "Enabling HT_20_40 on the 2.4GHz band\n");
-		sband->ht_cap.cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
-	}
+
 	hw->wiphy->bands[NL80211_BAND_2GHZ] = sband;
 
 	hw->wiphy->rts_threshold = 2347;
-- 
2.51.1


