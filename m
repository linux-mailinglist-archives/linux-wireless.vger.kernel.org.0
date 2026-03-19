Return-Path: <linux-wireless+bounces-33528-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBceN5t6vGnOzAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33528-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:37:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1182D3450
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9499B30010F0
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 22:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6457B40F8DB;
	Thu, 19 Mar 2026 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="AzP5Ohth";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0N1FBmJs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A92408238;
	Thu, 19 Mar 2026 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959092; cv=none; b=lyJAgs8rsp/AiLdO8PkWGKF/mxpp4Lz5GzBYIIuf2rWi2lrBOv3t4G+BFOdmWcdAOkonYups4U0y/MBKOR6J0vI264CrBJbqawQndkQmuOuugJq5KsG8mZ0FAfROXjUJU/Bk0nflCbSR2ift16wfWmOkfB9bPb/dNkQxKMpN83s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959092; c=relaxed/simple;
	bh=nz8eyDAP8ActMVY+DXN7zhQnBrM5b9VLE4uS6ZrmhBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=SkFY0z/Tr6SPec+xlTOIhAFRc9kCf5r6phvT4lyzh9D+1tnwjDcFXO2lCIxSYQPpnSTG/i5zx3tUj+AfNrnu9QQQ7Sv9P7tQLjjGPxCeS3/uoXvZRIdcrivAMHJ3l7ExWWMf3DCJXwgHA3cn45QmKnf6fIUdEobHY2VdeARHZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=AzP5Ohth; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0N1FBmJs; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 9C0B91300170;
	Thu, 19 Mar 2026 18:24:46 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 18:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773959086;
	 x=1773966286; bh=M6mqwUzvrAper/bN3xuewcXmVlq92pIpxYo4QqPfYVo=; b=
	AzP5OhthuIMWHDuLNYLU4bKg+OwoC+HW6qG+2IMF6bfOUEp8wSHJUURmNZrGXVEF
	UM0Awx2rTE7AQJXEWMQqrwle3a903IMlqNnzJBIfw1JFNAw7ZUcRKqnY2QYYJuD0
	YAe91jz1HyuuctL8IJk1mBzyCKcQ1VaH05k0aqYpaMR2am5RD3RQq6MIHEH/Syf8
	h2YzNSFk5whXS6E59bH2oRSqEuKI/G/pGBC/wVzfCdoEo1MT+yJCpgi2LuxyltX2
	AmOAz+3EjVLXunmEB/sZZndf+q9Sns58cHxV7GLW0KYMzFGDeb3ULjD2ZntSRl4F
	MZSp7OH8/spDzlb0kTDRNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773959086; x=
	1773966286; bh=M6mqwUzvrAper/bN3xuewcXmVlq92pIpxYo4QqPfYVo=; b=0
	N1FBmJstklqTbwHJbFY/DwOwscV9pi9QRwXkdg5l0zciJRvR8n2J6ZrYPP/0Ku1s
	aVNCiigAjZkDXBoeeVXDxjAK7Gk2Vf/pdWq58cGnWSfpEGdhKSLJwinvXm3o4V1y
	epHD6fMjUP2CWEud1QTLrbun3j/K9C306gZYyQA6sa6SYQq+bHJILoT0r8ul7YIa
	XCQgs5dOWIgQOdq9O7k9m4LHuomCuNAgQQE2eTMbxj22rA3YMhiP0sIbzfvYnFXZ
	vfZYS1LLzbNIKFl9Ez2IYivbrbi4cfViUrsxTzfWJVtVEPJfweULZEudHCt6eftc
	1+rSyI8WrQARJLYlS+6FQ==
X-ME-Sender: <xms:rne8aV0y00RejmpI0V_ks5g0-PF4_r8RTEEcvfCZE27h7_m1glEIZQ>
    <xme:rne8aW7TdvxxJbXkBJmjUWbjnNteSOq4mLNQvHEUUscjq_FRsRUvocjPu1XLEIo-O
    gMjAcc0NTPhS6rTyoncdsLJmimPt4_cyiFs8cyiK_oknNfVTKHXH5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepkeenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:rne8aYH3ZM7wIVrTgahcBv85AszxVME5qxH6IRShKVs8AMWTOGzxNg>
    <xmx:rne8aeief7Zgwl4j-h8Qfp6GKEPpq0b27XJZ3_QhPNyy3n7R0SbrPw>
    <xmx:rne8aWqRsgItE4EkrI64uafcY_mAWBWhd_arOAZptjWRbZwv1dD55Q>
    <xmx:rne8aWQtLqRwG56Srx2WrdzMEtPHFYdvHG9XLu9wdXTrIW2oN2IbUw>
    <xmx:rne8abFuyG0cF2xqxJt7Ow0kU-ufJaw9HD1-P3zuLF87m3RmwW9Kmm2t>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 535E01EA006B; Thu, 19 Mar 2026 18:24:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 19 Mar 2026 16:24:29 -0600
