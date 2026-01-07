Return-Path: <linux-wireless+bounces-30490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EABCFE5BF
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 555F93053BF6
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F3E342CA7;
	Wed,  7 Jan 2026 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pbp898LQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FE534251F
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795842; cv=none; b=Q1d2YpOlNdltQh7uXDlB8Qcl1bQ7LP6fMy5jKNewLj4bE+3F+ObgnABCPRpEsl9waBfed80Tsj4R3REi4QJO/jtGxClbILTawTALhl7fxBHBWXYGFmhxV/QAE+JJ/lHXx4WegaLZi2bP6tWNgChgKticEgQ2YUXsi038F37dCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795842; c=relaxed/simple;
	bh=bK4i8p2KMAZ0wsIKYZtFAaDqsWYnmq0D71Mqpk05xNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWWphhyAe0qzerT78PnxmqWkSMzm3A+BHgPLGla62JCNqhNebnpRS5dIWEl+LT570fHs9plV830JgM8oBDvAhJveXQomv9bP5NCswG3iYYxkfEWEst/P2olIchWXJISCCtVH2zqHB5W7J7LhJasN464Sr9ZHfkgwF4vGMf728NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pbp898LQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=snR92oS7SBgOMjE+4JZKrdNdzRMODcJil0N9MZ08/BM=;
	t=1767795840; x=1769005440; b=pbp898LQWmZg73yco4jMH3jWdpiGfYanWPS5Ml9/fKxGybq
	Mql0byXbCJiWsEzrXz5j4u0XnFJfSSLRXNuydaVndJPXVCMDVReTAIbgpuRRed3YCTAr36SFJcWFY
	LEUbYtSCG5Hn71GhbG6ZTKIMM60Xk2gW1e8gCtZNKFWCz6Rad009x+++SF0S9t3E8PBdRc72I+ohW
	845+7a9SRergItc3SwgrE9LACzlFM+O9QTVkC9sp0usKvhYbvsjpWzybCi7aU0Uc+uvLyf8jGSIOG
	jv/eujWxndcVtvUaKRgljV7HlXXVSoLjbQhGK7sezPjzTQAaJN2hpwRYDqTuu5cw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUS6-00000005agF-3301;
	Wed, 07 Jan 2026 15:23:59 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 29/46] wifi: mac80211: support open and close for NAN_DATA interfaces
Date: Wed,  7 Jan 2026 15:22:28 +0100
Message-ID: <20260107152325.5b2b3fc230f4.Ia6724dac6a0e17cb69989dd714d14f4df1c69bef@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Support opening and closing a NAN_DATA interface.
Track the NAN (NMI) interface, for convenience.
Allow opening an NAN_DATA interface only if the NAN interface is running
(NAN has started).
When closing the NAN interface, make sure all NAN_DATA interfaces are
closed first, and warn if this is not the case.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 11 +++++++++++
 net/mac80211/iface.c       | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9815b56771c1..1786554f79cb 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1001,6 +1001,16 @@ struct ieee80211_if_nan {
 	} de;
 };
 
+/**
+ * struct ieee80211_if_nan_data - NAN data path state
+ *
+ * @nmi: pointer to the NAN management interface sdata. Used for data path,
+ *	hence RCU.
+ */
+struct ieee80211_if_nan_data {
+	struct ieee80211_sub_if_data __rcu *nmi;
+};
+
 struct ieee80211_link_data_managed {
 	u8 bssid[ETH_ALEN] __aligned(2);
 
@@ -1199,6 +1209,7 @@ struct ieee80211_sub_if_data {
 		struct ieee80211_if_ocb ocb;
 		struct ieee80211_if_mntr mntr;
 		struct ieee80211_if_nan nan;
+		struct ieee80211_if_nan_data nan_data;
 	} u;
 
 	struct ieee80211_link_data deflink;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 3fb09ca49276..f0b973952b6c 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -359,6 +359,17 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
 			     nsdata->vif.type == NL80211_IFTYPE_OCB))
 				return -EBUSY;
 
+			/*
+			 * A NAN DATA interface is correlated to the NAN
+			 * (management) one
+			 */
+			if (iftype == NL80211_IFTYPE_NAN_DATA &&
+			    nsdata->vif.type == NL80211_IFTYPE_NAN) {
+				if (!nsdata->u.nan.started)
+					return -EINVAL;
+				rcu_assign_pointer(sdata->u.nan_data.nmi, nsdata);
+			}
+
 			/*
 			 * Allow only a single IBSS interface to be up at any
 			 * time. This is restricted because beacon distribution
@@ -471,6 +482,7 @@ static int ieee80211_open(struct net_device *dev)
 static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_down)
 {
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_sub_if_data *iter;
 	unsigned long flags;
 	struct sk_buff_head freeq;
 	struct sk_buff *skb, *tmp;
@@ -617,6 +629,12 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		}
 		break;
 	case NL80211_IFTYPE_NAN:
+		/* Check if any open NAN_DATA interfaces */
+		list_for_each_entry(iter, &local->interfaces, list) {
+			WARN_ON(iter->vif.type == NL80211_IFTYPE_NAN_DATA &&
+				ieee80211_sdata_running(iter));
+		}
+
 		/* clean all the functions */
 		if (!(local->hw.wiphy->nan_capa.flags &
 		      WIPHY_NAN_FLAGS_USERSPACE_DE)) {
@@ -632,6 +650,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 			spin_unlock_bh(&sdata->u.nan.de.func_lock);
 		}
 		break;
+	case NL80211_IFTYPE_NAN_DATA:
+		RCU_INIT_POINTER(sdata->u.nan_data.nmi, NULL);
+		fallthrough;
 	default:
 		wiphy_work_cancel(sdata->local->hw.wiphy, &sdata->work);
 		/*
@@ -1376,9 +1397,12 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_OCB:
 	case NL80211_IFTYPE_NAN:
-	case NL80211_IFTYPE_NAN_DATA:
 		/* no special treatment */
 		break;
+	case NL80211_IFTYPE_NAN_DATA:
+		if (WARN_ON(!rcu_access_pointer(sdata->u.nan_data.nmi)))
+			return -ENOLINK;
+		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NUM_NL80211_IFTYPES:
 	case NL80211_IFTYPE_P2P_CLIENT:
@@ -1396,8 +1420,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		res = drv_start(local);
 		if (res) {
 			/*
-			 * no need to worry about AP_VLAN cleanup since in that
-			 * case we can't have open_count == 0
+			 * no need to worry about AP_VLAN/NAN_DATA cleanup since
+			 * in that case we can't have open_count == 0
 			 */
 			return res;
 		}
@@ -1516,6 +1540,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		case NL80211_IFTYPE_AP:
 		case NL80211_IFTYPE_MESH_POINT:
 		case NL80211_IFTYPE_OCB:
+		case NL80211_IFTYPE_NAN_DATA:
 			netif_carrier_off(dev);
 			break;
 		case NL80211_IFTYPE_P2P_DEVICE:
@@ -1562,6 +1587,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
  err_stop:
 	if (!local->open_count)
 		drv_stop(local, false);
+	if (sdata->vif.type == NL80211_IFTYPE_NAN_DATA)
+		RCU_INIT_POINTER(sdata->u.nan_data.nmi, NULL);
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		list_del(&sdata->u.vlan.list);
 	/* Might not be initialized yet, but it is harmless */
-- 
2.52.0


