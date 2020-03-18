Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7EB118990D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2020 11:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgCRKQg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Mar 2020 06:16:36 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:23576 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726733AbgCRKQg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Mar 2020 06:16:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584526595; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=O0d05UCJjVD4xSTI3MM3+2mZGIiEeIDQjqFaMpz2WIo=; b=nDg/lMn0WEgRUxzVsBrjpPggx10in86AMaCRP/Mf/C7/3R0aux8Bwigfu5iebVcIVGb35Ye+
 x7XFI51KgTdcE7CIEMmkhMq8Ww4BYw/3lksA7qH5IyKxyTJv1w0Nz73XPySnxsX+1zXtyIB2
 eKdzZ98gmSKSNaA8OU4qI+3Spw8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e71f4f6.7f82f5770c70-smtp-out-n03;
 Wed, 18 Mar 2020 10:16:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 98B0AC432C2; Wed, 18 Mar 2020 10:16:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from c-gsamin-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: seevalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4E72C433CB;
        Wed, 18 Mar 2020 10:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4E72C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=seevalam@codeaurora.org
From:   Seevalamuthu Mariappan <seevalam@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>
Subject: [PATCH] mac80211: Read rx_stats with perCPU pointers
Date:   Wed, 18 Mar 2020 15:45:55 +0530
Message-Id: <1584526555-25960-1-git-send-email-seevalam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use perCPU pointers to get rx_stats in sta_set_sinfo
when RSS is enabled

Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
---
 net/mac80211/sta_info.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f357156..8989a94 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2150,19 +2150,41 @@ static int sta_set_rate_info_rx(struct sta_info *sta, struct rate_info *rinfo)
 	return 0;
 }
 
+static inline u64 sta_get_tidstats_msdu(struct ieee80211_sta_rx_stats *rxstats,
+					int tid)
+{
+	unsigned int start;
+	u64 value;
+
+	do {
+		start = u64_stats_fetch_begin(&rxstats->syncp);
+		value = rxstats->msdu[tid];
+	} while (u64_stats_fetch_retry(&rxstats->syncp, start));
+
+	return value;
+}
+
 static void sta_set_tidstats(struct sta_info *sta,
 			     struct cfg80211_tid_stats *tidstats,
 			     int tid)
 {
 	struct ieee80211_local *local = sta->local;
+	int cpu;
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_RX_MSDU))) {
-		unsigned int start;
+		if (!ieee80211_hw_check(&local->hw, USES_RSS))
+			tidstats->rx_msdu +=
+				sta_get_tidstats_msdu(&sta->rx_stats, tid);
 
-		do {
-			start = u64_stats_fetch_begin(&sta->rx_stats.syncp);
-			tidstats->rx_msdu = sta->rx_stats.msdu[tid];
-		} while (u64_stats_fetch_retry(&sta->rx_stats.syncp, start));
+		if (sta->pcpu_rx_stats) {
+			for_each_possible_cpu(cpu) {
+				struct ieee80211_sta_rx_stats *cpurxs;
+
+				cpurxs = per_cpu_ptr(sta->pcpu_rx_stats, cpu);
+				tidstats->rx_msdu +=
+					sta_get_tidstats_msdu(cpurxs, tid);
+			}
+		}
 
 		tidstats->filled |= BIT(NL80211_TID_STATS_RX_MSDU);
 	}
@@ -2266,7 +2288,8 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 
 	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_RX_BYTES)))) {
-		sinfo->rx_bytes += sta_get_stats_bytes(&sta->rx_stats);
+		if (!ieee80211_hw_check(&local->hw, USES_RSS))
+			sinfo->rx_bytes += sta_get_stats_bytes(&sta->rx_stats);
 
 		if (sta->pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {
-- 
1.9.1
