Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FDD1AB454
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2020 01:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgDOXiN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 19:38:13 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:64281 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729994AbgDOXiK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 19:38:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586993886; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=HKTakO+PiEVXg5Smi0dPiRo8ZMvXYE4ZWxQcQPgnpsU=; b=j6yBP8hE/1weDhsMbXfw261PEHX2PPuaKlHT7T5RF1iPvCPkZTXCU7vHXLprv73TjBVeS1MQ
 sNAntEg7tMlJtMqmLD7PRA9RDR/NF2IGpVlUgo7ldenCke55wBY9cGaL2LueAB3D8SWOwyHe
 u5hUFAdztR4kSpoOijx0LrwGq+E=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e979ad8.7f9ddc35d298-smtp-out-n01;
 Wed, 15 Apr 2020 23:38:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9E962C432C2; Wed, 15 Apr 2020 23:37:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 69D44C433CB;
        Wed, 15 Apr 2020 23:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69D44C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH] ath10k: add flush tx packets for SDIO chip
Date:   Thu, 16 Apr 2020 07:37:30 +0800
Message-Id: <20200415233730.10581-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When station connected to AP, and run TX traffic such as TCP/UDP, and
system enter suspend state, then mac80211 call ath10k_flush with set
drop flag, recently it only send wmi peer flush to firmware and
firmware will flush all pending TX packets, for PCIe, firmware will
indicate the TX packets status to ath10k, and then ath10k indicate to
mac80211 TX complete with the status, then all the packets has been
flushed at this moment. For SDIO chip, it is different, its TX
complete indication is disabled by default, and it has a tx queue in
ath10k, and its tx credit control is enabled, total tx credit is 96,
when its credit is not sufficient, then the packets will buffered in
the tx queue of ath10k, max packets is TARGET_TLV_NUM_MSDU_DESC_HL
which is 1024, for SDIO, when mac80211 call ath10k_flush with set drop
flag, maybe it have pending packets in tx queue of ath10k, and if it
does not have sufficient tx credit, the packets will stay in queue
untill tx credit report from firmware, if it is a noisy environment,
tx speed is low and the tx credit report from firmware will delay more
time, then the num_pending_tx will remain > 0 untill all packets send
to firmware. After the 1st ath10k_flush, mac80211 will call the 2nd
ath10k_flush without set drop flag immediately, then it will call to
ath10k_mac_wait_tx_complete, and it wait untill num_pending_tx become
to 0, in noisy environment, it is esay to wait about near 5 seconds,
then it cause the suspend take long time.

