Return-Path: <linux-wireless+bounces-32695-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHjYNWl1q2kvdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32695-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:46:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C7E22918A
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E50B3052611
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D3226CE3B;
	Sat,  7 Mar 2026 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="EU3DA6E7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jZf2cWNz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9E826F46F;
	Sat,  7 Mar 2026 00:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843635; cv=none; b=nJAPWt+YRlf0ZReaKxDGZxWVDMQaXO75SxJHsawPEPbgRWPte3SZyTyMX9y3skMTHC96MeXYwvyoYeXgvni0uJPpB6IGW2n1YPHL+rnAf6+Rp4mtZvFjHk0BvIevufFhW71+NQOOc7kaHoiK4coO67hRpx+0t78nmEdfW/jVtsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843635; c=relaxed/simple;
	bh=rDGaFfNf7jHAcpr58xKa3I82OUiQC87REEhxcKnu0lU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=ISlqPLujtOv5ivi7CaqKCRM2wtSUGzqzR/Y492Xov3t9Lc1s4w45HMJqS+iVjArpuBFN8O7TErsx+wB6SCW8tH7A1wdCv1boS3eGOexGtGdvd3927KogRlheJ7gYZ+UmsbwFb+8o512JTf8/eQH1blZkMHhJ1e3OL1q6Ola5v68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=EU3DA6E7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jZf2cWNz; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 368521380A45;
	Fri,  6 Mar 2026 19:33:50 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 19:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772843630;
	 x=1772850830; bh=SurwNBvAl/bBDja7s6L7R/0E+xLUsx7Ctts0NZBHMOE=; b=
	EU3DA6E7CFuf68QIe1jn6w2D91wclcXrsQYo+dBYcdoqd1OEhHYB7eVV3FWPoAOG
	Eu6nO+/IVAx6heRNdK2b+QaVw4P2LLntkR7kcRRuQM1Y0b7OnyUFfX4IMuGSaTP4
	ZZ9sx5mYVV7DKezfJBiBUEGrFryJKoKB4q/BiMENraMPbozSnxBe2gfqmoxjBPrN
	PvBmYnxlLPilleKZrMz7s37HF5EIi7kTZNK57fcJRHdTS66AKnAd87VYKclsZ2pe
	xbDAsESwO8pFiv8CHQ8Zp/g1EQLDPM90Avy3yATQDb5XPeI4BARozWJL1q8SoldL
	DVHN+dSUjtDymfoCCnpxnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772843630; x=
	1772850830; bh=SurwNBvAl/bBDja7s6L7R/0E+xLUsx7Ctts0NZBHMOE=; b=j
	Zf2cWNzmCBO7Yjt+3pi7ABQOoDuXaAUnEzWIdxY+VCao60UIQLORipLAiFLnPaAS
	RKUnB5SCclQLqJIeVWSJCEsfrNW6C8tWH29sM6IVBAbRXsc8qo+UrulZVhICYHBo
	5Q4wMdxWFpjBnhpmNcvhv24oWBVlcz+gEHBLFbkqjw5p+B3+VViJ3YN/T1qltqVG
	Z37sYQ5LXMEfGqTx+x3abKU/vAcitWbnYNtc1z/CHSssWt0uwCiMqhPBLXMHRqlR
	N6tT5prtsipDXxplYXntbYKHg0NyH08VrXzUVyLMdRgePI+bUF3KX/mOSsdn3ZWY
	yhXpVmtn+Ctqo0bjgWDjQ==
X-ME-Sender: <xms:bnKrabiAuLJkHFCwujgj_Eo0fELS6GUz4ivbd6mrCvazK25AQKs8xw>
    <xme:bnKraS3yYvHpVvaAlJD_GLN-gT9H1lIg2DdHOoB7Q24ZqCzdr-QiFMLyBLnr0gvI7
    sHIIeSoScnVDPQIaQf0PCZbItxnjkhikO-F_L1k-w4dJ9qu_5fBUxU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepjeenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:bnKraRgkauOtahwNqqwCdS8mefe9lnBcmoE8BZAt6YHeNlUjynRCEw>
    <xmx:bnKraa7hD0ky8CMrN6OSho9CkRDZePkFUZVer7mrCjT_gQLBoatsdg>
    <xmx:bnKraep7Gaky93v9SoiS2vpDfVfREqjiL7NCGCwRNZkU-AybtsxEhg>
    <xmx:bnKraYXOiBkPuVioLtsIx4289oQcsaCuuSR97Uddv1OER6BAwLiKfg>
    <xmx:bnKraVPRR5LRgGJPmIiuxVTVNpPlonYaPxH_Kusx8i1AV03kMsdt2V-k>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0B0511EA006C; Fri,  6 Mar 2026 19:33:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Fri, 06 Mar 2026 18:33:27 -0600
