Return-Path: <linux-wireless+bounces-4889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A667287F918
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 09:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C771F242AC
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 08:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23707CF27;
	Tue, 19 Mar 2024 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4fVvuLP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3BA7CF37
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835862; cv=none; b=t0u6odgFynDfmhnQTkhkQeTPs/lCpcSrmgWqvIQpYCzJD8/BiX4FSQCgT6PQioLat7q6hNldG0tpQiDGPIdEo70SQqDw6cS5EQbHPbFpslrW5pw/kb8dptXtt4dU8W73t+MYk/ysSHzzbpfx7dlho5o4353L/fZpVcFxvZeY+00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835862; c=relaxed/simple;
	bh=S0r9bx+a0izm3lX9lcQ0XX0BBceAOPdURSemdMxg278=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QiNrRzJyffEayQJuZNWFH/3DkjkBJKOQSDY0jMQrcqtpiCwbTExm25nAn1l0cd7NbUawcxujwIOdjzwQLzQk84GVJJ69Gpch14VALtYyfrRFDXSDlzMio2GX2Crnjod369n8wJD8NyGima6QU4eNxyETW6hzaTz0efHQRft6wlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4fVvuLP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710835861; x=1742371861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S0r9bx+a0izm3lX9lcQ0XX0BBceAOPdURSemdMxg278=;
  b=m4fVvuLPYzicfbGmGGBb5flYdi7b1BXzp2k8aUyQGTted6mH1sU1JrV2
   k5/y+NwWuEw1bH0/pv+r+D9IXQK9qYKuqApsvPyH9tjy/H/B+weDVKmZr
   dci4QMx68jHM/QYGJkb/H8hUiOQ+yKKiG9ukt0WznH0P7M8czI8Eq0Xcq
   CRdU25V5C+yzKtvjY80aJVGBlgIHYEVOOP6vEoPN8/PGCyQPJPMB2Dio5
   btC/I1VVle9SVB4Uvm+0yV262lG9SR5i1v2h3lQ9dqS3xhYxNz4wFpteB
   nrnizYVzHV0+DlnhsF7WvEPcPIvCzHIhYz7dV9s3ho4Mx6ML/RDIrirhl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5810565"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5810565"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18447633"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:11:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: fw: add clarifying comments about iwl_fwrt_dump_data
Date: Tue, 19 Mar 2024 10:10:21 +0200
Message-Id: <20240319100755.49c3a39737cc.I91c588e0d66b49f0ee9103e8d4a0e501c2fd36d6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
References: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

iwl_fw_dbg_collect_sync() unconditionally accesses 'trig' at
the beginning of the function, even though the data has an
inner union and 'trig' isn't necessarily always used, it can
be 'desc' instead. Add comments clarifying why this is OK,
that 'trig'/'desc' must be first in the struct and how in it
the use of the union's sub-structs is differentiated.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c     | 1 +
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index c3bdf433d8f7..fe4e1bea30bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -3084,6 +3084,7 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 	if (!test_bit(wk_idx, &fwrt->dump.active_wks))
 		return;
 
+	/* also checks 'desc' for pre-ini mode, since that shadows in union */
 	if (!dump_data->trig) {
 		IWL_ERR(fwrt, "dump trigger data is not set\n");
 		goto out;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index b2bc4fd37abf..4204e999bbf2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -46,6 +46,10 @@ struct iwl_fwrt_shared_mem_cfg {
  * struct iwl_fwrt_dump_data - dump data
  * @trig: trigger the worker was scheduled upon
  * @fw_pkt: packet received from FW
+ *
+ * Note that the decision which part of the union is used
+ * is based on iwl_trans_dbg_ini_valid(): the 'trig' part
+ * is used if it is %true, the 'desc' part otherwise.
  */
 struct iwl_fwrt_dump_data {
 	union {
@@ -54,6 +58,7 @@ struct iwl_fwrt_dump_data {
 			struct iwl_rx_packet *fw_pkt;
 		};
 		struct {
+			/* must be first to be same as 'trig' */
 			const struct iwl_fw_dump_desc *desc;
 			bool monitor_only;
 		};
-- 
2.34.1


