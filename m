Return-Path: <linux-wireless+bounces-3171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135D984A6D7
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEDE2915D3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D0C59146;
	Mon,  5 Feb 2024 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WzzryYg5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D9058ADE
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160917; cv=none; b=jBXLdxL4dooZ9AR6HKPLj2PDg7QLi4H1rR6dHRdO4ia+GK8J3kUpHbw0Bkboh3xTXafowNwAuWVqxiE2N10AiTGg0QeYi5nHv8um5ntLPa9d4zQmFJRAarFXvCjGlkCwmP8CVljdPAMdxAPiPv5gMvaBLAwL66f7AlObAeqY4aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160917; c=relaxed/simple;
	bh=HMiH+npE30AH5y1E0Mg2xjsdAkpS50AWbZc/V+cxXvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YqQDvbsM6kcnWaIS0Yimo2vJjrBSl8EMjx3hmbf1MQoGxCORSJOPinYVLmQ156hqjjjqfOG0YzMn3HzSgKPPaDKrk7eaRAKi6z+U14+7fzy2UpM08RbpAC2N7yARhFnvIVJfaoUACuIMvvsRzXO1/pJCFr3u4j6EmXmbjXzhaQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WzzryYg5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160915; x=1738696915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HMiH+npE30AH5y1E0Mg2xjsdAkpS50AWbZc/V+cxXvM=;
  b=WzzryYg5yCkhr+zedg4iktKQnFgNo8/1APmf+0cuuTrt3PZ42Y5+yLMd
   rf6V/zc2GpBmCm98FTb1Gb2SI4B/bZH83NfPv4l21MXu5f9Z7Lbn/2CYo
   PPeKstPJyS24CgRQWzSH+mI5MySlk/rnIjS0RSe+eQ7u91WMgplgUyzmI
   t8HDb+kUcx4YI+dEGD/k1jICgxq8w/2S/0T+jBu9c7bUKeVpZBajBjyqc
   /BfwRwWNdPxRwpNskxJEVxr0XjTEaWDc/FnRHAO+kTe9AR8yFXoL6ERV4
   xbE2l/LJ+ONkmOaL+ffmK1rl3q+feVFQlJIkN57OQGvybXBJuvVpkkPGQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4381631"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4381631"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5403135"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:55 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 08/15] wifi: iwlwifi: cancel session protection only if there is one
Date: Mon,  5 Feb 2024 21:21:08 +0200
Message-Id: <20240205211151.30176bf869d9.Id811c20d3746b870cbe0c946bbfe1c0ab0a290cb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
References: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

mac80211 might (due to an unavoidable race) cancel a ROC that has already
expired. In that case the driver should not send the session protection
cmd to cancel the ROC.
When session protection is supported, the te_data::id field is reused
to save the configuration id. Check it before sending the cmd.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/time-event.c  | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 658f6f20391c..80532c56b20e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -1224,13 +1224,21 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD)) {
 		mvmvif = iwl_mvm_vif_from_mac80211(vif);
+		te_data = &mvmvif->time_event_data;
+
+		if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
+			if (te_data->id >= SESSION_PROTECT_CONF_MAX_ID) {
+				IWL_DEBUG_TE(mvm,
+					     "No remain on channel event\n");
+				return;
+			}
 
-		if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
 			iwl_mvm_cancel_session_protection(mvm, vif,
-							  mvmvif->time_event_data.id,
-							  mvmvif->time_event_data.link_id);
-		else
+							  te_data->id,
+							  te_data->link_id);
+		} else {
 			iwl_mvm_roc_station_remove(mvm, mvmvif);
+		}
 		goto cleanup_roc;
 	}
 
-- 
2.34.1


