Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFEC5F54DE
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJENBQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJENA5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F961CFF3
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kejRBNsSzCbijVEws28khCIFmKWb5Q+voIF3xu66D4c=;
        t=1664974856; x=1666184456; b=IJZfipf8vO9d4IRhlbroFvvV89Q5wOt3+ggOpNf98z4QxQ6
        7w/+OhvA/nME2LAfTfZV7pgSnIVboXar8k25tH/W9K7asQlfZyvdN8nvrZatOHCGB2VG16vgFXz7P
        MgCWoEu3Xrclm4STrVjr3Gu+udJ74oHWOHbf38T2mYAM9LMJuQYfRAFtNDNIkDpib0DlOpCOzWoST
        pI0FxTqyYhXCP4YLXYxaNRQ0IOwhAGIxxMzi9VlMHG1o7dz+xIyTNLFWpj/PqF/o4uD7UL/oq8bqr
        rEweaAMU4ogn0PLlnuzhm3JT0oAlWbldqil7u5ZNmZACOZuVFvItxpN3qMCB65gQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og418-00G2RL-0F;
        Wed, 05 Oct 2022 15:00:54 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/28] wifi: mac80211: use link_id in ieee80211_change_bss()
Date:   Wed,  5 Oct 2022 15:00:34 +0200
Message-Id: <20221005145226.590dadcad812.I61f4492fce85a5c7717facefeddb20e8528d320c@changeid>
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

We should set the parameters here per link, except
unfortunately ap_isolate, but we can't really change
that anymore so it'll remain a quirk in the API in
that you need to change it on one of the valid links
and it'll apply to all.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 687b4c878d4a..ef5700eac05c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2554,47 +2554,50 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 				struct bss_parameters *params)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_link_data *link;
 	struct ieee80211_supported_band *sband;
 	u32 changed = 0;
 
-	if (!sdata_dereference(sdata->deflink.u.ap.beacon, sdata))
+	link = ieee80211_link_or_deflink(sdata, params->link_id, true);
+	if (IS_ERR(link))
+		return PTR_ERR(link);
+
+	if (!sdata_dereference(link->u.ap.beacon, sdata))
 		return -ENOENT;
 
-	sband = ieee80211_get_sband(sdata);
+	sband = ieee80211_get_link_sband(link);
 	if (!sband)
 		return -EINVAL;
 
 	if (params->use_cts_prot >= 0) {
-		sdata->vif.bss_conf.use_cts_prot = params->use_cts_prot;
+		link->conf->use_cts_prot = params->use_cts_prot;
 		changed |= BSS_CHANGED_ERP_CTS_PROT;
 	}
 	if (params->use_short_preamble >= 0) {
-		sdata->vif.bss_conf.use_short_preamble =
-			params->use_short_preamble;
+		link->conf->use_short_preamble = params->use_short_preamble;
 		changed |= BSS_CHANGED_ERP_PREAMBLE;
 	}
 
-	if (!sdata->vif.bss_conf.use_short_slot &&
+	if (!link->conf->use_short_slot &&
 	    (sband->band == NL80211_BAND_5GHZ ||
 	     sband->band == NL80211_BAND_6GHZ)) {
-		sdata->vif.bss_conf.use_short_slot = true;
+		link->conf->use_short_slot = true;
 		changed |= BSS_CHANGED_ERP_SLOT;
 	}
 
 	if (params->use_short_slot_time >= 0) {
-		sdata->vif.bss_conf.use_short_slot =
-			params->use_short_slot_time;
+		link->conf->use_short_slot = params->use_short_slot_time;
 		changed |= BSS_CHANGED_ERP_SLOT;
 	}
 
 	if (params->basic_rates) {
-		ieee80211_parse_bitrates(sdata->vif.bss_conf.chandef.width,
+		ieee80211_parse_bitrates(link->conf->chandef.width,
 					 wiphy->bands[sband->band],
 					 params->basic_rates,
 					 params->basic_rates_len,
-					 &sdata->vif.bss_conf.basic_rates);
+					 &link->conf->basic_rates);
 		changed |= BSS_CHANGED_BASIC_RATES;
-		ieee80211_check_rate_mask(&sdata->deflink);
+		ieee80211_check_rate_mask(link);
 	}
 
 	if (params->ap_isolate >= 0) {
@@ -2606,30 +2609,29 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 	}
 
 	if (params->ht_opmode >= 0) {
-		sdata->vif.bss_conf.ht_operation_mode =
-			(u16) params->ht_opmode;
+		link->conf->ht_operation_mode = (u16)params->ht_opmode;
 		changed |= BSS_CHANGED_HT;
 	}
 
 	if (params->p2p_ctwindow >= 0) {
-		sdata->vif.bss_conf.p2p_noa_attr.oppps_ctwindow &=
+		link->conf->p2p_noa_attr.oppps_ctwindow &=
 					~IEEE80211_P2P_OPPPS_CTWINDOW_MASK;
-		sdata->vif.bss_conf.p2p_noa_attr.oppps_ctwindow |=
+		link->conf->p2p_noa_attr.oppps_ctwindow |=
 			params->p2p_ctwindow & IEEE80211_P2P_OPPPS_CTWINDOW_MASK;
 		changed |= BSS_CHANGED_P2P_PS;
 	}
 
 	if (params->p2p_opp_ps > 0) {
-		sdata->vif.bss_conf.p2p_noa_attr.oppps_ctwindow |=
+		link->conf->p2p_noa_attr.oppps_ctwindow |=
 					IEEE80211_P2P_OPPPS_ENABLE_BIT;
 		changed |= BSS_CHANGED_P2P_PS;
 	} else if (params->p2p_opp_ps == 0) {
-		sdata->vif.bss_conf.p2p_noa_attr.oppps_ctwindow &=
+		link->conf->p2p_noa_attr.oppps_ctwindow &=
 					~IEEE80211_P2P_OPPPS_ENABLE_BIT;
 		changed |= BSS_CHANGED_P2P_PS;
 	}
 
-	ieee80211_link_info_change_notify(sdata, &sdata->deflink, changed);
+	ieee80211_link_info_change_notify(sdata, link, changed);
 
 	return 0;
 }
-- 
2.37.3

