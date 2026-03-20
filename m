Return-Path: <linux-wireless+bounces-33574-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAESKpYCvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33574-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:17:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ADC2D7127
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3642F31141EC
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66B0373BF9;
	Fri, 20 Mar 2026 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5Qf5OqU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96129371862
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994191; cv=none; b=b7cXWVEKePbQv2oNcBRZhnS6mfaNMEhLd6eh6xBYL+jqaJS/pu/a6QRyWwW0Ac3cOxBQXSqpqBiaE6O1agNTLsIWgKI7FP912O22Bw1mLgjnXHk+jU5479/JGVivBAS5nDjAh0W/KG6baDdoBFHt8akYqB2VnT8r8AHKQ+PfNTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994191; c=relaxed/simple;
	bh=T1TyVkeAhLZciqVLS0Z9uBfJVeGiBXICDuaIcO3PrjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RdCEe2lcVUK6M5rLTG7Qd7Snj7/OD8Jzmacew941oG+lQttyg3LWQO6FJHji7nARtyOwAmisxyBac8KH6jBIEFO0B1z1HyaAkubtxln4TtczosWMP6MdNN0N5tBlFwEOQdp0jjJeHWzh0InWTkVQSe0/N8Kroh0rFofvzON1fgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5Qf5OqU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994190; x=1805530190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T1TyVkeAhLZciqVLS0Z9uBfJVeGiBXICDuaIcO3PrjE=;
  b=m5Qf5OqU4VCb/yqdVA4g/4jtmPpg4IkkIG3idXagKW9RCXpj+cHA1ZD6
   7KiEDCvb48XajJ41xc+Ge9xPh0VVEklTeLD7rND2/XHgJOIJ0Vxyg+ZtR
   qnAsAy+nnI28ldJlPI0EI4hIflQIifB2bKJjW9WDFCKBauJrAXEIHLzoT
   eAhKJVpCFqpBzpCGprPuOyFEys+G3dQdsQAP1wD2nbs/p9uqIKCrvvz2H
   MkueGdc9KAfahWDV1P60q1RzZ/TAG33YVlNTYst1e63u05089nqBypRf2
   KnhSUohc+VdOuC/lYE0RFbf1O4hyUZXze9zLYhVAyvy/Gu1s50jLch1Il
   g==;
X-CSE-ConnectionGUID: MKdUVOKIQLS3zYyIxuEUxA==
X-CSE-MsgGUID: A9jIuxYNTH2BVyK+hV2qnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86154153"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86154153"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:50 -0700
X-CSE-ConnectionGUID: Q1cBTlUfRS+ZwGwfTI/zkw==
X-CSE-MsgGUID: 7Gzk3G5uQdqVDbN+l84leg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227692624"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: pcie: don't dump on reset handshake in dump
Date: Fri, 20 Mar 2026 10:09:16 +0200
Message-Id: <20260320100746.f36ba3893899.I063ccc3a037ae6dabcde61941acb162c4b33f127@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
References: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33574-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 46ADC2D7127
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

When a FW dump happens, possibly even because of a reset handshake
timeout, there's no point in attempting to dump again. Since all the
callers of the function outside the transport itself are from the FW
dump infrastructure, just split the internal function and make the
external one not dump on timeout.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
index b15c5d486527..a50e845cea42 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
@@ -95,7 +95,9 @@ static void iwl_pcie_gen2_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 			      CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
 }
 
-void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
+static void
+_iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans,
+				   bool dump_on_timeout)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int ret;
@@ -133,7 +135,7 @@ void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
 			"timeout waiting for FW reset ACK (inta_hw=0x%x, reset_done %d)\n",
 			inta_hw, reset_done);
 
-		if (!reset_done) {
+		if (!reset_done && dump_on_timeout) {
 			struct iwl_fw_error_dump_mode mode = {
 				.type = IWL_ERR_TYPE_RESET_HS_TIMEOUT,
 				.context = IWL_ERR_CONTEXT_FROM_OPMODE,
@@ -147,6 +149,11 @@ void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
 	trans_pcie->fw_reset_state = FW_RESET_IDLE;
 }
 
+void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
+{
+	_iwl_trans_pcie_fw_reset_handshake(trans, false);
+}
+
 static void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -163,7 +170,7 @@ static void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 		 * should assume that the firmware is already dead.
 		 */
 		trans->state = IWL_TRANS_NO_FW;
-		iwl_trans_pcie_fw_reset_handshake(trans);
+		_iwl_trans_pcie_fw_reset_handshake(trans, true);
 	}
 
 	trans_pcie->is_down = true;
-- 
2.34.1


