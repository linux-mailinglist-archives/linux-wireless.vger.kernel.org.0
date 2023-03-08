Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96A96B1675
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 00:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCHXYc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 18:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCHXYa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 18:24:30 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC1E69CD6
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 15:24:27 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C13E42C006C
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 23:24:25 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 2B59C13C2B0;
        Wed,  8 Mar 2023 15:24:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2B59C13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1678317865;
        bh=n0g83HecLbuik9WFWPi8NpUl8pKuIcybaNeU7RKLfjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=isuU/Spw5ENnHmRgw6LPEXwwIYca8O94yCzoMxZ7MPNQavTWm7jq1fy/6XltXiex+
         FRi79JK23AQ5VGN5x47vk7Eb9PbjSFesYRA/E+IDIptBcX2JadQ8+yccS1hqq8yH2p
         g/sgRtHxr4CulnNY3duQEVBYV2RxNAU0ixPyFG1E=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 2/2] wireless: mac80211: fix ath10k wave-2 in 80mhz mode in config_bw logic.
Date:   Wed,  8 Mar 2023 15:24:21 -0800
Message-Id: <20230308232421.2672247-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230308232421.2672247-1-greearb@candelatech.com>
References: <20230308232421.2672247-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1678317866-yXSWvFJfDKKs
X-MDID-O: us5;at1;1678317866;yXSWvFJfDKKs;<greearb@candelatech.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

It was complaining about the 'DISABLE_HE' flag mismatch,
so ensure that if ifmgd has DISABLE_HE set, then 'flags'
also will have that flag set.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/mlme.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0efca23be69b..52c8f2770757 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -505,6 +505,10 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 	    chandef.width != NL80211_CHAN_WIDTH_80P80)
 		flags |= IEEE80211_CONN_DISABLE_80P80MHZ;
 
+	/* if ifmgd has HE disabled, then we cannot re-enable that here. */
+	if (link->u.mgd.conn_flags & IEEE80211_STA_DISABLE_HE)
+		flags |= IEEE80211_STA_DISABLE_HE;
+
 	if (cfg80211_chandef_identical(&chandef, &link->conf->chandef))
 		return 0;
 
-- 
2.39.1

