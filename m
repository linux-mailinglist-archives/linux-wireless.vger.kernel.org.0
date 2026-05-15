Return-Path: <linux-wireless+bounces-36466-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGFRDOIRB2rgrQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36466-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:30:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF64354F944
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C079F30EC740
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A091EFFA1;
	Fri, 15 May 2026 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idWxHbMN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2D44D68A
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847007; cv=none; b=hYkJxwVmMdeSXVYBpvCZ/iEhdXZxSRCqyLF12JNoJCvkIFD/cubT5IVJ/GIn+x1LZTUVG/b+z+EscAHvjWYxnqh7On3nhufTDwDKgrSOYTKOl1SpPK3Eww3RZWHsRMxc/xsEtqInSD9Tm795s/9+jKkQppF+7OjclSHG7iNvFyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847007; c=relaxed/simple;
	bh=CET4Qgc/De/+tevN55TNyZDMwhLlRkFzRBCdKp0x5GA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=km9ay5dxg9dw9TXK2JM9Cg4iPLdU/73zABKZnes/VszdY5euzxEnvOOjoc/Q1CkxPyAEmcTJUd8EQQ6jQpRi8tQbFpbskgC0t41VSoBJoZP5tZxDHVQKiXXABUvhheL0rMOcAPKfoin85o5Ui1wH6T9WQu35Bypv5XYiib7vry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idWxHbMN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847006; x=1810383006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CET4Qgc/De/+tevN55TNyZDMwhLlRkFzRBCdKp0x5GA=;
  b=idWxHbMNrPS5J1j5nmhpIDwuLFxRywkRqKtRTLzFpEHCgrhIeZyU8ANB
   tP2N1m5uSyPdiuhoOZ/wvykI7l83+5VwgG75xO7NyYZuixFcGIIe5nvKP
   0zN0I6yCaHE/9s9MezdYvdUpJGW5SPKCmNdo/+V5q0vhYVSLrqWgHFmHt
   uatyegD4a8DmIOuyd+YL//yNeCa17xtkrL43uIkwfDyMAkNic1WP60DKP
   tNA6Ax8P2AtD8NWRnKXCoBn3z20u8ChZM2uMqJB8LT6b0f+EBikgS+9WO
   q7huGIKCgo602EQNqCO7Mvp5d/YkoGsT2P6zFzZRV98lFbluPGNB5M0ub
   g==;
X-CSE-ConnectionGUID: zXf0alaCTMqyPiOS55dgjw==
X-CSE-MsgGUID: sa4Ntxx0RbyzmIxpyDQYOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="91185662"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="91185662"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:04 -0700
X-CSE-ConnectionGUID: fOkuTuXNStiSZyLOPxoHpQ==
X-CSE-MsgGUID: hteg9gvMS9ShmHK8HVQ0Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="243649951"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH v2 iwlwifi-next 01/15] wifi: iwlwifi: mld: nan: add availability attribute to schedule config
Date: Fri, 15 May 2026 15:09:34 +0300
Message-Id: <20260515150751.97809376508e.Ie7f00f97992016c6bb2f4a5c9fc201ac58eed8ce@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
References: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CF64354F944
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36466-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Avraham Stern <avraham.stern@intel.com>

Add the availability attribute to the schedule config command. The
firmware needs to add this attribute to schedule update frames
(e.g. when ULW changed or the local schedule changed).

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/nan.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index 530ba263c5f0..d13b2374b642 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -693,6 +693,14 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 		break;
 	case 2:
 		cmd_size = sizeof(struct iwl_nan_schedule_cmd);
+
+		if (sched_cfg->avail_blob_len &&
+		    !WARN_ON(sched_cfg->avail_blob_len >
+			     sizeof(cmd.avail_attr.attr))) {
+			cmd.avail_attr.attr_len = sched_cfg->avail_blob_len;
+			memcpy(cmd.avail_attr.attr, sched_cfg->avail_blob,
+			       sched_cfg->avail_blob_len);
+		}
 		break;
 	default:
 		IWL_ERR(mld, "NAN: unsupported NAN schedule cmd version %d\n",
@@ -727,6 +735,15 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 	BUILD_BUG_ON(ARRAY_SIZE(sched_cfg->channels) !=
 		     ARRAY_SIZE(cmd.channels));
 
+	/*
+	 * mac80211 removes unused channels before adding new ones, so it may
+	 * update an empty schedule with an availability attribute because it
+	 * is going to add channels later. Since the firmware does not expect
+	 * an availability attribute without channels, ignore it in that case.
+	 */
+	if (empty_schedule)
+		cmd.avail_attr.attr_len = 0;
+
 	/* find links we can keep (same chanctx/PHY) */
 	for (i = 0; i < ARRAY_SIZE(sched_cfg->channels); i++) {
 		struct ieee80211_chanctx_conf *chanctx;
-- 
2.34.1


