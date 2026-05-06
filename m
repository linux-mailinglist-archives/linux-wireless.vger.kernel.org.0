Return-Path: <linux-wireless+bounces-35991-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO4NLkvo+mlIUAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35991-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 09:05:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B294D6FD1
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 09:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C06BA3056166
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 07:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2992036896F;
	Wed,  6 May 2026 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="or+NM3gI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8720730E0E4
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 07:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051114; cv=none; b=bSLvY5ut8uSlDsjkAW3+zFhmmc2FvtPqeSjEpFAGxozqpuftQ4ftWgTzD7nWTUxbszr2Dw4foB9cIycFcJR0ILJtXgUMvx4xG2ZFSzkmfMw4/wQi6CLTnp4gT37f9A+ggXRy74lcjkpHuyD/LZhBr+20Qaav+vuBJWADvuNq9N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051114; c=relaxed/simple;
	bh=AUpnrf+r7OSKwZjXgaCIyXE5PglpM0OvzCTUFv5k268=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K8KJMDvkRoYXQtM01iaqzxB0BFs/rQaiqrKX+JVw7mCQDuLoCaYRwoTN+7KbvHeV1Fj/Pu+3izzUPq84tiZOIZdwg0P52ZUhdds0N6AwYyIulw07mcvLgvDYDoDMUiaCIRUc4dnXh0GQzNH1Y1AZD3XWeA3FH1QTNAr8Kdll4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=or+NM3gI; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e6a1aff4491911f1b96f91537e34a508-20260506
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=btOsksgvyHLdtmt37uoAfhcP2ZOCHruYw58r8wY8K48=;
	b=or+NM3gIhg/pfQIkGL5HMJVDf+hjUoHrPZf8K5lm1U+H8rgtrWawL7dIzOIahT6xBi8iW0hpw1kGiaQBAriRJlBR+C8SGfw0sZLGuBQ5q1LX+3ceA+knffRBraAb0oIJAq9liTMHu/Pp4/LGwuE4EMjsSDFk5tIcow8k2nEKCIs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9ecef815-d19b-4847-a406-0d1e70ab0dd4,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:5888f0be-65a8-4b41-ac18-3671578a914d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
	15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e6a1aff4491911f1b96f91537e34a508-20260506
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 528822891; Wed, 06 May 2026 15:05:01 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 6 May 2026 15:05:00 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 6 May 2026 15:05:00 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <eason.lai@mediatek.com>,
	<jb.tsai@mediatek.com>, Eason Lai <Eason.Lai@mediatek.com>, Sean Wang
	<sean.wang@mediatek.com>, Jeff Hsu <jeff.hsu@mediatek.com>, Michael Lo
	<michael.lo@mediatek.com>
Subject: [PATCH v3] wifi: mt76: mt7921: Add PCIe AER handler support to  prevent system crash
Date: Wed, 6 May 2026 15:04:58 +0800
Message-ID: <20260506070458.3096180-1-jb.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-MTK: N
X-Rspamd-Queue-Id: 08B294D6FD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35991-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[mediatek.com:query timed out];
	DKIM_TRACE(0.00)[mediatek.com:+];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[mediatek.com:query timed out];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mediatek.com:email,mediatek.com:dkim,mediatek.com:mid]

From: Eason Lai <Eason.Lai@mediatek.com>=0D

