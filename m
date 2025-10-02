Return-Path: <linux-wireless+bounces-27774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC26BB2650
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 04:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03BE1C6EB9
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 02:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9671829A2;
	Thu,  2 Oct 2025 02:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AUu9LkQx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF9B28E5
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759373185; cv=none; b=UXWZ9cyG5DMJmMpbDClsgFITT0tQ8Ps6RX1Vyy+LugMXV/r2upRdX5Wk58D0ZtrG4LZ5wHCnsjxeVRYQDLJIiMLkdQEsZz1GtyLMb4ZpuCYK6UFOrkYFnVKfaeu6LjMZuNRZkL3TOqZC6k27eIOToJJphQn1etAc4AHSpBzKoUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759373185; c=relaxed/simple;
	bh=eGVtM0iAO4uMjsGKMQ8THgXgQPcAVYFY1KwVEZTAx7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JGA9tqSm4emuk09ibqpypku+7XerK9P1AC0wC+TizAncfyGJb3373siT8MbRhS83+AcpCmQ2kVhTGa/03LU0+XY/1n/rSIEYhMNtnCoPDAiZNnuJmoeFYLEcxWpLyLh8EMMLZHt9xwQG+LL3I454iL7UxpoaziU65jEpViSf9yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AUu9LkQx; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f560a5989f3911f08d9e1119e76e3a28-20251002
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=VPDS2LIWrNMWhv2C0p1zv0OtoxHNOTWaa2kc1kOk+nk=;
	b=AUu9LkQxglRoXhjPNcCZx46xb4he3gaM26WySjOfSA6Kl86Xs4LJQzRVDPYFy6y26m5zUKbiCMav4CS4IZGuic8TflsPGgMQZuIzOsFiIldBNCFD+0wduN1g+MsH/1LANAcLdpIOp5/vCvbgQxnht7aefm9nl6ezRUI9y7n/MQo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5e33f371-b952-4279-ad7f-284607014668,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:a842276d-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f560a5989f3911f08d9e1119e76e3a28-20251002
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1525263715; Thu, 02 Oct 2025 10:46:12 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Oct 2025 10:46:09 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Thu, 2 Oct 2025 10:46:09 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Michael Lo <michael.lo@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: Add PCIe AER handler support to prevent system crash
Date: Thu, 2 Oct 2025 10:46:10 +0800
Message-ID: <20251002024610.2840198-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Michael Lo <michael.lo@mediatek.com>

Activating AER ensures that enhanced error reporting feature are
properly initialized, enabling more effective error management
and helping to prevent system crashes caused by PCIe errors.

[ 2932.266976] Unable to handle kernel paging request at virtual address ffffffc01099eac0
[ 2932.267800] pc : mt76_dma_add_buf+0x124/0x188 [mt76]
[ 2932.267831] lr : mt76_dma_rx_fill+0x11c/0x1d8 [mt76]
[ 2932.267845] sp : ffffffc016d9bbf0
[ 2932.267859] x29: ffffffc016d9bc10 x28: 0000000000000000
[ 2932.267885] x27: 0000000000000000 x26: ffffffb7855e50b8
[ 2932.267911] x25: ffffffb80d04f000 x24: 0000000000000000
[ 2932.267936] x23: 0000000000000ec0 x22: ffffffb796803648
[ 2932.267962] x21: ffffffb796801f80 x20: ffffffb7968035f8
[ 2932.267987] x19: 0000000000000ec0 x18: 0000000000000000
[ 2932.268012] x17: 000000004ec00000 x16: 000000000ec00000
[ 2932.268037] x15: ffffffc01099eac0 x14: 000000004ec00000
[ 2932.268063] x13: 00000000ffc5a000 x12: ffffffc016d9bc32
[ 2932.268088] x11: 00000000ffffffff x10: 0000000000000002
[ 2932.268113] x9 : 0000000000000000 x8 : 000000000000b4ac
[ 2932.268138] x7 : 0000000000000a20 x6 : ffffffb6c1806400
[ 2932.268163] x5 : 0000000000000000 x4 : ffffffb80d04f000
[ 2932.268188] x3 : 0000000000000000 x2 : 0000000000000001
[ 2932.268213] x1 : 000000000ec04000 x0 : ffffffb7968035f8
[ 2932.268238] Call trace:
[ 2932.268275]  mt76_dma_add_buf+0x124/0x188 [mt76 (HASH:1029 4)]
[ 2932.268309]  mt76_dma_rx_reset+0xe8/0xfc [mt76 (HASH:1029 4)]
[ 2932.268342]  mt7921_wpdma_reset+0x188/0x1b0 [mt7921e (HASH:ee48 5)]
[ 2932.268371]  mt7921e_mac_reset+0x128/0x418 [mt7921e (HASH:ee48 5)]
[ 2932.268403]  mt7921_mac_reset_work+0xac/0x1a8 [mt7921_common (HASH:f721 6)]
[ 2932.268427]  process_one_work+0x188/0x514
[ 2932.268445]  worker_thread+0x12c/0x300
[ 2932.268465]  kthread+0x140/0x1fc
[ 2932.268483]  ret_from_fork+0x10/0x30

