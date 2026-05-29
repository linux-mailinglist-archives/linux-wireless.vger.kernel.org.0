Return-Path: <linux-wireless+bounces-37091-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FKutE08oGWpXrQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37091-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 07:46:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0405FD83B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 07:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1908300C303
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 05:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5663A3E91;
	Fri, 29 May 2026 05:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7USN07C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD1430EF77
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033611; cv=none; b=A6TXNuJS3lmrgdEXWXOtAHAljGw2cUHE0CESC2JVNTPDnnCkakLRWktNVh2h921mXRuMnUHHN1kejUj0QRwiuP76DBGNoU9k8XWcW2q+Co6IbVXV7KKmZiGJrTgih58Dpv0DuLLxyUeW/GnUseOuTm9QUxe8pcIthKHgsl27wrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033611; c=relaxed/simple;
	bh=2M8EvyKp6LU6TdSWF2btRAol4TIKl87NPGZ+Gb+L8SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iz8blnq5NvCTJrKrqUUgC+paZ0rXt96D84pwgWSKDskED+o4B5aSVDMiW3+ns4wJLbnLglU7+CF1SZPZkLRVYrZsMxiXzI4qByKB6C8dd5LCFWyoKVGABeuOMKkI3fYKS4niekvGdpYnw9gWHWn6TjXQ/Ln2Edx3/8TE6SOD2R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7USN07C; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780033609; x=1811569609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2M8EvyKp6LU6TdSWF2btRAol4TIKl87NPGZ+Gb+L8SQ=;
  b=T7USN07CDDWoT3rZPuwNXry1oxo9GuL+wmSnNN+18179JOJ00C4gGUtK
   WACAWV4W6mIiIkRVDKiXa46tQtQNS48MjdUHYCslnJb8qf2iK2tBiMNKs
   qiVu4p8b7sG+lpV6d4DuJ/d3Wt3gSNFohVo469y22DIjFGvVcjMnrU/DE
   d4ggRXrySrpy8GgOjw/PzP19x/T86HWiiE0jlYcg3vDTKI6HTIVNsvKw4
   rD4w5gWrAO+oZ6G17GidJ2NwnAEU1YlrJ80awal/WeExCoUtJrI2LELCw
   lN1KPk0veKlxKbvJUm6YIaygMUrHLEwg7UV6tWvRbLKG1zMbelPomQhoC
   g==;
X-CSE-ConnectionGUID: DbDVG7ibRGGipklQrzEOxA==
X-CSE-MsgGUID: bFdqzaunQAaeT+3yX1Vleg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91453708"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="91453708"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 22:46:49 -0700
X-CSE-ConnectionGUID: XzdR/9egTCGu1IIYwXmBRw==
X-CSE-MsgGUID: oJ09ZlfPSZirtjHEI8vngw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="247043579"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 22:46:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-fixes 1/3] wifi: iwlwifi: mvm: don't support the reset handshake for old firmwares
Date: Fri, 29 May 2026 08:46:29 +0300
Message-Id: <20260529084540.9307b81d9b02.I21bba9e649f4cd0e35d3ea6cd97a03258be5832f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529054631.4039300-1-miriam.rachel.korenblit@intel.com>
References: <20260529054631.4039300-1-miriam.rachel.korenblit@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37091-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5C0405FD83B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

-77.ucode doesn't contain the fixes for this flow it seems.
Don't use the firmware reset handshake even if the firmware claims
support for it.

Fixes: 906d4eb84408 ("iwlwifi: support firmware reset handshake")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220600
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index ae177477b201..384bed95835d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1416,6 +1416,12 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 		fw_has_capa(&mvm->fw->ucode_capa,
 			    IWL_UCODE_TLV_CAPA_FW_RESET_HANDSHAKE);
 
+	/* Those firmware versions claim to support the fw_reset_handshake
+	 * but they are buggy.
+	 */
+	if (IWL_UCODE_MAJOR(mvm->fw->ucode_ver) <= 77)
+		trans->conf.fw_reset_handshake = false;
+
 	trans->conf.queue_alloc_cmd_ver =
 		iwl_fw_lookup_cmd_ver(mvm->fw,
 				      WIDE_ID(DATA_PATH_GROUP,
-- 
2.34.1


