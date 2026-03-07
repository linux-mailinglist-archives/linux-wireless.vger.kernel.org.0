Return-Path: <linux-wireless+bounces-32697-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAnFLpt1q2kvdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32697-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:47:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD522291B0
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF04E305E9DC
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F54E27FD5D;
	Sat,  7 Mar 2026 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="YJmsZqDl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JdQesv7L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250342797AC;
	Sat,  7 Mar 2026 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843640; cv=none; b=nz3AEPxhLrFkgjEBUTaUkIjWkProeUUf5FvQ1PmQzDLvqTQSJAGjxr8yAiogexV6LB/+A2ZQMmdrBLIc30NeXTGS/8oIrFNIDrLHkS/pEOC8mQ7GFN3VBSisJxZn8JmX+Gh0mhofGrEcFE1I5SjbkX6ys+qz2ffAWqBG0Jaq+Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843640; c=relaxed/simple;
	bh=fCY3DSE95mUoabPrkuKHGr3zz66X2jRynD0TiW/Z0BY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=R0WL08ggFMYC5pSdB9txlW6u90MRwzhkO/ZNGGrDCmmTghjC1ZrKARCvfUol/MBpD0eesPyNLfbemRuQ8IAWBc8IVn1bhPqvfBF+InMbXxGjZgTBpo7b5oy2AsrUJCBaKj3UB6RYTtKnDBv0EAnueXpJUsjP4YrkmTzMcppmjUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=YJmsZqDl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JdQesv7L; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 6EF2A1380A7F;
	Fri,  6 Mar 2026 19:33:58 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 19:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772843638;
	 x=1772850838; bh=jVDAyuRFOXHy/wcoICXEPnLxH/n67+H+2S/lHmQXGE8=; b=
	YJmsZqDlBdsrPcyqTgWGTXoWd6pJL0C24MaQVEJWdw4tNqByEvrf2ecgq4NAt9MX
	GchhHNR4gN2JSFBsw2Nu+IihLjC1PN3YmWj4Wpe4DDSkEizqTknu5qmtqfgrtaVO
	Occs3g6FoJjHxc5c7ob8+WfmXXZDc+3WVb6ssgC37HY2KLAVF0EyDZBUibsR3lQH
	L5MrfiAc/PG2SlSYs7zO7eeTWvi9EA+c6fA3u88UZb3tNfkzqy6RRZoGdXoB5cTW
	/ewYN2zAMZ5KskldG58Vg8v8+05YQId94Ykv1IzqJGdiglzG1piKKpdY+LQndVsa
	JD2gIQDnane0Rn759K7yVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772843638; x=
	1772850838; bh=jVDAyuRFOXHy/wcoICXEPnLxH/n67+H+2S/lHmQXGE8=; b=J
	dQesv7L489j+4BJyAMheP/NocKPc9zu9bZNNyJmSY/3fqk/uwCUkH7o1E3nh/N5P
	yNkVwFtLy+vQFWeSZWXGtLfMLL6JgT3HSSPjn7JrajeYqLvslCN7LoUUtUHYFrnt
	WXGSfm8fblWqqdKlp42xMfAz+tu0DZpP8iVLK5pCSMdHdxEJT6STjrTGxw8UtCON
	38/b5h95e7rnd1uHiRr3ETZfolnRR64EmfggT8G8rrBTYDDJMKwk1LlAnyiKkfSS
	rUvoYRLZFGCJTQd7F89VhMKMMP1b0pIwMciK2SpKSgDxZFlTMcrubn6Im9bSDKgV
	XY5CP/X8Zn7MV0AKeQwQQ==
X-ME-Sender: <xms:dnKraTIGnYN2QcIUb4lIMkoD29trKupTJWPbkBQWfG--igmeiyD05g>
    <xme:dnKraR9jEwtP-JFXvuygXivT95EVhFufgFuHMwjygoFIiosIHvTFgsSFs05SwWUok
    ZtwhE-rJHck2ltx9YOcPwQ0zWMaajqiHsnIxaDbwYaNnSNEXQtJmHM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepkeenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:dnKrabKViEW9ddauD9cKxMpFSLQbbnnrlpDk89Is5v-cUntjBioLcg>
    <xmx:dnKraUCcDrAPUfiAXcT52xv0ZaV4l-7s8eiYViMnjVpYA6vejEuFBg>
    <xmx:dnKraRQYxvnsJ9JNH-F6JtsW-GuNEfxiLsePaD0CL6fI3tP-7Qd4sA>
    <xmx:dnKraWcIDepTnUgkULbmmS4RN3JeZafPvAg5_w3PaMpEDRH92LcaFQ>
    <xmx:dnKrabWEA4s02oTP7yESgUhCvrgMb8_pAMUx5CzPqZ3T_BtWn4_cW3Ax>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 42DBE1EA006B; Fri,  6 Mar 2026 19:33:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Fri, 06 Mar 2026 18:33:29 -0600
