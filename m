Return-Path: <linux-wireless+bounces-33873-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDAUCcBQxGljyAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33873-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:16:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BBB32C516
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AA173068762
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 21:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDCF34EF11;
	Wed, 25 Mar 2026 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jci+exJH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CCA34E762
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473353; cv=none; b=P2KDW+eqAVksRt7lnIUxydyJHYT/soexcNfyhsvAwoub0MCdhDZAtwfAMr4EeL4AHS418+I6z6DcJNWOvohwR/vz+7sVHPRBhZts/ETbHoC/ecqBrqm5fKAHS8trg7YX2pzDmjI+2Zg9nC/DkQ/9WQbgvW2qAE4hFvcrTRrh7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473353; c=relaxed/simple;
	bh=7IXP61NSqiUFrWAbfBZvkSFr7ICvRDwviorUMJUzFrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bzqf6k3lcSi1BDFs240c35OriVlfMpcvrV/tQ402/XxTsskbuCtoUJDGuZGcW6iPLAMQrSeUrch7oxAq3qbowpX5xD28Hyg41crM/BBz2IiLFYCY1bGYPluSGEsAvbixciIpXkMUczn2D/k08WEQYOspOmMK8ZLwh9MJKgjZNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jci+exJH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774473352; x=1806009352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7IXP61NSqiUFrWAbfBZvkSFr7ICvRDwviorUMJUzFrk=;
  b=jci+exJHnGurFSydVt0zsE+wf80epsl7+QM8PORKtGj6Os5PzqWA2ZYz
   jK9GUSg9SpaXwr4OfpaJr/UWjps4j7+gVj0xDOdNFYyKDz9lIBIhJQvs6
   /UnH9V1ZGAnxSJz4dL0axHFGv3be8kMGcd0Vp/nA4AuCySor3TD4+n3WF
   +ZLT5lswwwdjXX6MYtb3IY60xOJcAIvA+vAAH5PeBQD6vSD5lH0TEoY2C
   nm7vTk7hKH4q6ppYcXHA7XX3Ygbv9koYfiqk9e6uuuQyvJ+E6vE12w+Am
   dtG6isoSs12yS+uNicAyb0zti1Iuaj0tkDeW2OjnA8k2lLeXMDtB5ewFs
   A==;
X-CSE-ConnectionGUID: NVBKPvAyToSDCNtQuHoyuQ==
X-CSE-MsgGUID: Z14Tn+YDQxuBkLcQalraiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75485341"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75485341"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:15:52 -0700
X-CSE-ConnectionGUID: Vq9VKIPTR8WjeOzj7rK6ww==
X-CSE-MsgGUID: O1YGjDucRdilx2M+zO0iOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="224747470"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:15:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 02/15] wifi: ieee80211: add more NAN definitions
Date: Wed, 25 Mar 2026 23:15:23 +0200
Message-Id: <20260325230443.2ed225751412.Ie8142cf92fc8c97c744a7c8b0a94ce3da6ff75ec@changeid>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33873-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1BBB32C516
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Benjamin Berg <benjamin.berg@intel.com>

These will be needed to implement NAN synchronization in mac80211_hwsim.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211-nan.h | 37 +++++++++++++++++++++++++++++++++++
 include/linux/ieee80211.h     |  1 +
 2 files changed, 38 insertions(+)

diff --git a/include/linux/ieee80211-nan.h b/include/linux/ieee80211-nan.h
index ebf28ea651f9..455033955e54 100644
--- a/include/linux/ieee80211-nan.h
+++ b/include/linux/ieee80211-nan.h
@@ -37,4 +37,41 @@
 #define NAN_DEV_CAPA_NDPE_SUPPORTED		0x08
 #define NAN_DEV_CAPA_S3_SUPPORTED		0x10
 
+/* NAN attributes, as defined in Wi-Fi Aware (TM) specification 4.0 Table 42 */
+#define NAN_ATTR_MASTER_INDICATION		0x00
+#define NAN_ATTR_CLUSTER_INFO			0x01
+
+struct ieee80211_nan_attr {
+	u8 attr;
+	__le16 length;
+	u8 data[];
+} __packed;
+
+struct ieee80211_nan_master_indication {
+	u8 master_pref;
+	u8 random_factor;
+} __packed;
+
+struct ieee80211_nan_anchor_master_info {
+	union {
+		__le64 master_rank;
+		struct {
+			u8 master_addr[ETH_ALEN];
+			u8 random_factor;
+			u8 master_pref;
+		} __packed;
+	} __packed;
+	u8 hop_count;
+	__le32 ambtt;
+} __packed;
+
+#define for_each_nan_attr(_attr, _data, _datalen)			\
+	for (_attr = (const struct ieee80211_nan_attr *)(_data);	\
+	     (const u8 *)(_data) + (_datalen) - (const u8 *)_attr >=	\
+		(int)sizeof(*_attr) &&					\
+	     (const u8 *)(_data) + (_datalen) - (const u8 *)_attr >=	\
+		(int)sizeof(*_attr) + le16_to_cpu(_attr->length);	\
+	     _attr = (const struct ieee80211_nan_attr *)		\
+		(_attr->data + le16_to_cpu(_attr->length)))
+
 #endif /* LINUX_IEEE80211_NAN_H */
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index b5d649db123f..ffa8f9f77efe 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2240,6 +2240,7 @@ struct ieee80211_multiple_bssid_configuration {
 
 #define WLAN_OUI_WFA			0x506f9a
 #define WLAN_OUI_TYPE_WFA_P2P		9
+#define WLAN_OUI_TYPE_WFA_NAN		0x13
 #define WLAN_OUI_TYPE_WFA_DPP		0x1A
 #define WLAN_OUI_MICROSOFT		0x0050f2
 #define WLAN_OUI_TYPE_MICROSOFT_WPA	1
-- 
2.34.1


