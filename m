Return-Path: <linux-wireless+bounces-33736-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEi/OHSswWmUUQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33736-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 22:11:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEEF2FD9F4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 22:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E5C13023300
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 21:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49128369225;
	Mon, 23 Mar 2026 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGQtcYbO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C457D29BD9A
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300200; cv=none; b=GWCy10i9K0kYBo8Rav3q14wniW4JcOBZ48z+7mpmg5ig1XywY9E01FetZZcg0FNQllYADqNQuqT/FBdS0TsI7Wg0DGMgE5w9L2KtGKwO1d+9tgpUw9vO5bINM4iSX6VTzgeBWwPXNLiClQGePR464PwiYV7ZV2K/JljnEzbHSFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300200; c=relaxed/simple;
	bh=dRFy2KWIKa7o5R9KI+cmFEkG3ZJFEwXi9oDGiAK6NJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WTbN6RVK81rZpM891GSGv74prdCzH5rcpZq72BCKVj3mtK4u6/WhyM1llw6FJriuu6JrcKU8fyOPWDLip5+Bu3mCaXN48zGSukAlBNy9fLg8n8jpSOHgiRCr8sROQnzCyB62n63eRiOTBaBaQhsxJTyQIxU1jJ/JyVLFDEPrlTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGQtcYbO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774300198; x=1805836198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dRFy2KWIKa7o5R9KI+cmFEkG3ZJFEwXi9oDGiAK6NJc=;
  b=ZGQtcYbOcCBztd9FtEqnxDw/8HjvQSl8tSK++szA1BXkbD97WDKHl+D4
   Tiyx1lFe9St+1LdVnch+1pNGN2JCjFmXszKsU4/6QZLeXgAjm9w+bidoa
   jSf0/mytnlVrNO4/WcvmxQQx4+d+R2f9pE5ahcjKhPG0oeJb6osB7BCJO
   LI8nXbCocJ3utO37IEDWbswjPLU8rVexTER/f1LMajEdfnPSud3F/xSJB
   e/sRnHMULD5Peh2H8YKsYGDZeFBhm7VQTTGJfoQv5wcFMYujH8c8XIOdb
   lysO9JcWlFly8H4g3hvnsRbh/ZF5VyEkmRT/O5qlmhs4ObqAXKK2Ey24G
   A==;
X-CSE-ConnectionGUID: TI17WwOuQHO6YZP0JNc7dg==
X-CSE-MsgGUID: 7bwsrJjvQvqMj5MzRDJLxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="79163757"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="79163757"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 14:09:58 -0700
X-CSE-ConnectionGUID: tbCF7MKdQC2qe9guUhY8jg==
X-CSE-MsgGUID: C7r2RJtmSjiYmnT033wAAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="254621746"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 14:09:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next] wifi: radiotap: add field for information about observed energy
Date: Mon, 23 Mar 2026 23:09:46 +0200
Message-Id: <20260323230634.9dec62e53f3a.Id8d5f0036705f42e496984c269956088bd85e067@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33736-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,radiotap.org:url]
X-Rspamd-Queue-Id: 5CEEF2FD9F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Benjamin Berg <benjamin.berg@intel.com>

This can be used to report some information about frames that are
duplicated across multiple channels. The reported information may just
be an estimate based on the energy observed on each subchannel. An
example of such duplication are RTS frames that are sent using a legacy
rate but are duplicated into multiple subchannels for compatibility.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/ieee80211_radiotap.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
index 6c2210a253cd..11c1544bc449 100644
--- a/include/net/ieee80211_radiotap.h
+++ b/include/net/ieee80211_radiotap.h
@@ -1,6 +1,6 @@
 /*
  * Copyright (c) 2017		Intel Deutschland GmbH
- * Copyright (c) 2018-2019, 2021-2022, 2025 Intel Corporation
+ * Copyright (c) 2018-2019, 2021-2022, 2025-2026 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -95,6 +95,7 @@ enum ieee80211_radiotap_presence {
 	IEEE80211_RADIOTAP_EXT = 31,
 	IEEE80211_RADIOTAP_EHT_USIG = 33,
 	IEEE80211_RADIOTAP_EHT = 34,
+	IEEE80211_RADIOTAP_OBSERVED_ENERGY = 35,
 	IEEE80211_RADIOTAP_UHR_ELR = 37,
 	IEEE80211_RADIOTAP_UHR = 38,
 };
@@ -604,6 +605,25 @@ enum ieee80211_radiotap_eht_usig_tb {
 	IEEE80211_RADIOTAP_EHT_USIG2_TB_B20_B25_TAIL		= 0xfc000000,
 };
 
+/* for IEEE80211_RADIOTAP_OBSERVED_ENERGY */
+enum ieee80211_radiotap_observed_energy_known {
+	IEEE80211_RADIOTAP_OBSERVED_ENERGY_KNOWN_BW		= 0x0001,
+};
+
+/**
+ * struct ieee80211_radiotap_observed_energy - Observed Energy (type 35)
+ * see www.radiotap.org/fields/observed%20energy.html for details.
+ *
+ * @known: Bitmap indicating which information is present
+ * @bw: The bandwidth in MHz sufficient to contain all subchannels where energy
+ *	likely belonging to the same transmission was observed. This may
+ *	indicate that the transmission was duplicated on multiple channels.
+ */
+struct ieee80211_radiotap_observed_energy {
+	__le16 known;
+	__le16 bw;
+} __packed;
+
 /*
  * ieee80211_radiotap_uhr_elr - content of UHR-ELR TLV (type 35)
  * see https://www.radiotap.org/fields/UHR-ELR for details
-- 
2.34.1


