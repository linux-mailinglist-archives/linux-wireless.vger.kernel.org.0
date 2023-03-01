Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3D76A6A8D
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCAKK3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCAKKU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:20 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F45D3647D
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665419; x=1709201419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R8pjKKSkSqAbZuBVupWApr555qBD+BgHrcSC4TCSTx8=;
  b=nKKOmdWETWShO7sE/190tKH8Qj4nf7DGzjggBV8iI8sTaQrXCxyYPif1
   0UKvAH8hwLrUTYODcrearGEY1QaXV2jyy7mx2OyKXa58Y0iJvbFYOJ+Ox
   JNTs4E8uCl3niON6XTpwRq9u9X0lOavR3dpjhDl/yahgj/xqt7zv/DQLS
   4bJdnTaxwQz7zi+6O03hMbzGITC4xajqJ3DLzZdTri1jUnrKwUwY5nzXS
   hlkL4qT8oupbr66/cVeiaYeX7KorYWp58QH9EYWyEmVQE/MiElPBKwElx
   WLMeH3Uyc1I1ok3XrY+6XBkBqWALQd+sVOIvPSlg1dYdk6XCKaQw6rcdD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662846"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662846"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589062"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589062"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:17 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 10/23] wifi: mac80211: add support for set_hw_timestamp command
Date:   Wed,  1 Mar 2023 12:09:22 +0200
Message-Id: <20230301115906.700ded7badde.Ib2f7c228256ce313a04d3d9f9ecc6c7b9aa602bb@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230301100935.170922-1-gregory.greenman@intel.com>
References: <20230301100935.170922-1-gregory.greenman@intel.com>
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

