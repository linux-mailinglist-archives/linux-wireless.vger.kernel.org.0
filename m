Return-Path: <linux-wireless+bounces-27882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDCDBC463A
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 12:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27011189CA04
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 10:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ED32F60A4;
	Wed,  8 Oct 2025 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNJtcvI3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AB52F5A1C
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920140; cv=none; b=UQLChx5Z5d4XUMxuQ1OZghPw2ai6ZDxi7vUUaQDMFiuB4IqzN2BuhPsV/H7aR3qx/zjWr3oQl2Cnh/I6X4JiR+2fCeBiA6SxA4RkjkuNLfXLstzGTalxe8asy456ZcIzbWMe+qk0i6H7/pIgydBdQJkJQ9xLkayAKWsot0wiEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920140; c=relaxed/simple;
	bh=VR4W9FmUND09AsNoaRiSvsJpE6L16sef/2CXgpUdvaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hpAWAw7qk9CcUIRgndyjAzN+XIxMrgwyurGIuqSewETgTRVWtzjW8rPeTO0HeQ94dEHUFq3LfEWnh/o6N8EUYDDIh2HKGes/BKswfVvFysuV6Ppp9+npGtLp+yfjD+nuMpWE0D5CBgdQphwfKC2YSFSH5BFnQGDw4k/YuLhano8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNJtcvI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742CEC4CEF4;
	Wed,  8 Oct 2025 10:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759920139;
	bh=VR4W9FmUND09AsNoaRiSvsJpE6L16sef/2CXgpUdvaM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gNJtcvI3/O6epHYpjhnE4QnnsxVsPg2R30sDfruqsemaaE28yK2MtaNox0d5n4arB
	 a2Wp8/t96BUoPdhKCtk6R4AgZwM+TgwXq2LxCw3KcTuEXsbR5B/OyWcBZtkTqBrRGM
	 sqDww34GZKgn8IFYOIHwospAa8j4lMrQma59BSQCtjVGiQZkdnRIIFdRSM2jwiMWX5
	 QSms9i5ouk3P3nCe2ST0ZuVszdZvtHJ0nI15eufMWvxP8gUHGSCN0AFhq8HagXTO/+
	 fb7DGg5VTdfMEIONc6qPqYW5tI6xkSOnGrHHYThevdf2PIQ4Br+Yyc3/P17qus5uTy
	 hqtqJBCE2E6bA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 08 Oct 2025 12:41:48 +0200
Subject: [PATCH mt76 1/2] wifi: mt76: wed: use proper wed reference in mt76
 wed driver callabacks
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-wed-fixes-v1-1-8f7678583385@kernel.org>
References: <20251008-wed-fixes-v1-0-8f7678583385@kernel.org>
In-Reply-To: <20251008-wed-fixes-v1-0-8f7678583385@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Daniel Pawlik <pawlik.dan@gmail.com>, 
 Matteo Croce <teknoraver@meta.com>
X-Mailer: b4 0.14.2

MT7996 driver can use both wed and wed_hif2 devices to offload traffic
from/to the wireless NIC. In the current codebase we assume to always
use the primary wed device in wed callbacks resulting in the following
crash if the hw runs wed_hif2 (e.g. 6GHz link).

