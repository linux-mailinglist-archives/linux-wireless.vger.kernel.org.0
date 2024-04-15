Return-Path: <linux-wireless+bounces-6316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1EB8A4AF2
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC581C21250
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E6F4D9E0;
	Mon, 15 Apr 2024 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LyoWXWYl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F814D11F
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171311; cv=none; b=X2eG8Aq1EJcxRqFuEOiz01NwCxL4PPGiMrpLuLaXcifT83FSAkQ4ny7II60B2Do6A1jsJqYzkfIyz0WgHuK8ASsTzxO/7yrdkkQ/qE5wDCMGjWSiLm0emA/fv/vhlucXzddExTzzNZlxI85KZaZ08YD+GoDHoC/1v6ddG7kd6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171311; c=relaxed/simple;
	bh=1qaLJ8y7yiUvbX9jhVK5M5r5aaTEz/zbfe3ofMKXwXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FtSYCsbtw6lEkuWbrxJczO4LcbHP2zwPxONPtwxJrar+x1H2dNllkVUumIYLZWN6Vxv3wffFNCU5cr0vCjqqm1448IEjwP7o4b5DU5qLcP0YU9kYdhwq1FqQxYxTdKrudif+Aq2TBBX4asq/4HavJbcuuNUMW5DAfk2t07Qq7u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LyoWXWYl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713171310; x=1744707310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1qaLJ8y7yiUvbX9jhVK5M5r5aaTEz/zbfe3ofMKXwXQ=;
  b=LyoWXWYlZE48n8pXtCccHa7WRdMTHwIwetsdhAv1a6+4lYBBMbTbfXFV
   qCYJ5WSnVkGH3giuk7K6xWPl9RT4K3ndQiJvycw6VySw/RAq63D676bAj
   yd4RXeZDLw2PZwTiRR0DD9fKAKSPv3hmSpJpCi+M/pShTiMDRVrcDZGzp
   MWCzwh2pG5QSy2QTvSuWGRsxaNmwv8+iFU6yngr2PlQBi103gCrndAaMY
   NvJYIWM65RxGEWrkXhvk+zEGUKAzJA3VsQJV8y2pzSI4nruIvJ//Ncv4h
   O46gXAAL72FEwkV93cKPMR477I21SHPnJSCBXTsF8E18yOl55J1GhTADe
   w==;
X-CSE-ConnectionGUID: j6eheJ7dSYSiMml/oLnOZQ==
X-CSE-MsgGUID: e9THO38BSNKtl/4Ni16YGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="9100603"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="9100603"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:55:10 -0700
X-CSE-ConnectionGUID: zl0fG6zORdior7w4MXoMyg==
X-CSE-MsgGUID: g2I5BG7AQMG3JDcRD45rig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21768050"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:55:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 08/11] wifi: iwlwifi: mvm: Add support for PPAG cmd v6
Date: Mon, 15 Apr 2024 11:54:41 +0300
Message-Id: <20240415114847.e1893fe24ea3.Ic84cf576de0883c2184c939bdfad4b110a8a1815@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
References: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Add support for enablement of PPAG for
 - VLP for 6 GHz mode in CANADA, USA and ETSI countries.
 - LPI for 6 GHz mode in CANADA.
 - SP for 6 GHz mode in CANADA, USA and ETSI countries.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index ce18ef9d3128..8f84d4733b63 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -567,7 +567,7 @@ enum iwl_ppag_flags {
  * union iwl_ppag_table_cmd - union for all versions of PPAG command
  * @v1: version 1
  * @v2: version 2
- * version 3, 4 and 5 are the same structure as v2,
+ * version 3, 4, 5 and 6 are the same structure as v2,
  *	but has a different format of the flags bitmap
  * @flags: values from &enum iwl_ppag_flags
  * @gain: table of antenna gain values per chain and sub-band
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index a3bf16b8b5fd..6d4b9334702e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -347,7 +347,7 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 					"PPAG table rev is %d, send truncated table\n",
 					fwrt->ppag_ver);
 		}
-	} else if (cmd_ver >= 2 && cmd_ver <= 5) {
+	} else if (cmd_ver >= 2 && cmd_ver <= 6) {
 		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
 		gain = cmd->v2.gain[0];
 		*cmd_size = sizeof(cmd->v2);
-- 
2.34.1


