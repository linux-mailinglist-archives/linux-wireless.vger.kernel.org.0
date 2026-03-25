Return-Path: <linux-wireless+bounces-33889-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ/hA3RdxGn1ygQAu9opvQ
	(envelope-from <linux-wireless+bounces-33889-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:11:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAD432CC8A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A1B73012D19
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B405356A09;
	Wed, 25 Mar 2026 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="i2bLZ/K7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2vxZo3lq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA0B27FD6D;
	Wed, 25 Mar 2026 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476657; cv=none; b=ZACW+Bd/1Hn9VTcDSed+6ZGsmmG8/3wy5gcJPZIutK9pca96OnOhMrOal7wF2/dKA6Wy0VuurSzYjfnQZFivfyNvmuipB3zbOxVPhWb3RvGT6aVloIuGKlJZ/uCU9ZVdPuYaVfvHehVpz1fvHH7jYYxl9AJjvR3D6l9+HrwbiGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476657; c=relaxed/simple;
	bh=ryF+Tq0TO0ABvQG1dY6QKIvionqJAkWcJuEl87nxA0c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mL8jU/bskWI73lLx9T1QP89olbPEF7JHg6UjkAEgwqzvYz737D9HE/HIzXjhMrCCDn/KVv/dEVnz8k9VtNnUMEEXlURVCZpAPuoNSmKtGHT3FFZwbVugBYzNwta7XrNkzYi44D5fBIgWRanmQRg3n17LQOjK3z0w64N0F0uUmhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=i2bLZ/K7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2vxZo3lq; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id D5B9C13004F5;
	Wed, 25 Mar 2026 18:10:53 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 18:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1774476653; x=1774483853; bh=uZ2V0pPiVe
	8VQhls4qUsrxS+o3VI1j3cwD9vd9IHfIw=; b=i2bLZ/K7EJ4sSBI1Fa8fjZEtLC
	oeMX/RHSbP1nJfZMpQE8tLeHZ6qIq6rIAwkUB+/3QBqYDdK3KCl80Co1mc2UREYC
	l9z9LLZqjUb6A/aNtn+q+n4e3ByF0vRz560W2ysn5iMysNjzjSk4rkRj5WkNO2B9
	oJkw6XDnXzTLMbgdOHLb8z0ZCCuX20jktYLOgG1ipH5ZJCHNdvgP1WS0Wb2BMr+e
	C1nXO6AKV/7aGpSo6AvTpZ9RsqW2jQPzxMBHQBdQLG5aWxH8o6T1vFdiJUfsberx
	3PQPLoFAAwYV9yyhPOGuf11/9MHeU120rPqd2kW+wfii5PTuyBx5L+GSG5mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774476653; x=1774483853; bh=uZ2V0pPiVe8VQhls4qUsrxS+o3VI
	1j3cwD9vd9IHfIw=; b=2vxZo3lqfe79L9YAQcOdtjUEZI8gp6lzOJyO1fiyIT7Y
	y3Q/JfJeXTGcqxiqdLVnkDVpmqflg64VDgi5Awt/PDUYgUrepim9vgEuTaCgmLbE
	y8Q3ncfaNkEeFMfO6y8CrlgcJLUJYTkD5DSvCxdorGR8Ym/6hCe7T5pkwne4sZJH
	aG88mvCPssqpfARWSj2HB5RGK4X1GAAtIwP19H5gYSQQ/H9O2CIyfjCuqg9W6dgV
	8kOmsTSFfYQSjG/9oGsJ4COpKol13WUti/mQOKPtkfFNOUIRV29353W9LFbmEBpo
	uzFN80NULN6aSTl+3DVrjhlc7vNW8gjnqW8gqNesUQ==
X-ME-Sender: <xms:bF3EaUFJuHSCt7mB0t4CsIjWyRRbxaXZbKfeK66cbUg6WfDSljy3RA>
    <xme:bF3EaYJqwgUtcH4NIAIBe8b0cm3e4_80EhdD1FjTLpP0nP491G6PRRxBcFOCUmDT5
    VeElw0fq8CPSAO106dhZQnFYKeyZlNXOTf2UHAcSkT4JFtWZNZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehiedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:bF3EacVzbUKYSRxYnlZoPSH5PQPm0VkWfY7GTglJP_rFB0qbJtkwig>
    <xmx:bF3EadyfcURAMKk6eV52e5YGpXXYojke5f_8MZJQ0myvXT2cjWM8jw>
    <xmx:bF3EaU4xiFiLzbADBAjGEO1sLju0cdknje1YS4T0w1UlV3BvFPfY5g>
    <xmx:bF3EaXgZ-jteiHae2toPBAMylrpetOf9lx0SRpuyrze7wi-KMpMxNg>
    <xmx:bV3EadUS49MWW-zb9EyYWXh3wxZcxI87P6Z4rDTG2P0UdIBzGGZAzze5>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 70AF81EA006B; Wed, 25 Mar 2026 18:10:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Subject: [PATCH v3 00/13] This series adds support for the MediaTek MT7927
 (Filogic 380) combo
Date: Wed, 25 Mar 2026 16:10:49 -0600
Message-Id: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3Myw5AMBBA0V+RWZuEIap+RSw8pswCTVuPRPy7x
 vIs7n3AsxP20CQPOD7Fy75FFGkC49JvM6NM0UAZVVmRa1yD0qTwEiPoD2t3F/Ak5FpPSumBalN
 CjK1jI/c/brv3/QDZOjB5aAAAAA==
X-Change-ID: 20260319-mt7927-wifi-support-v2-e89d779b28f4
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6818; i=floss@jetm.me;
 h=from:subject:message-id; bh=ryF+Tq0TO0ABvQG1dY6QKIvionqJAkWcJuEl87nxA0c=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxF1pXkkuS92az5SKw16kyDbrHgEN5AZ6PQ7lk
 XiAYzYn6CGJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacRdaQAKCRC17sMLqGd3
 H+eBDACYTPw+yIpnzkyiSE0qkQVtjEKKk5D0tlqiWRIVxJmqROcxTyK3QSUDqqaBTeev4VuQsYw
 iQgHxS6HxjPsQp5JyS1JqE5dMFSgzpmOUeU8ELzubXg1TdrVJY8tuh6zxqGopdYerJn5rA8nYXv
 uA14gEaenouPkqvjfq/ERGIki1bvbEc5q788scA368qqBhqhIDoBA7/QbcLyMiZiMaa4eaFmnwM
 wz/Hp9GybFgfmk5Sz0jy9unr47I1qARy8R8TfVSJQYUvdrEVSmV5cAtllgX4sq8GLQYRqXmUZc0
 2DZBbHUqzz0Z/WBu9ot6k4twFjtntyRk9hT0emeHK8oYupqm0I4TLbxO31TRnHs58BDGTCPRqA0
 B2hqA6z+JMOIMjEdZVOgDURIP7NfXuAjBBmDcOWOyeArtDCCUAkTbEzOS4jkppitRPIfvydgefA
 ff217Yrb6ryWFLg0Jzj61QTd/EMek8WV3lVsEIRr0/e3p7FKW1j7VgG+RwLSmaRyINHx0=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-33889-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,jetm.me:dkim,jetm.me:email,jetm.me:mid]
