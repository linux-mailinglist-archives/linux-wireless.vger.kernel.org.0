Return-Path: <linux-wireless+bounces-32691-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Pk+DcVyq2m6dAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32691-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:35:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88211229078
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8CC030C4C80
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0FC26D4F7;
	Sat,  7 Mar 2026 00:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="IYezvKXs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KBOEg1A7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F537260F;
	Sat,  7 Mar 2026 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843619; cv=none; b=TiGJKtbPkv6GMGNsDK6tP9BBHCJqLP64LHJ3JUJDQh583wEtECQ4qfatVxSX/pD/vtQb+P5XlnfryPm/7qga3pPliASLHK665onZjNgC37n4tAk4FOWKXVD41sWkRrwq4CdgSkoFKdR8RIbnyp4wJev2WANSWwysnQwXsg4W23g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843619; c=relaxed/simple;
	bh=8zfhMOtWs+2kWv6+lZNYGSFtF0CiUOkcbGyNzxMtulM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=K0zY7QWMMhEscwEYBctdOkTCzL5kYA2xo2Mwd5WE0hRr71aaD6qXuyHywm0f3OSEoa09gljsRBis80jIIwBKDucIVWHtEZ29W6WNJXB9jYGXDrehglpWTpR1tiVsh2je3wDfRk8/2qGOstABXrKUn/8KrXBgzqdd9E1j9ALoFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=IYezvKXs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KBOEg1A7; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id A53F01380A33;
	Fri,  6 Mar 2026 19:33:37 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 19:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772843617;
	 x=1772850817; bh=4LPE2Xh6GFbLLDd1lbS31oigF2wohFyU0b17pySzriw=; b=
	IYezvKXsYWOOT1e34w490FiWBeEHh28UQ5xC8z8/Lu+yb8Vv0bt8yJE9QNYFLFQq
	S2MkcpU+DGDJ72ZKItkdkKje32iJtU37s5oYVYZWAy3r1lO+LEnG3gNNOB+chTNF
	rHF57sIbT6hXmq9QmfvZtlSQTiB/ULhnOnGI9ehPEhJPQ1Eu2xsqX/LKUX5wLau/
	ap20c8roah7jqwsqXKSl434Qzdhf2GCjCySS9n82jvGUjfL++wG+z5ZtO5L3ReHD
	erYiD1SDmSqMQt+8g1+nkQVKTjkJXlYb5i2RmM5O8Jw33KSgcX10b3euqGWV+S+D
	zjX5Alnv5QBmkbdq8UkDCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772843617; x=
	1772850817; bh=4LPE2Xh6GFbLLDd1lbS31oigF2wohFyU0b17pySzriw=; b=K
	BOEg1A7y5EfwGb5ZhMtER4rphrhY3jD4yd6johf9s5iqZ0lnxkv7AxVq0JeMzAd1
	8TdEpodrZogV82VhYFfKVziqzhd+IdlotSx8lShuPngJ0IJrI0Hy2NNKNnQJpYQN
	KkK/0dQ4o6SIDF2eSSrgFSFQUjxzyEnBHJfnqbLvj97u0yNtEDBJQyJSM0Ys5y/M
	j5+LWSa4pFw1Dat9Q3AZd3qoIt4ogs0vZCNWjBfYR8fD02lMb1mjM0rf3Yf32ZOs
	69/wrkBd8PUmuf3dRxip2is6qjbs1nZt+4Lu3DD5xgHcoUFuKC+yRveNWJkGwia/
	V7z2Hx3YgNHRRDR0l0chQ==
X-ME-Sender: <xms:YXKraTVgMJw2sQY1k1QYHLCGOu_kn-SDe86Hsvji7VteFit-yj6MxA>
    <xme:YXKraWZoc3kWfwyFTkUghM2l95VdiFY2TdA9ID70NN5Byk9yt2R6-IruL4EsHxfsR
    s_BxUD6DkFqSI-r5T2yUIB-SrRbqK6TcXavUYfDjyK1UKeTMftOl54>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:YXKraaU1jRHsJPamio8TRtx92HGTyoQQs6OPGBReZLBQvE81suTuxA>
    <xmx:YXKrabcIv-MSgiNHnayCAgXfNKIUTwOETCwtoepQeetQZTNrKb34rw>
    <xmx:YXKrab8wC61_RaFXVXLdFXljY41RRC2cj6GHD1GMIkgqGl4NP5625w>
    <xmx:YXKraTYrRloj1S1XoVP9JG1lOzfZDVvHvX0oJaVrYttV8NEGNMf9Dw>
    <xmx:YXKracS67tvHOBOlaOz4BaiQc7-egpcS_rlTbVH8s9jULsJSvE8OXZ92>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7AB731EA006B; Fri,  6 Mar 2026 19:33:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Fri, 06 Mar 2026 18:33:23 -0600
