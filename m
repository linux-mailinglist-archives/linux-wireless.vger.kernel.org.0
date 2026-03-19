Return-Path: <linux-wireless+bounces-33524-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC+KN5Z6vGnOzAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33524-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:37:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC6F2D3434
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E4B8302143E
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 22:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B16F40823D;
	Thu, 19 Mar 2026 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="pgx28rM4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="arj23Bxb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533523BAD8D;
	Thu, 19 Mar 2026 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959082; cv=none; b=kt+Ld7d23bCPaz5LwkG88HUXdFQMlC4qxtw4znM6x+Sh6wUdjNRXT3tVQGNFUguArsI9LsQUqExhCD3+L8PyKm5zaoAds2YfQcjKSHTclZvK8l6OAhVqHXQc6ntu+SsPpGvJ7WzQ3wkz0KDP+VFkfK3lVsoQPQig90aSu2G8Sdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959082; c=relaxed/simple;
	bh=d/HKmmehbZuZuFy6yrEQuL+8MJqGQNMTKPsrWPbucdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=EID+ueA5xlMV+uTgQCKHXyHqu2/pTr33FvEmF6upc44VWTx9zSqkNxD11uP+7k/a+5GrFl4TsOBMt3U5LjrsOU0Up2xCl75UuEFMJk+5nZc5E/IDYS/6adw5Q9Qs0PCF3ZhqaQZkK6PQvAf++X24oXawwT3/yi5rnMElK81L468=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=pgx28rM4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=arj23Bxb; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 19E2213000B6;
	Thu, 19 Mar 2026 18:24:37 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 18:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773959076;
	 x=1773966276; bh=wh4REqgnKzyEzUI/NBTjswi8jAEeySuPefhD1zQxSo0=; b=
	pgx28rM4YIT6zVe3CfzI2Hs4DgHmOoBmckmySaMMMCNE4YNeDlnIz+jIuDWLJ9DB
	4x2+kzjwIsBMADi2KA4OGD+19n4Q9rFQcAUkG00geMWxSHg+gHde8/TjNakpuz8e
	+NCT/nwk0hnc/Rv7LH3lLt2cyH/i6OfaJWkUVgTpyzBdrGx8TYH3N4s/pqR4rs03
	8GhUCFMYdmLp7Q7Qdh1Db6yI/+IxsbPwYKlj5dqHYv824nb0puNpfZMU3ml4TD2b
	gHV6Lo3h3LAqJDHkuBqhSCHRJziPcb1wjCWoxSJm2yWEAtk5MW3cEYRZogB8sp+9
	WyzS9xXBxfsmGtB9mNRAEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773959076; x=
	1773966276; bh=wh4REqgnKzyEzUI/NBTjswi8jAEeySuPefhD1zQxSo0=; b=a
	rj23BxbXuIKZ4iWDsXZ+wQ0qDY2k1UemV1l5ty7aiqUXUug3Hwwre8pMA8pyKEYH
	46r18B78Hs2ZY9hs70jCGqCqgNwStnBqfs821Z0aAFGiuplG3iq1j3mb4/+pHX1j
	y6CkUwrupXMbtP60F2FqxnKDPg77GkUJJMWW9EScahV4bPojWe+BZbJZeZCVcdtL
	TXOMdQcsT8/Ma7zDh/nI5JZUE+sQ7/j52+06QiVH6NTnP1fiNZHzvukcTzNrtfGA
	lzF9muab1ja+hiDqxMbWzCoDv3MRN9nXnRFRYzHxQXXqKv5xxgRFcmG7UWsQb6Mr
	n0/MLXj4YNLfoWhmc7aAg==
X-ME-Sender: <xms:pHe8aRxFbrW8LmtP1xr2VoIz2PlWPcn5nNh3CI7cvxaePrDq5U3vlA>
    <xme:pHe8acFoaSv4y1olsSSmW9BstDWvA_6HKWaEI8nYj5mWAQ8ptV-SCkqKTkJUSnAVJ
    nvgnoA2nmM49LyK95-GR3s4Tzmb0_w0PZDnrGtUR8oyyRinFxVj6sI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:pHe8aSj8oDxEg3m4zChUogM54XZ3skwLrFd7WNnuH2Hq35tPOVqjnA>
    <xmx:pHe8aQOkL67ZgAI8KqkDThsJguAuF9xAlrkNS81KOSSfq7W5trv4vw>
    <xmx:pHe8aen_Hrwt1yYGngpq4DAOk5hprVIpXjhMEOp9wtAu9hFS_Uup2A>
    <xmx:pHe8aXdTswFI3ZidiNcS30PHtSDIwXCuHDCu9avS9e7dddkpzaU1kg>
    <xmx:pHe8ac6Xr6pC4NgLRzBuxwSmlu4Cu1o7c-gsGvjgclLVxmXfyqtsJaqE>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C727D1EA006B; Thu, 19 Mar 2026 18:24:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 19 Mar 2026 16:24:24 -0600
