Return-Path: <linux-wireless+bounces-16865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B029FDF42
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8173A18AB
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557DE194C96;
	Sun, 29 Dec 2024 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3K5nUtv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F91946B8
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483514; cv=none; b=aGb3zfW5zjbJg0rmSCwCa7crj8Bk86bEqbCR4vQYrpnmnDhwUsBxf5JhTjgvjgL/XQmcWXBvDCpJmke066g6J5DveZ24smHWWPjXH/5kZBoz1K0c2LWG8dZKj/yML2sAEaE9AQi4Xo+zPMS0ej4JRK+sCACD5Cb2YAcdHbHx00w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483514; c=relaxed/simple;
	bh=n7ZzYv0/bSucDD/F3ZK36zL+wf+hjPXpPj1/JeCgtlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xb7Q0fvnJ46sRWjDT4zO40tbdn8b4YGHW1zfpOM1j9VfE8OlScIViwOpMNcWsxK9m33dE3LC9j1yJ9mcSUSU2uyrsYlIRYuzMY4x2ZTms2MrWrYRvLSkA6ifwOgX7Tp1Mul9chBBfrzS5HCfRRU+l96QSpoMk+i8/sN97bWgZ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3K5nUtv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483513; x=1767019513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n7ZzYv0/bSucDD/F3ZK36zL+wf+hjPXpPj1/JeCgtlk=;
  b=S3K5nUtvSqvC3voMjK3lcTNF0gDwodkSAsaTLOxtYjK5b/6/GSDjyLuy
   e2k5h1fMM68e0gMWjxn/fFU2SzzcTFictq4A1VuAQ0A+YTAMZZTbwev2T
   bXheNHCIz0ammOfT8rcfF8E9bv0uYP7JueXCGGzSvY7gGbmol8zq2jrRE
   LCohQjWaUKDA7UwXq1osnA7NNWzj60MwfkYybyVmH+4O6OjMUV6p4N06X
   I88PYvznx9NBy1K2dTF9C8703XpblMOrxSvRGB8aRzTsqlojKW60SGJ0j
   ZX/L98p4LWfFKNZJ4R4LyAfyJHxmhAWKQb5OpHaqLDN09cXZnRoPzdwqb
   g==;
X-CSE-ConnectionGUID: xydMeTWvSTS4jzPIP/erMA==
X-CSE-MsgGUID: lpWO4SAsQbmvlA9MBwN23g==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572432"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572432"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:12 -0800
X-CSE-ConnectionGUID: OvgXBnkNQWSAu9eVOv1jcA==
X-CSE-MsgGUID: qCruMnEcQJOVGP0OBjcj8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105656874"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:11 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 04/17] wifi: iwlwifi: cleanup unused variable in trans.h
Date: Sun, 29 Dec 2024 16:44:39 +0200
Message-Id: <20241229164246.1d04ce18a0ec.Ibfac364163b55b52196d30ff2b43945c5aa804a9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
References: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Remove unused fields from the transport API.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 4 ----
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c   | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 0a9881c3291e..45c5245136a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -633,8 +633,6 @@ struct iwl_pc_data {
  * @n_dest_reg: num of reg_ops in %dbg_dest_tlv
  * @rec_on: true iff there is a fw debug recording currently active
  * @dest_tlv: points to the destination TLV for debug
- * @conf_tlv: array of pointers to configuration TLVs for debug
- * @trigger_tlv: array of pointers to triggers TLVs for debug
  * @lmac_error_event_table: addrs of lmacs error tables
  * @umac_error_event_table: addr of umac error table
  * @tcm_error_event_table: address(es) of TCM error table(s)
@@ -669,8 +667,6 @@ struct iwl_trans_debug {
 	bool rec_on;
 
 	const struct iwl_fw_dbg_dest_tlv_v1 *dest_tlv;
-	const struct iwl_fw_dbg_conf_tlv *conf_tlv[FW_DBG_CONF_MAX];
-	struct iwl_fw_dbg_trigger_tlv * const *trigger_tlv;
 
 	u32 lmac_error_event_table[2];
 	u32 umac_error_event_table;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 7250c85fb6e6..f5ff700d0665 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1479,9 +1479,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	trans->rx_mpdu_cmd = REPLY_RX_MPDU_CMD;
 	trans->dbg.dest_tlv = mvm->fw->dbg.dest_tlv;
 	trans->dbg.n_dest_reg = mvm->fw->dbg.n_dest_reg;
-	memcpy(trans->dbg.conf_tlv, mvm->fw->dbg.conf_tlv,
-	       sizeof(trans->dbg.conf_tlv));
-	trans->dbg.trigger_tlv = mvm->fw->dbg.trigger_tlv;
 
 	trans->iml = mvm->fw->iml;
 	trans->iml_len = mvm->fw->iml_len;
-- 
2.34.1


