Return-Path: <linux-wireless+bounces-36254-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEi1Aj4VAmrangEAu9opvQ
	(envelope-from <linux-wireless+bounces-36254-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:43:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF32513AB3
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B1DC308EE1D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EC7466B6E;
	Mon, 11 May 2026 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bc85mgYP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5501466B49
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521028; cv=none; b=f9kj0FgicqgJKVQ1Ipr0Vp9OU4qk04xv9c9YA+/nfwaYEtANYizt4n7RIjpyNNE5eNPZ8NyS/FUm2IHMS4JBVW8EhX4zrSyC28w7NgmmQNMFTevCLmRCP8lGJ+jb9oRzCwrTYf4/HqkW/6IR66IDty90tEXXmJna/PTL54/cuRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521028; c=relaxed/simple;
	bh=agHZLxsDRLPMpZdq83TMMA32frWS9TAX5DCv9B03BwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FRwwCaL3l0bU2DUlm/fKS1JolwwjNcJdSboiJ5SijUARl9movWubEWcwO8H2fY1XB44nUhBzgmb6ZnasiqW6jjeUkdXfKVquGw/o+8i+ogHbpY3nOkRmVfy0Hod+OJ/lA0GnHzDIZV4VkIiwcogqvGdOkJAlHArzFmkV3mR7t2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bc85mgYP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778521028; x=1810057028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=agHZLxsDRLPMpZdq83TMMA32frWS9TAX5DCv9B03BwI=;
  b=bc85mgYP+jN2bUhKd55zj4q45cKmj7y1wxOZUvIeHZsN2B2ShKKezIk0
   TGZBhvdccILpuzVSUqcMqZ98OoEzFL0mXNv6MZmpjSNoUYaOH5lrXgHjW
   tQdX7cu0/rqrLEj5VCwWJH3jRyORpHB5lJxYvqBxOojw6ysEE/gpWNigR
   a0vXCAmKCtJ+jGEeFVuhc0CM2dvy+fX3Xp4tozqLzTq9jMoFTXfbojkOK
   hnoT1uv3c0ur7PHW4R7hmt5v3adjbM2YoAALnHdlihc5oWry8kNonw9/z
   m3wKvPMjgQIiU1370tlxz0uXDeGuUbBQA4+AabDshhlKHvdTj1XgIQSAc
   A==;
X-CSE-ConnectionGUID: SYRr751iTzeNyVX4AuchGg==
X-CSE-MsgGUID: NPNmn46uRc6/U+KNWG1DjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314860"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79314860"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:37:07 -0700
X-CSE-ConnectionGUID: XDuyeteGR7qPJqqr0TSHuw==
X-CSE-MsgGUID: fgf3whC/TKm8b4CZVq8qdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261005148"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:37:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: fw: api: fix UHR U-SIG whitespace
Date: Mon, 11 May 2026 20:36:29 +0300
Message-Id: <20260511203428.f960f56f6734.I1f925625e606fbc96e8401ac3c5667671065bbe1@changeid>
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
X-Rspamd-Queue-Id: BCF32513AB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36254-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Somehow I put tabs there where it should be spaces, fix that.

Fixes: 3b6e7afaf7c3 ("wifi: iwlwifi: fw: api: add UHR data definitions")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 8ef764787ba4..e46e2fe46eaa 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -1278,15 +1278,15 @@ struct iwl_uhr_sigs {
 	__le32 usig_a1;
 #define OFDM_RX_FRAME_UHR_BSS_COLOR2			0x0000003f
 	__le32 usig_a1_uhr;
-#define	OFDM_RX_FRAME_UHR_PPDU_TYPE			0x00000003
-#define	OFDM_RX_FRAME_UHR_COBF_CSR_DISABLE		0x00000004
-#define	OFDM_RX_FRAME_UHR_PUNC_CHANNEL			0x000000f8
-#define	OFDM_RX_FRAME_UHR_USIG2_VALIDATE_B8		0x00000100
-#define	OFDM_RX_FRAME_UHR_SIG_MCS			0x00000600
-#define	OFDM_RX_FRAME_UHR_SIG_SYM_NUM			0x0000f800
-#define	OFDM_RX_FRAME_UHR_TRIG_SPATIAL_REUSE_1		0x000f0000
-#define	OFDM_RX_FRAME_UHR_TRIG_SPATIAL_REUSE_2		0x00f00000
-#define	OFDM_RX_FRAME_UHR_TRIG_USIG2_DISREGARD		0x1f000000
+#define OFDM_RX_FRAME_UHR_PPDU_TYPE			0x00000003
+#define OFDM_RX_FRAME_UHR_COBF_CSR_DISABLE		0x00000004
+#define OFDM_RX_FRAME_UHR_PUNC_CHANNEL			0x000000f8
+#define OFDM_RX_FRAME_UHR_USIG2_VALIDATE_B8		0x00000100
+#define OFDM_RX_FRAME_UHR_SIG_MCS			0x00000600
+#define OFDM_RX_FRAME_UHR_SIG_SYM_NUM			0x0000f800
+#define OFDM_RX_FRAME_UHR_TRIG_SPATIAL_REUSE_1		0x000f0000
+#define OFDM_RX_FRAME_UHR_TRIG_SPATIAL_REUSE_2		0x00f00000
+#define OFDM_RX_FRAME_UHR_TRIG_USIG2_DISREGARD		0x1f000000
 	__le32 usig_a2_uhr;
 #define OFDM_RX_FRAME_UHR_SPATIAL_REUSE			0x0000000f
 #define OFDM_RX_FRAME_UHR_GI_LTF_TYPE			0x00000030
-- 
2.34.1


