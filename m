Return-Path: <linux-wireless+bounces-33952-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBGhIkkMxWn05wQAu9opvQ
	(envelope-from <linux-wireless+bounces-33952-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:36:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE35733383F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB27831A1DCA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762673C1961;
	Thu, 26 Mar 2026 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjtjTYre"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6473BFE34
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520113; cv=none; b=I6YsXWzy5DImN6s8/+Q+UJ/+gmefdKXmtffvse7B0ezgb0er+wXTrll93QoR6n8BZAi+Z7JMhj4rmcEFA9vnx/IAtKUvEoA82PdwXRd2VxCPjU8tdvOxOwoVL5Ez62xvvAyArBvRXnB4MxVmX0xlu6pLeTamkGymQnatuyIeEe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520113; c=relaxed/simple;
	bh=VARwBIGMqWBb2bwa4xzFsNr4HoAChWR4so6pATHLLwo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BuPWO/PgkTe8F5u4NZrpCCc7CleQA2kV4zx00H/9jNQwRWuhxJwY+finS+BzsmWpATtVxc4S1ytMqXDZptCkB3GlaEd7VRRvqGUMVuzoRLKxWoJIq0DwsLQ5Vlhgs8dKhJyXxDltvV1zpGdMxIn0vDpeoBuCRRqh5XBfdeEDBGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XjtjTYre; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774520112; x=1806056112;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=VARwBIGMqWBb2bwa4xzFsNr4HoAChWR4so6pATHLLwo=;
  b=XjtjTYre03w4LGP5bYLQVW3rd9Fbkvv/mycpSzqUSErTGWtmk4WqyekP
   q+/trOn45iuEfwWEoGAreFltQ4+x1Kn7vpmZyYJoH6rwPkgDDJgCkwugl
   lZt45aJ7GgWeyAPcOnnp4axl9O6Lh1ZSZmYqHZSCLvgAaxnZ3rcOFSiiE
   H/ieScvPXVbh8qw/eChAMCnAYTRP50pNG9Ed3VNPiN87TFv2aQcxE7vCL
   byOppxSofTNVlZQxP5uKhcbJsKla7zG5+kTzMTea1nmxf3T7EuHUFo6/Q
   Z93YJIvIvoJLB2o+SFvo8Ubl+jMzwT00hHPBP6HuWs98Fkq4FcSu8YyC+
   g==;
X-CSE-ConnectionGUID: HPoS6bsTTWey1fBrW14K8g==
X-CSE-MsgGUID: lGlqesS9QfWYevEjC7HzBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="87048561"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="87048561"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:10 -0700
X-CSE-ConnectionGUID: nAVN1FAhRqmK+n6Ubdm02g==
X-CSE-MsgGUID: neDmUG/gR1a6PpYrUJkysA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="221653165"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 wireless-next 06/15] wifi: mac80211: support open and close for NAN_DATA interfaces
Date: Thu, 26 Mar 2026 12:14:36 +0200
Message-Id: <20260326121156.a19de68119e5.Ia6724dac6a0e17cb69989dd714d14f4df1c69bef@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
References: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33952-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: DE35733383F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Support opening and closing a NAN_DATA interface.
Track the NAN (NMI) interface, for convenience.
Allow opening an NAN_DATA interface only if the NAN interface is running
(NAN has started).
When closing the NAN interface, make sure all NAN_DATA interfaces are
closed first, and warn if this is not the case.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
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


