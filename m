Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AFB7CBEBC
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 11:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjJQJRN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 05:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjJQJRL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 05:17:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9278E
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534229; x=1729070229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zcgaChS2RJW0S41BN0yayNv3HBAdsyCdKoOWRSO2ARA=;
  b=Z7ZZIfWrsxtOpzkjMzCmkaI7tDi17YawgwZWTeIeus4kKLU0jd7b2i0Z
   ClfnJq6tL9/orXYfWdl55Dz4atTzSarNYSmpdMQuFck0xGiKRYfNRjVJE
   GgqpMd46Vi+qpzJsIfG6wYesVfFzzxUWOgbwGgbvSWcfolvrnzjEW0FVk
   u2X63IBKOHcVVr2RlFYyryY1Q7Izj9GRQcohfJEnyi/6QcFXcvhd8OmAE
   n5uJyh83dT5qxerzUPNH0396HfdWqk4o4fXx+66KBS+xrJNdWXByt9JEu
   B44egpYWuz1St8LQ/eAHj6StSraPLSpTX0NiBBgAdjxXpFAgAJD+kR4kx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="370808521"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="370808521"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759731825"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759731825"
Received: from obarinsh-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.213.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:07 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/14] wifi: iwlwifi: support link id in SESSION_PROTECTION_NOTIF
Date:   Tue, 17 Oct 2023 12:16:38 +0300
Message-Id: <20231017115047.4c59b149086e.I74fe93a6337f4ec9d1bd6f791d315411ac5b40da@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231017091649.65090-1-gregory.greenman@intel.com>
References: <20231017091649.65090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

FW is introducing an API change in which link ID will be used
for session protection notif. Add support for it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../intel/iwlwifi/fw/api/time-event.h         | 10 ++++---
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 27 +++++++++++++++++--
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
index 701b2929c3a4..2e15be71c957 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
@@ -461,7 +461,8 @@ struct iwl_mvm_session_prot_cmd {
 
 /**
  * struct iwl_mvm_session_prot_notif - session protection started / ended
- * @mac_id: the mac id for which the session protection started / ended
+ * @mac_link_id: the mac id (or link id, for notif ver > 2) for which the
+ *	session protection started / ended
  * @status: 1 means success, 0 means failure
  * @start: 1 means the session protection started, 0 means it ended
  * @conf_id: see &enum iwl_mvm_session_prot_conf_id
@@ -470,10 +471,13 @@ struct iwl_mvm_session_prot_cmd {
  * and end even the firmware could not schedule it.
  */
 struct iwl_mvm_session_prot_notif {
-	__le32 mac_id;
+	__le32 mac_link_id;
 	__le32 status;
 	__le32 start;
 	__le32 conf_id;
-} __packed; /* SESSION_PROTECTION_NOTIFICATION_API_S_VER_2 */
+} __packed;
+/* SESSION_PROTECTION_NOTIFICATION_API_S_VER_2 and
+ * SESSION_PROTECTION_NOTIFICATION_API_S_VER_3
+ */
 
 #endif /* __iwl_fw_api_time_event_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index ecbebef80791..218fdf1ed530 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -898,18 +898,41 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_mvm_session_prot_notif *notif = (void *)pkt->data;
+	unsigned int ver =
+		iwl_fw_lookup_cmd_ver(mvm->fw,
+				      WIDE_ID(MAC_CONF_GROUP,
+					      SESSION_PROTECTION_CMD), 2);
+	int id = le32_to_cpu(notif->mac_link_id);
 	struct ieee80211_vif *vif;
 	struct iwl_mvm_vif *mvmvif;
+	unsigned int notif_link_id;
 
 	rcu_read_lock();
-	vif = iwl_mvm_rcu_dereference_vif_id(mvm, le32_to_cpu(notif->mac_id),
-					     true);
+
+	if (ver <= 2) {
+		vif = iwl_mvm_rcu_dereference_vif_id(mvm, id, true);
+	} else {
+		struct ieee80211_bss_conf *link_conf =
+			iwl_mvm_rcu_fw_link_id_to_link_conf(mvm, id, true);
+
+		if (!link_conf)
+			goto out_unlock;
+
+		notif_link_id = link_conf->link_id;
+		vif = link_conf->vif;
+	}
 
 	if (!vif)
 		goto out_unlock;
 
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
+	if (WARN(ver > 2 && mvmvif->time_event_data.link_id >= 0 &&
+		 mvmvif->time_event_data.link_id != notif_link_id,
+		 "SESION_PROTECTION_NOTIF was received for link %u, while the current time event is on link %u\n",
+		 notif_link_id, mvmvif->time_event_data.link_id))
+		goto out_unlock;
+
 	/* The vif is not a P2P_DEVICE, maintain its time_event_data */
 	if (vif->type != NL80211_IFTYPE_P2P_DEVICE) {
 		struct iwl_mvm_time_event_data *te_data =
-- 
2.38.1

