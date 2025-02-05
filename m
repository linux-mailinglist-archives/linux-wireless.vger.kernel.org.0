Return-Path: <linux-wireless+bounces-18498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8033A286C8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780FC1885452
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1666122ACD3;
	Wed,  5 Feb 2025 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acsqmpwk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9E22A80C
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748393; cv=none; b=E873jwysD3QvyLxRgXUUGBLoQoFnHoXtuj3j+Rp4i9JAlEPuQ0IVN6ep2s+oeXJjQerqOqkN1pME8XF3S6I+UKLkxouL/5onpSgGvTaJvmIjyAeAB34QyUwJIEDUCnxC0RK37r1vMGMRUrWGy+JELDufGZetahXixaSWn5Ltm4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748393; c=relaxed/simple;
	bh=xyxI2LWjPg+jJGbHlxEwgJArzPq3I3qPFeLsDmhVwM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KpUP6IR1YdK96cUcrCKvHZGItb3NLRTMDmozW0J7OP0AcoMMKNFhSFoWxQVfND1E5eexcwoBLFtsZNJcKAOVaJHwcQ0Sp00DP3fOuMAhvFmhoapNCTOS0wxOjd1mkELz+AEkiRt0tnPX3jXPNRu4vk9K7b25LZNeIWcaPTUGiyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acsqmpwk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748391; x=1770284391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xyxI2LWjPg+jJGbHlxEwgJArzPq3I3qPFeLsDmhVwM0=;
  b=acsqmpwkE5g2OdiiiGOodeXIZrb4UWMKDKqiCqEvDqA8ikkNu/4Zb8C2
   vKRYCUUKghpac+XqC+77E02JvoCsbCxbnes4xVKQ1v4WExO9sQl+LVKd0
   ONTfH/HtEuP/M4yj1rltG+15MdHFc2/hWhL+ZCiy5k7k/bkTvtrXrBpEB
   n5FYWDEu2ILAbrkY0FybEn7upk1GEacoXAKoqcVKo7RLL/IgyDx/2ToFX
   mNpOwVkynirejfazbQ5ax0kpNlkQgYgNlQV8pKj08kpy4YB31dQFpEwYx
   uowE29/nSouNO2chgCNkGMydYR1fhU/33YVhEZmLMSKngcVMdsEcfCD8e
   Q==;
X-CSE-ConnectionGUID: ZfuEphhjQ8WFwcU1YAi9Cw==
X-CSE-MsgGUID: d0Ba3p1PQayPHODkZncs0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43225215"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43225215"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:51 -0800
X-CSE-ConnectionGUID: 0YngMrw5Q8aIqq5AusMxEw==
X-CSE-MsgGUID: jtlD/ThUQqORk3ufYJangg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115845278"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:48 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/17] wifi: ieee80211: Add missing EHT MAC capabilities
Date: Wed,  5 Feb 2025 11:39:14 +0200
Message-Id: <20250205110958.6c1643c345a1.I7405b9c35cb39ae97a52c3fbcc36b0bd81e495dc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
References: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Add missing EHT MAC capabilities definitions.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 8f35a3a5211c..508d466de1cc 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3113,6 +3113,11 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 #define	IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_11454	        2
 
 #define IEEE80211_EHT_MAC_CAP1_MAX_AMPDU_LEN_MASK		0x01
+#define IEEE80211_EHT_MAC_CAP1_EHT_TRS				0x02
+#define IEEE80211_EHT_MAC_CAP1_TXOP_RET				0x04
+#define IEEE80211_EHT_MAC_CAP1_TWO_BQRS				0x08
+#define IEEE80211_EHT_MAC_CAP1_EHT_LINK_ADAPT_MASK		0x30
+#define IEEE80211_EHT_MAC_CAP1_UNSOL_EPCS_PRIO_ACCESS		0x40
 
 /* EHT PHY capabilities as defined in P802.11be_D2.0 section 9.4.2.313.3 */
 #define IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ			0x02
-- 
2.34.1


