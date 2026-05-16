Return-Path: <linux-wireless+bounces-36520-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJjUC53PCGp+6QMAu9opvQ
	(envelope-from <linux-wireless+bounces-36520-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:12:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6C355DA00
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 007F430131D9
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 20:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C678A54654;
	Sat, 16 May 2026 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/6TiEgw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF732BDC23
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778962316; cv=none; b=NhKR4PttN9QORT4u7w3GDPy8T7fVTz5Cdy7IujwtE5ZJPLM8s7D3tBZvUFtYYDcaMsqxHFe/jydMqOo70+Fe2/1JMwtqdLnGNRw8n/7yd2b9qrTTA8gtc3IYePvPWXWNrM0bwImR05O7FHGLgMtGy61yEiY+PeDh8818HACckH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778962316; c=relaxed/simple;
	bh=vbXJlk2v0wzXb7NI+i18eNmgMLLkKI0zXPdO0P6+iLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWPCtQJii+Vs6peBsYP9ebXtTBVdXXYh25G6B8SnY42aa2yXMa0gb/GyzrmiKKotnl5+UJytXtlYeUw8+ssGo3DSSi7BaHg6fi6uBSVgQPnVisRKHJUjG4WEG6/6ZLGJm0urcsDKlHqdKWQMjZB+iLXbIA4dqo5o9Xy+zKXku2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/6TiEgw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778962316; x=1810498316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vbXJlk2v0wzXb7NI+i18eNmgMLLkKI0zXPdO0P6+iLQ=;
  b=i/6TiEgweM2Gn2y8BcNCAAqc54ugHCa8Lj3VvQ6x19Ai9q2ikASkE8Ti
   6ARlL8zGgjyF4m2kTDZmNlHYkW96uoz+EY7dM1kMb8jJos2D8dRjiIfzK
   CQ+2DNbg1LRtIOq11Kh2JjBs/TiiRjaxunRfB4a25Mr693IG2C4bfMGXa
   VBaeT9XfaMJSfAcu2/xNAvtdkRtbkp2lf+X4AlRI8spfKWJNNVpn0i1Ny
   vX3dchWulpl008tiGIUomFVi0Buoa/9PslRRYGYvmR9E7/FnE/xk2q19E
   FfxqOOe43uDv16Xztj8n8kFyZDJWrr7NMGPtwT9fpSm5/XnW1RFwO0ph9
   A==;
X-CSE-ConnectionGUID: 8cAz6k2CQdSF3Y+K0TxKuQ==
X-CSE-MsgGUID: mhla6/6aQCi/SjYSH4iubw==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79845723"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="79845723"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:11:55 -0700
X-CSE-ConnectionGUID: yOqfH3OVTJuVaftXNQr5NA==
X-CSE-MsgGUID: H3qF3mnkSyuJ1wWFL5ejOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="239130860"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:11:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 02/15] wifi: iwlwifi: mld: purge async notifications upon nic error
Date: Sat, 16 May 2026 23:11:24 +0300
Message-Id: <20260516230843.4414228bf1d1.I1926a2b2e7827eaac22882699880ec04a3cb95f0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
References: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA6C355DA00
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
	TAGGED_FROM(0.00)[bounces-36520-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim]
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


