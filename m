Return-Path: <linux-wireless+bounces-13820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5FF997245
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 18:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748E91F21AE8
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722EB197A8F;
	Wed,  9 Oct 2024 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="aM/7H1WY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F322CA5
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492587; cv=none; b=K5y8LaxnpxhH/G83eNNC1MKIXv2HD5BXlND7hRyOAWLpv58nzfOzSQU/ujFuWUI3droeVTp+h7+x3K6bKqLnIeVNuRXXtXO4j1+Lukh6xrc9WJ04cynpLaGl+jYPUw2hwAHUS66kDJevmSlDD9DV7154ggdt8085uToiadpxLEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492587; c=relaxed/simple;
	bh=jFkS9zEsUx1UGQQugMKF13irAodjNzOZi2z0xsp6ThQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fT08cVTGaF/tzCVM82rVYljO0LDCol1wqDc29VfEmyks0R80oD3p+voxXBQkqG2oCnUr227FxJ3BDwfrHRKNvO9IOL2o5NerN2CFr6EpsotjnuZH+nD0EPb0g5/iO931OT874PNtEoIebxVvCpmeMaQhOWcD+IkaVqZdOkHB/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=aM/7H1WY; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E20CC2C5F96
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 16:49:44 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 36D4BB00064
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 16:49:09 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id BF13613C2B0;
	Wed,  9 Oct 2024 09:49:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BF13613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1728492548;
	bh=jFkS9zEsUx1UGQQugMKF13irAodjNzOZi2z0xsp6ThQ=;
	h=From:To:Cc:Subject:Date:From;
	b=aM/7H1WY+tNdoH3/Uv4fqsaf6QDjpQCKIX9QfjrlVQgfMkMFqG7bcBUC1FK+Fuk13
	 Bc4HH/CfqXi0WkvRpb6jJG0FLms6f834hJfc9eYSEiKlSS1N4MMKlQGCLcdFHllnGJ
	 pcmyIzduttL2vJyVH940qBlCrt9i5n97Pb0OiKOg=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH v3 1/2] wifi: iwlwifi: Report link-id for transmitted frames.
Date: Wed,  9 Oct 2024 09:49:03 -0700
Message-ID: <20241009164904.3906438-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1728492578-cb-u5sSezVLs
X-MDID-O:
 us5;ut7;1728492578;cb-u5sSezVLs;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Ben Greear <greearb@candelatech.com>

This will let upper stack properly record stats per link.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v2:  Fix rcu locking

v3:  Fix missing v2 change text
     Fix long lines
     Fix |= that should have been '=' assignment in replace_bits logic.

 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index ca026b5256ce..f5b469647a35 100644
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
 
@@ -1732,6 +1740,10 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 
 		memset(&info->status, 0, sizeof(info->status));
 		info->flags &= ~(IEEE80211_TX_STAT_ACK | IEEE80211_TX_STAT_TX_FILTERED);
+		if (link_sta_id != -1)
+			info->control.flags = u32_replace_bits(info->control.flags,
+							       link_sta_id,
+							       IEEE80211_TX_CTRL_MLO_LINK);
 
 		/* inform mac80211 about what happened with the frame */
 		switch (status & TX_STATUS_MSK) {
@@ -2048,6 +2060,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 	struct iwl_mvm_sta *mvmsta = NULL;
 	struct sk_buff *skb;
 	int freed;
+	struct ieee80211_link_sta *link_sta;
 
 	if (WARN_ONCE(sta_id >= mvm->fw->ucode_capa.num_stations ||
 		      tid > IWL_MAX_TID_COUNT,
@@ -2064,6 +2077,8 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 		return;
 	}
 
+	link_sta = rcu_dereference(mvm->fw_id_to_link_sta[sta_id]);
+
 	__skb_queue_head_init(&reclaimed_skbs);
 
 	/*
@@ -2087,6 +2102,11 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			info->flags |= IEEE80211_TX_STAT_ACK;
 		else
 			info->flags &= ~IEEE80211_TX_STAT_ACK;
+
+		if (link_sta)
+			info->control.flags = u32_replace_bits(info->control.flags,
+							       link_sta->link_id,
+							       IEEE80211_TX_CTRL_MLO_LINK);
 	}
 
 	/*
-- 
2.42.0