Subject: [PATCH 10/18] wifi: mt76: mt7925: enable MT7927 runtime power
 management
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-mt7927-wifi-support-v1-10-c77e7445511d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5179; i=floss@jetm.me;
 h=from:subject:message-id; bh=fCY3DSE95mUoabPrkuKHGr3zz66X2jRynD0TiW/Z0BY=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpq3JP0hl2X2uf/k196xdtgmlRlzuJ7V5ef/Y4+
 offmO7WouyJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCaatyTwAKCRC17sMLqGd3
 H21nDACHHqC4EVt/a2mb/2XiH5bItCkASCDZQpTI0AvtRajZW+uzwxxjb4j0rhE2yPnXhJJWHj5
 qOAU01Mspi6l5UNuCus4GyiuX1MEcCtcikdTd7HLo1vbB+3Jv9xvxHKk1cLODub1Eh0m65soe4w
 al/qqfzd73PzPtAs5+n2iVchz37niO+Ma1JI6+1LVg56lh/qqSOLCYIhZJkE5daIl6nXI+zZEkP
 FzX52RVHcBKi19+o2eLsP/wX1tkYQVoAVYgg0JII9K1JZisOckmjYPZ9DSNmOGQy+DFovaco1Pu
 sU9D86Bz6M3AUIBn6oBGiI47wz4JHVGg31sPBEs6Vexf8ItnAl7jOYx8SIqTeBMfvu2h/1X4Gq4
 /Go8mFu4q6BiCMGeBbbttWB0D1LFtLHlS0VGn6X8bWCh9SM7x/8fipBanImeCOi1moeiy7pJM0i
 GmvdnrfBXFuc9+x9uX5t2/1AmGmwgOAXE7vUIoGMrd0kTo0IWnYBlUu+mMHsm0rdW5lJE=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
X-Rspamd-Queue-Id: 2CD522291B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32697-lists,linux-wireless=lfdr.de];
	R_DKIM_ALLOW(0.00)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lgic.pl,gmail.com,humeurlibre.fr,jetm.me];
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
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	NEURAL_SPAM(0.00)[0.686];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[humeurlibre.fr:email,messagingengine.com:dkim,lgic.pl:email,jetm.me:dkim,jetm.me:email,jetm.me:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: add header
X-Spam: Yes

Add MT7927-specific GLO_CFG register programming to mt792x_dma_enable()
so that ADDR_EXT_EN and CSR_LBK_RX_Q_SEL_EN are correctly configured
after every WPDMA reinitialization triggered by CLR_OWN during power
management transitions.

On MT7927, every CLR_OWN causes the ROM to reinitialize WFDMA, which
resets the DMA configuration. The PM wake path already handles ring
reprogramming (mt76_queue_reset restores ring base addresses from
stored desc_dma) and prefetch configuration (mt792x_dma_prefetch has
an is_mt7927 branch), but two GLO_CFG bits were missing from
mt792x_dma_enable:

  - BIT(26) ADDR_EXT_EN: extended DMA addressing, required for
    MT7927's host memory access
  - BIT(20) CSR_LBK_RX_Q_SEL_EN: loopback RX queue select, must
    be cleared for normal DMA operation

Also define proper macros for these bits and use them in
mt7927_dma_init() to replace bare BIT() values.

With the DMA recovery path now fully MT7927-aware, remove the
is_mt7927() guard that disabled runtime PM and deep sleep. Let the
standard mt792x power management work for MT7927 hardware.

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
 drivers/net/wireless/mediatek/mt76/mt7925/init.c | 5 +----
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c  | 7 +++++++
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h | 2 ++
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 1e9eadca3988..84af52a0176d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -242,10 +242,7 @@ int mt7925_register_device(struct mt792x_dev *dev)
 	dev->pm.idle_timeout = MT792x_PM_TIMEOUT;
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
-	/* MT7927: disable power management. Every CLR_OWN triggers the
-	 * ROM to reinitialize WFDMA, destroying DMA ring configuration.
-	 * Keep the device awake until the PM wake path handles MT7927. */
-	if (!mt76_is_usb(&dev->mt76) && !is_mt7927(&dev->mt76)) {
+	if (!mt76_is_usb(&dev->mt76)) {
 		dev->pm.enable_user = true;
 		dev->pm.enable = true;
 		dev->pm.ds_enable_user = true;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 0dec25b320f8..0f76d9197230 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -416,8 +416,8 @@ static int mt7927_dma_init(struct mt792x_dev *dev)
 	napi_enable(&dev->mt76.tx_napi);
 
 	/* MT7927-specific GLO_CFG bits before DMA enable */
-	mt76_set(dev, MT_WFDMA0_GLO_CFG, BIT(26));   /* ADDR_EXT_EN */
-	mt76_clear(dev, MT_WFDMA0_GLO_CFG, BIT(20)); /* CSR_LBK_RX_Q_SEL_EN */
+	mt76_set(dev, MT_WFDMA0_GLO_CFG, MT_WFDMA0_GLO_CFG_ADDR_EXT_EN);
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG, MT_WFDMA0_GLO_CFG_CSR_LBK_RX_Q_SEL_EN);
 	mt76_set(dev, MT_WFDMA0_GLO_CFG_EXT1, BIT(28));
 	mt76_set(dev, MT_WFDMA0_GLO_CFG,
 		 MT_WFDMA0_GLO_CFG_FW_DWLD_BYPASS_DMASHDL);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
index 3177c6cc6eb5..32364f19007d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -166,6 +166,13 @@ int mt792x_dma_enable(struct mt792x_dev *dev)
 	mt76_set(dev, MT_WFDMA0_GLO_CFG,
 		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
 
+	if (is_mt7927(&dev->mt76)) {
+		mt76_set(dev, MT_WFDMA0_GLO_CFG,
+			 MT_WFDMA0_GLO_CFG_ADDR_EXT_EN);
+		mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+			   MT_WFDMA0_GLO_CFG_CSR_LBK_RX_Q_SEL_EN);
+	}
+
 	if (is_mt7925(&dev->mt76)) {
 		mt76_rmw(dev, MT_UWFDMA0_GLO_CFG_EXT1, BIT(28), BIT(28));
 		mt76_set(dev, MT_WFDMA0_INT_RX_PRI, 0x0F00);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index 5497cfaab8d7..b364d0038653 100644
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

-- 
2.53.0


