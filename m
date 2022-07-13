Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA113573322
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiGMJpM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbiGMJpK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B836BFAEB
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=n7wFBEEAuNQGGsR1pxmwrMMRlVj3BpAiqSqQllf4lKg=;
        t=1657705508; x=1658915108; b=NdNptq9QaEYb5hcGAeLWUoeDf8hVCLkInoSNm76JDViBwNR
        exNLEVOCdhXNXPNKYFYcyUS0ZtGhrXt/NGFyNZ1nFMkgxk4LEUPnkhw2K3ih2oxLBTnGrsJt2XjiT
        Uoat64PKkV/dUUi/MQPbIlygcJ50HDKi9nTM8Dy001xKynBPenLFsICPrjMDDVniE70RiM+PLXaWX
        2AKRLmqow3TRUcXAJMCE+SWqBcodbumAQoz6xMKNRm1iuQKmCBDRaghtx2YcXMTyeSk9D+TL9AsUD
        maq5Pee0PWM5PrunJCWvEbWFfnTkL3Q7uNuRWdfThlBgKUFYKlgUQJ0ximlXADwg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvZ-00EgvB-RX;
        Wed, 13 Jul 2022 11:45:05 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH 04/76] wifi: mac80211: Consider MLO links in offchannel logic
Date:   Wed, 13 Jul 2022 11:43:50 +0200
Message-Id: <20220713114425.640af05da5be.I968979e66d80dbf8b9352075a6dcc7a366c1ba85@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

Check all the MLO links to decide whether offchannel TX is needed.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/offchannel.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 2ed4e2325914..aff5d3c39902 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -842,10 +842,24 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 
 	/* Check if the operating channel is the requested channel */
 	if (!need_offchan) {
-		struct ieee80211_chanctx_conf *chanctx_conf;
+		struct ieee80211_chanctx_conf *chanctx_conf = NULL;
+		int i;
 
 		rcu_read_lock();
-		chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
+		/* Check all the links first */
+		for (i = 0; i < ARRAY_SIZE(sdata->vif.link_conf); i++) {
+			if (!sdata->vif.link_conf[i])
+				continue;
+
+			chanctx_conf = rcu_dereference(sdata->vif.link_conf[i]->chanctx_conf);
+			if (!chanctx_conf)
+				continue;
+
+			if (ether_addr_equal(sdata->vif.link_conf[i]->addr, mgmt->sa))
+				break;
+
+			chanctx_conf = NULL;
+		}
 
 		if (chanctx_conf) {
 			need_offchan = params->chan &&
-- 
2.36.1

