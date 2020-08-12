Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CB6242BD0
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 17:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHLPBr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 11:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHLPBB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 11:01:01 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE192C061386
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 08:01:00 -0700 (PDT)
Received: from [149.224.82.90] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1k5sFO-0002OP-9b; Wed, 12 Aug 2020 17:00:58 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V3 6/9] ath11k: add the multiple bssid WMI commands
Date:   Wed, 12 Aug 2020 17:00:47 +0200
Message-Id: <20200812150050.2683396-7-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812150050.2683396-1-john@phrozen.org>
References: <20200812150050.2683396-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the code to pass the BSS specific multiple bssid info to the FW.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c |  3 +++
 drivers/net/wireless/ath/ath11k/wmi.h | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 04ef73d1f032..ffe8d7b1320b 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -641,6 +641,8 @@ int ath11k_wmi_vdev_create(struct ath11k *ar, u8 *macaddr,
 	cmd->vdev_subtype = param->subtype;
 	cmd->num_cfg_txrx_streams = WMI_NUM_SUPPORTED_BAND_MAX;
 	cmd->pdev_id = param->pdev_id;
+	cmd->flags = param->flags;
+	cmd->vdevid_trans = param->vdevid_trans;
 	ether_addr_copy(cmd->vdev_macaddr.addr, macaddr);
 
 	ptr = skb->data + sizeof(*cmd);
@@ -1603,6 +1605,7 @@ int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 	cmd->csa_switch_count_offset = offs->cntdwn_counter_offs[0];
 	cmd->ext_csa_switch_count_offset = offs->cntdwn_counter_offs[1];
 	cmd->buf_len = bcn->len;
+	cmd->mbssid_ie_offset = offs->multiple_bssid_offset;
 
 	ptr = skb->data + sizeof(*cmd);
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index a2d81abf6356..ad741add1ebe 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -119,6 +119,12 @@ enum {
 	WMI_HOST_WLAN_2G_5G_CAP	= 0x3,
 };
 
+enum {
+	WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP	= 1,
+	WMI_HOST_VDEV_FLAGS_TRANSMIT_AP		= 2,
+	WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP	= 4,
+};
+
 /*
  * wmi command groups.
  */
@@ -2456,6 +2462,8 @@ struct vdev_create_params {
 		u8 rx;
 	} chains[NUM_NL80211_BANDS];
 	u32 pdev_id;
+	u32 flags;
+	u32 vdevid_trans;
 };
 
 struct wmi_vdev_create_cmd {
@@ -2466,6 +2474,8 @@ struct wmi_vdev_create_cmd {
 	struct wmi_mac_addr vdev_macaddr;
 	u32 num_cfg_txrx_streams;
 	u32 pdev_id;
+	u32 flags;
+	u32 vdevid_trans;
 } __packed;
 
 struct wmi_vdev_txrx_streams {
-- 
2.25.1

