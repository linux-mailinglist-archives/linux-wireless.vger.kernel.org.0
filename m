Return-Path: <linux-wireless+bounces-32690-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C25BWhyq2m6dAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32690-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:33:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD499229026
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F64A30244F6
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CE2211A05;
	Sat,  7 Mar 2026 00:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="np3ZPoHw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FiwlW65y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D90221FF23;
	Sat,  7 Mar 2026 00:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843619; cv=none; b=EQMbO02JujJsAmvurBwNDH1SPIiRwH2VFCpKmiA6abSb4D2lA+GpNgm0F+BkIwAV901RNrIJuqauB8WTq9ZXAb3eqDY94jtketfbA5CIDFOZhoJ4DoH+gaWbR5jUopAzptFvaD7ClXeygSXnUPFuO4Ge8NkN/eTDOBPmSWsJAjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843619; c=relaxed/simple;
	bh=rHhSd4Kdv2//ivF8/gVZZBl8JUQawv/PcEjbvOPS57g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=t7JvzDwom+gzRLkx9ZI3yl3n9RP2WFr5XHeLxWpTL4QrIkW4snIq8y0Z3vV4HlA0VU5+COZvWAFZunB17tHIerCAshCWKvtOu20LowLSND4jWEy1gRIdsp4y6sd8ocAUBlCjrD1Fgm4IIpJS4nTx9HjRjQevOwHgcmypt4+aZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=np3ZPoHw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FiwlW65y; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id B3EC21380A22;
	Fri,  6 Mar 2026 19:33:34 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 19:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772843614;
	 x=1772850814; bh=HiWZdv/LQon9ciOmz8L9DqJkjYY985xynxWS3KIjPSk=; b=
	np3ZPoHwXmTyEq1m72lYNp8H+7SMN46wd3cJm6t78op4kUuqCF7sfpxAg3/xXfU7
	D+OJcSHUwiz9/V0MK7uiTLFhPKK1Y8CgVL+CMuV96Caq3AOm/lZFtaXiv2DuLwjv
	Krk75552LVdL42nDKogXi8Z6Xoyuu9CXldKyTQrtPoh/EpObJEAOz2issoVGJuFv
	zXF+cL3p277jJP877HXBFxRt6tg8FHrU6VF5dkBne6IzQ182kXgz9HinoI6HW22/
	+yAOMh4jm7tkQLpjIrIFPzIbmclZFHbgBaN24AmwHIUgReKc7LqO1Jpt/6CuljPK
	XKhmM1ns2rbfV8j7a/ADIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772843614; x=
	1772850814; bh=HiWZdv/LQon9ciOmz8L9DqJkjYY985xynxWS3KIjPSk=; b=F
	iwlW65yXbD000N9vjHc5klXYmv3jpNIJQFk3XkUFxeHiDD2d5JX9GbOeiaogc38t
	iOo/CjuPJZ/gRf4pRlZdX8e5XFLJCPlxHFot+PgWLj7A2IKqeRsv59WFqHh8VcMs
	xE9rRpHPDw76xlpxfoFqRfUuC5+YDBH+VODSpdsaBMr/HN3OAsM/5Zp+qfPnbEsd
	7JMDBwx7ty6edvwHnugbPgIhWn/H1k9jxtyquQNPmQN/cHWiUT3gPk7j+pYGK10D
	WgCIkLfpovEjYiEJ/X+UeuMi2V6Ziru9CwGXP9FNzqA6L5W5radqdz9EybUhEvh7
	T8F/05gkWM3Y5wd3WLMlg==
X-ME-Sender: <xms:XnKradj11XNIPkN-7Jd3E1tsVvFgaGtIU9geQvtnCfzArfUJADds0A>
    <xme:XnKrac2QqFtquTNKZ3xvFV6OYk8wBBFd-GYMXw1CQN-pS0H63bs8HnGupnfavDGnQ
    _RluTmREbHTepSXSj7TqlcWpXDQgymQrus-tLbkttUMHSAiZj-KCt7f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:XnKraTgTVh1BQj6yIIwAwbvTW0aHW_d5nYCi0HykUiCMpS6tH8yvbQ>
    <xmx:XnKraU5y2xyra8UN_xtK_01OsejEcE7Rl228E9FwjZVNDuyI1RwcrA>
    <xmx:XnKraQrQNc6zql9upiUWLPTrjrdAdkm-S5wLbmboSYczqexGkD_RWg>
    <xmx:XnKraSVgracYJG7UFEGJD6j_wQt-AktiqT6G_K1xdjrWGIT9BQo3mA>
    <xmx:XnKrafOa9oLUEo63Hvm4-HXDQm8S51nAYQoidzDpSoj7ag1Yjslx9jKE>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 892261EA0070; Fri,  6 Mar 2026 19:33:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Fri, 06 Mar 2026 18:33:22 -0600
