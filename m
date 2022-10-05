Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479EB5F54E9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiJENBb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiJENA7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA34C1E3F5
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=PbW8judF+pUNDM+G5aD3fMMdWTuvhSRw/ik1euIOPYQ=;
        t=1664974858; x=1666184458; b=kh825iYLNtiJCRthHd0+8vCIv4DaSR46yfJaIMXxtoal0nZ
        8ZKWLF0shXfqMi768YHvmKH/HHn4oko9chLnyTrTyC1mtHI/1gGbsQTYBqdjcW4Kr60BkhPUDI+m1
        9Xljut13R8wSZTdLG/5iLwy+4fFtIa9vNXksRgVIxR6bifdthrZGMWKDjds7WcPFHnbCO3S1n2TK3
        WWFG5I58C5ldFd5PCLKY2zskuMaUi5eIRy2uOd2faH+FpzILdeZejRCMjTmiI4o3s86seo0i7WOPr
        T92PhpVjSYFyj4pQhne/T6uHc7cN/npNaPx9kHjbvPjXSvPokxvmpkGyurGD3cIw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og41A-00G2RL-19;
        Wed, 05 Oct 2022 15:00:56 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 23/28] wifi: mac80211: change AddBA deny error message
Date:   Wed,  5 Oct 2022 15:00:43 +0200
Message-Id: <20221005145226.ab7386682152.I5002d55dfe804187586114419374b70229e96549@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the station has no HT, we deny the aggregation session
but the error message talks about QoS; change it to say HT
instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/agg-rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index eaef88a603e5..f8bec5ee5b44 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -299,7 +299,7 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 	if (!sta->sta.deflink.ht_cap.ht_supported &&
 	    sta->sdata->vif.bss_conf.chandef.chan->band != NL80211_BAND_6GHZ) {
 		ht_dbg(sta->sdata,
-		       "STA %pM erroneously requests BA session on tid %d w/o QoS\n",
+		       "STA %pM erroneously requests BA session on tid %d w/o HT\n",
 		       sta->sta.addr, tid);
 		/* send a response anyway, it's an error case if we get here */
 		goto end;
-- 
2.37.3

