Return-Path: <linux-wireless+bounces-11137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7F794C59D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 22:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297571F22876
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 20:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51659158DB1;
	Thu,  8 Aug 2024 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dbFZ9jsj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998D155A25
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 20:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148586; cv=none; b=THvE6YeeOqsMO2Ta1Af7nWFfPF4fh/Bli4Hyk+VrS1uorj5K6Ku7vga3xQeFlTHDEpjkkLB2q/N7PoY4sM42i8TahiA/FYlm9Qb2mxlRHdh4VZ8vFg/7ywHp3yUAfxs4d+4uHqcfPoXYhnIfvpPcmzVPZekoAdEgoEtvvoAorOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148586; c=relaxed/simple;
	bh=8LtJ2Yc+UKzDnGNMjIQcmLl6PDDATWxUwyAULVDgAeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iv5feTICsOehCB2z8MV51mEDjWaZ0Fq7HWjRR8fKSFb5dzwvM1LTOUMfO1skJdQB+ugCd2fk/CGhjYAkoreFNprQU/KBar9fR4b74fS9eGFChEJfYDEWrcPka/mWoeX1znAzLGvvv5bx7Q8MIZhp6D3P+T4o5saDmoFyb78Db6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dbFZ9jsj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723148585; x=1754684585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8LtJ2Yc+UKzDnGNMjIQcmLl6PDDATWxUwyAULVDgAeQ=;
  b=dbFZ9jsj1TEkCnVjYrRp++LXcdilMXCxlCVfpcl8iJQcAX52d7yLuUU2
   16NZi7WoxRJQGkEEcXDxdgwCtJMe6ziufG09JaK21/ZcX+Y65kYjAqew9
   7/ucgBlXVrFZ3mRdhqrKZveA/UD5YyVdlIN/O3P/PELQ8yjTrTDLW+2Nf
   JpLjzv1aKnSwnoWxHBqRENcUh3SBwnAGvmFM4IP1IGFz/2JdffwCAi2rj
   1YVo2J403NmpbzDjGbbY0SM8+bMPzNM7s6BLBlZ8NAA3BmfOf3bffizwH
   T+dHU2sPObtx/wJimXy4ew29Q4W+PhWjYZ/ps9GSxopMQ287nelTs4Ld8
   g==;
X-CSE-ConnectionGUID: JXPzUofYScOKd6jMTfRBMA==
X-CSE-MsgGUID: ZCGx6Q4dSB6/Yup/E1v7Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38808833"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="38808833"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:04 -0700
X-CSE-ConnectionGUID: d3BjZYVuSUq0neW4NLCWPw==
X-CSE-MsgGUID: eM8kUs8+STaF3RXrQ2sIxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57305283"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 02/13] wifi: iwlwifi: mvm: rename iwl_missed_beacons_notif
Date: Thu,  8 Aug 2024 23:22:38 +0300
Message-Id: <20240808232017.b5c3a83a05ef.I698611582b5ca8395f42a535c51f7230307e2c6f@changeid>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

A new version is coming up. Rename the current struct to include the
current version.

s/iwl_missed_beacons_notif/iwl_missed_beacons_notif_v4

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h      | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 377fac278511..852ea5d14051 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -401,7 +401,7 @@ enum iwl_legacy_cmds {
 	REDUCE_TX_POWER_CMD = 0x9f,
 
 	/**
-	 * @MISSED_BEACONS_NOTIFICATION: &struct iwl_missed_beacons_notif
+	 * @MISSED_BEACONS_NOTIFICATION: &struct iwl_missed_beacons_notif_v4
 	 */
 	MISSED_BEACONS_NOTIFICATION = 0xa2,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index bcbbf8c4a297..490215e71e5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -378,7 +378,7 @@ struct iwl_missed_beacons_notif_ver_3 {
 } __packed; /* MISSED_BEACON_NTFY_API_S_VER_3 */
 
 /**
- * struct iwl_missed_beacons_notif - information on missed beacons
+ * struct iwl_missed_beacons_notif_v4 - information on missed beacons
  * ( MISSED_BEACONS_NOTIFICATION = 0xa2 )
  * @link_id: fw link ID
  * @consec_missed_beacons_since_last_rx: number of consecutive missed
@@ -387,7 +387,7 @@ struct iwl_missed_beacons_notif_ver_3 {
  * @num_expected_beacons: number of expected beacons
  * @num_recvd_beacons: number of received beacons
  */
-struct iwl_missed_beacons_notif {
+struct iwl_missed_beacons_notif_v4 {
 	__le32 link_id;
 	__le32 consec_missed_beacons_since_last_rx;
 	__le32 consec_missed_beacons;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index dfcc96f18b4f..9209814b465c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1590,7 +1590,7 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 				     struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
-	struct iwl_missed_beacons_notif *mb = (void *)pkt->data;
+	struct iwl_missed_beacons_notif_v4 *mb = (void *)pkt->data;
 	struct iwl_fw_dbg_trigger_missed_bcon *bcon_trig;
 	struct iwl_fw_dbg_trigger_tlv *trigger;
 	u32 stop_trig_missed_bcon, stop_trig_missed_bcon_since_rx;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index be20c8e3a389..dd2631ff452d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -396,7 +396,7 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 
 	RX_HANDLER(MISSED_BEACONS_NOTIFICATION, iwl_mvm_rx_missed_beacons_notif,
 		   RX_HANDLER_ASYNC_LOCKED_WIPHY,
-		   struct iwl_missed_beacons_notif),
+		   struct iwl_missed_beacons_notif_v4),
 
 	RX_HANDLER(REPLY_ERROR, iwl_mvm_rx_fw_error, RX_HANDLER_SYNC,
 		   struct iwl_error_resp),
-- 
2.34.1


