Return-Path: <linux-wireless+bounces-22393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AE0AA85F6
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D7D3BD425
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 10:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89B61A5B99;
	Sun,  4 May 2025 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4uRbxLG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4781A1A5BAB
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354423; cv=none; b=XJE8hMhAQLBquk/i6pzEJi7Epq7IC+4kJ1etI8tZAQqiVZFqSJK5ElP1EFscH8PFy5IqUBAjhJxGjwfsgHBK1ETaqx0KtTxyyBCi+AXvT8Uvd0f7miBU8BhFMnn6k+lB8f8hR4ei0tFHro0MrotJvrHSYWhd53ZDqFiitQfCjUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354423; c=relaxed/simple;
	bh=bFIpPgGzOczpZARC6bIDWsLW90Dm3uEXq9LHF+ErQ40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oL32rWfTmDyCImRY3QAEXfowKiZsuCVEQWU2CLtD5e6wnONFthNjNHS3MbCjoVT4wgt+nJ66oUJOjsEK3PcLbV4Jpb5ksPM7o05DtxnmmhLAecLVdpJ2Q9d3mrEW0r5rZrE+Dj+yon+N6eUBgT5At/bofNSTmw+uz20DauLoHe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4uRbxLG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746354422; x=1777890422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bFIpPgGzOczpZARC6bIDWsLW90Dm3uEXq9LHF+ErQ40=;
  b=T4uRbxLGXalGdZ+h5VguBugypgWybHdwcC61J6THpeyB/VLxzQVfANwb
   buSy/vGsKkJbpaBA0EfJNafQDAKn3YBzToNuMnW8IRWjnrF3PUaL/zRnc
   KZewCrYt6+5yAFteu2JrZ6EGS26lsXjrOdFfugJ/DLblPTP/6OG/1Wa7c
   IT8Z3jbMMg88WuCYTy5OJjmlnMTl3aysmGnvfcxVmyHeJHO92WJlMoHAL
   towYuLeBcKDZ4QHDcKiSJOs4pM2EI80qmNiupgD/2HdYxg18wbnfu4Qwp
   7Jp+CLNKrDYBAX6U/UxzEarnXhYmdfP3KrlhxQ2eceuIZ1Om7vhzW9L5O
   A==;
X-CSE-ConnectionGUID: tGwCrv19RECxV2SkN+f+Dg==
X-CSE-MsgGUID: UW2m14bIQmuYPp4psRjovA==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="65511495"
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="65511495"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:27:01 -0700
X-CSE-ConnectionGUID: vuZ6MLQgQcGnASQqpP+g7g==
X-CSE-MsgGUID: IdUpH4C9RByVTbLGWR/nYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="139778886"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:27:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mld: don't report bad EHT rate to mac80211
Date: Sun,  4 May 2025 13:26:23 +0300
Message-Id: <20250504132447.8baf4efec182.Idc0cabf1919c05b35dc2341c08ea88a7157614c4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
References: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In EHT, we shouldn't report a legacy rate to mac80211, that
might just be confusing. Set it to zero, since it's only
really relevant for radiotap.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/tx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index c25222116075..1f018f03a68e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -1013,6 +1013,7 @@ static void iwl_mld_hwrate_to_tx_rate(u32 rate_n_flags,
 		tx_rate->flags |= IEEE80211_TX_RC_VHT_MCS;
 		break;
 	case RATE_MCS_MOD_TYPE_HE:
+	case RATE_MCS_MOD_TYPE_EHT:
 		/* mac80211 cannot do this without ieee80211_tx_status_ext()
 		 * but it only matters for radiotap
 		 */
-- 
2.34.1


