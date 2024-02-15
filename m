Return-Path: <linux-wireless+bounces-3647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0018856D32
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 19:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8681C288667
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 18:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE35131E54;
	Thu, 15 Feb 2024 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhNFmxGI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397B83D6D
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708023485; cv=none; b=LTlq78Omb1ARmpozarjV1l9bzebFUB2i8YfGQs0Th1lMEEPKHOiuz2nd0r5OHVSFMHfI3ZtXPyDpcECoPOmTJyL0HiqegJDOIBGSF9sW1m42HiFxIqHj58tnoxoLJ5iiYIg2EgtHDzRAGFwfghgJi+mXzF3dFqXRomJ1NpB/GkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708023485; c=relaxed/simple;
	bh=kR8TLk1lZIgR3pfrS9QaXCUMf1Oxk9StmrdxsuqIuDs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TSbiLu87KFBjab23n/RaMJ8e4VHYvghmQPtbHUSMS3EVEkR/AagGmgjRVgqv2zlyOopA7H1by6yZtJ9pgFaMO66Ygy57AhBcxnLD6si7aAQbLo/yNK+Cyfb1nBpIrlva/NOSXxFrNOvkvLpP/ijSCSFSZ8EJt8Xo6gtDiQDYcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhNFmxGI; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d0a4e8444dso13094061fa.2
        for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 10:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708023481; x=1708628281; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8i4gTAYTSFH05Hf9ypVw0rIObhdj8+RHQzx0YazL0tQ=;
        b=JhNFmxGISGgn391AmeFVyRqABRlZmFC/1dm37Qz1wsDIhmL6LmHUf5sv5nHvoCGDQP
         rQL7WwdLaLONenahKcFcVn1XXGbJGX73dCOn5VxrmcjS3VVKeOQAemulNMNTSJjcsjjm
         gLWwIRL2ZTC1SuPQIbVqhRcFUxNhLOs5U/vtuGaXs7nXDjBy1WqesCKFDnyE9MciT8nn
         fgD3l+k2ul/sac9vQPe60rc8nsiTZQs3fJvhkO2Rb/plqk/PbdbuNshAQT6Gu3Wk1py+
         +lEFzegozunF3VIxxLbqidOg2Suxjd2yvC53fQu+5LhRfLWPDgZkGL0p54GU0QMD3yej
         /UVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708023481; x=1708628281;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8i4gTAYTSFH05Hf9ypVw0rIObhdj8+RHQzx0YazL0tQ=;
        b=Fxbzj9Ec9oLczS+1DVH/6MsFAdmR7XyINAbsYARyAnGW/xCS7mBR2CNHiLJ81Aubqo
         Yk/L46I4bdur/TI2empXR7js2txkxZgBFz/C/rvYS6CCzN9BnxCoxyGouGj/fld5tcZO
         nRhlNAdSlHib+DKQiSnzfzMqeisiLDgCwFyy08Lzwkp8OcSvbjV3Q73T8fu2cACeNTAU
         QNfaDFeLrJ0rE4SujcWJH99anmi3zE0Hu6845JRjBDV3OjipcYrS23nEHhfjW08zMVcG
         Fg0rfrSoBYXC07pNY7ujL7dGPKEcwJrrxrLazcxcJSgalr2xgVv1x0tvpfGiVOQC+PGN
         k6sQ==
X-Gm-Message-State: AOJu0Ywztvqpmot+eAlOZ7VI85GeFJuI5vxdPGJ5TtaFrfiTIWjRzEPU
	rQ0OHFsB4wpxgFhsu2TxkGwqLIgfYbUF7T8UqXJlR0MyWUFbgQWKitIcpbVk
X-Google-Smtp-Source: AGHT+IGERcLT0qhH0S+Z4YZDnqvVRyLeFF2q3ETSm6UELzOF9mKEfpJ38gx1M83DCRaMO+rvAt/yvw==
X-Received: by 2002:a2e:bb96:0:b0:2d1:1c0d:7f63 with SMTP id y22-20020a2ebb96000000b002d11c0d7f63mr1771852lje.22.1708023480983;
        Thu, 15 Feb 2024 10:58:00 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id dn17-20020a05600c655100b00412156abf32sm2590489wmb.16.2024.02.15.10.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 10:58:00 -0800 (PST)
Message-ID: <4e936334-5f81-403f-a495-0628ebfb6903@gmail.com>
Date: Thu, 15 Feb 2024 20:57:59 +0200
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
Subject: [PATCH v2] wifi: rtlwifi: rtl8192cu: Fix TX aggregation
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
v2:
 - Add back the tid variable.
---
 .../wireless/realtek/rtlwifi/rtl8192cu/trx.c  | 29 +++++++++++--------
 .../wireless/realtek/rtlwifi/rtl8192cu/trx.h  |  2 --
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |  3 --
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
index 4856ed40005b..aa702ba7c9f5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
@@ -482,8 +482,9 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
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
@@ -492,6 +493,7 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
 						skb_get_queue_mapping(skb));
 	u8 *txdesc8;
 	__le32 *txdesc;
+	u8 tid;
 
 	seq_number = (le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_SEQ) >> 4;
 	rtl_get_tcb_desc(hw, info, sta, skb, tcb_desc);
@@ -505,10 +507,21 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
 	set_tx_desc_tx_rate(txdesc, tcb_desc->hw_rate);
 	if (tcb_desc->use_shortgi || tcb_desc->use_shortpreamble)
 		set_tx_desc_data_shortgi(txdesc, 1);
-	if (mac->tids[tid].agg.agg_state == RTL_AGG_ON &&
-		    info->flags & IEEE80211_TX_CTL_AMPDU) {
+
+	if (sta) {
+		sta_entry = (struct rtl_sta_info *)sta->drv_priv;
+		tid = ieee80211_get_tid(hdr);
+		agg_state = sta_entry->tids[tid].agg.agg_state;
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
@@ -543,14 +556,6 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
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
index 8678fa0043f4..09e61dc0f317 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
@@ -10,8 +10,6 @@
 #define RTL92C_SIZE_MAX_RX_BUFFER		15360   /* 8192 */
 #define RX_DRV_INFO_SIZE_UNIT			8
 
-#define RTL_AGG_ON				1
-
 enum usb_rx_agg_mode {
 	USB_RX_AGG_DISABLE,
 	USB_RX_AGG_DMA,
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 01df00a43cdb..f388d13e2ba8 100644
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

