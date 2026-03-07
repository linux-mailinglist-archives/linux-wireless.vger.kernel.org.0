Return-Path: <linux-wireless+bounces-32692-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN5rDeF0q2lCdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32692-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:44:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56268229156
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A94431170BE
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820F926F46F;
	Sat,  7 Mar 2026 00:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="FQ8Mj8SA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zkozg72i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA0528507E;
	Sat,  7 Mar 2026 00:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843622; cv=none; b=nca6l6rN59+pMXilfGH0lQb05QUhXzy98cOG0h7XjB4Hoe6btT2yX0XpxL7uxkITMEwZJ4tgg3Dbn02Y0obo7dhOzru1r4Ox7jKCsbGpcvDLDWg0JwJOXRek+CH2BP8X0wjXYYa26rMzazNuf0QBBFVqOkX5JkACYsEAlN1g9V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843622; c=relaxed/simple;
	bh=fB6otMGIwko1yonItoV0W4EcmOF1mpMAMxLshlLLqx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=RduNamGTG93UJ6JmzRkqAUgX64Ba28OgsaVjHEj/SFyyTcZsp59C7mqxj14LSwnHvABWyOQgp8qlV/L7L6Yl65UeuiHI1TYa7g7zaU03Hv/uvwV7/PVzwuitFg9bYAglrXbkRUjY7DLdXJbkz+BugQjdYCJeE0LX9e/YJLBKNSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=FQ8Mj8SA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zkozg72i; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 8B3D51380A3E;
	Fri,  6 Mar 2026 19:33:40 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 19:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772843620;
	 x=1772850820; bh=AV5pjfr8DB4LzAYJo0LZOvg+vcORVwMVJnNA5YqOM1g=; b=
	FQ8Mj8SA/lqtFbHg4yYxEzGXo/TXW1cm45MI/fjEg6S6HRqg231tlcmdd7FCXcMC
	p66JlQ0+DPsJYuP8k88yoN3JwL8KavoKCqrnfIlPQm5TdMis2HnjzKEnHKnVRDkS
	zLdeRzzZXDxceQA/OiOZk/HiVdSfmdt0brSEKdRm75Y2xKeFbGZmzz5GRYKP+IL3
	NHx1kvQFsv8KY+UY148YxKI0PYVg7iPA3EM1YBlw/lAEA53ra+cgfAv4hK5G18ai
	15UZ7Xu5FwMRNTKuPCl0a36JUangWIYKvsh5uTT+SYA52LqFu30L8OKKhpCat5ks
	2CWG3suK3Ii8u5+kqecPbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772843620; x=
	1772850820; bh=AV5pjfr8DB4LzAYJo0LZOvg+vcORVwMVJnNA5YqOM1g=; b=z
	kozg72iS6ADapSXG9DkoV+rVk0bCksC0GyhUOiVw7XJoM6F4e9YhqOuDERremdSy
	5P7o4ge0xi8bBF47k/vr4QYYCuQcN4aRGJLPuZMC7iqDgvCIwxWW1bnX5Y5zzcPM
	ITkj6m9zWTo6rdrLuVEhI+Z+11l5jcX4dd6QsRmUB8uw3gu6Cp7poKtQgv7XuP6R
	+1Jt9Q6BYZUnsA00Uzg6oll8wSXO+bf/4Fvzdq3MnvBhpRHrFm93jNK9Rij1RMXL
	NdVdgMF9YBBngLsvo7GmGySbrtSXsuTh9rsalWkdDVYYVWcwddHunhf/VxI5NTAw
	1So+MzmTaudYk8XQv0Zcg==
X-ME-Sender: <xms:ZHKraeUfiCW50Ex6eoB419vNw2bRtxUSJMFqJMWhU8QdoCeDhe9pWg>
    <xme:ZHKraVYmSCBkct6dsumc8GfBwmPpDjhr1rf1kfduRCKGRCV-bhzoK_uBnWHcW2Pc2
    CHWiOfxATn6IbTbN9QF4-VvvcZ7c_MmO99pmHWFESA8J-QB32PGxMGN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ZHKraVWsp8mg3w7PwlWbHjd4K5fYEaIj7kS2_ghjl_PmzD8pgViQaQ>
    <xmx:ZHKraaex5Rfss-j9385Jehtz58GsVlDlqhOo1wtZDiyg3e9UD6hC2g>
    <xmx:ZHKrae--iHo9b7Jh5F0fqcLRlAtqEcI9D2ZIh6yakck0_njFYrrjOA>
    <xmx:ZHKraabVulp8WJOfGHkWBiqWOw4BlXzwGCebNumpKDbwP58xhaFokg>
    <xmx:ZHKraTS5DhWwQyGGNjOo6DtdAayThibaO5D7SBBVQ83f6BzbjAeixgJU>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5ADF61EA006B; Fri,  6 Mar 2026 19:33:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Fri, 06 Mar 2026 18:33:24 -0600
