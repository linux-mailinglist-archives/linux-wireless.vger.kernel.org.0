Return-Path: <linux-wireless+bounces-26673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5FEB37896
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 05:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68AD2686829
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 03:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72872F9992;
	Wed, 27 Aug 2025 03:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/q1mCnW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E2F2367D9
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 03:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756265673; cv=none; b=m117vpf+DmVt+/rmakbbljGjJjPrfmywvAraaptX87nECtqWnDv1oxb7YDlYHftN5qxEITbfoXAPYfs4jqlgeHf4YSMP7shPn1vnG0nyQlxIff277/hhOHQocHlxAFvrq2ciksnjq0bzw59m/DUzRVGehgaR8WFZHYqu4f9qz+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756265673; c=relaxed/simple;
	bh=h1k0XcPaiBPx5sqc4eyvkVNUt3CmHCrZ+H53GwsB42A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZDn3UjNqSCfUR3M/oazJXHWe3RGnA7xda1841ye67/uGdXLCr/umSe5AyLBhMp4TxrjNrLeXKf6CFF4IXKshb+/aG/kUhCg7diCEdJ+XH73U9najCwC7dLrN+qsIvtdqDspUu3Jt1ynoxghrfvA4sNA/9NOf44ghFs1r2/q9m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/q1mCnW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756265672; x=1787801672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h1k0XcPaiBPx5sqc4eyvkVNUt3CmHCrZ+H53GwsB42A=;
  b=C/q1mCnW2i8vsndaaCkIdbdi+a4ucVm3RC8wde2t2trZhF6sM9dqcfLi
   1m4C0khr8TJSEz773n//RGpAVu1Gxs6AT22HibFi9CGjzinYOi+rN6mw1
   HR4sv7Tq5aBrdSzh177gpj2G6xjrs5Sp73ADqnxv1hyqlTLm2dl1AEsqa
   hroIK67jmvRZaiLqXJ7sdBG/sOsOMUVW4EiNnweaU5KAkgtO/vW1FMjs4
   sHBS8b1K8Faz2yHb6VmOCN1GM9Rb0nEBJJ6BATCK8G5TM1v2bYvYfLIVz
   hCQJQAninfQJWDr+4cu7mYp6pXz9mHGcU8TlrPOVNxz1sKGnW0+h/XbyB
   w==;
X-CSE-ConnectionGUID: yp2sDsXtREWi0GmanZ5EQA==
X-CSE-MsgGUID: mmL7yoEoQXKTCteVu+QcqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69229551"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69229551"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:34:31 -0700
X-CSE-ConnectionGUID: nXQkhXDIRzig9ZwruIKdtg==
X-CSE-MsgGUID: ZOI3UgX/SMCAw3GuR2qxcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200631398"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:34:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH iwlwifi-fixes 4/4] wifi: iwlwifi: cfg: restore some 1000 series configs
Date: Wed, 27 Aug 2025 06:34:01 +0300
Message-Id: <20250827063332.fabb99c2df9e.If0ad87bf9ab360da5f613e879fd416c17c544733@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
References: <20250827063332.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In the fixed commit, I inadvertently removed two configurations
while combining the 0x0083/0x0084 device IDs. Replace the fixed
matches for the BG versions by a masked match and add the BGN
version back with a similar masked match.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220477
Fixes: 1fb053d9876f ("wifi: iwlwifi: cfg: remove unnecessary configs")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 46d8c1922292..f5e72c90dd57 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -729,10 +729,10 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x0083), SUBDEV_MASKED(0x5, 0xF)),
 	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
 		     DEVICE(0x0083), SUBDEV_MASKED(0x6, 0xF)),
+	IWL_DEV_INFO(iwl1000_bgn_cfg, iwl1000_bgn_name,
+		     DEVICE(0x0084), SUBDEV_MASKED(0x5, 0xF)),
 	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
-		     DEVICE(0x0084), SUBDEV(0x1216)),
-	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
-		     DEVICE(0x0084), SUBDEV(0x1316)),
+		     DEVICE(0x0084), SUBDEV_MASKED(0x6, 0xF)),
 
 /* 100 Series WiFi */
 	IWL_DEV_INFO(iwl100_bgn_cfg, iwl100_bgn_name,
-- 
2.34.1


