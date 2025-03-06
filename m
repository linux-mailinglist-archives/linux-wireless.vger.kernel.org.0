Return-Path: <linux-wireless+bounces-19881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1445A54833
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F751719D8
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085FE204879;
	Thu,  6 Mar 2025 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYc+Qp2i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64864209681
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257829; cv=none; b=bav27Q71a9fEzQmiHX4+KgzOlYa46hzef7+/Od7QAdVje+UV8Loss/w8IA4bmqTao+CwpEIanlwLmGQRMptHmSsYNf+XEeEn2P2BHN7BxngSgAVCRtdByTrPkh3LI2stOmqw16Oti08qF7wqTK1hLtk6pYn1Kh/lDKnDAlFd1Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257829; c=relaxed/simple;
	bh=8pLMsaVdsrHpTBd9Nhqae0S+nvAfGbMfiJFFo2jWdSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q79ySWcugXgvayCFWKPgirRbwduE19xNy4ES01QtAHcLi7ZNKn/wE+9Co4KaSHbHYQAz0XKP6ff+JFeiN2Q7ODUGwiQf+JrqFTsQ8o8b+9MMd4LTeeWCOoIl6SJs6Oman5gCY4ZNeA3YKJx882yo4RdZXd4YFQ2i/Wb3DV+Tlvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYc+Qp2i; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257829; x=1772793829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8pLMsaVdsrHpTBd9Nhqae0S+nvAfGbMfiJFFo2jWdSg=;
  b=GYc+Qp2i+EJakn3WQazxjBbOdklRpZkHSJO1HBqGg1ve1nns2/smG8k1
   PfpbxN49r3/L/r6ZBRW+WYf2ibvq927X4SspBm3GJC0qNJrpLXjZ05n8y
   IhaMibaA/D4UCy1S8SgmAa2YHZHNXniBnbNeUj6wMbi7zwQ9/X4/u+se/
   PaOOcqWgReUYobRFA/R3BWotN7y9sxJfjPzyVcGCRMAxx3GbNCceSbnYg
   SqOjYOKYIKoqgR7E3SpvFoUfJ2PqtuMRVs5xweB7eEtYGo9NlYhipjCwR
   0haDvH57Mof6TbmQIL3X/w1vU6gHkoApIeBXiVufI9aJogRO6rKgpLOF5
   A==;
X-CSE-ConnectionGUID: f0bwl4f4QaC6ANNwhBc5bQ==
X-CSE-MsgGUID: ZDnL3cdMQMCX/SiwBe/5XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29844484"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="29844484"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:48 -0800
X-CSE-ConnectionGUID: 9NCIxATVQVSUlUNu1P1Azg==
X-CSE-MsgGUID: oAGw9FHhQRa1VodfJxzmAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118797738"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 06/15] wifi: cfg80211: improve supported_selector documentation
Date: Thu,  6 Mar 2025 12:43:17 +0200
Message-Id: <20250306124057.8ba33932cad6.I502b56111b62ea0be174ae76bd03684ae1d4aefb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
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
index 1cf52bc17ef3..36b9daf98974 100644
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
+ *	of supported selectors as defined by IEEE 802.11 (9.4.2.3 in -2020) but
+ *	without the length restriction (at most %NL80211_MAX_SUPP_SELECTORS).
  *	This can be used to provide a list of selectors that are implemented
  *	by the supplicant. If not given, support for SAE_H2E is assumed.
  *
-- 
2.34.1


