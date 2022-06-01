Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A9F539E8E
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 09:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350327AbiFAHkZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 03:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350321AbiFAHkI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 03:40:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4136F972BE
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=YpRqZdE/+/b7j9vWq1FHZaqY7Fpd3+VzegIh6LJTuOI=;
        t=1654069207; x=1655278807; b=cJUvV1nYZRkqDkIMWes5jkGFTYNgaoTJCqkn5OUgNgnheXp
        m25d+8qPCkIwyw3tTh4r7tnNnm5JI68ZCINe6gAFN3WH+Do4vvkOHsxAPDZlK+qAMLxO/+F+PB97L
        6X+5oHaJ+rturn0c6GOkNM/A3i2UyMHZNUkWwelQPbf4MOy03QroQvmp3RtJAS9NWf2/zSZfs+4Fk
        cu7YWlEnieWGpzfCqF41NVlB0aMlzS0qfOOc5MAIIbREs00wYFkU/YPgFA7D63197OTNUYreU2ox2
        ucUI/8w/EOh6b/6ARsL1MR7fgqUxtMywf0NWRwpLUak5/DZD3PMaJii8KnePKmZQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nwIxZ-00AJPK-Cg;
        Wed, 01 Jun 2022 09:40:05 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/15] mac80211: correct link config data in tracing
Date:   Wed,  1 Jun 2022 09:39:58 +0200
Message-Id: <20220601093922.4e2c96a3d24d.I2f422bb67b9e7b051a5ef3cee532231e518d0318@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601073958.8345-1-johannes@sipsolutions.net>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
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

From: Johannes Berg <johannes.berg@intel.com>

We need to no longer use bss_conf here, but the per-link data.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/trace.h | 48 +++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 5c941fe4d70a..4c6c02dd697d 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -481,34 +481,36 @@ TRACE_EVENT(drv_link_info_changed,
 	),
 
 	TP_fast_assign(
+		struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
+
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
 		__entry->changed = changed;
 		__entry->link_id = link_id;
-		__entry->shortpre = sdata->vif.bss_conf.use_short_preamble;
-		__entry->cts = sdata->vif.bss_conf.use_cts_prot;
-		__entry->shortslot = sdata->vif.bss_conf.use_short_slot;
-		__entry->enable_beacon = sdata->vif.bss_conf.enable_beacon;
-		__entry->dtimper = sdata->vif.bss_conf.dtim_period;
-		__entry->bcnint = sdata->vif.bss_conf.beacon_int;
-		__entry->assoc_cap = sdata->vif.bss_conf.assoc_capability;
-		__entry->sync_tsf = sdata->vif.bss_conf.sync_tsf;
-		__entry->sync_device_ts = sdata->vif.bss_conf.sync_device_ts;
-		__entry->sync_dtim_count = sdata->vif.bss_conf.sync_dtim_count;
-		__entry->basic_rates = sdata->vif.bss_conf.basic_rates;
-		memcpy(__entry->mcast_rate, sdata->vif.bss_conf.mcast_rate,
+		__entry->shortpre = link_conf->use_short_preamble;
+		__entry->cts = link_conf->use_cts_prot;
+		__entry->shortslot = link_conf->use_short_slot;
+		__entry->enable_beacon = link_conf->enable_beacon;
+		__entry->dtimper = link_conf->dtim_period;
+		__entry->bcnint = link_conf->beacon_int;
+		__entry->assoc_cap = link_conf->assoc_capability;
+		__entry->sync_tsf = link_conf->sync_tsf;
+		__entry->sync_device_ts = link_conf->sync_device_ts;
+		__entry->sync_dtim_count = link_conf->sync_dtim_count;
+		__entry->basic_rates = link_conf->basic_rates;
+		memcpy(__entry->mcast_rate, link_conf->mcast_rate,
 		       sizeof(__entry->mcast_rate));
-		__entry->ht_operation_mode = sdata->vif.bss_conf.ht_operation_mode;
-		__entry->cqm_rssi_thold = sdata->vif.bss_conf.cqm_rssi_thold;
-		__entry->cqm_rssi_hyst = sdata->vif.bss_conf.cqm_rssi_hyst;
-		__entry->channel_width = sdata->vif.bss_conf.chandef.width;
-		__entry->channel_cfreq1 = sdata->vif.bss_conf.chandef.center_freq1;
-		__entry->channel_cfreq1_offset = sdata->vif.bss_conf.chandef.freq1_offset;
-		__entry->qos = sdata->vif.bss_conf.qos;
-		__entry->ps = sdata->vif.bss_conf.ps;
-		__entry->hidden_ssid = sdata->vif.bss_conf.hidden_ssid;
-		__entry->txpower = sdata->vif.bss_conf.txpower;
-		__entry->p2p_oppps_ctwindow = sdata->vif.bss_conf.p2p_noa_attr.oppps_ctwindow;
+		__entry->ht_operation_mode = link_conf->ht_operation_mode;
+		__entry->cqm_rssi_thold = link_conf->cqm_rssi_thold;
+		__entry->cqm_rssi_hyst = link_conf->cqm_rssi_hyst;
+		__entry->channel_width = link_conf->chandef.width;
+		__entry->channel_cfreq1 = link_conf->chandef.center_freq1;
+		__entry->channel_cfreq1_offset = link_conf->chandef.freq1_offset;
+		__entry->qos = link_conf->qos;
+		__entry->ps = link_conf->ps;
+		__entry->hidden_ssid = link_conf->hidden_ssid;
+		__entry->txpower = link_conf->txpower;
+		__entry->p2p_oppps_ctwindow = link_conf->p2p_noa_attr.oppps_ctwindow;
 	),
 
 	TP_printk(
-- 
2.36.1