1st and 2nd callstack of ath10k_flush
[  303.740427] ath10k_sdio mmc1:0001:1: ath10k_flush drop:1, pending:0-0
[  303.740495] ------------[ cut here ]------------
[  303.740739] WARNING: CPU: 1 PID: 3921 at /mnt/host/source/src/third_party/kernel/v4.19/drivers/net/wireless/ath/ath10k/mac.c:7025 ath10k_flush+0x54/0x104 [ath10k_core]
[  303.740757] Modules linked in: bridge stp llc ath10k_sdio ath10k_core rfcomm uinput cros_ec_rpmsg mtk_seninf mtk_cam_isp mtk_vcodec_enc mtk_fd mtk_vcodec_dec mtk_vcodec_common mtk_dip mtk_mdp3 videobuf2_dma_contig videobuf2_memops v4l2_mem2mem videobuf2_v4l2 videobuf2_common hid_google_hammer hci_uart btqca bluetooth dw9768 ov8856 ecdh_generic ov02a10 v4l2_fwnode mtk_scp mtk_rpmsg rpmsg_core mtk_scp_ipi ipt_MASQUERADE fuse iio_trig_sysfs cros_ec_sensors_ring cros_ec_sensors_sync cros_ec_light_prox cros_ec_sensors industrialio_triggered_buffer
[  303.740914]  kfifo_buf cros_ec_activity cros_ec_sensors_core lzo_rle lzo_compress ath mac80211 zram cfg80211 joydev [last unloaded: ath10k_core]
[  303.741009] CPU: 1 PID: 3921 Comm: kworker/u16:10 Tainted: G        W         4.19.95 #2
[  303.741027] Hardware name: MediaTek krane sku176 board (DT)
[  303.741061] Workqueue: events_unbound async_run_entry_fn
[  303.741086] pstate: 60000005 (nZCv daif -PAN -UAO)
[  303.741166] pc : ath10k_flush+0x54/0x104 [ath10k_core]
[  303.741244] lr : ath10k_flush+0x54/0x104 [ath10k_core]
[  303.741260] sp : ffffffdf080e77a0
[  303.741276] x29: ffffffdf080e77a0 x28: ffffffdef3730040
[  303.741300] x27: ffffff907c2240a0 x26: ffffffde6ff39afc
[  303.741321] x25: ffffffdef3730040 x24: ffffff907bf61018
[  303.741343] x23: ffffff907c2240a0 x22: ffffffde6ff39a50
[  303.741364] x21: 0000000000000001 x20: ffffffde6ff39a50
[  303.741385] x19: ffffffde6bac2420 x18: 0000000000017200
[  303.741407] x17: ffffff907c24a000 x16: 0000000000000037
[  303.741428] x15: ffffff907b49a568 x14: ffffff907cf332c1
[  303.741476] x13: 00000000000922e4 x12: 0000000000000000
[  303.741497] x11: 0000000000000001 x10: 0000000000000007
[  303.741518] x9 : f2256b8c1de4bc00 x8 : f2256b8c1de4bc00
[  303.741539] x7 : ffffff907ab5e764 x6 : 0000000000000000
[  303.741560] x5 : 0000000000000080 x4 : 0000000000000001
[  303.741582] x3 : ffffffdf080e74a8 x2 : ffffff907aa91244
[  303.741603] x1 : ffffffdf080e74a8 x0 : 0000000000000024
[  303.741624] Call trace:
[  303.741701]  ath10k_flush+0x54/0x104 [ath10k_core]
[  303.741941]  __ieee80211_flush_queues+0x1dc/0x358 [mac80211]
[  303.742098]  ieee80211_flush_queues+0x34/0x44 [mac80211]
[  303.742253]  ieee80211_set_disassoc+0xc0/0x5ec [mac80211]
[  303.742399]  ieee80211_mgd_deauth+0x720/0x7d4 [mac80211]
[  303.742535]  ieee80211_deauth+0x24/0x30 [mac80211]
[  303.742720]  cfg80211_mlme_deauth+0x250/0x3bc [cfg80211]
[  303.742849]  cfg80211_mlme_down+0x90/0xd0 [cfg80211]
[  303.742971]  cfg80211_disconnect+0x340/0x3a0 [cfg80211]
[  303.743087]  __cfg80211_leave+0xe4/0x17c [cfg80211]
[  303.743203]  cfg80211_leave+0x38/0x50 [cfg80211]
[  303.743319]  wiphy_suspend+0x84/0x5bc [cfg80211]
[  303.743335]  dpm_run_callback+0x170/0x304
[  303.743346]  __device_suspend+0x2dc/0x3e8
[  303.743356]  async_suspend+0x2c/0xb0
[  303.743370]  async_run_entry_fn+0x48/0xf8
[  303.743383]  process_one_work+0x304/0x604
[  303.743394]  worker_thread+0x248/0x3f4
[  303.743403]  kthread+0x120/0x130
[  303.743416]  ret_from_fork+0x10/0x18

