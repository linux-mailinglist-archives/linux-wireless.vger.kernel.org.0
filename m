Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D574D11339A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 19:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfLDSSC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 13:18:02 -0500
Received: from nbd.name ([46.4.11.11]:40936 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731784AbfLDSSA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 13:18:00 -0500
Received: from p5dcfb666.dip0.t-ipconnect.de ([93.207.182.102] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1icZDm-0005Od-Cr; Wed, 04 Dec 2019 19:17:54 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 4/9] ath11k: rename ath11k_wmi_base instances from wmi_sc to wmi_ab
Date:   Wed,  4 Dec 2019 19:17:40 +0100
Message-Id: <20191204181745.27297-5-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191204181745.27297-1-john@phrozen.org>
References: <20191204181745.27297-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This makes the code consistent with the recent sc to ab rename.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/core.c     |   4 +-
 drivers/net/wireless/ath/ath11k/core.h     |   2 +-
 drivers/net/wireless/ath/ath11k/htc.c      |   2 +-
 drivers/net/wireless/ath/ath11k/mac.c      |   4 +-
 drivers/net/wireless/ath/ath11k/testmode.c |   2 +-
 drivers/net/wireless/ath/ath11k/wmi.c      | 146 ++++++++++-----------
 drivers/net/wireless/ath/ath11k/wmi.h      |   2 +-
 7 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 5cdc9b2aee51..9e823056e673 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -651,7 +651,7 @@ static void ath11k_core_restart(struct work_struct *work)
 		idr_destroy(&ar->txmgmt_idr);
 	}
 
-	wake_up(&ab->wmi_sc.tx_credits_wq);
+	wake_up(&ab->wmi_ab.tx_credits_wq);
 	wake_up(&ab->peer_mapping_wq);
 
 	ret = ath11k_core_reconfigure_on_crash(ab);
@@ -761,7 +761,7 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev)
 
 	INIT_LIST_HEAD(&ab->peers);
 	init_waitqueue_head(&ab->peer_mapping_wq);