Subject: [PATCH 03/18] wifi: mt76: mt7925: add MT7927 CBTOP remap and chip
 initialization
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-mt7927-wifi-support-v1-3-c77e7445511d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6368; i=floss@jetm.me;
 h=from:subject:message-id; bh=rHhSd4Kdv2//ivF8/gVZZBl8JUQawv/PcEjbvOPS57g=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpq3JPiyrKKOKSdFctyZX6j9LnVVIbQdR/FmRNQ
 nClxj9OT+GJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCaatyTwAKCRC17sMLqGd3
 H55GC/4kCCBCugnVE0/RXqAfWcKJ5DSglTPod2jfqYQbEnnhPT3PdYWnMvJAHlxBiXiTHY9AtGw
 kSZZpM6vraTDpC7xP0WsKS+Tw0bz98W0TU30EF+MUgNHT3rDdfwYW7cG2x9HM1jWtVREIpzq4j5
 OcIPQtjBAHxdObMXXl4COgMPQkSHGU1RAc1qcSEgTodFvVdZTKPRj6Y7Ins339Zvok+Fe2petSJ
 b8QTnekCO80z3DMApwi2I3twVhU6ZurjjjX79rai2HzBICa1dRDMF3xnkQ/M1FcUlOGL5BTJmdC
 VGmzdtGUBX9M0RfuE1b7ELnUPL+loiyIwJrnAlK7eMA6DRtP+6AwVHewlbdB6QzvJWYeYwvASv7
 SfQC5jyFNclvuX/T8eYO4plFk0RxnUrgZS3ji4opKcHDR7Ru7MgAA7rZAeoBkxXwAKFJHvZSHuv
 +KeGLgOkEsgGS3otYn1SPl3v+FR7IuNyPIau023tXITpNvDyoWxfdP9CV1VYXub5GLQ6E=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
X-Rspamd-Queue-Id: AD499229026
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-32690-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jetm.me:dkim,jetm.me:email,jetm.me:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

The MT7927 combo chip has an additional bus fabric called CBInfra
(ConnectaBus Infrastructure) between PCIe and the WiFi subsystem.
Without configuring the CBTOP address remap, all MMIO reads to WiFi
registers return zero.

Add mt7927_cbtop_remap() to configure the PCIe address mapping for WiFi
and Bluetooth subsystems, and mt7927_chip_init() to perform the CBInfra
initialization sequence:

  1. EMI sleep protect enable
  2. WF subsystem reset via CBInfra RGU
  3. MCU ownership acquisition
  4. Poll ROMCODE_INDEX for MCU idle (0x1D1E)
  5. MCIF remap for host DMA
  6. PCIe sleep disable

Skip the early CLR_OWN in probe for MT7927 since CBTOP remap is not yet
configured at that point - the ROM's WFDMA init would fail.

Register values derived from Loong0x00's reverse-engineered MT7927
driver.

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
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 90 ++++++++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h | 18 +++++
 2 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 54eac5c6e509..c16ec05c5601 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -270,6 +270,60 @@ static int mt7925_dma_init(struct mt792x_dev *dev)
 	return mt792x_dma_enable(dev);
 }
 
+static int mt7927_chip_init(struct mt792x_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	u32 val;
+
+	/* EMI sleep protect */
+	mt76_rmw_field(dev, MT_HW_EMI_CTL, MT_HW_EMI_CTL_SLPPROT_EN, 1);
+
+	/* WF subsystem reset via CBInfra RGU */
+	mt76_set(dev, MT_CBINFRA_RGU_WF_RST, MT_CBINFRA_RGU_WF_RST_WF_SUBSYS);
+	msleep(1);
+	mt76_clear(dev, MT_CBINFRA_RGU_WF_RST,
+		   MT_CBINFRA_RGU_WF_RST_WF_SUBSYS);
+	msleep(5);
+
+	/* MCU ownership */
+	mt76_wr(dev, MT_CBINFRA_MCU_OWN_SET, BIT(0));
+
+	/* Poll ROMCODE_INDEX for MCU idle */
+	if (!__mt76_poll_msec(mdev, MT_ROMCODE_INDEX,
+			      0xffff, MT_MCU_IDLE_VALUE, 2000)) {
+		val = mt76_rr(dev, MT_ROMCODE_INDEX);
+		dev_err(mdev->dev,
+			"MT7927 MCU idle timeout (ROMCODE_INDEX=0x%04x)\n",
+			val & 0xffff);
+		return -ETIMEDOUT;
+	}
+
+	/* MCIF remap - MCU needs this to DMA to host memory */
+	mt76_wr(dev, MT_MCIF_REMAP_WF_1_BA, MT_MCIF_REMAP_WF_1_BA_VAL);
+
+	/* Disable PCIe sleep */
+	mt76_wr(dev, MT_CBINFRA_SLP_CTRL, 0xffffffff);
+
+	/* Clear CONNINFRA wakeup */
+	mt76_wr(dev, MT_CBINFRA_WAKEPU_TOP, 0x0);
+
+	return 0;
+}
+
+static void mt7927_cbtop_remap(struct mt792x_dev *dev)
+{
+	/* CONNINFRA wakeup - required before CBInfra register access */
+	mt76_wr(dev, MT_CBINFRA_WAKEPU_TOP, 0x1);
+	usleep_range(1000, 2000);
+
+	/* Configure CBTOP PCIe address remap for WF and BT */
+	mt76_wr(dev, MT_CBINFRA_MISC0_REMAP_WF, MT_CBINFRA_REMAP_WF_VAL);
+	mt76_wr(dev, MT_CBINFRA_MISC0_REMAP_BT, MT_CBINFRA_REMAP_BT_VAL);
+
+	/* Readback to push writes */
+	mt76_rr(dev, MT_CBINFRA_MISC0_REMAP_WF);
+}
+
 static int mt7925_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -314,6 +368,7 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	struct mt76_bus_ops *bus_ops;
 	struct mt792x_dev *dev;
 	struct mt76_dev *mdev;
