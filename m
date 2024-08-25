Return-Path: <linux-wireless+bounces-11911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A370D95E447
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 18:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DD9CB210C5
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 16:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3574416EC0E;
	Sun, 25 Aug 2024 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kgjc60X9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A3E16BE1C
	for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724602654; cv=none; b=Ka+8OOGLnCbYS0aqKx/IhTRnpJ5l7EZ3HW1LwgSRTfhIdnc7cFOeJIwOSDFdMSn8azJ5AsRHNYS8Ig8MEDz8CltfU1KX9ImrvHo/4td0TDyXH98wxeN818/UtzKM89shAtahaVwXBYyKaZnxYrXzjAEMt+CWkkNPeCPG0Zl9oLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724602654; c=relaxed/simple;
	bh=xU/utmda3HNrCa4+yZJC1EmRsSH7D/LKzvY7RUz0cWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NEYb6zRsp0NakClzhMLML28cG2myWg5tWy1NIsJHBnXjy2lVQ3isZr3qtTLQu3i3b5zhHCcXK0dx9WmBKCI5JIBDD5KRroD/9MTTrp+bnU/m7SY9B2XvRyLFDsxUxbr2vYXdPbCyOLf8JrZvu2+JSdX1irjP0L7eWMyVLj8eOi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kgjc60X9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724602652; x=1756138652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xU/utmda3HNrCa4+yZJC1EmRsSH7D/LKzvY7RUz0cWk=;
  b=Kgjc60X9OLJ9sJOpG7YCafe9vf57v3w+RIWqBHCwXmHoHRTFKv/MAARF
   0PfF1WZWwg7zv0Du4cjp6bGFWaABG/7Bh7DMpHNdDJJr+nBSDUYSJXvSc
   eHiDhqamQfFw5O9nZOsV7oyocIPCTqrK3vpotszYYxQ66mIkFpitrciLq
   xZjlqdkP4TVcDoTIw08tvyDBTohWH2+bDGu4ExX9D0fX37rCg14bWO1Sr
   5Qb0kzxqdXcSL2Db6AVn+mvQPJLUsoL0hBVSv2fh9EVfmPxgCmq93MyaS
   evuA1NWu/SeYj4jGE2wM4V+1oA0eOqg3HFXrf79BkLHfUZmNxofwN1U6a
   A==;
X-CSE-ConnectionGUID: +DGvjm8hT4amsd02+7ghDw==
X-CSE-MsgGUID: emFN3YSvScGPcLLyPyKcIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22544127"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="22544127"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:32 -0700
X-CSE-ConnectionGUID: jjk3bUemQjqJvMW49+KGTA==
X-CSE-MsgGUID: viVKQj7aT0a4mFQZ2fXXlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="62999745"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 06/13] wifi: iwlwifi: mvm: fix iwl_mvm_max_scan_ie_fw_cmd_room()
Date: Sun, 25 Aug 2024 19:17:06 +0300
Message-Id: <20240825191257.e710ce446b7f.I2715c6742e9c3d160e2ba41bc4b35de370d2ce34@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
References: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

Driver creates also the WFA TPC element, consider that in the
calculation.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index ecd9d301e88b..bae6aec8295c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -48,6 +48,8 @@
 /* Number of iterations on the channel for mei filtered scan */
 #define IWL_MEI_SCAN_NUM_ITER	5U
 
+#define WFA_TPC_IE_LEN	9
+
 struct iwl_mvm_scan_timing_params {
 	u32 suspend_time;
 	u32 max_out_time;
@@ -303,8 +305,8 @@ static int iwl_mvm_max_scan_ie_fw_cmd_room(struct iwl_mvm *mvm)
 
 	max_probe_len = SCAN_OFFLOAD_PROBE_REQ_SIZE;
 
-	/* we create the 802.11 header and SSID element */
-	max_probe_len -= 24 + 2;
+	/* we create the 802.11 header SSID element and WFA TPC element */
+	max_probe_len -= 24 + 2 + WFA_TPC_IE_LEN;
 
 	/* DS parameter set element is added on 2.4GHZ band if required */
 	if (iwl_mvm_rrm_scan_needed(mvm))
@@ -731,8 +733,6 @@ static u8 *iwl_mvm_copy_and_insert_ds_elem(struct iwl_mvm *mvm, const u8 *ies,
 	return newpos;
 }
 
-#define WFA_TPC_IE_LEN	9
-
 static void iwl_mvm_add_tpc_report_ie(u8 *pos)
 {
 	pos[0] = WLAN_EID_VENDOR_SPECIFIC;
-- 
2.34.1