[  303.743812] ath10k_sdio mmc1:0001:1: ath10k_flush drop:0, pending:0-0
[  303.743858] ------------[ cut here ]------------
[  303.744057] WARNING: CPU: 1 PID: 3921 at /mnt/host/source/src/third_party/kernel/v4.19/drivers/net/wireless/ath/ath10k/mac.c:7025 ath10k_flush+0x54/0x104 [ath10k_core]
[  303.744075] Modules linked in: bridge stp llc ath10k_sdio ath10k_core rfcomm uinput cros_ec_rpmsg mtk_seninf mtk_cam_isp mtk_vcodec_enc mtk_fd mtk_vcodec_dec mtk_vcodec_common mtk_dip mtk_mdp3 videobuf2_dma_contig videobuf2_memops v4l2_mem2mem videobuf2_v4l2 videobuf2_common hid_google_hammer hci_uart btqca bluetooth dw9768 ov8856 ecdh_generic ov02a10 v4l2_fwnode mtk_scp mtk_rpmsg rpmsg_core mtk_scp_ipi ipt_MASQUERADE fuse iio_trig_sysfs cros_ec_sensors_ring cros_ec_sensors_sync cros_ec_light_prox cros_ec_sensors industrialio_triggered_buffer kfifo_buf cros_ec_activity cros_ec_sensors_core lzo_rle lzo_compress ath mac80211 zram cfg80211 joydev [last unloaded: ath10k_core]
[  303.744256] CPU: 1 PID: 3921 Comm: kworker/u16:10 Tainted: G        W         4.19.95 #2
[  303.744273] Hardware name: MediaTek krane sku176 board (DT)
[  303.744301] Workqueue: events_unbound async_run_entry_fn
[  303.744325] pstate: 60000005 (nZCv daif -PAN -UAO)
[  303.744403] pc : ath10k_flush+0x54/0x104 [ath10k_core]
[  303.744480] lr : ath10k_flush+0x54/0x104 [ath10k_core]
[  303.744496] sp : ffffffdf080e77a0
[  303.744512] x29: ffffffdf080e77a0 x28: ffffffdef3730040
[  303.744534] x27: ffffff907c2240a0 x26: ffffffde6ff39afc
[  303.744556] x25: ffffffdef3730040 x24: ffffff907bf61018
[  303.744577] x23: ffffff907c2240a0 x22: ffffffde6ff39a50
[  303.744598] x21: 0000000000000000 x20: ffffffde6ff39a50
[  303.744620] x19: ffffffde6bac2420 x18: 000000000001831c
[  303.744641] x17: ffffff907c24a000 x16: 0000000000000037
[  303.744662] x15: ffffff907b49a568 x14: ffffff907cf332c1
[  303.744683] x13: 00000000000922ea x12: 0000000000000000
[  303.744704] x11: 0000000000000001 x10: 0000000000000007
[  303.744747] x9 : f2256b8c1de4bc00 x8 : f2256b8c1de4bc00
[  303.744768] x7 : ffffff907ab5e764 x6 : 0000000000000000
[  303.744789] x5 : 0000000000000080 x4 : 0000000000000001
[  303.744810] x3 : ffffffdf080e74a8 x2 : ffffff907aa91244
[  303.744831] x1 : ffffffdf080e74a8 x0 : 0000000000000024
[  303.744853] Call trace:
[  303.744929]  ath10k_flush+0x54/0x104 [ath10k_core]
[  303.745098]  __ieee80211_flush_queues+0x1dc/0x358 [mac80211]
[  303.745277]  ieee80211_flush_queues+0x34/0x44 [mac80211]
[  303.745424]  ieee80211_set_disassoc+0x108/0x5ec [mac80211]
[  303.745569]  ieee80211_mgd_deauth+0x720/0x7d4 [mac80211]
[  303.745706]  ieee80211_deauth+0x24/0x30 [mac80211]
[  303.745853]  cfg80211_mlme_deauth+0x250/0x3bc [cfg80211]
[  303.745979]  cfg80211_mlme_down+0x90/0xd0 [cfg80211]
[  303.746103]  cfg80211_disconnect+0x340/0x3a0 [cfg80211]
[  303.746219]  __cfg80211_leave+0xe4/0x17c [cfg80211]
[  303.746335]  cfg80211_leave+0x38/0x50 [cfg80211]
[  303.746452]  wiphy_suspend+0x84/0x5bc [cfg80211]
[  303.746467]  dpm_run_callback+0x170/0x304
[  303.746477]  __device_suspend+0x2dc/0x3e8
[  303.746487]  async_suspend+0x2c/0xb0
[  303.746498]  async_run_entry_fn+0x48/0xf8
[  303.746510]  process_one_work+0x304/0x604
[  303.746521]  worker_thread+0x248/0x3f4
[  303.746530]  kthread+0x120/0x130
[  303.746542]  ret_from_fork+0x10/0x18

