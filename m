Return-Path: <linux-wireless+bounces-23862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF27AD256E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B103A857D
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939CA21D3CA;
	Mon,  9 Jun 2025 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQTfTU1W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B68621CC71
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493313; cv=none; b=oZ8VUJmg3PizMOoZwBPHWJ5CcDjdOrastaBeXsC7TdIIO902Px+1ceQIqoiiFCOkI10xGG1RuGDqZy4yCgwK3bmnregrXpe9u54D/me0ZvZxR0jeELPWj60ExidSzSknn2yhIMd2swf/kiB80wYFVrdmJoYNlaxV5ILo02QmfDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493313; c=relaxed/simple;
	bh=jT/D2fWrLywyxzA/uyUb+aVoRiYd6oYn1ijCynf0qJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vE2cFxxULUj8k2T2/gtvsv7dqxoOgsmM38GwP69wirVq21xzg9NCtlKmbnGg59Q3pD8VTQFyUT1YoGsx7der5Ka5cmSDaszGXke1p20cUdb1l6AOSG0j+QQpbsabR4hXoZaRvldbPMeMCuZd1AQqCEUN76k6Uq1fRWfN7EoZjLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQTfTU1W; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749493312; x=1781029312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jT/D2fWrLywyxzA/uyUb+aVoRiYd6oYn1ijCynf0qJQ=;
  b=lQTfTU1WzHQeAKx30mJChY4toTJBDTu8PKjqRjCeAJ9uwBtmqzNNkc/I
   87p5ymNLG4wxfigrFvQ/UQ066KIsMbpjrpqq6Upf2NxNkdwR+NKW9pHjG
   fHupvosQ0lAuu9fE5Ws2kdvoPDhahqPt7FWgrgyBvjHlrISGVgFsU6GDw
   c6zyvb+p/UjhrJqZCFnP9zd/Mc9lpyTzP/JFzNLbn2WOU4BQ0ju3lXLEQ
   2u2CgENxFrtQt06CiZJsMpc/3/oxvA4dGkEFR0L/ong0WGN3tqKSv+yRW
   t6GDzai5t4MqL4DevizswYvlWBwUjX03RbvlPMBXX3/4l0AJLdgS/9wbL
   A==;
X-CSE-ConnectionGUID: tVte42StSqKzdrxWTHv67A==
X-CSE-MsgGUID: manrDY5bScmX25KeRBKQOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62237665"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62237665"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:51 -0700
X-CSE-ConnectionGUID: vB/Dn20eR+yKSevjL+h9Aw==
X-CSE-MsgGUID: liNoUaD8RVa76v5Ph0Yu5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146510249"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Itamar Shalev <itamar.shalev@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: mld: respect AUTO_EML_ENABLE in iwl_mld_int_mlo_scan()
Date: Mon,  9 Jun 2025 21:21:09 +0300
Message-Id: <20250609211928.9ecb5c5301d4.I88b37e93d9ba66d4381f4976541b4aca2a20e36e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
References: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Itamar Shalev <itamar.shalev@intel.com>

Respect this flag and don't scan for another link if it is set.

Signed-off-by: Itamar Shalev <itamar.shalev@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.c b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
index 3fce7cd2d512..55d54bf29eae 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
@@ -1809,8 +1809,8 @@ void iwl_mld_int_mlo_scan(struct iwl_mld *mld, struct ieee80211_vif *vif)
 
 	lockdep_assert_wiphy(mld->wiphy);
 
-	if (!vif->cfg.assoc || !ieee80211_vif_is_mld(vif) ||
-	    hweight16(vif->valid_links) == 1)
+	if (!IWL_MLD_AUTO_EML_ENABLE || !vif->cfg.assoc ||
+	    !ieee80211_vif_is_mld(vif) || hweight16(vif->valid_links) == 1)
 		return;
 
 	if (mld->scan.status & IWL_MLD_SCAN_INT_MLO) {
-- 
2.34.1


