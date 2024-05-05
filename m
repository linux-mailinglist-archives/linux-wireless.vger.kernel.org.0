Return-Path: <linux-wireless+bounces-7181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457AF8BBF6F
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 08:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2C8281E38
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620F85227;
	Sun,  5 May 2024 06:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URnMynkG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12A44430
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890020; cv=none; b=Xm2LD2mVYxMfu1akJzrN3ANLhomPpiMlhN+irV5vw5IOwuufRcdZicuOUsKIZLvMaqoDtP3fiB8GD4sZR1TPHR1XKOzhT/5BWfr53BsYqpmyCCVx5/Ks54iloC4B5obXF6QWz+eJmuHuJYW31+tPBlANRQWijNtGuqskVSrSXNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890020; c=relaxed/simple;
	bh=ySzqQA3tEVvgCBNO9+K9wKPwYG9HyqmzBplQft8HAp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VBdVNPfbzzpqkJI74QuQxLVXoRHL6+Cdu3hWwHiqXuAtNLiTBdTnNH4cJnWlcfAsqRCvB+562eWKntuOHyJqO5rYOvxdoMnPG2Acbu9ty3aPhWZ3qJpthqNU+67uIfF3dGHnC+q8n2J+9pFBSnsjZsPYawaeSvJz7db4CEmnzoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=URnMynkG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714890019; x=1746426019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ySzqQA3tEVvgCBNO9+K9wKPwYG9HyqmzBplQft8HAp0=;
  b=URnMynkGBA57c/ZbV1/qFka7E99sfYVfd89p49CdXpOZ1YeE5iCE5n06
   sCWxBVfskRoCgmq9EnM/dZzc1MQQCPtYlt+98dt+zMLMARuHm1dzeRNoO
   PEy5kuUItzoLEKLQgHteESRp0iCCVH3KDJPA/tupB8ytkC+TZ0iopLMFy
   Vu+7cwsZRg8gSsLbCrI/LV5sP3AvNkDMz0Y69VWSvwaTMkMAN607bUIyX
   1dsmD1dKTfp6Dj5G1aviObXLwBCrjRd+Dc7A9s7C1pJ1XlL4Ts2ZAnXAc
   4MZpwN6yZ0uwKdIVlA0brTtRh+NDBP+UI7WP0FGWrknwXW4L6m/QqzLFz
   w==;
X-CSE-ConnectionGUID: lssjJg6wSQSyABMYU0zjtA==
X-CSE-MsgGUID: YMTQbXgUTFmoNX7KnlH0HA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14461805"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="14461805"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:18 -0700
X-CSE-ConnectionGUID: tGy1Tq0QQc6yoyoXEJOAtQ==
X-CSE-MsgGUID: bSm4Fs/iQjy3x9vzsfIusw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27903582"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: mvm: add a debugfs for (un)blocking EMLSR
Date: Sun,  5 May 2024 09:19:47 +0300
Message-Id: <20240505091420.eba2b6f0664c.I5f058e02abda11bf2eccfd2bcb59ca26bae87a3a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
References: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This is needed for testing purposes.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index aad736b7354b..213de638f132 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -722,6 +722,33 @@ static ssize_t iwl_dbgfs_int_mlo_scan_write(struct ieee80211_vif *vif,
 	return ret ?: count;
 }
 
+static ssize_t iwl_dbgfs_block_esr_write(struct ieee80211_vif *vif, char *buf,
+					 size_t count, loff_t *ppos)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm *mvm = mvmvif->mvm;
+	u32 reason;
+	u8 block;
+	int ret;
+
+	ret = sscanf(buf, "%u %hhu", &reason, &block);
+	if (ret < 0)
+		return ret;
+
+	if (hweight16(reason) != 1 || !(reason & IWL_MVM_BLOCK_ESR_REASONS))
+		return -EINVAL;
+
+	mutex_lock(&mvm->mutex);
+	if (block)
+		iwl_mvm_block_esr(mvm, vif, reason,
+				  iwl_mvm_get_primary_link(vif));
+	else
+		iwl_mvm_unblock_esr(mvm, vif, reason);
+	mutex_unlock(&mvm->mutex);
+
+	return count;
+}
+
 #define MVM_DEBUGFS_WRITE_FILE_OPS(name, bufsz) \
 	_MVM_DEBUGFS_WRITE_FILE_OPS(name, bufsz, struct ieee80211_vif)
 #define MVM_DEBUGFS_READ_WRITE_FILE_OPS(name, bufsz) \
@@ -742,6 +769,7 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(rx_phyinfo, 10);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(quota_min, 32);
 MVM_DEBUGFS_READ_FILE_OPS(os_device_timediff);
 MVM_DEBUGFS_WRITE_FILE_OPS(int_mlo_scan, 32);
+MVM_DEBUGFS_WRITE_FILE_OPS(block_esr, 32);
 
 void iwl_mvm_vif_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
@@ -772,6 +800,7 @@ void iwl_mvm_vif_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	debugfs_create_bool("ftm_unprotected", 0200, mvmvif->dbgfs_dir,
 			    &mvmvif->ftm_unprotected);
 	MVM_DEBUGFS_ADD_FILE_VIF(int_mlo_scan, mvmvif->dbgfs_dir, 0200);
+	MVM_DEBUGFS_ADD_FILE_VIF(block_esr, mvmvif->dbgfs_dir, 0600);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
 	    mvmvif == mvm->bf_allowed_vif)
-- 
2.34.1