-	init_waitqueue_head(&ab->wmi_sc.tx_credits_wq);
+	init_waitqueue_head(&ab->wmi_ab.tx_credits_wq);
 	INIT_WORK(&ab->restart_work, ath11k_core_restart);
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
 	ab->dev = dev;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 06482a5c102d..25cdcf71d0c4 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -578,7 +578,7 @@ struct ath11k_base {
 	struct platform_device *pdev;
 	struct device *dev;
 	struct ath11k_qmi qmi;
-	struct ath11k_wmi_base wmi_sc;
+	struct ath11k_wmi_base wmi_ab;
 	struct completion fw_ready;
 	struct rproc *tgt_rproc;
 	int num_radios;
diff --git a/drivers/net/wireless/ath/ath11k/htc.c b/drivers/net/wireless/ath/ath11k/htc.c
index 9d4115f25ceb..8f54f58b83e6 100644
--- a/drivers/net/wireless/ath/ath11k/htc.c
+++ b/drivers/net/wireless/ath/ath11k/htc.c
@@ -736,7 +736,7 @@ int ath11k_htc_init(struct ath11k_base *ab)
 
 	htc->ab = ab;
 
-	switch (ab->wmi_sc.preferred_hw_mode) {
+	switch (ab->wmi_ab.preferred_hw_mode) {
 	case WMI_HOST_HW_MODE_SINGLE:
 		htc->wmi_ep_count = 1;
 		break;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index d9b4c95019e5..a2c8a52b8621 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5245,7 +5245,7 @@ ath11k_mac_update_bss_chan_survey(struct ath11k *ar,
 
 	lockdep_assert_held(&ar->conf_mutex);
 
-	if (!test_bit(WMI_TLV_SERVICE_BSS_CHANNEL_INFO_64, ar->ab->wmi_sc.svc_map) ||
+	if (!test_bit(WMI_TLV_SERVICE_BSS_CHANNEL_INFO_64, ar->ab->wmi_ab.svc_map) ||
 	    ar->rx_channel != channel)
 		return;
 
@@ -5763,7 +5763,7 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 		ar->pdev_idx = i;
 		ar->lmac_id = ath11k_core_get_hw_mac_id(ab, i);
 
-		ar->wmi = &ab->wmi_sc.wmi[i];
+		ar->wmi = &ab->wmi_ab.wmi[i];
 		/* FIXME wmi[0] is already initialized during attach,
 		 * Should we do this again?
 		 */
diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
index 932bee6d1740..d2dc9db01491 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.c
+++ b/drivers/net/wireless/ath/ath11k/testmode.c
@@ -150,7 +150,7 @@ static int ath11k_tm_cmd_wmi(struct ath11k *ar, struct nlattr *tb[])
 
 	ath11k_dbg_dump(ar->ab, ATH11K_DBG_TESTMODE, NULL, "", buf, buf_len);
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, buf_len);
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, buf_len);
 	if (!skb) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index bf3c246ce883..b16bfb50d73e 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -205,7 +205,7 @@ static int ath11k_wmi_cmd_send_nowait(struct ath11k_pdev_wmi *wmi, struct sk_buf
 				      u32 cmd_id)
 {
 	struct ath11k_skb_cb *skb_cb = ATH11K_SKB_CB(skb);
-	struct ath11k_base *ab = wmi->wmi_sc->ab;
+	struct ath11k_base *ab = wmi->wmi_ab->ab;
 	struct wmi_cmd_hdr *cmd_hdr;
 	int ret;
 	u32 cmd = 0;
@@ -234,7 +234,7 @@ static int ath11k_wmi_cmd_send_nowait(struct ath11k_pdev_wmi *wmi, struct sk_buf
 int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 			u32 cmd_id)
 {
-	struct ath11k_wmi_base *wmi_sc = wmi->wmi_sc;
+	struct ath11k_wmi_base *wmi_sc = wmi->wmi_ab;
 	int ret = -EOPNOTSUPP;
 
 	might_sleep();
@@ -448,7 +448,7 @@ static void ath11k_wmi_service_bitmap_copy(struct ath11k_pdev_wmi *wmi,
 	for (i = 0, j = 0; i < WMI_SERVICE_BM_SIZE && j < WMI_MAX_SERVICE; i++) {
 		do {
 			if (wmi_svc_bm[i] & BIT(j % WMI_SERVICE_BITS_IN_SIZE32))
-				set_bit(j, wmi->wmi_sc->svc_map);
+				set_bit(j, wmi->wmi_ab->svc_map);
 		} while (++j % WMI_SERVICE_BITS_IN_SIZE32);
 	}
 }
@@ -457,7 +457,7 @@ static int ath11k_wmi_tlv_svc_rdy_parse(struct ath11k_base *ab, u16 tag, u16 len
 					const void *ptr, void *data)
 {
 	struct wmi_tlv_svc_ready_parse *svc_ready = data;
-	struct ath11k_pdev_wmi *wmi_handle = &ab->wmi_sc.wmi[0];
+	struct ath11k_pdev_wmi *wmi_handle = &ab->wmi_ab.wmi[0];
 	u16 expect_len;
 
 	switch (tag) {
@@ -538,7 +538,7 @@ int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
 
 	len = sizeof(*cmd) + sizeof(*frame_tlv) + roundup(buf_len, 4);
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -590,7 +590,7 @@ int ath11k_wmi_vdev_create(struct ath11k *ar, u8 *macaddr,
 	len = sizeof(*cmd) + TLV_HDR_SIZE +
 		(WMI_NUM_SUPPORTED_BAND_MAX * sizeof(*txrx_streams));
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -656,7 +656,7 @@ int ath11k_wmi_vdev_delete(struct ath11k *ar, u8 vdev_id)
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -683,7 +683,7 @@ int ath11k_wmi_vdev_stop(struct ath11k *ar, u8 vdev_id)
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -711,7 +711,7 @@ int ath11k_wmi_vdev_down(struct ath11k *ar, u8 vdev_id)
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -789,7 +789,7 @@ int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 
 	len = sizeof(*cmd) + sizeof(*chan) + TLV_HDR_SIZE;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -867,7 +867,7 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -901,7 +901,7 @@ int ath11k_wmi_send_peer_create_cmd(struct ath11k *ar,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -934,7 +934,7 @@ int ath11k_wmi_send_peer_delete_cmd(struct ath11k *ar,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -966,7 +966,7 @@ int ath11k_wmi_send_pdev_set_regdomain(struct ath11k *ar,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -1006,7 +1006,7 @@ int ath11k_wmi_set_peer_param(struct ath11k *ar, const u8 *peer_addr,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -1040,7 +1040,7 @@ int ath11k_wmi_send_peer_flush_tids_cmd(struct ath11k *ar,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -1076,7 +1076,7 @@ int ath11k_wmi_peer_rx_reorder_queue_setup(struct ath11k *ar,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -1118,7 +1118,7 @@ ath11k_wmi_rx_reord_queue_remove(struct ath11k *ar,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -1154,7 +1154,7 @@ int ath11k_wmi_pdev_set_param(struct ath11k *ar, u32 param_id,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -1185,7 +1185,7 @@ int ath11k_wmi_pdev_set_ps_mode(struct ath11k *ar, int vdev_id, u32 enable)
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -1216,7 +1216,7 @@ int ath11k_wmi_pdev_suspend(struct ath11k *ar, u32 suspend_opt,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -1247,7 +1247,7 @@ int ath11k_wmi_pdev_resume(struct ath11k *ar, u32 pdev_id)
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -1281,7 +1281,7 @@ int ath11k_wmi_pdev_bss_chan_info_request(struct ath11k *ar,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -1314,7 +1314,7 @@ int ath11k_wmi_send_set_ap_ps_param_cmd(struct ath11k *ar, u8 *peer_addr,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -1349,7 +1349,7 @@ int ath11k_wmi_set_sta_ps_param(struct ath11k *ar, u32 vdev_id,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -1384,7 +1384,7 @@ int ath11k_wmi_force_fw_hang_cmd(struct ath11k *ar, u32 type, u32 delay_time_ms)
 
 	len = sizeof(*cmd);
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -1412,7 +1412,7 @@ int ath11k_wmi_vdev_set_param_cmd(struct ath11k *ar, u32 vdev_id,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -1446,7 +1446,7 @@ int ath11k_wmi_send_stats_request_cmd(struct ath11k *ar,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -1479,7 +1479,7 @@ int ath11k_wmi_send_bcn_offload_control_cmd(struct ath11k *ar,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -1520,7 +1520,7 @@ int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 
 	len = sizeof(*cmd) + sizeof(*bcn_prb_info) + TLV_HDR_SIZE + aligned_len;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -1571,7 +1571,7 @@ int ath11k_wmi_vdev_install_key(struct ath11k *ar,
 
 	len = sizeof(*cmd) + TLV_HDR_SIZE + key_len_aligned;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -1717,7 +1717,7 @@ int ath11k_wmi_send_peer_assoc_cmd(struct ath11k *ar,
 	      sizeof(*mcs) + TLV_HDR_SIZE +
 	      (sizeof(*he_mcs) * param->peer_he_mcs_count);
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -1983,7 +1983,7 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 			roundup(params->extraie.len, sizeof(u32));
 	len += extraie_len_with_pad;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -2099,7 +2099,7 @@ int ath11k_wmi_send_scan_stop_cmd(struct ath11k *ar,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -2155,7 +2155,7 @@ int ath11k_wmi_send_scan_chan_list_cmd(struct ath11k *ar,
 	len = sizeof(*cmd) + TLV_HDR_SIZE +
 		 sizeof(*chan_info) * chan_list->nallchans;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -2247,7 +2247,7 @@ int ath11k_wmi_send_wmm_update_cmd_tlv(struct ath11k *ar, u32 vdev_id,
 	struct sk_buff *skb;
 	int ret, ac;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -2314,7 +2314,7 @@ int ath11k_wmi_send_dfs_phyerr_offload_enable_cmd(struct ath11k *ar,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -2351,7 +2351,7 @@ int ath11k_wmi_pdev_peer_pktlog_filter(struct ath11k *ar, u8 *addr, u8 enable)
 	int ret, len;
 
 	len = sizeof(*cmd) + sizeof(*info) + TLV_HDR_SIZE;
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -2397,7 +2397,7 @@ ath11k_wmi_send_init_country_cmd(struct ath11k *ar,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -2449,7 +2449,7 @@ int ath11k_wmi_pdev_pktlog_enable(struct ath11k *ar, u32 pktlog_filter)
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -2479,7 +2479,7 @@ int ath11k_wmi_pdev_pktlog_disable(struct ath11k *ar)
 	struct sk_buff *skb;
 	int ret;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
 
@@ -2504,14 +2504,14 @@ int
 ath11k_wmi_send_twt_enable_cmd(struct ath11k *ar, u32 pdev_id)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
-	struct ath11k_base *ab = wmi->wmi_sc->ab;
+	struct ath11k_base *ab = wmi->wmi_ab->ab;
 	struct wmi_twt_enable_params_cmd *cmd;
 	struct sk_buff *skb;
 	int ret, len;
 
 	len = sizeof(*cmd);
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -2555,14 +2555,14 @@ int
 ath11k_wmi_send_twt_disable_cmd(struct ath11k *ar, u32 pdev_id)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
-	struct ath11k_base *ab = wmi->wmi_sc->ab;
+	struct ath11k_base *ab = wmi->wmi_ab->ab;
 	struct wmi_twt_disable_params_cmd *cmd;
 	struct sk_buff *skb;
 	int ret, len;
 
 	len = sizeof(*cmd);
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -2585,14 +2585,14 @@ ath11k_wmi_send_obss_spr_cmd(struct ath11k *ar, u32 vdev_id,
 			     struct ieee80211_he_obss_pd *he_obss_pd)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
-	struct ath11k_base *ab = wmi->wmi_sc->ab;
+	struct ath11k_base *ab = wmi->wmi_ab->ab;
 	struct wmi_obss_spatial_reuse_params_cmd *cmd;
 	struct sk_buff *skb;
 	int ret, len;
 
 	len = sizeof(*cmd);
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -2714,7 +2714,7 @@ ath11k_wmi_copy_resource_config(struct wmi_resource_config *wmi_cfg,
 static int ath11k_init_cmd_send(struct ath11k_pdev_wmi *wmi,
 				struct wmi_init_cmd_param *param)
 {
-	struct ath11k_base *ab = wmi->wmi_sc->ab;
+	struct ath11k_base *ab = wmi->wmi_ab->ab;
 	struct sk_buff *skb;
 	struct wmi_init_cmd *cmd;
 	struct wmi_resource_config *cfg;
@@ -2734,7 +2734,7 @@ static int ath11k_init_cmd_send(struct ath11k_pdev_wmi *wmi,
 	len = sizeof(*cmd) + TLV_HDR_SIZE + sizeof(*cfg) + hw_mode_len +
 	      (sizeof(*host_mem_chunks) * WMI_MAX_MEM_REQS);
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -2829,7 +2829,7 @@ int ath11k_wmi_wait_for_service_ready(struct ath11k_base *ab)
 {
 	unsigned long time_left;
 
-	time_left = wait_for_completion_timeout(&ab->wmi_sc.service_ready,
+	time_left = wait_for_completion_timeout(&ab->wmi_ab.service_ready,
 						WMI_SERVICE_READY_TIMEOUT_HZ);
 	if (!time_left)
 		return -ETIMEDOUT;
@@ -2841,7 +2841,7 @@ int ath11k_wmi_wait_for_unified_ready(struct ath11k_base *ab)
 {
 	unsigned long time_left;
 
-	time_left = wait_for_completion_timeout(&ab->wmi_sc.unified_ready,
+	time_left = wait_for_completion_timeout(&ab->wmi_ab.unified_ready,
 						WMI_SERVICE_READY_TIMEOUT_HZ);
 	if (!time_left)
 		return -ETIMEDOUT;
@@ -2851,7 +2851,7 @@ int ath11k_wmi_wait_for_unified_ready(struct ath11k_base *ab)
 
 int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 {
-	struct ath11k_wmi_base *wmi_sc = &ab->wmi_sc;
+	struct ath11k_wmi_base *wmi_sc = &ab->wmi_ab;
 	struct wmi_init_cmd_param init_param;
 	struct target_resource_config  config;
 
@@ -2971,16 +2971,16 @@ static int ath11k_wmi_tlv_hw_mode_caps(struct ath11k_base *soc,
 	while (i < svc_rdy_ext->n_hw_mode_caps) {
 		hw_mode_caps = &svc_rdy_ext->hw_mode_caps[i];
 		mode = hw_mode_caps->hw_mode_id;
-		pref = soc->wmi_sc.preferred_hw_mode;
+		pref = soc->wmi_ab.preferred_hw_mode;
 
 		if (ath11k_hw_mode_pri_map[mode] < ath11k_hw_mode_pri_map[pref]) {
 			svc_rdy_ext->pref_hw_mode_caps = *hw_mode_caps;
-			soc->wmi_sc.preferred_hw_mode = mode;
+			soc->wmi_ab.preferred_hw_mode = mode;
 		}
 		i++;
 	}
 
-	if (soc->wmi_sc.preferred_hw_mode == WMI_HOST_HW_MODE_MAX)
+	if (soc->wmi_ab.preferred_hw_mode == WMI_HOST_HW_MODE_MAX)
 		return -EINVAL;
 
 	return 0;
@@ -3030,7 +3030,7 @@ static int ath11k_wmi_tlv_ext_hal_reg_caps_parse(struct ath11k_base *soc,
 static int ath11k_wmi_tlv_ext_hal_reg_caps(struct ath11k_base *soc,
 					   u16 len, const void *ptr, void *data)
 {
-	struct ath11k_pdev_wmi *wmi_handle = &soc->wmi_sc.wmi[0];
+	struct ath11k_pdev_wmi *wmi_handle = &soc->wmi_ab.wmi[0];
 	struct wmi_tlv_svc_rdy_ext_parse *svc_rdy_ext = data;
 	struct ath11k_hal_reg_capabilities_ext reg_cap;
 	int ret;
@@ -3066,7 +3066,7 @@ static int ath11k_wmi_tlv_ext_soc_hal_reg_caps_parse(struct ath11k_base *soc,
 						     u16 len, const void *ptr,
 						     void *data)
 {
-	struct ath11k_pdev_wmi *wmi_handle = &soc->wmi_sc.wmi[0];
+	struct ath11k_pdev_wmi *wmi_handle = &soc->wmi_ab.wmi[0];
 	struct wmi_tlv_svc_rdy_ext_parse *svc_rdy_ext = data;
 	u8 hw_mode_id = svc_rdy_ext->pref_hw_mode_caps.hw_mode_id;
 	u32 phy_id_map;
@@ -3104,7 +3104,7 @@ static int ath11k_wmi_tlv_svc_rdy_ext_parse(struct ath11k_base *ab,
 					    u16 tag, u16 len,
 					    const void *ptr, void *data)
 {
-	struct ath11k_pdev_wmi *wmi_handle = &ab->wmi_sc.wmi[0];
+	struct ath11k_pdev_wmi *wmi_handle = &ab->wmi_ab.wmi[0];
 	struct wmi_tlv_svc_rdy_ext_parse *svc_rdy_ext = data;
 	int ret;
 
@@ -3156,7 +3156,7 @@ static int ath11k_wmi_tlv_svc_rdy_ext_parse(struct ath11k_base *ab,
 				return ret;
 
 			svc_rdy_ext->ext_hal_reg_done = true;
-			complete(&ab->wmi_sc.service_ready);
+			complete(&ab->wmi_ab.service_ready);
 		}
 		break;
 
@@ -4498,7 +4498,7 @@ void ath11k_wmi_fw_stats_fill(struct ath11k *ar,
 static void ath11k_wmi_op_ep_tx_credits(struct ath11k_base *ab)
 {
 	/* try to send pending beacons first. they take priority */
-	wake_up(&ab->wmi_sc.tx_credits_wq);
+	wake_up(&ab->wmi_ab.tx_credits_wq);
 }
 
 static void ath11k_wmi_htc_tx_complete(struct ath11k_base *ab,
@@ -4668,7 +4668,7 @@ static int ath11k_ready_event(struct ath11k_base *ab, struct sk_buff *skb)
 		return ret;
 	}
 
-	complete(&ab->wmi_sc.unified_ready);
+	complete(&ab->wmi_ab.unified_ready);
 	return 0;
 }
 
@@ -5319,7 +5319,7 @@ static void ath11k_service_available_event(struct ath11k_base *ab, struct sk_buf
 		do {
 			if (ev->wmi_service_segment_bitmap[i] &
 			    BIT(j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32))
-				set_bit(j, ab->wmi_sc.svc_map);
+				set_bit(j, ab->wmi_ab.svc_map);
 		} while (++j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32);
 	}
 
@@ -5639,9 +5639,9 @@ static int ath11k_connect_pdev_htc_service(struct ath11k_base *ab,
 		return status;
 	}
 
-	ab->wmi_sc.wmi_endpoint_id[pdev_idx] = conn_resp.eid;
-	ab->wmi_sc.wmi[pdev_idx].eid = conn_resp.eid;
-	ab->wmi_sc.max_msg_len[pdev_idx] = conn_resp.max_msg_len;
+	ab->wmi_ab.wmi_endpoint_id[pdev_idx] = conn_resp.eid;
+	ab->wmi_ab.wmi[pdev_idx].eid = conn_resp.eid;
+	ab->wmi_ab.max_msg_len[pdev_idx] = conn_resp.max_msg_len;
 
 	return 0;
 }
@@ -5664,7 +5664,7 @@ ath11k_wmi_send_unit_test_cmd(struct ath11k *ar,
 	arg_len = sizeof(u32) * ut_cmd.num_args;
 	buf_len = sizeof(ut_cmd) + arg_len + TLV_HDR_SIZE;
 
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, buf_len);
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, buf_len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -5771,11 +5771,11 @@ int ath11k_wmi_pdev_attach(struct ath11k_base *ab,
 	if (pdev_id >= MAX_RADIOS)
 		return -EINVAL;
 
-	wmi_handle = &ab->wmi_sc.wmi[pdev_id];
+	wmi_handle = &ab->wmi_ab.wmi[pdev_id];
 
-	wmi_handle->wmi_sc = &ab->wmi_sc;
+	wmi_handle->wmi_ab = &ab->wmi_ab;
 
-	ab->wmi_sc.ab = ab;
+	ab->wmi_ab.ab = ab;
 	/* TODO: Init remaining resource specific to pdev */
 
 	return 0;
@@ -5789,12 +5789,12 @@ int ath11k_wmi_attach(struct ath11k_base *ab)
 	if (ret)
 		return ret;
 
-	ab->wmi_sc.ab = ab;
-	ab->wmi_sc.preferred_hw_mode = WMI_HOST_HW_MODE_MAX;
+	ab->wmi_ab.ab = ab;
+	ab->wmi_ab.preferred_hw_mode = WMI_HOST_HW_MODE_MAX;
 
 	/* TODO: Init remaining wmi soc resources required */
-	init_completion(&ab->wmi_sc.service_ready);
-	init_completion(&ab->wmi_sc.unified_ready);
+	init_completion(&ab->wmi_ab.service_ready);
+	init_completion(&ab->wmi_ab.unified_ready);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 9919d8bf297b..ab983aac604b 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2354,7 +2354,7 @@ struct wmi_service_available_event {
 } __packed;
 
 struct ath11k_pdev_wmi {
-	struct ath11k_wmi_base *wmi_sc;
+	struct ath11k_wmi_base *wmi_ab;
 	enum ath11k_htc_ep_id eid;
 	const struct wmi_peer_flags_map *peer_flags;
 	u32 rx_decap_mode;
-- 
2.20.1

