Return-Path: <linux-wireless+bounces-32689-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJa9NJ1yq2m6dAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32689-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:34:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CE322905A
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2D3E307B22E
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79B3242D84;
	Sat,  7 Mar 2026 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="lNetV4vP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S7z6H/nX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61651271468;
	Sat,  7 Mar 2026 00:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843613; cv=none; b=ISkKi+NSDvP9rUClCJFywkdt1VBLyQ62ZX0QuWuUwnIq89zRSl9reZWYreJcVuHNQ3OIXBwPfXGnCzOdScJE5Pa52AzEqp0vcUP5un62mHFjwOkHil4B7xdCj9Ez2ihH8D6xAQbnNI3Zf5ESX6OP3hLo0oY5vyoudn7CWHxlaqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843613; c=relaxed/simple;
	bh=7QkanlILEvogwMwpWy8/BqBW0eINQBelH4+HCMDj77Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=kj19KF1tFSxygBCGGW1/CitgGtzSUzXZ7WWEdOS1QeSggKNfNT71VWoQqrYrAuN0nMzmNcDQZBVSYI9aS6Km3jBydaFgEDp9xaLYVzWN1XBD9Utk/Q+npRUy6QYVQO2Qofz8LaKI9JT6IYNKsjGEoxVM5o8kPabtUp0ztkb5gNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=lNetV4vP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S7z6H/nX; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id C432E1380A23;
	Fri,  6 Mar 2026 19:33:31 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 19:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772843611;
	 x=1772850811; bh=aTO5+q1HMGfin+fXE1FWNDxCTM17E1HWlcub7MoIACc=; b=
	lNetV4vP4BE6DeKPu+5maTox6waDXRXlhHtxjAjtU76Vas1NLGGt8CGBX5lfgMNh
	o8eDrZ7OSC/gxLkVOSRzCrJ7G/vWJLVionQLufPx0DYT4K9Pd1WQg1AtbLk3DQqd
	aUN1cSHs3KQJUHCXw/lsHj+f2jO8HXpqwGxJ7fSxZHdWXrNPvh36q4N6B7UZM8Pw
	1usJiCQvAi6UAmo6SbjEV/I9/a4bxZQuco8URBLjZffNer2MAPy9P7l+GRVepHcJ
	UBAZ/WPX7H/fn+i/BRsaZZU6F+AQcRjEdHGttnJFZULy9dHhCNJwPPCaPVyzJATY
	LEmplIWXXWC87IMmF57Hfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772843611; x=
	1772850811; bh=aTO5+q1HMGfin+fXE1FWNDxCTM17E1HWlcub7MoIACc=; b=S
	7z6H/nXfL7qICjB7EbPnZ7T089Wp0HYaJUzJMTvAVw7F+wnmVO9S1TpOJNN/9E2B
	S5NGNyhr394XW1XmKj5KERESLVTyvorXOD9eYxuHvbbZobwOYHK/dW/ckyNIoKSY
	Dor9+rxig/AbHKMR4p+znPYBGSuaQc4wbJHyn4cThjlSlTsPzHIrwlhpLeMCUctr
	3R2Up61V0xg4Z1osdWc5aZvHLceIEy5tCZux9GEQcGrrO3kBq+8n/Hgj/BJfG2Mw
	DAEGBioxUbdHKPPk0OycffQN6ESMynqhoQAFJSuw9WzJHWlGIzGfQJwutZ+vZLJy
	GWya4Xchl639+aOZvJphw==
X-ME-Sender: <xms:W3KrabwQHM9KWe7fAO9uMKrFNLKYMAuoQAcKvzsnBWsWqsW-Vp0c-g>
    <xme:W3KraeHb2rbJbyZQZKjv6EB3cTsIWRl9uztMXr3UGXey4yiOpSTQvfJ87Z7qRl5tE
    xoF_eBQMy70Wa5yBE75cYb1FlTusNoFh0vxvU4RW4a_N38HxaMnroo>
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
X-ME-Proxy: <xmx:W3KraVyRmV3JgQv-zng5BwbZytLKpf_19KKluJXG_bBKx6yPlcfsAw>
    <xmx:W3KraaJ_HJ4ZZ58NDqg7P5UVVB_FAmjqCxZnLLwatWwnOjjljlMz2w>
    <xmx:W3Krac70UWqB1waCbghPG18roq2XxFbggyXABRvqTkM1UmtwoBnEKg>
    <xmx:W3KraZkfYUVrcy9I2GzqLIv0k2MhIjcZgDsk3B3p_-Ochy34IDJCtQ>
    <xmx:W3KraT84kMJ22D1DPUzTcHR7U9XcrIylIDH7ZDLIgQ27V1PDjFtlJiZf>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 917011EA006B; Fri,  6 Mar 2026 19:33:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Fri, 06 Mar 2026 18:33:21 -0600
