Return-Path: <linux-wireless+bounces-984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215F4818443
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 10:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A5B1C23674
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 09:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C845714282;
	Tue, 19 Dec 2023 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="vU+Bac7k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward202c.mail.yandex.net (forward202c.mail.yandex.net [178.154.239.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1657D13FFB
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d102])
	by forward202c.mail.yandex.net (Yandex) with ESMTP id 4FCEA654E1
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 12:12:41 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c00:2fa5:0:640:c484:0])
	by forward102c.mail.yandex.net (Yandex) with ESMTP id 3F5C560918;
	Tue, 19 Dec 2023 12:12:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id WCImvU1oJa60-s8Vryqm7;
	Tue, 19 Dec 2023 12:12:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1702977152; bh=QN6sKgMhWcxss0dyYsHwHQY4QwUxCoexe3ak4SQ70mQ=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=vU+Bac7kUCIZ+A6tVDEvXO1VgeKHXpgSi3VtxFzDN51iASqlKoNYXkSgl/HkV7Boe
	 F/V6PajxXqaliDvHL5kYetuxjgwJBF0Fji3Q9ZUowGPKR1D7vF+XP8ZvS2T4Sc/a48
	 BLr6qvffsZpUzknhZJ3z6T67SZJ810X/NqgXadno=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath12k: refactor ath12k_wmi_tlv_parse_alloc()
Date: Tue, 19 Dec 2023 12:10:18 +0300
Message-ID: <20231219091022.70861-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'ath12k_wmi_tlv_parse_alloc()' always operates on 'skb->data,
skb->len' tuple, it may be simplified to pass the only 'skb' argument
instead (which implies refactoring of 'ath12k_pull_bcn_tx_status_ev()',
'ath12k_pull_chan_info_ev()' and 'ath12k_pull_pdev_temp_ev()' in the
same way). This is an ath12k counterpart of the recently submitted
ath11k patch and compile tested only as well.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 69 +++++++++++++--------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 11cc3005c0f9..553d2566b3f7 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -359,8 +359,8 @@ static int ath12k_wmi_tlv_parse(struct ath12k_base *ar, const void **tb,
 }
 
 static const void **
