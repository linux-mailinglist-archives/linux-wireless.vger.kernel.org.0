Return-Path: <linux-wireless+bounces-6344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF438A5C2C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 22:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2911C211DA
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 20:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D9015687D;
	Mon, 15 Apr 2024 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+5kHHS7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F0156871
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212779; cv=none; b=QfzLfBMekZoNXG6SA3de9elWxRWxAH3WheYE8WqMZEVsXCn+IgYChskL9DHGrbViAbPEEwp40lYpek53nxVgAQO4vI4Qq2T5S/k/xvzEzSp4K/85LEOcc/f0/YgR1Qg5CTEzJubG2MtopPTG38A8E84PC9ZuwjT3O5gtx1MTjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212779; c=relaxed/simple;
	bh=mcCVZawZzVONE7lvWpHlFE0ihspD0dJTL0akkv4yjlU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eVWoVCNgpVae9J3j1FSY6AdU4SqiwD82U+o5TQFnMcjcb34S1B0Z3N5iF9qe926RMNblC9nm906p2/9R0H7Y4Txmdjkw6sk4jC4ehuZjlW95/V9bk6PAKR7R6tP0TUijLz1wlchFrPfb4C5nzKN5KxspnRspJckEgZbN6QJrtK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+5kHHS7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-418913dc298so20865e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 13:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713212776; x=1713817576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MhMI1n7PFYfoeJsHzmW+zMmxTfge8/yN0bSZTuC6IPk=;
        b=f+5kHHS7xnurEfIJKOx7NbQOgCC2KXA9+NFF9X+JmUeS91blDN8DBCREf9AjeTU6GS
         M6VcsxZU027JrKFLJpK5aExvq6ZJesQc8+FevvpWSlq/Q2yGQaw0grhNj2N0Puy0QEVn
         2BqD1MPuuoIYKM6Sn5fuifcQAY/K2cueFdPW87tDx+wvmp3z2RJD5LyTZh0nZgCfvZlw
         4JIv/oiM0xBDbyB8+SxmpGk724AYWyUoEahdvNo2BkW+cEkMDKZAXf5/1FJBGVs2IKVc
         fcQWcYLN/DcxaIYCi01R3kUFXKEnb2RafRJ6Ls+wWgl/zKXb7+P48s7ri47DH00X1wHp
         uL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713212776; x=1713817576;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhMI1n7PFYfoeJsHzmW+zMmxTfge8/yN0bSZTuC6IPk=;
        b=FBD79TDtiLQduQbhytwXFZ6q9oj5K/KQqBerrwxBKvRRa8NtKkn+zEC1WtOjLAXYlA
         I3FxnkEdTo7yXtcP2DlQM91eJCUAr1Szv8AfebUbzpoMLZchRgR9CkCq5Hi8wzoyxIUr
         YYB5yloJOSSDUCwWYulxtgdi1bGO1+khkl3ZkypKFHijf/94xlS+k6r1GaSTuE5WaVJF
         4bwA9u8wL/ePNebcMuonGauK9Gp5/Lve7IGRCPVQG5RIOX6IRfJTdIESOJcQiOREGRaR
         tktkhwR+ul1H1kTKqDWP7+s6yVrJdu3oAlO9/lnzbHdUktXa+Sttfgy5Mmv15R2cmPBx
         XpMQ==
X-Gm-Message-State: AOJu0YwEIN5lJh+raHXHkteJ57FSwfwOm6jQEU2YlSueFvqLNfR551KM
	RVpIVE90LWGTCsbXTN6M4iR469gLum+Rxi8Hu57+M7eSC7AThJNaRqg9jmKj
X-Google-Smtp-Source: AGHT+IEPrGkXNyMwlURoHwNsfX/OyFBYoizrVefRtjT6aZWX0cjzgq8kyiz2MzgbNAdUNi1Aw66UUQ==
X-Received: by 2002:adf:f84a:0:b0:347:ec04:6ac5 with SMTP id d10-20020adff84a000000b00347ec046ac5mr2307493wrq.6.1713212775750;
        Mon, 15 Apr 2024 13:26:15 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id cg14-20020a5d5cce000000b00346d91ddbe3sm11856262wrb.9.2024.04.15.13.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 13:26:15 -0700 (PDT)
Message-ID: <4f5feba7-82ad-4287-a34f-648529a972d0@gmail.com>
Date: Mon, 15 Apr 2024 23:26:14 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 3/6] wifi: rtlwifi: rtl8192de: Fix endianness issue in RX
 path
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
Content-Language: en-US
In-Reply-To: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Structs rx_desc_92d and rx_fwinfo_92d will not work for big endian
systems.

Delete rx_desc_92d because it's big and barely used, and instead use
the get_rx_desc_rxmcs and get_rx_desc_rxht functions, which work on big
endian systems too.

Fix rx_fwinfo_92d by duplicating four of its members in the correct
order.

Tested only with RTL8192DU, which will use the same code.
Tested only on a little endian system.

Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v5:
 - Patch is new in v5.
---
 .../wireless/realtek/rtlwifi/rtl8192de/trx.c  | 16 ++---
 .../wireless/realtek/rtlwifi/rtl8192de/trx.h  | 65 ++-----------------
 2 files changed, 15 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
