Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0883E0234
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbhHDNoB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 09:44:01 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:43904 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238342AbhHDNn4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 09:43:56 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.131])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id F01E81C0074
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 13:43:42 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B7A7C980084
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 13:43:42 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 814BE13C2BB;
        Wed,  4 Aug 2021 06:43:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 814BE13C2BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628084622;
        bh=cP8ABkMeRrXekMt+l+jbql0Y5fpFlhz17RDws3sF//U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b8MzL6aFyk+0fJbTEmy0JNgU63SitBnQcWgSZ8qP1J3s+eiDYJfoLTnnWvEy4hH3y
         r4ZVRtRDYTJYsjsholQWPPs6mcjc50/coX7eSs2y0+w1cnG02wS1TQLDZDoIX7jOHN
         JkuZGMxVAoSRxIzcSAld/VhGU30hyBfwHdFQNDFc=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v7 7/7] mt76: mt7915:  add mib counters to ethtool stats
Date:   Wed,  4 Aug 2021 06:43:35 -0700
Message-Id: <20210804134337.2582-7-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210804134337.2582-1-greearb@candelatech.com>
References: <20210804134337.2582-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628084623-55g5HaSZupup
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This adds the new mib counters from last patch into ethtool
stats.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 49 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3c80bee2dab2..4a37c4dc49e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1029,6 +1029,14 @@ static void mt7915_sta_set_decap_offload(struct ieee80211_hw *hw,
 }
 
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
@@ -1068,6 +1076,22 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
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
 	"v_tx_mode_cck",
 	"v_tx_mode_ofdm",
@@ -1179,6 +1203,15 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
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
@@ -1210,12 +1243,26 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	data[ei++] = mib->tx_mu_acked_mpdu_cnt;
 	data[ei++] = mib->tx_su_acked_mpdu_cnt;
 
-	/* TODO:  External phy too?? */
 
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
 	wi.data = data;
 	wi.mvif = mvif;
-- 
2.20.1

