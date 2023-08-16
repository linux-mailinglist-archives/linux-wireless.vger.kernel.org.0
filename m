Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3E477DB99
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242642AbjHPIEg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242526AbjHPIEU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:04:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FDFAB
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=6UMLbhNbdypZ8C8BdQK3EcWirRD95iFojQCclvxCv48=; t=1692173059; x=1693382659; 
        b=VOuNBRbJ5H7Lfigw/fHiE5L4GtxEek5VKDy7l7/MX7gwWN8x0BkXpeh7rOUGe/cOHAKQ3yn6rlO
        yyDX5JqZkIFf5FhlXmE7BHwKsAwfuC7/1fFnHtPzeMmANHhi+I5IcIyiX6Jarn1BlayWrfBPZLSJa
        nrOJ77/gPXtCzI81xncEGvN0rUf6R1YiAl7qEd6umY4ir/TRjqEY9yBlK4GwvW0YI/n0H7trmHCTA
        9l6Lom5fx57muvi3mY5lgy6Z7E4Cl3GtLm1yPBpFN9RZX0d1EwJ2thmpw221FRActsp70kdHSj6rj
        nMJMa4+CLZSMN0XVWX/smPMtIO/Bigu9WnlA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qWBVo-00AbTO-1r;
        Wed, 16 Aug 2023 10:04:16 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Aloka Dixit <quic_alokad@quicinc.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: fix puncturing bitmap handling in CSA
Date:   Wed, 16 Aug 2023 10:04:13 +0200
Message-ID: <20230816100412.e2677a05ffd3.I062e026efafb59b026ab72fc7f7fce54f43dd29b@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Code inspection reveals that we switch the puncturing bitmap
before the real channel switch, since that happens only in
the second round of the worker after the channel context is
switched by ieee80211_link_use_reserved_context().

Fixes: 2cc25e4b2a04 ("wifi: mac80211: configure puncturing bitmap")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e7ac24603892..1657ff09a83a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3648,12 +3648,6 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 	lockdep_assert_held(&local->mtx);
 	lockdep_assert_held(&local->chanctx_mtx);
 
-	if (sdata->vif.bss_conf.eht_puncturing != sdata->vif.bss_conf.csa_punct_bitmap) {
-		sdata->vif.bss_conf.eht_puncturing =
-					sdata->vif.bss_conf.csa_punct_bitmap;
-		changed |= BSS_CHANGED_EHT_PUNCTURING;
-	}
-
 	/*
 	 * using reservation isn't immediate as it may be deferred until later
 	 * with multi-vif. once reservation is complete it will re-schedule the
@@ -3683,6 +3677,12 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 	if (err)
 		return err;
 
+	if (link_data->conf->eht_puncturing != link_data->conf->csa_punct_bitmap) {
+		link_data->conf->eht_puncturing =
+					link_data->conf->csa_punct_bitmap;
+		changed |= BSS_CHANGED_EHT_PUNCTURING;
+	}
+
 	ieee80211_link_info_change_notify(sdata, &sdata->deflink, changed);
 
 	if (sdata->deflink.csa_block_tx) {
-- 
2.41.0

