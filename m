Return-Path: <linux-wireless+bounces-3360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E5F84E92B
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 20:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 495AAB2566E
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 19:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D463381C1;
	Thu,  8 Feb 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3VyW13f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D3D37711
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422081; cv=none; b=L79CU8wYmANU2oM9o5sUNYoPuhK7qINa01BrQeZmCDXFe3FOwfb7EMIERaDQgUSjcEKnBANtOj6s6hnkX2uMSvSw02/CAVRLuM9bc9xLzHzpqja61CetjRYrNpnfKxMe+nxU/1zJNWSH5Kci2a9JgOCf7fMR2RxzariBJD4VC94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422081; c=relaxed/simple;
	bh=ckOCixohMbsgT1bJ5IvqXu3ktVGeyPxayC3hnq7Mknk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LsXO0TZDcSvmNg5z4tx9Iq1jspGsKVZHUrFQ1weG9l0MVQnCa/j5SMq43gKzOGnXG0lL0qWpe1C9DTDtkvV+L2is5mt+zigP44pImnf36ZmZSI0wa1NUy/5gIfCDkr4MY/dpCPOWJoPXasdLeYDxA5Vc/vgSt8StDWH9xSUrd2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3VyW13f; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5116dfe1d9dso213344e87.3
        for <linux-wireless@vger.kernel.org>; Thu, 08 Feb 2024 11:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707422077; x=1708026877; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=469iOJNQmuVo9E8zIk9GFqzvR0yR3SRw/f8kZ1GV/Hg=;
        b=f3VyW13fCOsbNGub/wCV0qLh6DhA1Wrd1GOCwmAHCObf4RoiKgzq5ZwhwUdBa9EAxa
         Y4Qv6C4BkGvnQEFjsWvcomnTUpxCzcSU4mImxVX6RmSDzUF1dCFXrxAUuslTSXb8q5lQ
         G65eiwndcJIx2iucOomB2MHgC0D3Xov4674EwaMe4thc5Sv/4LeCzSkwxLJA1wbZPDXk
         /2LAR9Plsm+sFgmP3orliRRF6R9dMlOlcOSBFwJl0pl8ZEK25vzUUeMfVuz4vmXrVHHP
         wQEDniWVM781FQ7BjXtWJn4W9U5nyR+/4o8ctw2tp3uYDZfNF3RS6TUvJ/8qaQK1l7ut
         bz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707422077; x=1708026877;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=469iOJNQmuVo9E8zIk9GFqzvR0yR3SRw/f8kZ1GV/Hg=;
        b=UDrtuzTRUdn5KfY2yQAcOy8AVM2RLCvZTMhpwElztdIfuZX6C0o7v1Ce2i0fu2MovR
         /KqQFTVyOQTBQimtyDEh4Sb0NMNRi7MmfOkpSGXxpYokVsb3Qi0sLIO7Xh1GKySDYg1e
         14UOZM55jYH10farNZBbBbIY3IqK1Cuof1Vh2XGuiYx1B9APEkNzIdL/HxUeikEXKo3t
         KTS3rP7dRYdWmBZHpV7BPzYLIUYynn3oY5iPfBPEPYWogEAcbhrgr8cFq03rQe21ech+
         j3c98tBCAGey/ZssqslA0uy0Kl0HtskZeWxBP+itRcRqjuPZidojPzprxS397U0tBaQI
         1Rtw==
X-Gm-Message-State: AOJu0YxDqzyKtoW50z+pvE9VcLfiBaNO66pWBS0N9IoDhJtusolTmoze
	t0lUExTBJDhLasOdMViK5HNpkDRnlDYWs1WesymQyUj+S3iDtTK84a6OV7DR
X-Google-Smtp-Source: AGHT+IELRkbHaCUNxGSGFvgR7KsqiKhOE1DsHQtTYwu6u0IXHr+bP6VL1OahpRarPnMV402rmK5R8w==
X-Received: by 2002:a19:6514:0:b0:511:19bf:fa0c with SMTP id z20-20020a196514000000b0051119bffa0cmr156453lfb.56.1707422076989;
        Thu, 08 Feb 2024 11:54:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUoekoAW1JmVQewkCaiQgcvsNwEPM3zvvDcR97XrG5eo1ut4QvH7EU3oszil4R6U5cNFh6zTTGbR8noslVu2aZ6vuXfkZHTv/0e
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c19c600b0040fd1629443sm303921wmq.18.2024.02.08.11.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 11:54:36 -0800 (PST)
Message-ID: <651dae37-1911-4dcd-870b-4b60f759ca82@gmail.com>
Date: Thu, 8 Feb 2024 21:54:35 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtlwifi: rtl8192cu: Fix TX aggregation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

