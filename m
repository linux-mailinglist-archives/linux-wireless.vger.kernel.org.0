Return-Path: <linux-wireless+bounces-1230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECED81C7F8
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15371C213D1
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FDC1775B;
	Fri, 22 Dec 2023 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tb+qk1Va";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ABtZKuZ9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FB171B6
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703240088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPW8iKPYFAwZwMyiYi0S8we3AtROWwXa6uqLOJUILIM=;
	b=tb+qk1VaM/kJMttjl0hgVZm/bl7S4oFQYsCOys/saaGl2jusXfwXESEybf4E9AZhegUJOV
	qPedzLzZW1botyXzGJ+uBjd8/jCyxC9KDFWFwvFK6AL1B5rvFgjQbxUm0RN3nCYK6ymS/K
	nNKDL3ck+LYau3UpiKH/ZzDRTTL2w1bP+gEDZqfz3C77wmlHwrZuYpBtLFftX9iYrk7XCM
	40+Cs1XLlX77LCof4BfERTtIPtxQiKyhh504jz9ueSo+oEmYpG/sQQaKOHiZTgeX+j7EXN
	xdg3Epbg6/R1mOIUQkcxiCtdR6BlIPQ2kCVbkH5cIT/tmGujQg1fzfyFX855aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703240088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPW8iKPYFAwZwMyiYi0S8we3AtROWwXa6uqLOJUILIM=;
	b=ABtZKuZ9kgzJjBFKg7FFSMxWPiHQrZ/APGL6szjx0LBVwoyg2MiPDgTPRbTOF1Saa/qVe8
	QDrPARa2UMFkkSCQ==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 08/21] wifi: rtl8xxxu: don't parse CFO, if both interfaces are connected in STA mode
Date: Fri, 22 Dec 2023 11:14:29 +0100
Message-Id: <20231222101442.626837-9-martin.kaistra@linutronix.de>
In-Reply-To: <20231222101442.626837-1-martin.kaistra@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If both interfaces are in STATION mode and both are connected to an AP,
there might be conflicting CFO values for the two connections. Ignore
the CFO information in this case.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index ca0d885eabb71..6fff982f65253 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5716,6 +5716,14 @@ static inline bool rtl8xxxu_is_packet_match_bssid(struct rtl8xxxu_priv *priv,
 	       ether_addr_equal(priv->vifs[port_num]->bss_conf.bssid, hdr->addr2);
 }
 
+static inline bool rtl8xxxu_is_sta_sta(struct rtl8xxxu_priv *priv)
+{
+	return (priv->vifs[0] && priv->vifs[0]->cfg.assoc &&
+		priv->vifs[0]->type == NL80211_IFTYPE_STATION) &&
+	       (priv->vifs[1] && priv->vifs[1]->cfg.assoc &&
+		priv->vifs[1]->type == NL80211_IFTYPE_STATION);
+}
+
 void rtl8723au_rx_parse_phystats(struct rtl8xxxu_priv *priv,
 				 struct ieee80211_rx_status *rx_status,
 				 struct rtl8723au_phy_stats *phy_stats,
@@ -5734,6 +5742,7 @@ void rtl8723au_rx_parse_phystats(struct rtl8xxxu_priv *priv,
 		bool parse_cfo = priv->fops->set_crystal_cap &&
 				 !crc_icv_err &&
 				 !ieee80211_is_ctl(hdr->frame_control) &&
+				 !rtl8xxxu_is_sta_sta(priv) &&
 				 (rtl8xxxu_is_packet_match_bssid(priv, hdr, 0) ||
 				  rtl8xxxu_is_packet_match_bssid(priv, hdr, 1));
 
@@ -5772,6 +5781,7 @@ static void jaguar2_rx_parse_phystats_type1(struct rtl8xxxu_priv *priv,
 	bool parse_cfo = priv->fops->set_crystal_cap &&
 			 !crc_icv_err &&
 			 !ieee80211_is_ctl(hdr->frame_control) &&
+			 !rtl8xxxu_is_sta_sta(priv) &&
 			 (rtl8xxxu_is_packet_match_bssid(priv, hdr, 0) ||
 			  rtl8xxxu_is_packet_match_bssid(priv, hdr, 1));
 	u8 pwdb_max = 0;
-- 
2.39.2


