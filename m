Return-Path: <linux-wireless+bounces-7554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DC38C37EB
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 20:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB2F1C209EE
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 18:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C622747F58;
	Sun, 12 May 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cQJfHOle"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF73F4F1
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715538828; cv=none; b=RG4vm3Yy+xHbDtsyI6v0e9T4M/Ldt6M1GZVJfd9SYsrgdWFBZJJqCfR0dTr5dQW/b2WQgUHsgTPDKYvINPyKDySxPdrAmT+YaZna2DmbYpvanaptWuEAu5Rn0a7zIFArLYrQ95ttd+l/qBO0pvbXlmlrk6o5dUQt55GvCHeCRSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715538828; c=relaxed/simple;
	bh=ebUphqSibhaHFWuSGbESVE+SHAmPtL2qcybLyt/s3EI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECF7msLstJQdu5d0i0QbzOq4DQ0XMU7KfkOoxPGEJ/fMpjEGI1TX/CWUzxJz29XhFYA3sEeDbtGt6J6WQ/azdn8tl76myH+UT4LxLvcl1uyJBP7sFnAX/Q0BZg0ar+fH2RJ+XXcXUtPBveus+iMRtlhCTXB+HeRj57rgSWCHDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cQJfHOle; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44CIXg8K114061;
	Sun, 12 May 2024 13:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715538822;
	bh=ZJJfzKhCK9o38sa4Wu+UYnw21gea3d1NquRZc/B5caI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cQJfHOle5QiiQIvHpvkubHmNmPIv3DPMU2xygSZmLC9lhuliLFpFC8mP5j9PuAkgE
	 Q+ihQWU2Lw+btwEqWSj5UPB0BiaOg5m4OJA1sPbwzOKvZmUY1noa8VbzTa/7c5mmjR
	 0+niLOEPpJ5Ri05Bqo78hhhBEycbpB+zTxuVsF3c=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44CIXgLW096014
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 12 May 2024 13:33:42 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 12
 May 2024 13:33:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 12 May 2024 13:33:42 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44CIXfQB047221;
	Sun, 12 May 2024 13:33:42 -0500
From: <michael.nemanov@ti.com>
To: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC: <sabeeh-khan@ti.com>, Michael Nemanov <Michael.Nemanov@ti.com>,
        Michael
 Nemanov <michael.nemanov@ti.com>
Subject: [RFC PATCH 06/17] Add event.c, event.h
Date: Sun, 12 May 2024 21:32:36 +0300
Message-ID: <20240512183247.2190242-7-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240512183247.2190242-1-michael.nemanov@ti.com>
References: <20240512183247.2190242-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Michael Nemanov <Michael.Nemanov@ti.com>

Unlike in wlcore, events are queued on linked list
(cc->event_list) and are handled outside the IRQ
context. This will be more clear when looking at main.c

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
---
 drivers/net/wireless/ti/cc33xx/event.c | 391 +++++++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/event.h |  70 +++++
 2 files changed, 461 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/event.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/event.h

