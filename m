Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94EF6A05C3
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjBWKMV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjBWKMQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:12:16 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2AF4ECCD
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147132; x=1708683132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R8pjKKSkSqAbZuBVupWApr555qBD+BgHrcSC4TCSTx8=;
  b=b9yyyfmQayeOVuVknfukE/bH5cZCwM433QMH3ckWZCkpUqPBdlK3q8Sy
   naCXmOKphRUUaZJYv4VWwdpLPOcfLW0np46Q5VezMj0XLWtgRh7Y52D9O
   xFdesjztAoCpvQ1AxQ7bQG3XFnw7BYrNuKkrZetqBKlhbP4VE1ofxLnhd
   UxV1YiTs/p+hIkzKmXhpUKMXpsnC+7v7FEj2hDZ1a0OCib/ZvY7aWxU4R
   5KZSyCh63DAn3j5Ve+SIB1Z3ko8joO4a6mbQ1GeY3Qbl56yxAtQqngm50
   M3FRLCeLcxcOV3/ey7jbSY0SrfGRG6jU+m648h2hTi7chNO9PfgGD4u68
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396349"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396349"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796245371"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796245371"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:46 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/21] wifi: mac80211: add support for set_hw_timestamp command
Date:   Thu, 23 Feb 2023 12:09:31 +0200
Message-Id: <20230223114629.05f6b24465ca.Ib2f7c228256ce313a04d3d9f9ecc6c7b9aa602bb@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230223100942.767589-1-gregory.greenman@intel.com>
References: <20230223100942.767589-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Support the set_hw_timestamp callback for enabling and disabling HW
timestamping if the low level driver supports it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/mac80211.h |  6 ++++++
 net/mac80211/cfg.c     | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 219fd15893b0..6946c9d95aec 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4230,6 +4230,9 @@ struct ieee80211_prep_tx_info {
  *	Note that a sta can also be inserted or removed with valid links,
  *	i.e. passed to @sta_add/@sta_state with sta->valid_links not zero.
  *	In fact, cannot change from having valid_links and not having them.
+ * @set_hw_timestamp: Enable/disable HW timestamping of TM/FTM frames. This is
+ *	not restored at HW reset by mac80211 so drivers need to take care of
+ *	that.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4589,6 +4592,9 @@ struct ieee80211_ops {
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta,
 				u16 old_links, u16 new_links);
+	int (*set_hw_timestamp)(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct cfg80211_set_hw_timestamp *hwts);
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 8eb342300868..7e90f4a81962 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4904,6 +4904,22 @@ ieee80211_del_link_station(struct wiphy *wiphy, struct net_device *dev,
 	return ret;
 }
 
+static int ieee80211_set_hw_timestamp(struct wiphy *wiphy,
+				      struct net_device *dev,
+				      struct cfg80211_set_hw_timestamp *hwts)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_local *local = sdata->local;
+
+	if (!local->ops->set_hw_timestamp)
+		return -EOPNOTSUPP;
+
+	if (!check_sdata_in_driver(sdata))
+		return -EIO;
+
+	return local->ops->set_hw_timestamp(&local->hw, &sdata->vif, hwts);
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -5014,4 +5030,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.add_link_station = ieee80211_add_link_station,
 	.mod_link_station = ieee80211_mod_link_station,
 	.del_link_station = ieee80211_del_link_station,
+	.set_hw_timestamp = ieee80211_set_hw_timestamp,
 };
-- 
2.38.1

