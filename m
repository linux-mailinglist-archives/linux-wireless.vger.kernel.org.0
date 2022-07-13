Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0681F573329
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbiGMJpR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbiGMJpL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A18FEE1F8
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JdJA/BoOw80ocllxCb1mlD/BYSFA49Ga4jUo8vuSqgg=;
        t=1657705509; x=1658915109; b=ltFow1F0S17p6zMAmcgsyzLphtj3buwj79OMQ4PqkPfTY8A
        e/4Dj2ztFyKTNUpWlVGZuLemdlnI0nq3OPuqZhjgHkuWebzeG7hv9CCw1f7n9R/Nu9q7yIA3Y/e+5
        d5YNnUdnwu1Rf4cR61UKRDJ8/JrmaheqyrGebH75pL98agfkPthmkcjIHiRXBr06oq/v4bQn5Z9Kx
        lATiDmb3YCRuXHdHSinDkH+eapW+n7a0wRYyYHcpIW0PL2cIkcZIkVQ8oSf9CM76ssYc626IPpgFN
        SMldJDZg/dvvjycNo8e6uw3mttCjtSeJLIIj5ZiwibLKpFmWXngHA6kxs+w57RCg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvb-00EgvB-9w;
        Wed, 13 Jul 2022 11:45:07 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 10/76] wifi: mac80211: implement callbacks for <add/mod/del>_link_station
Date:   Wed, 13 Jul 2022 11:43:56 +0200
Message-Id: <20220713114425.f8dd4c9e6ac2.I8705f04cb349065f10fbb27286f5800444be37a6@changeid>
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

From: Shaul Triebitz <shaul.triebitz@intel.com>

Implement callbacks for cfg80211 add_link_station, mod_link_station,
and del_link_station API.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c      | 105 ++++++++++++++++++++++++++++++++++++++++
 net/mac80211/sta_info.c |   7 +++
 net/mac80211/sta_info.h |   1 +
 3 files changed, 113 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a63f9235bcc3..777c133c3f0b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4588,6 +4588,108 @@ static void ieee80211_del_intf_link(struct wiphy *wiphy,
 	ieee80211_vif_set_links(sdata, wdev->valid_links);
 }
 
+static int sta_add_link_station(struct ieee80211_local *local,
+				struct ieee80211_sub_if_data *sdata,
+				struct link_station_parameters *params)
+{
+	struct sta_info *sta;
+	int ret;
+
+	sta = sta_info_get_bss(sdata, params->mld_mac);
+	if (!sta)
+		return -ENOENT;
+
+	ret = ieee80211_sta_allocate_link(sta, params->link_id);
+	if (ret)
+		return ret;
+
+	ret = sta_link_apply_parameters(local, sta, params);
+	if (ret) {
+		ieee80211_sta_free_link(sta, params->link_id);
+		return ret;
+	}
+
+	/* ieee80211_sta_activate_link frees the link upon failure */
+	return ieee80211_sta_activate_link(sta, params->link_id);
+}
+
+static int
+ieee80211_add_link_station(struct wiphy *wiphy, struct net_device *dev,
+			   struct link_station_parameters *params)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_local *local = wiphy_priv(wiphy);
+	int ret;
+
+	mutex_lock(&sdata->local->sta_mtx);
+	ret = sta_add_link_station(local, sdata, params);
+	mutex_unlock(&sdata->local->sta_mtx);
+
+	return ret;
+}
+
+static int sta_mod_link_station(struct ieee80211_local *local,
+				struct ieee80211_sub_if_data *sdata,
+				struct link_station_parameters *params)
+{
+	struct sta_info *sta;
+
+	sta = sta_info_get_bss(sdata, params->mld_mac);
+	if (!sta)
+		return -ENOENT;
+
+	if (!(sta->sta.valid_links & BIT(params->link_id)))
+		return -EINVAL;
+
+	return sta_link_apply_parameters(local, sta, params);
+}
+
+static int
+ieee80211_mod_link_station(struct wiphy *wiphy, struct net_device *dev,
+			   struct link_station_parameters *params)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_local *local = wiphy_priv(wiphy);
+	int ret;
+
+	mutex_lock(&sdata->local->sta_mtx);
+	ret = sta_mod_link_station(local, sdata, params);
+	mutex_unlock(&sdata->local->sta_mtx);
+
+	return ret;
+}
+
+static int sta_del_link_station(struct ieee80211_sub_if_data *sdata,
+				struct link_station_del_parameters *params)
+{
+	struct sta_info *sta;
+
+	sta = sta_info_get_bss(sdata, params->mld_mac);
+	if (!sta)
+		return -ENOENT;
+
+	if (!(sta->sta.valid_links & BIT(params->link_id)))
+		return -EINVAL;
+
+	ieee80211_sta_remove_link(sta, params->link_id);
+
+	return 0;
+}
+
+static int
+ieee80211_del_link_station(struct wiphy *wiphy, struct net_device *dev,
+			   struct link_station_del_parameters *params)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	int ret;
+
+	mutex_lock(&sdata->local->sta_mtx);
+	ret = sta_del_link_station(sdata, params);
+	mutex_unlock(&sdata->local->sta_mtx);
+
+	return ret;
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -4695,4 +4797,7 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.set_radar_background = ieee80211_set_radar_background,
 	.add_intf_link = ieee80211_add_intf_link,
 	.del_intf_link = ieee80211_del_intf_link,
+	.add_link_station = ieee80211_add_link_station,
+	.mod_link_station = ieee80211_mod_link_station,
+	.del_link_station = ieee80211_del_link_station,
 };
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index d738534a709e..a4fa0ce7bd92 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2702,6 +2702,13 @@ static int link_sta_info_hash_add(struct ieee80211_local *local,
 			       link_sta_rht_params);
 }
 
+void ieee80211_sta_free_link(struct sta_info *sta, unsigned int link_id)
+{
+	lockdep_assert_held(&sta->sdata->local->sta_mtx);
+
+	sta_remove_link(sta, link_id, false);
+}
+
 int ieee80211_sta_activate_link(struct sta_info *sta, unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index a1724e366a35..ea0eeee808a5 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -900,6 +900,7 @@ void ieee80211_sta_expire(struct ieee80211_sub_if_data *sdata,
 			  unsigned long exp_time);
 
 int ieee80211_sta_allocate_link(struct sta_info *sta, unsigned int link_id);
+void ieee80211_sta_free_link(struct sta_info *sta, unsigned int link_id);
 int ieee80211_sta_activate_link(struct sta_info *sta, unsigned int link_id);
 void ieee80211_sta_remove_link(struct sta_info *sta, unsigned int link_id);
 
-- 
2.36.1

