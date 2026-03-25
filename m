Return-Path: <linux-wireless+bounces-33896-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMRCC45hxGkuywQAu9opvQ
	(envelope-from <linux-wireless+bounces-33896-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:28:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9AB32CF7A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B12E3135E06
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB7A383C6E;
	Wed, 25 Mar 2026 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="EMyEL8CA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zblLEkJo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5538E5E1;
	Wed, 25 Mar 2026 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476676; cv=none; b=iwW0FCHZimqdwkOr6CgxVqAtigW7d0ysz37fePdLJxAQ7nuI3wjpWDERyoTzm4EsAB/4HSuQ/io75zO8eQ8X8T1mCmJLyEnbUxFUcLtLhxtMrIMA2S07TWgbiSkh/2gTEs/eA9yiaU8Zq4Q9eq+XSfC+//l4ZZopAqo6PEj9vZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476676; c=relaxed/simple;
	bh=nWa4qRu3K/oLEzDqawtOQqtIO8UuGhdZfXRs4iLq41o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=u/pMlJVV7b76cuH4AJWuAVqdXz6gPcST35oFvczbvWAwGz7uZEE5wkPTk6F3+O3610KlP/WFg6fogbHg9++YjxY1iZKN5oCp01loO0WfDruOsjfXXi1Tt3N5s+DKAKP5IIjcwiBeBKUIdo9KRClivKY1/HxJiuhkh2JdLANRvmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=EMyEL8CA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zblLEkJo; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id EF6411300522;
	Wed, 25 Mar 2026 18:11:08 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 18:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774476668;
	 x=1774483868; bh=RgdC5kt5k6hG8v7cip1AuvGjq20kUgYnV+A5Mrl16mo=; b=
	EMyEL8CAeniknA6fI69yWrGzATf1FZ8EkIZ6qCdXCxp19WQn8evmQD3lrCqqv/Af
	WVtTVqRm3UF+1KBn6yl+8vRJJYboR6xXBK38o5QJTYZx8IaH+x8OSTUJ0XUpPnH9
	fqlMBHGg03Hcm7mE58zE0GLBzFvRVBc+Dx89F2ZJQUMEWNShJ32lYKcPyIVT/m4N
	G6NGhpjub0HfYJnVvHKK+6s76HxyY8dgqYexLdeqNWoVii+u0yZh1Z/2uqfP5lEI
	FNEyaLtSidI7jkSv8x4y789VzOp0+3O+WzQadYrvFTcicLzq/OX5ors0l89l/mP7
	SbO9/vdgi8Y+L5djk8l2lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774476668; x=
	1774483868; bh=RgdC5kt5k6hG8v7cip1AuvGjq20kUgYnV+A5Mrl16mo=; b=z
	blLEkJoxMvLUMFNaTJZVvIV9hSDCPZDx8pNuJlXDSg4TnBi+E8068EVQkQUldQ28
	UwfH5JjME5Uo/osnfcHmmMAWFjTDAWJZLeKbVftHGzsyqt3AUmoEvz4prn0sVGYC
	zpzGKJkYw3EARZvanNRWUuPKZbdGQwalBn8D0F0X5yGE2ovpJOT7bftdA7OwqZfp
	kTmjNLzasDTj0GFta1KqBYUm05EF9C9x7NeiS48DOWqRCv2047wi50og3ZQV4KS6
	9sfHpDataIbEINdimS9rxbjN9/CkniaVpg/b4Qgcp5lRdM17Soxl004GsaBvytu4
	iiJvNXGGTRqGnq38XYIlA==
X-ME-Sender: <xms:fF3EaTt2xgc0BJ7uxJWGvWQ6Nb2YC-CeMKiOlu00zPPqIO85I25feQ>
    <xme:fF3EafQsrKHzSHASPS-ONEmnc6o0qtX2qvDwZ8xI_X5aeU9WHe8M83eReudxTFfLZ
    fJUkHGTAxOCjdr9fEXW5Lsqe-Xzv17F-a_i-rVtG_mH4LNt8-NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:fF3EaS_4gsT1OKX5CazMYU-1wmc58h6Zvw6iiBzhvk3GU83wvwrORQ>
    <xmx:fF3Eaf48SvrVK5mLDrBktlFeiCigMO5K3dP640yVRrV3dDV3AEAP3g>
    <xmx:fF3EacikR7pSdAvvggPLbUhg3PkFDq6tXmtysngKz8IBjDY3v96Q3w>
    <xmx:fF3EaWrgtRzqzUJFQW73ziL771z9z3CuYm6KLG_fXFBYnfXiNLpyoQ>
    <xmx:fF3Eae_sHzy4R80XxeZSBTIq6zNc_tND3mZ_WdTQVzv7YbPaGR25WktX>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A4BB11EA006B; Wed, 25 Mar 2026 18:11:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Wed, 25 Mar 2026 16:10:56 -0600
Subject: [PATCH v3 07/13] wifi: mt76: mt7925: add MT7927 firmware paths
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260325-mt7927-wifi-support-v2-v3-7-5ca66c97a755@jetm.me>
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
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxF1qM/TaP2bw/ec1p3ooFz69AbfJyZP/6Y2Y9
 WA6V5CPjxyJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacRdagAKCRC17sMLqGd3
 H0GfDACFasrPPGfSBAZkVayWMOCCTN4htPlBVa1k2crZ92GChXtQ0ldeaYd4EASB9QJHMOXvY8A
 4l0TyQyWrtOt2SXOrpwijYOSsfcCtBbXVjx9QQbp8WkDVq8KwVgjnFVXhODaMd2Qy6uPgxWoqWC
 JA+FNooQzREwyQoFc0/FbAYqEpA54qbgdtLrLKEdNk2TzOWR7JsYajJDUADgcep+a7m88vSwIAf
 pZ6MO8yLhvQsGWq0PgnrYAaWUVfXhWGwxy7E+1lIRzMXYWfu234xK0AExWd+kfuse23BGkXnUYS
 64MQqxROb6LmPUZRbNiqX5KH9HQFNIJHPPjpRxkDN3MIqgXc0+tbMJ55YxsPqKv7FEohlk4L2rW
 +PQqT8LdQ4rVPzS0bHkeS1yUHOWYzAKAPkCEuRJnRE/yPYiNiZuOf2eXeKzgC9qr9b+cAgOKctp
 T9zpoBNesTu3CV7tisq93gMoH5V1Nytkdi2wtmj4gfdAbNXQaT8VevSdiBLHde09tlF20=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me>
References: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me>
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
	TAGGED_FROM(0.00)[bounces-33896-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jetm.me:dkim,jetm.me:email,jetm.me:mid,lgic.pl:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,humeurlibre.fr:email,messagingengine.com:dkim,mediatek.com:email]
X-Rspamd-Queue-Id: AA9AB32CF7A
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


