Return-Path: <linux-wireless+bounces-19909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9383DA54A00
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDA3168F25
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C871020CCD6;
	Thu,  6 Mar 2025 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zv3uvsg9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2EC20C48B
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261775; cv=none; b=iAx7y4ghhL7lXbk8V0ZDEnMqsXCUBttVNvwX3h2FzBBMM2M8ZgYTNzJeJW9oXOrvDyDYeLe28mzjqcLwmi7F37JNRcJtjsL6T86By97miM+jCSAW6eDKnrBGKgxbQcWPf5eh08NH1sPM58/KwN7gnTNc1J/N58IddzmgwyJjaRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261775; c=relaxed/simple;
	bh=Fs0s/aimuoS/iHurGf8VxnMtc9mb6hXdFm4hTzV0Yuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QU+PFRNyrxorWtNIiTUFflzYfYPIE4CMHYhdWRyVuFT31ST/KWDhZifvYLvFmCcbbo8/7XXlWWwRWnclR1S99DA15duuLV29Wuvw6eqMLSEAxaObkdWuFW+B0G94SgAKDNiBxG4V2XtU9M73L+ebTKVbMQtK8dlfP9tbzpgXhs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zv3uvsg9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741261775; x=1772797775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fs0s/aimuoS/iHurGf8VxnMtc9mb6hXdFm4hTzV0Yuw=;
  b=Zv3uvsg9RnIj4mUjKEbhkyrSGJ4BBJlhNeHLIcHy7CdT9DdQpyqdre5J
   muNRMfcfLpy+ahwKhK6myzG6pxuNH9zwopw3yKGtwO5BwjAgN0DIqQDgu
   /Iq2qaTUwe5Eq0mSS5DtZsr1sDp7TeArdFpnhSWQbml5y1e/dsr77mJDT
   TTHI51+nDgLiwee6VwUb6OKVBAF9SJOtvAWpr2d0/amkXzVEPaJgspXdd
   Xbf53wiUh43emQ+3nxdmtpnGz54Tv6b4n5nBrsl2oZqX7yyj3W5D4wF6W
   XhiVrdPlO8PQOX6VFDpIQgg3LMKqSZFGU061QvNRe9aidL2rawxsM+wxD
   Q==;
X-CSE-ConnectionGUID: qFI7WWWgQLivqjyHhnDWvQ==
X-CSE-MsgGUID: tQ2WknUtR3GmXI7cI0MDyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52474561"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52474561"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:34 -0800
X-CSE-ConnectionGUID: kqXdlb0oTgqyeF67Xh4GsA==
X-CSE-MsgGUID: dqf7GA6zRNeMrPGGfvFI0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119915587"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:32 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH wireless-next 16/19] wifi: iwlwifi: mvm: fix setting the TK when associated
Date: Thu,  6 Mar 2025 13:48:52 +0200
Message-Id: <20250306134559.136afdbf19fd.Icd19d797e56483c08dd22c55b96fee481c4d2f3d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
References: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

When running secured ranging and the initiator is associated with
the responder, the TK was not set in the range request command.
Fix it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index dfb25b964f0e..a493ef6bedc3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -672,7 +672,11 @@ iwl_mvm_ftm_set_secured_ranging(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 			target.bssid = bssid;
 			target.cipher = cipher;
+			target.tk = NULL;
 			ieee80211_iter_keys(mvm->hw, vif, iter, &target);
+
+			if (!WARN_ON(!target.tk))
+				memcpy(tk, target.tk, TK_11AZ_LEN);
 		} else {
 			memcpy(tk, entry->tk, sizeof(entry->tk));
 		}
-- 
2.34.1


