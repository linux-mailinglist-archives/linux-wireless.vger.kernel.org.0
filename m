Return-Path: <linux-wireless+bounces-6572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C1F8AAF7D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 15:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18C0281C82
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD0785C62;
	Fri, 19 Apr 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn9jzP7l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A524128366
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533825; cv=none; b=WchzkwgWHUxM5HDujSkKfxOnnWzYoD532uOpuZLupJvdJLEPLQhPYLNj8FTO6QFr885whWsnZ6H7ef4iaK/Z82T+7KVVNsI5D7rGwdcO7WXTEFiNKnG3jrUSgprF+c5Kao27A1sSaXal1FitfdrWJ45Pwp/64280uOMWa4NuH0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533825; c=relaxed/simple;
	bh=voAGSZT3IIbwh1HM/cylSPtngeiK1NWN8O/QDGM9HTo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=F2MnI1rACsh3DhNM2eWCvajJd6l3/8AB9mOAz1txeQO+6sF9PRFKO48hjzDuJFhY7yD/Xp7wLmvr35Sx+5khujZ744SV04Vm4bIznmHqAevWmR7/aLGzxtGvOEBH5yKU8ZNrdHSZkuj4A+ajJb2joytS8MXppG9FpdyBMhhUlkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn9jzP7l; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2da08b07157so26060941fa.1
        for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713533822; x=1714138622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dHwjUzThZIbrhMkcs9A58doZowYvE9GFstHSRpfCbVY=;
        b=Nn9jzP7lQ/Vw1KZ/dtFtHTO/WqCDrFZOJd4GR7hfUsoyzNiaFvlUADGiKgMb3Sxxxe
         ODU0oAvMjDdJs4/FfGPnYPuiPPJDWB2PFPLAYz0kxGrjwjr2ChIVSww0BHLkUXc4YOSp
         xJNx0+vFN54qOizuZzc1kWRzn6P4yulCe5QF1jKhYdUvKl6ZfudPZed2fdY8jxd9t701
         GD/hc8yOJDVAhfsflSCDS0U6q68aHB9zhUFHGfKDZNJRyeUuImMQXcay3y0IowoxL6V+
         Ws/vMe87EG0BAQ9HjJs9cuf8QTu/qB3Wjc0IF3Xx/Tbfos+m8W9o4CJLccTEY3JwMm1W
         yOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713533822; x=1714138622;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHwjUzThZIbrhMkcs9A58doZowYvE9GFstHSRpfCbVY=;
        b=FGnoLc7qtLpPQrXuaV9ta0c8ifLFvEAx/UrmW9HTqJY/W0+vhtWkuJwCBOboJMrj4j
         9zqzKMF4XUYGlViP4j9e+nDzj3nRTCcgQcnmdVodNo82OZNdNSnIlbaJhiP1EJlplFS8
         y0qAh2u12bbYfbRt99mm42QzwKXlKfmviy/1iy111Bi1AG6Ispb80P7RLppmLbEzfTFa
         k+XkY+TsoxsFaoIG94C3kzN45f1kKHiciRPaVe+/mMz3ikglwT0SecytBJozay7QpdJ5
         bP2KtMmKe9EC+fkKahuMFdtaD7CAYbpwsQW3fUBfLuJNyxXO7exDhwcbTNbHm9a8Olyw
         A9FQ==
X-Gm-Message-State: AOJu0YxjuQ1Q3gW8hdz3ZyySZzQ5hqUhtmPyjtMYtBsN4jVGWMuv5CBb
	Zot+GCA260Tgr55UjCNiJITb0Czkpm5FVGINrzX02W+hYYafwpuyKjb7leBA
X-Google-Smtp-Source: AGHT+IFDKLMdH6Pz5N0l/TEXKhjKDx/PNbYlaxeER4MKT7ArE2hUaqAofSmabt8cZhzvwbncBCbOxg==
X-Received: by 2002:a2e:8ed0:0:b0:2dc:fc58:9d74 with SMTP id e16-20020a2e8ed0000000b002dcfc589d74mr402539ljl.37.1713533821961;
        Fri, 19 Apr 2024 06:37:01 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id qu20-20020a170907111400b00a5242ec4573sm2174840ejb.29.2024.04.19.06.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 06:37:01 -0700 (PDT)
Message-ID: <825a2dd4-66a4-4aa4-9a5a-7351b8a28046@gmail.com>
Date: Fri, 19 Apr 2024 16:37:00 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v6 3/6] wifi: rtlwifi: rtl8192de: Fix endianness issue in RX
 path
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <9d54a192-d389-4a56-9286-2e7721cbbc27@gmail.com>
Content-Language: en-US
In-Reply-To: <9d54a192-d389-4a56-9286-2e7721cbbc27@gmail.com>
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



