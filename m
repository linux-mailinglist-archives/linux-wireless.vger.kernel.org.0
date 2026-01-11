Return-Path: <linux-wireless+bounces-30661-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6234D0F87A
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A295A3095AA3
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA7021ABBB;
	Sun, 11 Jan 2026 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzpNZgIF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B91534D3A8
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153193; cv=none; b=PkDCUzVBDRgAe/d0wWhPENQpzMQVnyKX+Gz1zKbaa5y0jejaqPKcL5aAbdNN4s1m5W76gv0Fb98p3DFF3bii6rTrvfoveaZTz4B1HMnymJZd0EYp6GfsU+gJvYMMmZNJk9/e1shwNqa9hiI/L4tbecZRY9yEraxXrkqmmti529Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153193; c=relaxed/simple;
	bh=18DQmoPqJ2cFmCevaFglI6rDaEG+yok+9376IPE/4MA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q86FfaWoh8UubAgmsSmqHct4T+NHco05FsCB2dIMlYyhAz82blUFWSpNIZ2Gtkl61RKlv9STesS4qpPSJn/kl87ulVJ0IxCnzBwEaBVkNZT1ZDFNL59cf4aHWzxBK5HADTc1abbzteLOWaGvyHbig64V8gKlClFVoOY6BPSNy90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzpNZgIF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768153192; x=1799689192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=18DQmoPqJ2cFmCevaFglI6rDaEG+yok+9376IPE/4MA=;
  b=BzpNZgIF6PjlWRSt9Qe8mp8T+qtPQT9HNM0gQPvVOL6eOGAOt2z8s3iy
   PnLRVVXPohhRkL1BPrsP375tVpLS6WODZ42t9bX+INfsLNc1VRlsYyY88
   UUnfuc8wHn8S/PSJi3d2V2YzEJL/Rr6aYVgbOS4SuwQK06T3IHbySoyEC
   i4LgiA2jwOycm8olc3yst+PHHPJKxB54xuIJT5EjGdIgbZoOv+2ho1xrU
   RBQnhwxkC0jAgqOz+vPMdqPkVDF1RTmvrvlt4OjM+omM2xhoua+y9zJiB
   k5K2owcsHWsluI88CAeP58mq3qg9ZMYqu1PofFlV9vvgNGQv5OssGEUOa
   Q==;
X-CSE-ConnectionGUID: tncksY2uS5ero3BG3TbglA==
X-CSE-MsgGUID: JgUlJmwsQ2qTdvos3spffw==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69521098"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69521098"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:52 -0800
X-CSE-ConnectionGUID: U/hTg7wkQUi5yFwTEPwDMw==
X-CSE-MsgGUID: SUWxcB/+TaW7br4sP3OI+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208393815"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:50 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: mld: change cluster_id type to u8 array
Date: Sun, 11 Jan 2026 19:39:24 +0200
Message-Id: <20260111193638.80921dc7d305.I56c2bbe0bfc6ee02782bc5d69fda2ac77f3502c4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
References: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

While the cluster_id is two bytes long, it is just the last two bytes of
the cluster ID MAC address. This does not really map to a big or little
endian data type. Switch it to use an array to avoid confusion and
adjust all users so that they do the right thing independent of
endianness.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h  |  9 +++++----
 drivers/net/wireless/intel/iwlwifi/mld/nan.c     | 16 +++++++---------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index f260115abc5a..c7a833f8041a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -1057,7 +1057,8 @@ enum iwl_nan_flags {
  * @nmi_addr: NAN Management Interface (NMI) address
  * @reserved_for_nmi_addr: reserved
  * @discovery_beacon_interval: discovery beacon interval in TUs
- * @cluster_id: local cluster ID, in case the local device starts a cluster
+ * @cluster_id: lower last two bytes of the cluster ID, in case the local
+ *	device starts a cluster
  * @sta_id: station ID of the NAN station
  * @hb_channel: channel for 5 GHz if the device supports operation on 5 GHz.
  *	Valid values are 44 and 149, which correspond to the 5 GHz channel, and
@@ -1082,7 +1083,7 @@ struct iwl_nan_config_cmd {
 	__le16 reserved_for_nmi_addr;
 	__le32 discovery_beacon_interval;
 
-	__le16 cluster_id;
+	u8 cluster_id[2];
 	u8 sta_id;
 	u8 hb_channel;
 
@@ -1113,12 +1114,12 @@ enum iwl_nan_cluster_notif_flags {
  * struct iwl_nan_cluster_notif - event sent when the device starts or joins a
  *	NAN cluster.
  *
- * @cluster_id: cluster ID
+ * @cluster_id: the last two bytes of the cluster ID
  * @flags: combination of &enum iwl_nan_cluster_notif_flags
  * @reserved: reserved
  */
 struct iwl_nan_cluster_notif {
-	__le16 cluster_id;
+	u8 cluster_id[2];
 	u8 flags;
 	u8 reserved;
 }; /* NAN_JOINED_CLUSTER_NTF_API_S_VER_1 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index d4298f44baf7..2dbd3d58b0c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -55,8 +55,8 @@ static int iwl_mld_nan_config(struct iwl_mld *mld,
 	cmd.master_pref = conf->master_pref;
 
 	if (conf->cluster_id)
-		cmd.cluster_id =
-			cpu_to_le16(*(const u16 *)(conf->cluster_id + 4));
+		memcpy(cmd.cluster_id, conf->cluster_id + 4,
+		       sizeof(cmd.cluster_id));
 
 	cmd.scan_period = conf->scan_period < 255 ? conf->scan_period : 255;
 	cmd.dwell_time =
@@ -215,14 +215,14 @@ void iwl_mld_handle_nan_cluster_notif(struct iwl_mld *mld,
 		ieee80211_vif_to_wdev(mld->nan_device_vif) : NULL;
 	bool new_cluster = !!(notif->flags &
 			      IWL_NAN_CLUSTER_NOTIF_FLAG_NEW_CLUSTER);
-	u8 cluster_id[ETH_ALEN] __aligned(2) = {
-		0x50, 0x6f, 0x9a, 0x01, 0x00, 0x00
+	u8 cluster_id[ETH_ALEN] = {
+		0x50, 0x6f, 0x9a, 0x01,
+		notif->cluster_id[0], notif->cluster_id[1]
 	};
-	u16 id = le16_to_cpu(notif->cluster_id);
 
 	IWL_DEBUG_INFO(mld,
-		       "NAN: cluster event: cluster_id=0x%x, flags=0x%x\n",
-		       id, notif->flags);
+		       "NAN: cluster event: cluster_id=%pM, flags=0x%x\n",
+		       cluster_id, notif->flags);
 
 	if (IWL_FW_CHECK(mld, !wdev, "NAN: cluster event without wdev\n"))
 		return;
@@ -231,8 +231,6 @@ void iwl_mld_handle_nan_cluster_notif(struct iwl_mld *mld,
 			 "NAN: cluster event without NAN started\n"))
 		return;
 
-	*((u16 *)(cluster_id + 4)) = id;
-
 	cfg80211_nan_cluster_joined(wdev, cluster_id, new_cluster, GFP_KERNEL);
 }
 
-- 
2.34.1


