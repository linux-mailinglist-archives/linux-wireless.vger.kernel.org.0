Return-Path: <linux-wireless+bounces-34008-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wZz+DUahxWlUAQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34008-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:12:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E41733BB2B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10006301DA4F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 21:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439333A1D1C;
	Thu, 26 Mar 2026 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="b6AIJ+Xq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IL3sG1Fk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9938C38E5F6;
	Thu, 26 Mar 2026 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559551; cv=none; b=n8M69jsxgqfQ66GtNoJPyrD3E3pxnXQCYssGSTFtfWNS2YaoUJA31RLZDABduOOYBsd6wMTM/g9dF2rniNqM97ZKZgtIQMb5EalC+ljzkNgu+/wAs2/mP0xWkloXrNPJgWxLomKn8sM6Khiha0tE6RdWtvztTHG+CSPRrLxDKr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559551; c=relaxed/simple;
	bh=EN2zeviwFL3UM1XcWFpml0kXrpH76dVjC7+heb94bFw=;
	h=From:Subject:Date:In-Reply-To:References:Message-Id:MIME-Version:
	 Content-Type:To:Cc; b=HQRLPaR+Hxa6W8lOYrU2ICKrNAaWtVIFL2A/sJoGR9gCY36ppVHhI9ZMurWNYJa0n+ajqwD+sm2IRftfCH0BDVXjjqg8ZkPKR0Bsb5M1ZzQDXlVAD7KOlYIqE4ccHqxLfWl1TkifzPZJ5mbSICc4NErwMgV1VslrdZh1qTEyGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=b6AIJ+Xq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IL3sG1Fk; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id E63BF1380140;
	Thu, 26 Mar 2026 17:12:28 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 17:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774559548;
	 x=1774566748; bh=Cv3m4TmwggmY9eo7/wpkhAhlQe/dYfbrzr9N5w5JXys=; b=
	b6AIJ+XqPSiFwhVeLHHeGC3KBTP38+K9VUqdK+dQYhdwKo3Ch9LiFms7TJsaLG8y
	4GyRhTVedwJfBKASRtmry0gNJEGcnq9G1OTm/uAJxacgaeRilhseWJjF96dBr7f1
	jtT/p8ohYTOhU9OAHIVQ7ltW9hkh0zKoJrdbqw295nmOSc9U77uZzEspk7LzuuBt
	PTndSl8EF173Jh8W5YsvBHA5ZgKS8ANYVSXOGwoT1GDMtXsyWdUl5tsU7gdiplCp
	KS8MLyHfmY+YLiDG9k81HVAoKMFZrHbzUlKNWskLBHb+bvL1tcZaLCrrLhKsh+vM
	kupVvIIxApQTVQ7arKo2yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774559548; x=
	1774566748; bh=Cv3m4TmwggmY9eo7/wpkhAhlQe/dYfbrzr9N5w5JXys=; b=I
	L3sG1FkPMpZYH75UWGLGFVJsxaiHaXgrN2To/radqcnOypTky3AxN4IfC5ofwVJ/
	8UUaQDxgEU1MJnE8GLSEgJkQu0kTXEYSrayClxx4kCauX/5SETSpqJumRAmQwuZn
	cmyjQykDE4cNu6LVzybtqlHubBC72fbTqcQQwYTaYivv3erphCdeio2jwFCGksT0
	kk2mRIEZ+RLF/JP/mIE1tERMceMwFkSQEpG7es5XndDEhcFomzDWgdUyCi22H627
	pwDygE9zS83HjkXDQukjNmihm/HLnGQYU9W3+fNXNc7i0OklF0LfG4CazHU09ZM2
	l1guO51ynUuH/reKRS0rQ==
