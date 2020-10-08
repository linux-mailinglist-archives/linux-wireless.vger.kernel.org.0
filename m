Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D732876DC
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbgJHPM6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:12:58 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54572 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730899AbgJHPM5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:12:57 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXbD-002QxQ-2C; Thu, 08 Oct 2020 18:12:55 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:12:40 +0300
Message-Id: <iwlwifi.20201008181047.2574e3e47927.Ic0c56411da1096e9a45ee5c3383edf777c5baca0@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008151250.332346-1-luca@coelho.fi>
References: <20201008151250.332346-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/13] iwlwifi: mvm: don't send a CSA command the firmware doesn't know
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We introduced a new flow to remove an on-going CSA but we
assumed the firwmare understands the
CHANNEL_SWITCH_TIME_EVENT_CMD. This is not true for 7265 and down.

Don't send this command for those devices, but rather use the older
command.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 12 ++++++----
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 22 +++++++++++++++++++
 .../wireless/intel/iwlwifi/mvm/time-event.h   |  7 ++++--
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 27b2a68c97f6..688c1125e67b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1409,10 +1409,14 @@ static void iwl_mvm_abort_channel_switch(struct ieee80211_hw *hw,
 	IWL_DEBUG_MAC80211(mvm, "Abort CSA on mac %d\n", mvmvif->id);
 
 	mutex_lock(&mvm->mutex);
-	WARN_ON(iwl_mvm_send_cmd_pdu(mvm,
-				     WIDE_ID(MAC_CONF_GROUP,
-					     CHANNEL_SWITCH_TIME_EVENT_CMD),
-				     0, sizeof(cmd), &cmd));
+	if (!fw_has_capa(&mvm->fw->ucode_capa,
+			 IWL_UCODE_TLV_CAPA_CHANNEL_SWITCH_CMD))
+		iwl_mvm_remove_csa_period(mvm, vif);
+	else
+		WARN_ON(iwl_mvm_send_cmd_pdu(mvm,
+					     WIDE_ID(MAC_CONF_GROUP,
+						     CHANNEL_SWITCH_TIME_EVENT_CMD),
+					     0, sizeof(cmd), &cmd));
 	mutex_unlock(&mvm->mutex);
 
 	WARN_ON(iwl_mvm_post_channel_switch(hw, vif));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 7ad6c9ab4737..7fce79c1c114 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -1016,6 +1016,28 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	iwl_mvm_roc_finished(mvm);
 }
 
+void iwl_mvm_remove_csa_period(struct iwl_mvm *mvm,
+			       struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_time_event_data *te_data = &mvmvif->time_event_data;
+	u32 id;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (!te_data->running)
+		return;
+
+	spin_lock_bh(&mvm->time_event_lock);
+	id = te_data->id;
+	spin_unlock_bh(&mvm->time_event_lock);
+
+	if (id != TE_CHANNEL_SWITCH_PERIOD)
+		return;
+
+	iwl_mvm_remove_time_event(mvm, mvmvif, te_data);
+}
+
 int iwl_mvm_schedule_csa_period(struct iwl_mvm *mvm,
 				struct ieee80211_vif *vif,
 				u32 duration, u32 apply_time)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
index 3186d7e40567..b6bac776f236 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
@@ -7,7 +7,7 @@
  *
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -29,7 +29,7 @@
  *
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -216,6 +216,9 @@ void iwl_mvm_te_clear_data(struct iwl_mvm *mvm,
 void iwl_mvm_cleanup_roc_te(struct iwl_mvm *mvm);
 void iwl_mvm_roc_done_wk(struct work_struct *wk);
 
+void iwl_mvm_remove_csa_period(struct iwl_mvm *mvm,
+			       struct ieee80211_vif *vif);
+
 /**
  * iwl_mvm_schedule_csa_period - request channel switch absence period
  * @mvm: the mvm component
-- 
2.28.0