When an AER error occurs and the bus is hung, the register reads return=0D
0xFFFFFFFF, causing the DMA queue state to be corrupted and resulting in=0D
an invalid memory access when accessing q->desc[] or q->entry[].=0D
=0D
Unable to handle kernel paging request at virtual address=0D
ffffffc01099eac0=0D
pc : mt76_dma_add_buf+0x124/0x188 [mt76]=0D
lr : mt76_dma_rx_fill+0x11c/0x1d8 [mt76]=0D
sp : ffffffc016d9bbf0=0D
x29: ffffffc016d9bc10 x28: 0000000000000000=0D
x27: 0000000000000000 x26: ffffffb7855e50b8=0D
x25: ffffffb80d04f000 x24: 0000000000000000=0D
x23: 0000000000000ec0 x22: ffffffb796803648=0D
x21: ffffffb796801f80 x20: ffffffb7968035f8=0D
x19: 0000000000000ec0 x18: 0000000000000000=0D
x17: 000000004ec00000 x16: 000000000ec00000=0D
x15: ffffffc01099eac0 x14: 000000004ec00000=0D
x13: 00000000ffc5a000 x12: ffffffc016d9bc32=0D
x11: 00000000ffffffff x10: 0000000000000002=0D
x9 : 0000000000000000 x8 : 000000000000b4ac=0D
x7 : 0000000000000a20 x6 : ffffffb6c1806400=0D
x5 : 0000000000000000 x4 : ffffffb80d04f000=0D
x3 : 0000000000000000 x2 : 0000000000000001=0D
x1 : 000000000ec04000 x0 : ffffffb7968035f8=0D
Call trace:=0D
 mt76_dma_add_buf+0x124/0x188 [mt76 (HASH:1029 4)]=0D
 mt76_dma_rx_reset+0xe8/0xfc [mt76 (HASH:1029 4)]=0D
 mt7921_wpdma_reset+0x188/0x1b0 [mt7921e (HASH:ee48 5)]=0D
 mt7921e_mac_reset+0x128/0x418 [mt7921e (HASH:ee48 5)]=0D
 mt7921_mac_reset_work+0xac/0x1a8 [mt7921_common (HASH:f721 6)]=0D
 process_one_work+0x188/0x514=0D
 worker_thread+0x12c/0x300=0D
 kthread+0x140/0x1fc=0D
 ret_from_fork+0x10/0x30=0D
=0D
Fix this by checking the bus_hung flag in mt7921_mac_reset_work() before=0D
attempting the reset sequence, and by installing no-op bus operations=0D
when an unrecoverable AER error is detected, preventing further invalid=0D
hardware accesses.=0D
=0D
Due to hardware limitations - such as the lack of a connected hardware=0D
reset pin or the absence of host re-probe functionality - affected Wi-Fi=0D
devices may not fully recover to a normal operational state after=0D
certain errors, even with AER enabled.=0D
=0D
Fixes: 17f1de56df05 ("mt76: add common code shared between multiple chipset=
s")=0D
Co-developed-by: Sean Wang <sean.wang@mediatek.com>=0D
Signed-off-by: Sean Wang <sean.wang@mediatek.com>=0D
Co-developed-by: Jeff Hsu <jeff.hsu@mediatek.com>=0D
Signed-off-by: Jeff Hsu <jeff.hsu@mediatek.com>=0D
Signed-off-by: Eason Lai <Eason.Lai@mediatek.com>=0D
Co-developed-by: Michael Lo <michael.lo@mediatek.com>=0D
---=0D
v2: remove the timestamp of error call trace=0D
v3: fix bus hung and causing invalid access issue=0D
---=0D
 drivers/net/wireless/mediatek/mt76/dma.c      |  10 +-=0D
 drivers/net/wireless/mediatek/mt76/dma.h      |  16 ++-=0D
 drivers/net/wireless/mediatek/mt76/mcu.c      |  12 +-=0D
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   5 +=0D
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |   3 +=0D
 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 103 ++++++++++++++++++=0D
 6 files changed, 140 insertions(+), 9 deletions(-)=0D
=0D
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireles=
s/mediatek/mt76/dma.c=0D
index f8c2fe5f2f58..ec84961b11db 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/dma.c=0D
+++ b/drivers/net/wireless/mediatek/mt76/dma.c=0D
@@ -189,6 +189,8 @@ mt76_dma_queue_magic_cnt_init(struct mt76_dev *dev, str=
uct mt76_queue *q)=0D
 static void=0D
 mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)=0D
 {=0D
+	int last =3D 0;=0D
+=0D
 	if ((q->flags & MT_QFLAG_WED_RRO_EN) &&=0D
 	    (!is_mt7992(dev) || !mt76_npu_device_active(dev)))=0D
 		Q_WRITE(q, ring_size, MT_DMA_RRO_EN | q->ndesc);=0D
@@ -201,7 +203,9 @@ mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_que=
ue *q)=0D
 	}=0D
 =0D
 	Q_WRITE(q, desc_base, q->desc_dma);=0D
