Return-Path: <linux-wireless+bounces-1410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605AF82222E
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 20:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C811C22A40
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 19:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD467168C8;
	Tue,  2 Jan 2024 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQRpNNFe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1689A168CB
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704224208; x=1735760208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yg70t9nLeqZngK18LZ5A2f/GSbRrjaMl0C7Un/QWypI=;
  b=QQRpNNFeT/yRqyheMoVeuFJ0PK6akvgQXccF+XCD5vvC/ph/ZaTAVCNX
   8PPcKXkyHO+lTkv7TWtJsVFRhQStxGFXQrj8RYp/GdXrrGNFuE9b4O0ma
   iL3R1fVcR63rPqbGMNcT5RqBvni9Qizu2/nPyDjjwEteYZPlFf4q151Cp
   0KjDSNNkUqeTjJT9uQdo1goKfcvhYTIcQ4uCGbqXYLF28PvqgMiecjVD2
   j5CBWEpWD1PZzlUYCGkchuFfFourQnmh/GlS7H+PNsrlIErIWIBkZPF19
   92Uyi+XzC6jsi2LctTg1uEuamqm9Iv/2PxfMPcXkv8J7fyWANWGrw8MR5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463314354"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="463314354"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="898624619"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="898624619"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/15] wifi: cfg80211: validate MLO connections better
Date: Tue,  2 Jan 2024 21:35:44 +0200
Message-Id: <20240102213313.ff83c034cb9a.I9962db0bfa8c73b37b8d5b59a3fad7f02f2129ae@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
References: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When going into an MLO connection, validate that the link IDs
match what userspace indicated, and that the AP MLD addresses
and capabilities are all matching between the links.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h |  24 +++++++
 net/wireless/core.h       |   3 +-
 net/wireless/mlme.c       | 131 ++++++++++++++++++++++++++++++++++----
 net/wireless/nl80211.c    |   3 +-
 net/wireless/sme.c        |   3 +-
 5 files changed, 148 insertions(+), 16 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 61dbee51025d..189f08aefecd 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4934,6 +4934,30 @@ static inline u8 ieee80211_mle_common_size(const u8 *data)
 	return sizeof(*mle) + common + mle->variable[0];
 }
 
