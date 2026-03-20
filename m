Return-Path: <linux-wireless+bounces-33580-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FoRGhgEvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33580-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:23:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C78082D7290
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07DEF30672DB
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8432EBB99;
	Fri, 20 Mar 2026 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Co0zB0N+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F181A34572B
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994772; cv=none; b=P7a1hJLg17GiLu4hWoy3A1HyRFo452aZPCq2RNE9nKHTz0wCIgt7jRlJiDs6pXVfUYoNp8bRXi2IIByEmwgq6hHAERZIdo+yb7MB0jJEs1NwoHzGRxZiRLiLsF7Aarl4eRZfMCTtiuYTRdpMSfJwqXQPbZHdHYPnAJIt9Aino2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994772; c=relaxed/simple;
	bh=ebkAvcA+o38UU2rheNWD6zSdy/4VmoaO3B5sJ5qhK4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i0+pHplDC6GeuIe7N4Taqg67MX0bhjwQLBktc/nLAw9xzo4A8bp9wmoYm4l6SXogI85/Ox1uEKAnv/ZK4XllxXCE1TFkAJDyrltqboahjdfT4dHbuYifGgbivG0RI2tZv1cNsxdVbQE1xEP1rnlNVhvOMLZAi26XESF1GnFLg6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Co0zB0N+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994771; x=1805530771;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ebkAvcA+o38UU2rheNWD6zSdy/4VmoaO3B5sJ5qhK4Q=;
  b=Co0zB0N+JPM57pc0pIL90SXJo2v0zzRGux9sVe6bjmTDD2+9mNRR86c/
   knlSLU1Qin3/R2DVSD2AcShgxGuheRAYaQbBYTL/GWTIJMrtu7zgSRWoo
   Q0twMJMxaxlu1MzRqh4V3FDROcfnCWwf2KnoxvrtHDIR7OjyaZq+ZYau5
   41WrusrsxcDfHYnwsVuGjHd58X8p94Ga+n4tx2+7kseZ1WtCbJ5d5lN+g
   4a/98R3bnmVKVV0SSvwmIqz8bLTmzipAw0GkqM5TvSqB8aaQ0RUJC1yWN
   flHQsGfJ/I6comeh48Xaq89x4xRvfBOc4sJPanQsZiwdHooGBu1fn0iAN
   Q==;
X-CSE-ConnectionGUID: moZI1apcQFG/yXmn6ZjoLw==
X-CSE-MsgGUID: D5/IKl0YQPK7gWJaMNXecw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74967415"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74967415"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:19:31 -0700
X-CSE-ConnectionGUID: FtNH3dgqToyklMMRJEAZ/w==
X-CSE-MsgGUID: yUJszA2oRBm4zfY53pHPPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223205719"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:19:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2 wireless-next] wifi: mac80211: ignore reserved bits in reconfiguration status
Date: Fri, 20 Mar 2026 10:19:18 +0200
Message-Id: <20260320101841.4f7b6cc3e322.I9aef8f4fb6f1b06671bb6cf0e2bd4ec6e4c8bda4@changeid>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33580-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C78082D7290
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Benjamin Berg <benjamin.berg@intel.com>

The Link ID Info field in the Reconfiguration Status Duple subfield of
the Reconfiguration Response frame only uses the lower four bits for the
link ID. The upper bits are reserved and should therefore be ignored.

Fixes: 529766edcdbd ("wifi: mac80211: Support dynamic link addition and removal")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h |  7 +++++++
 net/mac80211/mlme.c       | 14 ++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

--
v2: added structs and macros, as required.

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 52db36120314..b5d649db123f 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1194,6 +1194,13 @@ struct ieee80211_mgmt {
 
 #define IEEE80211_MIN_ACTION_SIZE(type)	offsetofend(struct ieee80211_mgmt, u.action.type)
 
+/* Link Reconfiguration Status Duple field */
+struct ieee80211_ml_reconf_status {
+	u8 info;
+	__le16 status;
+} __packed;
+
+#define IEEE80211_ML_RECONF_LINK_ID_MASK	0xf
 
 /* Management MIC information element (IEEE 802.11w) for CMAC */
 struct ieee80211_mmie {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0cd8d07bf668..d40b7d43b14d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10458,8 +10458,8 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 	pos = mgmt->u.action.ml_reconf_resp.variable;
 	len -= offsetofend(typeof(*mgmt), u.action.ml_reconf_resp);
 
-	/* each status duple is 3 octets */
-	if (len < mgmt->u.action.ml_reconf_resp.count * 3) {
+	if (len < mgmt->u.action.ml_reconf_resp.count *
+				sizeof(struct ieee80211_ml_reconf_status)) {
 		sdata_info(sdata,
 			   "mlo: reconf: unexpected len=%zu, count=%u\n",
 			   len, mgmt->u.action.ml_reconf_resp.count);
@@ -10468,9 +10468,11 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 
 	link_mask = sta_changed_links;
 	for (i = 0; i < mgmt->u.action.ml_reconf_resp.count; i++) {
-		u16 status = get_unaligned_le16(pos + 1);
+		struct ieee80211_ml_reconf_status *reconf_status = (void *)pos;
+		u16 status = le16_to_cpu(reconf_status->status);
 
-		link_id = *pos;
+		link_id = u8_get_bits(reconf_status->info,
+				      IEEE80211_ML_RECONF_LINK_ID_MASK);
 
 		if (!(link_mask & BIT(link_id))) {
 			sdata_info(sdata,
@@ -10505,8 +10507,8 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 			sdata->u.mgd.reconf.added_links &= ~BIT(link_id);
 		}
 
-		pos += 3;
-		len -= 3;
+		pos += sizeof(*reconf_status);
+		len -= sizeof(*reconf_status);
 	}
 
 	if (link_mask) {
-- 
2.34.1