rtl8192cu is checking rtl_mac.tids when deciding if it should enable
aggregation. This is wrong because rtl_mac.tids is not initialised
anywhere. Check rtl_sta_info.tids instead, which is initialised.

Also, when enabling aggregation also enable RTS. The vendor driver does
this, my router does this. It seems like the thing to do.

Also also, it seems right to set the AMPDU density only when enabling
aggregation.

Also also also, delete the unused member rtl_mac.tids and the unused
macros RTL_AGG_ON and RTL_AGG_OFF.

Naturally, with working AMPDU the download/upload speeds are better.
Before: 59/32 Mbps.
After:  68/46 Mbps.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../wireless/realtek/rtlwifi/rtl8192cu/trx.c  | 27 ++++++++++---------
 .../wireless/realtek/rtlwifi/rtl8192cu/trx.h  |  2 --
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |  3 ---
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
index e5c81c1c63c0..cbbd1dab8af0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
@@ -475,8 +475,9 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	u8 *qc = ieee80211_get_qos_ctl(hdr);
-	u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
+	struct rtl_sta_info *sta_entry;
+	u8 agg_state = RTL_AGG_STOP;
+	u8 ampdu_density = 0;
 	u16 seq_number;
 	__le16 fc = hdr->frame_control;
 	u8 rate_flag = info->control.rates[0].flags;
@@ -498,10 +499,20 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
 	set_tx_desc_tx_rate(txdesc, tcb_desc->hw_rate);
 	if (tcb_desc->use_shortgi || tcb_desc->use_shortpreamble)
 		set_tx_desc_data_shortgi(txdesc, 1);
-	if (mac->tids[tid].agg.agg_state == RTL_AGG_ON &&
-		    info->flags & IEEE80211_TX_CTL_AMPDU) {
+
+	if (sta) {
+		sta_entry = (struct rtl_sta_info *)sta->drv_priv;
+		agg_state = sta_entry->tids[ieee80211_get_tid(hdr)].agg.agg_state;
+		ampdu_density = sta->deflink.ht_cap.ampdu_density;
+	}
+
+	if (agg_state == RTL_AGG_OPERATIONAL &&
+	    info->flags & IEEE80211_TX_CTL_AMPDU) {
 		set_tx_desc_agg_enable(txdesc, 1);
 		set_tx_desc_max_agg_num(txdesc, 0x14);
+		set_tx_desc_ampdu_density(txdesc, ampdu_density);
+		tcb_desc->rts_enable = 1;
+		tcb_desc->rts_rate = DESC_RATE24M;
 	} else {
 		set_tx_desc_agg_break(txdesc, 1);
 	}
@@ -536,14 +547,6 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
 		set_tx_desc_data_bw(txdesc, 0);
 		set_tx_desc_data_sc(txdesc, 0);
 	}
-	rcu_read_lock();
-	sta = ieee80211_find_sta(mac->vif, mac->bssid);
-	if (sta) {
-		u8 ampdu_density = sta->deflink.ht_cap.ampdu_density;
-
-		set_tx_desc_ampdu_density(txdesc, ampdu_density);
-	}
-	rcu_read_unlock();
 	if (info->control.hw_key) {
 		struct ieee80211_key_conf *keyconf = info->control.hw_key;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
index 5f81cab205cc..caeebe4480ff 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
@@ -11,8 +11,6 @@
 #define RTL92C_SIZE_MAX_RX_BUFFER		15360   /* 8192 */
 #define RX_DRV_INFO_SIZE_UNIT			8
 
-#define RTL_AGG_ON				1
-
 enum usb_rx_agg_mode {
 	USB_RX_AGG_DISABLE,
 	USB_RX_AGG_DMA,
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 3821f6e31447..b65d54115eac 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -1397,8 +1397,6 @@ struct rtl_phy {
 #define RTL_AGG_PROGRESS			1
 #define RTL_AGG_START				2
 #define RTL_AGG_OPERATIONAL			3
-#define RTL_AGG_OFF				0
-#define RTL_AGG_ON				1
 #define RTL_RX_AGG_START			1
 #define RTL_RX_AGG_STOP				0
 #define RTL_AGG_EMPTYING_HW_QUEUE_ADDBA		2
@@ -1473,7 +1471,6 @@ struct rtl_mac {
 	enum nl80211_iftype opmode;
 
 	/*Probe Beacon management */
-	struct rtl_tid_data tids[MAX_TID_COUNT];
 	enum rtl_link_state link_state;
 
 	int n_channels;
-- 
2.43.0