Subject: [PATCH 05/18] wifi: mt76: mt7925: skip CLR_OWN in mt7925e_mcu_init
 for MT7927
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-mt7927-wifi-support-v1-5-c77e7445511d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063; i=floss@jetm.me;
 h=from:subject:message-id; bh=fB6otMGIwko1yonItoV0W4EcmOF1mpMAMxLshlLLqx4=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpq3JP5Mpt9lS8a/Lf2blvrfs2Fodgx8e4mRQlI
 oSw1PgK/1uJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCaatyTwAKCRC17sMLqGd3
 H1X8C/0VHd6bjvKOIqAdusuJtLoSCCk9t+e+vfNGLFaCw3MfemEChkITad1xYNjzb/YkVvViEnt
 iO7PWdfVTQBnk915cpdyXVErc78+SdOwa/4NOKWPnokTYjxpOldhHWcGDpebN0hg3yTxaFqzxq0
 ejd5GwBgvQHmLMZSFXaMeyM68kdGMXEF1UeWjTnWXFk63SLElkCygZ/HTp+VMSWHaU51tWk4OjW
 vvUuf5Mg6UkP2J5X5nIXCCMF4Q8GKDiCmsDFYMbMSLaQYMrcG7HGwwBZ+jKLjysdDEZ4snIUbZ7
 frH/N/8zy7kNhIIcKRyCNJQXNLk3RSm/VQLpv6sXbbWy3Y3YxEvWLzu3zQ1hhmnoN+Up+b56dfm
 p4AjqdajHcApTVCJXIO8rja/ew2qS3C75I3nlOR0p+1GlpP4yQioAlnAwBnGLv+s57a0JB0QEoV
 G38ep8746pwkjd+TvgphytWBXMVyB71uEu4JPnOFGdhNUFjqsNYGvb2/V6xUvgodyfm5I=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
X-Rspamd-Queue-Id: 56268229156
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32692-lists,linux-wireless=lfdr.de];
	R_DKIM_ALLOW(0.00)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
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

On MT7927 hardware, every CLR_OWN triggers the ROM bootloader to
reinitialize the WFDMA engine, destroying all DMA ring configuration
(base addresses, prefetch settings, descriptor pointers).

The DMA rings are already properly initialized by mt7927_dma_init()
which performs a controlled CLR_OWN before ring setup. Skip the
SET_OWN/CLR_OWN cycle in mt7925e_mcu_init() to preserve that
configuration.

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
 drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
index 6cceff88c656..206d525eb550 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
@@ -35,13 +35,20 @@ int mt7925e_mcu_init(struct mt792x_dev *dev)
 
 	dev->mt76.mcu_ops = &mt7925_mcu_ops;
 
-	err = mt792xe_mcu_fw_pmctrl(dev);
-	if (err)
-		return err;
+	if (is_mt7927(&dev->mt76)) {
+		/* MT7927: CLR_OWN was already done in mt7927_dma_init().
+		 * The ROM re-initializes WFDMA on every CLR_OWN, wiping
+		 * ring and prefetch config. Skip SET_OWN/CLR_OWN here
+		 * to preserve DMA state. */
+	} else {
+		err = mt792xe_mcu_fw_pmctrl(dev);
+		if (err)
+			return err;
 
-	err = __mt792xe_mcu_drv_pmctrl(dev);
-	if (err)
-		return err;
+		err = __mt792xe_mcu_drv_pmctrl(dev);
+		if (err)
+			return err;
+	}
 
 	mt76_rmw_field(dev, MT_PCIE_MAC_PM, MT_PCIE_MAC_PM_L0S_DIS, 1);
 

-- 
2.53.0