Subject: [PATCH 04/18] wifi: mt76: mt7925: add MT7927 DMA ring layout, IRQ
 map, and prefetch
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-mt7927-wifi-support-v1-4-c77e7445511d@jetm.me>
To: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Deren Wu <deren.wu@mediatek.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Marcin FM <marcin@lgic.pl>,
 Cristian-Florin Radoi <radoi.chris@gmail.com>,
 George Salukvadze <giosal90@gmail.com>, Evgeny Kapusta <3193631@gmail.com>,
 Samu Toljamo <samu.toljamo@gmail.com>,
 Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>,
 Chapuis Dario <chapuisdario4@gmail.com>,
 =?utf-8?q?Thibaut_Fran=C3=A7ois?= <tibo@humeurlibre.fr>,
 =?utf-8?q?=E5=BC=A0=E6=97=AD=E6=B6=B5?= <Loong.0x00@gmail.com>,
 Javier Tia <floss@jetm.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9458; i=floss@jetm.me;
 h=from:subject:message-id; bh=8zfhMOtWs+2kWv6+lZNYGSFtF0CiUOkcbGyNzxMtulM=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpq3JPDcN4EZIh8w99bmnglLQxhPexUJkRzdoAm
 TLp1O72VFaJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCaatyTwAKCRC17sMLqGd3
 HyiLDAC7XMXjWLxKNV/65He1u/7DAZUZPJVNeWO7WhTWlqQGOh5FHZWWUvXDLHzClDjraxqib5D
 J31/3SsPSC2pLvii8cJnND+mr7IKH5HtlQeEr/dIqDuQ9TaUPL/KISyCOEB0/yALo5RgxpEP2HG
 vhoC9EqjGs6V3BVw1bZC5kcvdhRofH1K8TwrWAXT6Vs/mSJ7UcMs5iiVoFKabRSk16EbvppwSAw
 2+iE6epTe6bjtPgyT91HOTAqd4x1VfqFiWeIbuOIon+O7FzDw9+GRUTWo5D6+x19Qlqr3r4qZMN
 LxQxPptA0wL4TmnbUiNl//j1Y2vsHJaWwrJhv2Myp2fTEF8ICFib85b5+n4hcVzbwIhXO4BOGDi
 GqRBrXK/mUuK0/IzeyPQVxzQFhq9Tt4B2PkbwJIOxMqXoIVj9r8XaETC+Z4np6klUQosj/YGC1j
 4UwL1Pken+1ioHWDyW+imRowsSOc5lTCJrTp32MEMAq4DRQmbjQEkxU+wGyHw2R9YR3do=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
