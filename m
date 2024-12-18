Return-Path: <linux-wireless+bounces-16555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 581509F70BB
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 00:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C9A16DD10
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 23:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0C31FCD15;
	Wed, 18 Dec 2024 23:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="loWDNKmB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4AD1FCD0F
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 23:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734564335; cv=none; b=ifXyYQJAZ5P/z008LDcgndW2fqDi5vbI2JaEcojy0JboRUsdv6x6Y0SWW2dZ70zifLrG3A+SK85BFi/bCYZEhuiaZ2Is7dByyw1uG06nzeNOgI0sOrqPnSGbYYOSYawPxO8n8zIcTdzqltUSswTc8FKe1MHRF2bbzfKXmjlzkrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734564335; c=relaxed/simple;
	bh=YxMBilccdrtnhH8Sv5CFR7ls05C1lZqJGjGWXSaOwDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQjEil4MaRFY0uRvXtm3jsdmx/6ERgQBMzL7FjwnhMOilJeY3iD1U1pkFxYI4TBHGzOJkOwQkT/CSrjOxE+pHnziTHJUHy18HjTBeNz4LO+Et3K3r3+96EKvYbZOVRGFzorlCbG7cSBFlD77bxtd5Rgs/4FakE/9cwdMHHsXqv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=loWDNKmB; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 973A8C40074
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 23:25:25 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 26EA913C2B0;
	Wed, 18 Dec 2024 15:25:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 26EA913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1734564325;
	bh=YxMBilccdrtnhH8Sv5CFR7ls05C1lZqJGjGWXSaOwDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=loWDNKmBbjl3yKqAlt6j1Afa8Mud7wRm5wipW/th2aLNKb3vovltfM9HEjXwMbiGQ
	 AhIFmplOas2C9WefPCmWexyqcFl52p9fvwisvf7PGasVOfaXHZSPx8/137fmC93k0r
	 9D3Mm9TloLxa211oN6Fx5YXuayX08Oo1g7/C10RI=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH v5 2/3] wifi: iwlwifi: Report link-id for transmitted frames.
Date: Wed, 18 Dec 2024 15:25:18 -0800
Message-ID: <20241218232519.3156080-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241218232519.3156080-1-greearb@candelatech.com>
References: <20241218232519.3156080-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1734564326-RwsU4mAgTzAG
X-MDID-O:
 us5;ut7;1734564326;RwsU4mAgTzAG;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Ben Greear <greearb@candelatech.com>

This will let upper stack properly record stats per link.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index c9867d26361b..c8b5d5cd3298 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1709,6 +1709,14 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 	u8 lq_color;
 	u16 next_reclaimed, seq_ctl;
 	bool is_ndp = false;
+	struct ieee80211_link_sta *link_sta;
+	int link_sta_id = -1;
+
+	rcu_read_lock();
+	link_sta = rcu_dereference(mvm->fw_id_to_link_sta[sta_id]);
+	if (link_sta)
+		link_sta_id = link_sta->link_id;
+	rcu_read_unlock();
 
 	__skb_queue_head_init(&skbs);
 
@@ -1732,6 +1740,7 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 
 		memset(&info->status, 0, sizeof(info->status));
 		info->flags &= ~(IEEE80211_TX_STAT_ACK | IEEE80211_TX_STAT_TX_FILTERED);
+		info->status.tx_link_id = link_sta_id + 1;
 
 		/* inform mac80211 about what happened with the frame */
 		switch (status & TX_STATUS_MSK) {
@@ -2048,6 +2057,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 	struct iwl_mvm_sta *mvmsta = NULL;
 	struct sk_buff *skb;
 	int freed;
+	struct ieee80211_link_sta *link_sta;
 
 	if (WARN_ONCE(sta_id >= mvm->fw->ucode_capa.num_stations ||
 		      tid > IWL_MAX_TID_COUNT,
@@ -2064,6 +2074,8 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 		return;
 	}
 
+	link_sta = rcu_dereference(mvm->fw_id_to_link_sta[sta_id]);
+
 	__skb_queue_head_init(&reclaimed_skbs);
 
 	/*
@@ -2087,6 +2099,9 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			info->flags |= IEEE80211_TX_STAT_ACK;
 		else
 			info->flags &= ~IEEE80211_TX_STAT_ACK;
+
+		if (link_sta)
+			info->status.tx_link_id = link_sta->link_id + 1;
 	}
 
 	/*
-- 
2.42.0