Subject: [PATCH v2 08/13] wifi: mt76: mt7925: use irq_map for chip-specific
 interrupt handling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260319-mt7927-wifi-support-v2-v2-8-d627a7fad70d@jetm.me>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Deren Wu <deren.wu@mediatek.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Marcin FM <marcin@lgic.pl>, Cristian-Florin Radoi <radoi.chris@gmail.com>,
 George Salukvadze <giosal90@gmail.com>, Evgeny Kapusta <3193631@gmail.com>,
 Samu Toljamo <samu.toljamo@gmail.com>,
 Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>,
 Chapuis Dario <chapuisdario4@gmail.com>,
 =?utf-8?q?Thibaut_Fran=C3=A7ois?= <tibo@humeurlibre.fr>,
 =?utf-8?q?=E5=BC=A0=E6=97=AD=E6=B6=B5?= <Loong.0x00@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4873; i=floss@jetm.me;
 h=from:subject:message-id; bh=d/HKmmehbZuZuFy6yrEQuL+8MJqGQNMTKPsrWPbucdg=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpvHeRsXc1e/dD04b+RXaJE2r3El23Udt4g75Hi
 Q2V8JxrTXqJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCabx3kQAKCRC17sMLqGd3
 HzlCC/9reY2YxHDP1rUbms3z9JoDDq2wa7CDznHl1fT10NNafTw9P/TtX/Je7aOJCfuhzlhWD9g
 FONYcwsf/6kKD0U4roc64nAqzaqFqe+XJjZMaqBEXqwZwfeYlMhpaSOoAqiLpwkfb6EcJBo2ZpL
 LY8f8/Zf8SyWIUyjhPEveG6AJBfRywW4AXV9xDv21wZYBNItjV9FfEQRNXJw9bmTVAUaVEyhFco
 6oLzmdeTG9+jqK0mVrCswnsfC0n/YhBdLz+QIArM3cM1taFW0O4s6yVTCRZa9tAOGH61jGV7QAf
 hFD27IK7QZ5lL/rPmCVP9Ox9VoMvdtuAds9udfrHY+UZWoHKYgCZxRp8mQ74AE0aHJ8nmA+P5Wh
 64Ln7o1dmwxJPrTXqpYz68HcxvNkXpy8zh8OOxbR6hprjyM7GKUlW1q658uL+h0/B2neb7Q3kR6
 /+kWH3ivIJViUIQBAWVhbLiuE++B6HFSSzC7c5VO7ZsjfHFjgdI9AW5xGJx5kxjISxqmA=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
