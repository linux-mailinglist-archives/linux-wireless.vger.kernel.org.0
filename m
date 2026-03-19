Return-Path: <linux-wireless+bounces-33516-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOfLCax3vGmFzAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33516-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:24:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D892D2EFF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 281013024287
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 22:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9723BAD82;
	Thu, 19 Mar 2026 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="QkC43vpJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lPhApHrC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C63BBA1D;
	Thu, 19 Mar 2026 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959066; cv=none; b=JWvrZK2P+JQwvjqevBjCmsA4wPDmk3tCBvwScgu/arBq0g170f7IokEKypIQ90bKbmMdBNGzQzLAyebkIy5/N5kii88nyUoBGVYOEyh17ChiVeGiMb/+hEuAOJz54PEWe/4Hh+qZ6sqG1YNousyqPkhTJq6jjWRLW6Q2Mut4t4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959066; c=relaxed/simple;
	bh=VkHzNgTPswZqtnZH9RrjpYvX5nnga+Iy4PRlJIRs4y8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bWWZ7u4Tkdfuc+cZsbayN1Bif8Fg34insATZTK/fFagYaBOULA1zJzCqmIQntoeysC3XyuGykWmegbFMXFvjdi6vmpUShAjEg4rOUdXI3VZX0ELGMa0tmkl+Z+cMw3znUUr9t3x9NSlVUcZsw4aRmXEZ0PRmtD5GdQ3X7SeBDJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=QkC43vpJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lPhApHrC; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id ADF9A1300091;
	Thu, 19 Mar 2026 18:24:20 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 18:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1773959060; x=1773966260; bh=LAVzGfypCR
	ghhsXf+ipXW1SW8g8TGd3VqLQvc8SXFPM=; b=QkC43vpJw1sG70rWQ3zyfYAOuF
	iddm2Ssf+iDOXBx+3ChfYspUuOiwzbQ1JyVGrWvR70Q3tweBGxwRJ8qgP+4ClJ31
	vavJ0/Tf14//WCeDFpDvlfMnmEwhKDLMcRybfA/xtwnHqkzCBly8eqPMmDEvfWN4
	O7oyvFb4KCQJdshsrtR/t+q5m6v/7IWgwGem4CQBGP2Jioh+dDUSGqBNc6jNxRFE
	RWZGRPTXnRp4D8UimhT56/1ZgXkS8YG+qjeZ4Y1gLG8aMAnJqOZzpVPhSmlQYloN
	OT2e3gtiKJSO41HyQ0BySv7EDV6zVbLcVUQ84WeWnaYA/++DDbjPvjo6l/qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1773959060; x=1773966260; bh=LAVzGfypCRghhsXf+ipXW1SW8g8T
	Gd3VqLQvc8SXFPM=; b=lPhApHrCjxvsGlNkrf43RFownvK//9oSXZ+Eu5QNk96y
	ae54X2vnM4W8rYgFNDMDFw/CiHaY5iXs1hIk3x0YZjEbehfNwjL0+62h16soH39v
	C5mt3iHTMtxVHwEZKhsPlt0S9zI2tmOzYanlCCcv8Q/f5Doq6o6wFmbD9HWXQEMD
	DAJpexfchG+mIDg3p0JH3L0HS0HDB8+lCLDKzfwgng6p/A8HWmXIzYjnwMVy4T/7
	S6egzUHo6fxCQDZT+4N5030YoFEWCXrFwyjFvYxVtyXevXe6NeURvo7a8GughEHt
	XXJZ0FhBcMBPb2/PWZQlljNqIbbK2AkxJQ7Or/n4yw==
