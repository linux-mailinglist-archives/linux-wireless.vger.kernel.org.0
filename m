Return-Path: <linux-wireless+bounces-33900-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E1zGTRgxGkuywQAu9opvQ
	(envelope-from <linux-wireless+bounces-33900-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:22:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DDE32CDBE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA8993044DC6
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F49D39DBFA;
	Wed, 25 Mar 2026 22:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="FfJYpItg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S1KQeY+n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437EF3563FB;
	Wed, 25 Mar 2026 22:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476682; cv=none; b=bRpCkrutez32MPBNckw/ty7pTUCrwB3ntaE3QKFP+eBGfklDJJZEWPTULn888ZONorCeN2t+tFqFDST1XybTlQq4j7sj4A2gQ0HRsUUD1WkuxjVi7Hg/d52urfoz1Jg/frqpMMe0hLpg+kmpTESqGtzqaRfCU7ZSSyyP6oE1HkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476682; c=relaxed/simple;
	bh=2iqjJzkxfCHr/WEpzj6LaYh+JuyD2C2/r14c7V0yo38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=OmlXD/hmGzf4iUIdK2CrVKFXNlmuF+yU9poOHfMwAQptf8aKvj+PNkGDUYviOSPCm/qd/HMxoePkOAsSQhSvvvHjieDLhaTEryJXOPLYWW89dVv+0Q+gxLWTNUfydpUxrVNyQN3MP3ojVptW6Q4RICp3T/O2i4BN8hVP6+ox5qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=FfJYpItg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S1KQeY+n; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B6C11D00168;
	Wed, 25 Mar 2026 18:11:17 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 18:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774476677;
	 x=1774563077; bh=n7RyoRF58WkVZqJnuoOO9YEr75upIQgc4Q8y20FVoJo=; b=
	FfJYpItgt4bCSVo9wuIULduF6xbyHzRPAuQk6FLtlF8MSeC5TFEP6FGfVfz9XYdw
	IVa9hJ63X8HrJoAf+pyLbcqjtVgj0LEuCau/jqhyrZSpzdLoCeru+uDNo5OJxWa0
	FBfl0mlGXkWEvTG5EM9gECXxn0TjCC5yeGu5dsnZYHoQkcAZG3aqm21eTaOVMzXi
	dm+oTX9RNQ1enUKa8dZJnc/iwuAfGq31x1MmYXQuWDOv7uktfDn7msefvLMW7CNb
	iDk/TWvicoL3SMlwSGO9dzk7phK+xCuH9IulAQogQNPdR2KJBnE5D9nw7jjGOk/r
	g7H59kpWMzniBgPQdOOXFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774476677; x=
	1774563077; bh=n7RyoRF58WkVZqJnuoOO9YEr75upIQgc4Q8y20FVoJo=; b=S
	1KQeY+n+GsBkf/iXvOVqlYen1Hlcg4zhmh+1ouwhKEGuJe4sl8V9qGR+3XymeQpC
	1CvLCN4g6lxB3tK0XUaeVQYzWGpXe+QgS5hUjjqN7c4Qcl+lBvDETAoxZqozgVOH
	uR2dLo+wkJOy+n5mlFScOq/a0oO2N7x+23Z2WdhUvLV35ydhkvTYHw1txcgW3I45
	h7jASTye9u2ctP3o2XmiQfQxrqZ5TDXTNdwUYdbSbFirNAZm4Z1xFr6nfMxnrTXX
	m5PwSL38BnkcoXD1FCGlJ60UBHPSKYN6Q3CQZwbwaIlYsYnckYHORg/5/Elx5Onc
	iE5Dz0jGkIwpRGtaVPkhA==
X-ME-Sender: <xms:hV3EabldZFuAQobfEGU6mvzLC4_5zmx0WKje5WqCkc2ZeW2d09s2sQ>
    <xme:hV3EaZrxCsa5JWRSwwk4EmbFhpBVWW4mnil-RJM0cFBNbxoGWqhwR1phN1F2ocrkp
    8C12vF3nRGb527jFtFBOm9f2IgAyRHYQgUrvn5PCoWVDYwHcZPx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthejredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepvd
    dtjeeiheeijedtveeujeevvdekjeeuveekleeijeekfeejhfefveeiffffvdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepmhgrthhthhhirghsrdgsghhgsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheplhhorhgvnhiioheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqmhgvughirghtvghksehlihhsthhsrdhinh
    hfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggvrhgvnhdrfihusehmvgguihgrthgv
    khdrtghomhdprhgtphhtthhopehmihhnghihvghnrdhhshhivghhsehmvgguihgrthgvkh
    drtghomhdprhgtphhtthhopehrhiguvghrrdhlvggvsehmvgguihgrthgvkhdrtghomhdp
    rhgtphhtthhopehsvggrnhdrfigrnhhgsehmvgguihgrthgvkhdrtghomh
X-ME-Proxy: <xmx:hV3EaYgNOKMY4XOGUO_fE19AsBjvub0CoNWHx7UFmm0i9VBbjeOY2g>
    <xmx:hV3EaWM65nQQJEBQ8IbMUfg2XDjqDrOqHfc45Z-62_DCrFK0ZClMwg>
    <xmx:hV3EaTdWKmt6y2CcbJI-tAm_m-pwPTlNDh3iAofLmmby3Z8EAYNSkA>
    <xmx:hV3EaYxeTnWYA_tJhEtm2TkO-W7eoOvCC5UFLx6zAdGJBsOFby1Y_Q>
    <xmx:hV3EaXPt5p7TppPpMxwauCcUktYsul-lD5YHYH3zwRy82jdPfJMRxce0>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 138A71EA006B; Wed, 25 Mar 2026 18:11:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Wed, 25 Mar 2026 16:11:01 -0600
Subject: [PATCH v3 12/13] wifi: mt76: mt7925: disable ASPM and runtime PM
 for MT7927
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-mt7927-wifi-support-v2-v3-12-5ca66c97a755@jetm.me>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
 Deren Wu <deren.wu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2922; i=floss@jetm.me;
 h=from:subject:message-id; bh=2iqjJzkxfCHr/WEpzj6LaYh+JuyD2C2/r14c7V0yo38=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxF1qvlXa+GRyNOT8nkxUvjlUbhCWJ7vFMh1vQ
 UbrZ9P12X2JAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacRdagAKCRC17sMLqGd3
 H8cmC/4/JBzUQWEO0ZBvP9nWGmMuy9TovpJ9fS6iVWDLKgrBWryNgT2GQXx9oTxcw8jgJIpPVed
 JY+8s2dKmr6BEV8S3U9U8uHVBoDKguxcE/KEkYBXU/R+nDQxSRWB2fFkXX4iT/h1EQkr19ryFZi
 u9dW+dqk5vFUe7NwgJJV3z/oafJmGmPBdlXyrCRu/SbDJhN79y8WDBC+7Al1lhIqIcEOHd3+i/E
 TATcG8lZMPSOU9w7eUObrneLAuvQ9M572lSl9IKYcsO7C7MMfVUHz/DTgjERSwqrA3atYU1nKhU
 kuRy+JC12q+iZkXRUFvEtNQDshFoccpFEdp09s5pmqaH4/IQt8T56evb/IfRxxUj+YzvqxMFZw6
 NKN1DwApfwUX13rwwg00C3DalVwgoEK+6EzWFfUxgnv//mU9JRf4M0DChcV89EHzeMIFPl43A8x
 zMKcra7mKtzX6ZG8oLpXuhPIQUdRDR9mB++FgOVJRhdkKV/wasvy1k528Scw5ln/jnfyI=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me>
References: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me>
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33900-lists,linux-wireless=lfdr.de];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[jetm.me:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[floss@jetm.me,linux-wireless@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[jetm.me,quarantine];
	TAGGED_RCPT(0.00)[linux-wireless];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	NEURAL_SPAM(0.00)[0.540];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jetm.me:dkim,jetm.me:email,jetm.me:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 62DDE32CDBE
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Disable PCIe ASPM unconditionally for MT7927. The CONNINFRA power
domain and WFDMA register access are unreliable with PCIe L1 active,
causing throughput to drop from 1+ Gbps to ~200 Mbps.

Disable runtime PM and deep sleep for MT7927. The combo chip shares
a CONNINFRA power domain between WiFi (PCIe) and BT (USB).
SET_OWN/CLR_OWN transitions on the LPCTL register crash the BT
firmware, requiring a full power cycle to recover. PM enablement will
be addressed in a follow-up once safe power state transitions are
determined.

Signed-off-by: Javier Tia <floss@jetm.me>
---
 drivers/net/wireless/mediatek/mt76/mt7925/init.c | 6 +++++-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 9 +++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index c4c99380f5b5..89140fc6a2b6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -243,7 +243,11 @@ int mt7925_register_device(struct mt792x_dev *dev)
 	dev->pm.idle_timeout = MT792x_PM_TIMEOUT;
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
-	if (!mt76_is_usb(&dev->mt76)) {
+	/* MT7927: runtime PM disabled. The combo chip shares a CONNINFRA
+	 * power domain between WiFi (PCIe) and BT (USB). SET_OWN/CLR_OWN
+	 * transitions on the LPCTL register crash BT firmware.
+	 */
+	if (!mt76_is_usb(&dev->mt76) && !is_mt7927(&dev->mt76)) {
 		dev->pm.enable_user = true;
 		dev->pm.enable = true;
 		dev->pm.ds_enable_user = true;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 393d9f408b84..693e08f35d68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -530,7 +530,13 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_pci_vec;
 
-	if (mt7925_disable_aspm)
+	is_mt7927_hw = (pdev->device == 0x6639 || pdev->device == 0x7927);
+
+	/* MT7927: CONNINFRA power domain and WFDMA register access are
+	 * unreliable with PCIe L1 active, causing throughput to drop
+	 * from 1+ Gbps to ~200 Mbps. Disable ASPM unconditionally.
+	 */
+	if (mt7925_disable_aspm || is_mt7927_hw)
 		mt76_pci_disable_aspm(pdev);
 
 	ops = mt792x_get_mac80211_ops(&pdev->dev, &mt7925_ops,
@@ -562,7 +568,6 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	dev = container_of(mdev, struct mt792x_dev, mt76);
 	dev->fw_features = features;
 	dev->hif_ops = &mt7925_pcie_ops;
-	is_mt7927_hw = (pdev->device == 0x6639 || pdev->device == 0x7927);
 	dev->irq_map = is_mt7927_hw ? &mt7927_irq_map : &irq_map;
 	dev->dma_config = is_mt7927_hw ? &mt7927_dma_cfg : &mt7925_dma_cfg;
 	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);

-- 
2.53.0


