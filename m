Return-Path: <linux-wireless+bounces-3218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D6A84B454
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 13:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322DF2815C7
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 12:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897F81350C9;
	Tue,  6 Feb 2024 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8H9F/Pu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE96131749
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220635; cv=none; b=ZY0TtSxUcof1CcMVFvhaSdFy434AejT4p4jQ+T01b66hQkkoVPyJdJG96D+FayO4Quu1iseeRE+ytXzUbUwlKijlRA4Mh4Ru8GHN0JAiseDCk+HmL1twNDnPrZbUcpTZNOn5PgWhAzhHoAg7sOWKLp7t2jJJagh3APj7Eq8IqWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220635; c=relaxed/simple;
	bh=47PcGrfYbMc2NDql49RIMTL0Rt6o/SqiQhQI5efcEr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sB62mTWWjwS3uOd/T57z9m16JH+LvTbYchU16t5uwSVDVeCQLoelN78HFSRO/96OYBRlpiLANZz923HTWWvMU6upZOrfvg5F+OSJTCVnVxfv7FabY5/5U61UV1U9gWBCOygaLtGplpTc04XxJrFgUqMbkjL2XmitjCZzUMA0+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8H9F/Pu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707220634; x=1738756634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=47PcGrfYbMc2NDql49RIMTL0Rt6o/SqiQhQI5efcEr0=;
  b=J8H9F/PuGFRlq9AOqUxxuUpavbtNObhts7Qiq2abdNhIge0K020vuYJv
   Mq1J+LemH0siu9kbmHHTwaSDHW4OUDz4YsKfdEHcwk54wKArZkXn9+2tx
   oofV+Lq992hLT7CIEzhLi5DXtEv3KW2Z4Gifu4bT0I9kuWsUDAxc0AdVk
   PqfnoQVDN10sz/k0ZFYvM3HRs+iHzTi98h5H7aazKWLJWJHc8+fs7V7iB
   T8d3fUPBrXuoEkj2HZOAWfVxTeC3SNe/dMb7isdxx+AYS0StnDDWRy6if
   JDyxb9ag3BqToMzLamV/A/5FjNBAwImmmM4xvsKvzmd9odlzM+xfBEI2Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="625235"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="625235"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 03:57:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824168050"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="824168050"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 03:57:11 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>,
	Luciano Coelho <luciano.coelho@intel.com>
Subject: [PATCH v2] wifi: iwlwifi: mvm: advertise support for protected ranging negotiation
Date: Tue,  6 Feb 2024 13:57:03 +0200
Message-Id: <20240206135637.9bb7e13ad18c.I578af1c9836e91069ce318b265bd221f42955992@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Advertise support for protected ranging negotiation if the firmware
supports it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: added 'wifi' prefix

 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index bc8d1760f36c..e62fcfd1a65f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -705,6 +705,13 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		}
 	}
 
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, WIDE_ID(LOCATION_GROUP,
+						   TOF_RANGE_REQ_CMD),
+				  IWL_FW_CMD_VER_UNKNOWN) >= 11) {
+		wiphy_ext_feature_set(hw->wiphy,
+				      NL80211_EXT_FEATURE_PROT_RANGE_NEGO_AND_MEASURE);
+	}
+
 	mvm->rts_threshold = IEEE80211_MAX_RTS_THRESHOLD;
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.34.1


