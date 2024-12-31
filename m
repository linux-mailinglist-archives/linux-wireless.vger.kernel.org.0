Return-Path: <linux-wireless+bounces-16947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B33E19FEF46
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 13:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECD71882E95
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 12:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0579199FC9;
	Tue, 31 Dec 2024 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SuYf992l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6A6192590
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646392; cv=none; b=tZQWtDCn8RHkU2Y/yFoSZfXTo9XneIJzGMx6ZijFo2pXN3JC+slPu3kgAiI1J0r9r2g6YKA/+RZ+gfr2ZXD2q3E1K1XA5K9FZr9VS6uXhO2+T/a+yOD/0GNIMvg7gaRcMW6m5GW4bQHPLAhxKvxOjeXO4aN76cCcMs5d2oM85to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646392; c=relaxed/simple;
	bh=dCcLXNoTAqdjFdSCCeuhRTAiRLDmG9eKd3xNY0G6Q90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bVcy0mFEt6BGgG+dXo5m2Uzs7huGRTF+SpBn6eEv7hXoTeazg/iCUn+EvE751M9FMiUVVofQgKH3iS0iKeKDuxf+8Xq4OxJZKkwkD5r6+shuDJXH0oEhii/sARuMLtC5ltdCfiVK6Vcc4IzCzocA/v9TEdWMpu/Eo7eOLzePU5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SuYf992l; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735646391; x=1767182391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dCcLXNoTAqdjFdSCCeuhRTAiRLDmG9eKd3xNY0G6Q90=;
  b=SuYf992lrtMqhAT0TIZT62GE11Yjh3ucujvtjH5aXT5KMObdLNzgw/lw
   ESDG4933Sj8MCproh/UdkCEqpGVbjJwYGJ2VENy2gDdvvZXJLvntYvEc8
   fT4btafJiu6fAb9wOu1lXPPZtSz++CsPmmJGf/KfBqjRUr3LCBwaDoTbL
   4F5TJ669FPrKRqejT0n+neshth8StnTAbpIId2oBSH4vFnotW4iaMyV2C
   bLzOSfzV4e53J2A0yCeubuyQr7ylNSSAOk4A4XJ/vU42UXi/5GyIIiEbp
   ZqoQJs3rTLUxzGNtxg0FLnRVGLGDBlZTDUVOoGgI06xmzPvAM3GoZIRX8
   A==;
X-CSE-ConnectionGUID: /hiKRdJOSRu40p43YI4hbg==
X-CSE-MsgGUID: HZa2OXYgQ0m1gOk3Rf4wIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53330205"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="53330205"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:51 -0800
X-CSE-ConnectionGUID: tzWoEbWlSZevJxdHcli4aw==
X-CSE-MsgGUID: R8MDOVKYQeixeVlZvXOkBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138380360"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:50 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: rename iwl_datapath_monitor_notif::mac_id to link_id
Date: Tue, 31 Dec 2024 13:59:15 +0200
Message-Id: <20241231135726.a3d07be17fb1.Ib8a623af099b9b0f2b8d552fca546c476a69a82d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
References: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The FW really sends the link_id here. Rename it, while leaving a FIXME
in iwlmvm.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c         | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 2ab38eaeb290..570a3f722510 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -391,7 +391,7 @@ enum iwl_datapath_monitor_notif_type {
 
 struct iwl_datapath_monitor_notif {
 	__le32 type;
-	u8 mac_id;
+	u8 link_id;
 	u8 reserved[3];
 } __packed; /* MONITOR_NTF_API_S_VER_1 */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index f5ff700d0665..984f407f7027 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -208,7 +208,8 @@ static void iwl_mvm_rx_monitor_notif(struct iwl_mvm *mvm,
 	if (notif->type != cpu_to_le32(IWL_DP_MON_NOTIF_TYPE_EXT_CCA))
 		return;
 
-	vif = iwl_mvm_get_vif_by_macid(mvm, notif->mac_id);
+	/* FIXME: should fetch the link and not the vif */
+	vif = iwl_mvm_get_vif_by_macid(mvm, notif->link_id);
 	if (!vif || vif->type != NL80211_IFTYPE_STATION)
 		return;
 
-- 
2.34.1


