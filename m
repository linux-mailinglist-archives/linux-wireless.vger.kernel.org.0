Return-Path: <linux-wireless+bounces-33869-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDzxFGI+xGnZxgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33869-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 20:58:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D59832B859
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 20:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B522C30131FC
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 19:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D0430F93D;
	Wed, 25 Mar 2026 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGHR1Lu5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3033A9C3
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468674; cv=none; b=Z7IuEWiytbUgpHTYjGNXcDutw30zoJAG27O7NbNQI0xyc+hB2cH4yKOABq/ckwrN82fr1gII3JPGs9vjk9Vkd0nA9ZXUKGOOEbY5N6SiUVSdVyYSIS1ukCgSruxkNUEyoZyUS3ZdUP/CvS2gEkSbCCvYKrqy9PAssOOmG2FNJ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468674; c=relaxed/simple;
	bh=krnllAghdLjo4diVkXV0ofGEmqaUXMDDjhFyCG7ESRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SF8DFYM353+oM5RXPhp1ElfOW7L6fzJ4I3JFRXYVJp2c4imrYKg4XBCg+cobaLPE8dIumXTjVTOcZQZewufhzLCehISS1R0G9tQcMeOydzaS+H8sHVRF7mK7IDf84KxGzFr+T0+jzzxvgZfD5vSi2vd8C3oEqVucQ78V1shZYbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EGHR1Lu5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774468673; x=1806004673;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=krnllAghdLjo4diVkXV0ofGEmqaUXMDDjhFyCG7ESRA=;
  b=EGHR1Lu58PSP7vZXxSywZ9ZE43OHACZEJmWzNV5TaVK5+7jNSh8WykAx
   +H5dQBOyU+6IY4tNCRTKU/ergBENiHwy2NJaXilniS8iRPyDTr5FhhXPJ
   CMOwHbYp14Z1B2oAYUWd+3S3p0Sthr4NY4CyQa8gQH4+3yfA+p8+80mXb
   NR3+Lxf9frQItdeakE2WHthWuTzt2gbJs+l4vYJoNodvLy1w7Lq3Y9oPK
   PPGKEOPlYAg42noxDT4FjulmOVazi9ENYjej1CtjIm6SNOU3M0Q1M9fzt
   MKBdMl7JIf7xYVsO1/vXYVnUH1cnCxjPw5O90TZ5n97HTtfhO/R8TPthA
   w==;
X-CSE-ConnectionGUID: JY2DUDULQPS96CtioQIaMQ==
X-CSE-MsgGUID: goNWdlfIQLaGm+hksjQPhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="63066905"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="63066905"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 12:57:52 -0700
X-CSE-ConnectionGUID: HacjwEphQ4W3eQHMv/6EYA==
X-CSE-MsgGUID: eo+4ZsKuThiqMXRVowf98w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="220374993"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 12:57:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v4 wireless-next] wifi: mac80211: ignore reserved bits in reconfiguration status
Date: Wed, 25 Mar 2026 21:57:39 +0200
Message-Id: <20260325215404.ab5ccf4bc62e.I9aef8f4fb6f1b06671bb6cf0e2bd4ec6e4c8bda4@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33869-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 0D59832B859
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Benjamin Berg <benjamin.berg@intel.com>

The Link ID Info field in the Reconfiguration Status Duple subfield of
the Reconfiguration Response frame only uses the lower four bits for the
link ID. The upper bits are reserved and should therefore be ignored.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h |  7 +++++++
 net/mac80211/mlme.c       | 14 ++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)
--
v2: added structs and macros, as required.
v3: fixed Fixes tag
v4: added the requested structures again...

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
index 173a60360a45..7fc5616cb244 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10459,8 +10459,8 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 	pos = mgmt->u.action.ml_reconf_resp.variable;
 	len -= offsetofend(typeof(*mgmt), u.action.ml_reconf_resp);
 
-	/* each status duple is 3 octets */
-	if (len < mgmt->u.action.ml_reconf_resp.count * 3) {
+	if (len < mgmt->u.action.ml_reconf_resp.count *
+				sizeof(struct ieee80211_ml_reconf_status)) {
 		sdata_info(sdata,
 			   "mlo: reconf: unexpected len=%zu, count=%u\n",
 			   len, mgmt->u.action.ml_reconf_resp.count);
@@ -10469,9 +10469,11 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 
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
@@ -10506,8 +10508,8 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
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


