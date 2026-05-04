Return-Path: <linux-wireless+bounces-35823-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK8LL0hk+GlJtgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35823-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 11:18:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D934BAD44
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 11:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5ED663006149
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 09:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC58363C63;
	Mon,  4 May 2026 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmUTRzWH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D22D35BDA0
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777886278; cv=none; b=OWXTIZHKVyI8kFBq2nhfyQlsgLDeQN7Rzaj91gzjoXUql8nGMneipDVEles690j0XTgq89Q3fJM+VmWx3itSK510T2YUWN3QhYRl1Y273HdkDGb+x+fRx3lOyz3pIiTWFDZQHURwxYpp6Vs29/LuHQVA60ejiORgaoA7mzGBcJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777886278; c=relaxed/simple;
	bh=EuDWuiym17FumPo76TXx+m42cbGaFJp7toK6Zl4Az+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=POdbC7Cv4pSE3zFCEtKxCbitvp9ABKtcp7oWBcGjXe6WhkafvwTEKIX2SyMi/jXJ+2eNOKW5NrVoSkh6otL/T2JFXZ3PNcbqpJx8+lBZ6Q7/NySZ2gwu7/7u6IrZ4T6THtlbDV/kmL9JXpLT/Ylceb1YYxn3o9IuVP1J2y6UMdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmUTRzWH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777886275; x=1809422275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EuDWuiym17FumPo76TXx+m42cbGaFJp7toK6Zl4Az+Q=;
  b=OmUTRzWHF+AfC8U6oiQqejldbc98AhOCTdLQ0iXOMioFx7ZWEYS6x13Z
   ob4TWtKQHnok4KeD93geNA2Shf8swA7sJxyspRKHpFf3YdspJgv2LdQ3C
   M4sg754tNfb6L1Etjpc41z+xvRG2nID04feD2DHm/t0w9O17yE9V5oYak
   jrT3K3ltJjufCubRRN4+VEnAjyvKs8EMj0PIvnCR6z7xlYIJSa5OLu9c/
   nEfpHwhm60LQctsUG4N/6HUDLU3HWVDoDLsWQG7Tf4OHQmjuliefDwsfg
   PmGagG1iTMTN6TEGPxfgxftk40ek0leFQDMinjZwLQZy+xLK//ZJKXaG5
   g==;
X-CSE-ConnectionGUID: zS4FsYwsToCtk5t7Ooh7zw==
X-CSE-MsgGUID: MyZGksc7ReasUhmpuHHy1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78446944"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78446944"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 02:17:55 -0700
X-CSE-ConnectionGUID: cMuv3J9DRnanF9b8p7RBCA==
X-CSE-MsgGUID: NMllK8oAQiOT8+VhwLz2LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="240449961"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 02:17:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Israel Kozitz <israel.kozitz@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next] wifi: cfg80211: fix max_channel_switch_time documentation unit
Date: Mon,  4 May 2026 12:17:40 +0300
Message-Id: <20260504121734.d0a0152f7d8c.I47e5c91f7ead4f8006fb13f9194d95a55cf9c398@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66D934BAD44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35823-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Israel Kozitz <israel.kozitz@intel.com>

The max_channel_switch_time field in struct wiphy_nan_capa was documented
as being in milliseconds, but it is actually in microseconds as defined
in the Wi-Fi Aware specification and as indicated in the nl80211
NL80211_NAN_CAPA_MAX_CHANNEL_SWITCH_TIME attribute.

Fix the documentation to say microseconds.

Signed-off-by: Israel Kozitz <israel.kozitz@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a40ab36b8edb..51eded4204cf 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6027,7 +6027,7 @@ enum wiphy_nan_flags {
  *     nibble indicates the number of TX antennas and upper nibble indicates the
  *     number of RX antennas. Value 0 indicates the information is not
  *     available.
- * @max_channel_switch_time: maximum channel switch time in milliseconds.
+ * @max_channel_switch_time: maximum channel switch time in microseconds.
  * @dev_capabilities: NAN device capabilities as defined in Wi-Fi Aware (TM)
  *     specification Table 79 (Capabilities field).
  * @phy: Band-agnostic capabilities for NAN data interfaces. Since NAN
-- 
2.34.1


