Return-Path: <linux-wireless+bounces-11030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6C8949653
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 19:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCDFB2A65C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 17:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F684171079;
	Tue,  6 Aug 2024 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qBMlU41m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0C016B732;
	Tue,  6 Aug 2024 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963715; cv=none; b=VtPkaPNophLz87mvEyPDcvtjZ7VJUglUYdnGA0ueA3bYbBcQp2aQ+NLqVe2DTF11+f/OSvwEENv8/wLWyEgRvBt53C+huoqtFoIH7gr1WW73EhtphvkYjiLdxLu02Uxdn5ccutHCHEyYYoIveC1VTbIp1BAzc51PRmmJQVB7Hcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963715; c=relaxed/simple;
	bh=9wnte3YXs/cL+TLTPyWzC74aq+7i6L6vhPbL6Pq81AA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKhogg4I7YVf6ei5rhQs35ThYy1w9LLhjsa2QSs7lFuDAFpvfgeORWkRKEtLvojIuC5N1BWXjOITxJydbPOF71m66Xw0GQOmOVf+N28ZAmhP1h5e4Kqej+JZt6Gjkh8JlrbeiKj2zF2Uu2CNVaZBRXw859tag1FvwDYACWwFrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qBMlU41m; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476H1fYq007460;
	Tue, 6 Aug 2024 12:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722963701;
	bh=TOaL8kDtzrTTOiJhBCZC0UmFSPmu0YqTpxBiQazG5kM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qBMlU41m+Ctfb2QukQrI4+ObEnioGyQvZhp6h3Nae4pFn9mJn7HfvmGCQAhdywpON
	 uixqYd5Dgz/qJ0piF1qdlwhVRasxCvjMfPzFZ38XTWi9xmfrBynFAsNFxOIOV4r09G
	 tPtj8oJZN2+GNJ5W8hEgTtSFFPFQ/duOAzImV8Tk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476H1fRI084678
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 12:01:41 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 12:01:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 12:01:41 -0500
Received: from localhost (udb0389739.dhcp.ti.com [137.167.1.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476H1eex039000;
	Tue, 6 Aug 2024 12:01:40 -0500
From: Michael Nemanov <michael.nemanov@ti.com>
To: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>, Michael Nemanov <michael.nemanov@ti.com>
Subject: [PATCH v3 10/17] wifi: cc33xx: Add tx.c, tx.h
Date: Tue, 6 Aug 2024 20:00:11 +0300
Message-ID: <20240806170018.638585-11-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806170018.638585-1-michael.nemanov@ti.com>
References: <20240806170018.638585-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Tx of data frames starts either with MAC80211 tx op (cc33xx_op_tx)
or from the deferred IRQ context (irq_deferred_work). Both trigger
cc->tx_work (cc33xx_tx_work @ tx.c) which will call
cc33xx_tx_work_locked where data from MAC80211 SKBs will be packed
and transferred to HW. An interrupt will then be received from HW
indicating that a given frame was transmitted or expired so that its
SKB can be freed (cc33xx_tx_immediate_complete).

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
---
 drivers/net/wireless/ti/cc33xx/tx.c | 1411 +++++++++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/tx.h |  160 +++
 2 files changed, 1571 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/tx.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/tx.h

diff --git a/drivers/net/wireless/ti/cc33xx/tx.c b/drivers/net/wireless/ti/cc33xx/tx.c
new file mode 100644
index 000000000000..287220f4a3f4
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/tx.c
@@ -0,0 +1,1411 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "acx.h"
+#include "debug.h"
+#include "io.h"
+#include "ps.h"
+#include "tx.h"
+#include "cc33xx.h"
+
+static int cc33xx_set_default_wep_key(struct cc33xx *cc,
+				      struct cc33xx_vif *wlvif, u8 id)
+{
+	int ret;
+	bool is_ap = (wlvif->bss_type == BSS_TYPE_AP_BSS);
+
+	if (is_ap)
+		ret = cc33xx_cmd_set_default_wep_key(cc, id,
+						     wlvif->ap.bcast_hlid);
+	else
+		ret = cc33xx_cmd_set_default_wep_key(cc, id, wlvif->sta.hlid);
+
+	if (ret < 0)
+		return ret;
+
+	cc33xx_debug(DEBUG_CRYPT, "default wep key idx: %d", (int)id);
+	return 0;
+}
+
+static int cc33xx_alloc_tx_id(struct cc33xx *cc, struct sk_buff *skb)
+{
+	int id;
+
+	id = find_first_zero_bit(cc->tx_frames_map, CC33XX_NUM_TX_DESCRIPTORS);
+	if (id >= CC33XX_NUM_TX_DESCRIPTORS)
+		return -EBUSY;
+
+	__set_bit(id, cc->tx_frames_map);
+	cc->tx_frames[id] = skb;
+	cc->tx_frames_cnt++;
+	cc33xx_debug(DEBUG_TX, "alloc desc ID. id - %d, frames count %d",
+		     id, cc->tx_frames_cnt);
+	return id;
+}
+
+void cc33xx_free_tx_id(struct cc33xx *cc, int id)
+{
+	if (__test_and_clear_bit(id, cc->tx_frames_map)) {
+		if (unlikely(cc->tx_frames_cnt == CC33XX_NUM_TX_DESCRIPTORS))
+			clear_bit(CC33XX_FLAG_FW_TX_BUSY, &cc->flags);
+
+		cc->tx_frames[id] = NULL;
+		cc->tx_frames_cnt--;
+	}
+	cc33xx_debug(DEBUG_TX, "free desc ID. id - %d, frames count %d",
+		     id, cc->tx_frames_cnt);
+}
+EXPORT_SYMBOL(cc33xx_free_tx_id);
+
+static void cc33xx_tx_ap_update_inconnection_sta(struct cc33xx *cc,
+						 struct cc33xx_vif *wlvif,
+						 struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr;
+
+	hdr = (struct ieee80211_hdr *)(skb->data +
+				       sizeof(struct cc33xx_tx_hw_descr));
+	if (!ieee80211_is_auth(hdr->frame_control))
+		return;
+
+	/* ROC for 1 second on the AP channel for completing the connection.
+	 * Note the ROC will be continued by the update_sta_state callbacks
+	 * once the station reaches the associated state.
+	 */
+	cc33xx_update_inconn_sta(cc, wlvif, NULL, true);
+	wlvif->pending_auth_reply_time = jiffies;
+	cancel_delayed_work(&wlvif->pending_auth_complete_work);
+	ieee80211_queue_delayed_work(cc->hw,
+				     &wlvif->pending_auth_complete_work,
+				msecs_to_jiffies(CC33XX_PEND_AUTH_ROC_TIMEOUT));
+}
+
+static void cc33xx_tx_regulate_link(struct cc33xx *cc,
+				    struct cc33xx_vif *wlvif,
+				    u8 hlid)
+{
+	bool fw_ps;
+	u8 tx_pkts;
+
+	if (WARN_ON(!test_bit(hlid, wlvif->links_map)))
+		return;
+
+	fw_ps = test_bit(hlid, &cc->ap_fw_ps_map);
+	tx_pkts = cc->links[hlid].allocated_pkts;
+
+	/* if in FW PS and there is enough data in FW we can put the link
+	 * into high-level PS and clean out its TX queues.
+	 * Make an exception if this is the only connected link. In this
+	 * case FW-memory congestion is less of a problem.
+	 * Note that a single connected STA means 2*ap_count + 1 active links,
+	 * since we must account for the global and broadcast AP links
+	 * for each AP. The "fw_ps" check assures us the other link is a STA
+	 * connected to the AP. Otherwise the FW would not set the PSM bit.
+	 */
+	if (cc->active_link_count > (cc->ap_count * 2 + 1) && fw_ps &&
+	    tx_pkts >= CC33XX_PS_STA_MAX_PACKETS)
+		cc33xx_ps_link_start(cc, wlvif, hlid, true);
+}
+
+inline bool cc33xx_is_dummy_packet(struct cc33xx *cc, struct sk_buff *skb)
+{
+	return cc->dummy_packet == skb;
+}
+EXPORT_SYMBOL(cc33xx_is_dummy_packet);
+
+static u8 cc33xx_tx_get_hlid_ap(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+				struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct ieee80211_hdr *hdr;
+
+	if (sta) {
+		struct cc33xx_station *wl_sta;
+
+		wl_sta = (struct cc33xx_station *)sta->drv_priv;
+		return wl_sta->hlid;
+	}
+
+	if (!test_bit(WLVIF_FLAG_AP_STARTED, &wlvif->flags))
+		return CC33XX_SYSTEM_HLID;
+
+	hdr = (struct ieee80211_hdr *)skb->data;
+	if (is_multicast_ether_addr(ieee80211_get_DA(hdr)))
+		return wlvif->ap.bcast_hlid;
+	else
+		return wlvif->ap.global_hlid;
+}
+
+u8 cc33xx_tx_get_hlid(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+		      struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct ieee80211_tx_info *control;
+
+	if (wlvif->bss_type == BSS_TYPE_AP_BSS)
+		return cc33xx_tx_get_hlid_ap(cc, wlvif, skb, sta);
+
+	control = IEEE80211_SKB_CB(skb);
+	if (control->flags & IEEE80211_TX_CTL_TX_OFFCHAN) {
+		cc33xx_debug(DEBUG_TX, "tx offchannel");
+		return wlvif->dev_hlid;
+	}
+
+	return wlvif->sta.hlid;
+}
+
+unsigned int cc33xx_calc_packet_alignment(struct cc33xx *cc,
+					  unsigned int packet_length)
+{
+	if ((cc->quirks & CC33XX_QUIRK_TX_PAD_LAST_FRAME) ||
+	    !(cc->quirks & CC33XX_QUIRK_TX_BLOCKSIZE_ALIGN))
+		return ALIGN(packet_length, CC33XX_TX_ALIGN_TO);
+	else
+		return ALIGN(packet_length, CC33XX_BUS_BLOCK_SIZE);
+}
+EXPORT_SYMBOL(cc33xx_calc_packet_alignment);
+
+static u32 cc33xx_calc_tx_blocks(struct cc33xx *cc, u32 len, u32 spare_blks)
+{
+	u32 blk_size = CC33XX_TX_HW_BLOCK_SIZE;
+	/* In CC33xx the packet will be stored along with its internal descriptor.
+	 * the descriptor is not part of the host transaction, but should be
+	 * considered as part of the allocate memory blocks in the device
+	 */
+	len = len + CC33xx_INTERNAL_DESC_SIZE;
+	return (len + blk_size - 1) / blk_size + spare_blks;
+}
+
+static inline void cc33xx_set_tx_desc_blocks(struct cc33xx *cc,
+					     struct cc33xx_tx_hw_descr *desc,
+					     u32 blks, u32 spare_blks)
+{
+	desc->cc33xx_mem.total_mem_blocks = blks;
+}
+
+static void cc33xx_set_tx_desc_data_len(struct cc33xx *cc,
+					struct cc33xx_tx_hw_descr *desc,
+					struct sk_buff *skb)
+{
+	desc->length = cpu_to_le16(skb->len);
+
+	/* if only the last frame is to be padded, we unset this bit on Tx */
+	if (cc->quirks & CC33XX_QUIRK_TX_PAD_LAST_FRAME)
+		desc->cc33xx_mem.ctrl = CC33XX_TX_CTRL_NOT_PADDED;
+	else
+		desc->cc33xx_mem.ctrl = 0;
+
+	cc33xx_debug(DEBUG_TX, "tx_fill_hdr: hlid: %d  len: %d life: %d mem: %d",
+		     desc->hlid, le16_to_cpu(desc->length),
+		     le16_to_cpu(desc->life_time),
+		     desc->cc33xx_mem.total_mem_blocks);
+}
+
+static int cc33xx_get_spare_blocks(struct cc33xx *cc, bool is_gem)
+{
+	/* If we have keys requiring extra spare, indulge them */
+	if (cc->extra_spare_key_count)
+		return CC33XX_TX_HW_EXTRA_BLOCK_SPARE;
+
+	return CC33XX_TX_HW_BLOCK_SPARE;
+}
+
+int cc33xx_tx_get_queue(int queue)
+{
+	switch (queue) {
+	case 0:
+		return CONF_TX_AC_VO;
+	case 1:
+		return CONF_TX_AC_VI;
+	case 2:
+		return CONF_TX_AC_BE;
+	case 3:
+		return CONF_TX_AC_BK;
+	default:
+		return CONF_TX_AC_BE;
+	}
+}
+
+static int cc33xx_tx_allocate(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			      struct sk_buff *skb, u32 extra, u32 buf_offset,
+			      u8 hlid, bool is_gem,
+			      struct NAB_tx_header *nab_cmd)
+{
+	struct cc33xx_tx_hw_descr *desc;
+	u32 total_blocks;
+	int id, ret = -EBUSY, ac;
+	u32 spare_blocks;
+	u32 total_skb_len = skb->len + extra;
+	/* Add NAB command required for CC33xx architecture */
+	u32 total_len = sizeof(struct NAB_tx_header);
+
+	total_skb_len += sizeof(struct cc33xx_tx_hw_descr);
+	total_len += total_skb_len;
+
+	cc33xx_debug(DEBUG_TX, "cc->tx_blocks_available %d",
+		     cc->tx_blocks_available);
+
+	if (buf_offset + total_len > cc->aggr_buf_size)
+		return -EAGAIN;
+
+	spare_blocks = cc33xx_get_spare_blocks(cc, is_gem);
+
+	/* allocate free identifier for the packet */
+	id = cc33xx_alloc_tx_id(cc, skb);
+	if (id < 0)
+		return id;
+
+	/* memblocks should not include nab descriptor */
+	total_blocks = cc33xx_calc_tx_blocks(cc, total_skb_len, spare_blocks);
+	cc33xx_debug(DEBUG_TX, "total blocks %d", total_blocks);
+
+	if (total_blocks <= cc->tx_blocks_available) {
+		/**
+		 * In CC33XX the packet starts with NAB command,
+		 * only then the descriptor.
+		 */
+		nab_cmd->sync = cpu_to_le32(HOST_SYNC_PATTERN);
+		nab_cmd->opcode = cpu_to_le16(NAB_SEND_CMD);
+
+		/**
+		 * length should include the following 4 bytes
+		 * of the NAB command.
+		 */
+		nab_cmd->len = cpu_to_le16(total_len -
+						sizeof(struct NAB_header));
+		nab_cmd->desc_length = cpu_to_le16(total_len -
+						sizeof(struct NAB_tx_header));
+		nab_cmd->sd = 0;
+		nab_cmd->flags = NAB_SEND_FLAGS;
+
+		desc = skb_push(skb, total_skb_len - skb->len);
+
+		cc33xx_set_tx_desc_blocks(cc, desc, total_blocks, spare_blocks);
+
+		desc->id = id;
+
+		cc33xx_debug(DEBUG_TX,
+			     "tx allocate id %u skb 0x%p tx_memblocks %d",
+			     id, skb, desc->cc33xx_mem.total_mem_blocks);
+
+		cc->tx_blocks_available -= total_blocks;
+		cc->tx_allocated_blocks += total_blocks;
+
+		/* If the FW was empty before, arm the Tx watchdog. Also do
+		 * this on the first Tx after resume, as we always cancel the
+		 * watchdog on suspend.
+		 */
+		if (cc->tx_allocated_blocks == total_blocks ||
+		    test_and_clear_bit(CC33XX_FLAG_REINIT_TX_WDOG, &cc->flags))
+			cc33xx_rearm_tx_watchdog_locked(cc);
+
+		ac = cc33xx_tx_get_queue(skb_get_queue_mapping(skb));
+		desc->ac = ac;
+		cc->tx_allocated_pkts[ac]++;
+
+		if (test_bit(hlid, cc->links_map))
+			cc->links[hlid].allocated_pkts++;
+
+		ret = 0;
+
+		cc33xx_debug(DEBUG_TX,
+			     "tx_allocate: size: %d, blocks: %d, id: %d",
+			     total_len, total_blocks, id);
+	} else {
+		cc33xx_free_tx_id(cc, id);
+	}
+
+	return ret;
+}
+
+static void cc33xx_tx_fill_hdr(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			       struct sk_buff *skb, u32 extra,
+			       struct ieee80211_tx_info *control, u8 hlid)
+{
+	struct cc33xx_tx_hw_descr *desc;
+	int ac, rate_idx;
+	u16 tx_attr = 0;
+	__le16 frame_control;
+	struct ieee80211_hdr *hdr;
+	u8 *frame_start;
+	bool is_dummy;
+
+	desc = (struct cc33xx_tx_hw_descr *)skb->data;
+
+	frame_start = (u8 *)(desc + 1);
+	hdr = (struct ieee80211_hdr *)(frame_start + extra);
+	frame_control = hdr->frame_control;
+
+	/* relocate space for security header */
+	if (extra) {
+		int hdrlen = ieee80211_hdrlen(frame_control);
+
+		memmove(frame_start, hdr, hdrlen);
+		skb_set_network_header(skb, skb_network_offset(skb) + extra);
+	}
+
+	is_dummy = cc33xx_is_dummy_packet(cc, skb);
+	if (is_dummy || !wlvif || wlvif->bss_type != BSS_TYPE_AP_BSS)
+		desc->life_time = cpu_to_le16(TX_HW_MGMT_PKT_LIFETIME_TU);
+	else
+		desc->life_time = cpu_to_le16(TX_HW_AP_MODE_PKT_LIFETIME_TU);
+
+	/* queue */
+	ac = cc33xx_tx_get_queue(skb_get_queue_mapping(skb));
+	desc->tid = skb->priority;
+
+	if (is_dummy) {
+		/* FW expects the dummy packet to have an invalid session id -
+		 * any session id that is different than the one set in the join
+		 */
+		tx_attr = (SESSION_COUNTER_INVALID <<
+			   TX_HW_ATTR_OFST_SESSION_COUNTER) &
+			   TX_HW_ATTR_SESSION_COUNTER;
+
+		tx_attr |= TX_HW_ATTR_TX_DUMMY_REQ;
+	} else if (wlvif) {
+		u8 session_id = cc->session_ids[hlid];
+
+		if (cc->quirks & CC33XX_QUIRK_AP_ZERO_SESSION_ID &&
+		    wlvif->bss_type == BSS_TYPE_AP_BSS)
+			session_id = 0;
+
+		/* configure the tx attributes */
+		tx_attr = session_id << TX_HW_ATTR_OFST_SESSION_COUNTER;
+	}
+
+	desc->hlid = hlid;
+	if (is_dummy || !wlvif) {
+		rate_idx = 0;
+	} else if (wlvif->bss_type != BSS_TYPE_AP_BSS) {
+		/* if the packets are data packets
+		 * send them with AP rate policies (EAPOLs are an exception),
+		 * otherwise use default basic rates
+		 */
+		if (skb->protocol == cpu_to_be16(ETH_P_PAE))
+			rate_idx = wlvif->sta.basic_rate_idx;
+		else if (control->flags & IEEE80211_TX_CTL_NO_CCK_RATE)
+			rate_idx = wlvif->sta.p2p_rate_idx;
+		else if (ieee80211_is_data(frame_control))
+			rate_idx = wlvif->sta.ap_rate_idx;
+		else
+			rate_idx = wlvif->sta.basic_rate_idx;
+	} else {
+		if (hlid == wlvif->ap.global_hlid)
+			rate_idx = wlvif->ap.mgmt_rate_idx;
+		else if (hlid == wlvif->ap.bcast_hlid ||
+			 skb->protocol == cpu_to_be16(ETH_P_PAE) ||
+			 !ieee80211_is_data(frame_control))
+			/* send non-data, bcast and EAPOLs using the
+			 * min basic rate
+			 */
+			rate_idx = wlvif->ap.bcast_rate_idx;
+		else
+			rate_idx = wlvif->ap.ucast_rate_idx[ac];
+	}
+
+	tx_attr |= rate_idx << TX_HW_ATTR_OFST_RATE_POLICY;
+
+	/* for WEP shared auth - no fw encryption is needed */
+	if (ieee80211_is_auth(frame_control) &&
+	    ieee80211_has_protected(frame_control))
+		tx_attr |= TX_HW_ATTR_HOST_ENCRYPT;
+
+	/* send EAPOL frames as voice */
+	if (control->control.flags & IEEE80211_TX_CTRL_PORT_CTRL_PROTO)
+		tx_attr |= TX_HW_ATTR_EAPOL_FRAME;
+
+	desc->tx_attr = cpu_to_le16(tx_attr);
+
+	cc33xx_set_tx_desc_data_len(cc, desc, skb);
+}
+
+/* caller must hold cc->mutex */
+static int cc33xx_prepare_tx_frame(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+				   struct sk_buff *skb, u32 buf_offset, u8 hlid)
+{
+	struct ieee80211_tx_info *info;
+	u32 extra = 0;
+	int ret = 0;
+	u32 total_len;
+	bool is_dummy;
+	bool is_gem = false;
+	struct NAB_tx_header nab_cmd;
+
+	if (!skb) {
+		cc33xx_error("discarding null skb");
+		return -EINVAL;
+	}
+
+	if (hlid == CC33XX_INVALID_LINK_ID) {
+		cc33xx_error("invalid hlid. dropping skb 0x%p", skb);
+		return -EINVAL;
+	}
+
+	info = IEEE80211_SKB_CB(skb);
+
+	is_dummy = cc33xx_is_dummy_packet(cc, skb);
+
+	if ((cc->quirks & CC33XX_QUIRK_TKIP_HEADER_SPACE) &&
+	    info->control.hw_key &&
+	    info->control.hw_key->cipher == WLAN_CIPHER_SUITE_TKIP)
+		extra = CC33XX_EXTRA_SPACE_TKIP;
+
+	if (info->control.hw_key) {
+		bool is_wep;
+		u8 idx = info->control.hw_key->hw_key_idx;
+		u32 cipher = info->control.hw_key->cipher;
+
+		is_wep = (cipher == WLAN_CIPHER_SUITE_WEP40) ||
+			 (cipher == WLAN_CIPHER_SUITE_WEP104);
+
+		if (WARN_ON(is_wep && wlvif && wlvif->default_key != idx)) {
+			ret = cc33xx_set_default_wep_key(cc, wlvif, idx);
+			if (ret < 0)
+				return ret;
+			wlvif->default_key = idx;
+		}
+
+		is_gem = (cipher == CC33XX_CIPHER_SUITE_GEM);
+	}
+
+	/* Add 4 bytes gap, may be filled later on by the PMAC. */
+	extra += IEEE80211_HT_CTL_LEN;
+	ret = cc33xx_tx_allocate(cc, wlvif, skb, extra, buf_offset, hlid,
+				 is_gem, &nab_cmd);
+	cc33xx_debug(DEBUG_TX, "cc33xx_tx_allocate %d", ret);
+
+	if (ret < 0)
+		return ret;
+
+	cc33xx_tx_fill_hdr(cc, wlvif, skb, extra, info, hlid);
+
+	if (!is_dummy && wlvif && wlvif->bss_type == BSS_TYPE_AP_BSS) {
+		cc33xx_tx_ap_update_inconnection_sta(cc, wlvif, skb);
+		cc33xx_tx_regulate_link(cc, wlvif, hlid);
+	}
+
+	/* The length of each packet is stored in terms of
+	 * words. Thus, we must pad the skb data to make sure its
+	 * length is aligned.  The number of padding bytes is computed
+	 * and set in cc33xx_tx_fill_hdr.
+	 * In special cases, we want to align to a specific block size
+	 * (eg. for wl128x with SDIO we align to 256).
+	 */
+	total_len = cc33xx_calc_packet_alignment(cc, skb->len);
+
+	memcpy(cc->aggr_buf + buf_offset,
+	       &nab_cmd, sizeof(struct NAB_tx_header));
+	memcpy(cc->aggr_buf + buf_offset + sizeof(struct NAB_tx_header),
+	       skb->data, skb->len);
+	memset(cc->aggr_buf + buf_offset + sizeof(struct NAB_tx_header)
+		+ skb->len, 0, total_len - skb->len);
+
+	/* Revert side effects in the dummy packet skb, so it can be reused */
+	if (is_dummy)
+		skb_pull(skb, sizeof(struct cc33xx_tx_hw_descr));
+
+	return (total_len + sizeof(struct NAB_tx_header));
+}
+
+u32 cc33xx_tx_enabled_rates_get(struct cc33xx *cc, u32 rate_set,
+				enum nl80211_band rate_band)
+{
+	struct ieee80211_supported_band *band;
+	u32 enabled_rates = 0;
+	int bit;
+
+	band = cc->hw->wiphy->bands[rate_band];
+	for (bit = 0; bit < band->n_bitrates; bit++) {
+		if (rate_set & 0x1)
+			enabled_rates |= band->bitrates[bit].hw_value;
+		rate_set >>= 1;
+	}
+
+	/* MCS rates indication are on bits 16 - 31 */
+	rate_set >>= HW_HT_RATES_OFFSET - band->n_bitrates;
+
+	for (bit = 0; bit < 16; bit++) {
+		if (rate_set & 0x1)
+			enabled_rates |= (CONF_HW_BIT_RATE_MCS_0 << bit);
+		rate_set >>= 1;
+	}
+
+	return enabled_rates;
+}
+
+static inline int cc33xx_tx_get_mac80211_queue(struct cc33xx_vif *wlvif,
+					       int queue)
+{
+	int mac_queue = wlvif->hw_queue_base;
+
+	switch (queue) {
+	case CONF_TX_AC_VO:
+		return mac_queue + 0;
+	case CONF_TX_AC_VI:
+		return mac_queue + 1;
+	case CONF_TX_AC_BE:
+		return mac_queue + 2;
+	case CONF_TX_AC_BK:
+		return mac_queue + 3;
+	default:
+		return mac_queue + 2;
+	}
+}
+
+static void cc33xx_wake_queue(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			      u8 queue, enum cc33xx_queue_stop_reason reason)
+{
+	unsigned long flags;
+	int hwq = cc33xx_tx_get_mac80211_queue(wlvif, queue);
+
+	spin_lock_irqsave(&cc->cc_lock, flags);
+
+	/* queue should not be clear for this reason */
+	WARN_ON_ONCE(!test_and_clear_bit(reason, &cc->queue_stop_reasons[hwq]));
+
+	if (cc->queue_stop_reasons[hwq])
+		goto out;
+
+	ieee80211_wake_queue(cc->hw, hwq);
+
+out:
+	spin_unlock_irqrestore(&cc->cc_lock, flags);
+}
+
+void cc33xx_handle_tx_low_watermark(struct cc33xx *cc)
+{
+	int i;
+	struct cc33xx_vif *wlvif;
+
+	cc33xx_for_each_wlvif(cc, wlvif) {
+		for (i = 0; i < NUM_TX_QUEUES; i++) {
+			if (cc33xx_is_queue_stopped_by_reason(cc, wlvif, i,
+							      CC33XX_QUEUE_STOP_REASON_WATERMARK) &&
+			    wlvif->tx_queue_count[i] <=
+					CC33XX_TX_QUEUE_LOW_WATERMARK)
+				/* firmware buffer has space, restart queues */
+				cc33xx_wake_queue(cc, wlvif, i,
+						  CC33XX_QUEUE_STOP_REASON_WATERMARK);
+		}
+	}
+}
+
+static int cc33xx_select_ac(struct cc33xx *cc)
+{
+	int i, q = -1, ac;
+	u32 min_pkts = 0xffffffff;
+
+	/* Find a non-empty ac where:
+	 * 1. There are packets to transmit
+	 * 2. The FW has the least allocated blocks
+	 *
+	 * We prioritize the ACs according to VO>VI>BE>BK
+	 */
+	for (i = 0; i < NUM_TX_QUEUES; i++) {
+		ac = cc33xx_tx_get_queue(i);
+		if (cc->tx_queue_count[ac] &&
+		    cc->tx_allocated_pkts[ac] < min_pkts) {
+			q = ac;
+			min_pkts = cc->tx_allocated_pkts[q];
+		}
+	}
+
+	return q;
+}
+
+static struct sk_buff *cc33xx_lnk_dequeue(struct cc33xx *cc,
+					  struct cc33xx_link *lnk, u8 q)
+{
+	struct sk_buff *skb;
+	unsigned long flags;
+
+	skb = skb_dequeue(&lnk->tx_queue[q]);
+	if (skb) {
+		spin_lock_irqsave(&cc->cc_lock, flags);
+		WARN_ON_ONCE(cc->tx_queue_count[q] <= 0);
+		cc->tx_queue_count[q]--;
+		if (lnk->wlvif) {
+			WARN_ON_ONCE(lnk->wlvif->tx_queue_count[q] <= 0);
+			lnk->wlvif->tx_queue_count[q]--;
+		}
+		spin_unlock_irqrestore(&cc->cc_lock, flags);
+	}
+
+	return skb;
+}
+
+static bool cc33xx_lnk_high_prio(struct cc33xx *cc, u8 hlid,
+				 struct cc33xx_link *lnk)
+{
+	u8 thold;
+	struct core_fw_status *core_fw_status = &cc->core_status->fw_info;
+	unsigned long suspend_bitmap, fast_bitmap, ps_bitmap;
+
+	suspend_bitmap = le32_to_cpu(core_fw_status->link_suspend_bitmap);
+	fast_bitmap = le32_to_cpu(core_fw_status->link_fast_bitmap);
+	ps_bitmap = le32_to_cpu(core_fw_status->link_ps_bitmap);
+
+	/* suspended links are never high priority */
+	if (test_bit(hlid, &suspend_bitmap))
+		return false;
+
+	/* the priority thresholds are taken from FW */
+	if (test_bit(hlid, &fast_bitmap) && !test_bit(hlid, &ps_bitmap))
+		thold = core_fw_status->tx_fast_link_prio_threshold;
+	else
+		thold = core_fw_status->tx_slow_link_prio_threshold;
+
+	return lnk->allocated_pkts < thold;
+}
+
+static bool cc33xx_lnk_low_prio(struct cc33xx *cc, u8 hlid,
+				struct cc33xx_link *lnk)
+{
+	u8 thold;
+	struct core_fw_status *core_fw_status = &cc->core_status->fw_info;
+	unsigned long suspend_bitmap, fast_bitmap, ps_bitmap;
+
+	suspend_bitmap = le32_to_cpu(core_fw_status->link_suspend_bitmap);
+	fast_bitmap = le32_to_cpu(core_fw_status->link_fast_bitmap);
+	ps_bitmap = le32_to_cpu(core_fw_status->link_ps_bitmap);
+
+	if (test_bit(hlid, &suspend_bitmap))
+		thold = core_fw_status->tx_suspend_threshold;
+	else if (test_bit(hlid, &fast_bitmap) && !test_bit(hlid, &ps_bitmap))
+		thold = core_fw_status->tx_fast_stop_threshold;
+	else
+		thold = core_fw_status->tx_slow_stop_threshold;
+
+	return lnk->allocated_pkts < thold;
+}
+
+static struct sk_buff *cc33xx_lnk_dequeue_high_prio(struct cc33xx *cc,
+						    u8 hlid, u8 ac,
+						    u8 *low_prio_hlid)
+{
+	struct cc33xx_link *lnk = &cc->links[hlid];
+
+	if (!cc33xx_lnk_high_prio(cc, hlid, lnk)) {
+		if (*low_prio_hlid == CC33XX_INVALID_LINK_ID &&
+		    !skb_queue_empty(&lnk->tx_queue[ac]) &&
+		    cc33xx_lnk_low_prio(cc, hlid, lnk))
+			/* we found the first non-empty low priority queue */
+			*low_prio_hlid = hlid;
+
+		return NULL;
+	}
+
+	return cc33xx_lnk_dequeue(cc, lnk, ac);
+}
+
+static struct sk_buff *cc33xx_vif_dequeue_high_prio(struct cc33xx *cc,
+						    struct cc33xx_vif *wlvif,
+						    u8 ac, u8 *hlid,
+						    u8 *low_prio_hlid)
+{
+	struct sk_buff *skb = NULL;
+	int i, h, start_hlid;
+
+	/* start from the link after the last one */
+	start_hlid = (wlvif->last_tx_hlid + 1) % CC33XX_MAX_LINKS;
+
+	/* dequeue according to AC, round robin on each link */
+	for (i = 0; i < CC33XX_MAX_LINKS; i++) {
+		h = (start_hlid + i) % CC33XX_MAX_LINKS;
+
+		/* only consider connected stations */
+		if (!test_bit(h, wlvif->links_map))
+			continue;
+
+		skb = cc33xx_lnk_dequeue_high_prio(cc, h, ac, low_prio_hlid);
+		if (!skb)
+			continue;
+
+		wlvif->last_tx_hlid = h;
+		break;
+	}
+
+	if (!skb)
+		wlvif->last_tx_hlid = 0;
+
+	*hlid = wlvif->last_tx_hlid;
+	return skb;
+}
+
+static struct sk_buff *cc33xx_skb_dequeue(struct cc33xx *cc, u8 *hlid)
+{
+	unsigned long flags;
+	struct cc33xx_vif *wlvif = cc->last_wlvif;
+	struct sk_buff *skb = NULL;
+	int ac;
+	u8 low_prio_hlid = CC33XX_INVALID_LINK_ID;
+
+	ac = cc33xx_select_ac(cc);
+	if (ac < 0)
+		goto out;
+
+	/* continue from last wlvif (round robin) */
+	if (wlvif) {
+		cc33xx_for_each_wlvif_continue(cc, wlvif) {
+			if (!wlvif->tx_queue_count[ac])
+				continue;
+
+			skb = cc33xx_vif_dequeue_high_prio(cc, wlvif, ac, hlid,
+							   &low_prio_hlid);
+			if (!skb)
+				continue;
+
+			cc->last_wlvif = wlvif;
+			break;
+		}
+	}
+
+	/* dequeue from the system HLID before the restarting wlvif list */
+	if (!skb) {
+		skb = cc33xx_lnk_dequeue_high_prio(cc, CC33XX_SYSTEM_HLID,
+						   ac, &low_prio_hlid);
+		if (skb) {
+			*hlid = CC33XX_SYSTEM_HLID;
+			cc->last_wlvif = NULL;
+		}
+	}
+
+	/* Do a new pass over the wlvif list. But no need to continue
+	 * after last_wlvif. The previous pass should have found it.
+	 */
+	if (!skb) {
+		cc33xx_for_each_wlvif(cc, wlvif) {
+			if (!wlvif->tx_queue_count[ac])
+				goto next;
+
+			skb = cc33xx_vif_dequeue_high_prio(cc, wlvif, ac, hlid,
+							   &low_prio_hlid);
+			if (skb) {
+				cc->last_wlvif = wlvif;
+				break;
+			}
+
+next:
+			if (wlvif == cc->last_wlvif)
+				break;
+		}
+	}
+
+	/* no high priority skbs found - but maybe a low priority one? */
+	if (!skb && low_prio_hlid != CC33XX_INVALID_LINK_ID) {
+		struct cc33xx_link *lnk = &cc->links[low_prio_hlid];
+
+		skb = cc33xx_lnk_dequeue(cc, lnk, ac);
+
+		WARN_ON(!skb); /* we checked this before */
+		*hlid = low_prio_hlid;
+
+		/* ensure proper round robin in the vif/link levels */
+		cc->last_wlvif = lnk->wlvif;
+		if (lnk->wlvif)
+			lnk->wlvif->last_tx_hlid = low_prio_hlid;
+	}
+
+out:
+	if (!skb &&
+	    test_and_clear_bit(CC33XX_FLAG_DUMMY_PACKET_PENDING, &cc->flags)) {
+		int q;
+
+		skb = cc->dummy_packet;
+		*hlid = CC33XX_SYSTEM_HLID;
+		q = cc33xx_tx_get_queue(skb_get_queue_mapping(skb));
+		spin_lock_irqsave(&cc->cc_lock, flags);
+		WARN_ON_ONCE(cc->tx_queue_count[q] <= 0);
+		cc->tx_queue_count[q]--;
+		spin_unlock_irqrestore(&cc->cc_lock, flags);
+	}
+
+	return skb;
+}
+
+static void cc33xx_skb_queue_head(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+				  struct sk_buff *skb, u8 hlid)
+{
+	unsigned long flags;
+	int q = cc33xx_tx_get_queue(skb_get_queue_mapping(skb));
+
+	if (cc33xx_is_dummy_packet(cc, skb)) {
+		set_bit(CC33XX_FLAG_DUMMY_PACKET_PENDING, &cc->flags);
+	} else {
+		skb_queue_head(&cc->links[hlid].tx_queue[q], skb);
+
+		/* make sure we dequeue the same packet next time */
+		wlvif->last_tx_hlid = (hlid + CC33XX_MAX_LINKS - 1) %
+				      CC33XX_MAX_LINKS;
+	}
+
+	spin_lock_irqsave(&cc->cc_lock, flags);
+	cc->tx_queue_count[q]++;
+	if (wlvif)
+		wlvif->tx_queue_count[q]++;
+	spin_unlock_irqrestore(&cc->cc_lock, flags);
+}
+
+static inline bool cc33xx_tx_is_data_present(struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)(skb->data);
+
+	return ieee80211_is_data_present(hdr->frame_control);
+}
+
+/* Returns failure values only in case of failed bus ops within this function.
+ * cc33xx_prepare_tx_frame retvals won't be returned in order to avoid
+ * triggering recovery by higher layers when not necessary.
+ * In case a FW command fails within cc33xx_prepare_tx_frame fails a recovery
+ * will be queued in cc33xx_cmd_send. -EAGAIN/-EBUSY from prepare_tx_frame
+ * can occur and are legitimate so don't propagate. -EINVAL will emit a WARNING
+ * within prepare_tx_frame code but there's nothing we should do about those
+ * as well.
+ */
+int cc33xx_tx_work_locked(struct cc33xx *cc)
+{
+	struct cc33xx_vif *wlvif;
+	struct sk_buff *skb;
+	struct cc33xx_tx_hw_descr *desc;
+	u32 buf_offset = 0, last_len = 0;
+	u32 transfer_len = 0;
+	u32 padding_size = 0;
+	bool sent_packets = false;
+	unsigned long active_hlids[BITS_TO_LONGS(CC33XX_MAX_LINKS)] = {0};
+	int ret = 0;
+	int bus_ret = 0;
+	u8 hlid;
+
+	memset(cc->aggr_buf, 0, 0x300);
+	if (unlikely(cc->state != CC33XX_STATE_ON))
+		return 0;
+
+	while ((skb = cc33xx_skb_dequeue(cc, &hlid))) {
+		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+		bool has_data = false;
+
+		cc33xx_debug(DEBUG_TX, "skb dequeue skb: 0x%p data %#lx head %#lx tail %#lx end %#lx",
+			     skb,
+			     (unsigned long)skb->data, (unsigned long)skb->head,
+			     (unsigned long)skb->tail, (unsigned long)skb->end);
+		wlvif = NULL;
+		if (!cc33xx_is_dummy_packet(cc, skb))
+			wlvif = cc33xx_vif_to_data(info->control.vif);
+		else
+			hlid = CC33XX_SYSTEM_HLID;
+
+		has_data = wlvif && cc33xx_tx_is_data_present(skb);
+		ret = cc33xx_prepare_tx_frame(cc, wlvif, skb, buf_offset,
+					      hlid);
+
+		if (ret == -EAGAIN) {
+			/* Aggregation buffer is full.
+			 * Flush buffer and try again.
+			 */
+			cc33xx_skb_queue_head(cc, wlvif, skb, hlid);
+
+			transfer_len = __ALIGN_MASK(buf_offset,
+						    CC33XX_BUS_BLOCK_SIZE * 2 - 1);
+
+			padding_size = transfer_len - buf_offset;
+			memset(cc->aggr_buf + buf_offset, 0x33, padding_size);
+
+			cc33xx_debug(DEBUG_TX, "sdio transaction length: %d ",
+				     transfer_len);
+
+			bus_ret = cc33xx_write(cc, NAB_DATA_ADDR, cc->aggr_buf,
+					       transfer_len, true);
+			if (bus_ret < 0)
+				goto out;
+
+			sent_packets = true;
+			buf_offset = 0;
+			continue;
+		} else if (ret == -EBUSY) {
+			/* Firmware buffer is full.
+			 * Queue back last skb, and stop aggregating.
+			 */
+			cc33xx_skb_queue_head(cc, wlvif, skb, hlid);
+			/* No work left, avoid scheduling redundant tx work */
+			set_bit(CC33XX_FLAG_FW_TX_BUSY, &cc->flags);
+			goto out_ack;
+		} else if (ret < 0) {
+			if (cc33xx_is_dummy_packet(cc, skb))
+				/* fw still expects dummy packet,
+				 * so re-enqueue it
+				 */
+				cc33xx_skb_queue_head(cc, wlvif, skb, hlid);
+			else
+				ieee80211_free_txskb(cc->hw, skb);
+			goto out_ack;
+		}
+
+		last_len = ret;
+		buf_offset += last_len;
+
+		if (has_data) {
+			desc = (struct cc33xx_tx_hw_descr *)skb->data;
+			__set_bit(desc->hlid, active_hlids);
+		}
+	}
+
+out_ack:
+	if (buf_offset) {
+		transfer_len = __ALIGN_MASK(buf_offset,
+					    CC33XX_BUS_BLOCK_SIZE * 2 - 1);
+
+		padding_size = transfer_len - buf_offset;
+		memset(cc->aggr_buf + buf_offset, 0x33, padding_size);
+
+		cc33xx_debug(DEBUG_TX, "sdio transaction (926) length: %d ",
+			     transfer_len);
+
+		bus_ret = cc33xx_write(cc, NAB_DATA_ADDR, cc->aggr_buf,
+				       transfer_len, true);
+		if (bus_ret < 0)
+			goto out;
+
+		sent_packets = true;
+	}
+
+	if (sent_packets)
+		cc33xx_handle_tx_low_watermark(cc);
+
+out:
+	return bus_ret;
+}
+
+void cc33xx_tx_work(struct work_struct *work)
+{
+	struct cc33xx *cc = container_of(work, struct cc33xx, tx_work);
+	int ret;
+
+	mutex_lock(&cc->mutex);
+
+	ret = cc33xx_tx_work_locked(cc);
+	if (ret < 0) {
+		cc33xx_queue_recovery_work(cc);
+		goto out;
+	}
+
+out:
+	mutex_unlock(&cc->mutex);
+}
+
+void cc33xx_tx_reset_link_queues(struct cc33xx *cc, u8 hlid)
+{
+	struct sk_buff *skb;
+	int i;
+	unsigned long flags;
+	struct ieee80211_tx_info *info;
+	int total[NUM_TX_QUEUES];
+	struct cc33xx_link *lnk = &cc->links[hlid];
+
+	for (i = 0; i < NUM_TX_QUEUES; i++) {
+		total[i] = 0;
+		while ((skb = skb_dequeue(&lnk->tx_queue[i]))) {
+			cc33xx_debug(DEBUG_TX, "link freeing skb 0x%p", skb);
+
+			if (!cc33xx_is_dummy_packet(cc, skb)) {
+				info = IEEE80211_SKB_CB(skb);
+				info->status.rates[0].idx = -1;
+				info->status.rates[0].count = 0;
+				ieee80211_tx_status_ni(cc->hw, skb);
+			}
+
+			total[i]++;
+		}
+	}
+
+	spin_lock_irqsave(&cc->cc_lock, flags);
+	for (i = 0; i < NUM_TX_QUEUES; i++) {
+		cc->tx_queue_count[i] -= total[i];
+		if (lnk->wlvif)
+			lnk->wlvif->tx_queue_count[i] -= total[i];
+	}
+	spin_unlock_irqrestore(&cc->cc_lock, flags);
+
+	cc33xx_handle_tx_low_watermark(cc);
+}
+
+/* caller must hold cc->mutex and TX must be stopped */
+void cc33xx_tx_reset_wlvif(struct cc33xx *cc, struct cc33xx_vif *wlvif)
+{
+	int i;
+
+	/* TX failure */
+	for_each_set_bit(i, wlvif->links_map, CC33XX_MAX_LINKS) {
+		if (wlvif->bss_type == BSS_TYPE_AP_BSS &&
+		    i != wlvif->ap.bcast_hlid &&
+		    i != wlvif->ap.global_hlid) {
+			/* this calls cc33xx_clear_link */
+			cc33xx_free_sta(cc, wlvif, i);
+		} else {
+			u8 hlid = i;
+
+			cc33xx_clear_link(cc, wlvif, &hlid);
+		}
+	}
+
+	wlvif->last_tx_hlid = 0;
+
+	for (i = 0; i < NUM_TX_QUEUES; i++)
+		wlvif->tx_queue_count[i] = 0;
+}
+
+int cc33xx_tx_total_queue_count(struct cc33xx *cc)
+{
+	int i, count = 0;
+
+	for (i = 0; i < NUM_TX_QUEUES; i++)
+		count += cc->tx_queue_count[i];
+
+	return count;
+}
+
+/* caller must hold cc->mutex and TX must be stopped */
+void cc33xx_tx_reset(struct cc33xx *cc)
+{
+	int i;
+	struct sk_buff *skb;
+	struct ieee80211_tx_info *info;
+
+	/* only reset the queues if something bad happened */
+	if (cc33xx_tx_total_queue_count(cc) != 0) {
+		for (i = 0; i < CC33XX_MAX_LINKS; i++)
+			cc33xx_tx_reset_link_queues(cc, i);
+
+		for (i = 0; i < NUM_TX_QUEUES; i++)
+			cc->tx_queue_count[i] = 0;
+	}
+
+	/* Make sure the driver is at a consistent state, in case this
+	 * function is called from a context other than interface removal.
+	 * This call will always wake the TX queues.
+	 */
+	cc33xx_handle_tx_low_watermark(cc);
+
+	for (i = 0; i < CC33XX_NUM_TX_DESCRIPTORS; i++) {
+		if (!cc->tx_frames[i])
+			continue;
+
+		skb = cc->tx_frames[i];
+		cc33xx_free_tx_id(cc, i);
+		cc33xx_debug(DEBUG_TX, "freeing skb 0x%p", skb);
+
+		if (!cc33xx_is_dummy_packet(cc, skb)) {
+			/* Remove private headers before passing the skb to
+			 * mac80211
+			 */
+			info = IEEE80211_SKB_CB(skb);
+			skb_pull(skb, sizeof(struct cc33xx_tx_hw_descr));
+			if ((cc->quirks & CC33XX_QUIRK_TKIP_HEADER_SPACE) &&
+			    info->control.hw_key &&
+			    info->control.hw_key->cipher ==
+			    WLAN_CIPHER_SUITE_TKIP) {
+				int hdrlen = ieee80211_get_hdrlen_from_skb(skb);
+
+				memmove(skb->data + CC33XX_EXTRA_SPACE_TKIP,
+					skb->data, hdrlen);
+				skb_pull(skb, CC33XX_EXTRA_SPACE_TKIP);
+			}
+
+			info->status.rates[0].idx = -1;
+			info->status.rates[0].count = 0;
+
+			ieee80211_tx_status_ni(cc->hw, skb);
+		}
+	}
+}
+
+#define CC33XX_TX_FLUSH_TIMEOUT 500000
+
+/* caller must *NOT* hold cc->mutex */
+void cc33xx_tx_flush(struct cc33xx *cc)
+{
+	unsigned long timeout, start_time;
+	int i;
+
+	start_time = jiffies;
+	timeout = start_time + usecs_to_jiffies(CC33XX_TX_FLUSH_TIMEOUT);
+
+	/* only one flush should be in progress, for consistent queue state */
+	mutex_lock(&cc->flush_mutex);
+
+	mutex_lock(&cc->mutex);
+	if (cc->tx_frames_cnt == 0 && cc33xx_tx_total_queue_count(cc) == 0) {
+		mutex_unlock(&cc->mutex);
+		goto out;
+	}
+
+	cc33xx_stop_queues(cc, CC33XX_QUEUE_STOP_REASON_FLUSH);
+
+	while (!time_after(jiffies, timeout)) {
+		cc33xx_debug(DEBUG_MAC80211, "flushing tx buffer: %d %d",
+			     cc->tx_frames_cnt,
+			     cc33xx_tx_total_queue_count(cc));
+
+		/* force Tx and give the driver some time to flush data */
+		mutex_unlock(&cc->mutex);
+		if (cc33xx_tx_total_queue_count(cc))
+			cc33xx_tx_work(&cc->tx_work);
+		msleep(20);
+		mutex_lock(&cc->mutex);
+
+		if (cc->tx_frames_cnt == 0 && cc33xx_tx_total_queue_count(cc) == 0) {
+			cc33xx_debug(DEBUG_MAC80211, "tx flush took %d ms",
+				     jiffies_to_msecs(jiffies - start_time));
+			goto out_wake;
+		}
+	}
+
+	cc33xx_warning("Unable to flush all TX buffers, timed out (timeout %d ms",
+		       CC33XX_TX_FLUSH_TIMEOUT / 1000);
+
+	/* forcibly flush all Tx buffers on our queues */
+	for (i = 0; i < CC33XX_MAX_LINKS; i++)
+		cc33xx_tx_reset_link_queues(cc, i);
+
+out_wake:
+	cc33xx_wake_queues(cc, CC33XX_QUEUE_STOP_REASON_FLUSH);
+	mutex_unlock(&cc->mutex);
+out:
+	mutex_unlock(&cc->flush_mutex);
+}
+
+u32 cc33xx_tx_min_rate_get(struct cc33xx *cc, u32 rate_set)
+{
+	if (WARN_ON(!rate_set))
+		return 0;
+
+	return BIT(__ffs(rate_set));
+}
+
+void cc33xx_stop_queue_locked(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			      u8 queue, enum cc33xx_queue_stop_reason reason)
+{
+	int hwq = cc33xx_tx_get_mac80211_queue(wlvif, queue);
+	bool stopped = !!cc->queue_stop_reasons[hwq];
+
+	/* queue should not be stopped for this reason */
+	WARN_ON_ONCE(test_and_set_bit(reason, &cc->queue_stop_reasons[hwq]));
+
+	if (stopped)
+		return;
+
+	ieee80211_stop_queue(cc->hw, hwq);
+}
+
+void cc33xx_stop_queues(struct cc33xx *cc,
+			enum cc33xx_queue_stop_reason reason)
+{
+	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cc->cc_lock, flags);
+
+	/* mark all possible queues as stopped */
+	for (i = 0; i < CC33XX_NUM_MAC_ADDRESSES * NUM_TX_QUEUES; i++) {
+		WARN_ON_ONCE(test_and_set_bit(reason,
+					      &cc->queue_stop_reasons[i]));
+	}
+
+	/* use the global version to make sure all vifs in mac80211 we don't
+	 * know are stopped.
+	 */
+	ieee80211_stop_queues(cc->hw);
+
+	spin_unlock_irqrestore(&cc->cc_lock, flags);
+}
+
+void cc33xx_wake_queues(struct cc33xx *cc,
+			enum cc33xx_queue_stop_reason reason)
+{
+	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cc->cc_lock, flags);
+
+	/* mark all possible queues as awake */
+	for (i = 0; i < CC33XX_NUM_MAC_ADDRESSES * NUM_TX_QUEUES; i++) {
+		WARN_ON_ONCE(!test_and_clear_bit(reason,
+						 &cc->queue_stop_reasons[i]));
+	}
+
+	/* use the global version to make sure all vifs in mac80211 we don't
+	 * know are woken up.
+	 */
+	ieee80211_wake_queues(cc->hw);
+
+	spin_unlock_irqrestore(&cc->cc_lock, flags);
+}
+
+bool cc33xx_is_queue_stopped_by_reason(struct cc33xx *cc,
+				       struct cc33xx_vif *wlvif, u8 queue,
+				       enum cc33xx_queue_stop_reason reason)
+{
+	unsigned long flags;
+	bool stopped;
+
+	spin_lock_irqsave(&cc->cc_lock, flags);
+	stopped = cc33xx_is_queue_stopped_by_reason_locked(cc, wlvif, queue,
+							   reason);
+	spin_unlock_irqrestore(&cc->cc_lock, flags);
+
+	return stopped;
+}
+
+bool cc33xx_is_queue_stopped_by_reason_locked(struct cc33xx *cc,
+					      struct cc33xx_vif *wlvif, u8 queue,
+				       enum cc33xx_queue_stop_reason reason)
+{
+	int hwq = cc33xx_tx_get_mac80211_queue(wlvif, queue);
+
+	assert_spin_locked(&cc->cc_lock);
+	return test_bit(reason, &cc->queue_stop_reasons[hwq]);
+}
+
+bool cc33xx_is_queue_stopped_locked(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+				    u8 queue)
+{
+	int hwq = cc33xx_tx_get_mac80211_queue(wlvif, queue);
+
+	assert_spin_locked(&cc->cc_lock);
+	return !!cc->queue_stop_reasons[hwq];
+}
+
+static void cc33xx_tx_complete_packet(struct cc33xx *cc, u8 tx_stat_byte,
+				      struct core_fw_status *core_fw_status)
+{
+	struct ieee80211_tx_info *info;
+	struct sk_buff *skb;
+	int id = tx_stat_byte & CC33XX_TX_STATUS_DESC_ID_MASK;
+	bool tx_success;
+	struct cc33xx_tx_hw_descr *tx_desc;
+	u16 desc_session_idx;
+
+	/* check for id legality */
+	if (unlikely(id >= CC33XX_NUM_TX_DESCRIPTORS ||
+		     !cc->tx_frames[id])) {
+		cc33xx_warning("illegal id in tx completion: %d", id);
+
+		print_hex_dump(KERN_DEBUG, "fw_info local:",
+			       DUMP_PREFIX_OFFSET, 16, 4, (u8 *)(core_fw_status),
+			       sizeof(struct core_fw_status), false);
+
+		cc33xx_queue_recovery_work(cc);
+		return;
+	}
+
+	/* a zero bit indicates Tx success */
+	tx_success = !(tx_stat_byte & BIT(CC33XX_TX_STATUS_STAT_BIT_IDX));
+
+	skb = cc->tx_frames[id];
+	info = IEEE80211_SKB_CB(skb);
+	tx_desc = (struct cc33xx_tx_hw_descr *)skb->data;
+
+	if (cc33xx_is_dummy_packet(cc, skb)) {
+		cc33xx_free_tx_id(cc, id);
+		return;
+	}
+
+	/* update the TX status info */
+	if (tx_success && !(info->flags & IEEE80211_TX_CTL_NO_ACK))
+		info->flags |= IEEE80211_TX_STAT_ACK;
+
+	info->status.rates[0].count = 1; /* no data about retries */
+	info->status.ack_signal = -1;
+
+	if (!tx_success)
+		cc->stats.retry_count++;
+
+	/* remove private header from packet */
+	skb_pull(skb, sizeof(struct cc33xx_tx_hw_descr));
+
+	/* remove TKIP header space if present */
+	if ((cc->quirks & CC33XX_QUIRK_TKIP_HEADER_SPACE) &&
+	    info->control.hw_key &&
+	    info->control.hw_key->cipher == WLAN_CIPHER_SUITE_TKIP) {
+		int hdrlen = ieee80211_get_hdrlen_from_skb(skb);
+
+		memmove(skb->data + CC33XX_EXTRA_SPACE_TKIP, skb->data, hdrlen);
+		skb_pull(skb, CC33XX_EXTRA_SPACE_TKIP);
+	}
+
+	cc33xx_debug(DEBUG_TX,
+		     "tx status id %u skb 0x%p success %d, tx_memblocks %d",
+		     id, skb, tx_success, tx_desc->cc33xx_mem.total_mem_blocks);
+
+	/**
+	 * in order to update the memory management
+	 * we should have total_blocks, ac, and hlid
+	 */
+	cc->tx_blocks_available += tx_desc->cc33xx_mem.total_mem_blocks;
+	cc->tx_allocated_blocks -= tx_desc->cc33xx_mem.total_mem_blocks;
+	/* per queue */
+
+	/* prevent wrap-around in freed-packets counter */
+	cc->tx_allocated_pkts[tx_desc->ac]--;
+
+	/* per link */
+	desc_session_idx = (le16_to_cpu(tx_desc->tx_attr) & TX_HW_ATTR_SESSION_COUNTER) >>
+					TX_HW_ATTR_OFST_SESSION_COUNTER;
+
+	if (cc->session_ids[tx_desc->hlid] == desc_session_idx)
+		cc->links[tx_desc->hlid].allocated_pkts--;
+
+	cc33xx_free_tx_id(cc, id);
+
+	/* new mem blocks are available now */
+	clear_bit(CC33XX_FLAG_FW_TX_BUSY, &cc->flags);
+
+	/* return the packet to the stack */
+	skb_queue_tail(&cc->deferred_tx_queue, skb);
+	queue_work(cc->freezable_wq, &cc->netstack_work);
+}
+
+void cc33xx_tx_immediate_complete(struct cc33xx *cc)
+{
+	u8 tx_result_queue_index;
+	struct core_fw_status core_fw_status;
+	u8 i;
+
+	claim_core_status_lock(cc);
+	memcpy(&core_fw_status, &cc->core_status->fw_info,
+	       sizeof(struct core_fw_status));
+
+	tx_result_queue_index = cc->core_status->fw_info.tx_result_queue_index;
+	/* Lock guarantees we shadow tx_result_queue_index NOT during
+	 * an active transaction. Subsequent references to fw_info can be done
+	 * without locking as long we do not pass this index.
+	 */
+	release_core_status_lock(cc);
+
+	cc33xx_debug(DEBUG_TX, "last released desc = %d, current idx = %d",
+		     cc->last_fw_rls_idx, tx_result_queue_index);
+
+	/* nothing to do here */
+	if (cc->last_fw_rls_idx == tx_result_queue_index)
+		return;
+
+	/* freed Tx descriptors */
+
+	if (tx_result_queue_index >= TX_RESULT_QUEUE_SIZE) {
+		cc33xx_error("invalid desc release index %d",
+			     tx_result_queue_index);
+		WARN_ON(1);
+		return;
+	}
+
+	cc33xx_debug(DEBUG_TX, "TX result queue! priv last fw idx %d, current resut index %d ",
+		     cc->last_fw_rls_idx, tx_result_queue_index);
+
+	for (i = cc->last_fw_rls_idx; i != tx_result_queue_index;
+	     i = (i + 1) % TX_RESULT_QUEUE_SIZE) {
+		cc33xx_tx_complete_packet(cc, core_fw_status.tx_result_queue[i],
+					  &core_fw_status);
+	}
+
+	cc->last_fw_rls_idx = tx_result_queue_index;
+}
diff --git a/drivers/net/wireless/ti/cc33xx/tx.h b/drivers/net/wireless/ti/cc33xx/tx.h
new file mode 100644
index 000000000000..9062d50c7c8e
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/tx.h
@@ -0,0 +1,160 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __TX_H__
+#define __TX_H__
+
+#define CC33XX_TX_HW_BLOCK_SPARE        1
+/* for special cases - namely, TKIP and GEM */
+#define CC33XX_TX_HW_EXTRA_BLOCK_SPARE  2
+#define CC33XX_TX_HW_BLOCK_SIZE         256
+
+#define CC33XX_TX_STATUS_DESC_ID_MASK    0x7F
+#define CC33XX_TX_STATUS_STAT_BIT_IDX    7
+
+/* Indicates this TX HW frame is not padded to SDIO block size */
+#define CC33XX_TX_CTRL_NOT_PADDED	BIT(7)
+
+#define TX_HW_MGMT_PKT_LIFETIME_TU       2000
+#define TX_HW_AP_MODE_PKT_LIFETIME_TU    8000
+
+#define TX_HW_ATTR_SESSION_COUNTER       (BIT(2) | BIT(3) | BIT(4))
+#define TX_HW_ATTR_TX_DUMMY_REQ          BIT(13)
+#define TX_HW_ATTR_HOST_ENCRYPT          BIT(14)
+#define TX_HW_ATTR_EAPOL_FRAME           BIT(15)
+
+#define TX_HW_ATTR_OFST_SESSION_COUNTER  2
+#define TX_HW_ATTR_OFST_RATE_POLICY      5
+
+#define CC33XX_TX_ALIGN_TO 4
+#define CC33XX_EXTRA_SPACE_TKIP 4
+#define CC33XX_EXTRA_SPACE_AES  8
+#define CC33XX_EXTRA_SPACE_MAX  8
+
+#define CC33XX_TX_EXTRA_HEADROOM	\
+		(sizeof(struct cc33xx_tx_hw_descr) + IEEE80211_HT_CTL_LEN)
+
+/* Used for management frames and dummy packets */
+#define CC33XX_TID_MGMT 7
+
+/* stop a ROC for pending authentication reply after this time (ms) */
+#define CC33XX_PEND_AUTH_ROC_TIMEOUT     1000
+#define CC33xx_PEND_ROC_COMPLETE_TIMEOUT 2000
+
+struct cc33xx_tx_mem {
+	/* Total number of memory blocks allocated by the host for
+	 * this packet.
+	 */
+	u8 total_mem_blocks;
+
+	/* control bits
+	 */
+	u8 ctrl;
+} __packed;
+
+/* On cc33xx based devices, when TX packets are aggregated, each packet
+ * size must be aligned to the SDIO block size. The maximum block size
+ * is bounded by the type of the padded bytes field that is sent to the
+ * FW. The HW maximum block size is 256 bytes. We use 128 to utilize the
+ * SDIO built-in busy signal when the FIFO is full.
+ */
+#define CC33XX_BUS_BLOCK_SIZE 128
+
+struct cc33xx_tx_hw_descr {
+	/* Length of packet in words, including descriptor+header+data */
+	__le16 length;
+
+	struct cc33xx_tx_mem cc33xx_mem;
+
+	/* Packet identifier used also in the Tx-Result. */
+	u8 id;
+	/* The packet TID value (as User-Priority) */
+	u8 tid;
+	/* host link ID (HLID) */
+	u8 hlid;
+	u8 ac;
+	/* Max delay in TUs until transmission. The last device time the
+	 * packet can be transmitted is: start_time + (1024 * life_time)
+	 */
+	__le16 life_time;
+	/* Bitwise fields - see TX_ATTR... definitions above. */
+	__le16 tx_attr;
+} __packed;
+
+struct cc33xx_tx_hw_res_descr {
+	/* Packet Identifier - same value used in the Tx descriptor.*/
+	u8 id;
+	/* The status of the transmission, indicating success or one of
+	 * several possible reasons for failure.
+	 */
+	u8 status;
+	/* Total air access duration including all retrys and overheads.*/
+	__le16 medium_usage;
+	/* The time passed from host xfer to Tx-complete.*/
+	__le32 fw_handling_time;
+	/* Total media delay
+	 * (from 1st EDCA AIFS counter until TX Complete).
+	 */
+	__le32 medium_delay;
+	/* LS-byte of last TKIP seq-num (saved per AC for recovery). */
+	u8 tx_security_sequence_number_lsb;
+	/* Retry count - number of transmissions without successful ACK.*/
+	u8 ack_failures;
+	/* The rate that succeeded getting ACK
+	 * (Valid only if status=SUCCESS).
+	 */
+	u8 rate_class_index;
+	/* for 4-byte alignment. */
+	u8 spare;
+} __packed;
+
+enum cc33xx_queue_stop_reason {
+	CC33XX_QUEUE_STOP_REASON_WATERMARK,
+	CC33XX_QUEUE_STOP_REASON_FW_RESTART,
+	CC33XX_QUEUE_STOP_REASON_FLUSH,
+	CC33XX_QUEUE_STOP_REASON_SPARE_BLK, /* 18xx specific */
+};
+
+int cc33xx_tx_get_queue(int queue);
+int cc33xx_tx_total_queue_count(struct cc33xx *cc);
+void cc33xx_tx_immediate_complete(struct cc33xx *cc);
+void cc33xx_tx_work(struct work_struct *work);
+int cc33xx_tx_work_locked(struct cc33xx *cc);
+void cc33xx_tx_reset_wlvif(struct cc33xx *cc, struct cc33xx_vif *wlvif);
+void cc33xx_tx_reset(struct cc33xx *cc);
+void cc33xx_tx_flush(struct cc33xx *cc);
+u8 cc33xx_rate_to_idx(struct cc33xx *cc, u8 rate, enum nl80211_band band);
+u32 cc33xx_tx_enabled_rates_get(struct cc33xx *cc, u32 rate_set,
+				enum nl80211_band rate_band);
+u32 cc33xx_tx_min_rate_get(struct cc33xx *cc, u32 rate_set);
+u8 cc33xx_tx_get_hlid(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+		      struct sk_buff *skb, struct ieee80211_sta *sta);
+void cc33xx_tx_reset_link_queues(struct cc33xx *cc, u8 hlid);
+void cc33xx_handle_tx_low_watermark(struct cc33xx *cc);
+bool cc33xx_is_dummy_packet(struct cc33xx *cc, struct sk_buff *skb);
+unsigned int cc33xx_calc_packet_alignment(struct cc33xx *cc,
+					  unsigned int packet_length);
+void cc33xx_free_tx_id(struct cc33xx *cc, int id);
+void cc33xx_stop_queue_locked(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			      u8 queue, enum cc33xx_queue_stop_reason reason);
+void cc33xx_stop_queues(struct cc33xx *cc,
+			enum cc33xx_queue_stop_reason reason);
+void cc33xx_wake_queues(struct cc33xx *cc,
+			enum cc33xx_queue_stop_reason reason);
+bool cc33xx_is_queue_stopped_by_reason(struct cc33xx *cc,
+				       struct cc33xx_vif *wlvif, u8 queue,
+				       enum cc33xx_queue_stop_reason reason);
+bool cc33xx_is_queue_stopped_by_reason_locked(struct cc33xx *cc,
+					      struct cc33xx_vif *wlvif,
+					      u8 queue,
+					 enum cc33xx_queue_stop_reason reason);
+bool cc33xx_is_queue_stopped_locked(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+				    u8 queue);
+
+/* from main.c */
+void cc33xx_free_sta(struct cc33xx *cc, struct cc33xx_vif *wlvif, u8 hlid);
+void cc33xx_rearm_tx_watchdog_locked(struct cc33xx *cc);
+
+#endif /* __TX_H__ */
-- 
2.34.1