Subject: [PATCH 08/18] wifi: mt76: mt7925: guard mac_reset against MT7927
 DMA destruction
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-mt7927-wifi-support-v1-8-c77e7445511d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943; i=floss@jetm.me;
 h=from:subject:message-id; bh=rDGaFfNf7jHAcpr58xKa3I82OUiQC87REEhxcKnu0lU=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpq3JPMXsAEGYKf/FbWGwk6bwEdk8nUJ3cAxMlF
 9a/tR05XCuJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCaatyTwAKCRC17sMLqGd3
 H9SGDACf5zkl3X6UnGRm+ZnMzObtrZtz5CJQp6Dn9jvZ4U7gX8dyGL6rpp1JaYLi4kdHfkjnLuN
 j92iQH9evrsyNDLSKv+KCWE2WC3XBumitMbFjbFQuHPNaQHAgFPUVi+i2+CxyR9HVS1KvH9+gSt
 P79twzIsEBxtVdxUNYYSJaZ1ZrVVGArzQSX2usCnZnXb5WZ/rT9RN7bHeTP2qr4dsYPsvw8RUSm
 bDn7aQA359GY6rr42rZPfJ6x/oBJ4oWGaZW2oUihtsxE6q/GAf7Uw7A8AOHRQYYOy3HHsz9SpLJ
 Y39ST5CbalxxnKERVpRsnlyk88biKENqxCgu9y46ZKwvru23fUc/cHSbEUZ75+XzWw9A8mo6LSK
 Y5J3fzeAVa0CyAF4eW9PEMnqyBEiafaLsECAo3hjKq9FQ8okR1nwcST6KlwB/GY6fcwvrdDb6RY
 hyOkFyTrdZrn0B44aDKw7JGi2n6xFjOYHa3eO8w151qqk9ouBZ30+9bplwCWm9T7gEJJM=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
X-Rspamd-Queue-Id: 36C7E22918A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32695-lists,linux-wireless=lfdr.de];
	R_DKIM_ALLOW(0.00)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
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
	NEURAL_SPAM(0.00)[0.696];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[humeurlibre.fr:email,messagingengine.com:dkim,lgic.pl:email,jetm.me:dkim,jetm.me:email,jetm.me:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: add header
X-Spam: Yes

On MT7927 hardware, the mac_reset path performs CLR_OWN and WPDMA logic
reset, both of which destroy DMA ring configuration. CLR_OWN triggers
the ROM to reinitialize WFDMA, and the logic reset pulse disrupts the
WFDMA state that mt7927_dma_init() carefully configured.

A full MT7927 reset requires re-running the DMA initialization sequence,
which is not yet implemented in the recovery path. Return -EOPNOTSUPP
with a warning so users know to reload the module.

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
 drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
index 1626a3684082..cf578a2cdc68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
@@ -72,6 +72,14 @@ int mt7925e_mac_reset(struct mt792x_dev *dev)
 	const struct mt792x_irq_map *irq_map = dev->irq_map;
 	int i, err;
 
+	/* MT7927: CLR_OWN and WPDMA reset destroy DMA ring configuration.
+	 * A full reset requires re-running mt7927_dma_init() which is not
+	 * yet implemented in the recovery path. */
+	if (is_mt7927(&dev->mt76)) {
+		dev_warn(dev->mt76.dev, "MT7927 mac_reset not supported, reload module to recover\n");
+		return -EOPNOTSUPP;
+	}
+
 	mt792xe_mcu_drv_pmctrl(dev);
 
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);

-- 
2.53.0


