Return-Path: <linux-wireless+bounces-33895-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFJYCJ9hxGkuywQAu9opvQ
	(envelope-from <linux-wireless+bounces-33895-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:28:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7795032CFA6
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62EDE312C52E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F23F3563FB;
	Wed, 25 Mar 2026 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="TDlZPRly";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HW7VZ+Jy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDE1390990;
	Wed, 25 Mar 2026 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476673; cv=none; b=E5qqggbzqrxRUifOnxz6CbpwjcMTRpUhiG02TlYPnED1Ief0lH4nQelDv3K5uRzPWgeykGA4M1oembkvlZ3bcdVzhAkPAkR2ey6GiDnKenJRqh6Z/yCk3PpMr+vMrpp+wn929BUVQTqUSevdLEZD7F0bZ7tqMC9zTftkvRj+K6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476673; c=relaxed/simple;
	bh=d/HKmmehbZuZuFy6yrEQuL+8MJqGQNMTKPsrWPbucdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=cKjHa6NyjLIYp59GK0wGMf+RyylgwDJ8Mw1nyNw3nM2dCv8AbFogqF5Drf2W7vdJyO01B3tticbzEz12/EeImi2ryvAHw3ViZLuURGEtw21mUOMS6mlmKjeJMoq9hftEqKSiE0d1FBrH5ivn0noqNmD7UI5+oVdWLiPlZHAiBQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=TDlZPRly; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HW7VZ+Jy; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id B995D1300523;
	Wed, 25 Mar 2026 18:11:10 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 18:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774476670;
	 x=1774483870; bh=wh4REqgnKzyEzUI/NBTjswi8jAEeySuPefhD1zQxSo0=; b=
	TDlZPRlymjCHsHXOfSU+r3oSoxs+WjDOHrnqAdXaR215ikq9KG/MEx7FS0YzNZox
	xsfW+YllfD3tPwSGaAmdo9JOnv7XpeObHKBgma21IlfYGvNXrNTE/ctFmTJvElIu
	lhdWf0+E1QER2xu6zb4154k3ADAJbMo6nwn4QIX5m1z2aVamag7oCZqe5IeN8PoA
	aqZqhcq39u8fsSU59yoUx3gJMHZFim0rjh/IIKP2G1Rg6lQhIz3b0YdjJzx2w6+r
	A7b4yh328EkRxouDF6+3TRVYxxdQ48Nu9go6nR3gevey9gE66iu/ErlJ5lpDpIXS
	Kq1fpYbz5TI1kXd6c9zrlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774476670; x=
	1774483870; bh=wh4REqgnKzyEzUI/NBTjswi8jAEeySuPefhD1zQxSo0=; b=H
	W7VZ+Jyrr2b0GMcUGY2HLbOXnSk4vCqmyoNA+MWIyDjegimWQDy5567NBgFqerBq
	rLnLsU2K7qB1eYMnyXUjOowMNOJFoHBcgERVwquNYPNu//KtauKNvrMjhUmufQOA
	XHKcpTh8d19M/k2pPXiPwb6m+h4XnDOR0JC/0AYaMP2MVrxAW3q5oMT3PSkdnWyV
	gr/RciWl7zWL4GSrX6WrJUbAU8p5C9xekyzyLnSRhdVZW7qKqww55orvBKnRGohi
	VaCLEG4krtJs6aEJTxFtmNKbbElGo4LLjo2IaB8QS68gJJlWT6MNzRjUlzQwQ5/D
	wb6Uu8FYd0aPzkbRIuQHA==
X-ME-Sender: <xms:fl3EaYzqk8xx59pwDoqVo91JcirK29ZrVTLRzYi-4bxITItcnhH-ew>
    <xme:fl3EaXF5U3ymfAzCtGbZ0RXVJY2aWcnTKjF14N8DC9SeOnXp9lhoqIFj4esBsqXEh
    7-5kyD8sG5hbvUvE212wnCXWRX2ZVZnXTql7wkI0nnUb66oquo0FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:fl3EaRgkeak-d1RUgXIx3PRiySbvQYG9jZuEujhW8IJfwDWYG3gZHg>
    <xmx:fl3EaTNFWisKh5vCIByxLvSCH2HcMy3uthIMPOkWQ2j2MdQ6M2xqBw>
    <xmx:fl3EaVnBVozTArOJuJqXyf29cvBLjibx8p6reom1WimUHSe-6o6DYA>
    <xmx:fl3EaSdQezQTLSVCl2CY-r9kWrKGiTiVp_kkmbkDBlUCs_7Dsic2dg>
    <xmx:fl3EaRCYdD9y2C302IyvDlCihxL0RAN3fsWmI50zt5uBIzsCp4ZTfLgT>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 743B71EA006B; Wed, 25 Mar 2026 18:11:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Wed, 25 Mar 2026 16:10:57 -0600
Subject: [PATCH v3 08/13] wifi: mt76: mt7925: use irq_map for chip-specific
 interrupt handling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260325-mt7927-wifi-support-v2-v3-8-5ca66c97a755@jetm.me>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
 Deren Wu <deren.wu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Marcin FM <marcin@lgic.pl>, Cristian-Florin Radoi <radoi.chris@gmail.com>,
 George Salukvadze <giosal90@gmail.com>, Evgeny Kapusta <3193631@gmail.com>,
 Samu Toljamo <samu.toljamo@gmail.com>,
 Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>,
 Chapuis Dario <chapuisdario4@gmail.com>,
 =?utf-8?q?Thibaut_Fran=C3=A7ois?= <tibo@humeurlibre.fr>,
 =?utf-8?q?=E5=BC=A0=E6=97=AD=E6=B6=B5?= <Loong.0x00@gmail.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4873; i=floss@jetm.me;
 h=from:subject:message-id; bh=d/HKmmehbZuZuFy6yrEQuL+8MJqGQNMTKPsrWPbucdg=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxF1qBQGRj7amcApjljBBVQ0Rz4EZPRXfni7HM
 sWQo/NeM5eJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacRdagAKCRC17sMLqGd3
 H2DCC/9907z+5653Xpjlrv4WpAr1hJGB3hSf8B6CxwCCzbs1b7RNiZ2Nhaz9Q8RVRY1wnkxKpge
 AjJiNb1MWFDd4H0+kAN4utCs9aoBnaSOQ6kTtT+hkNw1waes4/bZ9/wDfLBrIE9zfbH7liLwsQU
 LFstKbv8FIrXu6RC31NWebepK8hN7O5QVmPTiWz1vg294ecvRwBE+MbW5Fvx7lPVWwzcOb4IPng
 fvyh6opbpJy2AJxL2Z2/160/jzGphxDhou+hVl1YzMzHm8Ac8YdEbcmKwEFxqsAAhJjsYxQQp0L
 D/0rblqOcoz0RXmMqH+lqJ80+6UB0GyOV0O69elTNtjZ5k9YWbblJBA9GKdpHW2oqNufgRwywsp
 pIcsmwxEgWIG7zayLFKX+jtNyJ+pe5yOZV/9cquyCC1OVvuNI6WCeEmlP9dUcFiVzbE1R4xLI0m
 pRtL9oQFmt44u8jvWiyqIjwEu6RLvi2Z3AVF5jp+eyO/nl4Z9xzN812KinGT1lA2qRxTo=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me>
References: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me>
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33895-lists,linux-wireless=lfdr.de];
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
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	NEURAL_SPAM(0.00)[0.841];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jetm.me:dkim,jetm.me:email,jetm.me:mid,lgic.pl:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,humeurlibre.fr:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 7795032CFA6
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