-	q->head =3D Q_READ(q, dma_idx);=0D
+=0D
+	last =3D Q_READ(q, dma_idx);=0D
+	q->head =3D (last >=3D 0 && last < q->ndesc) ? last : 0;=0D
 	q->tail =3D q->head;=0D
 }=0D
 =0D
@@ -625,8 +629,8 @@ mt76_dma_tx_queue_skb_raw(struct mt76_dev *dev, struct =
mt76_queue *q,=0D
 	buf.len =3D skb->len;=0D
 =0D
 	spin_lock_bh(&q->lock);=0D
-	mt76_dma_add_buf(dev, q, &buf, 1, tx_info, skb, NULL);=0D
-	mt76_dma_kick_queue(dev, q);=0D
+	if (mt76_dma_add_buf(dev, q, &buf, 1, tx_info, skb, NULL) >=3D 0)=0D
+		mt76_dma_kick_queue(dev, q);=0D
 	spin_unlock_bh(&q->lock);=0D
 =0D
 	return 0;=0D
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireles=
s/mediatek/mt76/dma.h=0D
index 2a0226c83f3c..7f395a4c509f 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/dma.h=0D
+++ b/drivers/net/wireless/mediatek/mt76/dma.h=0D
@@ -108,8 +108,20 @@=0D
 =0D
 #else=0D
 =0D
-#define Q_READ(_q, _field)		readl(&(_q)->regs->_field)=0D
-#define Q_WRITE(_q, _field, _val)	writel(_val, &(_q)->regs->_field)=0D
+#define Q_READ(_q, _field) ({						\=0D
+	u32 _val;							\=0D
+	if (unlikely(atomic_read(&(_q)->dev->bus_hung)))		\=0D
+		_val =3D 0;						\=0D
+	else								\=0D
+		_val =3D readl(&(_q)->regs->(_field));			\=0D
+	_val;								\=0D
+})=0D
+=0D
+#define Q_WRITE(_q, _field, _val) do {					\=0D
+	if (unlikely(atomic_read(&(_q)->dev->bus_hung)))		\=0D
+		break;							\=0D
+	writel(_val, &(_q)->regs->(_field));				\=0D
+} while (0)=0D
 =0D
 #endif=0D
 =0D
diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireles=
s/mediatek/mt76/mcu.c=0D
index cbfb3bbec503..7149b2f7aafd 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/mcu.c=0D
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c=0D
@@ -78,15 +78,19 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev,=
 struct sk_buff *skb,=0D
 	unsigned long expires;=0D
 	int ret, seq;=0D
 =0D
-	if (mt76_is_sdio(dev))=0D
-		if (test_bit(MT76_RESET, &dev->phy.state) && atomic_read(&dev->bus_hung)=
)=0D
-			return -EIO;=0D
-=0D
 	if (ret_skb)=0D
 		*ret_skb =3D NULL;=0D
 =0D
 	mutex_lock(&dev->mcu.mutex);=0D
 =0D
