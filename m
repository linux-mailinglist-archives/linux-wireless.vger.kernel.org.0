Return-Path: <linux-wireless+bounces-33737-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOYBEGKtwWmUUQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33737-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 22:15:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 305412FDA48
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 22:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C953C302DA16
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 21:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6029A372661;
	Mon, 23 Mar 2026 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPH1C91W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38CE378D6B
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300360; cv=none; b=WzlXyuGfhZNOMyyLRuf6o4TGCufgPylWhRHqJsCfRiiuVFPok202+iUiHDTs+HUaHmWmz62RwXVUGuot1zg8ZFgbJCmhV3e0NSuerPgxX0Fs1CsnOgcNGxrJhZFMa0KzHTrMTupRmDUsl03UUpCUsgcxuJ7141/o/A/tAgM4HVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300360; c=relaxed/simple;
	bh=Bre6fdU2XENHUKZ5hkgvUH6YH9BuXrNPQqmtvnfElr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=doRtV3AsijAWY087QSVpF4EvFWECTV5GEDi4lwUCDjd5hHl4IKqULPyEilZrQYGhcFlJLykN6unb7cUwh5HEnOzmZSgDJbw3p2GmtzBTGNF/xQq2h8wGdZ1VhqOiVzoJlMtuqaT55jHrmvuow7pxOuTF4mv47Yh+6R11HIxBehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPH1C91W; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774300359; x=1805836359;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Bre6fdU2XENHUKZ5hkgvUH6YH9BuXrNPQqmtvnfElr0=;
  b=PPH1C91WFYy2sf/yGZcSRr55RSCymZcP4TWL3AEn1iZO4oymjuBbh9ct
   RdYJQGJxmdny/jecb+rvLGrAATY4yRaAqk/Fd7EqJMV67tgHwE4XQ3qDL
   s5qxmEXVnalTLdJxHxlun/45mLa8TaXZ/v+pV16mTJg80A4ImSX+KOBLq
   uN4yE5psB7ZKcwu8ig065Vi81k+KbdaqpYqqSKeyCSWLPA5ALDTNGJFtW
   qSPtx7JDNe+iqMhEfJLsvD4YLlzJtyLgiMjZ0/omDcQ+NWwyuRpCEKfz/
   rNp9P6tNkTkMSZCBSYb9i62tk8t9CEem76CVbMvI0rg6lfSLaON5CKBXH
   w==;
X-CSE-ConnectionGUID: Hxd2LqeWQTeGVS/ANF6Srw==
X-CSE-MsgGUID: lYUtTRrNRkeHWUxqt/7z3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="92883251"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="92883251"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 14:12:38 -0700
X-CSE-ConnectionGUID: O4+g4wm/SHalm4HCTJeUaQ==
X-CSE-MsgGUID: 7UN3+dYrTWG/3MWNrzhTog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="224118613"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 14:12:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: radiotap: add a field for PHY SERVICE field related data
Date: Mon, 23 Mar 2026 23:12:26 +0200
Message-Id: <20260323231012.c7b1cb1b3405.Ic11e92b56b2b1df6c202ec9442f25bd78206a4e8@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33737-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,radiotap.org:url,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 305412FDA48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Benjamin Berg <benjamin.berg@intel.com>

For certain frames bits are encoded into the DATA field of the PHY
header in a way that cannot be properly reported in other ways. Add a
new field to be able to report the SERVICE field and scrambler
initialization value as well as the bandwidth signalling information
that may be encoded here.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/ieee80211_radiotap.h | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
index 11c1544bc449..34419d4fd898 100644
--- a/include/net/ieee80211_radiotap.h
+++ b/include/net/ieee80211_radiotap.h
@@ -96,6 +96,7 @@ enum ieee80211_radiotap_presence {
 	IEEE80211_RADIOTAP_EHT_USIG = 33,
 	IEEE80211_RADIOTAP_EHT = 34,
 	IEEE80211_RADIOTAP_OBSERVED_ENERGY = 35,
+	IEEE80211_RADIOTAP_SERVICE_FIELD = 36,
 	IEEE80211_RADIOTAP_UHR_ELR = 37,
 	IEEE80211_RADIOTAP_UHR = 38,
 };
@@ -624,6 +625,47 @@ struct ieee80211_radiotap_observed_energy {
 	__le16 bw;
 } __packed;
 
+enum ieee80211_radiotap_service_field_known {
+	IEEE80211_RADIOTAP_SERVICE_FIELD_KNOWN_SERVICE_FIELD	= 0x01,
+	IEEE80211_RADIOTAP_SERVICE_FIELD_KNOWN_SCRAMBLER_INIT	= 0x02,
+	IEEE80211_RADIOTAP_SERVICE_FIELD_KNOWN_DYN_BW_IN_NON_HT	= 0x04,
+	IEEE80211_RADIOTAP_SERVICE_FIELD_KNOWN_CH_BW_IN_NON_HT	= 0x08,
+};
+
+enum ieee80211_radiotap_service_field_flags {
+	IEEE80211_RADIOTAP_SERVICE_FIELD_FLAG_DYN_BW_IN_NON_HT	= 0x01,
+	IEEE80211_RADIOTAP_SERVICE_FIELD_FLAG_SCRAMBLER_INIT_11	= 0x02,
+};
+
+/**
+ * struct ieee80211_radiotap_service_field - SERVICE field information (type 36)
+ * see www.radiotap.org/fields/SERVICE%20field.html for details.
+ *
+ * For certain frames, information may be encoded early in the SERVICE field of
+ * the PHY header. This information may be reported here.
+ *
+ * The DYN_BANDWIDTH_IN_NON_HT and CH_BANDWIDTH_IN_NON_HT may be reported
+ * separately if the other bits cannot be reported. These fields are only valid
+ * for certain frames when bandwidth signalling is in use.
+ *
+ * @known: Bitmap indicating which information is present
+ * @flags: Bitmap of flags
+ * @service_field: SERVICE field, the lower bits are used to store the
+ *	scrambler initialization as the SERVICE field must be all zero there.
+ *	The scrambler initialization may be 7 or 11 bit long depending on the
+ *	PHY type of the frame. If it is 11 bit, then
+ *	%IEEE80211_RADIOTAP_SERVICE_FIELD_FLAG_SCRAMBLER_INIT_11 is set.
+ * @ch_bw_in_non_ht: Value of CH_BANDWIDTH_IN_NON_HT as defined in
+ *	IEEE802.11REVmf-D1.0, Table 17-8 - TXVECTOR parameter
+ *	CH_BANDWIDTH_IN_NON_HT values.
+ */
+struct ieee80211_radiotap_service_field {
+	u8 known;
+	u8 flags;
+	__le16 service_field;
+	u8 ch_bw_in_non_ht;
+} __packed;
+
 /*
  * ieee80211_radiotap_uhr_elr - content of UHR-ELR TLV (type 35)
  * see https://www.radiotap.org/fields/UHR-ELR for details
-- 
2.34.1


