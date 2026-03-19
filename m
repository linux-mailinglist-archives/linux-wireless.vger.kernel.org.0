Return-Path: <linux-wireless+bounces-33525-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MhyHgN5vGnOzAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33525-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:30:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA422D2FA3
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9787E3038D6A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 22:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA51340B6EB;
	Thu, 19 Mar 2026 22:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="WgTOauF1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PPhHwpCE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238DF407599;
	Thu, 19 Mar 2026 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959088; cv=none; b=PybD9FV1hesM5Guk2vsABpN+mRL+IDi2grBwOp7fcT85T0vfgtc6mdwzMqnAVqcvO38lFROLX9KMnVcErGd+3wWIZadCaQD35eaI5iWPzEJ+bBMGFbZP+ceuvEcMQsoSmp/HuuBDcG87vBQfHhsBif3hTVU6umICslStc9RrsmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959088; c=relaxed/simple;
	bh=wWU757xwqx0hIgj80GlHGMOCQOT/7mAO0JYyHm76zMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=R4T8gH+mkziuytk2gbWxQ+x8wU7VddAogRHjdndFzGSm7Cp2k7Ts2pWChEIHwckFgonJ/Kl4vB9AZ1f+1GlR1nGGuH1G5vOX82TPJeYeOBCqEMwAqdsXbrzOZ5nkG+lfYZblkm8LF/kap8/+uHA1kzwqaurc3UQgW/iEl7zC1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=WgTOauF1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PPhHwpCE; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id C599913000B8;
	Thu, 19 Mar 2026 18:24:39 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 18:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773959079;
	 x=1773966279; bh=Cv1Q21xYQCzqAdOrD0pUBrfpzc3E8jkE3eBpHTTz4LM=; b=
	WgTOauF1IbI4pckz7dq/ysMtl6er7hMTK4hJd6s4YZketEUld3sViDjrHUI4GfqM
	2R5WzFqgwJM4klw+cwfYtpotZpV52KE7ZkEp3s0ufoFsH7zFxDd0blZQTns8oEAj
	aJnlrxW/3ZflVSGFVdnHb/iqS7wz6Wyk+kwandsHwCMCU3LkuCi71kXK2e+4YJaB
	U+8Re0ptv7VuqeYhFIVLpj0v2BB259l4D/tIKs9KrNpBZcoeMjDUC5qU2DqFjASn
	ghr3/D3Y1G5nNcIK03Z9aiczwuH49xOmvFN+h0J4gYm0GlnI7fHZbbuxopH6AD/q
	8LlebrUdAogmnQEK29WI1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773959079; x=
	1773966279; bh=Cv1Q21xYQCzqAdOrD0pUBrfpzc3E8jkE3eBpHTTz4LM=; b=P
	PhHwpCEV2Yi9UrV4e+CviH4rYMTiL3G5LK7gxtOKd/O0ceXYuo7GtAF9Rtq41Bso
	CrlkzW17hVccH04e0HoTIjGn4+Yhl86mA5LLSvEE8qNJ2IIGAh+7feHFhz+4lRuW
	z+U1m8xwvvqkZQaeuMh46aoBX9B/NM8WOzrWxkalz1DkJaTITEdFBhGMVFGTaQ8/
	STATJzkCtoy+U4NTJIrinF2Wh7keEgX2IgZNQ3qftmoCIAbseH3NqTxYgEzBZMz7
	5bmfo6sOicr+Emk3GaRi8+3Q4UFjkO+lblEk1cZIBGlhDufPz67oDvwiiXwZkSbL
	9N8PdYIBMOfjQvGNs8EoA==
