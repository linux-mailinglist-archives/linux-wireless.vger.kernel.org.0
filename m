Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECDC539E82
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 09:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347443AbiFAHkH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 03:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344822AbiFAHkF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 03:40:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79F295A0F
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 00:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=M009YxJvc8DyS+CBpo5OXiN9hDwTcLCkbit/XnteBCw=;
        t=1654069204; x=1655278804; b=SxzKZk0pK6xblDhpnAHLPMg0Stg5wONu5CZJJd99ZkcQntC
        rH8B4UuBm2zFhQH2SKjPJ3obTc/N7R6d2nxkt6L+mWhy/Z8vR1cUKBX35OvZCgiNIkJGIZoWc26J0
        zI5WwyGFRulM9NUstoTvOwI+GISdXtMfBXyQue34zuwQl+7xN7oQX8zSOLFrHhFc97fF0FYuZu8s5
        RU0B0UXTvPUKC3+tykij3YknfxUfKbZfD1O1V86/d2j3AqG/Pyece1JKITkgItkoi7ABW9M0mwOuI
        y4CFCil7Qr/yeFSvTJX6zZOqf7aHJoi4JGIFUsgWAqwfRA5MxvO4WctDzeKsnRrA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nwIxV-00AJPK-KN;
        Wed, 01 Jun 2022 09:40:01 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/15] mac80211: add per-link configuration pointer
Date:   Wed,  1 Jun 2022 09:39:45 +0200
Message-Id: <20220601093922.bd2184733906.I673f0eb1514e7d3ef749401f7ee6220276a63ec7@changeid>
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

Add pointers so we can start using link_id throughout the
code, even if for now only link ID 0 is valid, pointing
to the "built-in" bss_conf, which is used by drivers that
are not aware of MLD.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h     |  3 +++
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/iface.c       | 23 +++++++++++++++++++++--
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 831f14b7ca69..e4868bccb446 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1739,6 +1739,8 @@ struct ieee80211_vif_cfg {
  * @cfg: vif configuration, see &struct ieee80211_vif_cfg
  * @bss_conf: BSS configuration for this interface, either our own
  *	or the BSS we're associated to
+ * @link_conf: in case of MLD, the per-link BSS configuration,
+ *	indexed by link ID
  * @addr: address of this interface
  * @p2p: indicates whether this AP or STA interface is a p2p
  *	interface, i.e. a GO or p2p-sta respectively
@@ -1773,6 +1775,7 @@ struct ieee80211_vif {
 	enum nl80211_iftype type;
 	struct ieee80211_vif_cfg cfg;
 	struct ieee80211_bss_conf bss_conf;
+	struct ieee80211_bss_conf *link_conf[IEEE80211_MLD_MAX_NUM_LINKS];
 	u8 addr[ETH_ALEN] __aligned(2);
 	bool p2p;
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 20153957cdee..397b111f006d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1031,6 +1031,7 @@ struct ieee80211_sub_if_data {
 	} u;
 
 	struct ieee80211_link_data deflink;
+	struct ieee80211_link_data *link[IEEE80211_MLD_MAX_NUM_LINKS];
 
 #ifdef CONFIG_MAC80211_DEBUGFS
 	struct {
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 978dfa48e098..04ee525394e9 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1012,6 +1012,23 @@ static void ieee80211_set_default_queues(struct ieee80211_sub_if_data *sdata)
 	sdata->vif.cab_queue = IEEE80211_INVAL_HW_QUEUE;
 }
 
+static void ieee80211_sdata_init(struct ieee80211_local *local,
+				 struct ieee80211_sub_if_data *sdata)
+{
+	sdata->local = local;
+
+	/*
+	 * Initialize the default link, so we can use link_id 0 for non-MLD,
+	 * and that continues to work for non-MLD-aware drivers that use just
+	 * vif.bss_conf instead of vif.link_conf.
+	 *
+	 * Note that we never change this, so if link ID 0 isn't used in an
+	 * MLD connection, we get a separate allocation for it.
+	 */
+	sdata->vif.link_conf[0] = &sdata->vif.bss_conf;
+	sdata->link[0] = &sdata->deflink;
+}
+
 int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 {
 	struct ieee80211_sub_if_data *sdata;
@@ -1031,12 +1048,13 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 		return -ENOMEM;
 
 	/* set up data */
-	sdata->local = local;
 	sdata->vif.type = NL80211_IFTYPE_MONITOR;
 	snprintf(sdata->name, IFNAMSIZ, "%s-monitor",
 		 wiphy_name(local->hw.wiphy));
 	sdata->wdev.iftype = NL80211_IFTYPE_MONITOR;
 
+	ieee80211_sdata_init(local, sdata);
+
 	ieee80211_set_default_queues(sdata);
 
 	ret = drv_add_interface(local, sdata);
@@ -2074,7 +2092,8 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 	/* initialise type-independent data */
 	sdata->wdev.wiphy = local->hw.wiphy;
-	sdata->local = local;
+
+	ieee80211_sdata_init(local, sdata);
 
 	ieee80211_init_frag_cache(&sdata->frags);
 
-- 
2.36.1

