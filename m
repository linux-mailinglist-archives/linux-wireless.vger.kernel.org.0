Return-Path: <linux-wireless+bounces-22263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829C4AA4C62
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A51716B205
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E928F25FA31;
	Wed, 30 Apr 2025 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6yM0Tc4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248F25DCEE
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017868; cv=none; b=OjttdKV0zSBInnOeEQAbNZ5DXOlT6hl2+YZCSsetVNmym9p/SijZpaDlXSlxnct5Am02emCO5bgjnrhxg3YH/Kmc7bswdDzAZDO4KLSFvPHlDXH6VnOAtzhCrpRG/IwIi5ACCpRzEwOHRUCEPxdzgZdZ5ak4PLcLzAIgPnsgEl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017868; c=relaxed/simple;
	bh=XswSLjD69x7YyUC4GhDaDCFfdNKGOisdI9YUK/vKO6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NdNX+vwrH+cOeOHsNxtKIfgpVDgFw6NGn6tmIIcxZcd7ijZB639r6H6AXKDPkwOLjQ5L9fbKp9UnQ+jjEvFH9BxID0X7a0Vw4BZEoECXdWhlk5XlC2S3rFsj3PBn1I16putJBPaT2ju0bsV9C1vvfxKPLjkbBzzh/JSIWjbiblI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6yM0Tc4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017867; x=1777553867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XswSLjD69x7YyUC4GhDaDCFfdNKGOisdI9YUK/vKO6w=;
  b=a6yM0Tc4fh78qh68t9rHtFfGiIlH6qtAYNTuLTaxUu3lUhE+Zs1TQrgK
   iosaNoZFHJv2RqW903G+7z8NUScNYv/kx+H1nrGGH85ZZmpsh3akE87cj
   DSwILAvnKPvgRJLPruCQlI0BiwQWjcX5BAmw6+hp3hu+NPLsFPkSerE+u
   vExn4N5HvMrjiE1Ty2YLMx7QQHCUT2+0cZVqMHU2IUXsnde2TqOdYB4Ax
   0Gm+S2HFMZrQ68FFK5GDi0uPUR7xIs7aK/oQAX3rfp8kl0/hp1J5MmOYZ
   btMOIDetfQSXga5ofPgEzQcKj3O3PiFeWVOQGJh3YrgMb2RXXwY4ZmoeU
   w==;
X-CSE-ConnectionGUID: 7eAi2CzTTymnM80e0XglHQ==
X-CSE-MsgGUID: 8DojD6I6RZmer912tr7X7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58332325"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="58332325"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:46 -0700
X-CSE-ConnectionGUID: 19IzsJkPS1SE5pBbqsVPnQ==
X-CSE-MsgGUID: x+0OXwBgRZGQRQ8srFXXlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134632085"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: add support for ALIVE v8
Date: Wed, 30 Apr 2025 15:57:16 +0300
Message-Id: <20250430155443.dc387ae36e0f.Iafd364c6b23749597b658015be97295ad0c1730d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
References: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware added a field to describe the platform Id.
Just print it.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/alive.h | 10 +++++++++
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   | 21 +++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 13 +++++++++++-
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
index 42360a8f23aa..3ce477c248ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
@@ -112,6 +112,16 @@ struct iwl_alive_ntf_v6 {
 	struct iwl_imr_alive_info imr;
 } __packed; /* UCODE_ALIVE_NTFY_API_S_VER_6 */
 
+struct iwl_alive_ntf {
+	__le16 status;
+	__le16 flags;
+	struct iwl_lmac_alive lmac_data[2];
+	struct iwl_umac_alive umac_data;
+	struct iwl_sku_id sku_id;
+	struct iwl_imr_alive_info imr;
+	__le64 platform_id;
+} __packed; /* UCODE_ALIVE_NTFY_API_S_VER_8 */
+
 /**
  * enum iwl_extended_cfg_flags - commands driver may send before
  *	finishing init flow
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index 238e8ad8ba82..268ff7eceb47 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -103,12 +103,13 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 			 struct iwl_rx_packet *pkt, void *data)
 {
 	unsigned int pkt_len = iwl_rx_packet_payload_len(pkt);
+	unsigned int expected_sz;
 	struct iwl_mld *mld =
 		container_of(notif_wait, struct iwl_mld, notif_wait);
 	struct iwl_trans *trans = mld->trans;
 	u32 version = iwl_fw_lookup_notif_ver(mld->fw, LEGACY_GROUP,
 					      UCODE_ALIVE_NTFY, 0);
-	struct iwl_alive_ntf_v6 *palive;
+	struct iwl_alive_ntf *palive;
 	bool *alive_valid = data;
 	struct iwl_umac_alive *umac;
 	struct iwl_lmac_alive *lmac1;
@@ -117,7 +118,19 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	u32 umac_error_table;
 	u16 status;
 
-	if (version < 6 || version > 7 || pkt_len != sizeof(*palive))
+	switch (version) {
+	case 6:
+	case 7:
+		expected_sz = sizeof(struct iwl_alive_ntf_v6);
+		break;
+	case 8:
+		expected_sz = sizeof(struct iwl_alive_ntf);
+		break;
+	default:
+		return false;
+	}
+
+	if (pkt_len != expected_sz)
 		return false;
 
 	palive = (void *)pkt->data;
@@ -171,6 +184,10 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 		IWL_DEBUG_FW(mld, "FW alive flags 0x%x\n",
 			     le16_to_cpu(palive->flags));
 
+	if (version >= 8)
+		IWL_DEBUG_FW(mld, "platform_id 0x%llx\n",
+			     le64_to_cpu(palive->platform_id));
+
 	iwl_fwrt_update_fw_versions(&mld->fwrt, lmac1, umac);
 
 	return true;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 5bdd35b433e8..d955f7c4ab8a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -114,7 +114,7 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	u32 i;
 
 
-	if (version == 6) {
+	if (version >= 6) {
 		struct iwl_alive_ntf_v6 *palive;
 
 		if (pkt_len < sizeof(*palive))
@@ -157,6 +157,17 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 				}
 			}
 		}
+
+		if (version >= 8) {
+			const struct iwl_alive_ntf *palive_v8 =
+				(void *)pkt->data;
+
+			if (pkt_len < sizeof(*palive_v8))
+				return false;
+
+			IWL_DEBUG_FW(mvm, "platform id: 0x%llx\n",
+				     palive_v8->platform_id);
+		}
 	}
 
 	if (version >= 5) {
-- 
2.34.1


