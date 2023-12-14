Return-Path: <linux-wireless+bounces-803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A1B8135DA
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 17:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A817B280D3A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 16:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513775F1CB;
	Thu, 14 Dec 2023 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="X3hKb6j2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB13E8
	for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 08:11:44 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:5fd0:0:640:c018:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTP id 9E032608EC;
	Thu, 14 Dec 2023 19:11:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id cBn4ZU2oC8c0-vn7KXgFA;
	Thu, 14 Dec 2023 19:11:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1702570299; bh=eweHmgBioIFJJexKo6SFBXsSDqMcp0t/sPuw1XRCL+o=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=X3hKb6j2el7jKBA9Bk0BlKUMQk+f6pl7HVdQHzGWXmMbMbGHVxPW5I6D2aXq8em2D
	 G5gDyYW/lAXjY621n06fFW/HgZXA5vSL9ZKi1ildGkzeXkJAA7Yk4yXfYcmfzo/RmP
	 DOPQ7NvML24RONLuN1JzU5/fJ4hYRo4dH5h9IoCs=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath11k: refactor ath11k_wmi_tlv_parse_alloc()
Date: Thu, 14 Dec 2023 19:11:14 +0300
Message-ID: <20231214161117.75145-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'ath11k_wmi_tlv_parse_alloc()' always operates on
'skb->data, skb->len' tuple, it may be simplified to pass
the only 'skb' argument instead (which also implies
refactoring of 'ath11k_pull_bcn_tx_status_ev()' and
'ath11k_pull_chan_info_ev()' in the same way). Compile
tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath11k/testmode.c |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.c      | 73 +++++++++++-----------
 drivers/net/wireless/ath/ath11k/wmi.h      |  4 +-
 3 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
index 43bb23265d34..302d66092b97 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.c
+++ b/drivers/net/wireless/ath/ath11k/testmode.c
@@ -198,7 +198,7 @@ static void ath11k_tm_wmi_event_segmented(struct ath11k_base *ab, u32 cmd_id,
 	u16 length;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse ftm event tlv: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 2845b4313d3a..ef2c8ad22fb3 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -238,8 +238,8 @@ static int ath11k_wmi_tlv_parse(struct ath11k_base *ar, const void **tb,
 				   (void *)tb);
 }
 
