Return-Path: <linux-wireless+bounces-9204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1637E90D9B5
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 18:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E711F2146F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5510613C807;
	Tue, 18 Jun 2024 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZCNjpjj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72CA13C9CF
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729069; cv=none; b=Erivh4GDACP1/SftFitI8Yaghkclgsr+NoLl2VmZeWEY5WpIQNb+RYLuYTeBv0KK0JsRowZNk/Xo0KFLYUh+r7kvp+DQ9YArBZSF2wDTwysk831rYXe3i9zaSDCDfdxJwJGl/LpQTdfzVqTOAs+2hsXW+Qbh0P5duZXM9U2ONRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729069; c=relaxed/simple;
	bh=6SW33UqNdIzLG7eqtDXfdldWNFO3cVYy4JFiVxd+rso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q8ei/zvKWvzqZUVOVxCf/n7ZONNj2WdUQW6yYP3BZI70Db5dJrlub3/uohMZ6jeYbt1IzniTmAAl6CuL9HSXQWWAJwcWli3JFU1tSPtlfhHbkC7KzDtHXM7gxP8TNwV5UF9Cjz4VxkbzgxxQoo6+ydCYjEzd1WtxHuRIgNvKVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZCNjpjj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718729067; x=1750265067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6SW33UqNdIzLG7eqtDXfdldWNFO3cVYy4JFiVxd+rso=;
  b=YZCNjpjjTjr0SsKlPSaMGi+Zo8IJL0+vF/B8Fepqml1ecalATznmxgo4
   AR01LmOzkss4VcBU5/Wr8Gi/huQiW9V4jaiAN5iJIAG/Ft2B5RmtOnQNl
   md0NgE8Eye6ftApYZkdXFfGjGBhvfIbN1SO6UpLAHrDyhN+NE4MJJjDRO
   yabzOXIWJFbxDzTskrnIbrjo9eCJnhmjmcUGYgp8QUteI+syVX1A3sNeW
   h4zv0BnLXcP/mTWwjVPqDsyrBzMTk3Lz2NWOqsFqW+xxrL35zt97LmUHD
   KZOS4DvIeF1bJzmClf6ez93LVKC6D3dGREHBKoXkNQUfEVZj8Fjx3V4z0
   A==;
X-CSE-ConnectionGUID: nsfH4PBhQSeUlZb3qrfJ7Q==
X-CSE-MsgGUID: 1hJpGv8WRj+7J7QhTq7VsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26257173"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26257173"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:27 -0700
X-CSE-ConnectionGUID: 4HSHSG9IQ/6FRkiuQhQxGA==
X-CSE-MsgGUID: Apnxrl8hT42P5TXVMxnb+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42306512"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 03/11] wifi: iwlwifi: trans: remove unused function parameter
Date: Tue, 18 Jun 2024 19:44:05 +0300
Message-Id: <20240618194245.1aa8bf13aea9.I9662c10c1db545dd8849af4bb4ab47708d4548d8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
References: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwl_trans_pcie_gen2_fw_alive doesn't use the scd_addr parameter,
it was there only because we needed the functio to have a prototype same
as iwl_trans_ops::fw_alive callback.
But now the ops is removed so no reason to keep the parameter.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c       | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h   | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index eeee5c35668e..bd21bbe7e7e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -359,7 +359,7 @@ void iwl_trans_fw_alive(struct iwl_trans *trans, u32 scd_addr)
 	trans->state = IWL_TRANS_FW_ALIVE;
 
 	if (trans->trans_cfg->gen2)
-		iwl_trans_pcie_gen2_fw_alive(trans, scd_addr);
+		iwl_trans_pcie_gen2_fw_alive(trans);
 	else
 		iwl_trans_pcie_fw_alive(trans, scd_addr);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 3ce626c93651..2040e00c744a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1095,7 +1095,7 @@ void iwl_pcie_alloc_fw_monitor(struct iwl_trans *trans, u8 max_power);
 /* transport gen 2 exported functions */
 int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 				 const struct fw_img *fw, bool run_in_rfkill);
-void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans, u32 scd_addr);
+void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans);
 int iwl_trans_pcie_gen2_send_hcmd(struct iwl_trans *trans,
 				  struct iwl_host_cmd *cmd);
 void iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index c1446d550b4f..18dda89b7985 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -339,7 +339,7 @@ static void iwl_pcie_get_rf_name(struct iwl_trans *trans)
 	pos += scnprintf(buf + pos, buflen - pos, "\n");
 }
 
-void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans, u32 scd_addr)
+void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-- 
2.34.1


