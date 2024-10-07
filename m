Return-Path: <linux-wireless+bounces-13621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F133993531
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 19:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1B628446D
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 17:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB721DD9D3;
	Mon,  7 Oct 2024 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="h3PppYpH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497301DDA08
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322755; cv=none; b=W2hGuWW/Bw8pJHAppcR97EACICCjHJJ04hcr5gWmIHc5ooX/pjlFLzMB4j5QpuAo9wZu6zCbwfqRyAJbGKU5MuEg3vNcEs38AuuepibslZcZQKWzIc8oS3L3X29lMvdzmcRONqQmb1l4/TnDiLiTPSSNwglOJitkHhmjZnH+bH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322755; c=relaxed/simple;
	bh=8TVQcQjVS1ZD0qvCwqBxSCjyTLRzgnBQkTo+gI9eaOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwHjbCN6kejHpseTPMsLFFtjGQJQOQg6cQRl91BwuCJzqftK8SiMjHSksVAJpQwxKcS8oW8EWLGBKsrdH7foqB+x3L20ACueRbut3tX50kmXun9nexBvILFU6zLg9psAH0kitcRAijuw4rqmgSuZz30sB3S5snXbT8siOGf7RQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=h3PppYpH; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DADEC504338
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 17:39:01 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E04508007B
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 17:38:53 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 7BB3D13C2B0;
	Mon,  7 Oct 2024 10:38:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7BB3D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1728322732;
	bh=8TVQcQjVS1ZD0qvCwqBxSCjyTLRzgnBQkTo+gI9eaOU=;
	h=From:To:Cc:Subject:Date:From;
	b=h3PppYpHf3dUn42+WXrG8P13zRlEWXLofpycT8+buxYzy3W94UBieED6pgRzpG62J
	 H6goWxTDhQtY2dZR0v/nJ2LhY0rvxxaKhLmSAkVlnLIK3baekQq7m2dVAXSCep+XV6
	 mhGuSQ2YIQDberzpZTYWDLdpsaqdmI+8uFScgXWo=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH 1/2] wifi: iwlwifi: Report link-id for transmitted frames.
Date: Mon,  7 Oct 2024 10:38:50 -0700
Message-ID: <20241007173851.2207849-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1728322734-C-FO0p9M99oj
X-MDID-O:
 us5;at1;1728322734;C-FO0p9M99oj;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Ben Greear <greearb@candelatech.com>

This will let upper stack properly record stats per link.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index ca026b5256ce..f22f8a269988 100644
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
 
@@ -1732,6 +1740,8 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 
 		memset(&info->status, 0, sizeof(info->status));
 		info->flags &= ~(IEEE80211_TX_STAT_ACK | IEEE80211_TX_STAT_TX_FILTERED);
+		if (link_sta_id != -1)
+			info->control.flags = u32_replace_bits(info->control.flags, link_sta_id, IEEE80211_TX_CTRL_MLO_LINK);
 
 		/* inform mac80211 about what happened with the frame */
 		switch (status & TX_STATUS_MSK) {
@@ -2048,6 +2058,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 	struct iwl_mvm_sta *mvmsta = NULL;
 	struct sk_buff *skb;
 	int freed;
+	struct ieee80211_link_sta *link_sta;
 
 	if (WARN_ONCE(sta_id >= mvm->fw->ucode_capa.num_stations ||
 		      tid > IWL_MAX_TID_COUNT,
@@ -2064,6 +2075,8 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 		return;
 	}
 
+	link_sta = rcu_dereference(mvm->fw_id_to_link_sta[sta_id]);
+
 	__skb_queue_head_init(&reclaimed_skbs);
 
 	/*
@@ -2087,6 +2100,9 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			info->flags |= IEEE80211_TX_STAT_ACK;
 		else
 			info->flags &= ~IEEE80211_TX_STAT_ACK;
+
+		if (link_sta)
+			info->control.flags |= u32_replace_bits(info->control.flags, link_sta->link_id, IEEE80211_TX_CTRL_MLO_LINK);
 	}
 
 	/*
-- 
2.42.0