X-ME-Sender: <xms:O6HFaTC-R9-uri0Og02SNVeAzRDoXDrI59FG_3JRtXhbZo0eMGTPyg>
    <xme:O6HFaUXuOVaHBF-lT4aSJSL-67zdHQNZo3c5p-ts-CgJwflRpR0-4FvuoKK4F6cP6
    ua9HItKJmU1yxHjyQHkszBqWrzlW0eirNcWpwzxkNSQs366eCMQN5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhufffjghfkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhephf
    dtleegffefkedtffffieelleekgfffhfeludevffduffekvefgueevfefhkedunecuffho
    mhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhm
    vgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    grnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgr
    rdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdprhgtphhtth
    hopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhopegrrhhivghl
    rdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrg
    hpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhoshgrlhel
    tdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghgghesghhmrg
    hilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:O6HFaRwPDghn09FhR1_opw5Ee0Ai9QV1VwP-vf1TcBh1qMFgwV9obg>
    <xmx:O6HFaeftl1sG5rABoX7HGRWN8T1-Zs-HYmbl6Wsi5ymitTpMFqMfzQ>
    <xmx:O6HFaf1NGRqjV4GSgHENK2dtFU74B7wgt7fd4ODuip-hVWgn953UHQ>
    <xmx:O6HFafuJ3DnBAfnUNQ2WvANLh3dfmNfYwbXwZhXzGY0ULu9fSMx8oA>
    <xmx:PKHFafQUX4iKLZjsNiV3EEBO0-k4DV6meqtmGHImy2zdV6Xk6NdfCXdF>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B3AEF1EA006B; Thu, 26 Mar 2026 17:12:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Subject: [PATCH v4 0/9] wifi: mt76: mt7925: MT7927 (Filogic 380) support
 patches 1-9
Date: Thu, 26 Mar 2026 15:12:24 -0600
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
Message-Id: <20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBBA4auQWTtJLaWNXsWwgDLVMRGaTvlJC
 He36PJbvLeDUGISuFc7JFpYeBoLzKUC/+rGJyEPxaCVtqrWFj/Z3bTDlQOjzDFOKeNisAnUONO
 7q/IWShwTBd5+40f7t8z9m3w+b3AcX6bslYl6AAAA
X-Change-ID: 20260326-mt7927-wifi-support-v4-5fe574b710c6
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5242; i=floss@jetm.me;
 h=from:subject:message-id; bh=EN2zeviwFL3UM1XcWFpml0kXrpH76dVjC7+heb94bFw=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxaE4aUHh2QSLhC0FFtLd0cGBFrdVm3tD6lPTz
 azm9ZrUaWWJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacWhOAAKCRC17sMLqGd3
 HyFwDACyWDQmuDU8hRKJD2LJYV/K3yrzJDdK8lx1EtZ9vK2W2zOK6uxO0IKr80VzLz9u9FhqIMO
 voyYQyCkjaeym9eAE+SZ+dE5/4ZN1jIwQF3WZUqPz674ydCjkHXzTBdCWt4nFo8BXVuUa51hDdj
 fBI7HVGLHnpn2N7NEl6+Zv3gGo15m0QpyWH2F1ob7HSS+keXdJ7sO5spfpw1oeXZXlQ5iwSKHei
 x9M60gPNgIn91P2T43gcRB7o55Cq6nyxLsQapYk2UNaW2DlXwtYFnaYq736HEdzDKQJzBVxRvc/
 jkivG43lWhi4/QhXUJdBwjLc/uZzMZvmvtl6AaFMDQCHIHHx5K1xKoe082mxXTHwUyN4+mBMrHM
 VTcMdVZ4/RL1P/ldhwDAH2x7MoAF8j0l6xe5nOE7SKXfHLk88xB61+luQt0XahtWnVT2TXjyBGA
 i1XxKYFbU8sX0GhZbt1lQMTUbQX3tk67MzFQqgKWRSQOLUy1wULHbSOaJeJr6CIH4Gl30=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-34008-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim,jetm.me:dkim,jetm.me:email,jetm.me:mid]
X-Rspamd-Queue-Id: 2E41733BB2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series contains the first 9 patches for MediaTek MT7927 (Filogic 380)
combo WiFi 7 + BT 5.4 support in the mt7925 driver.

Patches 1-5 add generic 320MHz EHT support (no MT7927 references).
Patches 6-7 introduce MT7927 chip ID helpers and firmware paths.
Patch 8 adds per-chip IRQ map handling.
Patch 9 disables ASPM and runtime PM for MT7927.

The remaining MT7927-specific patches (DMA configuration, hardware
initialization, band_idx, CNM quirk, and PCI device ID enablement)
will be submitted separately by Sean Wang as part of a broader
refactoring effort to introduce a generic layer that both mt7925 and
mt7927 can share. This split was agreed upon during v3 review.

