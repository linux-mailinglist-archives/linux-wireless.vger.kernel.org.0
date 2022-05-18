Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960ED52B9F6
	for <lists+linux-wireless@lfdr.de>; Wed, 18 May 2022 14:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbiERMfA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 May 2022 08:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237066AbiERMeP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 May 2022 08:34:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931C31059FE;
        Wed, 18 May 2022 05:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A237AB81FBB;
        Wed, 18 May 2022 12:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35330C385AA;
        Wed, 18 May 2022 12:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652876990;
        bh=KxUHMxCtT1XT8i2oOCZgReXE0uqJrutH4S+iLI9/Svw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mLCrHqC9eVi/RtNIN8uxwLotVzhpn0ZBPJCmD1ZeuyWvdQuCAI/hoeBTJ80rk+ohW
         lzHOEn6upppnwkqwU7DqOnnNuJASjB/EgwgicQFsD4xPXixYXxx3xLzJUYUTmjrE6M
         vnzp8oUteyDfWkns2Y7LjfMMCPlbWZIA3hS6IJuAS1PzpruiHbPhPUARr221e56zfq
         0vMblsE+ExinZblZlWphFRJtl/EN8e1fZba423VgLUbc27lbvkVFPEjSXd0hcnHmIh
         7+C1JuDa7p0kmg3YLr88F9FgVVHtabRFKz/g7G1NwN3J567R4xftNaaJdxh63a6Sdp
         yGHd007OjdvNg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/5] mac80211: fix rx reordering with non explicit / psmp ack policy
Date:   Wed, 18 May 2022 08:29:42 -0400
Message-Id: <20220518122946.343712-2-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518122946.343712-1-sashal@kernel.org>
References: <20220518122946.343712-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 5e469ed9764d4722c59562da13120bd2dc6834c5 ]

When the QoS ack policy was set to non explicit / psmp ack, frames are treated
as not being part of a BA session, which causes extra latency on reordering.
Fix this by only bypassing reordering for packets with no-ack policy

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Link: https://lore.kernel.org/r/20220420105038.36443-1-nbd@nbd.name
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index f30b732af61d..3598ebe52d08 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1322,8 +1322,7 @@ static void ieee80211_rx_reorder_ampdu(struct ieee80211_rx_data *rx,
 		goto dont_reorder;
 
 	/* not part of a BA session */
-	if (ack_policy != IEEE80211_QOS_CTL_ACK_POLICY_BLOCKACK &&
-	    ack_policy != IEEE80211_QOS_CTL_ACK_POLICY_NORMAL)
+	if (ack_policy == IEEE80211_QOS_CTL_ACK_POLICY_NOACK)
 		goto dont_reorder;
 
 	/* new, potentially un-ordered, ampdu frame - process it */
-- 
2.35.1