+	bool is_mt7927_hw;
 	u8 features;
 	int ret;
 	u16 cmd;
@@ -385,24 +440,45 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	if (!mt7925_disable_aspm && mt76_pci_aspm_supported(pdev))
 		dev->aspm_supported = true;
 
+	is_mt7927_hw = (pdev->device == 0x6639 || pdev->device == 0x7927);
+
 	ret = __mt792x_mcu_fw_pmctrl(dev);
 	if (ret)
 		goto err_free_dev;
 
-	ret = __mt792xe_mcu_drv_pmctrl(dev);
-	if (ret)
-		goto err_free_dev;
+	if (!is_mt7927_hw) {
+		ret = __mt792xe_mcu_drv_pmctrl(dev);
+		if (ret)
+			goto err_free_dev;
+	}
+
+	if (is_mt7927_hw)
+		mt7927_cbtop_remap(dev);
 
 	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
 
 	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
-	mt76_rmw_field(dev, MT_HW_EMI_CTL, MT_HW_EMI_CTL_SLPPROT_EN, 1);
+	/* Force chip ID for MT7927 hardware if CHIPID read returns garbage */
+	if (is_mt7927_hw && (mdev->rev >> 16) != 0x7927) {
+		dev_info(mdev->dev,
+			 "MT7927 raw CHIPID=0x%04x, forcing chip=0x7927\n",
+			 (u16)(mdev->rev >> 16));
+		mdev->rev = (0x7927 << 16) | (mdev->rev & 0xff);
+	}
 
-	ret = mt792x_wfsys_reset(dev);
-	if (ret)
-		goto err_free_dev;
+	if (is_mt7927_hw) {
+		ret = mt7927_chip_init(dev);
+		if (ret)
+			goto err_free_dev;
+	} else {
+		mt76_rmw_field(dev, MT_HW_EMI_CTL,
+			       MT_HW_EMI_CTL_SLPPROT_EN, 1);
+		ret = mt792x_wfsys_reset(dev);
+		if (ret)
+			goto err_free_dev;
+	}
 
 	mt76_wr(dev, irq_map.host_irq_enable, 0);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index acf627aed609..0f75dca0a96c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -484,4 +484,22 @@
 #define WFSYS_SW_RST_B			BIT(0)
 #define WFSYS_SW_INIT_DONE		BIT(4)
 
+/* CBInfra registers - MT7927 combo chip */
+#define MT_CBINFRA_WAKEPU_TOP		0xe01a0
+#define MT_CBINFRA_MISC0_REMAP_WF	0x1f6554
+#define MT_CBINFRA_MISC0_REMAP_BT	0x1f6558
+#define MT_CBINFRA_RGU_WF_RST		0x1f8600
+#define MT_CBINFRA_RGU_WF_RST_WF_SUBSYS	BIT(4)
+#define MT_CBINFRA_MCU_OWN_SET		0x1f5034
+#define MT_CBINFRA_SLP_CTRL		0x1f5018
+#define MT_ROMCODE_INDEX		0xc1604
+#define MT_MCU_IDLE_VALUE		0x1d1e
+#define MT_MCIF_REMAP_WF_1_BA		0xd1034
+
+/* CBInfra CBTOP remap values */
+#define MT_CBINFRA_REMAP_WF_VAL	0x74037001
+#define MT_CBINFRA_REMAP_BT_VAL	0x70007000
+
+#define MT_MCIF_REMAP_WF_1_BA_VAL	0x18051803
+
 #endif /* __MT792X_REGS_H */

-- 
2.53.0


