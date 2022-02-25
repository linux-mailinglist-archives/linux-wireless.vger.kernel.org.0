Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC064C5211
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Feb 2022 00:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbiBYX3W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Feb 2022 18:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiBYX3V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Feb 2022 18:29:21 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08F912341F
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 15:28:47 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.164])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 6C023A0074
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 23:28:46 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3F9B7B00072
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 23:28:46 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id A8D8113C2B0;
        Fri, 25 Feb 2022 15:28:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A8D8113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1645831725;
        bh=0KnkVM0jE2CErxS79Sa2/Q5kulSfZbpWM9FmwF87zAg=;
        h=From:To:Cc:Subject:Date:From;
        b=fDScoqeJMKumnjj60tfORh/pWEzPcqBrUNKQym7yGzl6fHy7onVkfDuoimqAQEtQs
         JAnFfmgosJmi94cL4x0XAatb3nJYnJEpETryMT52rr2aGPgsR+nVFB+hWngkeBGuDJ
         3qtecPYb6k1Lc+r5VD0CDSZJmvTADCUG29zAaImM=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 1/2] mac80211:  Allow drivers to report avg chain signal.
Date:   Fri, 25 Feb 2022 15:28:41 -0800
Message-Id: <20220225232842.32028-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1645831726-m_09h8JzGjcz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Drivers that use RSS cannot get the avg signal from mac80211.
So allow drivers to report the avg chain signal while letting
mac80211 take care of the last chain signal.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/sta_info.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 43a58b30c6a4..00836f587b6d 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2543,6 +2543,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	if (last_rxstats->chains &&
 	    !(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL) |
 			       BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)))) {
+		/* Neither chain signal nor chain signal avg is filled */
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
 		if (!sta->pcpu_rx_stats)
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
@@ -2557,6 +2558,21 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		}
 	}
 
+	/* Check if chain signal is not filled, for cases avg was filled by
+	 * driver bug last chain signal was not.
+	 */
+	if (last_rxstats->chains &&
+		 !(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)))) {
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
+
+		sinfo->chains = last_rxstats->chains;
+
+		for (i = 0; i < ARRAY_SIZE(sinfo->chain_signal); i++) {
+			sinfo->chain_signal[i] =
+				last_rxstats->chain_signal_last[i];
+		}
+	}
+
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE))) {
 		sta_set_rate_info_tx(sta, &sta->tx_stats.last_rate,
 				     &sinfo->txrate);
-- 
2.20.1