References: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33524-lists,linux-wireless=lfdr.de];
	R_DKIM_ALLOW(0.00)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lgic.pl,gmail.com,humeurlibre.fr];
	DMARC_POLICY_ALLOW(0.00)[jetm.me,quarantine];
	DKIM_TRACE(0.00)[jetm.me:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[floss@jetm.me,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	NEURAL_SPAM(0.00)[0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[humeurlibre.fr:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,lgic.pl:email,jetm.me:dkim,jetm.me:email,jetm.me:mid]
X-Rspamd-Queue-Id: 8DC6F2D3434
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

The mac_reset and resume paths use the hardcoded MT_INT_RX_DONE_ALL
constant (bits 0-2) to re-enable RX interrupts. This is correct for
MT7925 (RX rings 0, 1, 2) but wrong for chips using different ring
indices.

Define a per-chip irq_map with the correct RX interrupt enable bits and
replace hardcoded MT_INT_RX_DONE_ALL with irq_map field reads in the
resume and mac_reset paths. Add the MT7927 irq_map with interrupt bits
matching its RX ring layout (rings 4, 6, 7), selected at probe time
based on PCI device ID.

This ensures the correct interrupt bits are enabled regardless of the
chip variant.

Tested-by: Marcin FM <marcin@lgic.pl>
Tested-by: Cristian-Florin Radoi <radoi.chris@gmail.com>
Tested-by: George Salukvadze <giosal90@gmail.com>
Tested-by: Evgeny Kapusta <3193631@gmail.com>
Tested-by: Samu Toljamo <samu.toljamo@gmail.com>
Tested-by: Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>
Tested-by: Chapuis Dario <chapuisdario4@gmail.com>
Tested-by: Thibaut François <tibo@humeurlibre.fr>
Tested-by: 张旭涵 <Loong.0x00@gmail.com>
Signed-off-by: Javier Tia <floss@jetm.me>
---
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c     | 21 +++++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c |  5 ++++-
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h    |  3 +++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index f820d5aeb723..604c0e9ae7ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -266,6 +266,18 @@ static int mt7925_dma_init(struct mt792x_dev *dev)
 	return mt792x_dma_enable(dev);
 }
 
+static const struct mt792x_irq_map mt7927_irq_map = {
+	.host_irq_enable = MT_WFDMA0_HOST_INT_ENA,
+	.tx = {
+		.all_complete_mask = MT_INT_TX_DONE_ALL,
+		.mcu_complete_mask = MT_INT_TX_DONE_MCU,
+	},
+	.rx = {
+		.data_complete_mask = MT7927_RX_DONE_INT_ENA4,
+		.wm_complete_mask = MT7927_RX_DONE_INT_ENA6,
+		.wm2_complete_mask = MT7927_RX_DONE_INT_ENA7,
+	},
+};
 static int mt7925_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -310,6 +322,7 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	struct mt76_bus_ops *bus_ops;
 	struct mt792x_dev *dev;
 	struct mt76_dev *mdev;
+	bool is_mt7927_hw;
 	u8 features;
 	int ret;
 	u16 cmd;
@@ -358,7 +371,8 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	dev = container_of(mdev, struct mt792x_dev, mt76);
 	dev->fw_features = features;
 	dev->hif_ops = &mt7925_pcie_ops;
-	dev->irq_map = &irq_map;
+	is_mt7927_hw = (pdev->device == 0x6639 || pdev->device == 0x7927);
+	dev->irq_map = is_mt7927_hw ? &mt7927_irq_map : &irq_map;
 	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
 	tasklet_init(&mdev->irq_tasklet, mt792x_irq_tasklet, (unsigned long)dev);
 
@@ -549,7 +563,10 @@ static int _mt7925_pci_resume(struct device *device, bool restore)
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 	mt76_connac_irq_enable(&dev->mt76,
 			       dev->irq_map->tx.all_complete_mask |
-			       MT_INT_RX_DONE_ALL | MT_INT_MCU_CMD);
+			       dev->irq_map->rx.data_complete_mask |
+			       dev->irq_map->rx.wm_complete_mask |
+			       dev->irq_map->rx.wm2_complete_mask |
+			       MT_INT_MCU_CMD);
 	mt76_set(dev, MT_MCU2HOST_SW_INT_ENA, MT_MCU_CMD_WAKE_RX_PCIE);
 
 	/* put dma enabled */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
index 3072850c2752..1626a3684082 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
@@ -118,7 +118,10 @@ int mt7925e_mac_reset(struct mt792x_dev *dev)
 
 	mt76_wr(dev, dev->irq_map->host_irq_enable,
 		dev->irq_map->tx.all_complete_mask |
-		MT_INT_RX_DONE_ALL | MT_INT_MCU_CMD);
+		dev->irq_map->rx.data_complete_mask |
+		dev->irq_map->rx.wm_complete_mask |
+		dev->irq_map->rx.wm2_complete_mask |
+		MT_INT_MCU_CMD);
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 
 	err = mt792xe_mcu_fw_pmctrl(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index acf627aed609..a8c8d7d6f565 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -308,6 +308,9 @@
 #define HOST_RX_DONE_INT_ENA1		BIT(1)
 #define HOST_RX_DONE_INT_ENA2		BIT(2)
 #define HOST_RX_DONE_INT_ENA3		BIT(3)
+#define MT7927_RX_DONE_INT_ENA4		BIT(12)
+#define MT7927_RX_DONE_INT_ENA6		BIT(14)
+#define MT7927_RX_DONE_INT_ENA7		BIT(15)
 #define HOST_TX_DONE_INT_ENA0		BIT(4)
 #define HOST_TX_DONE_INT_ENA1		BIT(5)
 #define HOST_TX_DONE_INT_ENA2		BIT(6)

-- 
2.53.0


