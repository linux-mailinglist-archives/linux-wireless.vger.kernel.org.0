Return-Path: <linux-wireless+bounces-32687-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGHpOFpyq2m6dAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32687-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:33:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A4C229014
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A409630087AA
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3362116F4;
	Sat,  7 Mar 2026 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="XCYiAcn1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bom4cPxP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289EA7260F;
	Sat,  7 Mar 2026 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843608; cv=none; b=CwEaTNrJCDRytq94WIpUhWQ2JoIk1aO4uLoab9MgVrAPcfRx1VCeikos3AVt3hoMydd3vFXX06DJRrsUChvWfKkG/yQgQc9HJ6rzX2RID0x3ua24cTLvgVI93O3iLsj3Q0moKQaQM6tHJMCEYCdBl2ecyxchMBQ0H6NtQdvmXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843608; c=relaxed/simple;
	bh=50UnPn89MYhFyhdErxVao3WQFDS1/s5aVZ8ZoQ0YUp8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N7yuQqQ7LWMTHQyiSCdwvCLDhOEsM+j9McohVJBLbFOobnewSu6Se68IoYF15eqSwUDUojng+81JEIRlQXtTazLgisFlNiOWvldUJHXT3KLQKlZAbAzFwTVu1bg6tc8/wyjoY/jmsrRptxrR7xv3HOymqzcm9KOKRRdRTJyR5+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=XCYiAcn1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bom4cPxP; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 58FA41380783;
	Fri,  6 Mar 2026 19:33:25 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 19:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1772843605; x=1772850805; bh=GOlXSBA3zV
	57VB94c1E22HBSC9q4AY+u2q4LW416Y5U=; b=XCYiAcn12BFy0qTXwey+ORjo+e
	Sq4FdfqGrvHQNUnIoSu36+bSelX+XjJ1rC3aRf6efeJjUe0zjf96fHn4uheL/QH+
	P9Lu1Iw6KnNx/Zk669ueXcG4qWXjQYzb7ztvm1Qesbfcl2tm8wC6oWugbvttLpo0
	dl65hgHJ/M6n5KQ6gzqHUbaTiJf2XyuuyvKjLxJj+8HlzexWD8UzJcfWhGXBHLrb
	YCmlfgLdchDn//o/mu2UfPXvmTE1k2o107hDt83vAbQf0iMEB9cckPRsIlNVrFjK
	rqrwQG9fHmPYFssZr99befDVf74TiVHAeTNfofz5ohBU5BqC1H9pvXNlFA4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1772843605; x=1772850805; bh=GOlXSBA3zV57VB94c1E22HBSC9q4
	AY+u2q4LW416Y5U=; b=bom4cPxPK4yI7StpEaesVEVlIwa2tzcFk+oORs8s93kf
	dbg5HZN24SgHuZrP4bj1GjWcilqUJ421gaLMUC5J+3pLfNzYnZvVOynUQ6TyxDx9
	LDs78CAnYBI64JoZ+tkRzqU8Wkjxqk8wTA8Z63fCN4quwtsk9ggd9yFsupFRbmCq
	j+2nNYltMPQWoLAL5c1cZ9AN902WZ+doX/0Rps1xp6465Eqlo38gmlotE7dagiFT
	L6izzx54nmubTO43h0yR3TSnSOMJ7RrU75JNVZX+AEa/oavYqxFcVw7+IS57LV7H
	wVM+M7pOyzSG05+uWgrbSgAw42MO6BJqMnUYIBnrrQ==