X-Rspamd-Queue-Id: 88211229078
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-32691-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lgic.pl,gmail.com,humeurlibre.fr,jetm.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[floss@jetm.me,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[jetm.me:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,humeurlibre.fr:email,jetm.me:dkim,jetm.me:email,jetm.me:mid,lgic.pl:email]
X-Rspamd-Action: no action

MT7927 uses different DMA ring indices than MT7925:

  - RX MCU events: ring 6 (MT7925 uses ring 0)
  - RX data: ring 4 (MT7925 uses ring 2)
  - RX auxiliary: ring 7 (management frames)
  - TX rings are identical

Add mt7927_dma_init() with the correct ring allocation, a dedicated
mt7927_irq_map with matching interrupt enable bits (BIT(12), BIT(14),
BIT(15) for RX rings 4, 6, 7), and MT7927 packed prefetch register
configuration in mt792x_dma_prefetch().

The DMA init performs a controlled SET_OWN/CLR_OWN sequence after CBTOP
and CBInfra initialization, since CLR_OWN triggers the ROM to initialize
WFDMA.

Ring layout and prefetch values derived from Loong0x00's
reverse-engineered MT7927 driver.

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
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |   7 ++
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    | 131 ++++++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |  18 ++-
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |  10 ++
 4 files changed, 163 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 6b9bf1b89032..ba3d2c4de4ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -126,6 +126,13 @@ enum mt7925_rxq_id {
 	MT7925_RXQ_MCU_WM2, /* for tx done */
 };
 
+/* MT7927 uses different RX ring indices than MT7925 */
+enum mt7927_rxq_id {
+	MT7927_RXQ_BAND0 = 4,
+	MT7927_RXQ_MCU_WM = 6,
+	MT7927_RXQ_DATA2 = 7,
+};
+
 enum {
 	MODE_OPEN = 0,
 	MODE_SHARED = 1,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index c16ec05c5601..ca9ccfe9975c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -324,6 +324,127 @@ static void mt7927_cbtop_remap(struct mt792x_dev *dev)
 	mt76_rr(dev, MT_CBINFRA_MISC0_REMAP_WF);
 }
 
+static int mt7927_dma_init(struct mt792x_dev *dev)
+{
+	int ret;
+
+	mt76_dma_attach(&dev->mt76);
+
+	/* Do SET_OWN -> CLR_OWN now that CBTOP and CBInfra are ready.
+	 * CLR_OWN triggers the ROM to initialize WFDMA properly. */
+	ret = mt792xe_mcu_fw_pmctrl(dev);
+	if (ret)
+		return ret;
+
+	ret = __mt792xe_mcu_drv_pmctrl(dev);
+	if (ret)
+		return ret;
+
+	/* Clear pending interrupts from previous state */
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_STA, ~0);
+
+	/* Disable DMA */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
+		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+	wmb();
+
+	if (!mt76_poll_msec_tick(dev, MT_WFDMA0_GLO_CFG,
+				 MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
+				 MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 100, 1))
+		return -ETIMEDOUT;
+
+	/* Reset DMA descriptor pointers */
+	mt76_wr(dev, MT_WFDMA0_RST_DTX_PTR, ~0);
+	mt76_wr(dev, MT_WFDMA0_RST_DRX_PTR, ~0);
+	wmb();
+	msleep(10);
+
+	/* init tx queue - ring 0 */
+	ret = mt76_connac_init_tx_queues(dev->phy.mt76, MT7925_TXQ_BAND0,
+					 MT7925_TX_RING_SIZE,
+					 MT_TX_RING_BASE, NULL, 0);
+	if (ret)
+		return ret;
+
+	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, 0x4);
+
+	/* command to WM - ring 15 */
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM,
+				  MT7925_TXQ_MCU_WM,
+				  MT7925_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
+	if (ret)
+		return ret;
+
+	/* firmware download - ring 16 */
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_FWDL,
+				  MT7925_TXQ_FWDL,
+				  MT7925_TX_FWDL_RING_SIZE, MT_TX_RING_BASE);
+	if (ret)
+		return ret;
+
+	/* rx MCU events - ring 6 (MT7925 uses ring 0) */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU],
+			       MT7927_RXQ_MCU_WM, MT7925_RX_MCU_RING_SIZE,
+			       MT_RX_BUF_SIZE, MT_RX_EVENT_RING_BASE);
+	if (ret)
+		return ret;
+
+	/* rx data - ring 4 (MT7925 uses ring 2) */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
+			       MT7927_RXQ_BAND0, MT7925_RX_RING_SIZE,
+			       MT_RX_BUF_SIZE, MT_RX_DATA_RING_BASE);
+	if (ret)
+		return ret;
+
+	/* rx auxiliary - ring 7: management frames */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
+			       MT7927_RXQ_DATA2, MT7925_RX_MCU_RING_SIZE,
+			       MT_RX_BUF_SIZE, MT_RX_DATA_RING_BASE);
+	if (ret)
+		return ret;
+
+	ret = mt76_init_queues(dev, mt792x_poll_rx);
+	if (ret < 0)
+		return ret;
+
+	netif_napi_add_tx(dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+			  mt792x_poll_tx);
+	napi_enable(&dev->mt76.tx_napi);
+
+	/* MT7927-specific GLO_CFG bits before DMA enable */
+	mt76_set(dev, MT_WFDMA0_GLO_CFG, BIT(26));   /* ADDR_EXT_EN */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG, BIT(20)); /* CSR_LBK_RX_Q_SEL_EN */
+	mt76_set(dev, MT_WFDMA0_GLO_CFG_EXT1, BIT(28));
+	mt76_set(dev, MT_WFDMA0_GLO_CFG,
+		 MT_WFDMA0_GLO_CFG_FW_DWLD_BYPASS_DMASHDL);
+
+	ret = mt792x_dma_enable(dev);
+	if (ret)
+		return ret;
+
+	/* Enable interrupts synchronously */
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, dev->mt76.mmio.irqmask);
+
+	return 0;
+}
+
+static const struct mt792x_irq_map mt7927_irq_map = {
+	.host_irq_enable = MT_WFDMA0_HOST_INT_ENA,
+	.tx = {
+		.all_complete_mask = MT_INT_TX_DONE_ALL,
+		.mcu_complete_mask = MT_INT_TX_DONE_MCU,
+	},
+	.rx = {
+		.data_complete_mask = HOST_RX_DONE_INT_ENA4,
+		.wm_complete_mask = HOST_RX_DONE_INT_ENA6,
+		.wm2_complete_mask = HOST_RX_DONE_INT_ENA7,
+	},
+};
+
 static int mt7925_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -417,7 +538,10 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	dev = container_of(mdev, struct mt792x_dev, mt76);
 	dev->fw_features = features;
 	dev->hif_ops = &mt7925_pcie_ops;