index 30b262c3f6d0..cbc7b4dbea9a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
@@ -35,7 +35,7 @@ static long _rtl92de_translate_todbm(struct ieee80211_hw *hw,
 
 static void _rtl92de_query_rxphystatus(struct ieee80211_hw *hw,
 				       struct rtl_stats *pstats,
-				       struct rx_desc_92d *pdesc,
+				       __le32 *pdesc,
 				       struct rx_fwinfo_92d *p_drvinfo,
 				       bool packet_match_bssid,
 				       bool packet_toself,
@@ -50,8 +50,10 @@ static void _rtl92de_query_rxphystatus(struct ieee80211_hw *hw,
 	u8 i, max_spatial_stream;
 	u32 rssi, total_rssi = 0;
 	bool is_cck_rate;
+	u8 rxmcs;
 
-	is_cck_rate = RX_HAL_IS_CCK_RATE(pdesc->rxmcs);
+	rxmcs = get_rx_desc_rxmcs(pdesc);
+	is_cck_rate = rxmcs <= DESC_RATE11M;
 	pstats->packet_matchbssid = packet_match_bssid;
 	pstats->packet_toself = packet_toself;
 	pstats->packet_beacon = packet_beacon;
@@ -157,8 +159,8 @@ static void _rtl92de_query_rxphystatus(struct ieee80211_hw *hw,
 		pstats->rx_pwdb_all = pwdb_all;
 		pstats->rxpower = rx_pwr_all;
 		pstats->recvsignalpower = rx_pwr_all;
-		if (pdesc->rxht && pdesc->rxmcs >= DESC_RATEMCS8 &&
-		    pdesc->rxmcs <= DESC_RATEMCS15)
+		if (get_rx_desc_rxht(pdesc) && rxmcs >= DESC_RATEMCS8 &&
+		    rxmcs <= DESC_RATEMCS15)
 			max_spatial_stream = 2;
 		else
 			max_spatial_stream = 1;
@@ -364,7 +366,7 @@ static void _rtl92de_process_phyinfo(struct ieee80211_hw *hw,
 static void _rtl92de_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 					       struct sk_buff *skb,
 					       struct rtl_stats *pstats,
-					       struct rx_desc_92d *pdesc,
+					       __le32 *pdesc,
 					       struct rx_fwinfo_92d *p_drvinfo)
 {
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
@@ -440,9 +442,7 @@ bool rtl92de_rx_query_desc(struct ieee80211_hw *hw,	struct rtl_stats *stats,
 	if (phystatus) {
 		p_drvinfo = (struct rx_fwinfo_92d *)(skb->data +
 						     stats->rx_bufshift);
-		_rtl92de_translate_rx_signal_stuff(hw,
-						   skb, stats,
-						   (struct rx_desc_92d *)pdesc,
+		_rtl92de_translate_rx_signal_stuff(hw, skb, stats, pdesc,
 						   p_drvinfo);
 	}
 	/*rx_status->qual = stats->signal; */
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
index f189ee2d9be2..2d4887490f00 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
@@ -394,10 +394,17 @@ struct rx_fwinfo_92d {
 	u8 csi_target[2];
 	u8 sigevm;
 	u8 max_ex_pwr;
+#ifdef __LITTLE_ENDIAN
 	u8 ex_intf_flag:1;
 	u8 sgi_en:1;
 	u8 rxsc:2;
 	u8 reserve:4;
+#else
+	u8 reserve:4;
+	u8 rxsc:2;
+	u8 sgi_en:1;
+	u8 ex_intf_flag:1;
+#endif
 } __packed;
 
 struct tx_desc_92d {
@@ -502,64 +509,6 @@ struct tx_desc_92d {
 	u32 reserve_pass_pcie_mm_limit[4];
 } __packed;
 
-struct rx_desc_92d {
-	u32 length:14;
-	u32 crc32:1;
-	u32 icverror:1;
-	u32 drv_infosize:4;
-	u32 security:3;
-	u32 qos:1;
-	u32 shift:2;
-	u32 phystatus:1;
-	u32 swdec:1;
-	u32 lastseg:1;
-	u32 firstseg:1;
-	u32 eor:1;
-	u32 own:1;
-
-	u32 macid:5;
-	u32 tid:4;
-	u32 hwrsvd:5;
-	u32 paggr:1;
-	u32 faggr:1;
-	u32 a1_fit:4;
-	u32 a2_fit:4;
-	u32 pam:1;
-	u32 pwr:1;
-	u32 moredata:1;
-	u32 morefrag:1;
-	u32 type:2;
-	u32 mc:1;
-	u32 bc:1;
-
-	u32 seq:12;
-	u32 frag:4;
-	u32 nextpktlen:14;
-	u32 nextind:1;
-	u32 rsvd:1;
-
-	u32 rxmcs:6;
-	u32 rxht:1;
-	u32 amsdu:1;
-	u32 splcp:1;
-	u32 bandwidth:1;
-	u32 htc:1;
-	u32 tcpchk_rpt:1;
-	u32 ipcchk_rpt:1;
-	u32 tcpchk_valid:1;
-	u32 hwpcerr:1;
-	u32 hwpcind:1;
-	u32 iv0:16;
-
-	u32 iv1;
-
-	u32 tsfl;
-
-	u32 bufferaddress;
-	u32 bufferaddress64;
-
-} __packed;
-
 void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 			  struct ieee80211_hdr *hdr, u8 *pdesc,
 			  u8 *pbd_desc_tx, struct ieee80211_tx_info *info,
-- 
2.44.0