X-ME-Sender: <xms:VHKraZY6PB-cYV4sBhHC9Uj8LzlPHT2J-3aFwts7-ZPBpQaPscglNQ>
    <xme:VHKrabOJHls4LQsx7-ZpfR7KwdytzjOVlquOsQS70SwjJH0LLR8oSqLuS1EMiE48m
    DPmNh7LVBVwDM3o5JHruWa3k5S1NVlWJ98ofrG6YWHXLhpSjMNttvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhufffkfggtgfgvfevofesthekredtredtjeenucfhrhhomheplfgrvhhivghr
    ucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepgfeggf
    etueehleduhedvvddtleevffeukedvffehgeduhedvteejveethfekueelnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehflhhoshhssehjvghtmhdrmhgvpdhnsggprhgtphhtthhopedv
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthh
    hinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopeef
    udelfeeifedusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoohhnghdrtdigtddtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprghrihgvlhdrrhhoshgvnhhfvghlugdrjeeh
    tdesghhmrghilhdrtghomhdprhgtphhtthhopegthhgrphhuihhsuggrrhhiohegsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhiohhsrghlledtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhgrthhthhhirghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprhgrughoihdrtghhrhhishesghhmrghilhdrtghomhdprhgtphhtthhopehsrghmuhdr
    thholhhjrghmohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:VHKraRSdVbvMVEVtl00KqaU-dRWtY7305pryyAhTKatxP72VpV3irg>
    <xmx:VHKraVjqLy1-8fZqoEdmohf05xRbe8zZ3RFMe7Inb6eLh-3WvFJPbg>
    <xmx:VHKraVuntK_dEp5HpX7EmCpagOp3A9ZJlnHPB-89qJ9bB5Gevqm0vw>
    <xmx:VHKrafxcc-zeCqTGIwvA-5PlF-nRObsAPDNdJpfdSU-A5GIUdnQ3UA>
    <xmx:VXKraVlV-k2DrfwcC39kzPN_BN7Cy1Taa_hoj1vyqkGDkToGiyqYIlY->
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 48E2E1EA0070; Fri,  6 Mar 2026 19:33:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Subject: [PATCH 00/18] wifi: mt76: mt7925: add MT7927 (Filogic 380) support
Date: Fri, 06 Mar 2026 18:33:19 -0600
Message-Id: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQ5AMBBA4avIrE1S01B1FbEQpswCTesvEXfXW
 H6L9x6IHIQjNNkDgU+Jsq0JRZ7BMPfrxChjMpCiSmlV4rIbSwYvcYLx8H4LOypy1ui617YiSKU
 P7OT+r233vh/wCB5pZQAAAA==
X-Change-ID: 20260305-mt7927-wifi-support-02f9738a3962
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6110; i=floss@jetm.me;
 h=from:subject:message-id; bh=50UnPn89MYhFyhdErxVao3WQFDS1/s5aVZ8ZoQ0YUp8=;
 b=owEB7AET/pANAwAKAbXuwwuoZ3cfAcsmYgBpq3JPDdKOscH2RgtMLSUrvXsSMIuexxd6u/3OP
 yr5i5auHQ6JAbIEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCaatyTwAKCRC17sMLqGd3
 H5HGC/Yqg7petJX15L0HpaeYdq3QsPWJVjeEJPSsGvqA8G0DDICSLejbmXdfrQlD8+i5HtMJ5ul
 XVJkZYM+lW35KnbWXQ/v6lou73D9NDuws5mJGbVXGJUtHgUzLmHRpY8abX3Losm8StleSj3Umm4
 jbK8KUDouR18qm2yFGujcCw8FeclaT7JxrgmRuRzzBGEN6gvI++9XogFrufO4q3q3SsoI1kiDFQ
 LYUaWNAO8Vxb1mJO72fznhYlAx96+2vz31BJUbHuTs4eFV6SsClPe+LO5VqCfntBUsUF6nqOVxZ
 lcDkTCJjh9HvBzAjm7nXtEqa1265vm3fJcBge5yibcfFqOOuxPLKkTVldZaEnsL9+TaReg7D5Ul
 SvMHjDsiUi9UKpmMu4tgb7UkShoLNQsYOw6keqFIDmWV2a9VKU5WRkCuhhNZqi7LGTH3vFyiTFQ
 lYmA2HMkcTzy75zYjdAUvYUEfJdpd1Gq/LFo1W5ne9KTv2MCX7k4reLWtUerI/N0Ym9A==
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
X-Rspamd-Queue-Id: E9A4C229014
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-32687-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

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
- MLO (Multi-Link Operation): tested working on 5GHz+2.4GHz STR
  (776 Mbps) but requires additional patches for link lifetime
  and error handling. Sean Wang's series [1] addresses these;
  MLO support will be submitted as a follow-up on top of that.