X-ME-Sender: <xms:k3e8aS8lR4FErd0kFOVoT9kDXSnjIf69Iv8YJod1piBIt82m0QZMvw>
    <xme:k3e8adjildvGCNFkRELadW0AsTzWf7FuMes5yfOcYq2lC9dSIsaFYDS_tquJ0o5e2
    hiiTVphjsC0JxwnXU4N2P7O8hcgV9GplfDAhdK9lYOJ_WQQnEkVJYU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfgrvhhivghr
    ucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhephefhfe
    eiudffleeliedvhfetvdevieegheeuleefuefhhfekgeefkeegueffgeehnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehflhhoshhssehjvghtmhdrmhgvpdhnsggprhgtphhtthhopedv
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthh
    hinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopeef
    udelfeeifedusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoohhnghdrtdigtddtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprghrihgvlhdrrhhoshgvnhhfvghlugdrjeeh
    tdesghhmrghilhdrtghomhdprhgtphhtthhopegthhgrphhuihhsuggrrhhiohegsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhiohhsrghlledtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhgrthhthhhirghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprhgrughoihdrtghhrhhishesghhmrghilhdrtghomhdprhgtphhtthhopehsrghmuhdr
    thholhhjrghmohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:k3e8aUJA9oXiqlvxFvRNvmyuGwUwCZqx-rE4439pAth1_QpdAWauQQ>
    <xmx:k3e8abwgJLhyNQFsNNV7rRGaTq55kMxJfgH23QUnmVifVgkg6iQuKQ>
    <xmx:k3e8aU7f4yddLEvLfbZNcXVQhnV8mTOGFHHnA-u0bb4a8qXAY6ZVZw>
    <xmx:k3e8aZYNUJ2pp36c7rKRAtYUt43gcdYp3jlChy8nF1_BDpYFxQ17og>
    <xmx:lHe8aZWXA-Lkr4B6u-gQIcunapmZMXbH16JTTCR_mUIp20BCD-hRg9uF>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 19B371EA006B; Thu, 19 Mar 2026 18:24:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Subject: [PATCH v2 00/13] wifi: mt76: mt7925: add MT7927 (Filogic 380)
 support
Date: Thu, 19 Mar 2026 16:24:16 -0600
Message-Id: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3Myw5AMBBA0V+RWZuEIap+RSw8pswCTVuPRPy7x
 vIs7n3AsxP20CQPOD7Fy75FUJrAuPTbzChTNFBGVVbkGtegNCm8xAj6w9rdBTwJudaTUnqg2pQ
 QY+vYyP2P2+59P8yiF2VoAAAA
X-Change-ID: 20260319-mt7927-wifi-support-v2-e89d779b28f4
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5469; i=floss@jetm.me;
 h=from:subject:message-id; bh=VkHzNgTPswZqtnZH9RrjpYvX5nnga+Iy4PRlJIRs4y8=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpvHeQGer2ktynT9bFfPfuA9qCJPtCWBA27y1ap
 qnl5MAm5AmJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCabx3kAAKCRC17sMLqGd3
 H7lbC/45LLIS0GdQOKy+BCMqakWJKFreShmb9TP2KsWBjgQDUJvvQtcbP0doNhRMl1rtnt3gjbs
 jlsAwIDTr6aANLjqXVKSNefwJqiVhkJRXgKlMhONVuIAvZgHhdS4LWVRNIcv37VP/XZBymXRCqZ
 9HFtNfSaVeKwja1JNHh0bOWyrN74STsGO4CLSOErJ6HXjC2NcZmVGYksXgNclM48Q0eGgIpSUsS
 Vu+O6hWVXGpkpe/jhnjPCJeQW2Q6IY/b5dE2Snhft+E4S1krbE9aA0wzB+H9SHvXruGBCFjiQAw
 8Zd+fLbYCk9ttmc0sj2wjm4vX/OM6be8A6+lHlUjlLQ1U5OZi69Cqg2goPbwQjmFcjEJwExC9Rb
 P5RGueKMSlbxtPb8Gs+t3S3t1lYBK8CZkH8OTdoifEJtM9Pja8809dcJvb2rlPql17v9XODDqUn
 U8MmI3u8OLbdEB/xpB3FUFEOyt2ogY9iWEQu3pdI06XCzz25oBNsqyrqiIbxwXFW0Q1bE=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-33516-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.228];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 80D892D2EFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds support for the MediaTek MT7927 (Filogic 380) combo
WiFi 7 + BT 5.4 module to the mt7925 driver. The MT7927 uses PCI ID
14c3:7927 (some hardware reports 14c3:6639) and shares the mt7925
firmware interface but requires different DMA ring layout, IRQ mapping,
chip initialization, and power management handling.

Tested hardware:
- ASUS ROG Crosshair X870E Hero (BT 0489:e13a, WiFi 14c3:6639)
- ASUS ProArt X870E-Creator WiFi (BT 0489:e13a / 13d3:3588, WiFi 14c3:6639)
- ASUS ROG Strix X870E-E (BT 0489:e13a, WiFi 14c3:7927)
- Gigabyte X870E Aorus Master X3D (BT 0489:e10f, WiFi 14c3:7927)
- Gigabyte Z790 AORUS MASTER X (BT 0489:e10f, WiFi 14c3:7927)
- Lenovo Legion Pro 7 16ARX9 (BT 0489:e0fa, WiFi 14c3:7927)
- TP-Link Archer TBE550E PCIe (BT 0489:e116, WiFi 14c3:7927)
- EDUP EP-MT7927BE M.2 card (WiFi 14c3:7927)
- Foxconn/Azurewave M.2 modules (WiFi 14c3:6639)
- AMD RZ738 reference design (WiFi 14c3:0738)

