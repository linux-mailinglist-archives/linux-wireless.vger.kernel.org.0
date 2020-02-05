Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 564B015279A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2020 09:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgBEIfl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Feb 2020 03:35:41 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:54462 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727068AbgBEIfl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Feb 2020 03:35:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580891740; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=lj4f+MD9H6ancfUR5vhoNmQMx4d6fdDWJ54DZFxbXqw=; b=RTIfo0m/YpzVIQV99epJhaFiwYjXM3Zc55k7K4ermuU8E3ipj3cWdviRUEGbhs2GbJjeK1I9
 RphFjF4HypPqNd4c9bUGw+0QRI2O6rX9RwqBeJJXhB/wjHWUxCV/WOfOBYNqosiib5fc4beW
 fDhjVo8PnrHt8JfRK7T9L5ILljQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3a7e5b.7f20da47aab0-smtp-out-n02;
 Wed, 05 Feb 2020 08:35:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 551FEC433A2; Wed,  5 Feb 2020 08:35:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnaralas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 782AEC43383;
        Wed,  5 Feb 2020 08:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 782AEC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vnaralas@codeaurora.org
From:   Venkateswara Rao Naralasetty <vnaralas@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>
Subject: [PATCH] ath11k: fix incorrect peer stats counters update
Date:   Wed,  5 Feb 2020 14:05:30 +0530
Message-Id: <1580891730-23868-1-git-send-email-vnaralas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Venkateswara Naralasetty <vnaralas@codeaurora.org>

Convert mac80211 bw to ath11k bw before updating peer stats
bw counters, which fixes incorrect peer stats counters update.

Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/debugfs_sta.c |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c         | 16 ++++++++++++++++
 drivers/net/wireless/ath/ath11k/mac.h         |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index 743760c..8e8f2a8 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -24,7 +24,7 @@ ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
 	tx_stats = arsta->tx_stats;
 	gi = FIELD_GET(RATE_INFO_FLAGS_SHORT_GI, arsta->txrate.flags);
 	mcs = txrate->mcs;
-	bw = txrate->bw;
+	bw = ath11k_mac_mac80211_bw_to_ath11k_bw(txrate->bw);
 	nss = txrate->nss - 1;
 
 #define STATS_OP_FMT(name) tx_stats->stats[ATH11K_STATS_TYPE_##name]
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 6640662..da117e1 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -178,6 +178,22 @@ u8 ath11k_mac_bw_to_mac80211_bw(u8 bw)
 	return ret;
 }
 
+enum ath11k_supported_bw ath11k_mac_mac80211_bw_to_ath11k_bw(enum rate_info_bw bw)
+{
+	switch (bw) {
+	case RATE_INFO_BW_20:
+		return ATH11K_BW_20;
+	case RATE_INFO_BW_40:
+		return ATH11K_BW_40;
+	case RATE_INFO_BW_80:
+		return ATH11K_BW_80;
+	case RATE_INFO_BW_160:
+		return ATH11K_BW_160;
+	default:
+		return ATH11K_BW_20;
+	}
+}
+
 int ath11k_mac_hw_ratecode_to_legacy_rate(u8 hw_rc, u8 preamble, u8 *rateidx,
 					  u16 *rate)
 {
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index f286531..f4937a0 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -144,4 +144,5 @@ void ath11k_mac_drain_tx(struct ath11k *ar);
 void ath11k_mac_peer_cleanup_all(struct ath11k *ar);
 int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx);
 u8 ath11k_mac_bw_to_mac80211_bw(u8 bw);
+enum ath11k_supported_bw ath11k_mac_mac80211_bw_to_ath11k_bw(enum rate_info_bw bw);
 #endif
-- 
2.7.4
