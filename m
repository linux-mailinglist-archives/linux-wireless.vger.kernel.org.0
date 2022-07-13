Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB47057334B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbiGMJp4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbiGMJpS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED00E0279
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Shs8bo+gTKDLdpln9DmHNM551HLaD47nArTrrT1D46s=;
        t=1657705517; x=1658915117; b=fOE1myynOgNwPh2Ngd/jYYnpKWpO0UlamUJnO/ku/N3Qu6L
        5IbFWpS8xADn1+1hOsnuI9oTSnQO2iUYrwIS95FWxLrwbKESJOmUjnheWcqK0wNuX4PDh5tfhPr+6
        KrzGOncvf1wxR2gOQdvi8otSDSnzWAqQAWYr6ml77Ag6pNtR+PExbd2En6DYKQkeZrlIeAFg/7Hio
        qeEhxEzP/0CdSbKrVINjAFK4N7UrFUsvgYxH1KvUUUScU43SOmlefN047sGUjyaEKKq7DnqOPXUMC
        vjxdUUzoxxO8qHcMnf3ZNVmXQ3ZPzspeZPYy8XXm8h6VlyBwD9sv4ZYEZ+dl3bRA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvj-00EgvB-8o;
        Wed, 13 Jul 2022 11:45:15 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 35/76] wifi: mac80211: mlme: use ieee80211_get_link_sband()
Date:   Wed, 13 Jul 2022 11:44:21 +0200
Message-Id: <20220713114425.35973aa556f0.I1394dd82298f09c6cb452be538dba8ba13f11b01@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

This requires a few more changes.

While at it, also add a warning to ieee80211_get_sband()
to avoid it being used when there are multiple links.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/mlme.c        | 12 ++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3e360bcaa03b..a0743c78d171 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1539,6 +1539,8 @@ ieee80211_get_sband(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	enum nl80211_band band;
 
+	WARN_ON(sdata->vif.valid_links);
+
 	rcu_read_lock();
 	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 80a31777922e..edd7f74f1ef3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2264,17 +2264,17 @@ static void ieee80211_stop_poll(struct ieee80211_sub_if_data *sdata)
 	mutex_unlock(&sdata->local->mtx);
 }
 
-static u32 ieee80211_handle_bss_capability(struct ieee80211_sub_if_data *sdata,
+static u32 ieee80211_handle_bss_capability(struct ieee80211_link_data *link,
 					   u16 capab, bool erp_valid, u8 erp)
 {
-	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
+	struct ieee80211_bss_conf *bss_conf = link->conf;
 	struct ieee80211_supported_band *sband;
 	u32 changed = 0;
 	bool use_protection;
 	bool use_short_preamble;
 	bool use_short_slot;
 
-	sband = ieee80211_get_sband(sdata);
+	sband = ieee80211_get_link_sband(link);
 	if (!sband)
 		return changed;
 
@@ -2320,7 +2320,7 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
 
 	bss_info_changed |= BSS_CHANGED_ASSOC;
-	bss_info_changed |= ieee80211_handle_bss_capability(sdata,
+	bss_info_changed |= ieee80211_handle_bss_capability(link,
 		bss_conf->assoc_capability, bss->has_erp_value, bss->erp_value);
 
 	sdata->u.mgd.beacon_timeout = usecs_to_jiffies(ieee80211_tu_to_usec(
@@ -3621,7 +3621,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
-	sband = ieee80211_get_sband(sdata);
+	sband = ieee80211_get_link_sband(link);
 	if (!sband) {
 		mutex_unlock(&sdata->local->sta_mtx);
 		ret = false;
@@ -4429,7 +4429,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	}
 
 	if (!ieee80211_is_s1g_beacon(hdr->frame_control))
-		changed |= ieee80211_handle_bss_capability(sdata,
+		changed |= ieee80211_handle_bss_capability(link,
 				le16_to_cpu(mgmt->u.beacon.capab_info),
 				erp_valid, erp_value);
 
-- 
2.36.1

