Return-Path: <linux-wireless+bounces-32694-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKADHXhyq2m6dAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32694-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:34:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 506A122904B
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45D33302C2A3
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0669242D84;
	Sat,  7 Mar 2026 00:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="dWAfE8Wl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQZdCs02"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1664A264628;
	Sat,  7 Mar 2026 00:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843633; cv=none; b=LSxTNOLz7MTpWinQrxQS8H/VBdlDcEJHH5qHTCW6P01ShDk/d27GQJkQuHe/s7clvqH4ThPd12FhejQgFEukoWMSI5sseX+W9hAR7YWfFMwW3q9jcT/pyOO9s46jUhHwF4BKJUcwMmidkeZgStAJ4nHQRGf+9ePCrvQZBvM+dPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843633; c=relaxed/simple;
	bh=fh8xuA/UcnCiI2pt4y9B5bOwUECz0KpoSZwkpRJvLHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=UZbAbLIiF+msqB0n6vwfiYOoiG22woyULM83NGvU6sZss5yOmXUvEkWnHCO4mRrXlg2IrOSk0MHLdeuxJEWK4OZ4gT10oHlRFlr6Y1UwjXy/hxLpWS2CFx633ckzno7+e6AIwKxLm+w72cHBeeTaVPmYMW7/dZAZ1AZWpkbu1/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=dWAfE8Wl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lQZdCs02; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 58FB31380A42;
	Fri,  6 Mar 2026 19:33:46 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 19:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772843626;
	 x=1772850826; bh=3oRXSofd2xMKwzx8uK/FRX4Ajp5i0R+uMPSyB8kKtlI=; b=
	dWAfE8Wln/4/TWN2vTjTxkbM+BuqOcH8d1bYrbzS45QdZ3l8FC9UM16sN1CyUiTM
	LHptVoUFMWgxnz9qGwY0H6SHVa1Co99ahqgFq9A3LiGyFF9w87aeznKJ4wBENBkK
	i+G3Kp3iuSQi7O9WCAtVjrsOvs3Pg37v30G2LzO5AC834aK3oOllv+iLtuU8a6am
	18f8yKX/6NUMhKZBeLfdS5C0NZP6Z892BNK8v6ZJCcbPgtq6dWPlWlV8Dvj/YIp4
	w7X/VmewyBAJn+Dw+PM066+s5FfLga+AT4SRfdCNufRs6hwnVmdOukwCUd9/FEx9
	PiincwleEIRoHOdaZfj5vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772843626; x=
	1772850826; bh=3oRXSofd2xMKwzx8uK/FRX4Ajp5i0R+uMPSyB8kKtlI=; b=l
	QZdCs02+8pGaYPL4LLi6NF1IL0PAiHi/iv566gG1Hr5RaKDk2XjYk3gmH3zq3Cfb
	itsZgO5qKcPZaj0B8PupqtLQuFexl7j+T1BOHi94FGsISbb4uAPNtM6SjQC0EeHi
	Lzyh/ewAsOLokQ+jX+PpJTGHTqhwSX/eWCUZReG3JSeMJVBcFgTB0HAxBH9f/M5O
	/ZAAzfleGh+xEH1sTMQmipnWCiY2LWLCALon5ZWHeThII9a/cQGZDlkdVehp9Jxk
	aGYZxqfZVCiMKwojSM2qMTsIWZSTd71Pz0bgfxz4RnHiY0fHFpu9lZJEKrZdO+RO
	S2PQT2wkwx9+67hRfB/hA==
X-ME-Sender: <xms:anKraWgJt4S78iLPxU8Sk3KXeXM-zWn_Fl_8kzjymHAJXemCX0HDXQ>
    <xme:anKraR1F0avceSEiP-z2lCYBjqVM35-rQWa0E4FJnsUXeoS9nIAWV_vbP_5NW9Gl3
    VYLjKc6r6XW1xU2X2Gii3HEP3Pr-MkBJBx998QHwBl4J9Ic_yCvaJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:anKracgz-TiPVnH9546JWUwMgdPOI--ocQ9qUsMZzkpEingVyw_-6Q>
    <xmx:anKraZ6vUVV1KC24K-6m7MFyN5Jh0FCkAiIsQpWCmy7cuklzE4fXpQ>
    <xmx:anKraRrLY_kgWvC-Ymt0DMnVqF2bEKfrcfv9EtfNMfiGzvzqqcqk0w>
    <xmx:anKrafWlkawRPzkFnDKd7TKHoyWtx0iU5Uu4hyB_f84KpEW9LdbDPw>
    <xmx:anKracO8BZPHiGqaU7CZ946sL_NjfQMy5-1io4JbHUM6gKkkSpR0U0b6>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 327251EA006B; Fri,  6 Mar 2026 19:33:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Fri, 06 Mar 2026 18:33:26 -0600
Subject: [PATCH 07/18] wifi: mt76: mt7925: use irq_map fields instead of
 MT_INT_RX_DONE_ALL
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-mt7927-wifi-support-v1-7-c77e7445511d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2571; i=floss@jetm.me;
 h=from:subject:message-id; bh=fh8xuA/UcnCiI2pt4y9B5bOwUECz0KpoSZwkpRJvLHQ=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpq3JPKHrsOJzA8wN2GMFvjDypIHO67m5syOjsD
 ACZU/PlUAKJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCaatyTwAKCRC17sMLqGd3
 HzjzC/9JYr/GjJIy2ewR1UB9eduPA4Z1Z5s7QcX99yWtr493idUXTtwBSLCr66G1zWURB9gIZsQ
 C6pvBKy6L81Dbh8OcBM9Djh8kR4KfGxfdgQMcTjxWRJtKSdLGUNNXlliQOilds74yY5N36FNPZf
 h48fqvXfsr/EJu/LQ5spP5IkYbOmLgcBguApfd0Bx1aCW5nZyjYtRm1+a4CX1Mxhp1LrDubiS4C
 IGe4fOMYHWkjkz637QD9Y0QF6r3CV2RNTuMCjS3u6Cxl82kyeksXWVPuVE7HwcIjzyo5Fe3qcG/
 1JuwzqU8Y77qAPiemU9qi37YSI9zEjhQcRPUox9ZHXuX+an+oOGMevsrRaayNXuG5jqSlEwhjtC
 2pF+am8nqW58V3JG26Vz2dBJxW1p2hPJ4YE4uNOFlFmWe2/XsFeVrcsRijXnbJwWKUUi2vl7Klz
 cCjT2XB9Z6SngsNmz06oNUH1PVF5fv3jNzvTpUIlVvBfChYjgfsFQ9cJiPUGH6HJKbUZM=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
X-Rspamd-Queue-Id: 506A122904B
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
	TAGGED_FROM(0.00)[bounces-32694-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,jetm.me:dkim,jetm.me:email,jetm.me:mid,lgic.pl:email]
X-Rspamd-Action: no action

The mac_reset and resume paths use the hardcoded MT_INT_RX_DONE_ALL
constant (bits 0-2) to re-enable RX interrupts. This is correct for
MT7925 (RX rings 0, 1, 2) but wrong for MT7927 which uses RX rings 4, 6,
7 (bits 12, 14, 15).

Replace with the per-chip irq_map fields so the correct interrupt bits
are enabled regardless of the chip variant.

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
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c     | 5 ++++-
 drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index dce9f30b68d7..0dec25b320f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -766,7 +766,10 @@ static int _mt7925_pci_resume(struct device *device, bool restore)
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

-- 
2.53.0


