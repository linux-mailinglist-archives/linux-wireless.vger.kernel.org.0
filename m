Return-Path: <linux-wireless+bounces-25785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C824B0D072
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D40C3B20FB
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 03:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026CA28B7C9;
	Tue, 22 Jul 2025 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UlnBaixM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C824B28B7E5
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 03:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155718; cv=none; b=MQzYInxaOvIeRWTllOZYAhfcat1Q5OZ4swip+420JQm2LoNotLAiwIfXGeWjBoQzKNC8iGyW9Ia4Q7lHm1BH2c0Q8lB/gS9zEitgees04WC4+vOHbnBirHAYyQoNzM6s+q7oNcQYYN3KJsB8gVqHaFUaTzS8TepOoKil0AuA3o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155718; c=relaxed/simple;
	bh=4LgHXbtObKheDq2SdSF+ueGU8ZkouyyX/UvjL/Shu78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ah6ob/ldcHFQaKFKDtJgldU4VU4xczO1R2DmEcFcAShwwiu6UZN0hMtOTIgrIjF351OU2WFRtfmQBgR7gRESjc7+/HcZaLjV1KGF3MhC5fKRGst0Mt/kSxqoY6PfmNLPtCxFT/NomcPHHQIdbCD6nzw4VsioZ1JGXnZsy1HV0fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UlnBaixM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753155716; x=1784691716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4LgHXbtObKheDq2SdSF+ueGU8ZkouyyX/UvjL/Shu78=;
  b=UlnBaixMzXDyaXAr6cnDf8PN2xDEBiBauHIiAZE6DCziu/YSEZan5D1F
   FZWDsLzzQjsljJgFe7p0KUf9dJsQ/tUKKpK7QQy131w4T4NFFGTJfD9Xz
   Kf7ffexiphpLPIldFJ+uxJY3ooXl9SBN6HXv7ODhkZa1M/fWGVyWE1Ls1
   gIMxcw04LUj65wFbPDKDgYLpH1sSyO+ZZZ+jgnjyTFE9Elo7uixG1IYyk
   leU5NqC1HqX2l2Llvh7jjiKJV3gSN7oXITG095sKi0TCJHLhIz5FvRoMk
   +R5bAlNtPE8EZLSgp9zY+8Fjl5GbGf7Da2H5/AYMj+i4IVssZXiizac3K
   g==;
X-CSE-ConnectionGUID: i1TkZmihQGahpTa40pq76w==
X-CSE-MsgGUID: SVG0TfdqQc2DhfrlaP4lAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="43006157"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="43006157"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:56 -0700
X-CSE-ConnectionGUID: fKiPNcvJSBmZKl6K56o44g==
X-CSE-MsgGUID: UXsp7WjsTkKPrnLvxuO3pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159338096"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: mvm: avoid outdated reorder buffer head_sn
Date: Tue, 22 Jul 2025 06:41:16 +0300
Message-Id: <20250722063923.0b53860259d5.I9ec9a3508e7935e8d1833ea3e086066fdefee644@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
References: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
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


