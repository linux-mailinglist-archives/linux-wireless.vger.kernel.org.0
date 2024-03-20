Return-Path: <linux-wireless+bounces-5060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D750B88191A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156231C20DDA
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EB68595A;
	Wed, 20 Mar 2024 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWANN4v9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB08B8626C
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970047; cv=none; b=pLr3UTesANeH5GEw5GnE4ACdIIUcvD83Ej7cWfz1jO70KNn12UoK+bLLdBtQwjVOEOYxh5RHOVlgRd7/Nl1pLrIIlVJimHjTJbb/u3BE+gtEOyd2C/XJIabAHxM9yN2YTP6gSr+T2KzvBepmGXWNndmRkUhcyvjSmE0bsbNoC6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970047; c=relaxed/simple;
	bh=QoCVBNozPPy4vGd1aXHib+J3WiImkToNH0ThTgL27Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=arnqeR24m/4Gi6/d7HFjnzKNgPV4gj5unulcIsqzZtaK6TWc1i7RDLds+h2UIeaXA4b8T7Y6hGHn0wO8iOSAHT5i2y+tPyRad3j9hZ1kszM/qHeYuB6pHoFnTsuBaxtOlyBMo7RyJWI8fppqGc2pp2CoirOojsmfvbPcJu7CEFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWANN4v9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970045; x=1742506045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QoCVBNozPPy4vGd1aXHib+J3WiImkToNH0ThTgL27Tg=;
  b=dWANN4v9juMLXK479rNl1mxiF1xyauoj4EbYVoyoLgOGbrudo438qZ/C
   +5+a/Uu44dCN0ZL0JmTymGBsV4VUlmyk9W/cTjMM4LWobEhdpQm9Jw5/3
   dSDbBjee8fGqt0jBNKEWc6EtME0XiSFapbhqIhDf7GmhEkShPLyGL+NB9
   Xuoiqv+PYlyAmICr2vISE6sTveU8zrDj9p8KBcDlHhTFPyhObkZH1JzXF
   DXg6+YDbgQUoxHHUCpQAiTRU+QdmWFew7xJEt6YjaJ++D+fJrrkactLQq
   uRK9QIb6cFPcdIMxM9ZE7MUVT8NPvU0IvuTezIGUGRkSyyIk3d5yXzLuf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698158"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698158"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184214"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 17/17] wifi: iwlwifi: reconfigure TLC during HW restart
Date: Wed, 20 Mar 2024 23:26:38 +0200
Message-Id: <20240320232419.a00adcfe381a.Ic798beccbb7b7d852dc976d539205353588853b0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
References: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Since the HW restart flow with multi-link is very similar to
the initial association, we do need to reconfigure TLC there.
Remove the check that prevented that.

Fixes: d2d0468f60cd ("wifi: iwlwifi: mvm: configure TLC on link activation")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 5a4973431c8b..32ccc3b883b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -295,13 +295,8 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	 * this needs the phy context assigned (and in FW?), and we cannot
 	 * do it later because it needs to be initialized as soon as we're
 	 * able to TX on the link, i.e. when active.
-	 *
-	 * Firmware restart isn't quite correct yet for MLO, but we don't
-	 * need to do it in that case anyway since it will happen from the
-	 * normal station state callback.
 	 */
-	if (mvmvif->ap_sta &&
-	    !test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
+	if (mvmvif->ap_sta) {
 		struct ieee80211_link_sta *link_sta;
 
 		rcu_read_lock();
-- 
2.34.1