-ath12k_wmi_tlv_parse_alloc(struct ath12k_base *ab, const void *ptr,
-			   size_t len, gfp_t gfp)
+ath12k_wmi_tlv_parse_alloc(struct ath12k_base *ab,
+			   struct sk_buff *skb, gfp_t gfp)
 {
 	const void **tb;
 	int ret;
@@ -369,7 +369,7 @@ ath12k_wmi_tlv_parse_alloc(struct ath12k_base *ab, const void *ptr,
 	if (!tb)
 		return ERR_PTR(-ENOMEM);
 
-	ret = ath12k_wmi_tlv_parse(ab, tb, ptr, len);
+	ret = ath12k_wmi_tlv_parse(ab, tb, skb->data, skb->len);
 	if (ret) {
 		kfree(tb);
 		return ERR_PTR(ret);
@@ -4374,7 +4374,7 @@ static int ath12k_pull_vdev_start_resp_tlv(struct ath12k_base *ab, struct sk_buf
 	const struct wmi_vdev_start_resp_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -4452,7 +4452,7 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 
 	ath12k_dbg(ab, ATH12K_DBG_WMI, "processing regulatory ext channel list\n");
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -4738,7 +4738,7 @@ static int ath12k_pull_peer_del_resp_ev(struct ath12k_base *ab, struct sk_buff *
 	const struct wmi_peer_delete_resp_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -4770,7 +4770,7 @@ static int ath12k_pull_vdev_del_resp_ev(struct ath12k_base *ab,
 	const struct wmi_vdev_delete_resp_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -4790,15 +4790,15 @@ static int ath12k_pull_vdev_del_resp_ev(struct ath12k_base *ab,
 	return 0;
 }
 
-static int ath12k_pull_bcn_tx_status_ev(struct ath12k_base *ab, void *evt_buf,
-					u32 len, u32 *vdev_id,
-					u32 *tx_status)
+static int ath12k_pull_bcn_tx_status_ev(struct ath12k_base *ab,
+					struct sk_buff *skb,
+					u32 *vdev_id, u32 *tx_status)
 {
 	const void **tb;
 	const struct wmi_bcn_tx_status_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, evt_buf, len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -4826,7 +4826,7 @@ static int ath12k_pull_vdev_stopped_param_tlv(struct ath12k_base *ab, struct sk_
 	const struct wmi_vdev_stopped_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -4970,7 +4970,7 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(struct ath12k_base *ab,
 	const struct wmi_mgmt_tx_compl_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5141,7 +5141,7 @@ static int ath12k_pull_scan_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	const struct wmi_scan_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5174,7 +5174,7 @@ static int ath12k_pull_peer_sta_kickout_ev(struct ath12k_base *ab, struct sk_buf
 	const struct wmi_peer_sta_kickout_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5201,7 +5201,7 @@ static int ath12k_pull_roam_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	const struct wmi_roam_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5245,14 +5245,14 @@ static int freq_to_idx(struct ath12k *ar, int freq)
 	return idx;
 }
 
-static int ath12k_pull_chan_info_ev(struct ath12k_base *ab, u8 *evt_buf,
-				    u32 len, struct wmi_chan_info_event *ch_info_ev)
+static int ath12k_pull_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
+				    struct wmi_chan_info_event *ch_info_ev)
 {
 	const void **tb;
 	const struct wmi_chan_info_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, evt_buf, len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5291,7 +5291,7 @@ ath12k_pull_pdev_bss_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	const struct wmi_pdev_bss_chan_info_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5331,7 +5331,7 @@ ath12k_pull_vdev_install_key_compl_ev(struct ath12k_base *ab, struct sk_buff *sk
 	const struct wmi_vdev_install_key_compl_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5362,7 +5362,7 @@ static int ath12k_pull_peer_assoc_conf_ev(struct ath12k_base *ab, struct sk_buff
 	const struct wmi_peer_assoc_conf_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5384,13 +5384,13 @@ static int ath12k_pull_peer_assoc_conf_ev(struct ath12k_base *ab, struct sk_buff
 }
 
 static int
-ath12k_pull_pdev_temp_ev(struct ath12k_base *ab, u8 *evt_buf,
-			 u32 len, const struct wmi_pdev_temperature_event *ev)
+ath12k_pull_pdev_temp_ev(struct ath12k_base *ab, struct sk_buff *skb,
+			 const struct wmi_pdev_temperature_event *ev)
 {
 	const void **tb;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, evt_buf, len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5725,8 +5725,7 @@ static void ath12k_bcn_tx_status_event(struct ath12k_base *ab, struct sk_buff *s
 {
 	u32 vdev_id, tx_status;
 
-	if (ath12k_pull_bcn_tx_status_ev(ab, skb->data, skb->len,
-					 &vdev_id, &tx_status) != 0) {
+	if (ath12k_pull_bcn_tx_status_ev(ab, skb, &vdev_id, &tx_status) != 0) {
 		ath12k_warn(ab, "failed to extract bcn tx status");
 		return;
 	}
@@ -6110,7 +6109,7 @@ static void ath12k_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
 	/* HW channel counters frequency value in hertz */
 	u32 cc_freq_hz = ab->cc_freq_hz;
 
-	if (ath12k_pull_chan_info_ev(ab, skb->data, skb->len, &ch_info_ev) != 0) {
+	if (ath12k_pull_chan_info_ev(ab, skb, &ch_info_ev) != 0) {
 		ath12k_warn(ab, "failed to extract chan info event");
 		return;
 	}
@@ -6395,7 +6394,7 @@ static void ath12k_pdev_ctl_failsafe_check_event(struct ath12k_base *ab,
 	const struct wmi_pdev_ctl_failsafe_chk_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6460,7 +6459,7 @@ ath12k_wmi_pdev_csa_switch_count_status_event(struct ath12k_base *ab,
 	const u32 *vdev_ids;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6494,7 +6493,7 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
 	struct ath12k *ar;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6546,7 +6545,7 @@ ath12k_wmi_pdev_temperature_event(struct ath12k_base *ab,
 	struct ath12k *ar;
 	struct wmi_pdev_temperature_event ev = {0};
 
-	if (ath12k_pull_pdev_temp_ev(ab, skb->data, skb->len, &ev) != 0) {
+	if (ath12k_pull_pdev_temp_ev(ab, skb, &ev) != 0) {
 		ath12k_warn(ab, "failed to extract pdev temperature event");
 		return;
 	}
@@ -6573,7 +6572,7 @@ static void ath12k_fils_discovery_event(struct ath12k_base *ab,
 	const struct wmi_fils_discovery_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab,
@@ -6603,7 +6602,7 @@ static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
 	const struct wmi_probe_resp_tx_status_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab,
@@ -6635,7 +6634,7 @@ static void ath12k_rfkill_state_change_event(struct ath12k_base *ab,
 	const void **tb;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
-- 
2.43.0


