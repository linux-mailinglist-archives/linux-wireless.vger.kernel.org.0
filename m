Return-Path: <linux-wireless+bounces-25821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C17B0D4A1
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11A81AA5951
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 08:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B132D94A3;
	Tue, 22 Jul 2025 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U33gyWnC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA922D3A97
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172983; cv=none; b=MLoZlmfrr/xHcopErJTLsWWw9Fi9K0I2lTPo/0sdfkzQKes+A+esTpOwq+Pf2XHqgeWAxzkUbxGy9oNs6XnZViLk8osTIGqs3jQPS9kgFrZFuSoiyK4k6hwm7WD2cQwpy7DuxrrXSMe8y//x+kcdVC8+e8lGrd83FLg6rXuJZAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172983; c=relaxed/simple;
	bh=4LgHXbtObKheDq2SdSF+ueGU8ZkouyyX/UvjL/Shu78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uG/wwUQi9cKW23fbgKhgKWtIGSlzT7UK3mOfheFWyu8/jXIz3hDjCOtPebz6kR7aSCm6ViOgBsENI7XyMEydRuiEqGu7xx43VvkIXqT/XxW+z8eaR9kViWabp5Rh/QhHduyL7xjhkxfqbEXTdmElAwgvl55GkryPZ2AvATVi/IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U33gyWnC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753172982; x=1784708982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4LgHXbtObKheDq2SdSF+ueGU8ZkouyyX/UvjL/Shu78=;
  b=U33gyWnCKO45vIEcvqwT8DhVf2vERyYzBqtp94ydVVE00mxx89AU7E3v
   peqPX5I9vj5On4YcJBZUrpkPyMZLGe/NTFcdgEpNB8DTjnL7eVnUC9Fsi
   hMXcPrhmIUqdY6Ikzga9EUT5Be33uCtXBUMLWAcLxl5BOOGgN/DDBGOPL
   M4bDfDueXIVuwcWjZMGka49o0xLNOvQ/cSlhCO8N2v16MPHnRqZJ7DEM/
   iYgpelRN3iXCjNwINDtr3K3JuCySFVNuu156BftKYmJXImXpdQVMmrnl2
   wpWcK8D/s8rY8DPKUjGTE6PT56UAwvIp9k0SUOvd7yl9p6R1rVaDWtPzW
   A==;
X-CSE-ConnectionGUID: Fq/Z+RGjRxKoDmEuYnwGuQ==
X-CSE-MsgGUID: yxWYkMyhQpOaH4nyvVlvwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55569860"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55569860"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:40 -0700
X-CSE-ConnectionGUID: LHe8OM4GRHeAmw/nfZHGXA==
X-CSE-MsgGUID: DuuKE/03Q6+mf1sTKT8v6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163124261"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: mvm: avoid outdated reorder buffer head_sn
Date: Tue, 22 Jul 2025 11:29:01 +0300
Message-Id: <20250722112718.0b53860259d5.I9ec9a3508e7935e8d1833ea3e086066fdefee644@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
References: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

If no frames are received on a queue for a while, the reorder buffer
head_sn may be an old one. When the next frame that is received on
that queue and buffered is a subframe of an AMSDU but not the last
subframe, it will not update the buffer's head_sn. When the frame
release notification arrives, it will not release the buffered frame
because it will look like the notification's NSSN is lower than the
buffer's head_sn (because of a wraparound).
Fix it by updating the head_sn when the first frame is buffered.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 4b57ca56e1f6..62e76a79f621 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -905,10 +905,15 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	 * already ahead and it will be dropped.
 	 * If the last sub-frame is not on this queue - we will get frame
 	 * release notification with up to date NSSN.
+	 * If this is the first frame that is stored in the buffer, the head_sn
+	 * may be outdated. Update it based on the last NSSN to make sure it
+	 * will be released when the frame release notification arrives.
 	 */
 	if (!amsdu || last_subframe)
 		iwl_mvm_release_frames(mvm, sta, napi, baid_data,
 				       buffer, nssn);
+	else if (buffer->num_stored == 1)
+		buffer->head_sn = nssn;
 
 	spin_unlock_bh(&buffer->lock);
 	return true;
-- 
2.34.1


