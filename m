Return-Path: <linux-wireless+bounces-20087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31FDA580B1
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 06:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 732EF7A3FF8
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 05:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923E8219FC;
	Sun,  9 Mar 2025 05:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWGUPHXz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AA1178395
	for <linux-wireless@vger.kernel.org>; Sun,  9 Mar 2025 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741498645; cv=none; b=rGnFb2z4YScQ9EoJHXSEpUuZxG0Vn6iChiBp19vJGPajKhCGfHC2RVh0wGzTN3S+DSiut8udCObtEtXmJK7vKPAZhlhs2oseZTXGgOz+giGicjvh+kpYemKpyEGwNJ4y/EZ4JIYwsvZOkVsqk0o/lq2iBOsD32RzeS1zk49ss2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741498645; c=relaxed/simple;
	bh=SkkbjhtychOw9bFaQfslrV9cqDdKjbvYNFAOQTJ4jAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VsoYn96Ui3Tr6FZIa6XNlogo90ao/wl+aP4fMcNsgg+EFVO7dVTlILE+E6gjf8qH5pS/Sq3ZGJPYL8lKzmSfzMCN3x8wKCWKhwxQCAto7Y6Ioxd3pEE3pUAgnwz+3lnX61E/Ky4jczHMBzHd7V9MKqIq961LX3z7rFJFYwrca48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWGUPHXz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741498644; x=1773034644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SkkbjhtychOw9bFaQfslrV9cqDdKjbvYNFAOQTJ4jAs=;
  b=mWGUPHXz4ckMhVfluvJWapPh5jUo5Fd80GL9M73y01a9eDw0c0IzoMIW
   HfdEOndzpvPMcloXbTuyS2uFUZ+IinxbQw6/VnKVBFPFXbtutsinF2ZgA
   1cVOPG41+A21Y9/13sb0fCTk+6o4Qn4MUr3jqAHPzY2mVfnlWgaMyjAXK
   ub2CI+HIrK5BXKDxfecju4FmWs3DeRcacKygX4AYtZdtXYb26wOTh5m0D
   ElX4P+j/B1KV8l0KfB1isGFBCBX6K0MtSBOz3YuqNBKAFEelLOF9qgfVD
   2CQdWGEsiRkKno+c1p0LSQJIgPMqUfYXFQCL7Im/o/A5T8NvMv7NYvZZE
   w==;
X-CSE-ConnectionGUID: XJ/wosFUTR2L/T8IXZek7g==
X-CSE-MsgGUID: v4tSsUb8TCOb6Fj4mnAhvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="41671706"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="41671706"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:23 -0800
X-CSE-ConnectionGUID: 9TOdZBqOS0eS8fn6bmhQbg==
X-CSE-MsgGUID: UQhfFg/5QTChCXPWSdFKcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="150470651"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:22 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 wireless-next 11/15] wifi: iwlwifi: mld: remove AP keys only for AP STA
Date: Sun,  9 Mar 2025 07:36:49 +0200
Message-Id: <20250309073442.f06a4d6eed2b.Icd20af668a22bfae5328eb0ea00ce10a72ce3539@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
References: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

On station interfaces we don't only have the AP STA, but also
TDLS stations. Don't try to remove AP keys for them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Tested-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index f266a81dd29b..994d4561518b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -793,7 +793,7 @@ void iwl_mld_remove_sta(struct iwl_mld *mld, struct ieee80211_sta *sta)
 		 * removed, but FW expects all the keys to be removed before
 		 * the STA is, so remove them all here.
 		 */
-		if (vif->type == NL80211_IFTYPE_STATION)
+		if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 			iwl_mld_remove_ap_keys(mld, vif, sta, link_id);
 
 		/* Remove the link_sta */
-- 
2.34.1


