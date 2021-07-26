Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3283D65D0
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jul 2021 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhGZQtr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Jul 2021 12:49:47 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:41622 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237125AbhGZQtk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Jul 2021 12:49:40 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.120])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E00441C0061
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jul 2021 17:30:05 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id ABAFF340082
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jul 2021 17:30:05 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 5604313C2BC;
        Mon, 26 Jul 2021 10:30:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5604313C2BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627320605;
        bh=oBjuFx14/4VADkptv/AaIJXEzXaKY18y5LppZ4N5xqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NMPG0I2iZ62TyR5EM2oNGk1rrcw11S1zmB5T6aUwb3oB2zXgv3PwsWcdwFRC6rXGi
         5GP7h70lTC2ZrcCDfgAWZw8RMWkMxnUUdEszMHgkV2jjGBkx5zgKWESUuCTzzVEQ1A
         +i9Yac6Qq0hJvixm4UpLSyqVKPmIanGy9MZ98B7o=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v5 7/7] mt76 - mt7915:  Add mib counters to ethtool stats.
Date:   Mon, 26 Jul 2021 10:30:00 -0700
Message-Id: <20210726173000.23807-7-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210726173000.23807-1-greearb@candelatech.com>
References: <20210726173000.23807-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1627320606-3_ztS5y4OI-F
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
index c9806a4c57ba..2dc1b340f8cf 100644
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
 	"v_tx_mpdu_attempts",
 	"v_tx_mpdu_fail",
@@ -1185,6 +1209,15 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
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
@@ -1216,12 +1249,26 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
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