-	dev->irq_map = &irq_map;
+	if (is_mt7927_hw)
+		dev->irq_map = &mt7927_irq_map;
+	else
+		dev->irq_map = &irq_map;
 	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
 	tasklet_init(&mdev->irq_tasklet, mt792x_irq_tasklet, (unsigned long)dev);
 
@@ -489,7 +613,10 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_dev;
 
-	ret = mt7925_dma_init(dev);
+	if (is_mt7927_hw)
+		ret = mt7927_dma_init(dev);
+	else
+		ret = mt7925_dma_init(dev);
 	if (ret)
 		goto err_free_irq;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
index 1ddec7788b66..3177c6cc6eb5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -90,7 +90,23 @@ EXPORT_SYMBOL_GPL(mt792x_rx_poll_complete);
 #define PREFETCH(base, depth)	((base) << 16 | (depth))
 static void mt792x_dma_prefetch(struct mt792x_dev *dev)
 {
-	if (is_mt7925(&dev->mt76)) {
+	if (is_mt7927(&dev->mt76)) {
+		/* Trigger prefetch controller reset before reprogramming */
+		mt76_wr(dev, MT_WFDMA_PREFETCH_CTRL,
+			mt76_rr(dev, MT_WFDMA_PREFETCH_CTRL));
+		/* MT7927 uses packed prefetch registers */
+		mt76_wr(dev, MT_WFDMA_PREFETCH_CFG0, 0x660077);
+		mt76_wr(dev, MT_WFDMA_PREFETCH_CFG1, 0x1100);
+		mt76_wr(dev, MT_WFDMA_PREFETCH_CFG2, 0x30004f);
+		mt76_wr(dev, MT_WFDMA_PREFETCH_CFG3, 0x542200);
+		/* per-ring EXT_CTRL */
+		mt76_wr(dev, MT_WFDMA0_RX_RING4_EXT_CTRL, PREFETCH(0x0000, 0x8));
+		mt76_wr(dev, MT_WFDMA0_RX_RING6_EXT_CTRL, PREFETCH(0x0080, 0x8));
+		mt76_wr(dev, MT_WFDMA0_RX_RING7_EXT_CTRL, PREFETCH(0x0100, 0x4));
+		mt76_wr(dev, MT_WFDMA0_TX_RING16_EXT_CTRL, PREFETCH(0x0140, 0x4));
+		mt76_wr(dev, MT_WFDMA0_TX_RING15_EXT_CTRL, PREFETCH(0x0180, 0x10));
+		mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, PREFETCH(0x0280, 0x4));
+	} else if (is_mt7925(&dev->mt76)) {
 		/* rx ring */
 		mt76_wr(dev, MT_WFDMA0_RX_RING0_EXT_CTRL, PREFETCH(0x0000, 0x4));
 		mt76_wr(dev, MT_WFDMA0_RX_RING1_EXT_CTRL, PREFETCH(0x0040, 0x4));
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index 0f75dca0a96c..5497cfaab8d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -363,6 +363,16 @@
 #define MT_WFDMA_EXT_CSR_HIF_MISC	MT_WFDMA_EXT_CSR(0x44)
 #define MT_WFDMA_EXT_CSR_HIF_MISC_BUSY	BIT(0)
 
+/* MT7927 packed prefetch registers */
+#define MT_WFDMA_PREFETCH_CTRL		MT_WFDMA_EXT_CSR(0x30)
+#define MT_WFDMA_PREFETCH_CFG0		MT_WFDMA_EXT_CSR(0xf0)
+#define MT_WFDMA_PREFETCH_CFG1		MT_WFDMA_EXT_CSR(0xf4)
+#define MT_WFDMA_PREFETCH_CFG2		MT_WFDMA_EXT_CSR(0xf8)
+#define MT_WFDMA_PREFETCH_CFG3		MT_WFDMA_EXT_CSR(0xfc)
+
+/* MT7927 GLO_CFG extended register */
+#define MT_WFDMA0_GLO_CFG_EXT1		MT_WFDMA0(0x2b4)
+
 #define MT_SWDEF_BASE			0x41f200
 #define MT_SWDEF(ofs)			(MT_SWDEF_BASE + (ofs))
 #define MT_SWDEF_MODE			MT_SWDEF(0x3c)

-- 
2.53.0


