Return-Path: <linux-wireless+bounces-917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB178173C4
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 15:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC461F235EF
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 14:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535B23A1C3;
	Mon, 18 Dec 2023 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PGI8o/8m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uJ+NE32c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034DF22088
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702910228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/0jYFXUEHYu9EAR8Mk/p4FDdZHkCTVLdinl6DphAm0=;
	b=PGI8o/8mAkQ/e0NPx6E0PNpRLe06EQrvaxaM32cqIG9/f8pKfIEJhT+irOZWew0oFOjJVb
	S+Nx8fmB4PaMCYXmrpNJYIYNhZRNYKKtvmqhBXpzakg1QA5ox/8WZxPTQt6w0NJmwAUKDv
	pUIiz55PhaAO6LllWYz/rj4pSGDCPtVthz/y0HuUoy9wBvddPryH+hkanGLADs8vm21t3S
	Rs7iFaBQgqcd9+M11WzYkTrQuCXdli6jw7Xu0DnsWqiA00XSSv0dlmJO6NCCrsx5258l3j
	3dztQPuQFvfNYa90ZopREQy869KVTymX87pLdgkgn/XJzPtQTLO7SdKQ2kcWnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702910228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/0jYFXUEHYu9EAR8Mk/p4FDdZHkCTVLdinl6DphAm0=;
	b=uJ+NE32cXGZwaWMM6L7rP/bWBxZAV7ItYHotN9ChGGvwxcmeYc8yMuGBMvXY+3GMgtdunq
	n5t3hf+8sijuUXAA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 07/20] wifi: rtl8xxxu: extend check for matching bssid to both interfaces
Date: Mon, 18 Dec 2023 15:36:32 +0100
Message-Id: <20231218143645.433356-8-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-1-martin.kaistra@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver will support two interfaces soon, which both can be in
station mode, so extend the check, whether cfo information should be
parsed, to cover both interfaces.

For better code readability put the lines with priv->vifs[port_num] in a
separate function.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index fd6b6e2eba038..c3039049e9f5b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5706,6 +5706,16 @@ static void rtl8xxxu_update_beacon_work_callback(struct work_struct *work)
 	rtl8xxxu_send_beacon_frame(hw, vif);
 }
 
+static inline bool rtl8xxxu_is_packet_match_bssid(struct rtl8xxxu_priv *priv,
+						  struct ieee80211_hdr *hdr,
+						  int port_num)
+{
+	return priv->vifs[port_num] &&
+		priv->vifs[port_num]->type == NL80211_IFTYPE_STATION &&
+		priv->vifs[port_num]->cfg.assoc &&
+		ether_addr_equal(priv->vifs[port_num]->bss_conf.bssid, hdr->addr2);
+}
+
 void rtl8723au_rx_parse_phystats(struct rtl8xxxu_priv *priv,
 				 struct ieee80211_rx_status *rx_status,
 				 struct rtl8723au_phy_stats *phy_stats,
@@ -5722,12 +5732,10 @@ void rtl8723au_rx_parse_phystats(struct rtl8xxxu_priv *priv,
 		rx_status->signal = priv->fops->cck_rssi(priv, phy_stats);
 	} else {
 		bool parse_cfo = priv->fops->set_crystal_cap &&
-				 priv->vif &&
-				 priv->vif->type == NL80211_IFTYPE_STATION &&
-				 priv->vif->cfg.assoc &&
 				 !crc_icv_err &&
 				 !ieee80211_is_ctl(hdr->frame_control) &&
-				 ether_addr_equal(priv->vif->bss_conf.bssid, hdr->addr2);
+				 (rtl8xxxu_is_packet_match_bssid(priv, hdr, 0) ||
+				  rtl8xxxu_is_packet_match_bssid(priv, hdr, 1));
 
 		if (parse_cfo) {
 			priv->cfo_tracking.cfo_tail[0] = phy_stats->path_cfotail[0];
@@ -5762,12 +5770,10 @@ static void jaguar2_rx_parse_phystats_type1(struct rtl8xxxu_priv *priv,
 					    bool crc_icv_err)
 {
 	bool parse_cfo = priv->fops->set_crystal_cap &&
-			 priv->vif &&
-			 priv->vif->type == NL80211_IFTYPE_STATION &&
-			 priv->vif->cfg.assoc &&
 			 !crc_icv_err &&
 			 !ieee80211_is_ctl(hdr->frame_control) &&
-			 ether_addr_equal(priv->vif->bss_conf.bssid, hdr->addr2);
+			 (rtl8xxxu_is_packet_match_bssid(priv, hdr, 0) ||
+			  rtl8xxxu_is_packet_match_bssid(priv, hdr, 1));
 	u8 pwdb_max = 0;
 	int rx_path;
 
-- 
2.39.2


