Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F620FC536
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 12:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfKNLTv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 06:19:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33928 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfKNLTv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 06:19:51 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C63D360A66; Thu, 14 Nov 2019 11:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573730389;
        bh=xmIppeEheL2alWVMG9pBL8KjNpw3Ay3LNGssvQnvSQY=;
        h=From:To:Cc:Subject:Date:From;
        b=oENFyCqFx5+hUKbHQEZNXXbisRFDIecOhbKG0MzBIQk3fm3A7ZJpdWanJLmeB6ixe
         NX2NyITT7tjmOw+Gk7YPxSYjqGs4j8he2T4zue9R2WCQlXmLgUkBdPHLgD1QmzLK+T
         jWl8SjTr86uoqxFfaVU+rD0POh+VVJFOZ1krFeks=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B47A6039D;
        Thu, 14 Nov 2019 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573730388;
        bh=xmIppeEheL2alWVMG9pBL8KjNpw3Ay3LNGssvQnvSQY=;
        h=From:To:Cc:Subject:Date:From;
        b=Agl0z2I9Gf6fjIPiSPn5q40OESRbW7Wf7VRq41nW20qB7xgu7Sy1V1yHbzOHAY/Lm
         Kawx9HetTm5eamvmKI8xl4Y4rQbufaJWV+BO8SGlEdkH6DP6V133VWcqo7oMNyevep
         5jiPlR5i+e6IbAEJiff7J0TC4Gk7pOPp1OOUrleI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B47A6039D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: report rssi of each chain to mac80211 for sdio
Date:   Thu, 14 Nov 2019 19:19:31 +0800
Message-Id: <20191114111931.27800-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

iw command only show rssi without each chain's rssi on sdio
iw wlan0 station dump
Station a0:40:a0:93:3e:de (on wlan0)
signal:         -82 dBm
signal avg:     -82 dBm

after this patch, it will show each chain's rssi on sdio
Station a0:40:a0:93:3e:de (on wlan0)
signal:         -82 [-84, -88] dBm
signal avg:     -82 [-84, -87] dBm

For QCA6174 PCIe, the ppdu have the correct rssi of each chain, it
indicate rssi of rx data by ath10k_htt_rx_h_signal. For sdio chip, the
rssi of each chain stored in rx management reported by firmware, the
ath10k_wmi_tlv_op_pull_mgmt_rx_ev which used for tlv wmi will get the
rssi of each chain and stored them in wmi_mgmt_rx_ev_arg, then indicate
them to mac80211. For non-tlv wmi chip, it will not get the rssi of each
chain and not indicate to mac80211, for non-tlv wmi chip, this patch will
not have impact. For tlv wmi chip, if the rssi of chain in mgmt is valid,
it will be indicate to mac80211, tested with QCA6174 PCIe/SDIO, the rssi
of 2 chain in mgmt is valid.

rssi of chains in mgmt of QCA6174 SDIO:
92096.652780: ath10k:ath10k_log_warn: ath10k_sdio mmc1:0001:1 rssi[0]:70
92096.657324: ath10k:ath10k_log_warn: ath10k_sdio mmc1:0001:1 rssi[1]:68
92096.662009: ath10k:ath10k_log_warn: ath10k_sdio mmc1:0001:1 rssi[2]:128
92096.666647: ath10k:ath10k_log_warn: ath10k_sdio mmc1:0001:1 rssi[3]:128

rssi of chains in mgmt of QCA6174 PCIe:
[ 1581.049816] ath10k_pci 0000:02:00.0: mgmt rssi[0]:17
[ 1581.049818] ath10k_pci 0000:02:00.0: mgmt rssi[1]:22
[ 1581.049821] ath10k_pci 0000:02:00.0: mgmt rssi[2]:128
[ 1581.049823] ath10k_pci 0000:02:00.0: mgmt rssi[3]:128

after apply this patch, the iw's rssi of PCIe do not changed, result is
same with before.

iw wlan0 station dump of QCA6174 PCIe:
Station 6c:e8:73:b8:92:dc (on wlan0)
        signal:         -70 [-77, -72] dBm
        signal avg:     -69 [-78, -72] dBm

iw wlan-5000mhz station dump of QCA9984 PCIe
connected with 2 client which has 2 chain:
Station 70:48:0f:1f:1a:b2 (on wlan-5000mhz)
        signal:         -47 [-55, -48, -87, -88] dBm
        signal avg:     -42 [-50, -43, -83, -86] dBm
