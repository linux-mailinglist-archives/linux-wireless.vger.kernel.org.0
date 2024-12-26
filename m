Return-Path: <linux-wireless+bounces-16820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1149FCBAE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 16:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402C618831E8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 15:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E3C14659D;
	Thu, 26 Dec 2024 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFE9VWix"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ECB136353
	for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2024 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735227935; cv=none; b=UdKARM6AZiMVYhnJs3thjdgLHC98aQVtQL2DUsDwCLwZzAZXeHfIU1c8Shl0Kk46D3ta0zUviXtrUnr5R6eXlhl1cvUSsvBwjnUZslA9/RHl8AscD/w62HxyEOETzWfmLcoKcpdaGNPkVrqNshm2/6SBdtr6wkQnviKFGsgEoxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735227935; c=relaxed/simple;
	bh=7M8OAVccliqQDhLFf8kYGf5QAmnsMo1lVHGu19sQug0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WM54ONKpsf5GfBkUiaaU39LAF0L+Xbdk0zSRygX5AsICM+7rXqHlY5BmuH0h0WpZtm+a9M6Zat7Ud0IyVJCWzWrh0RkTxbTD1iLHRmnbZxVFw3/1PXWAIuJJ3OY2w2HYrZHD8MTJUOw5DIgdjWUsuI87pF436aU4Yu+T0kNSQ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFE9VWix; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735227934; x=1766763934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7M8OAVccliqQDhLFf8kYGf5QAmnsMo1lVHGu19sQug0=;
  b=NFE9VWixUro+teF+uzzoNV7cvW4aAuTlplh43PPy2vA6WjcSk74+8CzW
   Drd+IpRnJ5u3cpzWE0cHp5rwjhQkzHyqIVT9EpNRqLEE9UyW7R0+sJdPA
   m9+3K3sJJWi25/n1AZESZJCdn1aKeVQqod410eJydJ4kuuKZuthMkYmPo
   afH0Uf3SPgZU2kbXEgKOXr3r0hRp4lheIlB1tUvJsXqin4exEJC4s8x+h
   /CdQTaZ/An++8joWEBTw34a1SvOSH/KqtO7Tvn+1un43EIbxsAuTASpTG
   KcUbN5v7Ng7JytE1oRL5H1co7E8PdAJXICiv2+rbjetVEVB3asRtro579
   w==;
X-CSE-ConnectionGUID: H69zwrxxRKKAR9iSxQOCZQ==
X-CSE-MsgGUID: bwpENJbgRKel24KZlxh3cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35878176"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35878176"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:33 -0800
X-CSE-ConnectionGUID: MdetaFXJRsucPFoswDbmJQ==
X-CSE-MsgGUID: T4UJY07gTCafRfOzHKEXaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="99778017"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:32 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: mvm: add UHB canada support in GET_TAS_STATUS cmd resp
Date: Thu, 26 Dec 2024 17:44:56 +0200
Message-Id: <20241226174257.dfd6b8893322.I196393dc3c9c28882f90b43a821a2d76a5c9a046@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

dump UHB canada is enabled or not based on firmware capability.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h | 6 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c  | 8 ++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index bea0f4668cc8..aa88e91d117e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -477,6 +477,9 @@ struct iwl_mvm_tas_status_per_mac {
  * @tas_status_mac: TAS status per lmac, uses
  *	&struct iwl_mvm_tas_status_per_mac
  * @in_dual_radio: is TAS in dual radio? - TRUE/FALSE
+ * @uhb_allowed_flags: see &enum iwl_tas_uhb_allowed_flags.
+ *	This member is valid only when fw has
+ *	%IWL_UCODE_TLV_CAPA_UHB_CANADA_TAS_SUPPORT capability.
  * @reserved: reserved
  */
 struct iwl_mvm_tas_status_resp {
@@ -486,7 +489,8 @@ struct iwl_mvm_tas_status_resp {
 	__le16 block_list[16];
 	struct iwl_mvm_tas_status_per_mac tas_status_mac[2];
 	u8 in_dual_radio;
-	u8 reserved[3];
+	u8 uhb_allowed_flags;
+	u8 reserved[2];
 } __packed; /*DEBUG_GET_TAS_STATUS_RSP_API_S_VER_3*/
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 91ca830a7b60..ccf377a6d73d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -659,6 +659,14 @@ static ssize_t iwl_dbgfs_tas_get_status_read(struct file *file,
 			 rsp->tas_fw_version);
 	pos += scnprintf(pos, endpos - pos, "Is UHB enabled for USA?: %s\n",
 			 rsp->is_uhb_for_usa_enable ? "True" : "False");
+
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_UHB_CANADA_TAS_SUPPORT))
+		pos += scnprintf(pos, endpos - pos,
+				 "Is UHB enabled for CANADA?: %s\n",
+				 rsp->uhb_allowed_flags &
+				 TAS_UHB_ALLOWED_CANADA ? "True" : "False");
+
 	pos += scnprintf(pos, endpos - pos, "Current MCC: 0x%x\n",
 			 le16_to_cpu(rsp->curr_mcc));
 
-- 
2.34.1


