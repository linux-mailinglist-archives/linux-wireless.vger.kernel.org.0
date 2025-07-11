Return-Path: <linux-wireless+bounces-25287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE7CB0208F
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 17:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 476247B92C6
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 15:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5A52EE282;
	Fri, 11 Jul 2025 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xu9tCq5h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93352ECEA6
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248106; cv=none; b=IoFrvNjpB2TEvwgcwGZ/G35RrsQlud6BbqNG/UuEL9K/fblymSFdVphKgpj+rrFtNdm+IWpVOTTrzb3Rz0BJLeNuUA1C3VPt6JNcCylLsM043CORm6Pp84d8Tt1RX2v8RpDq+MChWWtNQK8MYWAC27XhAkPLKyqjs/nzoPA9+o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248106; c=relaxed/simple;
	bh=g7VYUx6Z/E9NkGZVSuWli/b+/GqP4ZN5sPYrBefu+io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YKA19+CIQPcHZs9z12wPJBEQXpB08uS5BBcLK2LFhlHafHuMxcks7Rv9wgPVpyvl1QwjmMz9qLN6q7o+5s1LpdIeM7jaKgLE8DBI7EkPfxuPup33dN26ybIqoVt0KynJJ+IBHwWh1LTeVxHWbQIQFElCohBGz2FLnOvUja4Kzds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xu9tCq5h; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248105; x=1783784105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g7VYUx6Z/E9NkGZVSuWli/b+/GqP4ZN5sPYrBefu+io=;
  b=Xu9tCq5hCdWzEe7V02NblWvoJb14LmG39FDOUFdQmI7cabqRxivGCF75
   O/2IKPwTJ1Zn38GH++yXYdQIYpajMeWBvY5j9HpGESJvCOizCkMrRjWRq
   z/QcZ9WeGo2dS7Y3P2vPRiLTIJy4n5zpmHz70okVAsX5qGhXXr3T2YpIl
   KryTaKHGFV48w/r8zQ2WRgtgS5ZT073/BXW/olawI8JnB9NoG4WMSE+4G
   7H0eZioIeZJriDEwHcnPN6812xIKlWG7GoybdpSmVmq9IU3TdaWlealGE
   QSY3Tk2pvy8VsTIwfqTdgbx2r33VbHFTTVRaRPd9T7BvKFHAsQCIvWreh
   g==;
X-CSE-ConnectionGUID: iPRf3BRnScuCPV6m08uXPw==
X-CSE-MsgGUID: /+iF4SXDSIqEZDwxEBWvLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54264170"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54264170"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:35:05 -0700
X-CSE-ConnectionGUID: dnpxnINLQ8655Fo/tK3Jeg==
X-CSE-MsgGUID: 9OMq9W+MQkmtaGc5PYYiug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156485169"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:35:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: mld: remove support for iwl_mcc_update_resp versions
Date: Fri, 11 Jul 2025 18:34:26 +0300
Message-Id: <20250711183056.9c64bfbb16cb.I109bee4d4bf455cbffbb8d2340023338bcab886d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
References: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwlmld was planned to be used for HR/GF, which has versions 5/6,
but it was decided at the end to use iwlmvm for HR/GF, so iwlmld only
needs to support version 8.
Remove versions 5 and 6 support.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c | 52 +-------------------
 1 file changed, 2 insertions(+), 50 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mcc.c b/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
index 680abda95adb..16bb1b4904f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
@@ -15,7 +15,7 @@
 
 /* It is the caller's responsibility to free the pointer returned here */
 static struct iwl_mcc_update_resp_v8 *
-iwl_mld_parse_mcc_update_resp_v8(const struct iwl_rx_packet *pkt)
+iwl_mld_copy_mcc_resp(const struct iwl_rx_packet *pkt)
 {
 	const struct iwl_mcc_update_resp_v8 *mcc_resp_v8 = (const void *)pkt->data;
 	int n_channels = __le32_to_cpu(mcc_resp_v8->n_channels);
@@ -32,43 +32,11 @@ iwl_mld_parse_mcc_update_resp_v8(const struct iwl_rx_packet *pkt)
 	return resp_cp;
 }
 
-/* It is the caller's responsibility to free the pointer returned here */
-static struct iwl_mcc_update_resp_v8 *
-iwl_mld_parse_mcc_update_resp_v5_v6(const struct iwl_rx_packet *pkt)
-{
-	const struct iwl_mcc_update_resp_v4 *mcc_resp_v4 = (const void *)pkt->data;
-	struct iwl_mcc_update_resp_v8 *resp_cp;
-	int n_channels = __le32_to_cpu(mcc_resp_v4->n_channels);
-	int resp_len;
-
-	if (iwl_rx_packet_payload_len(pkt) !=
-	    struct_size(mcc_resp_v4, channels, n_channels))
-		return ERR_PTR(-EINVAL);
-
-	resp_len = struct_size(resp_cp, channels, n_channels);
-	resp_cp = kzalloc(resp_len, GFP_KERNEL);
-	if (!resp_cp)
-		return ERR_PTR(-ENOMEM);
-
-	resp_cp->status = mcc_resp_v4->status;
-	resp_cp->mcc = mcc_resp_v4->mcc;
-	resp_cp->cap = cpu_to_le32(le16_to_cpu(mcc_resp_v4->cap));
-	resp_cp->source_id = mcc_resp_v4->source_id;
-	resp_cp->geo_info = mcc_resp_v4->geo_info;
-	resp_cp->n_channels = mcc_resp_v4->n_channels;
-	memcpy(resp_cp->channels, mcc_resp_v4->channels,
-	       n_channels * sizeof(__le32));
-
-	return resp_cp;
-}
-
 /* It is the caller's responsibility to free the pointer returned here */
 static struct iwl_mcc_update_resp_v8 *
 iwl_mld_update_mcc(struct iwl_mld *mld, const char *alpha2,
 		   enum iwl_mcc_source src_id)
 {
-	int resp_ver = iwl_fw_lookup_notif_ver(mld->fw, LONG_GROUP,
-					       MCC_UPDATE_CMD, 0);
 	struct iwl_mcc_update_cmd mcc_update_cmd = {
 		.mcc = cpu_to_le16(alpha2[0] << 8 | alpha2[1]),
 		.source_id = (u8)src_id,
@@ -93,23 +61,7 @@ iwl_mld_update_mcc(struct iwl_mld *mld, const char *alpha2,
 
 	pkt = cmd.resp_pkt;
 
-	/* For Wifi-7 radios, we get version 8
-	 * For Wifi-6E radios, we get version 6
-	 * For Wifi-6 radios, we get version 5, but 5, 6, and 4 are compatible.
-	 */
-	switch (resp_ver) {
-	case 5:
-	case 6:
-		resp_cp = iwl_mld_parse_mcc_update_resp_v5_v6(pkt);
-		break;
-	case 8:
-		resp_cp = iwl_mld_parse_mcc_update_resp_v8(pkt);
-		break;
-	default:
-		IWL_FW_CHECK_FAILED(mld, "Unknown MCC_UPDATE_CMD version %d\n", resp_ver);
-		resp_cp = ERR_PTR(-EINVAL);
-	}
-
+	resp_cp = iwl_mld_copy_mcc_resp(pkt);
 	if (IS_ERR(resp_cp))
 		goto exit;
 
-- 
2.34.1