X-ME-Sender: <xms:p3e8aXEdipFaQS82pUg2gm3BSOARol1ijjA1obPdrJ-vPQMxtWJbzA>
    <xme:p3e8afLi_As9uvmkbCvZ2wXEgslJrGMbh3wng6CV0UX6qArRJdf7W32Dsdx4VKu0c
    rUIia8MXMm8vZcgf-ilLw3MArBy92JkXMRAp5MfWcSU7FX2uT8-ppY>
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
X-ME-Proxy: <xmx:p3e8aXUsEvb_Ek3FIJiX1Bca9-ySHy7b1yOgyE7x91m8_-IciFncYw>
    <xmx:p3e8acxiwqGcYg9SGDaAoG-fIpxz7m4XXDb-DQOUkob83h85lttXhg>
    <xmx:p3e8aX7RTnjIAg5dd5v65SuJDzC0GyezqRD8zlnC3vEol0Eh1HakcA>
    <xmx:p3e8aehtt4O2ipvm7pTr8CPD5-6KxWkHbVR3FAvjMNOZ170VGalKsQ>
    <xmx:p3e8aQU-jKGPvO8dUCa4gUKpaPrub_9JnCoOSz3WAT-CUe9yQbl4fnB0>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 738511EA006B; Thu, 19 Mar 2026 18:24:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 19 Mar 2026 16:24:25 -0600
Subject: [PATCH v2 09/13] wifi: mt76: mt7925: add chip-specific DMA
 configuration
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260319-mt7927-wifi-support-v2-v2-9-d627a7fad70d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15351; i=floss@jetm.me;
 h=from:subject:message-id; bh=wWU757xwqx0hIgj80GlHGMOCQOT/7mAO0JYyHm76zMY=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpvHeRk5L8bLqemJVkHg048H/m7S/ySdOZjwHAL
 Kx+qdNHm+KJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCabx3kQAKCRC17sMLqGd3
 H6MHDACKqS6CSqcHB29kjIqeXpfUJy4LZjxohA5nRH2e2ydbOTJp7TW7vfV+fOgPHm0tEgPL9ZX
 eTt+EGuZPSxwW4eZKWTCqjWSmNm/ae7CcwOeWO9mk425czgZiitPmE3Csj606AeKRxZ/CJ5Qc4g
 H/g9OIP4DLMM9xzqTIlTBGOppfhx6UaUYSaOufLfoVdCQzTR8fAKPkHuppgsa2jR3X0Lh/8lP4V
 FlmTzlFxBSV05jwLH95bIlCqhO1ohgJpZ8lohpR7UBCJ+uEmcsARSMfHEtgN4v/jtkpPtzhoDOX
 VHT9+KCzJyQwtctXhYnD8Pn4uOfb+NgPmFotVRbhbYrvZpUpEXsCCHX4MLyRZc6hPLpIYCEYogW
 3zLkBA5hELvRTP5AV733oLD1XPOZLGlJyBfFUmIQKcgqIZKV+KgJt1CVLlWIcC+8beFZsUfKaz0
 4ByX1zCdHLI4aMZGti7hLzM4TdeY9C4yXPVrJ1lWFfn3Hu7x1vhEJtHswF88jHCI061bk=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
References: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-33525-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lgic.pl,gmail.com,humeurlibre.fr];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[floss@jetm.me,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[jetm.me:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.331];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,lgic.pl:email,jetm.me:dkim,jetm.me:email,jetm.me:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,humeurlibre.fr:email]
X-Rspamd-Queue-Id: 7AA422D2FA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MT7927 uses different DMA ring indices (RX rings 4, 6, 7 vs MT7925's
0, 1, 2), a different prefetch register layout, and requires additional
GLO_CFG bits (ADDR_EXT_EN, FW_DWLD_BYPASS_DMASHDL) that must be
restored after every PM wake cycle.

Introduce struct mt792x_dma_config to parameterize per-chip DMA
differences:
  - RX ring indices for MCU events, data, and auxiliary queues
  - Prefetch configuration callback
  - GLO_CFG quirk bits (set/clear masks applied after DMA enable)
  - Pre-ring-setup hook for MT7927's SET_OWN/CLR_OWN sequence

Refactor mt7925_dma_init() to read ring indices from the config struct,
eliminating the need for a standalone mt7927_dma_init(). The single
init function handles both chips by dispatching through the config.

Update mt792x_dma_enable() to apply chip-specific GLO_CFG bits from the
config and select the correct GLO_CFG_EXT1 register address per chip.

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
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 137 +++++++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt792x.h      |  21 ++++
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c  |  68 +++++------
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h |  12 ++
 4 files changed, 198 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 604c0e9ae7ba..415194a440f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -210,17 +210,128 @@ static u32 mt7925_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
 	return dev->bus_ops->rmw(mdev, addr, mask, val);
 }
 
