Return-Path: <linux-wireless+bounces-8134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED898D08A3
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBD2CB2ED96
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9531816B73C;
	Mon, 27 May 2024 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zz3lhUQL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFEE16B723
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826014; cv=none; b=oZ50HpGVi+t8slCYBaldXE1a4qgTjLOAkEsrO+BEbPwyBYYvfVH2W/e+yPYfab147HxFgzpXlJyuZINtWfY1SZnLwlQcwo6c17f3db2wuq7JwK7/gFMhRnxlOoXFBfeUP2DqUD1oSTDlbbPwPao9DO/SDmFtVay/A9dvi9HyMqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826014; c=relaxed/simple;
	bh=oycJ6t5CoIxGzT/Xbzje22K5K3HjjpKaCPfnSwFfArg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t7WqT4Lqwvp3B5nRUr8DWwCJkY3J2zz2iX9kA/GpZ4BikjY0slmeRBjiuddKpA00BGFON3qCwfjafPhOuNO0CpBvXcdt6MMEcE9jh02gmiKJAHR6j2yfH2jJlbMlv7dXsrNNmK/7hdDTJJYP6asMa875qKdOLnBNjqdFs/KOOl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zz3lhUQL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716826013; x=1748362013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oycJ6t5CoIxGzT/Xbzje22K5K3HjjpKaCPfnSwFfArg=;
  b=Zz3lhUQLv3NjuRMkNJlcBNVyXj75b/4P2vf5F9Yc0U6utE3A3zeFP5u/
   kChsLx5HrtfHwggRsbDilj98BnQgKf6zR1vM++q4/3S7ttal4OTApSA1G
   SgWKPihn62bo9Q3KkiFlG9TmEGM3MQ3D9hZOKBQAng3lhoQ+dGVxNuzuI
   CDv1vWAEEMpMX/qLD6sdXwfnnEqCAw7TRsFY0hBfcN35u4aXHIw50d9LE
   BluNef+z/ii8w1evi5iF8V7hHFw+JoodO/Y934x8Eh0pUm3FzONLEcrPX
   iuxM5Cwh8Q2wvBu49WCbRA5VdP2sFLrzIows6O+OeuLLsOMbHDBlBvNxD
   Q==;
X-CSE-ConnectionGUID: 5RMI+58BTYu2cDO+9YxK8w==
X-CSE-MsgGUID: k0zXrJJNTte4DxTrlba3Sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002137"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002137"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:53 -0700
X-CSE-ConnectionGUID: 4/+ypBiXSx2QdZuR1Pz6EQ==
X-CSE-MsgGUID: HIvbX+S9SOmO9Gro2DkY2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407152"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 20/20] wifi: iwlwifi: move Bz and Gl iwl_dev_info entries
Date: Mon, 27 May 2024 19:06:15 +0300
Message-Id: <20240527190228.a75e9a1eb86c.I003980f8ca60a96019657e396e848a07df6b92a4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The iwl_dev_info entries for these devices were incorrectly positioned
within the array, out of chronological order. Move them arround.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 52 +++++++++----------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 92e48cff49de..d6da25e24818 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -997,32 +997,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_CDB,
 		      iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_name),
 
-/* Bz */
-/* FIXME: need to change the naming according to the actual CRF */
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
-		      iwl_cfg_bz, iwl_fm_name),
-
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ_W, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
-		      iwl_cfg_bz, iwl_fm_name),
-
-/* Ga (Gl) */
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_320, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_gl, iwl_gl_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_NO_320, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_gl, iwl_mtp_name),
-
 /* SoF with JF2 */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
@@ -1103,6 +1077,32 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_name),
 
+/* Bz */
+/* FIXME: need to change the naming according to the actual CRF */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_bz, iwl_fm_name),
+
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ_W, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_bz, iwl_fm_name),
+
+/* Ga (Gl) */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_320, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      iwl_cfg_gl, iwl_gl_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_NO_320, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      iwl_cfg_gl, iwl_mtp_name),
+
 /* Sc */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC, IWL_CFG_ANY,
-- 
2.34.1