Station ac:c1:ee:39:e3:83 (on wlan-5000mhz)
        signal:         -43 [-46, -45, -79, -84] dBm
        signal avg:     -43 [-46, -46, -82, -83] dBm

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00017-QCARMSWP-1.
Tested with QCA6174 PCIe with firmware WLAN.RM.4.4.1-00110-QCARMSWP-1.
Tested with QCA9984 PCIe with firmware 10.4-3.9.0.2-00040.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c  |  1 -
 drivers/net/wireless/ath/ath10k/wmi-tlv.c |  5 ++++-
 drivers/net/wireless/ath/ath10k/wmi.c     | 18 ++++++++++++++++--
 drivers/net/wireless/ath/ath10k/wmi.h     |  2 ++
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index d95b63f133ab..941c8e6a4f45 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -2236,7 +2236,6 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 	hdr = (struct ieee80211_hdr *)skb->data;
 	qos = ieee80211_is_data_qos(hdr->frame_control);
 	rx_status = IEEE80211_SKB_RXCB(skb);
-	rx_status->chains |= BIT(0);
 	if (rx->ppdu.combined_rssi == 0) {
 		/* SDIO firmware does not provide signal */
 		rx_status->signal = 0;
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 69a1ec53df29..213d02e7981f 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -841,7 +841,7 @@ static int ath10k_wmi_tlv_op_pull_mgmt_rx_ev(struct ath10k *ar,
 	const struct wmi_tlv_mgmt_rx_ev *ev;
 	const u8 *frame;
 	u32 msdu_len;
-	int ret;
+	int ret, i;
 
 	tb = ath10k_wmi_tlv_parse_alloc(ar, skb->data, skb->len, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
@@ -865,6 +865,9 @@ static int ath10k_wmi_tlv_op_pull_mgmt_rx_ev(struct ath10k *ar,
 	arg->phy_mode = ev->phy_mode;
 	arg->rate = ev->rate;
 
+	for (i = 0; i < ARRAY_SIZE(ev->rssi); i++)
+		arg->rssi[i] = ev->rssi[i];
+
 	msdu_len = __le32_to_cpu(arg->buf_len);
 
 	if (skb->len < (frame - skb->data) + msdu_len) {
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 9f564e2b7a14..13f7531d945d 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -2463,10 +2463,10 @@ int ath10k_wmi_event_mgmt_rx(struct ath10k *ar, struct sk_buff *skb)
 	u32 rx_status;
 	u32 channel;
 	u32 phy_mode;
-	u32 snr;
+	u32 snr, rssi;
 	u32 rate;
 	u16 fc;
-	int ret;
+	int ret, i;
 
 	ret = ath10k_wmi_pull_mgmt_rx(ar, skb, &arg);
 	if (ret) {
@@ -2525,6 +2525,20 @@ int ath10k_wmi_event_mgmt_rx(struct ath10k *ar, struct sk_buff *skb)
 
 	status->freq = ieee80211_channel_to_frequency(channel, status->band);
 	status->signal = snr + ATH10K_DEFAULT_NOISE_FLOOR;
+
+	BUILD_BUG_ON(ARRAY_SIZE(status->chain_signal) != ARRAY_SIZE(arg.rssi));
+
+	for (i = 0; i < ARRAY_SIZE(status->chain_signal); i++) {
+		status->chains &= ~BIT(i);
+		rssi = __le32_to_cpu(arg.rssi[i]);
+		ath10k_dbg(ar, ATH10K_DBG_MGMT, "mgmt rssi[%d]:%d\n", i, arg.rssi[i]);
+
+		if (rssi != ATH10K_INVALID_RSSI && rssi != 0) {
+			status->chain_signal[i] = ATH10K_DEFAULT_NOISE_FLOOR + rssi;
+			status->chains |= BIT(i);
+		}
+	}
+
 	status->rate_idx = ath10k_mac_bitrate_to_idx(sband, rate / 100);
 
 	hdr = (struct ieee80211_hdr *)skb->data;
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 74adce1dd3a9..972d53d77654 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -6786,6 +6786,7 @@ struct wmi_peer_delete_resp_ev_arg {
 	struct wmi_mac_addr peer_addr;
 };
 
+#define WMI_MGMT_RX_NUM_RSSI 4
 struct wmi_mgmt_rx_ev_arg {
 	__le32 channel;
 	__le32 snr;
@@ -6794,6 +6795,7 @@ struct wmi_mgmt_rx_ev_arg {
 	__le32 buf_len;
 	__le32 status; /* %WMI_RX_STATUS_ */
 	struct wmi_mgmt_rx_ext_info ext_info;
+	__le32 rssi[WMI_MGMT_RX_NUM_RSSI];
 };
 
 struct wmi_ch_info_ev_arg {
-- 
2.23.0

