Return-Path: <linux-wireless+bounces-25288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D61B0208D
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 17:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E56A602FB
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD0A2ED176;
	Fri, 11 Jul 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XasUplgg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7C82EE27E
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248107; cv=none; b=Q9o2LEH9VZHWZvkhl9on0yukukrAtX95V77dgNxFap8JHVkvW5KnST1PsZcEhIQMiywNC5+cU1meXHBxTtlaEWze6kXATfUSTEfc0M0XL1MSyHpi3Kr09HYUjtckK5UIG77exJcAT3mIBlHezCtQ9+aQ+So730f4zN3oT/kzbS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248107; c=relaxed/simple;
	bh=xTET5F5nB5qYwHmKYMjT234uR/gzmxrK3LBgDgHdu6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m0i3k2Pwvmogy4eZ6ubYn6DJ9dxHopCVxLxKMZLlMOR9CGjxs3QblDybCwVO7ikkWf3j4qLrjKjRRG1CZqp/gcH4Pquu2xTyiljTvEuALSJlFx2QkwLCw4ljil4s20F+/VIHuGmmOiu1Z8hy/IxjK3+Na5zdLSQ7JSPREEBak6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XasUplgg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248106; x=1783784106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xTET5F5nB5qYwHmKYMjT234uR/gzmxrK3LBgDgHdu6w=;
  b=XasUplgghowiz5CinKIKTelCizFxqb5kQEZgWJmtNRa9bSknamo0TkXe
   S29igYM7OG730I7o/3sNAb0739oY/H4Prhc0nhdkgFQ6SqyNXWEGYvXhv
   Z9MvkdvkEOt/A/KmgaZzVRJsSqSoBKK2mF4L7OZvN2pm8oWkbAHZLWZ+O
   904GXwd48PI78ymmD2zGssZfMc6WScqPxRKLFmCJcs6L5gLEIqdwJYeXo
   Ay5ozUQT20zSBarlWOEMgC7IfaHAhLDxuMER++X0JmjVR23+nhYuZtNNB
   qSD6pvr3MsYwcSI7CFGQt+Xk1eAbsxqImfYlUS0p6h1UfHcANEZjv35PP
   Q==;
X-CSE-ConnectionGUID: 3hlFazLaTW2sYnNi9AXItQ==
X-CSE-MsgGUID: FEaZqzGNTbG4ks6bI2AD+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54264172"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54264172"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:35:06 -0700
X-CSE-ConnectionGUID: NxkSxRq2QLurtivOB2XaFQ==
X-CSE-MsgGUID: e2wsr8PJRS2vnOwrgN3rPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156485177"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:35:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: remove support of versions 4 and 5 of iwl_alive_ntf
Date: Fri, 11 Jul 2025 18:34:27 +0300
Message-Id: <20250711183056.dd784443be53.I4ff3b2392294f5df2625a71e2deee3364e9708f6@changeid>
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

These are not used in any of our devices. Remove them.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/alive.h | 15 ------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 50 ++++++-------------
 2 files changed, 16 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
index 3ce477c248ce..ad5b95cad0bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
@@ -82,21 +82,6 @@ struct iwl_alive_ntf_v3 {
 	struct iwl_umac_alive umac_data;
 } __packed; /* UCODE_ALIVE_NTFY_API_S_VER_3 */
 
-struct iwl_alive_ntf_v4 {
-	__le16 status;
-	__le16 flags;
-	struct iwl_lmac_alive lmac_data[2];
-	struct iwl_umac_alive umac_data;
-} __packed; /* UCODE_ALIVE_NTFY_API_S_VER_4 */
-
-struct iwl_alive_ntf_v5 {
-	__le16 status;
-	__le16 flags;
-	struct iwl_lmac_alive lmac_data[2];
-	struct iwl_umac_alive umac_data;
-	struct iwl_sku_id sku_id;
-} __packed; /* UCODE_ALIVE_NTFY_API_S_VER_5 */
-
 struct iwl_imr_alive_info {
 	__le64 base_addr;
 	__le32 size;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 749fb8441190..d931c6eaf12f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -121,6 +121,22 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 			return false;
 
 		palive = (void *)pkt->data;
+
+		umac = &palive->umac_data;
+		lmac1 = &palive->lmac_data[0];
+		lmac2 = &palive->lmac_data[1];
+		status = le16_to_cpu(palive->status);
+
+		BUILD_BUG_ON(sizeof(palive->sku_id.data) !=
+			     sizeof(alive_data->sku_id));
+		memcpy(alive_data->sku_id, palive->sku_id.data,
+		       sizeof(palive->sku_id.data));
+
+		IWL_DEBUG_FW(mvm, "Got sku_id: 0x0%x 0x0%x 0x0%x\n",
+			     le32_to_cpu(alive_data->sku_id[0]),
+			     le32_to_cpu(alive_data->sku_id[1]),
+			     le32_to_cpu(alive_data->sku_id[2]));
+
 		mvm->trans->dbg.imr_data.imr_enable =
 			le32_to_cpu(palive->imr.enabled);
 		mvm->trans->dbg.imr_data.imr_size =
@@ -168,40 +184,6 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 			IWL_DEBUG_FW(mvm, "platform id: 0x%llx\n",
 				     palive_v8->platform_id);
 		}
-	}
-
-	if (version >= 5) {
-		struct iwl_alive_ntf_v5 *palive;
-
-		if (pkt_len < sizeof(*palive))
-			return false;
-
-		palive = (void *)pkt->data;
-		umac = &palive->umac_data;
-		lmac1 = &palive->lmac_data[0];
-		lmac2 = &palive->lmac_data[1];
-		status = le16_to_cpu(palive->status);
-
-		BUILD_BUG_ON(sizeof(palive->sku_id.data) !=
-			     sizeof(alive_data->sku_id));
-		memcpy(alive_data->sku_id, palive->sku_id.data,
-		       sizeof(palive->sku_id.data));
-
-		IWL_DEBUG_FW(mvm, "Got sku_id: 0x0%x 0x0%x 0x0%x\n",
-			     le32_to_cpu(alive_data->sku_id[0]),
-			     le32_to_cpu(alive_data->sku_id[1]),
-			     le32_to_cpu(alive_data->sku_id[2]));
-	} else if (iwl_rx_packet_payload_len(pkt) == sizeof(struct iwl_alive_ntf_v4)) {
-		struct iwl_alive_ntf_v4 *palive;
-
-		if (pkt_len < sizeof(*palive))
-			return false;
-
-		palive = (void *)pkt->data;
-		umac = &palive->umac_data;
-		lmac1 = &palive->lmac_data[0];
-		lmac2 = &palive->lmac_data[1];
-		status = le16_to_cpu(palive->status);
 	} else if (iwl_rx_packet_payload_len(pkt) ==
 		   sizeof(struct iwl_alive_ntf_v3)) {
 		struct iwl_alive_ntf_v3 *palive3;
-- 
2.34.1


