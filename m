Return-Path: <linux-wireless+bounces-16963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 576C99FF2DE
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D52E18826DB
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB55718052;
	Wed,  1 Jan 2025 05:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4reA0vN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61059175AB
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707973; cv=none; b=TFAx0oeocpHWQvUp/EXjaOSzVm+cFxo6zFcOjCNQSPKJGHVSK+QS/I/tLBFSHFd9LWBXL6zoLUVKFoYaPOpgiJYFIlhaTLqDNP7Xjwu79547l+D0Faaco8eQZyGsRoq/1AqndKNtbVS2TnWwVEdeKPLKtUYnJp+5Oj39wU59M2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707973; c=relaxed/simple;
	bh=MXZUBvYkvHs3qcafVR2OOo+uvAEQAsfilC31i6xcoPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s0oQUz09LXPXK+OND8wLvlAriel3NZz5u5A7GkTt9O5UPcBg4LoiYRzKuehmjgpPqgk3xE2OpA8tAOxSCuA5/ZiuIzr8IOK8QqQaoa12QJ62u2IRM8XCw7oj5haNQauBKzSEWqulADwtTYXeczOuRbhCoJAK7Fh6WwlZeuDh4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4reA0vN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707972; x=1767243972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MXZUBvYkvHs3qcafVR2OOo+uvAEQAsfilC31i6xcoPw=;
  b=L4reA0vNwluQkkH6+YFJVg9ToW5fPoJjOGlDtopQjcugUoJqldJzNE8N
   DKaCOhaYlUMsF7qum6IdnGBmMn4FjdqV7CP+s/kWj/opFEqyGRNiwtWnB
   xL7uIuCRC6Fm6eslJq1OaYJ5s2ewd9e0E8/PqspJxPFnL9/I6+I/WJP1/
   pzh5SGxj1gJZjs1DRIJR3aAyJpjTmGvzegHZPV0cxrO2LOij1Onqvx4tG
   SjObMfqjD5QQiSLlutxxRr3zLG32mM5F1/S8yQcLT9EaMudkkB96C7LGf
   tDZ3RmhqkRwfoRTooxUlQPuhy+4ZcnO1U4wp733D/orEGG2/N4LmpfgST
   A==;
X-CSE-ConnectionGUID: EXffKjd6TDmzlUKHPdAycw==
X-CSE-MsgGUID: QHNF7c1fRr2c7PqairoVvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194434"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194434"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:12 -0800
X-CSE-ConnectionGUID: VR9wBF8bStm/AaLAaHn6Ew==
X-CSE-MsgGUID: 2NPfQ3fLRh6EJru0JiJ4wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618930"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:11 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/19] wifi: mac80211: skip all known membership selectors
Date: Wed,  1 Jan 2025 07:05:33 +0200
Message-Id: <20250101070249.2c19a2dc53db.If187b7d93d8b43a6c70e422c837b7636538fb358@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
References: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The GLK and EPD Selectors are also not rates, so add a new macro for the
minimum value of a selector and test against that instead of the entire
list. Also fix the typo in the EPD selector define.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h | 4 +++-
 net/mac80211/mlme.c       | 9 ++-------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 9c0e2617fe8f..745c3b125d97 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1542,11 +1542,13 @@ struct ieee80211_mgmt {
 #define BSS_MEMBERSHIP_SELECTOR_HT_PHY	127
 #define BSS_MEMBERSHIP_SELECTOR_VHT_PHY	126
 #define BSS_MEMBERSHIP_SELECTOR_GLK	125
-#define BSS_MEMBERSHIP_SELECTOR_EPS	124
+#define BSS_MEMBERSHIP_SELECTOR_EPD	124
 #define BSS_MEMBERSHIP_SELECTOR_SAE_H2E 123
 #define BSS_MEMBERSHIP_SELECTOR_HE_PHY	122
 #define BSS_MEMBERSHIP_SELECTOR_EHT_PHY	121
 
+#define BSS_MEMBERSHIP_SELECTOR_MIN	BSS_MEMBERSHIP_SELECTOR_EHT_PHY
+
 /* mgmt header + 1 byte category code */
 #define IEEE80211_MIN_ACTION_SIZE offsetof(struct ieee80211_mgmt, u.action.u)
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 061d20ace29c..cc9bf79d631f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4745,18 +4745,13 @@ static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 			*have_higher_than_11mbit = true;
 
 		/*
-		 * Skip HT, VHT, HE, EHT and SAE H2E only BSS membership
-		 * selectors since they're not rates.
+		 * Skip membership selectors since they're not rates.
 		 *
 		 * Note: Even though the membership selector and the basic
 		 *	 rate flag share the same bit, they are not exactly
 		 *	 the same.
 		 */
-		if (supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_HT_PHY) ||
-		    supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_VHT_PHY) ||
-		    supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_HE_PHY) ||
-		    supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_EHT_PHY) ||
-		    supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_SAE_H2E))
+		if (supp_rates[i] >= (0x80 | BSS_MEMBERSHIP_SELECTOR_MIN))
 			continue;
 
 		for (j = 0; j < sband->n_bitrates; j++) {
-- 
2.34.1


