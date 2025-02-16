Return-Path: <linux-wireless+bounces-18995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16265A3738C
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22E717A2B41
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8129118DB39;
	Sun, 16 Feb 2025 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUky3SR5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A831918DB38
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699052; cv=none; b=a7gGALPdDJRq/ngMfmBITdGDRoZ7JH0Rzn4NUR0MC1PsWwqHJmc3os0rcTaGcfSfbtzDP2MJKZtEZtavFAdujwTI/DlaET9YYq2ysmDkvM8WvJwe2gJtTnjDX3phgENknLPACdkXQyNlAHY3poKrY5AJWFzv0FSoWiGE2hLCXcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699052; c=relaxed/simple;
	bh=mIsAK3eYsTaEJCsbV+T0LEZok5mfzfmCT1eFRjTtOTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S5tDwEiytaDiFOgL9K+2SibGYuLD3RWLSGb3nyDbFv5gI3nY4IBv/o+tdED9jVi8FFJ4tG0ujCpbcXWxzT6s0iXsGMGydhdGXpTov8u9e7EpZ+74NSuQcprYBIn09Pnp4DipPQeu0fI935U9bGuSVZJE04M1jCxVw+9V+pQ6YdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUky3SR5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699051; x=1771235051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mIsAK3eYsTaEJCsbV+T0LEZok5mfzfmCT1eFRjTtOTY=;
  b=BUky3SR5bzRftFGXqNGyhDBoE5ajZyIQqu+z0e/Ll/0wPqIGZHgPmSkX
   Gy/SwFMemZdyE///OIGtc/jnORm1bmw4QA/N9ZWAsC2jMT+MUi/yGn1on
   4AnjeVNP96k5ryO/bAxtrTPX2BQt6l7ihUJqlfYI/YXaoi+k9nHfq9I82
   ljdOEg1XNYjiEq5GSazp3qq58GqYh6Fz91b3ksdvmDuacPPLFV5A4s6k3
   O9MmXnFl86dc5xv+MmRlAczu/b2A+LPEvg3YjiiokdW3or5RFUjfJmK8u
   qOUVrlRtl/bOdsQZucoWhxmbkSmanimvlhPykmpfztxXsFog676yL+DRN
   Q==;
X-CSE-ConnectionGUID: 8/NfGBrERLuBSM7T4PGR4w==
X-CSE-MsgGUID: JmcBpvYKRv6ySHBNtzCakA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323410"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323410"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:10 -0800
X-CSE-ConnectionGUID: CQFMTh5gTqS8oi7R853HdQ==
X-CSE-MsgGUID: pU4noVPjQbKMnbhiwzbbjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785260"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:09 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 27/42] wifi: iwlwifi: mld: add file session-protect.h/c
Date: Sun, 16 Feb 2025 11:43:06 +0200
Message-Id: <20250216111648.c7574fc440fc.I36df1878d73a84719d8fb42b0e96f40edb80cfbf@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
References: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

this file is handling a link object

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../intel/iwlwifi/mld/session-protect.c       | 222 ++++++++++++++++++
 .../intel/iwlwifi/mld/session-protect.h       | 102 ++++++++
 2 files changed, 324 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/session-protect.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/session-protect.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/session-protect.c b/drivers/net/wireless/intel/iwlwifi/mld/session-protect.c
