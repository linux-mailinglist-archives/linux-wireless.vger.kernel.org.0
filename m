Return-Path: <linux-wireless+bounces-34015-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDCVEZ+hxWlUAQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34015-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:14:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 073E033BB6C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 753FC30439EE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 21:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB51F3B19AC;
	Thu, 26 Mar 2026 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="nHtzQb+o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jYR2QCkV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A523AE71E;
	Thu, 26 Mar 2026 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559562; cv=none; b=WzvkddDfOXHpjSoXC4N6XGFvL5hQ+AOFD3Cz61MH6ddIRmD/Qt4UbiA2Nu+G/UTLvfLFoU9yzzml2PtWNSe3NVfqJLpnl9IIWcbfDyyWRmuByuEL1xrtC+5jvoXMXQ9cd0H2uY/mLCg/vdS5yfbsKBjne5zify/SbRjXhXWeAyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559562; c=relaxed/simple;
	bh=nWa4qRu3K/oLEzDqawtOQqtIO8UuGhdZfXRs4iLq41o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=bOY/gxOM3qw4mOLjkCzr55xPsU+eQd0fgetjTa+mRb91SMGkpuw34fODNJPQRFUbhUgKYjj1iMx2EogyWLVvF8yMse+oy2qVU2bmhDQe/3aLe/a4csNABhzihdpzOLxj/Rc7XoqBQ33vyaj4sKTVgsVNHA6lyetdmdjh7PBj85g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=nHtzQb+o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jYR2QCkV; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 6DC181380154;
	Thu, 26 Mar 2026 17:12:40 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 17:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774559560;
	 x=1774566760; bh=RgdC5kt5k6hG8v7cip1AuvGjq20kUgYnV+A5Mrl16mo=; b=
	nHtzQb+ooL6CWejvDDqx+gMjZ7gaZIARUwpZX0b5zJDfPUnk8DhGCnhg3nYGjTbT
	GtytB/lJaadoKFMvi/SmTsK1WDDHUvI0FA/JwH2kYLG/Laj5m1Rz+pm3X1oWD+1g
	KEYgOuS+w7s009kD9X5Yhm9rs/SvO9YudDO+yRd+eQpbzS3SQiw+HQgvLjc4q0fW
	aDnuGv2mmD6xTH+2pSje98gwT53INzlVrMqYlLKoGuJK8/nZ9YgVwZp9FdnJTc8E
	IGUIV5hokug0z2hT2Pj91XGiZmAk4nfCvqe7HXFZ7NMjy5sDW/co9pF9LeiV8NGt
	5kV4Ym6xAW2txysrflMeQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774559560; x=
	1774566760; bh=RgdC5kt5k6hG8v7cip1AuvGjq20kUgYnV+A5Mrl16mo=; b=j
	YR2QCkVO3zUSylGhmtgtgZ6LouyXz5oNuejKqROiKPZHjiHyso5TUX3B09t6viYO
	D78XqhOShsvgASMwytj2vHPUDJ0ANZQsKCxzWoVBPhX/9WINcSht5nHrQWC0evnT
	IPLNGBhXGkefyGmLieYXIjplawxEkmt7CgJRrhRf8hjC3k8eF/hRMww6iqRH9vx4
	+phIDKXjZt7utwucnGWnuODVrbHPBIiOcLAG4EZzfz3Xytt1sUat039mbPAg6OE7
	tVG0sShIBl2OWlgY21VxmZaESEta8s8GfvEhOdrT6B04fwaOOUQZBHp+CBGGwdHx
	Uo2EpOiRwiPl3qtLVZ4/g==
X-ME-Sender: <xms:SKHFaaH0ifUPcWRPOh5Dy0b5QZ36KQfWH08PWpge9BPfkIRqFctAUg>
    <xme:SKHFaWKigHvuVZDH0DS9OBgfe0p3xrixSXkwxNeaxpteg-BDboaqIwarw-BN89uB3
    yp2Ss3M6jjkhpEgt7y5ygdhqUYO_B-EzEYeuT38_Svtmi0kgiHZNill>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:SKHFaSUwpWvr3Bu4zA_YTcVwVDIu8pMwc34qZKJx1p0YZ1d2Bu1uRA>
    <xmx:SKHFabwU68w8jlrSmVBkOX8ObPKrZAYOr74ppD4w_6w7osmU8AUMGQ>
    <xmx:SKHFaa40wJEtop3CNAqSz0yIJN3ImWYnhhU-35emn3Cmf7h-m3GU0A>
    <xmx:SKHFaVjJW0jAzTmrUCTAf-Y4_Wk-Of9HTb3SdZg1x1u62scq0MWXyQ>
    <xmx:SKHFaTXcNB1KkuTHDKypgqFV5FXrk44J8le3IaZ6fbpN5qbR3WXhZHg5>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 44B311EA006B; Thu, 26 Mar 2026 17:12:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 26 Mar 2026 15:12:31 -0600
Subject: [PATCH v4 7/9] wifi: mt76: mt7925: add MT7927 firmware paths
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260326-mt7927-wifi-support-v4-v4-7-8ab465addcfe@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3298; i=floss@jetm.me;
 h=from:subject:message-id; bh=nWa4qRu3K/oLEzDqawtOQqtIO8UuGhdZfXRs4iLq41o=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxaE4Z4QGjHWFpDUbkgYQcX+KCxtMF0VbBGt7Q
 OBpnDkyhduJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacWhOAAKCRC17sMLqGd3
 H7r2C/97PZa1x2s1vJCzuJAqPYMEQADPRD5bdDsISGBDBaDCngYb6quYte2x1TSRqtUNpFn9M98
 J3zE3/9vUXy7pwJ/QsNN4++VanUrKHnBqs04YjHJmAhauwRTKIN38XhzUoVtZQ/0RH2b6xZyOxk
 A1VYj8kyFjzLeZbb5JrkNUzFtLVx4hbY7xZkBDpkmo9VsJm5v06cXMyEtn0xuqKHx8PeQV1Y8bV
 buniosAx9JyB811CVCuBvD6Piiz1C0Qb7oy7m+nBC3Mg7jqQP3M9Bj6bN87fb8epOUuJ6fm+QDg
 bNpyt8vSoEapBdwvJb86MZ5Zy01O1VNDGbHzlho3FDh4kJOWdH9jKrs4QGXxkJHQqa4uFCjAZqQ
 qfKsZVXZYPAgnNhnBbuNHrRa2QLIEixWu/3LB+98svERyqJLW4Bq1qn2Uif1f/LKUz65m5Sljlu
 SIqMkvhL2xW7rQJ+tokSb7NyP/Drp4X3eSN8j/y+SQ4ydKm4l1Nt5rIHnnE2OsHUvC9qw=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me>
References: <20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me>
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
	TAGGED_FROM(0.00)[bounces-34015-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[jetm.me:dkim,jetm.me:email,jetm.me:mid,humeurlibre.fr:email,messagingengine.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lgic.pl:email]
X-Rspamd-Queue-Id: 073E033BB6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add firmware path definitions for MT7927 WiFi firmware (WIFI_RAM_CODE
and PATCH_MCU) and the corresponding MODULE_FIRMWARE declarations. Add
MT7927 cases to mt792x_ram_name() and mt792x_patch_name() so the driver
loads the correct firmware for the 0x7927 chip ID.

PCI device table entries are deferred to a later patch to allow
infrastructure setup before device enablement.

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
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt792x.h     | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index c4161754c01d..f820d5aeb723 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -633,6 +633,8 @@ module_pci_driver(mt7925_pci_driver);
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