Tested on Arch Linux, CachyOS, EndeavourOS, Fedora (Bazzite), NixOS,
openSUSE Tumbleweed, and Ubuntu across kernels 6.13-6.19.

What works:
- WiFi 7 with EHT 320MHz on 2.4/5/6 GHz bands
- 320MHz data path verified at 841 Mbps (iperf3 -t30 -P8)
- PCIe initialization with CBTOP remap and MT7927-specific DMA layout
- Runtime power management and suspend/resume (S3)
- DBDC (dual-band concurrent) mode
- Explicit band_idx assignment for stable 5GHz/6GHz operation
- ASPM disabled for MT7927 to prevent throughput collapse

Known limitations (planned as follow-up series):
- mac_reset returns -EOPNOTSUPP (DMA recovery not yet implemented)
- MLO (Multi-Link Operation): tested working on 5GHz+2.4GHz STR
  (776 Mbps) but requires additional patches for link lifetime
  and error handling. Sean Wang's series [1] addresses these;
  MLO support will be submitted as a follow-up on top of that.
- TX retransmissions: elevated retry rate on all bands, firmware-side
  rate adaptation issue not addressable in the driver.

[1] https://lore.kernel.org/linux-wireless/20260306232238.2039675-1-sean.wang@kernel.org/

Patches 1-5 add generic 320MHz EHT support (no MT7927 references).
Patches 6-7 introduce MT7927 chip ID helpers and firmware paths.
Patch 8 adds per-chip IRQ map handling.
Patch 9 introduces mt792x_dma_config struct for chip-specific DMA.
Patch 10 combines CBTOP remap, chip init, DBDC, CNM, and mac_reset.
Patch 11 adds mt7925_band_idx() helper for stable 5/6 GHz operation.
Patch 12 enables runtime PM and disables ASPM.
Patch 13 enables the MT7927 PCI device table entries.

The WiFi firmware path and filename in linux-firmware have not been
finalized yet. The driver currently requests mediatek/mt6639/ (the
mobile SoC codename), but this may change based on the linux-firmware
review.

Changes since v1 (suggested by Sean Wang):
- Reorganized from 18 patches into 13 across 8 logical groups
- Common 320MHz patches first, chip-specific changes later
- Introduced mt792x_dma_config struct to reuse mt7925_dma_init()
  instead of duplicating as mt7927_dma_init()
- Replaced is_mt7927() with is_320mhz_supported() in common patches
- Added mt7925_band_idx() helper replacing scattered if/else patterns
- Renamed MT7927-specific registers with MT7927_ prefix
- Added PCI ID 0x0738 for AMD RZ738 hardware
- Moved GLO_CFG_EXT1 register address into dma_config struct to
  eliminate is_mt7927() from shared mt792x_dma.c

Link to v1: https://lore.kernel.org/linux-wireless/20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me/

Assisted-by: Claude (Anthropic)
Signed-off-by: Javier Tia <floss@jetm.me>
---
Javier Tia (13):
      wifi: mt76: mt7925: fix stale pointer comparisons in change_vif_links
      wifi: mt76: mt7925: add 320MHz bandwidth to bss_rlm_tlv
      wifi: mt76: mt7925: handle 320MHz bandwidth in RXV and TXS
      wifi: mt76: mt7925: populate EHT 320MHz MCS map in sta_rec
      wifi: mt76: mt7925: advertise EHT 320MHz capabilities for 6GHz band
      wifi: mt76: mt7925: add MT7927 chip ID helpers
      wifi: mt76: mt7925: add MT7927 firmware paths
      wifi: mt76: mt7925: use irq_map for chip-specific interrupt handling
      wifi: mt76: mt7925: add chip-specific DMA configuration
      wifi: mt76: mt7925: add MT7927 hardware initialization
      wifi: mt76: mt7925: fix band_idx for stable 5GHz/6GHz operation
      wifi: mt76: mt7925: enable low power support for MT7927
      wifi: mt76: mt7925: enable MT7927 PCI device IDs

 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |  13 +-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |  13 +
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   9 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  67 ++++-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  55 +++-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |   7 +
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    | 277 +++++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |  14 +-
 .../net/wireless/mediatek/mt76/mt7925/pci_mcu.c    |  20 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |  27 ++
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |  68 ++---
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |  33 +++
 12 files changed, 529 insertions(+), 74 deletions(-)
---
base-commit: 9ac76f3d0bb2940db3a9684d596b9c8f301ef315
change-id: 20260319-mt7927-wifi-support-v2-e89d779b28f4

Best regards,
-- 
Javier Tia <floss@jetm.me>