new file mode 100644
index 000000000000..63e339091fcb
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/session-protect.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#include "session-protect.h"
+#include "fw/api/time-event.h"
+#include "fw/api/context.h"
+#include "iface.h"
+#include <net/mac80211.h>
+
+void iwl_mld_handle_session_prot_notif(struct iwl_mld *mld,
+				       struct iwl_rx_packet *pkt)
+{
+	struct iwl_session_prot_notif *notif = (void *)pkt->data;
+	int fw_link_id = le32_to_cpu(notif->mac_link_id);
+	struct ieee80211_bss_conf *link_conf =
+		iwl_mld_fw_id_to_link_conf(mld, fw_link_id);
+	struct ieee80211_vif *vif;
+	struct iwl_mld_vif *mld_vif;
+	struct iwl_mld_session_protect *session_protect;
+
+	if (WARN_ON(!link_conf))
+		return;
+
+	vif = link_conf->vif;
+	mld_vif = iwl_mld_vif_from_mac80211(vif);
+	session_protect = &mld_vif->session_protect;
+
+	if (!le32_to_cpu(notif->status)) {
+		memset(session_protect, 0, sizeof(*session_protect));
+	} else if (le32_to_cpu(notif->start)) {
+		/* End_jiffies indicates an active session */
+		session_protect->session_requested = false;
+		session_protect->end_jiffies =
+			TU_TO_EXP_TIME(session_protect->duration);
+		/* !session_protect->end_jiffies means inactive session */
+		if (!session_protect->end_jiffies)
+			session_protect->end_jiffies = 1;
+	} else {
+		memset(session_protect, 0, sizeof(*session_protect));
+	}
+}
+
+static int _iwl_mld_schedule_session_protection(struct iwl_mld *mld,
+						struct ieee80211_vif *vif,
+						u32 duration, u32 min_duration,
+						int link_id)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld_link *link =
+		iwl_mld_link_dereference_check(mld_vif, link_id);
+	struct iwl_mld_session_protect *session_protect =
+		&mld_vif->session_protect;
+	struct iwl_session_prot_cmd cmd = {
+		.id_and_color = cpu_to_le32(link->fw_id),
+		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
+		.conf_id = cpu_to_le32(SESSION_PROTECT_CONF_ASSOC),
+		.duration_tu = cpu_to_le32(MSEC_TO_TU(duration)),
+	};
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	WARN(hweight16(vif->active_links) > 1,
+	     "Session protection isn't allowed with more than one active link");
+
+	if (session_protect->end_jiffies &&
+	    time_after(session_protect->end_jiffies,
+		       TU_TO_EXP_TIME(min_duration))) {
+		IWL_DEBUG_TE(mld, "We have ample in the current session: %u\n",
+			     jiffies_to_msecs(session_protect->end_jiffies -
+					      jiffies));
+		return -EALREADY;
+	}
+
+	IWL_DEBUG_TE(mld, "Add a new session protection, duration %d TU\n",
+		     le32_to_cpu(cmd.duration_tu));
+
+	ret = iwl_mld_send_cmd_pdu(mld, WIDE_ID(MAC_CONF_GROUP,
+						SESSION_PROTECTION_CMD), &cmd);
+
+	if (ret)
+		return ret;
+
+	/* end_jiffies will be updated when handling session_prot_notif */
+	session_protect->end_jiffies = 0;
+	session_protect->duration = duration;
+	session_protect->session_requested = true;
+
+	return 0;
+}
+
+void iwl_mld_schedule_session_protection(struct iwl_mld *mld,
+					 struct ieee80211_vif *vif,
+					 u32 duration, u32 min_duration,
+					 int link_id)
+{
+	int ret;
+
+	ret = _iwl_mld_schedule_session_protection(mld, vif, duration,
+						   min_duration, link_id);
+	if (ret && ret != -EALREADY)
+		IWL_ERR(mld,
+			"Couldn't send the SESSION_PROTECTION_CMD (%d)\n",
+			ret);
+}
+
+struct iwl_mld_session_start_data {
+	struct iwl_mld *mld;
+	struct ieee80211_bss_conf *link_conf;
+	bool success;
+};
+
+static bool iwl_mld_session_start_fn(struct iwl_notif_wait_data *notif_wait,
+				     struct iwl_rx_packet *pkt, void *_data)
+{
+	struct iwl_session_prot_notif *notif = (void *)pkt->data;
+	unsigned int pkt_len = iwl_rx_packet_payload_len(pkt);
+	struct iwl_mld_session_start_data *data = _data;
+	struct ieee80211_bss_conf *link_conf;
+	struct iwl_mld *mld = data->mld;
+	int fw_link_id;
+
+	if (IWL_FW_CHECK(mld, pkt_len < sizeof(*notif),
+			 "short session prot notif (%d)\n",
+			 pkt_len))
+		return false;
+
+	fw_link_id = le32_to_cpu(notif->mac_link_id);
+	link_conf = iwl_mld_fw_id_to_link_conf(mld, fw_link_id);
+
+	if (link_conf != data->link_conf)
+		return false;
+
+	if (!le32_to_cpu(notif->status))
+		return true;
+
+	if (notif->start) {
+		data->success = true;
+		return true;
+	}
+
+	return false;
+}
+
+int iwl_mld_start_session_protection(struct iwl_mld *mld,
+				     struct ieee80211_vif *vif,
+				     u32 duration, u32 min_duration,
+				     int link_id, unsigned long timeout)
+{
+	static const u16 start_notif[] = { SESSION_PROTECTION_NOTIF };
+	struct iwl_notification_wait start_wait;
+	struct iwl_mld_session_start_data data = {
+		.mld = mld,
+		.link_conf = wiphy_dereference(mld->wiphy,
+					       vif->link_conf[link_id]),
+	};
+	int ret;
+
+	if (WARN_ON(!data.link_conf))
+		return -EINVAL;
+
+	iwl_init_notification_wait(&mld->notif_wait, &start_wait,
+				   start_notif, ARRAY_SIZE(start_notif),
+				   iwl_mld_session_start_fn, &data);
+
+	ret = _iwl_mld_schedule_session_protection(mld, vif, duration,
+						   min_duration, link_id);
+
+	if (ret) {
+		iwl_remove_notification(&mld->notif_wait, &start_wait);
+		return ret == -EALREADY ? 0 : ret;
+	}
+
+	ret = iwl_wait_notification(&mld->notif_wait, &start_wait, timeout);
+	if (ret)
+		return ret;
+	return data.success ? 0 : -EIO;
+}
+
+int iwl_mld_cancel_session_protection(struct iwl_mld *mld,
+				      struct ieee80211_vif *vif,
+				      int link_id)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld_link *link =
+		iwl_mld_link_dereference_check(mld_vif, link_id);
+	struct iwl_mld_session_protect *session_protect =
+		&mld_vif->session_protect;
+	struct iwl_session_prot_cmd cmd = {
+		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
+		.conf_id = cpu_to_le32(SESSION_PROTECT_CONF_ASSOC),
+	};
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	/* If there isn't an active session or a requested one for this
+	 * link do nothing
+	 */
+	if (!session_protect->session_requested &&
+	    !session_protect->end_jiffies)
+		return 0;
+
+	if (WARN_ON(!link))
+		return -EINVAL;
+
+	cmd.id_and_color = cpu_to_le32(link->fw_id),
+
+	ret = iwl_mld_send_cmd_pdu(mld,
+				   WIDE_ID(MAC_CONF_GROUP,
+					   SESSION_PROTECTION_CMD), &cmd);
+	if (ret) {
+		IWL_ERR(mld,
+			"Couldn't send the SESSION_PROTECTION_CMD\n");
+		return ret;
+	}
+
+	memset(session_protect, 0, sizeof(*session_protect));
+
+	return 0;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/session-protect.h b/drivers/net/wireless/intel/iwlwifi/mld/session-protect.h
new file mode 100644
index 000000000000..642bec8451a1
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/session-protect.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+
+#ifndef __session_protect_h__
+#define __session_protect_h__
+
+#include "mld.h"
+#include "hcmd.h"
+#include <net/mac80211.h>
+#include "fw/api/mac-cfg.h"
+
+/**
+ * DOC: session protection
+ *
+ * Session protection is an API from the firmware that allows the driver to
+ * request time on medium. This is needed before the association when we need
+ * to be on medium for the association frame exchange. Once we configure the
+ * firmware as 'associated', the firmware will allocate time on medium without
+ * needed a session protection.
+ *
+ * TDLS discover uses this API as well even after association to ensure that
+ * other activities internal to the firmware will not interrupt our presence
+ * on medium.
+ */
+
+/**
+ * struct iwl_mld_session_protect - session protection parameters
+ * @end_jiffies: expected end_jiffies of current session protection.
+ *	0 if not active
+ * @duration: the duration in tu of current session
+ * @session_requested: A session protection command was sent and wasn't yet
+ *	answered
+ */
+struct iwl_mld_session_protect {
+	unsigned long end_jiffies;
+	u32 duration;
+	bool session_requested;
+};
+
+#define IWL_MLD_SESSION_PROTECTION_ASSOC_TIME_MS 900
+#define IWL_MLD_SESSION_PROTECTION_MIN_TIME_MS 400
+
+/**
+ * iwl_mld_handle_session_prot_notif - handles %SESSION_PROTECTION_NOTIF
+ * @mld: the mld component
+ * @pkt: the RX packet containing the notification
+ */
+void iwl_mld_handle_session_prot_notif(struct iwl_mld *mld,
+				       struct iwl_rx_packet *pkt);
+
+/**
+ * iwl_mld_schedule_session_protection - schedule a session protection
+ * @mld: the mld component
+ * @vif: the virtual interface for which the protection issued
+ * @duration: the requested duration of the protection
+ * @min_duration: the minimum duration of the protection
+ * @link_id: The link to schedule a session protection for
+ */
+void iwl_mld_schedule_session_protection(struct iwl_mld *mld,
+					 struct ieee80211_vif *vif,
+					 u32 duration, u32 min_duration,
+					 int link_id);
+
+/**
+ * iwl_mld_start_session_protection - start a session protection
+ * @mld: the mld component
+ * @vif: the virtual interface for which the protection issued
+ * @duration: the requested duration of the protection
+ * @min_duration: the minimum duration of the protection
+ * @link_id: The link to schedule a session protection for
+ * @timeout: timeout for waiting
+ *
+ * This schedules the session protection, and waits for it to start
+ * (with timeout)
+ *
+ * Returns: 0 if successful, error code otherwise
+ */
+int iwl_mld_start_session_protection(struct iwl_mld *mld,
+				     struct ieee80211_vif *vif,
+				     u32 duration, u32 min_duration,
+				     int link_id, unsigned long timeout);
+
+/**
+ * iwl_mld_cancel_session_protection - cancel the session protection.
+ * @mld: the mld component
+ * @vif: the virtual interface for which the session is issued
+ * @link_id: cancel the session protection for given link
+ *
+ * This functions cancels the session protection which is an act of good
+ * citizenship. If it is not needed any more it should be canceled because
+ * the other mac contexts wait for the medium during that time.
+ *
+ * Returns: 0 if successful, error code otherwise
+ *
+ */
+int iwl_mld_cancel_session_protection(struct iwl_mld *mld,
+				      struct ieee80211_vif *vif,
+				      int link_id);
+
+#endif /* __session_protect_h__ */
-- 
2.34.1


