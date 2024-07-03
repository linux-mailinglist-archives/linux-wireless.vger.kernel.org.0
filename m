Return-Path: <linux-wireless+bounces-9918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B35259257A1
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566F51F2731E
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E6616F0DB;
	Wed,  3 Jul 2024 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TdHiCSM4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A93716EC0F
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000781; cv=none; b=K+CrNXT8Lg3C6LeTBLW/vRuZvVZekodhluR79QXNKRu8G2E1Xss/crwEC4T+zVf/5TQ2gqOlMzhAjEjf46MYMmeLonJOyBHPSGn7BEJ7Xtfwl7KZk873TQI/di3xDBwTRa2sK7zOJqvcDdBZUTNV0OQPT26oHrZ1Ykb7f9Uc8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000781; c=relaxed/simple;
	bh=tP7vnNqtB6W7oJGHL5Iq/vkztJFriG4rITf9YSHubyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L2K8mP+JqYCHAr2QuMYM3TArXjoR5rVBGJPAJhYZ0LxN3zkLJMItAFUzVdqTCqHbpUPgryVqBIrCRDSDgV4ef4XeTtanvbtzHs8nS3H26bgzcsmwftrEfMUFHXTrt0LsavEVTdMYNsMdp9p4C1j+GAU6N4cN6+f+Wd745TJOpmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TdHiCSM4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000780; x=1751536780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tP7vnNqtB6W7oJGHL5Iq/vkztJFriG4rITf9YSHubyc=;
  b=TdHiCSM4wP5twCb7Kq6kYDcWCQs6SU1zKp9NzvhrvR4gR715NZtsLhA5
   CUMCKigmzkKPNjMOdDal94jD6kVG+3/EgrGAn0OKD79wAwhVoRNGytT00
   3vmB1y/tKjcDmpjdZLlHkJ/Yds9hZQoD4KnJfDx8yeNwNFtci6AV59+Hr
   PGkUpjKKJjGlaBgpp5O+hy5UcTo3Xp4PHrsvXjDTIoHBc05vk3NCA2gli
   X6Lre3WTvCx4VJWyVY8DHdVO2hiZUrlqy//IrtzeaZ8sVXcQrRQvBb0bs
   YIORiJM2k4QuHdhvOEpOiVZKxlvUA1ORGwQnCt8qWwajUmopvTG8OTdC+
   w==;
X-CSE-ConnectionGUID: xmlkftmMSIKBRUdjhduemA==
X-CSE-MsgGUID: 3GvbAXzVS/WpIF7fEQ1pbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837569"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837569"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:40 -0700
X-CSE-ConnectionGUID: M2s5SG9HTmSx22A8AgyxsA==
X-CSE-MsgGUID: l5uPYyEZQHie8+W54RjVfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987873"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Subject: [PATCH 17/18] wifi: iwlwifi: Remove debug message
Date: Wed,  3 Jul 2024 12:59:05 +0300
Message-Id: <20240703125541.8fc59cb17526.Ibb5d68b2fe5f7df709db3570de55a566d5af3f24@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Debug logs related to reset_fw are logged with all
notification/response and polluting the trace.

Remove the debug message related to reset_fw setting
when dump is collected.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 9810a7f4a591..08d990ba8a79 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -1240,12 +1240,6 @@ iwl_dbg_tlv_tp_trigger(struct iwl_fw_runtime *fwrt, bool sync,
 		}
 
 		fwrt->trans->dbg.restart_required = false;
-		IWL_DEBUG_FW(fwrt, "WRT: tp %d, reset_fw %d\n",
-			     tp, dump_data.trig->reset_fw);
-		IWL_DEBUG_FW(fwrt,
-			     "WRT: restart_required %d, last_tp_resetfw %d\n",
-			     fwrt->trans->dbg.restart_required,
-			     fwrt->trans->dbg.last_tp_resetfw);
 
 		if (fwrt->trans->trans_cfg->device_family ==
 		    IWL_DEVICE_FAMILY_9000) {
@@ -1255,22 +1249,17 @@ iwl_dbg_tlv_tp_trigger(struct iwl_fw_runtime *fwrt, bool sync,
 			   IWL_FW_INI_RESET_FW_MODE_STOP_FW_ONLY) {
 			fwrt->trans->dbg.restart_required = false;
 			fwrt->trans->dbg.last_tp_resetfw = 0xFF;
-			IWL_DEBUG_FW(fwrt, "WRT: FW_ASSERT due to reset_fw_mode-no restart\n");
 		} else if (le32_to_cpu(dump_data.trig->reset_fw) ==
 			   IWL_FW_INI_RESET_FW_MODE_STOP_AND_RELOAD_FW) {
-			IWL_DEBUG_FW(fwrt, "WRT: stop and reload firmware\n");
 			fwrt->trans->dbg.restart_required = true;
 		} else if (le32_to_cpu(dump_data.trig->reset_fw) ==
 			   IWL_FW_INI_RESET_FW_MODE_STOP_FW_ONLY) {
-			IWL_DEBUG_FW(fwrt,
-				     "WRT: stop only and no reload firmware\n");
 			fwrt->trans->dbg.restart_required = false;
 			fwrt->trans->dbg.last_tp_resetfw =
 				le32_to_cpu(dump_data.trig->reset_fw);
 		} else if (le32_to_cpu(dump_data.trig->reset_fw) ==
 			   IWL_FW_INI_RESET_FW_MODE_NOTHING) {
-			IWL_DEBUG_FW(fwrt,
-				     "WRT: nothing need to be done after debug collection\n");
+			/* nothing */
 		} else {
 			IWL_ERR(fwrt, "WRT: wrong resetfw %d\n",
 				le32_to_cpu(dump_data.trig->reset_fw));
-- 
2.34.1


