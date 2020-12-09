Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E622D3919
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 04:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgLIDGJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 22:06:09 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:55161 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgLIDGJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 22:06:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607483152; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=8ThBztOOXO+KpLxELh7RSp180zvmZ/59IZkttzXtZdo=; b=WBg5t/gR1qTXILrAEyJAzT+eqwi5+YehPNCf4zNCeOX6E9JEP4DA9ty4k/rhavnwQuplQ5Kd
 9bAM2kO+7nZVkocqNFnDbLis65BEmaSnbcmroz0Am98pH747KV9B7OVG7OUKSS5ELEaqgxJ5
 f5POmb6oc9jKXnebaSopB78lerQ=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5fd03ef2395c822bfe184de4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 09 Dec 2020 03:05:22
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA336C43461; Wed,  9 Dec 2020 03:05:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2EEFC433C6;
        Wed,  9 Dec 2020 03:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2EEFC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org, ath10k@lists.infradead.org,
        johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH] mac80211: fix a mistake check for rx_stats update
Date:   Wed,  9 Dec 2020 11:06:29 +0800
Message-Id: <1607483189-3891-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It should be !is_multicast_ether_addr() in ieee80211_rx_h_sta_process()
for the rx_stats update, below commit remove the !, this patch is to
change it back.

It lead the rx rate "iw wlan0 station dump" become invalid for some
scene when IEEE80211_HW_USES_RSS is set, and the rx rate become valid
with this patch for the scene.

Fixed: 09a740ce352e ("mac80211: receive and process S1G beacons")

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 net/mac80211/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index ebd01ca9d2e6..dafde71af50e 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1762,7 +1762,7 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 	} else if (rx->sdata->vif.type == NL80211_IFTYPE_OCB) {
 		sta->rx_stats.last_rx = jiffies;
 	} else if (!ieee80211_is_s1g_beacon(hdr->frame_control) &&
-		   is_multicast_ether_addr(hdr->addr1)) {
+		   !is_multicast_ether_addr(hdr->addr1)) {
 		/*
 		 * Mesh beacons will update last_rx when if they are found to
 		 * match the current local configuration when processed.
-- 
2.23.0

