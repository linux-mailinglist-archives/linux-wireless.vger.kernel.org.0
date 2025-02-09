Return-Path: <linux-wireless+bounces-18663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE128A2DDCB
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 13:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53EB31622CF
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 12:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECC51E522;
	Sun,  9 Feb 2025 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PpedIIbL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78241DDA17
	for <linux-wireless@vger.kernel.org>; Sun,  9 Feb 2025 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104516; cv=none; b=OTfE/tdSwMCmrNlQg4qhlcSW/5QgM1YZ8o3DgnACLuu3QkfCmtAiCXigJZOLhMRki8iSFAyPhUrzliczbjEsI5Kn6WMuimi8d9EisZRseRk3bB+/6ySAGnErWmcJfbTz9AJAV50Vt2wK8yuOEw3TP3IuRIhbL7iwYyeAUlYk/Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104516; c=relaxed/simple;
	bh=l2k7HII3YGdwO7uoO7U2yXSbk6HJDNo9+5z1a2AXj5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LS7lZl1g/WNzOoMHFM+YM04bXEhLsCPQXIutug73GxQM5Uh8e5lE5qi+3vYlYdEWh2Ns5w9wIUCZ9tQZ2kGmACbfRy6jVwz279KsjZVY6eJ87PjX+ntZbTFWqe0fCszc/Kb7SV0CquuQoZJylQP0wHVwBiJoqnzeWQ3tTKkzokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PpedIIbL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739104515; x=1770640515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l2k7HII3YGdwO7uoO7U2yXSbk6HJDNo9+5z1a2AXj5Y=;
  b=PpedIIbLPwCqz/8d8db2vKUpLCgd1AEM4sa9ElpDiycuNjWocfZ7P23g
   uLFY3GvReqFmX+bRipUh/RRQHDbpJvidliniuWKaizAdFuFZqmzoO+XIg
   tk/0bCDkS9SfdF39vBsaEKe5sEAlpNxz9tYXIaNaMN8KWz9xxAF8NEq2Q
   4Tw7eWxTcC2XRbxEz0ZWRXMyaUUdNmsnHkcJgNzlGcMdH8dNWqhSGuyvI
   e9cql0/C2IOAanB42uCOz4DRRR3IBXeu+un9U2EyjNGqky50xhQYWVLU1
   BJezAw4Hd7BUsrKCh9+J0Y+pNZQUh9sC2ytbix8od7G4vwbhCVSzI1F9P
   Q==;
X-CSE-ConnectionGUID: W9E29l6LQ3mesQV3DmkZ7Q==
X-CSE-MsgGUID: rf1FCsqZTRSRhVHcBmhP/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51125976"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51125976"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:14 -0800
X-CSE-ConnectionGUID: z0HIb6zaQMmoAiTVPOohOA==
X-CSE-MsgGUID: /7mF8LTHQJyjy/RaT0V0lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111782419"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:13 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 3/9] wifi: iwlwifi: mvm: clean up ROC on failure
Date: Sun,  9 Feb 2025 14:34:47 +0200
Message-Id: <20250209143303.0fe36c291068.I67f5dac742170dd937f11e4d4f937f45f71b7cb4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
References: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the firmware fails to start the session protection, then we
do call iwl_mvm_roc_finished() here, but that won't do anything
at all because IWL_MVM_STATUS_ROC_P2P_RUNNING was never set.
Set IWL_MVM_STATUS_ROC_P2P_RUNNING in the failure/stop path.
If it started successfully before, it's already set, so that
doesn't matter, and if it didn't start it needs to be set to
clean up.

Not doing so will lead to a WARN_ON() later on a fresh remain-
on-channel, since the link is already active when activated as
it was never deactivated.

Fixes: 35c1bbd93c4e ("wifi: iwlwifi: mvm: remove IWL_MVM_STATUS_NEED_FLUSH_P2P")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 9216c43a35c4..ebfa88b38b71 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -1030,6 +1030,8 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 		/* End TE, notify mac80211 */
 		mvmvif->time_event_data.id = SESSION_PROTECT_CONF_MAX_ID;
 		mvmvif->time_event_data.link_id = -1;
+		/* set the bit so the ROC cleanup will actually clean up */
+		set_bit(IWL_MVM_STATUS_ROC_P2P_RUNNING, &mvm->status);
 		iwl_mvm_roc_finished(mvm);
 		ieee80211_remain_on_channel_expired(mvm->hw);
 	} else if (le32_to_cpu(notif->start)) {
-- 
2.34.1