+/**
+ * ieee80211_mle_get_link_id - returns the link ID
+ * @data: the basic multi link element
+ *
+ * The element is assumed to be of the correct type (BASIC) and big enough,
+ * this must be checked using ieee80211_mle_type_ok().
+ *
+ * If the BSS link ID can't be found, -1 will be returned
+ */
+static inline int ieee80211_mle_get_link_id(const u8 *data)
+{
+	const struct ieee80211_multi_link_elem *mle = (const void *)data;
+	u16 control = le16_to_cpu(mle->control);
+	const u8 *common = mle->variable;
+
+	/* common points now at the beginning of ieee80211_mle_basic_common_info */
+	common += sizeof(struct ieee80211_mle_basic_common_info);
+
+	if (!(control & IEEE80211_MLC_BASIC_PRES_LINK_ID))
+		return -1;
+
+	return *common;
+}
+
 /**
  * ieee80211_mle_get_bss_param_ch_cnt - returns the BSS parameter change count
  * @mle: the basic multi link element
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 1963958263d2..956ebec51bd6 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -362,7 +362,8 @@ int cfg80211_mlme_auth(struct cfg80211_registered_device *rdev,
 		       struct cfg80211_auth_request *req);
 int cfg80211_mlme_assoc(struct cfg80211_registered_device *rdev,
 			struct net_device *dev,
-			struct cfg80211_assoc_request *req);
+			struct cfg80211_assoc_request *req,
+			struct netlink_ext_ack *extack);
 int cfg80211_mlme_deauth(struct cfg80211_registered_device *rdev,
 			 struct net_device *dev, const u8 *bssid,
 			 const u8 *ie, int ie_len, u16 reason,
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index f635a8b6ca2e..3f90bbe7753d 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -325,28 +325,133 @@ void cfg80211_oper_and_vht_capa(struct ieee80211_vht_cap *vht_capa,
 		p1[i] &= p2[i];
 }
 
-/* Note: caller must cfg80211_put_bss() regardless of result */
-int cfg80211_mlme_assoc(struct cfg80211_registered_device *rdev,
-			struct net_device *dev,
-			struct cfg80211_assoc_request *req)
+static int
+cfg80211_mlme_check_mlo_compat(const struct ieee80211_multi_link_elem *mle_a,
+			       const struct ieee80211_multi_link_elem *mle_b,
+			       struct netlink_ext_ack *extack)
 {
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	int err, i, j;
+	const struct ieee80211_mle_basic_common_info *common_a, *common_b;
 
-	lockdep_assert_wiphy(wdev->wiphy);
+	common_a = (const void *)mle_a->variable;
+	common_b = (const void *)mle_b->variable;
+
+	if (memcmp(common_a->mld_mac_addr, common_b->mld_mac_addr, ETH_ALEN)) {
+		NL_SET_ERR_MSG(extack, "AP MLD address mismatch");
+		return -EINVAL;
+	}
+
+	if (ieee80211_mle_get_eml_med_sync_delay((const u8 *)mle_a) !=
+	    ieee80211_mle_get_eml_med_sync_delay((const u8 *)mle_b)) {
+		NL_SET_ERR_MSG(extack, "link EML medium sync delay mismatch");
+		return -EINVAL;
+	}
+
+	if (ieee80211_mle_get_eml_cap((const u8 *)mle_a) !=
+	    ieee80211_mle_get_eml_cap((const u8 *)mle_b)) {
+		NL_SET_ERR_MSG(extack, "link EML capabilities mismatch");
+		return -EINVAL;
+	}
+
+	if (ieee80211_mle_get_mld_capa_op((const u8 *)mle_a) !=
+	    ieee80211_mle_get_mld_capa_op((const u8 *)mle_b)) {
+		NL_SET_ERR_MSG(extack, "link MLD capabilities/ops mismatch");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cfg80211_mlme_check_mlo(struct net_device *dev,
+				   struct cfg80211_assoc_request *req,
+				   struct netlink_ext_ack *extack)
+{
+	const struct ieee80211_multi_link_elem *mles[ARRAY_SIZE(req->links)] = {};
+	int i;
+
+	if (req->link_id < 0)
+		return 0;
+
+	if (!req->links[req->link_id].bss) {
+		NL_SET_ERR_MSG(extack, "no BSS for assoc link");
+		return -EINVAL;
+	}
+
+	rcu_read_lock();
+	for (i = 0; i < ARRAY_SIZE(req->links); i++) {
+		const struct cfg80211_bss_ies *ies;
+		const struct element *ml;
 
-	for (i = 1; i < ARRAY_SIZE(req->links); i++) {
 		if (!req->links[i].bss)
 			continue;
-		for (j = 0; j < i; j++) {
-			if (req->links[i].bss == req->links[j].bss)
-				return -EINVAL;
+
+		if (ether_addr_equal(req->links[i].bss->bssid, dev->dev_addr)) {
+			NL_SET_ERR_MSG(extack, "BSSID must not be our address");
+			req->links[i].error = -EINVAL;
+			goto error;
 		}
 
-		if (ether_addr_equal(req->links[i].bss->bssid, dev->dev_addr))
-			return -EINVAL;
+		ies = rcu_dereference(req->links[i].bss->ies);
+		ml = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
+					    ies->data, ies->len);
+		if (!ml) {
+			NL_SET_ERR_MSG(extack, "MLO BSS w/o ML element");
+			req->links[i].error = -EINVAL;
+			goto error;
+		}
+
+		if (!ieee80211_mle_type_ok(ml->data + 1,
+					   IEEE80211_ML_CONTROL_TYPE_BASIC,
+					   ml->datalen - 1)) {
+			NL_SET_ERR_MSG(extack, "BSS with invalid ML element");
+			req->links[i].error = -EINVAL;
+			goto error;
+		}
+
+		mles[i] = (const void *)(ml->data + 1);
+
+		if (ieee80211_mle_get_link_id((const u8 *)mles[i]) != i) {
+			NL_SET_ERR_MSG(extack, "link ID mismatch");
+			req->links[i].error = -EINVAL;
+			goto error;
+		}
+	}
+
+	if (WARN_ON(!mles[req->link_id]))
+		goto error;
+
+	for (i = 0; i < ARRAY_SIZE(req->links); i++) {
+		if (i == req->link_id || !req->links[i].bss)
+			continue;
+
+		if (WARN_ON(!mles[i]))
+			goto error;
+
+		if (cfg80211_mlme_check_mlo_compat(mles[req->link_id], mles[i],
+						   extack)) {
+			req->links[i].error = -EINVAL;
+			goto error;
+		}
 	}
 
+	rcu_read_unlock();
+	return 0;
+error:
+	rcu_read_unlock();
+	return -EINVAL;
+}
+
+/* Note: caller must cfg80211_put_bss() regardless of result */
+int cfg80211_mlme_assoc(struct cfg80211_registered_device *rdev,
+			struct net_device *dev,
+			struct cfg80211_assoc_request *req,
+			struct netlink_ext_ack *extack)
+{
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	int err;
+
+	lockdep_assert_wiphy(wdev->wiphy);
+
+	err = cfg80211_mlme_check_mlo(dev, req, extack);
 	if (wdev->connected &&
 	    (!req->prev_bssid ||
 	     !ether_addr_equal(wdev->u.client.connected_addr, req->prev_bssid)))
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5640ac8c72ad..cfabf847024e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -11244,7 +11244,8 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 		struct nlattr *link;
 		int rem = 0;
 
-		err = cfg80211_mlme_assoc(rdev, dev, &req);
+		err = cfg80211_mlme_assoc(rdev, dev, &req,
+					  info->extack);
 
 		if (!err && info->attrs[NL80211_ATTR_SOCKET_OWNER]) {
 			dev->ieee80211_ptr->conn_owner_nlportid =
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 195c8532734b..82e3ce42206c 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -209,7 +209,8 @@ static int cfg80211_conn_do_work(struct wireless_dev *wdev,
 		if (!req.bss) {
 			err = -ENOENT;
 		} else {
-			err = cfg80211_mlme_assoc(rdev, wdev->netdev, &req);
+			err = cfg80211_mlme_assoc(rdev, wdev->netdev,
+						  &req, NULL);
 			cfg80211_put_bss(&rdev->wiphy, req.bss);
 		}
 
-- 
2.34.1