[  297.455876] Unable to handle kernel read from unreadable memory at virtual address 000000000000080a
[  297.464928] Mem abort info:
[  297.467722]   ESR = 0x0000000096000005
[  297.471461]   EC = 0x25: DABT (current EL), IL = 32 bits
[  297.476766]   SET = 0, FnV = 0
[  297.479809]   EA = 0, S1PTW = 0
[  297.482940]   FSC = 0x05: level 1 translation fault
[  297.487809] Data abort info:
[  297.490679]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[  297.496156]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  297.501196]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  297.506500] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000107480000
[  297.512927] [000000000000080a] pgd=08000001097fb003, p4d=08000001097fb003, pud=08000001097fb003, pmd=0000000000000000
[  297.523532] Internal error: Oops: 0000000096000005 [#1] SMP
[  297.715393] CPU: 2 UID: 0 PID: 45 Comm: kworker/u16:2 Tainted: G           O       6.12.50 #0
[  297.723908] Tainted: [O]=OOT_MODULE
[  297.727384] Hardware name: Banana Pi BPI-R4 (2x SFP+) (DT)
[  297.732857] Workqueue: nf_ft_offload_del nf_flow_rule_route_ipv6 [nf_flow_table]
[  297.740254] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  297.747205] pc : mt76_wed_offload_disable+0x64/0xa0 [mt76]
[  297.752688] lr : mtk_wed_flow_remove+0x58/0x80
[  297.757126] sp : ffffffc080fe3ae0
[  297.760430] x29: ffffffc080fe3ae0 x28: ffffffc080fe3be0 x27: 00000000deadbef7
[  297.767557] x26: ffffff80c5ebca00 x25: 0000000000000001 x24: ffffff80c85f4c00
[  297.774683] x23: ffffff80c1875b78 x22: ffffffc080d42cd0 x21: ffffffc080660018
[  297.781809] x20: ffffff80c6a076d0 x19: ffffff80c6a043c8 x18: 0000000000000000
[  297.788935] x17: 0000000000000000 x16: 0000000000000001 x15: 0000000000000000
[  297.796060] x14: 0000000000000019 x13: ffffff80c0ad8ec0 x12: 00000000fa83b2da
[  297.803185] x11: ffffff80c02700c0 x10: ffffff80c0ad8ec0 x9 : ffffff81fef96200
[  297.810311] x8 : ffffff80c02700c0 x7 : ffffff80c02700d0 x6 : 0000000000000002
[  297.817435] x5 : 0000000000000400 x4 : 0000000000000000 x3 : 0000000000000000
[  297.824561] x2 : 0000000000000001 x1 : 0000000000000800 x0 : ffffff80c6a063c8
[  297.831686] Call trace:
[  297.834123]  mt76_wed_offload_disable+0x64/0xa0 [mt76]
[  297.839254]  mtk_wed_flow_remove+0x58/0x80
[  297.843342]  mtk_flow_offload_cmd+0x434/0x574
[  297.847689]  mtk_wed_setup_tc_block_cb+0x30/0x40
[  297.852295]  nf_flow_offload_ipv6_hook+0x7f4/0x964 [nf_flow_table]
[  297.858466]  nf_flow_rule_route_ipv6+0x438/0x4a4 [nf_flow_table]
[  297.864463]  process_one_work+0x174/0x300
[  297.868465]  worker_thread+0x278/0x430
[  297.872204]  kthread+0xd8/0xdc
[  297.875251]  ret_from_fork+0x10/0x20
[  297.878820] Code: 928b5ae0 8b000273 91400a60 f943fa61 (79401421)
[  297.884901] ---[ end trace 0000000000000000 ]---

Fix the issue detecting the proper wed reference to use running wed
callabacks.