-const void **ath11k_wmi_tlv_parse_alloc(struct ath11k_base *ab, const void *ptr,
-					size_t len, gfp_t gfp)
+const void **ath11k_wmi_tlv_parse_alloc(struct ath11k_base *ab,
+					struct sk_buff *skb, gfp_t gfp)
 {
 	const void **tb;
 	int ret;
@@ -248,7 +248,7 @@ const void **ath11k_wmi_tlv_parse_alloc(struct ath11k_base *ab, const void *ptr,
 	if (!tb)
 		return ERR_PTR(-ENOMEM);
 
-	ret = ath11k_wmi_tlv_parse(ab, tb, ptr, len);
+	ret = ath11k_wmi_tlv_parse(ab, tb, skb->data, skb->len);
 	if (ret) {
 		kfree(tb);
 		return ERR_PTR(ret);
@@ -3930,7 +3930,7 @@ ath11k_wmi_obss_color_collision_event(struct ath11k_base *ab, struct sk_buff *sk
 	struct ath11k_vif *arvif;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5003,7 +5003,7 @@ static int ath11k_pull_vdev_start_resp_tlv(struct ath11k_base *ab, struct sk_buf
 	const struct wmi_vdev_start_resp_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5102,7 +5102,7 @@ static int ath11k_pull_reg_chan_list_update_ev(struct ath11k_base *ab,
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI, "processing regulatory channel list\n");
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5278,7 +5278,7 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI, "processing regulatory ext channel list\n");
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5634,7 +5634,7 @@ static int ath11k_pull_peer_del_resp_ev(struct ath11k_base *ab, struct sk_buff *
 	const struct wmi_peer_delete_resp_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5666,7 +5666,7 @@ static int ath11k_pull_vdev_del_resp_ev(struct ath11k_base *ab,
 	const struct wmi_vdev_delete_resp_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5686,15 +5686,15 @@ static int ath11k_pull_vdev_del_resp_ev(struct ath11k_base *ab,
 	return 0;
 }
 
-static int ath11k_pull_bcn_tx_status_ev(struct ath11k_base *ab, void *evt_buf,
-					u32 len, u32 *vdev_id,
-					u32 *tx_status)
+static int ath11k_pull_bcn_tx_status_ev(struct ath11k_base *ab,
+					struct sk_buff *skb,
+					u32 *vdev_id, u32 *tx_status)
 {
 	const void **tb;
 	const struct wmi_bcn_tx_status_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, evt_buf, len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5722,7 +5722,7 @@ static int ath11k_pull_vdev_stopped_param_tlv(struct ath11k_base *ab, struct sk_
 	const struct wmi_vdev_stopped_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5876,7 +5876,7 @@ static int ath11k_pull_mgmt_tx_compl_param_tlv(struct ath11k_base *ab,
 	const struct wmi_mgmt_tx_compl_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6052,7 +6052,7 @@ static int ath11k_pull_scan_ev(struct ath11k_base *ab, struct sk_buff *skb,
 	const struct wmi_scan_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6085,7 +6085,7 @@ static int ath11k_pull_peer_sta_kickout_ev(struct ath11k_base *ab, struct sk_buf
 	const struct wmi_peer_sta_kickout_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6112,7 +6112,7 @@ static int ath11k_pull_roam_ev(struct ath11k_base *ab, struct sk_buff *skb,
 	const struct wmi_roam_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6153,14 +6153,14 @@ static int freq_to_idx(struct ath11k *ar, int freq)
 	return idx;
 }
 
-static int ath11k_pull_chan_info_ev(struct ath11k_base *ab, u8 *evt_buf,
-				    u32 len, struct wmi_chan_info_event *ch_info_ev)
+static int ath11k_pull_chan_info_ev(struct ath11k_base *ab, struct sk_buff *skb,
+				    struct wmi_chan_info_event *ch_info_ev)
 {
 	const void **tb;
 	const struct wmi_chan_info_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, evt_buf, len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6199,7 +6199,7 @@ ath11k_pull_pdev_bss_chan_info_ev(struct ath11k_base *ab, struct sk_buff *skb,
 	const struct wmi_pdev_bss_chan_info_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6239,7 +6239,7 @@ ath11k_pull_vdev_install_key_compl_ev(struct ath11k_base *ab, struct sk_buff *sk
 	const struct wmi_vdev_install_key_compl_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6270,7 +6270,7 @@ static int ath11k_pull_peer_assoc_conf_ev(struct ath11k_base *ab, struct sk_buff
 	const struct wmi_peer_assoc_conf_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6995,7 +6995,7 @@ static int ath11k_reg_11d_new_cc_event(struct ath11k_base *ab, struct sk_buff *s
 	const void **tb;
 	int ret, i;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -7384,8 +7384,7 @@ static void ath11k_bcn_tx_status_event(struct ath11k_base *ab, struct sk_buff *s
 	struct ath11k_vif *arvif;
 	u32 vdev_id, tx_status;
 
-	if (ath11k_pull_bcn_tx_status_ev(ab, skb->data, skb->len,
-					 &vdev_id, &tx_status) != 0) {
+	if (ath11k_pull_bcn_tx_status_ev(ab, skb, &vdev_id, &tx_status) != 0) {
 		ath11k_warn(ab, "failed to extract bcn tx status");
 		return;
 	}
@@ -7416,7 +7415,7 @@ static void ath11k_wmi_event_peer_sta_ps_state_chg(struct ath11k_base *ab,
 	enum ath11k_wmi_peer_ps_state peer_previous_ps_state;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -7884,7 +7883,7 @@ static void ath11k_chan_info_event(struct ath11k_base *ab, struct sk_buff *skb)
 	/* HW channel counters frequency value in hertz */
 	u32 cc_freq_hz = ab->cc_freq_hz;
 
-	if (ath11k_pull_chan_info_ev(ab, skb->data, skb->len, &ch_info_ev) != 0) {
+	if (ath11k_pull_chan_info_ev(ab, skb, &ch_info_ev) != 0) {
 		ath11k_warn(ab, "failed to extract chan info event");
 		return;
 	}
@@ -8216,7 +8215,7 @@ static void ath11k_pdev_ctl_failsafe_check_event(struct ath11k_base *ab,
 	const struct wmi_pdev_ctl_failsafe_chk_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -8281,7 +8280,7 @@ ath11k_wmi_pdev_csa_switch_count_status_event(struct ath11k_base *ab,
 	const u32 *vdev_ids;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -8315,7 +8314,7 @@ ath11k_wmi_pdev_dfs_radar_detected_event(struct ath11k_base *ab, struct sk_buff
 	struct ath11k *ar;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -8369,7 +8368,7 @@ ath11k_wmi_pdev_temperature_event(struct ath11k_base *ab,
 	const struct wmi_pdev_temperature_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -8409,7 +8408,7 @@ static void ath11k_fils_discovery_event(struct ath11k_base *ab,
 	const struct wmi_fils_discovery_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab,
@@ -8441,7 +8440,7 @@ static void ath11k_probe_resp_tx_status_event(struct ath11k_base *ab,
 	const struct wmi_probe_resp_tx_status_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab,
@@ -8567,7 +8566,7 @@ static void ath11k_wmi_twt_add_dialog_event(struct ath11k_base *ab,
 	const struct wmi_twt_add_dialog_event *ev;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab,
@@ -8604,7 +8603,7 @@ static void ath11k_wmi_gtk_offload_status_event(struct ath11k_base *ab,
 	u64    replay_ctr;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 100bb816b592..b1c05e802da3 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -6320,8 +6320,8 @@ enum wmi_sta_keepalive_method {
 #define WMI_STA_KEEPALIVE_INTERVAL_DEFAULT	30
 #define WMI_STA_KEEPALIVE_INTERVAL_DISABLE	0
 
-const void **ath11k_wmi_tlv_parse_alloc(struct ath11k_base *ab, const void *ptr,
-					size_t len, gfp_t gfp);
+const void **ath11k_wmi_tlv_parse_alloc(struct ath11k_base *ab,
+					struct sk_buff *skb, gfp_t gfp);
 int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 			u32 cmd_id);
 struct sk_buff *ath11k_wmi_alloc_skb(struct ath11k_wmi_base *wmi_sc, u32 len);
-- 
2.43.0