[1] https://lore.kernel.org/linux-wireless/20260306232238.2039675-1-sean.wang@kernel.org/
- TX retransmissions: elevated retry rate on all bands, firmware-side
  rate adaptation issue not addressable in the driver.

Patches 1-11 bring up the basic driver (chip ID, firmware, DMA, init,
power management, 320MHz MCS, mac_reset guard, IRQ map, probe fix).
Patch 12 advertises EHT 320MHz capabilities, guarded by is_mt7927().
Patches 13-14 fix DMASHDL PM wake and disable ASPM.
Patch 15 adds 320MHz bandwidth handling in RXV/TXS status reporting.
Patch 16 fixes stale pointer comparisons in change_vif_links.
Patch 17 assigns explicit band_idx for stable 5GHz/6GHz operation.
Patch 18 adds the missing 320MHz case in bss_rlm_tlv() so firmware
receives the correct bandwidth when associated to a 320MHz BSS.

The WiFi firmware ships as part of the linux-firmware package
(mediatek/mt6639/ directory - the firmware uses the mobile SoC codename).

To: linux-wireless@vger.kernel.org
To: Felix Fietkau <nbd@nbd.name>
To: Lorenzo Bianconi <lorenzo@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
To: Shayne Chen <shayne.chen@mediatek.com>
To: Sean Wang <sean.wang@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Deren Wu <deren.wu@mediatek.com>
To: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
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
Javier Tia (18):
      wifi: mt76: mt7925: add MT7927 chip ID helpers
      wifi: mt76: mt7925: add MT7927 firmware paths and PCI device IDs
      wifi: mt76: mt7925: add MT7927 CBTOP remap and chip initialization
      wifi: mt76: mt7925: add MT7927 DMA ring layout, IRQ map, and prefetch
      wifi: mt76: mt7925: skip CLR_OWN in mt7925e_mcu_init for MT7927
      wifi: mt76: mt7925: add MT7927 power management, DBDC, and CNM fixes
      wifi: mt76: mt7925: use irq_map fields instead of MT_INT_RX_DONE_ALL
      wifi: mt76: mt7925: guard mac_reset against MT7927 DMA destruction
      wifi: mt76: mt7925: populate EHT 320MHz MCS map in sta_rec
      wifi: mt76: mt7925: enable MT7927 runtime power management
      wifi: mt76: mt7925: fix uninitialized is_mt7927_hw in probe
      wifi: mt76: mt7925: advertise EHT 320MHz capabilities for 6GHz band
      wifi: mt76: mt7925: restore FW_DWLD_BYPASS_DMASHDL in MT7927 PM wake path
      wifi: mt76: mt7925: disable ASPM for MT7927 to fix throughput collapse
      wifi: mt76: mt7925: handle 320MHz bandwidth in RXV and TXS
      wifi: mt76: mt7925: fix stale pointer comparisons in change_vif_links
      wifi: mt76: mt7925: fix MT7927 band_idx for stable 5GHz/6GHz operation
      wifi: mt76: mt7925: add 320MHz bandwidth to bss_rlm_tlv

 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |  12 +
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   9 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  72 +++++-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  59 ++++-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |  12 +
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    | 248 ++++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |  13 +-
 .../net/wireless/mediatek/mt76/mt7925/pci_mcu.c    |  19 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |   6 +
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |  26 ++-
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |  30 +++
 12 files changed, 479 insertions(+), 35 deletions(-)
---
base-commit: 97492c019da4b62df83255e968b23b81c0315530
change-id: 20260305-mt7927-wifi-support-02f9738a3962

Best regards,
-- 
Javier Tia <floss@jetm.me>