one sample's debugging log: it wait 3190 ms(5000 - 1810).

1st ath10k_flush, it has 120 packets in tx queue of ath10k:
<...>-1513  [000] .... 25374.786005: ath10k_log_err: ath10k_sdio mmc1:0001:1 ath10k_flush drop:1, pending:120-0
<...>-1513  [000] ...1 25374.788375: ath10k_log_warn: ath10k_sdio mmc1:0001:1 ath10k_htt_tx_mgmt_inc_pending htt->num_pending_mgmt_tx:0
<...>-1500  [001] .... 25374.790143: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx work, eid:1, count:121

2st ath10k_flush, it has 121 packets in tx queue of ath10k:
<...>-1513  [000] .... 25374.790571: ath10k_log_err: ath10k_sdio mmc1:0001:1 ath10k_flush drop:0, pending:121-0
<...>-1513  [000] .... 25374.791990: ath10k_log_err: ath10k_sdio mmc1:0001:1 ath10k_mac_wait_tx_complete state:1 pending:121-0
<...>-1508  [001] .... 25374.792696: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 credit update: delta:46
<...>-1508  [001] .... 25374.792700: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 credit total:46
<...>-1508  [001] .... 25374.792729: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx work, eid:1, count:121
<...>-1508  [001] .... 25374.792937: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx status:0, eid:1, req count:88, count:32, len:49792
<...>-1508  [001] .... 25374.793031: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx status:0, eid:1, req count:75, count:14, len:21784
kworker/u16:0-25773 [003] .... 25374.793701: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx complete, eid:1, pending complete count:46
<...>-1881  [000] .... 25375.073178: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 credit update: delta:24
<...>-1881  [000] .... 25375.073182: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 credit total:24
<...>-1881  [000] .... 25375.073429: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx work, eid:1, count:75
<...>-1879  [001] .... 25375.074090: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx complete, eid:1, pending complete count:24
<...>-1881  [000] .... 25375.074123: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx status:0, eid:1, req count:51, count:24, len:37344
<...>-1879  [001] .... 25375.270126: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 credit update: delta:26
<...>-1879  [001] .... 25375.270130: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 credit total:26
<...>-1488  [000] .... 25375.270174: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx work, eid:1, count:51
<...>-1488  [000] .... 25375.270529: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx status:0, eid:1, req count:25, count:26, len:40456
<...>-1879  [001] .... 25375.270693: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx complete, eid:1, pending complete count:26
<...>-1488  [001] .... 25377.775885: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 credit update: delta:12
<...>-1488  [001] .... 25377.775890: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 credit total:12
<...>-1488  [001] .... 25377.775933: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx work, eid:1, count:25
<...>-1488  [001] .... 25377.776059: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx status:0, eid:1, req count:13, count:12, len:18672
<...>-1879  [001] .... 25377.776100: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx complete, eid:1, pending complete count:12
<...>-1488  [001] .... 25377.878079: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 credit update: delta:15
<...>-1488  [001] .... 25377.878087: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 credit total:15
<...>-1879  [000] .... 25377.878323: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx work, eid:1, count:13
<...>-1879  [000] .... 25377.878487: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx status:0, eid:1, req count:0, count:13, len:20228
<...>-1879  [000] .... 25377.878497: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx complete, eid:1, pending complete count:13
<...>-1488  [001] .... 25377.919927: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 credit update: delta:11
<...>-1488  [001] .... 25377.919932: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 credit total:13
<...>-1488  [001] .... 25377.919976: ath10k_log_dbg: ath10k_sdio mmc1:0001:1 bundle tx work, eid:1, count:0
<...>-1881  [000] .... 25377.982645: ath10k_log_warn: ath10k_sdio mmc1:0001:1 HTT_T2H_MSG_TYPE_MGMT_TX_COMPLETION status:0
<...>-1513  [001] .... 25377.982973: ath10k_log_err: ath10k_sdio mmc1:0001:1 ath10k_mac_wait_tx_complete time_left:1810, pending:0-0