Subject: [PATCH 02/18] wifi: mt76: mt7925: add MT7927 firmware paths and
 PCI device IDs
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-mt7927-wifi-support-v1-2-c77e7445511d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3765; i=floss@jetm.me;
 h=from:subject:message-id; bh=7QkanlILEvogwMwpWy8/BqBW0eINQBelH4+HCMDj77Y=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpq3JPAzr5BADMojXsGScpYHQT3oByoNn8dhp4w
 ns3QYv9UFSJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCaatyTwAKCRC17sMLqGd3
 HwUAC/sHt4a/vffVtKz6VSNf5zC8vSKzOZkdGsiLTvNSkIIpaypuBwaJ2Kcv/bzPXBTCczHbzyY
 OrqrPGWAZ27J7d//VpQgntAQ6zJGEIT0skzfeIUps6AiabR7BA0gkLR6gnpyouhooDPSroLonK3
 xjhOva5nOJtjExafmfeU0fELiuHGZxZgMc84wVclhD79X6JiNewl5LUK2KiLNG1Di5PZZOu8BDe
 tKDK6pNTErKTgizcGaR52/hRZEOKljGJyiMBuiJ2Ovof41n3jt1/XSLt0bS1uSf7/K6zsqot+io
 pFiFiQxip/EmXo98wxUG2q2C67+XcOiXSlkq1vt7kWBNSByxr8vp9R5PWrmjJZy9ja/1UMNVWCR
 Ar8056vpsl9p4pFblYBzNmWkLHaqUqEPMuQwWxrR3As+4a/STfyumMMS9G+rMFi+ugQHyWOD6YJ
 ClJgQuZtxrQC2gmJGeefZWIjGwywCInsuzIV1H4bH8CWZUdfFl64SPMwH1mUeMIGOW1Wo=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
X-Rspamd-Queue-Id: 35CE322905A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-32689-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,humeurlibre.fr:email,mediatek.com:email,jetm.me:dkim,jetm.me:email,jetm.me:mid,lgic.pl:email]
X-Rspamd-Action: no action

Add PCI device IDs for MT7927 (14c3:7927) and MT7927 (14c3:6639)
hardware variants, along with firmware path definitions for the MT7927
WiFi firmware.

Known hardware using these IDs:

  - ASUS ROG Crosshair X870E Hero (14c3:7927)
  - Lenovo Legion Pro 7 16ARX9 (14c3:7927)
  - Foxconn/Azurewave modules (14c3:6639)
  - AMD RZ738 (MediaTek MT7927) (14c3:0738)

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
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt792x.h     | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index c4161754c01d..54eac5c6e509 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -16,6 +16,10 @@ static const struct pci_device_id mt7925_pci_device_table[] = {
 		.driver_data = (kernel_ulong_t)MT7925_FIRMWARE_WM },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0717),
 		.driver_data = (kernel_ulong_t)MT7925_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7927),
+		.driver_data = (kernel_ulong_t)MT7927_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x6639),
+		.driver_data = (kernel_ulong_t)MT7927_FIRMWARE_WM },
 	{ },
 };
 
@@ -633,6 +637,8 @@ module_pci_driver(mt7925_pci_driver);
 MODULE_DEVICE_TABLE(pci, mt7925_pci_device_table);
 MODULE_FIRMWARE(MT7925_FIRMWARE_WM);
 MODULE_FIRMWARE(MT7925_ROM_PATCH);
+MODULE_FIRMWARE(MT7927_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7927_ROM_PATCH);
 MODULE_AUTHOR("Deren Wu <deren.wu@mediatek.com>");
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_DESCRIPTION("MediaTek MT7925E (PCIe) wireless driver");
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 8388638ed550..38790ef83e51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -45,11 +45,13 @@
 #define MT7921_FIRMWARE_WM	"mediatek/WIFI_RAM_CODE_MT7961_1.bin"
 #define MT7922_FIRMWARE_WM	"mediatek/WIFI_RAM_CODE_MT7922_1.bin"
 #define MT7925_FIRMWARE_WM	"mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin"
+#define MT7927_FIRMWARE_WM	"mediatek/mt7927/WIFI_RAM_CODE_MT6639_2_1.bin"
 
 #define MT7920_ROM_PATCH	"mediatek/WIFI_MT7961_patch_mcu_1a_2_hdr.bin"
 #define MT7921_ROM_PATCH	"mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin"
 #define MT7922_ROM_PATCH	"mediatek/WIFI_MT7922_patch_mcu_1_1_hdr.bin"
 #define MT7925_ROM_PATCH	"mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin"
+#define MT7927_ROM_PATCH	"mediatek/mt7927/WIFI_MT6639_PATCH_MCU_2_1_hdr.bin"
 
 #define MT792x_SDIO_HDR_TX_BYTES	GENMASK(15, 0)
 #define MT792x_SDIO_HDR_PKT_TYPE	GENMASK(17, 16)
@@ -454,6 +456,8 @@ static inline char *mt792x_ram_name(struct mt792x_dev *dev)
 		return MT7922_FIRMWARE_WM;
 	case 0x7925:
 		return MT7925_FIRMWARE_WM;
+	case 0x7927:
+		return MT7927_FIRMWARE_WM;
 	default:
 		return MT7921_FIRMWARE_WM;
 	}
@@ -468,6 +472,8 @@ static inline char *mt792x_patch_name(struct mt792x_dev *dev)
 		return MT7922_ROM_PATCH;
 	case 0x7925:
 		return MT7925_ROM_PATCH;
+	case 0x7927:
+		return MT7927_ROM_PATCH;
 	default:
 		return MT7921_ROM_PATCH;
 	}

-- 
2.53.0


