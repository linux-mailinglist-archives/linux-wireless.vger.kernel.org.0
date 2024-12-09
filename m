Return-Path: <linux-wireless+bounces-16112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716AC9E9E82
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 19:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17DB281B43
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 18:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885781991BE;
	Mon,  9 Dec 2024 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVQU831Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B71991AF
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770473; cv=none; b=a4PMehSu9l09YEz23MuExQDmePny8JdF277fT/FGpV5qt28zL6N8yd9iCdz9ZO1JoW1C3cSmGgrenEma5ReDKBO+F39saM6n3f6OCuNGTxpTEETV3oYj5XvGbKuGvt3Z73ueapnQMkzSG+V/7BUc3BQ/B2rZWKiZsHkyWdT1HWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770473; c=relaxed/simple;
	bh=+eODcYiOK2lvd0sDtM4IPRRyMxPqg1E76bdc5gjjHbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RAd0Mx8dSezHZ6+eZpQIouiylEM41Kf4jQAn1u82KMwUd93cRnVmMFsYnbwXEPJ8rPu5T5uNgQtJp6PrRyPH4CWB1ymozcJUQwQZ6upJePzaeqiBZhmXpHkn8JaKzk98mBpM0Wpu/BUNP7wqpXcZ1UXPh80YBaTXZPcmUckWwas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVQU831Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB8FC4CEE1;
	Mon,  9 Dec 2024 18:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733770473;
	bh=+eODcYiOK2lvd0sDtM4IPRRyMxPqg1E76bdc5gjjHbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OVQU831Yz3p4TKWP+Wd4f0SZ20yn4aBFDPw97KC0dyXU9npdLte21FhsMTM73Hhz+
	 1tl9BCquG8ytHFeSkYwgp4uUD9Rc5Jp8Id0eQLTjmvurgiJJ5RPO6zVjvzF3kwbRdZ
	 JmHmRyrnyaKO8yF9Zxfy+QubtQVzfWGmz6EzTqxtKrcOSYog2NpcENtGsVn5h5KusR
	 LblyKVf+p5pwvIEuzeApLTsfURM4OOR8QCGzEbKLiMJPCGcuP4v8kws2TbVavMvgz7
	 fhFEstS2RRZo6RD6bI0ahBMQR8bucomlm7m36x4GCHvMRU1uxepH8Q62NlYF7j9uW9
	 2ffyBAT+gbviQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 9/9] wifi: ath12k: pass link ID during MLO while delivering skb
Date: Mon,  9 Dec 2024 20:54:21 +0200
Message-Id: <20241209185421.376381-10-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209185421.376381-1-kvalo@kernel.org>
References: <20241209185421.376381-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

mac80211 expects link_id in some scenarios or else the packet might
get dropped. Hence, add link_id information before delivering the skb.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 8 +++++++-
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 5 +++++
 drivers/net/wireless/ath/ath12k/peer.c   | 2 ++
 drivers/net/wireless/ath/ath12k/peer.h   | 3 +++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 494984133a91..2d53404095d6 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1093,8 +1093,14 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 		decap = ath12k_dp_rx_h_decap_type(ar->ab, rxcb->rx_desc);
 	spin_lock_bh(&ar->ab->base_lock);
 	peer = ath12k_dp_rx_h_find_peer(ar->ab, msdu);
-	if (peer && peer->sta)
+	if (peer && peer->sta) {
 		pubsta = peer->sta;
+		if (pubsta->valid_links) {
+			status->link_valid = 1;
+			status->link_id = peer->link_id;
+		}
+	}
+
 	spin_unlock_bh(&ar->ab->base_lock);
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index adbd7bbcef6f..1cc7f6ce55b9 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2474,6 +2474,11 @@ static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *nap
 
 	pubsta = peer ? peer->sta : NULL;
 
+	if (pubsta && pubsta->valid_links) {
+		status->link_valid = 1;
+		status->link_id = peer->link_id;
+	}
+
 	spin_unlock_bh(&ab->base_lock);
 
 	ath12k_dbg(ab, ATH12K_DBG_DATA,
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 5763c5a40cfc..792cca8a3fb1 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -388,6 +388,8 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		arsta = wiphy_dereference(ath12k_ar_to_hw(ar)->wiphy,
 					  ahsta->link[link_id]);
 
+		peer->link_id = arsta->link_id;
+
 		/* Fill ML info into created peer */
 		if (sta->mlo) {
 			ml_peer_id = ahsta->ml_peer_id;
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index 7e6231cb2b52..5870ee11a8c7 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -59,6 +59,9 @@ struct ath12k_peer {
 
 	/* To ensure only certain work related to dp is done once */
 	bool primary_link;
+
+	/* for reference to ath12k_link_sta */
+	u8 link_id;
 };
 
 struct ath12k_ml_peer {
-- 
2.39.5


