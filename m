Return-Path: <linux-wireless+bounces-11147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8D194C5A8
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 22:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9390B1F2145A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 20:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632B1158D7F;
	Thu,  8 Aug 2024 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRFiE/sr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577A15D5C1
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148601; cv=none; b=NQ+/qyJRosMt9cVyYK3Sao9qNWQz1Q/y7CgM9W8pTa2w2q9M+boYRqaPO/TlTo4FpEbT2lMGcmWuL9JFAxuhIqoT87L3Sci4IactptWQpwjQTNS1lQBqau/7ZiC1sM45yR0HmlyqF6Dr0YRNamJE2e1Phqln4lxjDIMLR6XKDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148601; c=relaxed/simple;
	bh=JmZGHjDmkZRhxs9y+Es471c5l15L7ZyJLf7ffm78xlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Clm4mT4kSkPswx53A9fO3bLeOOx634NmCL42sCaeiLaUodpdPOnvUVceqrC1bOebXnhtkHhihRRWgltCKRXth0U5Dsndzt8PnpDGBsAVZ8nuJHYf0oIJTxqNtkPVFZHORhPbWPgUNHxQE4Jw6wPAgrN4ynWQMPAWG4/YtabbKEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRFiE/sr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723148600; x=1754684600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JmZGHjDmkZRhxs9y+Es471c5l15L7ZyJLf7ffm78xlc=;
  b=KRFiE/srjFOBWGT8tNI8yq4Fyx5aK0bq31C9+tMergThHQUYtrf85lMi
   a2xV/gczAFTopBgl7tDuEDc7YLlQwSc0n2uaB15MdCItwlEoOc8hhIUqc
   viHU0WOpYbCDejfxWh9HoZSVK+zarCi+e5A25hENZMArz50CjSnSS1DxL
   1KKm8AKwTbf1aPIkI0k6RabtP5eBhJQMIGYksZOwrl3RlizObPM2l2Siu
   vJOeE9Wu3HhJhf2jd7GPepyp1fdlzOOB1Qm9lxhXR15PefHyKjXeMW1GQ
   Xo+Fv3+rQG4505g6kCr9RJcGrfLR08u6Je26CTl7P8iI7KI4ky9rbOlAq
   A==;
X-CSE-ConnectionGUID: FHdtL8ZHSmeA8p+uMdwR3Q==
X-CSE-MsgGUID: 0EvF9IhrQeWGMG/oczDNjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38808868"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="38808868"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:19 -0700
X-CSE-ConnectionGUID: GXFfDZhJTsuqAhDyZuM3HQ==
X-CSE-MsgGUID: R3/Ve5FJQweic2+XPcgogQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57305346"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/13] wifi: iwlwifi: mvm: drop wrong STA selection in TX
Date: Thu,  8 Aug 2024 23:22:48 +0300
Message-Id: <20240808232017.45ad105dc7fe.I6d45c82e5758395d9afb8854057ded03c7dc81d7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
References: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This shouldn't happen at all, since in station mode all MMPDUs
go through the TXQ for the STA, and not this function. There
may or may not be a race in mac80211 through which this might
happen for some frames while a station is being added, but in
that case we can also just drop the frame and pretend the STA
didn't exist yet.

Also, the code is simply wrong since it uses deflink, and it's
not easy to fix it since the mvmvif->ap_sta pointer cannot be
used without the mutex, and perhaps the right link might not
even be known.

Just drop the frame at that point instead of trying to fix it
up.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c    | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index af892c8291d4..f3f5cfd3baaa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -839,20 +839,10 @@ void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
 	if (ieee80211_is_mgmt(hdr->frame_control))
 		sta = NULL;
 
-	/* If there is no sta, and it's not offchannel - send through AP */
+	/* this shouldn't even happen: just drop */
 	if (!sta && info->control.vif->type == NL80211_IFTYPE_STATION &&
-	    !offchannel) {
-		struct iwl_mvm_vif *mvmvif =
-			iwl_mvm_vif_from_mac80211(info->control.vif);
-		u8 ap_sta_id = READ_ONCE(mvmvif->deflink.ap_sta_id);
-
-		if (ap_sta_id < mvm->fw->ucode_capa.num_stations) {
-			/* mac80211 holds rcu read lock */
-			sta = rcu_dereference(mvm->fw_id_to_mac_id[ap_sta_id]);
-			if (IS_ERR_OR_NULL(sta))
-				goto drop;
-		}
-	}
+	    !offchannel)
+		goto drop;
 
 	if (tmp_sta && !sta && link_id != IEEE80211_LINK_UNSPECIFIED &&
 	    !ieee80211_is_probe_resp(hdr->frame_control)) {
-- 
2.34.1


