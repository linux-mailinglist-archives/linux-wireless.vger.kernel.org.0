Return-Path: <linux-wireless+bounces-19941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4852A55920
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115FF189A164
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 21:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11D0277017;
	Thu,  6 Mar 2025 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DrQHoXTE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B80C26FD9A
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297987; cv=none; b=mrmK5MW+djpMuh8CcXKUxqkMdp7xlJCpCP6ZVJm2+creZZNRST6AxJZQ2tz+HfsrrqfVsB740LpWH54tmBlRmFExih3qXmaIo//kbU9XwH3IVhvXl2NlATUhXAbdTrNsJMPpBzZUd1uX7NvY7I7qrkVy56tb8Qk4/zRJ5WXl6CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297987; c=relaxed/simple;
	bh=rr8E02IV6lje1gSjfdLlNaUtcUQGBcM3VDGs13/96Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PPIQ8m30vEmGC2cQPiuTtm1XuLi+/fL3wtlc4J6THmLMHWyD8sbcLjE3QQrlzImYKHzbJijcLvxvuz7Z23Ww99t+sDDOOF6e8Wze15cjpXpk8/085NLpHsehC3fZVCHrc2myj4v+yLqiTjgcyzjcfrAeO55dHLJwFOyylnYonaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DrQHoXTE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741297986; x=1772833986;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rr8E02IV6lje1gSjfdLlNaUtcUQGBcM3VDGs13/96Dw=;
  b=DrQHoXTEMv+/RcmC+vwQ2h2L9xjRDSfMTS9CHRsdBVdINr2AvcCyz4qD
   UFK2BAliDLTBm3CkMI80puuJZJP92lYP0FPCI6QevwEScYOSs/APefOYm
   kyFqTT/kNvIy+5a6D1ec081RdCjevEZoVZniwEwqBGS14nHyXgVL+eTSK
   nsdZqD2VkV5rl7ngBlobEGrrL0EohFtwlXm5046NbUbu/W4AgQB1eRIJv
   XSF9OWW/4SQguOLX7Y8f3wdIHACY6vsgXEi435kS4osgauObgUBfaKUti
   Bf853f/nXZnthmkow6+K/t6IZroNtrLeeNWvvabuSujQYuDVoV9mRFK78
   Q==;
X-CSE-ConnectionGUID: 5vGPXMuuR2SCp++Kr6CqFw==
X-CSE-MsgGUID: bfk2MOxsR/epWJyu8aHEHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46260506"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="46260506"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:53:06 -0800
X-CSE-ConnectionGUID: MfQ4vi7yRKe7+VILHae/3w==
X-CSE-MsgGUID: GLI4bRbXTP6Z+uTNiTHPpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="118978573"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:53:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2 wireless-next 06/15] wifi: cfg80211: improve supported_selector documentation
Date: Thu,  6 Mar 2025 23:52:53 +0200
Message-Id: <20250306235142.0bf9939a20a4.I502b56111b62ea0be174ae76bd03684ae1d4aefb@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Improve the documentation for supported BSS selectors to make it more
precise.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       | 4 ++--
 include/uapi/linux/nl80211.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)
---
v2: fixed the standart version formatting

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9a4a5c20b568..6f76059c0aa5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3149,10 +3149,10 @@ enum cfg80211_assoc_req_flags {
  *	included in the Current AP address field of the Reassociation Request
  *	frame.
  * @flags:  See &enum cfg80211_assoc_req_flags
- * @supported_selectors: supported selectors in IEEE 802.11 format
+ * @supported_selectors: supported BSS selectors in IEEE 802.11 format
  *	(or %NULL for no change).
  *	If %NULL, then support for SAE_H2E should be assumed.
- * @supported_selectors_len: Length of supported_selectors in octets.
+ * @supported_selectors_len: number of supported BSS selectors
  * @ht_capa:  HT Capabilities over-rides.  Values set in ht_capa_mask
  *	will be used in ht_capa.  Un-supported values will be ignored.
  * @ht_capa_mask:  The bits of ht_capa which are to be used.
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 1cf52bc17ef3..33ec891cf340 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2881,9 +2881,9 @@ enum nl80211_commands {
  * @NL80211_ATTR_VIF_RADIO_MASK: Bitmask of allowed radios (u32).
  *	A value of 0 means all radios.
  *
- * @NL80211_ATTR_SUPPORTED_SELECTORS: supported selectors, array of
- *	supported selectors as defined by IEEE 802.11 7.3.2.2 but without the
- *	length restriction (at most %NL80211_MAX_SUPP_SELECTORS).
+ * @NL80211_ATTR_SUPPORTED_SELECTORS: supported BSS Membership Selectors, array
+ *	of supported selectors as defined by IEEE Std 802.11-2020 9.4.2.3 but
+ *	without the length restriction (at most %NL80211_MAX_SUPP_SELECTORS).
  *	This can be used to provide a list of selectors that are implemented
  *	by the supplicant. If not given, support for SAE_H2E is assumed.
  *
-- 
2.34.1


