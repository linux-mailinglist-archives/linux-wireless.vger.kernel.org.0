Return-Path: <linux-wireless+bounces-17717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF279A163AE
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 20:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086F7164274
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 19:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7641DF97E;
	Sun, 19 Jan 2025 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="norTjpbl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E534E1422AB
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737313414; cv=none; b=ddJgQarnYpdEdgV6Km78R2h8rx74VSWQV7h2gVpWt2mcRlm4Yq5IxhS2bij4jKQxTJikGttV1R5B6+LQ/bNxH0VCslSsL4nkcg89ZAgfnsVr0RSS4sT+305IVkBUKsWvYw7YL28YVeFBe0hVvh7l4wi5maXbhpWy+yB5eJaT9ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737313414; c=relaxed/simple;
	bh=rbVedwRGM54bb1JRCmawc3EpgPe91MvB2+wriw/a4wI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q8RGB8DalSCuwKq/6x2bfUhQGpsSIOpGBpfjrXMePtzAq1s7hNfvaOR0QHPo2uqD5NSQGsLA8zp85vQiyuajbAl+8Yd1WeplJl5oEJkJJcIbbyoqA8y9JnJ8fFTmi3uSHJpiSMh4A1WaXcCWo1GApxvfCikwpgV0JsrX7MYOoiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=norTjpbl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737313413; x=1768849413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rbVedwRGM54bb1JRCmawc3EpgPe91MvB2+wriw/a4wI=;
  b=norTjpblicTf9Mm/ksdP+dApjaBMr32ek8UDV/FnBWDjwS/arVaYO9HR
   AXWW3SA+7cotW+o09IG4QpvQpFrq5SdOE1fdHM7C12O2HaOEa7KYNYcNe
   vnK6j24tZB/13zaHYGqlETn9F5Wq+RZMX5U1RqUpPQvwrHnwqlJV6FDWU
   lS72fr/qf1EQLhmrXnTxC0bj496369Mo+7bAZxOGGx1MTWEVIyTZ1YJoh
   LDJqSrfL6oSrgbgtHsY8QSigir4J47VMoTTP8vcTVONOFvwS3+8+76hxD
   6WCzHAjDxxCCwSHKcztIemNgBC68rX+dUddu+uTpGi+6rArtuw14Kinwp
   g==;
X-CSE-ConnectionGUID: ovoKsztWSDK6fRfB7Psv/w==
X-CSE-MsgGUID: woxTtJG9QGmT3eN7tzIGGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="37556135"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="37556135"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 11:03:32 -0800
X-CSE-ConnectionGUID: x/hp1L1tQwiHdhqMTsf6CQ==
X-CSE-MsgGUID: DlpjeUj4TImWIjLGhDxXQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="106127755"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 11:03:30 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2] wifi: iwlwifi: remove the version number from iwl_dts_measurement_notif_v2
Date: Sun, 19 Jan 2025 21:03:14 +0200
Message-Id: <20250119210104.9d218a5c4f6b.I9de3e424be48d66994cde3684ce7e9e99456067d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250119210104.04f3afcf9c77.Ic2b6f265d0b4aea25ccc7114d6f48afa621871be@changeid>
References: <20250119210104.04f3afcf9c77.Ic2b6f265d0b4aea25ccc7114d6f48afa621871be@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

No need to carry the version number in the structure name if this is the
latest version available.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: rephrased the commit message

 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h      | 6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c          | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 34a1f97653c0..4b450c722a9c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -502,7 +502,7 @@ enum iwl_legacy_cmds {
 	/**
 	 * @DTS_MEASUREMENT_NOTIFICATION:
 	 * &struct iwl_dts_measurement_notif_v1 or
-	 * &struct iwl_dts_measurement_notif_v2
+	 * &struct iwl_dts_measurement_notif
 	 */
 	DTS_MEASUREMENT_NOTIFICATION = 0xdd,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
index 1dce28f3afa0..eb8961b51cb0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
@@ -55,7 +55,7 @@ enum iwl_phy_ops_subcmd_ids {
 	/**
 	 * @DTS_MEASUREMENT_NOTIF_WIDE:
 	 * &struct iwl_dts_measurement_notif_v1 or
-	 * &struct iwl_dts_measurement_notif_v2
+	 * &struct iwl_dts_measurement_notif
 	 */
 	DTS_MEASUREMENT_NOTIF_WIDE = 0xFF,
 };
@@ -152,13 +152,13 @@ struct iwl_dts_measurement_notif_v1 {
 } __packed; /* TEMPERATURE_MEASUREMENT_TRIGGER_NTFY_S_VER_1*/
 
 /**
- * struct iwl_dts_measurement_notif_v2 - measurements notification
+ * struct iwl_dts_measurement_notif - measurements notification
  *
  * @temp: the measured temperature
  * @voltage: the measured voltage
  * @threshold_idx: the trip index that was crossed
  */
-struct iwl_dts_measurement_notif_v2 {
+struct iwl_dts_measurement_notif {
 	__le32 temp;
 	__le32 voltage;
 	__le32 threshold_idx;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 256f8f558b15..c851290e75a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -105,7 +105,7 @@ static bool iwl_mvm_temp_notif_wait(struct iwl_notif_wait_data *notif_wait,
 void iwl_mvm_temp_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
-	struct iwl_dts_measurement_notif_v2 *notif_v2;
+	struct iwl_dts_measurement_notif *notif_v2;
 	int len = iwl_rx_packet_payload_len(pkt);
 	int temp;
 	u32 ths_crossed;
-- 
2.34.1