+/* MT7927 uses different RX ring indices than MT7925 */
+enum mt7927_rxq_id {
+	MT7927_RXQ_BAND0 = 4,
+	MT7927_RXQ_MCU_WM = 6,
+	MT7927_RXQ_DATA2 = 7,
+};
+
+#define PREFETCH(base, depth)	((base) << 16 | (depth))
+
+static void mt7925_dma_prefetch(struct mt792x_dev *dev)
+{
+	/* rx ring */
+	mt76_wr(dev, MT_WFDMA0_RX_RING0_EXT_CTRL, PREFETCH(0x0000, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING1_EXT_CTRL, PREFETCH(0x0040, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING2_EXT_CTRL, PREFETCH(0x0080, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING3_EXT_CTRL, PREFETCH(0x00c0, 0x4));
+	/* tx ring */
+	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, PREFETCH(0x0100, 0x10));
+	mt76_wr(dev, MT_WFDMA0_TX_RING1_EXT_CTRL, PREFETCH(0x0200, 0x10));
+	mt76_wr(dev, MT_WFDMA0_TX_RING2_EXT_CTRL, PREFETCH(0x0300, 0x10));
+	mt76_wr(dev, MT_WFDMA0_TX_RING3_EXT_CTRL, PREFETCH(0x0400, 0x10));
+	mt76_wr(dev, MT_WFDMA0_TX_RING15_EXT_CTRL, PREFETCH(0x0500, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING16_EXT_CTRL, PREFETCH(0x0540, 0x4));
+}
+
+static void mt7927_dma_prefetch(struct mt792x_dev *dev)
+{
+	/* Trigger prefetch controller reset before reprogramming */
+	mt76_wr(dev, MT_WFDMA_PREFETCH_CTRL,
+		mt76_rr(dev, MT_WFDMA_PREFETCH_CTRL));
+	/* MT7927 uses packed prefetch registers */
+	mt76_wr(dev, MT_WFDMA_PREFETCH_CFG0, 0x660077);
+	mt76_wr(dev, MT_WFDMA_PREFETCH_CFG1, 0x1100);
+	mt76_wr(dev, MT_WFDMA_PREFETCH_CFG2, 0x30004f);
+	mt76_wr(dev, MT_WFDMA_PREFETCH_CFG3, 0x542200);
+	/* per-ring EXT_CTRL */
+	mt76_wr(dev, MT_WFDMA0_RX_RING4_EXT_CTRL, PREFETCH(0x0000, 0x8));
+	mt76_wr(dev, MT_WFDMA0_RX_RING6_EXT_CTRL, PREFETCH(0x0080, 0x8));
+	mt76_wr(dev, MT_WFDMA0_RX_RING7_EXT_CTRL, PREFETCH(0x0100, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING16_EXT_CTRL, PREFETCH(0x0140, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING15_EXT_CTRL, PREFETCH(0x0180, 0x10));
+	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, PREFETCH(0x0280, 0x4));
+}
+
+static int mt7927_pre_ring_setup(struct mt792x_dev *dev)
+{
+	int ret;
+
+	/* SET_OWN -> CLR_OWN: triggers ROM to initialize WFDMA */
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
+	return 0;
+}
+
+static const struct mt792x_dma_config mt7925_dma_cfg = {
+	.rxq_band0 = MT7925_RXQ_BAND0,		/* 2 */
+	.rxq_mcu_wm = MT7925_RXQ_MCU_WM,	/* 0 */
+	.dma_prefetch = mt7925_dma_prefetch,
+	.glo_cfg_ext1 = MT_UWFDMA0_GLO_CFG_EXT1,
+};
+
+static const struct mt792x_dma_config mt7927_dma_cfg = {
+	.rxq_band0 = MT7927_RXQ_BAND0,		/* 4 */
+	.rxq_mcu_wm = MT7927_RXQ_MCU_WM,	/* 6 */
+	.rxq_data2 = MT7927_RXQ_DATA2,		/* 7 */
+	.dma_prefetch = mt7927_dma_prefetch,
+	.glo_cfg_set = MT_WFDMA0_GLO_CFG_ADDR_EXT_EN |
+		       MT_WFDMA0_GLO_CFG_FW_DWLD_BYPASS_DMASHDL,
+	.glo_cfg_clear = MT_WFDMA0_GLO_CFG_CSR_LBK_RX_Q_SEL_EN,
+	.glo_cfg_ext1 = MT_WFDMA0_GLO_CFG_EXT1,
+	.pre_ring_setup = mt7927_pre_ring_setup,
+};
+
 static int mt7925_dma_init(struct mt792x_dev *dev)
 {
+	const struct mt792x_dma_config *cfg = dev->dma_config;
 	int ret;
 
 	mt76_dma_attach(&dev->mt76);
 
-	ret = mt792x_dma_disable(dev, true);
-	if (ret)
-		return ret;
+	if (cfg->pre_ring_setup) {
+		ret = cfg->pre_ring_setup(dev);
+		if (ret)
+			return ret;
 
-	/* init tx queue */
+		/* Disable DMA before ring allocation */
+		mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+			   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+			   MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+			   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
+			   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+			   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+		/* Ensure all DMA writes complete before polling status. */
+		wmb();
+
+		if (!mt76_poll_msec_tick(dev, MT_WFDMA0_GLO_CFG,
+					MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
+					MT_WFDMA0_GLO_CFG_RX_DMA_BUSY,
+					0, 100, 1))
+			return -ETIMEDOUT;
+
+		mt76_wr(dev, MT_WFDMA0_RST_DTX_PTR, ~0);
+		mt76_wr(dev, MT_WFDMA0_RST_DRX_PTR, ~0);
+		/* Ensure all DMA writes complete before polling status. */
+		wmb();
+		msleep(10);
+	} else {
+		ret = mt792x_dma_disable(dev, true);
+		if (ret)
+			return ret;
+	}
+
+	/* init tx queue - ring 0 */
 	ret = mt76_connac_init_tx_queues(dev->phy.mt76, MT7925_TXQ_BAND0,
 					 MT7925_TX_RING_SIZE,
 					 MT_TX_RING_BASE, NULL, 0);
@@ -241,20 +352,31 @@ static int mt7925_dma_init(struct mt792x_dev *dev)
 	if (ret)
 		return ret;
 
-	/* rx event */
+	/* rx MCU events */
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU],
-			       MT7925_RXQ_MCU_WM, MT7925_RX_MCU_RING_SIZE,
+			       cfg->rxq_mcu_wm, MT7925_RX_MCU_RING_SIZE,
 			       MT_RX_BUF_SIZE, MT_RX_EVENT_RING_BASE);
 	if (ret)
 		return ret;
 
 	/* rx data */
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
-			       MT7925_RXQ_BAND0, MT7925_RX_RING_SIZE,
+			       cfg->rxq_band0, MT7925_RX_RING_SIZE,
 			       MT_RX_BUF_SIZE, MT_RX_DATA_RING_BASE);
 	if (ret)
 		return ret;
 
+	/* rx auxiliary data (MT7927: management frames on ring 7) */
+	if (cfg->rxq_data2) {
+		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
+				       cfg->rxq_data2,
+				       MT7925_RX_MCU_RING_SIZE,
+				       MT_RX_BUF_SIZE,
+				       MT_RX_DATA_RING_BASE);
+		if (ret)
+			return ret;
+	}
+
 	ret = mt76_init_queues(dev, mt792x_poll_rx);
 	if (ret < 0)
 		return ret;
@@ -373,6 +495,7 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	dev->hif_ops = &mt7925_pcie_ops;
 	is_mt7927_hw = (pdev->device == 0x6639 || pdev->device == 0x7927);
 	dev->irq_map = is_mt7927_hw ? &mt7927_irq_map : &irq_map;
+	dev->dma_config = is_mt7927_hw ? &mt7927_dma_cfg : &mt7925_dma_cfg;
 	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
 	tasklet_init(&mdev->irq_tasklet, mt792x_irq_tasklet, (unsigned long)dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 38790ef83e51..8a10438e26f9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -203,6 +203,26 @@ struct mt792x_irq_map {
 	} rx;
 };
 
+struct mt792x_dma_config {
+	/* RX ring indices */
+	u8 rxq_band0;
+	u8 rxq_mcu_wm;
+	u8 rxq_data2;		/* 0 = not used */
+
+	/* Prefetch configuration */
+	void (*dma_prefetch)(struct mt792x_dev *dev);
+
+	/* GLO_CFG quirk bits to set/clear after DMA enable */
+	u32 glo_cfg_set;
+	u32 glo_cfg_clear;
+
+	/* GLO_CFG_EXT1 register address (chip-specific MMIO base) */
+	u32 glo_cfg_ext1;
+
+	/* Pre-ring-setup hook (NULL = not needed) */
+	int (*pre_ring_setup)(struct mt792x_dev *dev);
+};
+
 #define mt792x_init_reset(dev)		((dev)->hif_ops->init_reset(dev))
 #define mt792x_dev_reset(dev)		((dev)->hif_ops->reset(dev))
 #define mt792x_mcu_init(dev)		((dev)->hif_ops->mcu_init(dev))
@@ -250,6 +270,7 @@ struct mt792x_dev {
 	struct mt76_connac_coredump coredump;
 	const struct mt792x_hif_ops *hif_ops;
 	const struct mt792x_irq_map *irq_map;
+	const struct mt792x_dma_config *dma_config;
 
 	struct work_struct ipv6_ns_work;
 	struct delayed_work mlo_pm_work;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
index 1ddec7788b66..4a6794ca86b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -90,42 +90,36 @@ EXPORT_SYMBOL_GPL(mt792x_rx_poll_complete);
 #define PREFETCH(base, depth)	((base) << 16 | (depth))
 static void mt792x_dma_prefetch(struct mt792x_dev *dev)
 {
-	if (is_mt7925(&dev->mt76)) {
-		/* rx ring */
-		mt76_wr(dev, MT_WFDMA0_RX_RING0_EXT_CTRL, PREFETCH(0x0000, 0x4));
-		mt76_wr(dev, MT_WFDMA0_RX_RING1_EXT_CTRL, PREFETCH(0x0040, 0x4));
-		mt76_wr(dev, MT_WFDMA0_RX_RING2_EXT_CTRL, PREFETCH(0x0080, 0x4));
-		mt76_wr(dev, MT_WFDMA0_RX_RING3_EXT_CTRL, PREFETCH(0x00c0, 0x4));
-		/* tx ring */
-		mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, PREFETCH(0x0100, 0x10));
-		mt76_wr(dev, MT_WFDMA0_TX_RING1_EXT_CTRL, PREFETCH(0x0200, 0x10));
-		mt76_wr(dev, MT_WFDMA0_TX_RING2_EXT_CTRL, PREFETCH(0x0300, 0x10));
-		mt76_wr(dev, MT_WFDMA0_TX_RING3_EXT_CTRL, PREFETCH(0x0400, 0x10));
-		mt76_wr(dev, MT_WFDMA0_TX_RING15_EXT_CTRL, PREFETCH(0x0500, 0x4));
-		mt76_wr(dev, MT_WFDMA0_TX_RING16_EXT_CTRL, PREFETCH(0x0540, 0x4));
-	} else {
-		/* rx ring */
-		mt76_wr(dev, MT_WFDMA0_RX_RING0_EXT_CTRL, PREFETCH(0x0, 0x4));
-		mt76_wr(dev, MT_WFDMA0_RX_RING2_EXT_CTRL, PREFETCH(0x40, 0x4));
-		mt76_wr(dev, MT_WFDMA0_RX_RING3_EXT_CTRL, PREFETCH(0x80, 0x4));
-		mt76_wr(dev, MT_WFDMA0_RX_RING4_EXT_CTRL, PREFETCH(0xc0, 0x4));
-		mt76_wr(dev, MT_WFDMA0_RX_RING5_EXT_CTRL, PREFETCH(0x100, 0x4));
-		/* tx ring */
-		mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, PREFETCH(0x140, 0x4));
-		mt76_wr(dev, MT_WFDMA0_TX_RING1_EXT_CTRL, PREFETCH(0x180, 0x4));
-		mt76_wr(dev, MT_WFDMA0_TX_RING2_EXT_CTRL, PREFETCH(0x1c0, 0x4));
-		mt76_wr(dev, MT_WFDMA0_TX_RING3_EXT_CTRL, PREFETCH(0x200, 0x4));
-		mt76_wr(dev, MT_WFDMA0_TX_RING4_EXT_CTRL, PREFETCH(0x240, 0x4));
-		mt76_wr(dev, MT_WFDMA0_TX_RING5_EXT_CTRL, PREFETCH(0x280, 0x4));
-		mt76_wr(dev, MT_WFDMA0_TX_RING6_EXT_CTRL, PREFETCH(0x2c0, 0x4));
-		mt76_wr(dev, MT_WFDMA0_TX_RING16_EXT_CTRL, PREFETCH(0x340, 0x4));
-		mt76_wr(dev, MT_WFDMA0_TX_RING17_EXT_CTRL, PREFETCH(0x380, 0x4));
+	/* mt7925 family uses per-chip prefetch via dma_config callback */
+	if (dev->dma_config && dev->dma_config->dma_prefetch) {
+		dev->dma_config->dma_prefetch(dev);
+		return;
 	}
+
+	/* mt7921/mt7922 legacy prefetch */
+	/* rx ring */
+	mt76_wr(dev, MT_WFDMA0_RX_RING0_EXT_CTRL, PREFETCH(0x0, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING2_EXT_CTRL, PREFETCH(0x40, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING3_EXT_CTRL, PREFETCH(0x80, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING4_EXT_CTRL, PREFETCH(0xc0, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING5_EXT_CTRL, PREFETCH(0x100, 0x4));
+	/* tx ring */
+	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, PREFETCH(0x140, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING1_EXT_CTRL, PREFETCH(0x180, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING2_EXT_CTRL, PREFETCH(0x1c0, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING3_EXT_CTRL, PREFETCH(0x200, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING4_EXT_CTRL, PREFETCH(0x240, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING5_EXT_CTRL, PREFETCH(0x280, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING6_EXT_CTRL, PREFETCH(0x2c0, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING16_EXT_CTRL, PREFETCH(0x340, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING17_EXT_CTRL, PREFETCH(0x380, 0x4));
 }
 
 int mt792x_dma_enable(struct mt792x_dev *dev)
 {
-	/* configure perfetch settings */
+	const struct mt792x_dma_config *cfg = dev->dma_config;
+
+	/* configure prefetch settings */
 	mt792x_dma_prefetch(dev);
 
 	/* reset dma idx */
@@ -150,8 +144,16 @@ int mt792x_dma_enable(struct mt792x_dev *dev)
 	mt76_set(dev, MT_WFDMA0_GLO_CFG,
 		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
 
-	if (is_mt7925(&dev->mt76)) {
-		mt76_rmw(dev, MT_UWFDMA0_GLO_CFG_EXT1, BIT(28), BIT(28));
+	/* Apply chip-specific GLO_CFG quirk bits from DMA config */
+	if (cfg) {
+		if (cfg->glo_cfg_set)
+			mt76_set(dev, MT_WFDMA0_GLO_CFG, cfg->glo_cfg_set);
+		if (cfg->glo_cfg_clear)
+			mt76_clear(dev, MT_WFDMA0_GLO_CFG, cfg->glo_cfg_clear);
+	}
+
+	if (cfg && cfg->glo_cfg_ext1) {
+		mt76_rmw(dev, cfg->glo_cfg_ext1, BIT(28), BIT(28));
 		mt76_set(dev, MT_WFDMA0_INT_RX_PRI, 0x0F00);
 		mt76_set(dev, MT_WFDMA0_INT_TX_PRI, 0x7F00);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index a8c8d7d6f565..1b9b51d43f79 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -299,7 +299,9 @@
 #define MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN	BIT(12)
 #define MT_WFDMA0_GLO_CFG_RX_WB_DDONE	BIT(13)
 #define MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN BIT(15)
+#define MT_WFDMA0_GLO_CFG_CSR_LBK_RX_Q_SEL_EN	BIT(20)
 #define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
+#define MT_WFDMA0_GLO_CFG_ADDR_EXT_EN		BIT(26)
 #define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO	BIT(27)
 #define MT_WFDMA0_GLO_CFG_OMIT_TX_INFO	BIT(28)
 #define MT_WFDMA0_GLO_CFG_CLK_GAT_DIS	BIT(30)
@@ -366,6 +368,16 @@
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