Fixes: 83eafc9251d6 ("wifi: mt76: mt7996: add wed tx support")
Tested-by: Daniel Pawlik <pawlik.dan@gmail.com>
Tested-by: Matteo Croce <teknoraver@meta.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h        |  9 +++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c |  1 +
 drivers/net/wireless/mediatek/mt76/wed.c         | 10 +++++-----
 include/linux/soc/mediatek/mtk_wed.h             |  1 +
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e0d50b58cd012910b697102bd50bb855966876f9..7753afa3d883d6c7104bbb68d1d61b562e828ac5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1252,6 +1252,15 @@ static inline int mt76_wed_dma_setup(struct mt76_dev *dev, struct mt76_queue *q,
 #define mt76_dereference(p, dev) \
 	rcu_dereference_protected(p, lockdep_is_held(&(dev)->mutex))
 
+static inline struct mt76_dev *mt76_wed_to_dev(struct mtk_wed_device *wed)
+{
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	if (wed->wlan.hif2)
+		return container_of(wed, struct mt76_dev, mmio.wed_hif2);
+#endif /* CONFIG_NET_MEDIATEK_SOC_WED */
+	return container_of(wed, struct mt76_dev, mmio.wed);
+}
+
 static inline struct mt76_wcid *
 __mt76_wcid_ptr(struct mt76_dev *dev, u16 idx)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index d14b626ee511566e465588d2b2f7b77bd859a6ec..80db102ed809c31d994cfc3fad2073007c96410a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -595,6 +595,7 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 
 	wed->wlan.nbuf = MT7996_HW_TOKEN_SIZE;
 	wed->wlan.token_start = MT7996_TOKEN_SIZE - wed->wlan.nbuf;
+	wed->wlan.hif2 = hif2;
 
 	wed->wlan.amsdu_max_subframes = 8;
 	wed->wlan.amsdu_max_len = 1536;
diff --git a/drivers/net/wireless/mediatek/mt76/wed.c b/drivers/net/wireless/mediatek/mt76/wed.c
index 907a8e43e72ad1f2a68d097c4a06df4506c4b039..fbd7e59c73aaf24993999f7ede015e61e0f13acd 100644
--- a/drivers/net/wireless/mediatek/mt76/wed.c
+++ b/drivers/net/wireless/mediatek/mt76/wed.c
@@ -8,7 +8,7 @@
 
 void mt76_wed_release_rx_buf(struct mtk_wed_device *wed)
 {
-	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
+	struct mt76_dev *dev = mt76_wed_to_dev(wed);
 	int i;
 
 	for (i = 0; i < dev->rx_token_size; i++) {
@@ -31,8 +31,8 @@ EXPORT_SYMBOL_GPL(mt76_wed_release_rx_buf);
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 u32 mt76_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 {
-	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
 	struct mtk_wed_bm_desc *desc = wed->rx_buf_ring.desc;
+	struct mt76_dev *dev = mt76_wed_to_dev(wed);
 	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
 	struct mt76_txwi_cache *t = NULL;
 	int i;
@@ -80,7 +80,7 @@ EXPORT_SYMBOL_GPL(mt76_wed_init_rx_buf);
 
 int mt76_wed_offload_enable(struct mtk_wed_device *wed)
 {
-	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
+	struct mt76_dev *dev = mt76_wed_to_dev(wed);
 
 	spin_lock_bh(&dev->token_lock);
 	dev->token_size = wed->wlan.token_start;
@@ -164,7 +164,7 @@ EXPORT_SYMBOL_GPL(mt76_wed_dma_setup);
 
 void mt76_wed_offload_disable(struct mtk_wed_device *wed)
 {
-	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
+	struct mt76_dev *dev = mt76_wed_to_dev(wed);
 
 	spin_lock_bh(&dev->token_lock);
 	dev->token_size = dev->drv->token_size;
@@ -174,7 +174,7 @@ EXPORT_SYMBOL_GPL(mt76_wed_offload_disable);
 
 void mt76_wed_reset_complete(struct mtk_wed_device *wed)
 {
-	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
+	struct mt76_dev *dev = mt76_wed_to_dev(wed);
 
 	complete(&dev->mmio.wed_reset_complete);
 }
diff --git a/include/linux/soc/mediatek/mtk_wed.h b/include/linux/soc/mediatek/mtk_wed.h
index c4ff6bab176db1f51cd94ac4198df0caeb557df2..3fa93bd650044bee127897c78634b35c458f9489 100644
--- a/include/linux/soc/mediatek/mtk_wed.h
+++ b/include/linux/soc/mediatek/mtk_wed.h
@@ -154,6 +154,7 @@ struct mtk_wed_device {
 		bool wcid_512;
 		bool hw_rro;
 		bool msi;
+		bool hif2;
 
 		u16 token_start;
 		unsigned int nbuf;

-- 
2.51.0


