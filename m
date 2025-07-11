Return-Path: <linux-wireless+bounces-25278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 157FDB02085
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 17:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A4A1CA7A9E
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E332ED844;
	Fri, 11 Jul 2025 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIe691eD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7F12E7BD4
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248097; cv=none; b=YZFYG7TveGJNNxK9gBElLF/mfgWqecNwWbw2lz3KEKLMjCFolhFTtBJhyiz28GdMfhCYzIYUaYj3+rlJ9g8oja+jISrMGWUPT5YYMpPr0ZTtwn3ik/cB+zW3sJTtVDvhuSAWJGE6vglobk5qwQmy4eyrvedO9lDnFNT7DTFIY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248097; c=relaxed/simple;
	bh=zQUIBIYLFXEdrVqKKKFrtDXKksvsa+VS5Lf4aPWPH24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d13zLMDhajbp2CNebJa2ZQm1F9cejFQ6RqxyjXlU7JHCxX0JP/zD3+SXtF95v7TXF87xscOVYv4ZvANvAgLoWUgwUFeFo7EMhnQMXAH//pkYCL+lp8mrB3sFyszU64oeqoX+lnTspN+s+h7sy2tUZXhy7oHUXewtqK1xztCEwPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIe691eD; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248097; x=1783784097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zQUIBIYLFXEdrVqKKKFrtDXKksvsa+VS5Lf4aPWPH24=;
  b=JIe691eDQBR5EdyaM27IhuP5LoXqiIpGSnc+W+p9bpOGVS3iyrDHAm5t
   oeGruoCQnQkfO7ejvKnoRItjxWc6YaGEuC7xMOIdPntlmRU43ktKPxQhq
   qZQZlp8u04ob9Pedd9ZmFWKW6dz1DF+5IAal+lRUEsw0YJwfww6Mmvdwl
   1vqbZxyGVlnc/lPM0qWGAKaS7dw4w6qOF6fFxFwumxgcwvwMm6kwvwBZz
   nRB9PMomsQ/LJqBEvobHrd9BO3VwOfvFvhy6eKN5aWuV7+ovMNRmX3dQb
   JG1Ma5erljIDCaORI6xdARM/dKdG2C1I/QgSq2ZCVYi+FKjJRm5dkQPJX
   A==;
X-CSE-ConnectionGUID: MX+v/E0CTEWSjG4DqkSKRA==
X-CSE-MsgGUID: ls+mf+KBTXOmp8BZLJtLkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54264155"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54264155"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:56 -0700
X-CSE-ConnectionGUID: WK3iGeEDSNKg9PEUnBkjzg==
X-CSE-MsgGUID: e107tO9eRDWy4Z0ytJQsvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156485100"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: mvm: Add dump handler to iwl_mvm
Date: Fri, 11 Jul 2025 18:34:18 +0300
Message-Id: <20250711183056.366fc31fd551.I976cb17edd85a461043c7a4c7f4895bfaec9174a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
References: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Implement a dump handler in the iwl_mvm operation mode to
collect firmware dump upon trigger from trans layer.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 892b1564677b..c7f08cde1f72 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -2119,6 +2119,17 @@ static void iwl_op_mode_mvm_time_point(struct iwl_op_mode *op_mode,
 	iwl_dbg_tlv_time_point(&mvm->fwrt, tp_id, tp_data);
 }
 
+static void iwl_mvm_dump(struct iwl_op_mode *op_mode)
+{
+	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
+	struct iwl_fw_runtime *fwrt = &mvm->fwrt;
+
+	if (!iwl_trans_fw_running(fwrt->trans))
+		return;
+
+	iwl_dbg_tlv_time_point(fwrt, IWL_FW_INI_TIME_POINT_USER_TRIGGER, NULL);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static void iwl_op_mode_mvm_device_powered_off(struct iwl_op_mode *op_mode)
 {
@@ -2181,4 +2192,5 @@ static const struct iwl_op_mode_ops iwl_mvm_ops_mq = {
 	IWL_MVM_COMMON_OPS,
 	.rx = iwl_mvm_rx_mq,
 	.rx_rss = iwl_mvm_rx_mq_rss,
+	.dump = iwl_mvm_dump,
 };
-- 
2.34.1


