Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E4D3C9345
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jul 2021 23:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhGNVrh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jul 2021 17:47:37 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:34712 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235344AbhGNVrf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jul 2021 17:47:35 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.177])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 67AF3A006D
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jul 2021 21:44:42 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 23A1068007F
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jul 2021 21:44:42 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id CEF5613C2BB;
        Wed, 14 Jul 2021 14:44:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CEF5613C2BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1626299081;
        bh=TkF2zHCIj8ioMNhOnPEoWBKHi7KvrJ1pDfD/lHlEYgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQqZ6GVDA5cw94DZjNaxETwONnhR5DuyVYmxVzUdHd6YKDoESo6/1dRKwkoIdwBT/
         2jk710K/dkzV+X0/l2+6IOl8dg4acyZoMHXIUVW1A1vi9LMkvsdIE/0XW8AezLFMJH
         cg/c9R8qlHZLp0Cw+mWQsczXQ69sC80FSv49PWvA=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2 8/8] mt76 - mt7915:  Add mib counters to ethtool stats.
Date:   Wed, 14 Jul 2021 14:44:32 -0700
Message-Id: <20210714214432.15162-8-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210714214432.15162-1-greearb@candelatech.com>
References: <20210714214432.15162-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1626299082-hfptsgmxxgut
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This adds the new mib counters from last patch into ethtool
stats.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 50 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 1d2b7d116659..d98c6425108b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -381,6 +381,14 @@ void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 #endif
 
 static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
+	"tx_ampdu_cnt",
+	"tx_stop_q_empty_cnt",
+	"tx_mpdu_attempts",
+	"tx_mpdu_success",
+	"tx_rwp_fail_cnt",
+	"tx_rwp_need_cnt",
+	"tx_pkt_ebf_cnt",
+	"tx_pkt_ibf_cnt",
 	"tx_ampdu_len:0-1",
 	"tx_ampdu_len:2-10",
 	"tx_ampdu_len:11-19",
@@ -420,6 +428,22 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"tx_msdu_pack_6",
 	"tx_msdu_pack_7",
 	"tx_msdu_pack_8",
+
+	/* rx counters */
+	"rx_fifo_full_cnt",
+	"rx_mpdu_cnt",
+	"channel_idle_cnt",
+	"rx_vector_mismatch_cnt",
+	"rx_delimiter_fail_cnt",
+	"rx_len_mismatch_cnt",
+	"rx_ampdu_cnt",
+	"rx_ampdu_bytes_cnt",
+	"rx_ampdu_valid_subframe_cnt",
+	"rx_ampdu_valid_subframe_b_cnt",
+	"rx_pfdrop_cnt",
+	"rx_vec_queue_overflow_drop_cnt",
+	"rx_ba_cnt",
+	
 	/* per vif counters */
 	"v_tx_mpdu_attempts",
 	"v_tx_mpdu_fail",
@@ -493,6 +517,15 @@ void mt7915_debug_get_et_stats(struct ieee80211_hw *hw,
 	if (!phy)
 		return;
 
+	data[ei++] = mib->tx_ampdu_cnt;
+	data[ei++] = mib->tx_stop_q_empty_cnt;
+	data[ei++] = mib->tx_mpdu_attempts_cnt;
+	data[ei++] = mib->tx_mpdu_success_cnt;
+	data[ei++] = mib->tx_rwp_fail_cnt;
+	data[ei++] = mib->tx_rwp_need_cnt;
+	data[ei++] = mib->tx_pkt_ebf_cnt;
+	data[ei++] = mib->tx_pkt_ibf_cnt;
+
 	/* Tx ampdu stat */
 	n = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	for (i = 0; i < 15 /*ARRAY_SIZE(bound)*/; i++)
@@ -524,12 +557,25 @@ void mt7915_debug_get_et_stats(struct ieee80211_hw *hw,
 	data[ei++] = mib->tx_mu_successful_mpdu_cnt;
 	data[ei++] = mib->tx_su_successful_mpdu_cnt;
 
-	/* TODO:  External phy too?? */
-
 	/* Tx amsdu info (pack-count histogram) */
 	for (i = 0; i < 8; i++)
 		data[ei++] = mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
 
+	/* rx counters */
+	data[ei++] = mib->rx_fifo_full_cnt;
+	data[ei++] = mib->rx_mpdu_cnt;
+	data[ei++] = mib->channel_idle_cnt;
+	data[ei++] = mib->rx_vector_mismatch_cnt;
+	data[ei++] = mib->rx_delimiter_fail_cnt;
+	data[ei++] = mib->rx_len_mismatch_cnt;
+	data[ei++] = mib->rx_ampdu_cnt;
+	data[ei++] = mib->rx_ampdu_bytes_cnt;
+	data[ei++] = mib->rx_ampdu_valid_subframe_cnt;
+	data[ei++] = mib->rx_ampdu_valid_subframe_bytes_cnt;
+	data[ei++] = mib->rx_pfdrop_cnt;
+	data[ei++] = mib->rx_vec_queue_overflow_drop_cnt;
+	data[ei++] = mib->rx_ba_cnt;
+
 	/* Add values for all stations owned by this vif */
 
 	/* See mt76_get_min_avr_rssi for example of how to find all sta
-- 
2.20.1