+	if ((mt76_is_mmio(dev) && atomic_read(&dev->bus_hung)) ||=0D
+	    (mt76_is_sdio(dev) && test_bit(MT76_RESET, &dev->phy.state) &&=0D
+	    atomic_read(&dev->bus_hung))) {=0D
+		orig_skb =3D skb;=0D
+		ret =3D -EIO;=0D
+		goto out;=0D
+	}=0D
+=0D
 	if (dev->mcu_ops->mcu_skb_prepare_msg) {=0D
 		orig_skb =3D skb;=0D
 		ret =3D dev->mcu_ops->mcu_skb_prepare_msg(dev, skb, cmd, &seq);=0D
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net=
/wireless/mediatek/mt76/mt76_connac.h=0D
index 51423c7740bd..17f9c6e65849 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h=0D
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h=0D
@@ -48,6 +48,11 @@ enum rx_pkt_type {=0D
 #define MT_TXD_LEN_MSDU_LAST		BIT(14)=0D
 #define MT_TXD_LEN_AMSDU_LAST		BIT(15)=0D
 =0D
+/* PCIE part */=0D
+#define PCIE_AER_UNC_STATUS_OFFSET  0x204=0D
+#define PCIE_AER_UNC_MASK_OFFSET    0x208=0D
+#define PCIE_AER_CO_STATUS_OFFSET   0x210=0D
+=0D
 enum {=0D
 	CMD_CBW_20MHZ =3D IEEE80211_STA_RX_BW_20,=0D
 	CMD_CBW_40MHZ =3D IEEE80211_STA_RX_BW_40,=0D
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/=
wireless/mediatek/mt76/mt7921/mac.c=0D
index 03b4960db73f..30f431896b1c 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c=0D
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c=0D
@@ -668,6 +668,9 @@ void mt7921_mac_reset_work(struct work_struct *work)=0D
 	cancel_work_sync(&pm->wake_work);=0D
 =0D
 	for (i =3D 0; i < 10; i++) {=0D
+		if (atomic_read(&dev->mt76.bus_hung))=0D
+			return;=0D
+=0D
 		mutex_lock(&dev->mt76.mutex);=0D
 		ret =3D mt792x_dev_reset(dev);=0D
 		mutex_unlock(&dev->mt76.mutex);=0D
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/=
wireless/mediatek/mt76/mt7921/pci.c=0D
index 7a790ddf43bb..6b9d267a7e7b 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c=0D
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c=0D
@@ -594,6 +594,108 @@ static int mt7921_pci_resume(struct device *device)=0D
 	return err;=0D
 }=0D
 =0D
+static u32 mt7921_aer_rr(struct mt76_dev *mdev, u32 offset)=0D
+{=0D
+	return 0;=0D
+}=0D
+=0D
+static void mt7921_aer_wr(struct mt76_dev *mdev, u32 offset, u32 val)=0D
+{=0D
+	;=0D
+}=0D
+=0D
+static u32 mt791_aer_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 =
val)=0D
+{=0D
+	return 0;=0D
+}=0D
+=0D
+static const struct mt76_bus_ops mt7921_aer_bus_hung_ops =3D {=0D
+	.rr =3D mt7921_aer_rr,=0D
+	.wr =3D mt7921_aer_wr,=0D
+	.rmw =3D mt791_aer_rmw,=0D
+	.type =3D MT76_BUS_MMIO=0D
+};=0D
+=0D
+static void mt7921_pci_set_aer_bus_hung_ops(struct mt792x_dev *dev)=0D
+{=0D
+	if (READ_ONCE(dev->mt76.bus) =3D=3D &mt7921_aer_bus_hung_ops)=0D
+		return;=0D
+=0D
+	atomic_set(&dev->mt76.bus_hung, true);=0D
+	WRITE_ONCE(dev->mt76.bus, &mt7921_aer_bus_hung_ops);=0D
+}=0D
+=0D
+static pci_ers_result_t mt7921_error_detected(struct pci_dev *pdev,=0D
+					      pci_channel_state_t state)=0D
+{=0D
+	struct mt76_dev *mdev =3D pci_get_drvdata(pdev);=0D
+	struct mt792x_dev *dev =3D container_of(mdev, struct mt792x_dev, mt76);=0D
+	u32 aer_unc_val =3D 0, aer_co_val =3D 0;=0D
+=0D
+	dev_err(mdev->dev, "PCIE error detect state: %d\n", state);=0D
+=0D
+	/* Clear SW IRQ tasklet first */=0D
+	tasklet_kill(&mdev->irq_tasklet);=0D
+=0D
+	if (state =3D=3D pci_channel_io_perm_failure) {=0D
+		mt7921_pci_set_aer_bus_hung_ops(dev);=0D
+		return PCI_ERS_RESULT_DISCONNECT;=0D
+	}=0D
+=0D
+	pci_read_config_dword(pdev, PCIE_AER_UNC_STATUS_OFFSET, &aer_unc_val);=0D
+	pci_read_config_dword(pdev, PCIE_AER_CO_STATUS_OFFSET, &aer_co_val);=0D
+=0D
+	dev_warn(mdev->dev, "PCIE_AER_UNC_STATUS_OFFSET: 0x%x\n", aer_unc_val);=0D
+	dev_warn(mdev->dev, "PCIE_AER_CO_STATUS_OFFSET: 0x%x\n", aer_co_val);=0D
+=0D
+	/**=0D
+	 * Due to this error is from link error and this AER is un-correctable,=0D
+	 * so can't covered by device=0D
+	 **/=0D
+	if (aer_unc_val !=3D 0) {=0D
+		mt7921_pci_set_aer_bus_hung_ops(dev);=0D
+		return PCI_ERS_RESULT_DISCONNECT;=0D
+	}=0D
+=0D
+	/**=0D
+	 * Try to recover it when state is pci_channel_io_frozen or=0D
+	 * AER is correctable error=0D
+	 **/=0D
+	if (state =3D=3D pci_channel_io_frozen || aer_co_val !=3D 0) {=0D
+		/* Disable PCIE activity first. */=0D
+		pci_disable_device(pdev);=0D
+		return PCI_ERS_RESULT_NEED_RESET;=0D
+	}=0D
+=0D
+	return PCI_ERS_RESULT_NONE;=0D
+}=0D
+=0D
+static pci_ers_result_t mt7921_slot_reset(struct pci_dev *pdev)=0D
+{=0D
+	struct mt76_dev *mdev =3D pci_get_drvdata(pdev);=0D
+	int ret =3D 0;=0D
+=0D
+	ret =3D pci_enable_device_mem(pdev);=0D
+=0D
+	if (ret) {=0D
+		dev_err(mdev->dev, "pci_enable_device_mem failed: %d\n", ret);=0D
+		return PCI_ERS_RESULT_DISCONNECT;=0D
+	}=0D
+=0D
+	pci_set_master(pdev);=0D
+	pci_restore_state(pdev);=0D
+	pci_save_state(pdev);=0D
+	/* Also try do the vendor reset to let it more clear. */=0D
+	mt792x_reset(mdev);=0D
+=0D
+	return PCI_ERS_RESULT_RECOVERED;=0D
+}=0D
+=0D
+static const struct pci_error_handlers mt7921_err_handler =3D {=0D
+	.error_detected =3D mt7921_error_detected,=0D
+	.slot_reset     =3D mt7921_slot_reset,=0D
+};=0D
+=0D
 static void mt7921_pci_shutdown(struct pci_dev *pdev)=0D
 {=0D
 	mt7921_pci_remove(pdev);=0D
@@ -608,6 +710,7 @@ static struct pci_driver mt7921_pci_driver =3D {=0D
 	.remove		=3D mt7921_pci_remove,=0D
 	.shutdown	=3D mt7921_pci_shutdown,=0D
 	.driver.pm	=3D pm_sleep_ptr(&mt7921_pm_ops),=0D
+	.err_handler    =3D &mt7921_err_handler,=0D
 };=0D
 =0D
 module_pci_driver(mt7921_pci_driver);=0D
-- =0D
2.45.2=0D
=0D