The DKMS out-of-tree package [1] continues to ship the full patch set
for working hardware support.

[1] https://github.com/jetm/mediatek-mt7927-dkms

Tested hardware:
- ASUS ROG Crosshair X870E Hero (BT 0489:e13a, WiFi 14c3:6639)
- ASUS ProArt X870E-Creator WiFi (BT 0489:e13a / 13d3:3588, WiFi 14c3:6639)
- ASUS ROG Strix X870-I (WiFi 14c3:7927)
- ASUS ROG Strix X870-F Gaming WiFi (BT 0489:e13a, WiFi 14c3:7927)
- ASUS ROG Strix X870E-E (BT 13d3:3588, WiFi 14c3:7927)
- ASUS ROG STRIX B850-E GAMING WIFI (BT 0489:e13a, WiFi 14c3:7927)
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

Changes since v3:
- Dropped patches 9-13 (DMA, HW init, band_idx, PCI IDs). Sean Wang
  will submit these as part of a generic layer refactor. The CNM quirk
  (v3 patch 13 feedback) will be folded into mt792x_get_mac80211_ops()
  as part of that work.
- Fixed is_320mhz_supported() to use mt76_chip() directly instead of
  is_mt7927() which was not yet defined at that point (patch 5).
- Trimmed verbose inline comments in ASPM/PM patch per review feedback.
  Detail kept in commit message (patch 9).
- Added tested hardware: ASUS ROG STRIX B850-E GAMING WIFI.

Changes since v2 (suggested by Sean Wang):
- Fixed is_320mhz_supported() to check for MT7927 only, not the
  entire mt7925 family. MT7925 does not support 320MHz (patch 5).
- Dropped phy_cap_info[7] 320MHz additions (NON_OFDMA_UL_MU_MIMO
  and MU_BEAMFORMER) to keep capabilities conservative (patch 5).
- Disabled runtime PM for MT7927 (patch 9). The combo chip shares a
  CONNINFRA power domain between WiFi and BT; SET_OWN/CLR_OWN
  transitions crash BT firmware. Discovered via user reports of BT
  lockups after enabling power_save=1 (Reported-by: Nitin Gurram).

Changes since v1 (suggested by Sean Wang):
- Reorganized from 18 patches into 13 across 8 logical groups
- Common 320MHz patches first, chip-specific changes later
- Introduced mt792x_dma_config struct to reuse mt7925_dma_init()
- Replaced is_mt7927() with is_320mhz_supported() in common patches

Link to v3: https://lore.kernel.org/linux-wireless/20260325-mt7927-wifi-support-v2-v3-0-826feb8fef8e@jetm.me/
Link to v2: https://lore.kernel.org/linux-wireless/20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me/
Link to v1: https://lore.kernel.org/linux-wireless/20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me/

Signed-off-by: Javier Tia <floss@jetm.me>
---
Javier Tia (9):
      wifi: mt76: mt7925: fix stale pointer comparisons in change_vif_links
      wifi: mt76: mt7925: add 320MHz bandwidth to bss_rlm_tlv
      wifi: mt76: mt7925: handle 320MHz bandwidth in RXV and TXS
      wifi: mt76: mt7925: populate EHT 320MHz MCS map in sta_rec
      wifi: mt76: mt7925: advertise EHT 320MHz capabilities for 6GHz band
      wifi: mt76: mt7925: add MT7927 chip ID helpers
      wifi: mt76: mt7925: add MT7927 firmware paths
      wifi: mt76: mt7925: use irq_map for chip-specific interrupt handling
      wifi: mt76: mt7925: disable ASPM and runtime PM for MT7927

 drivers/net/wireless/mediatek/mt76/mt76_connac.h   | 13 ++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |  9 ++++++++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   | 26 ++++++++++++++++++---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  5 ++++
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    | 27 +++++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |  5 +++-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |  6 +++++
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |  3 +++
 9 files changed, 88 insertions(+), 9 deletions(-)
---
base-commit: 9ac76f3d0bb2940db3a9684d596b9c8f301ef315
change-id: 20260326-mt7927-wifi-support-v4-5fe574b710c6

Best regards,
--  
Javier Tia <floss@jetm.me>


