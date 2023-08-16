Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4080477DBD0
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242773AbjHPILj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242798AbjHPILQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:11:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3373B13E
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=lNgneGpTaj/bLyLMWq3uOLNeRNdL445hGJRAiuKWeCE=; t=1692173475; x=1693383075; 
        b=EC2PRZjvYrrYkNJ5yEwMR/m/lo/T28Kt3IHKVVjMAmagBBnrDr5s6s2lL1dsq9maV66jb3QVRk2
        +hKKs+ESDifkQzJZD+N+6izEUnz61SvAJdVSPzAvS6EPaurIUPM4btb09O68MEpanYEtFA7K5SkEk
        0jrI6pj4xuRxqP9B0QbtntDPjLQM78Kxv14fgi2AO/oBmB0hXqtMAuMa3pF4jFrGY8RuPj6C944XR
        l44gtEAJTeM8U8AWielvZ9P7XoBFzkbcqSmIX4YBxIjQwnptm/G+TGlXJxi/6QLw21Df/9h/rdQpn
        KaWnDGoElhPn+4DWzbsixBuoUrM463GwZzlA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qWBcW-00Abvh-0M;
        Wed, 16 Aug 2023 10:11:12 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Aloka Dixit <quic_alokad@quicinc.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] wifi: mac80211: fix puncturing bitmap handling in CSA
Date:   Wed, 16 Aug 2023 10:11:09 +0200
Message-ID: <20230816101108.9a2a011e3670.I062e026efafb59b026ab72fc7f7fce54f43dd29b@changeid>
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

While at it, switch the code to using the link access to the
data instead of the default bss_conf, even if not all of it
is multi-link capable yet.

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