Subject: [PATCH v2 13/13] wifi: mt76: mt7925: enable MT7927 PCI device IDs
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260319-mt7927-wifi-support-v2-v2-13-d627a7fad70d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3386; i=floss@jetm.me;
 h=from:subject:message-id; bh=nz8eyDAP8ActMVY+DXN7zhQnBrM5b9VLE4uS6ZrmhBc=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpvHeRUYSIdSZdhtvKx1x5yK4Rd8yQ8NM1L2y0V
 rwy4ahifPSJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCabx3kQAKCRC17sMLqGd3
 H6EjDACXjQ/CypFIMH9QqO3ZVzJcRAEYRiDM2yAwOTT8NeaV+whsm7ba9yo2QfOWd2mP4VB9cpl
 eA0YVHzs8et9cr8QCThStHUjmHULxnTXmEyxBq1oCAiIHv64XmXzfUBce9KIZMcZfr2d3y8Sfmm
 l0q4BiKktjoeR63G01IwQRRNdY++/XZ2BCELkFtPpYxY5Mj1SMkf/acB6GQ0ZR9pAhhZrGk7DoC
 N0g3f8Y4bUJs2DczHk0zZbK1SjeoroWIHDRW9/stoGm7aOeo591QGr5Uj5kiQPaBqwCLMiNkff5
 W60lYcriwLFRrJPKso6BODuiF8cthK34P0WYXBq/DVheqq/DCFmQGxoVVEUkvCMuxXh4ap4dqtu
 betxr7LPtUNdlocVDcTANJ8Oy+iO61YTX8v0c2ECnb6Yh7s4r7TEPosGZhTnovhi3ZAW3QRolot
 ioAejmcK1k2HQrzRfWjq5hJnyrYLGAxigHC5CtImWlEPycTaf1JFFQLPGXhdjYEffZRXA=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
References: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33528-lists,linux-wireless=lfdr.de];
	R_DKIM_ALLOW(0.00)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lgic.pl,gmail.com,humeurlibre.fr];
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
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	NEURAL_SPAM(0.00)[0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lgic.pl:email,jetm.me:dkim,jetm.me:email,jetm.me:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,humeurlibre.fr:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: CA1182D3450
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Add PCI device table entries for MT7927 hardware variants:
  - 14c3:7927 (ASUS ROG Crosshair X870E Hero, Lenovo Legion Pro 7)
  - 14c3:6639 (Foxconn/Azurewave modules)
  - 14c3:0738 (AMD RZ738 / MediaTek MT7927)

This is the final patch in the series, enabling MT7927 device
enumeration after all infrastructure (DMA, IRQ, HW init, band index,
power management) is in place.

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
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c | 29 +++++++++++++++----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 693e08f35d68..00c3601f14ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -16,6 +16,12 @@ static const struct pci_device_id mt7925_pci_device_table[] = {
 		.driver_data = (kernel_ulong_t)MT7925_FIRMWARE_WM },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0717),
 		.driver_data = (kernel_ulong_t)MT7925_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7927),
+		.driver_data = (kernel_ulong_t)MT7927_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x6639),
+		.driver_data = (kernel_ulong_t)MT7927_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0738),
+		.driver_data = (kernel_ulong_t)MT7927_FIRMWARE_WM },
 	{ },
 };
 
@@ -530,7 +536,8 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_pci_vec;
 
-	is_mt7927_hw = (pdev->device == 0x6639 || pdev->device == 0x7927);
+	is_mt7927_hw = (pdev->device == 0x6639 || pdev->device == 0x7927 ||
+			pdev->device == 0x0738);
 
 	/* MT7927: CONNINFRA power domain and WFDMA register access are
 	 * unreliable with PCIe L1 active, causing throughput to drop
@@ -546,16 +553,16 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 		goto err_free_pci_vec;
 	}
 
-	/* MT7927 firmware lacks the connac2 feature trailer, so
-	 * mt792x_get_mac80211_ops() can't detect CNM support and
-	 * replaces chanctx/ROC/mgd_prepare_tx ops with stubs.
-	 * Force CNM and restore the original mt7925 ops.
-	 */
-	if ((pdev->device == 0x6639 || pdev->device == 0x7927) &&
-	    !(features & MT792x_FW_CAP_CNM)) {
-		features |= MT792x_FW_CAP_CNM;
-		memcpy(ops, &mt7925_ops, sizeof(*ops));
-	}
+		/* MT7927 firmware lacks the connac2 feature trailer, so
+		 * mt792x_get_mac80211_ops() can't detect CNM support and
+		 * replaces chanctx/ROC/mgd_prepare_tx ops with stubs.
+		 * Force CNM and restore the original mt7925 ops.
+		 */
+		if ((pdev->device == 0x6639 || pdev->device == 0x7927 ||
+		     pdev->device == 0x0738) && !(features & MT792x_FW_CAP_CNM)) {
+			features |= MT792x_FW_CAP_CNM;
+			memcpy(ops, &mt7925_ops, sizeof(*ops));
+		}
 
 	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), ops, &drv_ops);
 	if (!mdev) {

-- 
2.53.0


