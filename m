Return-Path: <linux-wireless+bounces-12178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4D2962D0C
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 17:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4B32827C0
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 15:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBAC172767;
	Wed, 28 Aug 2024 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="jCxcT4Qf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9F318756D
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860513; cv=none; b=mBGci4v5kKiE4dg+JVfUAikOmQZ1XYLrMwy3N8Z+U2jZ9eDFVr1qsD79jCSp+QN3hshtAe08H/BDVfc67oVPAjPkirT9siHNlU1esxCEXtgjA9UtIKZkB10x94yfLKaSj+/FTCv/6oK0bLUNqzRXJv3sNFa+vKMp8vlIlY0f2y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860513; c=relaxed/simple;
	bh=c/vTvF+/xKi1ir3gqqvg+ojTMC6SuxtbztjDi9Fn+vA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hn5yxRdGM4ckJHbeFDbwUwJ/WeWtd0M79A6lCIaH/KIu8NEh9VLC/6sLq9fVnTgR0O6DjE1moherfhwLDxbVWzJjBAcitIoTBan94uCRZQpD0IuGxzvRjoXE299wAeA0V8EHwfBwa0tHcPIr0Aul0s+fH5CE/SYHDVijxTX5aPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=jCxcT4Qf; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D65EDA8007F
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 15:55:03 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id F08A913C2B0;
	Wed, 28 Aug 2024 08:55:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com F08A913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1724860501;
	bh=c/vTvF+/xKi1ir3gqqvg+ojTMC6SuxtbztjDi9Fn+vA=;
	h=From:To:Cc:Subject:Date:From;
	b=jCxcT4QfAwzyruOb4AwwubAjr+nkGizWzITo3Wuns+sGbtxSaTjMys8KH6ePnHZ2i
	 TbvejjxiPtiNGuZEE4hpK0A6xB3/PykvG4smaO/ywmQXKSqZs95pfdgf4/dkE/E0Qe
	 bLZ2SqBMCzjLuUsheB5R0Snu5Ras83gKwHm0okmI=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [RFC PATCH 1/2] wifi: iwlwifi:  Report link-id for transmitted frames.
Date: Wed, 28 Aug 2024 08:54:57 -0700
Message-ID: <20240828155458.1990497-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1724860504-uLj7hZZbQnSj
X-MDID-O:
 us5;ut7;1724860504;uLj7hZZbQnSj;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

This will let upper stack properly record stats per link.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

Patch is against my internal tree at this point.
Will port to upstream kernel once general approach is ironed out.

 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index e7cb6dcde182..42bb21a976fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1963,6 +1963,9 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 	u8 lq_color;
 	u16 next_reclaimed, seq_ctl;
 	bool is_ndp = false;
+	struct ieee80211_link_sta *link_sta;
+
+	link_sta = rcu_dereference(mvm->fw_id_to_link_sta[sta_id]);
 
 	__skb_queue_head_init(&skbs);
 
@@ -1989,6 +1992,10 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 
 		memset(&info->status, 0, sizeof(info->status));
 		info->flags &= ~(IEEE80211_TX_STAT_ACK | IEEE80211_TX_STAT_TX_FILTERED);
+		if (link_sta) {
+			info->control.flags &= ~(u32_encode_bits(0xF, IEEE80211_TX_CTRL_MLO_LINK));
+			info->control.flags |= u32_encode_bits(link_sta->link_id, IEEE80211_TX_CTRL_MLO_LINK);
+		}
 
 		/* inform mac80211 about what happened with the frame */
 		switch (status & TX_STATUS_MSK) {
@@ -2334,6 +2341,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 	struct iwl_mvm_sta *mvmsta = NULL;
 	struct sk_buff *skb;
 	int freed;
+	struct ieee80211_link_sta *link_sta;
 
 	if (WARN_ONCE(sta_id >= mvm->fw->ucode_capa.num_stations ||
 		      tid > IWL_MAX_TID_COUNT,
@@ -2350,6 +2358,8 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 		return;
 	}
 
+	link_sta = rcu_dereference(mvm->fw_id_to_link_sta[sta_id]);
+
 	__skb_queue_head_init(&reclaimed_skbs);
 
 	/*
@@ -2437,6 +2447,11 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			info->flags |= IEEE80211_TX_STAT_ACK;
 		else
 			info->flags &= ~IEEE80211_TX_STAT_ACK;
+
+		if (link_sta) {
+			info->control.flags &= ~(u32_encode_bits(0xF, IEEE80211_TX_CTRL_MLO_LINK));
+			info->control.flags |= u32_encode_bits(link_sta->link_id, IEEE80211_TX_CTRL_MLO_LINK);
+		}
 	}
 
 	/*
-- 
2.42.0


