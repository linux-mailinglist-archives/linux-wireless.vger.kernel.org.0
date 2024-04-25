Return-Path: <linux-wireless+bounces-6868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884628B27ED
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 20:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1345A1F2182B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 18:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD7414D457;
	Thu, 25 Apr 2024 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDW8smRn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C943937152
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068798; cv=none; b=nW7zYd+YC25fTPrY6dJBZHd+aOXgUIdPX3oiwxbx9eFu1p7kd19/WaVB5TmoHBbNBmrpQHcx2wiFkwRzhloPib0s76yk4kDjKWX8VIUheKgu5ddcTkDQJsFeIFJ9Rp7Gh9kClRJLXMPPWTghtyIAeNRfH4QH18QB+2+prnWXocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068798; c=relaxed/simple;
	bh=A8dYXkQeTxYz+Mz+0mym63SXJ6OsdQfohRZy+Bht9oE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Neifq9fbi9/xyx4KUwTyC2aLaLYt1bTZTkSM1xMnykeUj7+dlLVPQwNKBaF4/6aXxkjnJy+7GuEuB97aO183v4/2cYo30FoctKXKp7uRgDH9xNW/UMMd7w+alWE+YS9J/9Nptkk0KHyTV6mvmHwWwJNk5VQWp9zPX8GOAPf+Wt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDW8smRn; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5176f217b7bso2361776e87.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 11:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714068795; x=1714673595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M/oMGDcPLZubpYP0ou4VHyFOv+TwDw3BNGVlS7iyKZo=;
        b=UDW8smRnufn6nIwoRUHBO+RVkKtzSnnVJPWYMUcYbPn6XnnXCmLvwHQ2B8NBhjbSE5
         1Jbg6QlNP/bGRxOQ1FSTH84jlU9rDFSycz/MoHh9aH6HgtbC5aE9nhVjtju9/iINNVpa
         mObD5agknlX0RXaVAi/pyXXhNfwCxWwEaD/L2QJJ3/9SUC8GrGzWm8uDrg7POdzhAc15
         O2LiU4C1cZG8zM6rP+CWmWg+b0jBW96Zxy7p6tNjUaZv+sHdPhpoME6LgxAM/jlM7pvY
         iNJDRTqDtE6Z7Nt6+vKdTbpA2by5AQal4TZqS636Ti6BY0H1v8Tpt1iQNnt5Q7EqokDv
         Ki6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714068795; x=1714673595;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/oMGDcPLZubpYP0ou4VHyFOv+TwDw3BNGVlS7iyKZo=;
        b=bC8QN/DwQ3mza0pYRZ6j8dKdfBgt4b4FFnzJcVJR0J9UzCXJMK34FjaKq2M3B6o4IB
         zFy1dDSc+9OEivliPuFyZFadNhfM7b/EoaPVUFgliJZyMaHRkQvIdOTtJONGMK21slo+
         vbFLaQxht7V4urkWL24chz2QE6VejYt4bZyccTmzN2t8bOwonzad21oKXVWzsCBeUcTs
         PPdKZTKx9YE6/auczMhTuS3W/q1Dd3ZM7TJ5S+P3AXL5Mf+XHXjp5wAR7oTarbUQQILr
         bZm38berb1NlX3klSXjavCg2qGep/Ne7BeDkD85FUQAUGhVnb/TI3bo347DOyIFCsqbz
         J4sQ==
X-Gm-Message-State: AOJu0YyncXRur7XtHyHkFcPGH/wwoCVcBmlRxDfVYsPda42sUF3Iqo2R
	XfKH0FATkjntWR9IJZSUG5+Es8N4kXoIbCKsPc5WG6PWiXp4YySqsaZYudYq
X-Google-Smtp-Source: AGHT+IGrVz8bar8qu9/z0kGldkmf1mKYG1F5pGvjr+KjNZWlEZe2jzco6pGSwI4n+2wH+J+Lj5Omyg==
X-Received: by 2002:a19:770f:0:b0:518:e7ed:3c7c with SMTP id s15-20020a19770f000000b00518e7ed3c7cmr99205lfc.14.1714068794639;
        Thu, 25 Apr 2024 11:13:14 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b00a526a99ccecsm9693409ejd.42.2024.04.25.11.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 11:13:14 -0700 (PDT)
Message-ID: <698463da-5ef1-40c7-b744-fa51ad847caf@gmail.com>
Date: Thu, 25 Apr 2024 21:13:12 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 3/6] wifi: rtlwifi: rtl8192de: Fix endianness issue in RX
 path
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <72231f87-60fd-4d87-8cf4-ee2967f22dd2@gmail.com>
Content-Language: en-US
In-Reply-To: <72231f87-60fd-4d87-8cf4-ee2967f22dd2@gmail.com>
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
v7:
 - No change.

v6:
 - No change.

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


