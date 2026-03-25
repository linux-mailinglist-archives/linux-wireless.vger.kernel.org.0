Return-Path: <linux-wireless+bounces-33876-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG8hEi5SxGljyAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33876-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:22:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C59C332C60F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F871302DF7A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 21:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D235378830;
	Wed, 25 Mar 2026 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUoBk/ci"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5982372EF0
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473360; cv=none; b=NoX6J7cE7NvtAsU8qRX0KZrZFVj34f4G6fA5+e+27TTCOCIwbCP2eK78BBbcRk1qPyf1UQnvR76MAuc/WX3r0ZaSKsLOfSsDV+G6H6fqqVeQ5ADugMZZ32bvSEbJFCKZJw2ZrFRnZKwHCeM6D22K/iIO91qoXBXVpmXRSP5pFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473360; c=relaxed/simple;
	bh=0cmwdBioasnSbKHC17epYKq6jXdsuDdkr6TVr0vr7ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=opiwmNMYZ6GLEdtP847yWsATTRBkLEU8QQ5nzA9AZDPwcPExclFV9dOqSjB7ymksRSUgEfExsi7dhAHJco2l+AK0E1/cO706QcBEByXlCroc65D5W5rISMm4drklNNKzkyYaIMJ+IBL4EVibsfVmIleaqN+pbsVayrtWsTbqxTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUoBk/ci; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774473359; x=1806009359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0cmwdBioasnSbKHC17epYKq6jXdsuDdkr6TVr0vr7ig=;
  b=QUoBk/ciQcoQfFcMTlH9rsjIR9a3Dkan4LfMYO83SzuNxj6NQZvBPEle
   ayESfn0CGRfr+PK5zV0mCZ5qBktOYm1EMEOhNWzdujIiKU60qZPkbITi5
   88w/XSDtjV716Qic5z0DYao2aYoGrg7i66sYJVuqookgnY7i7vVWmzWTE
   MmjgZDZWORbb4f3TdMChn/8x0dVQ4nY6nAIIYIQKyy85aPI+DqR8tDBfR
   grwum5y0qMTVWb2xwUv1Ghysm3qSLT6su6QCEPOeR6tnU9RE6DzGiCR6Z
   53LZ+Pf8bRPkOu1oYSenxdxaVtVs7qhZ0DlBBm5t7y97YcmiEWuvAqT3f
   w==;
X-CSE-ConnectionGUID: ANSQQrurRLGZr7rkd/nIgA==
X-CSE-MsgGUID: ftHM8KaERm6pBKmnrUKniA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75485365"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75485365"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:15:59 -0700
X-CSE-ConnectionGUID: DSxT1adYRWSSQrX9AKFAZw==
X-CSE-MsgGUID: iJFBHLkKQgyQvZw9PwVB9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="224747493"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:15:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 06/15] wifi: mac80211: support open and close for NAN_DATA interfaces
Date: Wed, 25 Mar 2026 23:15:27 +0200
Message-Id: <20260325230443.ae46387faa5e.Ia6724dac6a0e17cb69989dd714d14f4df1c69bef@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325211536.910411-1-miriam.rachel.korenblit@intel.com>
References: <20260325211536.910411-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33876-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C59C332C60F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 92ea8de8a6db..e3a051beba6a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1006,6 +1006,16 @@ struct ieee80211_if_nan {
 	DECLARE_BITMAP(removed_channels, IEEE80211_NAN_MAX_CHANNELS);
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
 
@@ -1204,6 +1214,7 @@ struct ieee80211_sub_if_data {
 		struct ieee80211_if_ocb ocb;
 		struct ieee80211_if_mntr mntr;
 		struct ieee80211_if_nan nan;
+		struct ieee80211_if_nan_data nan_data;
 	} u;
 
 	struct ieee80211_link_data deflink;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 0f3e49cdbb39..507c5e016ec8 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -361,6 +361,17 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
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
@@ -475,6 +486,7 @@ static int ieee80211_open(struct net_device *dev)
 static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_down)
 {
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_sub_if_data *iter;
 	unsigned long flags;
 	struct sk_buff_head freeq;
 	struct sk_buff *skb, *tmp;
@@ -621,6 +633,12 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
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
@@ -636,6 +654,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 			spin_unlock_bh(&sdata->u.nan.de.func_lock);
 		}
 		break;
+	case NL80211_IFTYPE_NAN_DATA:
+		RCU_INIT_POINTER(sdata->u.nan_data.nmi, NULL);
+		fallthrough;
 	default:
 		wiphy_work_cancel(sdata->local->hw.wiphy, &sdata->work);
 		/*
@@ -1384,9 +1405,12 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
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
@@ -1404,8 +1428,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
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
@@ -1524,6 +1548,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		case NL80211_IFTYPE_AP:
 		case NL80211_IFTYPE_MESH_POINT:
 		case NL80211_IFTYPE_OCB:
+		case NL80211_IFTYPE_NAN_DATA:
 			netif_carrier_off(dev);
 			break;
 		case NL80211_IFTYPE_P2P_DEVICE:
@@ -1570,6 +1595,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
  err_stop:
 	if (!local->open_count)
 		drv_stop(local, false);
+	if (sdata->vif.type == NL80211_IFTYPE_NAN_DATA)
+		RCU_INIT_POINTER(sdata->u.nan_data.nmi, NULL);
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		list_del(&sdata->u.vlan.list);
 	/* Might not be initialized yet, but it is harmless */
-- 
2.34.1