Due to hardware limitations - such as the lack of a connected hardware
reset pin or the absence of host re-probe functionality - affected Wi-Fi
devices may not fully recover to a normal operational state after certain
errors, even with AER enabled.

Signed-off-by: Michael Lo <michael.lo@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/agg-rx.c   |  9 +++
 drivers/net/wireless/mediatek/mt76/dma.c      |  6 ++
 drivers/net/wireless/mediatek/mt76/mac80211.c |  3 +
 drivers/net/wireless/mediatek/mt76/mcu.c      |  3 +
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  3 +
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  3 +
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  3 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  3 +
 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 64 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  8 +++
 .../net/wireless/mediatek/mt76/mt792x_mac.c   | 12 ++++
 11 files changed, 117 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index 936ab1ca9246..89d45f5954a2 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -96,6 +96,9 @@ mt76_rx_aggr_reorder_work(struct work_struct *work)
 	struct sk_buff_head frames;
 	int nframes;
 
+	if (atomic_read(&dev->bus_hung) == 1)
+		return;
+
 	__skb_queue_head_init(&frames);
 
 	local_bh_disable();
@@ -179,6 +182,9 @@ void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames)
 	if (!tid)
 		return;
 
+	if (atomic_read(&tid->dev->bus_hung) == 1)
+		return;
+
 	status->flag |= RX_FLAG_DUP_VALIDATED;
 	spin_lock_bh(&tid->lock);
 
