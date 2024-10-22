Return-Path: <linux-wireless+bounces-14292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A1F9A9ADA
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 09:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196B61F218AA
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 07:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AE514901B;
	Tue, 22 Oct 2024 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Uj+O/JwT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C41684A22
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581744; cv=none; b=bxJg7EW5+DVDAhQ36nnNatQ2VmAbWvUMk34GdjoNcAPYCfE6FCRGOoxhUvi3Ryoa1mm0dkOEEC6wCNRJdZas8gWypPuqcrFla8n7C1+Lw9hFaXUh/udI3EXBLlRkz3I2XS6FkUK5TLhWKtM7fdHLNXlr/osMr4qc/3kelcBtScQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581744; c=relaxed/simple;
	bh=VLE/UZSqxnBEMMJv1C0CrNd4y+h/544R3S2DgWANX1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKp+o3GvjMK6UMsthmtnSxle8LZWlP+jtg3EIJREkrxx+q4Ot9Ojhj95LVfaCZhYLPQ/j2wyS5jawkXlRCVZQE2TTtsxem2YDWpCRC4ikT+90oOrHPHUQQdBJwHAJAtzoidglZ/EQUeLrLkUCxoC0BLn0ExXrAGBwaBLq4pdxgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Uj+O/JwT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=qDQVgQ+dou8Qa1R8LFDv2lddmXu01YhnjL75jECS5KU=; t=1729581743; x=1730791343; 
	b=Uj+O/JwTzsy1100ezte91s6c4a+8lMQS4QWf5YCpW2O+Lia8ZKdvAFWTIdyegdz1LQTyL2lSh4a
	OvQW8BA7k7M6uHDVRJZ0fiTLBFtufapiyruC9gBzkIURJrRD3rg1/KV8p02GoCeeVt068tU7HhDYL
	TtT1ZREa+Vk6wS86jysj8sGL92kmPTF14SRyi1jm6LzV84BWRYybSg5sDu83uz9CBsF5xdEoAaRSM
	lGxBPRodWL5IBp+OA3RsFOFqKLvxx1l8Mynf4ZiIOW38kmSLhYoJblOqqZdrMbrUogD84N8oWjdGp
	xYZjgFN0yX0vM6g/UvGpHiqE44e7yIFPgLOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t39Da-00000001c1h-1RBc;
	Tue, 22 Oct 2024 09:22:14 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless] Revert "wifi: iwlwifi: remove retry loops in start"
Date: Tue, 22 Oct 2024 09:22:11 +0200
Message-ID: <20241022092212.4aa82a558a00.Ibdeff9c8f0d608bc97fc42024392ae763b6937b7@changeid>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Revert commit dfdfe4be183b ("wifi: iwlwifi: remove retry loops in
start"), it turns out that there's an issue with the PNVM load
notification from firmware not getting processed, that this patch
has been somewhat successfully papering over. Since this is being
reported, revert the loop removal for now.

We will later at least clean this up to only attempt to retry if
there was a timeout, but currently we don't even bubble up the
failure reason to the correct layer, only returning NULL.

Fixes: dfdfe4be183b ("wifi: iwlwifi: remove retry loops in start")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 34 ++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  |  3 ++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 10 +++++-
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 2abfc986701f..c620911a1193 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1413,26 +1413,36 @@ _iwl_op_mode_start(struct iwl_drv *drv, struct iwlwifi_opmode_table *op)
 	const struct iwl_op_mode_ops *ops = op->ops;
 	struct dentry *dbgfs_dir = NULL;
 	struct iwl_op_mode *op_mode = NULL;
+	int retry, max_retry = !!iwlwifi_mod_params.fw_restart * IWL_MAX_INIT_RETRY;
 
 	/* also protects start/stop from racing against each other */
 	lockdep_assert_held(&iwlwifi_opmode_table_mtx);
 
-#ifdef CONFIG_IWLWIFI_DEBUGFS
-	drv->dbgfs_op_mode = debugfs_create_dir(op->name,
-						drv->dbgfs_drv);
-	dbgfs_dir = drv->dbgfs_op_mode;
-#endif
-
-	op_mode = ops->start(drv->trans, drv->trans->cfg,
-			     &drv->fw, dbgfs_dir);
-	if (op_mode)
-		return op_mode;
+	for (retry = 0; retry <= max_retry; retry++) {
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-	debugfs_remove_recursive(drv->dbgfs_op_mode);
-	drv->dbgfs_op_mode = NULL;
+		drv->dbgfs_op_mode = debugfs_create_dir(op->name,
+							drv->dbgfs_drv);
+		dbgfs_dir = drv->dbgfs_op_mode;
 #endif
 
+		op_mode = ops->start(drv->trans, drv->trans->cfg,
+				     &drv->fw, dbgfs_dir);
+
+		if (op_mode)
+			return op_mode;
+
+		if (test_bit(STATUS_TRANS_DEAD, &drv->trans->status))
+			break;
+
+		IWL_ERR(drv, "retry init count %d\n", retry);
+
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+		debugfs_remove_recursive(drv->dbgfs_op_mode);
+		drv->dbgfs_op_mode = NULL;
+#endif
+	}
+
 	return NULL;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
index 1549ff429549..6a1d31892417 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
@@ -98,6 +98,9 @@ void iwl_drv_stop(struct iwl_drv *drv);
 #define VISIBLE_IF_IWLWIFI_KUNIT static
 #endif
 
+/* max retry for init flow */
+#define IWL_MAX_INIT_RETRY 2
+
 #define FW_NAME_PRE_BUFSIZE	64
 struct iwl_trans;
 const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a327893c6dce..812ef47a396f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1293,12 +1293,14 @@ int iwl_mvm_mac_start(struct ieee80211_hw *hw)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
+	int retry, max_retry = 0;
 
 	mutex_lock(&mvm->mutex);
 
 	/* we are starting the mac not in error flow, and restart is enabled */
 	if (!test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status) &&
 	    iwlwifi_mod_params.fw_restart) {
+		max_retry = IWL_MAX_INIT_RETRY;
 		/*
 		 * This will prevent mac80211 recovery flows to trigger during
 		 * init failures
@@ -1306,7 +1308,13 @@ int iwl_mvm_mac_start(struct ieee80211_hw *hw)
 		set_bit(IWL_MVM_STATUS_STARTING, &mvm->status);
 	}
 
-	ret = __iwl_mvm_mac_start(mvm);
+	for (retry = 0; retry <= max_retry; retry++) {
+		ret = __iwl_mvm_mac_start(mvm);
+		if (!ret)
+			break;
+
+		IWL_ERR(mvm, "mac start retry %d\n", retry);
+	}
 	clear_bit(IWL_MVM_STATUS_STARTING, &mvm->status);
 
 	mutex_unlock(&mvm->mutex);
-- 
2.47.0