X-Rspamd-Queue-Id: 4FAD432CC8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

WiFi 7 + BT 5.4 module to the mt7925 driver. The MT7927 uses PCI ID
14c3:7927 (some hardware reports 14c3:6639) and shares the mt7925
firmware interface but requires different DMA ring layout, IRQ mapping,
chip initialization, and power management handling.

Tested hardware:
- ASUS ROG Crosshair X870E Hero (BT 0489:e13a, WiFi 14c3:6639)
- ASUS ProArt X870E-Creator WiFi (BT 0489:e13a / 13d3:3588, WiFi 14c3:6639)
- ASUS ROG Strix X870-I (WiFi 14c3:7927)
- ASUS ROG Strix X870-F Gaming WiFi (BT 0489:e13a, WiFi 14c3:7927)
- ASUS ROG Strix X870E-E (BT 13d3:3588, WiFi 14c3:7927)
- Gigabyte X870E Aorus Master X3D (BT 0489:e10f, WiFi 14c3:7927)
- Gigabyte Z790 AORUS MASTER X (BT 0489:e10f, WiFi 14c3:7927)
- Gigabyte Z790 AORUS ELITE X WiFi7 (BT 0489:e10f, WiFi 14c3:7927)
- MSI MEG X870E ACE MAX (BT 0489:e110, WiFi 14c3:7927)
- Lenovo Legion Pro 7 16ARX9 (BT 0489:e0fa, WiFi 14c3:7927)
- Lenovo Legion Pro 7 16AFR10H (BT 0489:e0fa, WiFi 14c3:7927)
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
- System suspend/resume (S3)
- DBDC (dual-band concurrent) mode
- Explicit band_idx assignment for stable 5GHz/6GHz operation
- ASPM and runtime PM disabled for MT7927 (see below)

Known limitations (planned as follow-up series):
- Runtime PM: disabled for MT7927 because the combo chip shares a
  CONNINFRA power domain between WiFi (PCIe) and BT (USB).
  SET_OWN/CLR_OWN transitions on the LPCTL register crash the BT
  firmware, requiring a full power cycle to recover. PM enablement
  will be addressed once safe power state transitions are determined.
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
Patch 12 disables ASPM and runtime PM for MT7927.
Patch 13 enables the MT7927 PCI device table entries.

The WiFi firmware path and filename in linux-firmware have not been
finalized yet. The driver currently requests mediatek/mt6639/ (the
mobile SoC codename), but this may change based on the linux-firmware
review.

Changes since v2 (suggested by Sean Wang):
- Fixed is_320mhz_supported() to check for MT7927 only, not the
  entire mt7925 family. MT7925 does not support 320MHz (patch 5).
- Dropped phy_cap_info[7] 320MHz additions (NON_OFDMA_UL_MU_MIMO
  and MU_BEAMFORMER) to keep capabilities conservative (patch 5).
- Disabled runtime PM for MT7927 (patch 12). The combo chip shares a
  CONNINFRA power domain between WiFi and BT; SET_OWN/CLR_OWN
  transitions crash BT firmware. Discovered via user reports of BT
  lockups after enabling power_save=1 (Reported-by: Nitin Gurram).
- Added tested hardware: MSI MEG X870E ACE MAX, Gigabyte Z790 AORUS
  ELITE X WiFi7, Lenovo Legion Pro 7 16AFR10H.

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

Link to v2: https://lore.kernel.org/linux-wireless/20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me/
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
      wifi: mt76: mt7925: disable ASPM and runtime PM for MT7927
      wifi: mt76: mt7925: enable MT7927 PCI device IDs

 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |  13 +-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |  19 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   9 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  61 ++++-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  55 +++-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |   7 +
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    | 277 +++++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |  14 +-
 .../net/wireless/mediatek/mt76/mt7925/pci_mcu.c    |  20 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |  27 ++
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |  68 ++---
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |  33 +++
 12 files changed, 528 insertions(+), 75 deletions(-)
---
base-commit: 9ac76f3d0bb2940db3a9684d596b9c8f301ef315
change-id: 20260319-mt7927-wifi-support-v2-e89d779b28f4

Best regards,
--  
Javier Tia <floss@jetm.me>


