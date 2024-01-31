Return-Path: <linux-wireless+bounces-2898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A16D844904
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 21:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20B0B22C0C
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 20:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F78C1BC49;
	Wed, 31 Jan 2024 20:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Le3n4Qa0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351F2171D0
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706733512; cv=none; b=MicpAM99T+F4FwKtr729+IvTAPbk/DWPAiG4pszVtgrPJak4koXdrkB8k8s9XyXIkMYDw50zR+jVzofeMZZjOpOmn1lGfEO/UICilUYjUxR7LuGWKAS5JjWTK6Us+/oSR5ZaZBP2sHn9By97tYLmpuWRJJQ5wU7tGDxAU4+mfdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706733512; c=relaxed/simple;
	bh=zUDB4sW807EzPj4xy0mafrKjN+UBSozTDuddN3UWPXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LIJxaquaa9GeWIZgF9QAMP+IZXuYxD7m+YQWKsFfW1NX8VGaE4mBt8dYNQZ/A/YS8BSvSopfFQ3gNUypPRON5banLknXaWyGm2BC8KAnLHq+s1fLl7x/QQzUqZny1KBVHR8+NP3WuiieRUokksymlzFdtGMq/XnQW662+PfZO78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Le3n4Qa0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=gLW2psmQ360X6ORQyxvFglWI8MTkcZZB2De7gOu4SqY=; t=1706733508; x=1707943108; 
	b=Le3n4Qa0IRYhXFN7gVMhmhAs+e+bPfBrseVTk91v9vU34SRoA+TgQP4bBUA/TsPImmHc+4pHlHM
	LJI+vJluCTdHDHEyeleUSoAfNbtrxha52IszepmRIyrsz/y9lujK/8DmbSJpb0tYfDdtOtWO3n5so
	BXcQh5AHtr/X0EsVR+EpnZWIt9zrmYRu8GulPmU+MjlA8wm7EgndspE15RrulYSoo6jfjy5msuZwc
	PALgYXuqQV2jth3TR90DThaalNBLBJ4Ovb34yxOiA3fgbJ0E2gZaaHLI98Cy1wwBMK3xPgc+Hl8Ax
	LsS70r6dvPIDmGbf+i5LWx+ufoyezVr4fF7Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rVHLk-00000007Q82-2nK3;
	Wed, 31 Jan 2024 21:38:24 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] iwlwifi: fw: fix more kernel-doc warnings
Date: Wed, 31 Jan 2024 21:38:16 +0100
Message-ID: <20240131213817.9f30c6529216.I69e98612c6c81cf1b7bd480d8041b5d3e25610d3@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Fix some more kernel-doc warnings in FW API definitions.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h       | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h    | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h | 1 +
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h       | 4 ++++
 5 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index ea99d41040d2..d2a74beed3a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -324,7 +324,7 @@ struct iwl_wowlan_patterns_cmd {
 	u8 n_patterns;
 
 	/**
-	 * @n_patterns: sta_id
+	 * @sta_id: sta_id
 	 */
 	u8 sta_id;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 751b596ea1a5..0f7903c5a4df 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -101,7 +101,7 @@ enum iwl_data_path_subcmd_ids {
 	RX_NO_DATA_NOTIF = 0xF5,
 
 	/**
-	 * @THERMAL_DUAL_CHAIN_DISABLE_REQ: firmware request for SMPS mode,
+	 * @THERMAL_DUAL_CHAIN_REQUEST: firmware request for SMPS mode,
 	 *	&struct iwl_thermal_dual_chain_request
 	 */
 	THERMAL_DUAL_CHAIN_REQUEST = 0xF6,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index 798731ecbefd..a4b54488e0fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -394,7 +394,7 @@ struct iwl_buf_alloc_cmd {
  *
  * @first_word: magic word value
  * @second_word: magic word value
- * @framfrags: DRAM fragmentaion detail
+ * @dram_frags: DRAM fragmentaion detail
 */
 struct iwl_dram_info {
 	__le32 first_word;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index b044990c7b87..25530a29317e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -630,6 +630,7 @@ enum iwl_location_frame_format {
  * @IWL_LOCATION_BW_20MHZ: 20MHz
  * @IWL_LOCATION_BW_40MHZ: 40MHz
  * @IWL_LOCATION_BW_80MHZ: 80MHz
+ * @IWL_LOCATION_BW_160MHZ: 160MHz
  */
 enum iwl_location_bw {
 	IWL_LOCATION_BW_20MHZ,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 842360b1e995..d9e4c75403b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -76,6 +76,8 @@ enum iwl_tx_flags {
  *	to a secured STA
  * @IWL_TX_FLAGS_HIGH_PRI: high priority frame (like EAPOL) - can affect rate
  *	selection, retry limits and BT kill
+ * @IWL_TX_FLAGS_RTS: firmware used an RTS
+ * @IWL_TX_FLAGS_CTS: firmware used CTS-to-self
  */
 enum iwl_tx_cmd_flags {
 	IWL_TX_FLAGS_CMD_RATE		= BIT(0),
@@ -884,6 +886,7 @@ struct iwl_tx_path_flush_cmd {
 
 /**
  * struct iwl_flush_queue_info - virtual flush queue info
+ * @tid: the tid to flush
  * @queue_num: virtual queue id
  * @read_before_flush: read pointer before flush
  * @read_after_flush: read pointer after flush
@@ -897,6 +900,7 @@ struct iwl_flush_queue_info {
 
 /**
  * struct iwl_tx_path_flush_cmd_rsp -- queue/FIFO flush command response
+ * @sta_id: the station for which the queue was flushed
  * @num_flushed_queues: number of queues in queues array
  * @queues: all flushed queues
  */
-- 
2.43.0