@@ -246,6 +252,9 @@ int mt76_rx_aggr_start(struct mt76_dev *dev, struct mt76_wcid *wcid, u8 tidno,
 {
 	struct mt76_rx_tid *tid;
 
+	if (atomic_read(&dev->bus_hung) == 1)
+		return -EIO;
+
 	mt76_rx_aggr_stop(dev, wcid, tidno);
 
 	tid = kzalloc(struct_size(tid, reorder_buf, size), GFP_KERNEL);
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 1fa7de1d2c45..2d508ddbc7b7 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -339,6 +339,9 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 	int i, idx = -1;
 	u32 ctrl, next;
 
+	if (atomic_read(&dev->bus_hung) == 1)
+		return idx;
+
 	if (txwi) {
 		q->entry[q->head].txwi = DMA_DUMMY_DATA;
 		q->entry[q->head].skip_buf0 = true;
@@ -765,6 +768,9 @@ mt76_dma_rx_fill_buf(struct mt76_dev *dev, struct mt76_queue *q,
 	int len = SKB_WITH_OVERHEAD(q->buf_size);
 	int frames = 0;
 
+	if (atomic_read(&dev->bus_hung) == 1)
+		return 0;
+
 	if (!q->ndesc)
 		return 0;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 09cc5e40ccf9..a70245672638 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1549,6 +1549,9 @@ void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
 	struct sk_buff_head frames;
 	struct sk_buff *skb;
 
+	if (atomic_read(&dev->bus_hung) == 1)
+		return;
+
 	__skb_queue_head_init(&frames);
 
 	while ((skb = __skb_dequeue(&dev->rx_skb[q])) != NULL) {
diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index 65d4c2adb538..2107c0c07f3e 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -58,6 +58,9 @@ int mt76_mcu_send_and_get_msg(struct mt76_dev *dev, int cmd, const void *data,
 {
 	struct sk_buff *skb;
 
+	if (atomic_read(&dev->bus_hung) == 1)
+		return -EIO;
+
 	if (dev->mcu_ops->mcu_send_msg)
 		return dev->mcu_ops->mcu_send_msg(dev, cmd, data, len, wait_resp);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 756719ce0e48..46b0f65320c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -333,6 +333,9 @@ static inline u8 mt76_connac_spe_idx(u8 antenna_mask)
 
 static inline void mt76_connac_irq_enable(struct mt76_dev *dev, u32 mask)
 {
+	if (atomic_read(&dev->bus_hung) == 1)
+		return;
+
 	mt76_set_irq_mask(dev, 0, 0, mask);
 	tasklet_schedule(&dev->irq_tasklet);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 0db00efe88b0..7a6db5e0e250 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -64,6 +64,9 @@ void mt76_connac_power_save_sched(struct mt76_phy *phy,
 {
 	struct mt76_dev *dev = phy->dev;
 
+	if (atomic_read(&dev->bus_hung) == 1)
+		return;
+
 	if (mt76_is_usb(dev))
 		return;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index bce26389ab18..610aaf7eccff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -658,6 +658,9 @@ void mt7921_mac_reset_work(struct work_struct *work)
 	struct mt76_connac_pm *pm = &dev->pm;
 	int i, ret;
 
+	if (atomic_read(&dev->mt76.bus_hung) == 1)
+		return;
+
 	dev_dbg(dev->mt76.dev, "chip reset\n");
 	set_bit(MT76_RESET, &dev->mphy.state);
 	dev->hw_full_reset = true;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index ef216153cdf0..ba85f3e5d0f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1002,6 +1002,9 @@ void mt7921_scan_work(struct work_struct *work)
 	phy = (struct mt792x_phy *)container_of(work, struct mt792x_phy,
 						scan_work.work);
 
+	if (atomic_read(&phy->dev->mt76.bus_hung) == 1)
+		return;
+
 	while (true) {
 		struct mt76_connac2_mcu_rxd *rxd;
 		struct sk_buff *skb;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 71fba57db9be..019d7961d9d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -363,6 +363,8 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		    (mt7921_l1_rr(dev, MT_HW_REV) & 0xff);
 	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
+	atomic_set(&mdev->bus_hung, 0);
+
 	ret = mt792x_wfsys_reset(dev);
 	if (ret)
 		goto err_free_dev;
@@ -562,6 +564,67 @@ static void mt7921_pci_shutdown(struct pci_dev *pdev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(mt7921_pm_ops, mt7921_pci_suspend, mt7921_pci_resume);
 
+static pci_ers_result_t mt7921_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
+{
+	struct mt76_dev *mdev = pci_get_drvdata(pdev);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct ieee80211_hw *hw = mdev->hw;
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct net_device *netdev = pci_get_drvdata(pdev);
+
+	if (state == pci_channel_io_normal)
+		return PCI_ERS_RESULT_CAN_RECOVER;
+
+	if (atomic_read(&mdev->bus_hung) == 1)
+		return PCI_ERS_RESULT_NEED_RESET;
+
+	atomic_set(&mdev->bus_hung, 1);
+
+	set_bit(MT76_REMOVED, &mdev->phy.state);
+
+	if (netif_running(netdev))
+		netif_device_detach(netdev);
+
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
+
+	cancel_delayed_work_sync(&dev->pm.ps_work);
+	cancel_work_sync(&dev->pm.wake_work);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
+
+	mt792x_mutex_acquire(dev);
+	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+	mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, false, false);
+	mt792x_mutex_release(dev);
+
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	tasklet_kill(&mdev->irq_tasklet);
+
+	pci_disable_device(pdev);
+
+	/* Request a slot reset. */
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+static pci_ers_result_t mt7921_pci_error_slot_reset(struct pci_dev *pdev)
+{
+	pci_ers_result_t ret = PCI_ERS_RESULT_DISCONNECT;
+
+	return ret;
+}
+
+static void mt7921_pci_error_resume(struct pci_dev *pdev)
+{
+	return;
+}
+
+static const struct pci_error_handlers mt7921_pci_err_handler = {
+	.error_detected = mt7921_pci_error_detected,
+	.slot_reset             = mt7921_pci_error_slot_reset,
+	.resume                 = mt7921_pci_error_resume,
+};
+
 static struct pci_driver mt7921_pci_driver = {
 	.name		= KBUILD_MODNAME,
 	.id_table	= mt7921_pci_device_table,
@@ -569,6 +632,7 @@ static struct pci_driver mt7921_pci_driver = {
 	.remove		= mt7921_pci_remove,
 	.shutdown	= mt7921_pci_shutdown,
 	.driver.pm	= pm_sleep_ptr(&mt7921_pm_ops),
+	.err_handler = &mt7921_pci_err_handler,
 };
 
 module_pci_driver(mt7921_pci_driver);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 65cff5302a5a..4f4aa26b359d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -811,6 +811,10 @@ int mt792x_mcu_drv_pmctrl(struct mt792x_dev *dev)
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt76_connac_pm *pm = &dev->pm;
 	int err = 0;
+	struct mt76_dev *mdev = mphy->dev;
+
+	if (atomic_read(&mdev->bus_hung) == 1)
+		return -EIO;
 
 	mutex_lock(&pm->mutex);
 
@@ -833,6 +837,10 @@ int mt792x_mcu_fw_pmctrl(struct mt792x_dev *dev)
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt76_connac_pm *pm = &dev->pm;
 	int err = 0;
+	struct mt76_dev *mdev = mphy->dev;
+
+	if (atomic_read(&mdev->bus_hung) == 1)
+		return -EIO;
 
 	mutex_lock(&pm->mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
index f86e0ac91100..c813547a3562 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
@@ -13,6 +13,10 @@ void mt792x_mac_work(struct work_struct *work)
 
 	mphy = (struct mt76_phy *)container_of(work, struct mt76_phy,
 					       mac_work.work);
+
+	if (atomic_read(&mphy->dev->bus_hung) == 1)
+		return;
+
 	phy = mphy->priv;
 
 	mt792x_mutex_acquire(phy->dev);
@@ -322,6 +326,10 @@ void mt792x_pm_wake_work(struct work_struct *work)
 
 	dev = (struct mt792x_dev *)container_of(work, struct mt792x_dev,
 						pm.wake_work);
+
+	if (atomic_read(&dev->mt76.bus_hung) == 1)
+		return;
+
 	mphy = dev->phy.mt76;
 
 	if (!mt792x_mcu_drv_pmctrl(dev)) {
@@ -357,6 +365,10 @@ void mt792x_pm_power_save_work(struct work_struct *work)
 
 	dev = (struct mt792x_dev *)container_of(work, struct mt792x_dev,
 						pm.ps_work.work);
+
+	if (atomic_read(&dev->mt76.bus_hung) == 1)
+		return;
+
 	mphy = dev->phy.mt76;
 
 	delta = dev->pm.idle_timeout;
-- 
2.34.1


