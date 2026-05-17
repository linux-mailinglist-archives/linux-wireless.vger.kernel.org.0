Return-Path: <linux-wireless+bounces-36538-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMzqAbB1CWolbAQAu9opvQ
	(envelope-from <linux-wireless+bounces-36538-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:00:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7742855FD49
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1520A300A536
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 08:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BC1B67E;
	Sun, 17 May 2026 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZeRs4iX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83CC2E7F38
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004829; cv=none; b=kHK/Knle9JjnxK+6lKOT6BDqqN2vY66FVpAHhhYdCODB5pJrDv+3vLdwn8+ayAzG7CUGetgdY6whT95no8hpZs31JRSZ1C4N8MhExPOinXNJoTWXNTqpcjxJweAEZDnTndES0qgD3er57muX53sQprtbVRcWQoMCm0TS4smSpFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004829; c=relaxed/simple;
	bh=vbXJlk2v0wzXb7NI+i18eNmgMLLkKI0zXPdO0P6+iLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bUfR3WBgg+s125qojb9R+X4cHjwQlxjg1k28EBfJ+sKPxjOgEGQsyqkg/BzynluKNUg+dRo1AKOsF+sdwovQ4AIrAELN6NGffGorsSUpHdP6B6MF0c4HOgLXvev75QfwRN9gma7t/Wf/kbw/66+oJTR4ptzEy2yK254bjppASBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZeRs4iX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779004827; x=1810540827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vbXJlk2v0wzXb7NI+i18eNmgMLLkKI0zXPdO0P6+iLQ=;
  b=hZeRs4iX2CYRK+Pc/UiP2rULcDWPQuzGxb74IHcEzYCZu3kyLY2/eELQ
   KcnwjkLgQ27DvcxGx6tgCY0oxXHfPU8sSluTm1gW7AkI71Kp0F9Kus4e9
   Wvkh1rpKyhGZIGvANWqsVkcn8bkO+DfpJHvxEtpA/zOBOers5ows+AAZn
   TcH6mFM+nfv9A9Entth2t5IvVMABUznVkb+9tVGDClDR3fwISK8aIOBpe
   w6iXtaghRjtopIvyXTpvZ7uiuHhzB7TRitwwwXJ7ZLXWSbZ9/dzGV2PY+
   eVSAz1xZ2nxIK1aAIUNDW+kmczByaSqvo2wbD4sqvRh3nO8afEbux9SXs
   w==;
X-CSE-ConnectionGUID: 9ZaydWJgTHyvdXEgSCSjCw==
X-CSE-MsgGUID: e6B1Dt4QTpuAUPuqwkaVUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79606953"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="79606953"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:27 -0700
X-CSE-ConnectionGUID: S7K+Uo0KTvKD0OgkStn1uQ==
X-CSE-MsgGUID: P/wIwha/Rz61K9J0cgQNJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="236490387"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 02/15] wifi: iwlwifi: mld: purge async notifications upon nic error
Date: Sun, 17 May 2026 10:59:46 +0300
Message-Id: <20260517100550.4414228bf1d1.I1926a2b2e7827eaac22882699880ec04a3cb95f0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260517075959.2815365-1-miriam.rachel.korenblit@intel.com>
References: <20260517075959.2815365-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7742855FD49
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
	TAGGED_FROM(0.00)[bounces-36538-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This fixes a kernel panic in reconfig failure:

1. we have a BSS connection
2. we have a NAN connection
3. FW error occurs
4. reconfig restores the BSS connection
5. however, restoring the NAN connection fails due to a FW error.
6. erroneously, ieee80211_handle_reconfig_failure is called and marks all
   interfaces as not-in-driver (will be fixed in a different patch).
7. mac80211 frees the links of the BSS connection but doesn't tell the
   driver about that, as it thinks that this vif is not in the driver.
8. in ieee80211_stop_device, *ALL* wiphy works are getting flushed
   (erroneously?)
9. Therefore, async_handlers_wk is being executed, processing the
   statistics notification that was received after we restored the BSS
   connection.
10. the notification handler dereferences fw_id_to_bss_conf[id], which is
    now a dangling pointer, as mac80211 already freed this link in (7).
11. On the first access to one of the links fields, we panic.

While this can and should be fixed by removing the call to
ieee80211_handle_reconfig_failure in (6), it is also not a good idea to
carry and maybe handle notifications from a dead FW.

We do purge the notifications when we stop the FW, but in reconfig
failure we stop the FW too late, after the notifications are processed.
In addition, async_handlers_wk can always be scheduled before the
reconfig work.

Purge the notifications immediately when transport notifies about a nic
error.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 0ef7c24831d8..78c78cf891cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -676,6 +676,15 @@ iwl_mld_nic_error(struct iwl_op_mode *op_mode,
 	if (type != IWL_ERR_TYPE_RESET_HS_TIMEOUT &&
 	    mld->fw_status.running)
 		mld->fw_status.in_hw_restart = true;
+
+	/* FW is dead. We don't want to process its notifications.
+	 * Right, we cancel them also in iwl_mld_stop_fw, but
+	 * iwl_mld_async_handlers_wk might be executed before
+	 * ieee80211_restart_work.
+	 * In addition, in case of an error during recovery,
+	 * iwl_mld_stop_fw might be too late.
+	 */
+	iwl_mld_cancel_async_notifications(mld);
 }
 
 static void iwl_mld_dump_error(struct iwl_op_mode *op_mode,
-- 
2.34.1


