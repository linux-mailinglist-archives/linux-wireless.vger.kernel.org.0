Return-Path: <linux-wireless+bounces-2616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD183F473
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 07:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC9B1C2109C
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 06:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFB21947E;
	Sun, 28 Jan 2024 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nT5qr/9N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBC51805E
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jan 2024 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706424899; cv=none; b=m96xoTg1/uQWJy3CcsEmAzo5/oF5/ha99LZrQVfMChfIU8VgaLWBvAdv0lcYkKmpSsY+EUuBeM8d3BoZp6f55Iz0D1JObIy7DkGf7R8czzFcvEHr/2aOvzc1mSH5vuZUR3qliv3k+YcYBAZMB0sx7647s5Ia1ttxBAL1CXW3OUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706424899; c=relaxed/simple;
	bh=sAAz2rLeSXG6wkkVr2PXZqVaKQhsXTtY9g4x0YzaaLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QSFLq/6xcoAn/BDzWDl1wMkdM5vy9v2hzHzYS1HhQY63FCYAlnOYiXZSE+9ZcWXe8AUWdM1DFrjAAns0ixvOTz0r+vfE5tiZaVhlnBqrIuROGehQ2Rl0PeGaTXNnPey16NbCzdoQLFvtLW1YoZuj04TKtztTcS0XZZL3F78+R7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nT5qr/9N; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706424899; x=1737960899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sAAz2rLeSXG6wkkVr2PXZqVaKQhsXTtY9g4x0YzaaLE=;
  b=nT5qr/9NLKT89YFL3skmNr6ob1R5W0Pg0iSubjtQwkt8b4Z6t76xFFHF
   3QPuoScSfdxgylx2hgjwpWoYW/DfgJzmfDJQKRsWuqgNdx1h+PEanyxKH
   V56zLHATI0zX3o5eRpw2EfGHc0YLoCXQfzSRpREiiXb7ntcR0S6bnVRxN
   7/rgOGGxwaG4pOr39dOI4kTT81ywJNg/oRGhWyRSlU2IjzM85ELD1zwJc
   2Q3bhDVx9RGZ3fWVhNwYIbjYqcEwNCSIPA0JAG0TAgkiOkfEiPWlhLJ7W
   5c1fSN7z/iTCpm8d9Buiox6JPeTcOJsGwJv/8KDqAap/EVgRv2D50tJTs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="24217680"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="24217680"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:54:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35833368"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:54:56 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/14] wifi: iwlwifi: mvm: disconnect station vifs if recovery failed
Date: Sun, 28 Jan 2024 08:53:56 +0200
Message-Id: <20240128084842.e90531cd3a36.Iebdc9483983c0d8497f9dcf9d79ec37332a5fdcc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
References: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This will allow to reconnect immediately instead of leaving the
connection in a limbo state.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index b6acf4ade552..175024170357 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1504,6 +1504,13 @@ void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
 
 #endif /* CONFIG_ACPI */
 
+static void iwl_mvm_disconnect_iterator(void *data, u8 *mac,
+					struct ieee80211_vif *vif)
+{
+	if (vif->type == NL80211_IFTYPE_STATION)
+		ieee80211_hw_restart_disconnect(vif);
+}
+
 void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 {
 	u32 error_log_size = mvm->fw->ucode_capa.error_log_size;
@@ -1548,10 +1555,15 @@ void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 	/* skb respond is only relevant in ERROR_RECOVERY_UPDATE_DB */
 	if (flags & ERROR_RECOVERY_UPDATE_DB) {
 		resp = le32_to_cpu(*(__le32 *)host_cmd.resp_pkt->data);
-		if (resp)
+		if (resp) {
 			IWL_ERR(mvm,
 				"Failed to send recovery cmd blob was invalid %d\n",
 				resp);
+
+			ieee80211_iterate_interfaces(mvm->hw, 0,
+						     iwl_mvm_disconnect_iterator,
+						     mvm);
+		}
 	}
 }
 
-- 
2.34.1