Flush all pending TX packets for the 1st ath10k_flush reduced the wait
time of the 2nd ath10k_flush and then suspend take short time.

This Patch only effect SDIO chips.

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00042.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
this depends on patches: "ath10k: improve throughout of TX of sdio"
 drivers/net/wireless/ath/ath10k/htt.h    | 7 +++++++
 drivers/net/wireless/ath/ath10k/htt_tx.c | 8 +++++++-
 drivers/net/wireless/ath/ath10k/mac.c    | 1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
index 3c2096d0766b..1628312701c3 100644
--- a/drivers/net/wireless/ath/ath10k/htt.h
+++ b/drivers/net/wireless/ath/ath10k/htt.h
@@ -2079,6 +2079,7 @@ struct ath10k_htt_tx_ops {
 	int (*htt_h2t_aggr_cfg_msg)(struct ath10k_htt *htt,
 				    u8 max_subfrms_ampdu,
 				    u8 max_subfrms_amsdu);
+	void (*htt_flush_tx)(struct ath10k_htt *htt);
 };
 
 static inline int ath10k_htt_send_rx_ring_cfg(struct ath10k_htt *htt)
@@ -2118,6 +2119,12 @@ static inline int ath10k_htt_tx(struct ath10k_htt *htt,
 	return htt->tx_ops->htt_tx(htt, txmode, msdu);
 }
 
+static inline void ath10k_htt_flush_tx(struct ath10k_htt *htt)
+{
+	if (htt->tx_ops->htt_flush_tx)
+		htt->tx_ops->htt_flush_tx(htt);
+}
+
 static inline int ath10k_htt_alloc_txbuff(struct ath10k_htt *htt)
 {
 	if (!htt->tx_ops->htt_alloc_txbuff)
diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index 0beb73aecaac..53185e34c9e5 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -529,10 +529,15 @@ void ath10k_htt_tx_destroy(struct ath10k_htt *htt)
 	htt->tx_mem_allocated = false;
 }
 
-void ath10k_htt_tx_stop(struct ath10k_htt *htt)
+static void ath10k_htt_flush_tx_queue(struct ath10k_htt *htt)
 {
 	ath10k_htc_stop_hl(htt->ar);
 	idr_for_each(&htt->pending_tx, ath10k_htt_tx_clean_up_pending, htt->ar);
+}
+
+void ath10k_htt_tx_stop(struct ath10k_htt *htt)
+{
+	ath10k_htt_flush_tx_queue(htt);
 	idr_destroy(&htt->pending_tx);
 }
 
@@ -1815,6 +1820,7 @@ static const struct ath10k_htt_tx_ops htt_tx_ops_hl = {
 	.htt_send_frag_desc_bank_cfg = ath10k_htt_send_frag_desc_bank_cfg_32,
 	.htt_tx = ath10k_htt_tx_hl,
 	.htt_h2t_aggr_cfg_msg = ath10k_htt_h2t_aggr_cfg_msg_32,
+	.htt_flush_tx = ath10k_htt_flush_tx_queue,
 };
 
 void ath10k_htt_set_tx_ops(struct ath10k_htt *htt)
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 3856edba7915..82bc07f863a3 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -7173,6 +7173,7 @@ static void ath10k_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 					ath10k_wmi_peer_flush(ar, arvif->vdev_id,
 							      arvif->bssid, bitmap);
 			}
+			ath10k_htt_flush_tx(&ar->htt);
 		}
 		return;
 	}
-- 
2.23.0
