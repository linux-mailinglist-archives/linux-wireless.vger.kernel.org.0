Return-Path: <linux-wireless+bounces-12708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA1B97240D
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 23:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FBEE284D1E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 21:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0442582;
	Mon,  9 Sep 2024 21:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="AM9uXDiC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869EC4A1D
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915636; cv=none; b=XFcZfbZlMzJMcTdl48Oj3aIq4mzdlI1pDOmCiZXsmeQd3G3N/TYaThwRWiaEE/2Q1KDvJT9W1MZqwvBo4YOtwkI45xZXItXCKTts30YGdT4WB/b6I328lHk0uEO+WMk0qq6iy1/duEUxSuMWo+KkEizhmIHTboHOPj/pnnBjks0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915636; c=relaxed/simple;
	bh=jaEZqtoc2MSS2vEXV6juCsXLBC0sjK5NC20T6duUTEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCQuowK1hLiLjlq8JfF/BYNuB/lWscAbuE8kt3iSdLkh+hfdErXcIQUa5oPZTBRUoN+5LGxb7cPcicxpLmnuzBIEitT1eUoNhey9mqtZ7aEtfgQF1riXWyUkJCFOi6gPPYpMwN4PeQ83+kdA2hKd87FsAtq6Mp41pvBQ0RLRxA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=AM9uXDiC; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0397F280079
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 21:00:26 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id C4FAE13C2B0;
	Mon,  9 Sep 2024 14:00:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C4FAE13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1725915624;
	bh=jaEZqtoc2MSS2vEXV6juCsXLBC0sjK5NC20T6duUTEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AM9uXDiCWBmNhW/tNAJ7Iyql/jN58EdbuiYfBW/j2rX1ZSFhLfCrFm/YUT0aTVAsb
	 gHwDe0YcnN26F/x1K8gLRxi1w5j2xBjDNcvozSpqAmMswwIy8E9XSbnBo0kxEkfZ42
	 zB2/g2vnqU5aHvtbyni2tNdKL4qBOg7CK474Icww=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH 2/2] wifi: iwlwifi: Report link-id for transmitted frames.
Date: Mon,  9 Sep 2024 14:00:17 -0700
Message-ID: <20240909210017.3228400-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240909210017.3228400-1-greearb@candelatech.com>
References: <20240909210017.3228400-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1725915627-L7-dI7EPG_Ix
X-MDID-O:
 us5;ut7;1725915627;L7-dI7EPG_Ix;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

This will let upper stack properly record stats per link.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 7ff5ea5e7aca..105f9029be2f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1707,6 +1707,9 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 	u8 lq_color;
 	u16 next_reclaimed, seq_ctl;
 	bool is_ndp = false;
+	struct ieee80211_link_sta *link_sta;
+
+	link_sta = rcu_dereference(mvm->fw_id_to_link_sta[sta_id]);
 
 	__skb_queue_head_init(&skbs);
 
@@ -1730,6 +1733,10 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 
 		memset(&info->status, 0, sizeof(info->status));
 		info->flags &= ~(IEEE80211_TX_STAT_ACK | IEEE80211_TX_STAT_TX_FILTERED);
+		if (link_sta) {
+			info->control.flags &= ~(u32_encode_bits(0xF, IEEE80211_TX_CTRL_MLO_LINK));
+			info->control.flags |= u32_encode_bits(link_sta->link_id, IEEE80211_TX_CTRL_MLO_LINK);
+		}
 
 		/* inform mac80211 about what happened with the frame */
 		switch (status & TX_STATUS_MSK) {
@@ -2046,6 +2053,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 	struct iwl_mvm_sta *mvmsta = NULL;
 	struct sk_buff *skb;
 	int freed;
+	struct ieee80211_link_sta *link_sta;
 
 	if (WARN_ONCE(sta_id >= mvm->fw->ucode_capa.num_stations ||
 		      tid > IWL_MAX_TID_COUNT,
@@ -2062,6 +2070,8 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 		return;
 	}
 
+	link_sta = rcu_dereference(mvm->fw_id_to_link_sta[sta_id]);
+
 	__skb_queue_head_init(&reclaimed_skbs);
 
 	/*
@@ -2085,6 +2095,11 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
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


