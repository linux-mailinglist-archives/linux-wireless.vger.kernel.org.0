Return-Path: <linux-wireless+bounces-2403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2250683974E
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556FB1C24220
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83034823A3;
	Tue, 23 Jan 2024 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkAyslj8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1D781AD4
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033346; cv=none; b=Xl8Ae+QgaOCw2TMDR4NUsLS3CiJfex6zJuAOyPiqX08qlDNmfCrUJz5LFKQVBtgm+JWxzPTxvhc0SII/yGwLjXaor3s/VE4tA3aZy8CZqldClyQglYHXgVjcN8gTRdS1cHqB5Ycw3I/rR/Lt2YxCPOShqEkjKwNIQFk9qTNDnco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033346; c=relaxed/simple;
	bh=Ps2ihVN6klVYh+qGwHyjEIDuaaP2isysZ47X8mmjnz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=keFEluIV30YriJ5GlU2a/go0UmT/KN8EWk1gnJsc+TROcsc35Uj798OblkYRLaZZ4XBR3NhAzzK9FikzZ4oI1pvGt/Ie0Mjm316qYHAWPPTKLeYPei8cz83ildLAoQO7IFxrjBPm9btVpjWdzoU8jxyjH2swFlqwbNY5BzxSNIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SkAyslj8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706033345; x=1737569345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ps2ihVN6klVYh+qGwHyjEIDuaaP2isysZ47X8mmjnz8=;
  b=SkAyslj86KXeGGhn1LbrMlD5jfOCo99WAa/o9bfgRcQz0Ud0AlEEiV6y
   5mrHoV8wSUl2yZA3z9NkvzVCn4hX8ZnC01RPOQ3bBW4GJEvYq1NL+ZlUo
   u8b5ZpS4yVFf0Yd5B1vw7Qf7gJhUCROFDdzKaynTza8/KrqUpAqOJgO7u
   aw4bI42eJoiklHJL3pM7279B9KZzRg958U8PluJuKk+78ZKa3ybXaHTFr
   MGJzs2yS4Ro5YaRaDpTcuIbeSMmvR/DCXdTX74BMk7b0qWN+UhIJeqA5i
   yEZoM/c2mCRtYG/yLdJgLoC+LNgUuAUQgkHePqx06d1atjXED7TrbyKrm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="501838"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="501838"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:09:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1666545"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:09:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: change link id in time event to s8
Date: Tue, 23 Jan 2024 20:08:16 +0200
Message-Id: <20240123200528.50d4941f946c.Iea990b118c69bc3e1eb61c1d134c9d470b3a17ac@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
References: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Link ID in time event data is -1 when the time event is cleared.
Change the type of the link ID in the time event data structure
and in the affected function from unsigned to signed.

Fixes: 135065837310 ("wifi: iwlwifi: support link_id in SESSION_PROTECTION cmd")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h        | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 40627961b834..997f0395b97a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -121,7 +121,7 @@ struct iwl_mvm_time_event_data {
 	 * if the te is in the time event list or not (when id == TE_MAX)
 	 */
 	u32 id;
-	u8 link_id;
+	s8 link_id;
 };
 
  /* Power management */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 218fdf1ed530..aceab96bcb97 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -692,7 +692,7 @@ void iwl_mvm_protect_session(struct iwl_mvm *mvm,
 /* Determine whether mac or link id should be used, and validate the link id */
 static int iwl_mvm_get_session_prot_id(struct iwl_mvm *mvm,
 				       struct ieee80211_vif *vif,
-				       u32 link_id)
+				       s8 link_id)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ver = iwl_fw_lookup_cmd_ver(mvm->fw,
@@ -716,7 +716,7 @@ static int iwl_mvm_get_session_prot_id(struct iwl_mvm *mvm,
 
 static void iwl_mvm_cancel_session_protection(struct iwl_mvm *mvm,
 					      struct ieee80211_vif *vif,
-					      u32 id, u32 link_id)
+					      u32 id, s8 link_id)
 {
 	int mac_link_id = iwl_mvm_get_session_prot_id(mvm, vif, link_id);
 	struct iwl_mvm_session_prot_cmd cmd = {
@@ -745,7 +745,7 @@ static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 	struct ieee80211_vif *vif = te_data->vif;
 	struct iwl_mvm_vif *mvmvif;
 	enum nl80211_iftype iftype;
-	unsigned int link_id;
+	s8 link_id;
 
 	if (!vif)
 		return false;
@@ -1296,7 +1296,7 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 	struct iwl_mvm_time_event_data *te_data = &mvmvif->time_event_data;
 	const u16 notif[] = { WIDE_ID(MAC_CONF_GROUP, SESSION_PROTECTION_NOTIF) };
 	struct iwl_notification_wait wait_notif;
-	int mac_link_id = iwl_mvm_get_session_prot_id(mvm, vif, link_id);
+	int mac_link_id = iwl_mvm_get_session_prot_id(mvm, vif, (s8)link_id);
 	struct iwl_mvm_session_prot_cmd cmd = {
 		.id_and_color = cpu_to_le32(mac_link_id),
 		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
-- 
2.34.1