diff --git a/drivers/net/wireless/ti/cc33xx/event.c b/drivers/net/wireless/ti/cc33xx/event.c
new file mode 100644
index 000000000000..3f5ba6b759d9
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/event.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* Copyright (C) 2022-2024 Texas Instruments Inc.*/
+
+#include "acx.h"
+#include "event.h"
+#include "ps.h"
+#include "io.h"
+#include "scan.h"
+
+#define CC33XX_WAIT_EVENT_FAST_POLL_COUNT 20
+
+struct cc33xx_event_mailbox {
+	__le32 events_vector;
+
+	u8 number_of_scan_results;
+	u8 number_of_sched_scan_results;
+
+	__le16 channel_switch_role_id_bitmap;
+
+	s8 rssi_snr_trigger_metric[NUM_OF_RSSI_SNR_TRIGGERS];
+
+	/* bitmap of removed links */
+	__le32 hlid_removed_bitmap;
+
+	/* rx ba constraint */
+	__le16 rx_ba_role_id_bitmap; /* 0xfff means any role. */
+	__le16 rx_ba_allowed_bitmap;
+
+	/* bitmap of roc completed (by role id) */
+	__le16 roc_completed_bitmap;
+
+	/* bitmap of stations (by role id) with bss loss */
+	__le16 bss_loss_bitmap;
+
+	/* bitmap of stations (by HLID) which exceeded max tx retries */
+	__le16 tx_retry_exceeded_bitmap;
+
+	/* time sync high msb*/
+	__le16 time_sync_tsf_high_msb;
+
+	/* bitmap of inactive stations (by HLID) */
+	__le16 inactive_sta_bitmap;
+
+	/* time sync high lsb*/
+	__le16 time_sync_tsf_high_lsb;
+
+	/* rx BA win size indicated by RX_BA_WIN_SIZE_CHANGE_EVENT_ID */
+	u8 rx_ba_role_id;
+	u8 rx_ba_link_id;
+	u8 rx_ba_win_size;
+	u8 padding;
+
+	/* smart config */
+	u8 sc_ssid_len;
+	u8 sc_pwd_len;
+	u8 sc_token_len;
+	u8 padding1;
+	u8 sc_ssid[32];
+	u8 sc_pwd[64];
+	u8 sc_token[32];
+
+	/* smart config sync channel */
+	u8 sc_sync_channel;
+	u8 sc_sync_band;
+
+	/* time sync low msb*/
+	__le16 time_sync_tsf_low_msb;
+
+	/* radar detect */
+	u8 radar_channel;
+	u8 radar_type;
+
+	/* time sync low lsb*/
+	__le16 time_sync_tsf_low_lsb;
+
+	u8 ble_event[260];
+
+} __packed;
+
+struct event_node {
+	struct llist_node node;
+	struct cc33xx_event_mailbox event_data;
+};
+
+void deffer_event(struct cc33xx *cc,
+		  const void *event_payload, size_t event_length)
+{
+	struct event_node *event_node;
+	bool ret;
+
+	if (WARN_ON(event_length != sizeof(event_node->event_data)))
+		return;
+
+	event_node = kzalloc(sizeof(*event_node), GFP_KERNEL);
+	if (WARN_ON(!event_node))
+		return;
+
+	memcpy(&event_node->event_data,
+	       event_payload, sizeof(event_node->event_data));
+
+	llist_add(&event_node->node, &cc->event_list);
+	ret = queue_work(cc->freezable_wq, &cc->irq_deferred_work);
+
+	cc33xx_debug(DEBUG_IRQ, "Queued deferred work (%d)", ret);
+}
+
+static inline struct llist_node *get_event_list(struct cc33xx *cc)
+{
+	struct llist_node *node;
+
+	node = llist_del_all(&cc->event_list);
+	if (!node)
+		return NULL;
+
+	return llist_reverse_order(node);
+}
+
+void flush_deferred_event_list(struct cc33xx *cc)
+{
+	struct event_node *event_node, *tmp;
+	struct llist_node *event_list;
+
+	event_list = get_event_list(cc);
+	llist_for_each_entry_safe(event_node, tmp, event_list, node) {
+		cc33xx_debug(DEBUG_IRQ, "Freeing event");
+		kfree(event_node);
+	}
+}
+
+static int wait_for_event_or_timeout(struct cc33xx *cc, u32 mask, bool *timeout)
+{
+	u32 event;
+	unsigned long timeout_time;
+	u16 poll_count = 0;
+	int ret = 0;
+	struct event_node *event_node, *tmp;
+	struct llist_node *event_list;
+	u32 vector;
+
+	*timeout = false;
+
+	timeout_time = jiffies + msecs_to_jiffies(CC33XX_EVENT_TIMEOUT);
+
+	do {
+		if (time_after(jiffies, timeout_time)) {
+			cc33xx_debug(DEBUG_CMD, "timeout waiting for event %d",
+				     (int)mask);
+			*timeout = true;
+			goto out;
+		}
+
+		poll_count++;
+		if (poll_count < CC33XX_WAIT_EVENT_FAST_POLL_COUNT)
+			usleep_range(50, 51);
+		else
+			usleep_range(1000, 5000);
+
+		vector = 0;
+		event_list = get_event_list(cc);
+		llist_for_each_entry_safe(event_node, tmp, event_list, node) {
+			vector |= le32_to_cpu(event_node->event_data.events_vector);
+		}
+
+		event  = vector & mask;
+	} while (!event);
+
+out:
+
+	return ret;
+}
+
+int cc33xx_wait_for_event(struct cc33xx *cc, enum cc33xx_wait_event event,
+			  bool *timeout)
+{
+	u32 local_event;
+
+	switch (event) {
+	case CC33XX_EVENT_PEER_REMOVE_COMPLETE:
+		local_event = PEER_REMOVE_COMPLETE_EVENT_ID;
+		break;
+
+	case CC33XX_EVENT_DFS_CONFIG_COMPLETE:
+		local_event = DFS_CHANNELS_CONFIG_COMPLETE_EVENT;
+		break;
+
+	default:
+		/* event not implemented */
+		return 0;
+	}
+	return wait_for_event_or_timeout(cc, local_event, timeout);
+}
+
+static void cc33xx_event_sched_scan_completed(struct cc33xx *cc, u8 status)
+{
+	cc33xx_debug(DEBUG_EVENT,
+		     "PERIODIC_SCAN_COMPLETE_EVENT (status 0x%0x)", status);
+
+	if (cc->mac80211_scan_stopped) {
+		cc->mac80211_scan_stopped = false;
+	} else {
+		if (cc->sched_vif) {
+			ieee80211_sched_scan_stopped(cc->hw);
+			cc->sched_vif = NULL;
+		}
+	}
+}
+
+static void cc33xx_event_channel_switch(struct cc33xx *cc,
+					unsigned long roles_bitmap,
+				 bool success)
+{
+	struct cc33xx_vif *wlvif;
+	struct ieee80211_vif *vif;
+
+	cc33xx_debug(DEBUG_EVENT, "%s: roles=0x%lx success=%d",
+		     __func__, roles_bitmap, success);
+
+	cc33xx_for_each_wlvif(cc, wlvif) {
+		if (wlvif->role_id == CC33XX_INVALID_ROLE_ID ||
+		    !test_bit(wlvif->role_id, &roles_bitmap))
+			continue;
+
+		if (!test_and_clear_bit(WLVIF_FLAG_CS_PROGRESS,
+					&wlvif->flags))
+			continue;
+
+		vif = cc33xx_wlvif_to_vif(wlvif);
+
+		if (wlvif->bss_type == BSS_TYPE_STA_BSS) {
+			ieee80211_chswitch_done(vif, success, 0);
+			cancel_delayed_work(&wlvif->channel_switch_work);
+		} else {
+			set_bit(WLVIF_FLAG_BEACON_DISABLED, &wlvif->flags);
+			ieee80211_csa_finish(vif, 0);
+		}
+	}
+}
+
+static void cc33xx_disconnect_sta(struct cc33xx *cc, unsigned long sta_bitmap)
+{
+	u32 num_packets = cc->conf.host_conf.tx.max_tx_retries;
+	struct cc33xx_vif *wlvif;
+	struct ieee80211_vif *vif;
+	struct ieee80211_sta *sta;
+	const u8 *addr;
+	int h;
+
+	for_each_set_bit(h, &sta_bitmap, CC33XX_MAX_LINKS) {
+		bool found = false;
+		/* find the ap vif connected to this sta */
+		cc33xx_for_each_wlvif_ap(cc, wlvif) {
+			if (!test_bit(h, wlvif->ap.sta_hlid_map))
+				continue;
+			found = true;
+			break;
+		}
+		if (!found)
+			continue;
+
+		vif = cc33xx_wlvif_to_vif(wlvif);
+		addr = cc->links[h].addr;
+
+		rcu_read_lock();
+		sta = ieee80211_find_sta(vif, addr);
+		if (sta) {
+			cc33xx_debug(DEBUG_EVENT, "remove sta %d", h);
+			ieee80211_report_low_ack(sta, num_packets);
+		}
+		rcu_read_unlock();
+	}
+}
+
+static void cc33xx_event_max_tx_failure(struct cc33xx *cc,
+					unsigned long sta_bitmap)
+{
+	cc33xx_debug(DEBUG_EVENT, "MAX_TX_FAILURE_EVENT_ID");
+	cc33xx_disconnect_sta(cc, sta_bitmap);
+}
+
+static void cc33xx_event_roc_complete(struct cc33xx *cc)
+{
+	cc33xx_debug(DEBUG_EVENT, "REMAIN_ON_CHANNEL_COMPLETE_EVENT_ID");
+	if (cc->roc_vif)
+		ieee80211_ready_on_channel(cc->hw);
+}
+
+static void cc33xx_event_beacon_loss(struct cc33xx *cc,
+				     unsigned long roles_bitmap)
+{
+	/* We are HW_MONITOR device. On beacon loss - queue
+	 * connection loss work. Cancel it on REGAINED event.
+	 */
+	struct cc33xx_vif *wlvif;
+	struct ieee80211_vif *vif;
+	int delay = cc->conf.host_conf.conn.synch_fail_thold;
+
+	delay *= cc->conf.host_conf.conn.bss_lose_timeout;
+
+	cc33xx_info("Beacon loss detected. roles:0x%lx", roles_bitmap);
+
+	cc33xx_for_each_wlvif_sta(cc, wlvif) {
+		if (wlvif->role_id == CC33XX_INVALID_ROLE_ID ||
+		    !test_bit(wlvif->role_id, &roles_bitmap))
+			continue;
+
+		vif = cc33xx_wlvif_to_vif(wlvif);
+
+		/* don't attempt roaming in case of p2p */
+		if (wlvif->p2p) {
+			ieee80211_connection_loss(vif);
+			continue;
+		}
+
+		/* if the work is already queued, it should take place.
+		 * We don't want to delay the connection loss
+		 * indication any more.
+		 */
+		ieee80211_queue_delayed_work(cc->hw,
+					     &wlvif->connection_loss_work,
+					     msecs_to_jiffies(delay));
+
+		ieee80211_cqm_beacon_loss_notify(vif, GFP_KERNEL);
+	}
+}
+
+void process_deferred_events(struct cc33xx *cc)
+{
+	struct event_node *event_node, *tmp;
+	struct llist_node *event_list;
+	u32 vector;
+
+	event_list = get_event_list(cc);
+
+	llist_for_each_entry_safe(event_node, tmp, event_list, node) {
+		struct cc33xx_event_mailbox *event_data;
+
+		event_data = &event_node->event_data;
+
+		print_hex_dump(KERN_DEBUG, "Deferred event dump:",
+			       DUMP_PREFIX_OFFSET, 4, 4, event_data, 64, false);
+
+		vector = le32_to_cpu(event_node->event_data.events_vector);
+		cc33xx_debug(DEBUG_EVENT, "MBOX vector: 0x%x", vector);
+
+		if (vector & SCAN_COMPLETE_EVENT_ID) {
+			cc33xx_debug(DEBUG_EVENT, "scan results: %d",
+				     event_node->event_data.number_of_scan_results);
+
+			if (cc->scan_wlvif)
+				cc33xx_scan_completed(cc, cc->scan_wlvif);
+		}
+
+		if (vector & PERIODIC_SCAN_COMPLETE_EVENT_ID)
+			cc33xx_event_sched_scan_completed(cc, 1);
+
+		if (vector & BSS_LOSS_EVENT_ID) {
+			u16 bss_loss_bitmap = le16_to_cpu(event_data->bss_loss_bitmap);
+
+			cc33xx_event_beacon_loss(cc, bss_loss_bitmap);
+		}
+
+		if (vector & MAX_TX_FAILURE_EVENT_ID) {
+			u16 tx_retry_exceeded_bitmap =
+				le16_to_cpu(event_data->tx_retry_exceeded_bitmap);
+
+			cc33xx_event_max_tx_failure(cc, tx_retry_exceeded_bitmap);
+		}
+
+		if (vector & PERIODIC_SCAN_REPORT_EVENT_ID) {
+			cc33xx_debug(DEBUG_EVENT,
+				     "PERIODIC_SCAN_REPORT_EVENT (results %d)",
+				     event_data->number_of_sched_scan_results);
+
+			cc33xx_scan_sched_scan_results(cc);
+		}
+
+		if (vector & CHANNEL_SWITCH_COMPLETE_EVENT_ID) {
+			u16 channel_switch_role_id_bitmap =
+				le16_to_cpu(event_data->channel_switch_role_id_bitmap);
+
+			cc33xx_debug(DEBUG_EVENT, "CHANNEL_SWITCH_COMPLETE_EVENT_ID");
+			cc33xx_event_channel_switch(cc, channel_switch_role_id_bitmap, true);
+		}
+
+		if (vector & REMAIN_ON_CHANNEL_COMPLETE_EVENT_ID)
+			cc33xx_event_roc_complete(cc);
+
+		kfree(event_node);
+	}
+}
diff --git a/drivers/net/wireless/ti/cc33xx/event.h b/drivers/net/wireless/ti/cc33xx/event.h
new file mode 100644
index 000000000000..11be9e38abbb
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/event.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/* Copyright (C) 2022-2024 Texas Instruments Inc.*/
+
+#ifndef __EVENT_H__
+#define __EVENT_H__
+
+/* Mbox events
+ *
+ * The event mechanism is based on a pair of event buffers (buffers A and
+ * B) at fixed locations in the target's memory. The host processes one
+ * buffer while the other buffer continues to collect events. If the host
+ * is not processing events, an interrupt is issued to signal that a buffer
+ * is ready. Once the host is done with processing events from one buffer,
+ * it signals the target (with an ACK interrupt) that the event buffer is
+ * free.
+ */
+
+enum {
+	RSSI_SNR_TRIGGER_0_EVENT_ID              = BIT(0),
+	RSSI_SNR_TRIGGER_1_EVENT_ID              = BIT(1),
+	RSSI_SNR_TRIGGER_2_EVENT_ID              = BIT(2),
+	RSSI_SNR_TRIGGER_3_EVENT_ID              = BIT(3),
+	RSSI_SNR_TRIGGER_4_EVENT_ID              = BIT(4),
+	RSSI_SNR_TRIGGER_5_EVENT_ID              = BIT(5),
+	RSSI_SNR_TRIGGER_6_EVENT_ID              = BIT(6),
+	RSSI_SNR_TRIGGER_7_EVENT_ID              = BIT(7),
+
+	EVENT_MBOX_ALL_EVENT_ID			 = 0x7fffffff,
+};
+
+enum {
+	SCAN_COMPLETE_EVENT_ID                   = BIT(8),
+	RADAR_DETECTED_EVENT_ID                  = BIT(9),
+	CHANNEL_SWITCH_COMPLETE_EVENT_ID         = BIT(10),
+	BSS_LOSS_EVENT_ID                        = BIT(11),
+	MAX_TX_FAILURE_EVENT_ID                  = BIT(12),
+	DUMMY_PACKET_EVENT_ID                    = BIT(13),
+	INACTIVE_STA_EVENT_ID                    = BIT(14),
+	PEER_REMOVE_COMPLETE_EVENT_ID            = BIT(15),
+	PERIODIC_SCAN_COMPLETE_EVENT_ID          = BIT(16),
+	BA_SESSION_RX_CONSTRAINT_EVENT_ID        = BIT(17),
+	REMAIN_ON_CHANNEL_COMPLETE_EVENT_ID      = BIT(18),
+	DFS_CHANNELS_CONFIG_COMPLETE_EVENT       = BIT(19),
+	PERIODIC_SCAN_REPORT_EVENT_ID            = BIT(20),
+	RX_BA_WIN_SIZE_CHANGE_EVENT_ID           = BIT(21),
+	SMART_CONFIG_SYNC_EVENT_ID               = BIT(22),
+	SMART_CONFIG_DECODE_EVENT_ID             = BIT(23),
+	TIME_SYNC_EVENT_ID                       = BIT(24),
+	FW_LOGGER_INDICATION                     = BIT(25),
+};
+
+/* events the driver might want to wait for */
+enum cc33xx_wait_event {
+	CC33XX_EVENT_ROLE_STOP_COMPLETE,
+	CC33XX_EVENT_PEER_REMOVE_COMPLETE,
+	CC33XX_EVENT_DFS_CONFIG_COMPLETE
+};
+
+#define NUM_OF_RSSI_SNR_TRIGGERS 8
+
+struct cc33xx;
+
+int cc33xx_wait_for_event(struct cc33xx *cc, enum cc33xx_wait_event event,
+			  bool *timeout);
+void deffer_event(struct cc33xx *cc, const void *event_payload, size_t event_length);
+void process_deferred_events(struct cc33xx *cc);
+void flush_deferred_event_list(struct cc33xx *cc);
+
+#endif /* __EVENT_H__ */
-- 
2.25.1


