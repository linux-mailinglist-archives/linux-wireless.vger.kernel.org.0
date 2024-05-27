Return-Path: <linux-wireless+bounces-8127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159F98D07FC
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57712A8D77
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934C516A379;
	Mon, 27 May 2024 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvFKXy6B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C051169393
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826004; cv=none; b=geNhdr8JIPyl3guZyB2BMCBYlnAl+si3buOQLIrulOi0jJHrPZP7ic7fbqF9P6Sd2yPwWkT4jfRdWuQqTjZiXxft1QON8D4+gnvogToFcAlylUagKOkubZo6jZI7oAPI4sQ7jku9Z/mxr4OKlQd/IfFA/Kj7gHWoKISqy7MRlMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826004; c=relaxed/simple;
	bh=EOEOq0/iGJoklaiFsdqU39Tz2VxPfldFvYzX4db6yNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VkqOtWRGCC6oSznI178NiEAmuClqTlCD/JoXdbsk0nA0O8WfVd18NtBJYjKyXe4BMC0ifOnlekAvfBpfGoDKYLz8tL3cuBIifwkac7V/CTTzHO355UDsMFix6wiMPyNrK41Rx4oO5tyE8NYuatQ/SnqOFAh6EyEcJEr9ZCwkYgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvFKXy6B; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716826003; x=1748362003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EOEOq0/iGJoklaiFsdqU39Tz2VxPfldFvYzX4db6yNo=;
  b=WvFKXy6B2Jys352+9xR9seKPj/jfxpue9CQxpQr/DpQFAtxOIJU8UgSb
   NrjIrX/V8vIE/wtmYXfWNTKGPBleJyiBHetESHoaywcpL99T6pAMsvKRS
   9VxckbyHHgnKizOg/1PnVbE6Sdt9gQgj+mZJ9A8EI326nAAZrLTWcZW46
   xaaXiXG7/3IvgEDkEGpAqKfx65lqa0d1z0pAhT6P5M0laQeq5UFi1BECl
   X0sgG1Fq31qOTm+7hYhdaQoEkWx3Kvy+NfZmdkmQi7eo8US7FjDXM/s63
   nAqphYGEaQfTZyvm9r4piVjoiIWMp8Eiwbrku+CgNjUN6sQQVbY6Yr1Gz
   g==;
X-CSE-ConnectionGUID: gbljEAlaRn2WvTdiJCXmdg==
X-CSE-MsgGUID: gey9k+WJSsyMaEybtxKatA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002101"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002101"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:43 -0700
X-CSE-ConnectionGUID: ueQ7FoudQD+uo9uKJoT+CA==
X-CSE-MsgGUID: WceVv1c2TzCpR3fAL6+Wkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407117"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/20] wifi: iwlwifi: mvm: use only beacon BSS load for active links
Date: Mon, 27 May 2024 19:06:08 +0300
Message-Id: <20240527190228.6947dc462fa9.I2076961211d6785c8a15b4308e0e87a413148222@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For active links, don't take information that may have been
received in probe responses, as those are not protected. For
inactive links, there may not be a choice.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      | 14 ++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/tests/links.c   |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 0745229c8c37..02a475a1f1b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -492,17 +492,27 @@ iwl_mvm_get_puncturing_factor(const struct ieee80211_bss_conf *link_conf)
 static unsigned int
 iwl_mvm_get_chan_load(struct ieee80211_bss_conf *link_conf)
 {
+	struct ieee80211_vif *vif = link_conf->vif;
 	struct iwl_mvm_vif_link_info *mvm_link =
 		iwl_mvm_vif_from_mac80211(link_conf->vif)->link[link_conf->link_id];
 	const struct element *bss_load_elem;
 	const struct ieee80211_bss_load_elem *bss_load;
 	enum nl80211_band band = link_conf->chanreq.oper.chan->band;
+	const struct cfg80211_bss_ies *ies;
 	unsigned int chan_load;
 	u32 chan_load_by_us;
 
 	rcu_read_lock();
-	bss_load_elem = ieee80211_bss_get_elem(link_conf->bss,
-					       WLAN_EID_QBSS_LOAD);
+	if (ieee80211_vif_link_active(vif, link_conf->link_id))
+		ies = rcu_dereference(link_conf->bss->beacon_ies);
+	else
+		ies = rcu_dereference(link_conf->bss->ies);
+
+	if (ies)
+		bss_load_elem = cfg80211_find_elem(WLAN_EID_QBSS_LOAD,
+						   ies->data, ies->len);
+	else
+		bss_load_elem = NULL;
 
 	/* If there isn't BSS Load element, take the defaults */
 	if (!bss_load_elem ||
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
index 6a680b5d03e0..47b8e7b64ead 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
@@ -208,6 +208,7 @@ static void setup_link_conf(struct kunit *test)
 	bss_load->channel_util = params->channel_util;
 
 	rcu_assign_pointer(bss.ies, ies);
+	rcu_assign_pointer(bss.beacon_ies, ies);
 }
 
 static void test_link_grading(struct kunit *test)
-- 
2.34.1


