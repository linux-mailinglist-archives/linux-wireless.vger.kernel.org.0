Return-Path: <linux-wireless+bounces-36255-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPUOKAsZAmognwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36255-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:59:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05733513F7C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0253B31EC8AB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC8C45348D;
	Mon, 11 May 2026 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Irg7FNPQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18664466B49
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521031; cv=none; b=GJ1nrMZT+5+Bg+t83mV63unxMLjTGp0FjEPD2xdMQ+EAY+Ev6rbI8SWVZDo15fx5q+pQodBterGU43HWTvtlm1FuBtWNE+h2EIMZjsCf+GSdhXyaksybbljpZO19bG31+QeUzryHeASUFAmKnWYpO9UoQCtnIlX/n81SSeX1z8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521031; c=relaxed/simple;
	bh=ToCiv8XHbyQ4Xu5lnzXMcyaqo+CYdN2Tg2hAIL2cn1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ptK9HIDjkA0AMoTEbV7+Pb850GscYtPPsEE9pa2SNDq+2E9X8nzfdwNXbmwJCM/GxtBun4FGOWbMEs56+ErtLWKQqzBXPTAAZOYplcfxm//HdUW7RRXZBE+THUUnhTytLFxgR7iWoHVQp9gNp9BpKkfs4UF9fems7CP2K0an15I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Irg7FNPQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778521031; x=1810057031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ToCiv8XHbyQ4Xu5lnzXMcyaqo+CYdN2Tg2hAIL2cn1o=;
  b=Irg7FNPQT8hIPFd8NP1lBYCjDG8KNCYUuaB1pmG9ZZfhtKwRknAiSCty
   UDjC5q0VQ9Zxf6O0FZHEj1vaF/yhGKp5ypOk1NXdZH3Ok/VXEEYIRFC68
   kl7GUmPJvrsrfGGHJ1ACn2PmtiKefPO6HAiv+UeRZUiJzs3wC5Qx0ro4c
   zCNhFcH0C3Q0hcWpxqUMMXb5sZtLqgAWF15pqL5fSDvMMuDqo8sHxMReB
   9o8G9/AKkgeipwAEi1y0XTbcslehiIDXE7O9IZXcm1bvFhMLvgKnM0JNM
   bftcNkqycfg+E4xCqC+ewIlLnHT7vyg+YVLE9wGSOvNgcyFp9CA3QVRFT
   Q==;
X-CSE-ConnectionGUID: 4jo3RQXwR42OzqEGnfLs4w==
X-CSE-MsgGUID: 5n2fMO5jTUaIfVvdsgl88A==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314874"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79314874"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:37:10 -0700
X-CSE-ConnectionGUID: DEmmnsa6TZOddWZwweNDhg==
X-CSE-MsgGUID: 6qors07cT1KQpbftKWU7Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261005234"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:37:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: fw: api: add/fix some UHR sniffer definitions
Date: Mon, 11 May 2026 20:36:30 +0300
Message-Id: <20260511203428.458cd2ff6623.Ia76e0371adac431b6a5fb93004640278d8572f09@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
References: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 05733513F7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36255-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Add some remaining definitions for the UHR sniffer API, and fix
the ELR where instead of usig_a2_uhr we'll get usig_a2_uhr_elr.

Fixes: 3b6e7afaf7c3 ("wifi: iwlwifi: fw: api: add UHR data definitions")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index e46e2fe46eaa..aa4e5e9d4d4e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -1172,8 +1172,14 @@ struct iwl_he_tb_sigs {
 #define OFDM_UCODE_TRIG_BASE_RX_BANDWIDTH		0x00007000
 #define OFDM_UCODE_TRIG_BASE_PS160			0x00008000
 #define OFDM_UCODE_EHT_TRIG_CONTROL_CHANNEL		0x000f0000
+/* for UHR, since PE RF: */
+#define OFDM_UCODE_TRIG_BASE_RX_MCS_UHR_AND_LATER	0x01f00000
+#define OFDM_UCODE_RX_IS_DRU				0x02000000
+#define OFDM_UCODE_RX_IS_2XLDPC_ENABLED			0x04000000
+#define OFDM_UCODE_RX_DRU_DBW				0x60000000
 	__le32 tb_rx0;
-#define OFDM_UCODE_TRIG_BASE_RX_MCS			0x0000000f
+/* prior to PE RF, cannot have 5 bits needed for UHR: */
+#define OFDM_UCODE_TRIG_BASE_RX_MCS_PRE_UHR		0x0000000f
 #define OFDM_UCODE_TRIG_BASE_RX_DCM			0x00000010
 #define OFDM_UCODE_TRIG_BASE_RX_GI_LTF_TYPE		0x00000060
 #define OFDM_UCODE_TRIG_BASE_RX_NSTS			0x00000380
@@ -1287,6 +1293,7 @@ struct iwl_uhr_sigs {
 #define OFDM_RX_FRAME_UHR_TRIG_SPATIAL_REUSE_1		0x000f0000
 #define OFDM_RX_FRAME_UHR_TRIG_SPATIAL_REUSE_2		0x00f00000
 #define OFDM_RX_FRAME_UHR_TRIG_USIG2_DISREGARD		0x1f000000
+#define OFDM_RX_FRAME_UHR_USIG_CRC_OK			0x40000000
 	__le32 usig_a2_uhr;
 #define OFDM_RX_FRAME_UHR_SPATIAL_REUSE			0x0000000f
 #define OFDM_RX_FRAME_UHR_GI_LTF_TYPE			0x00000030
@@ -1308,6 +1315,7 @@ struct iwl_uhr_sigs {
 #define OFDM_RX_FRAME_UHR_CODING			0x00000200
 #define OFDM_RX_FRAME_UHR_SPATIAL_CONFIG		0x00003c00
 #define OFDM_RX_FRAME_UHR_STA_RU			0x003fc000
+#define OFDM_RX_FRAME_UHR_STA_RU_P80			0x00004000
 #define OFDM_RX_FRAME_UHR_STA_RU_PS160			0x00400000
 #define OFDM_RX_FRAME_UHR_UEQM				0x00800000
 #define OFDM_RX_FRAME_UHR_2XLDPC			0x01000000
@@ -1333,7 +1341,12 @@ struct iwl_uhr_tb_sigs {
 
 struct iwl_uhr_elr_sigs {
 	/* same as UHR above */
-	__le32 usig_a1, usig_a2_uhr;
+	__le32 usig_a1;
+#define OFDM_RX_VECTOR_UHR_ELR_PPDU_TYPE		0x00000003
+#define OFDM_RX_VECTOR_UHR_ELR_USIG_STA_ID		0x00001ffc
+#define OFDM_RX_VECTOR_UHR_ELR_VALIDATE			0x0000e000
+#define OFDM_RX_VECTOR_UHR_ELR_CRC_OK			0x00010000
+	__le32 usig_a2_uhr_elr;
 #define OFDM_RX_VECTOR_UHR_ELR_VER_ID			0x00000007
 #define OFDM_RX_VECTOR_UHR_ELR_UPLINK_FLAG		0x00000008
 #define OFDM_RX_VECTOR_UHR_ELR_MCS			0x00000010
-- 
2.34.1


