Return-Path: <linux-wireless+bounces-33899-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDZoHS9gxGkuywQAu9opvQ
	(envelope-from <linux-wireless+bounces-33899-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:22:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8343332CDAF
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1C0F3020FC7
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B2839DBD2;
	Wed, 25 Mar 2026 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="SnNfzvIE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a70f6694"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2058033A9CB;
	Wed, 25 Mar 2026 22:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476681; cv=none; b=utE4DHnz1wkPZfJACYtD8szmv4jTeHQPP8uPn1C5Y0M4oeTHf9+LaeQunfvnyDKi1cJp8ZEjDc6iYPna1CzdWyoqu5eY8NPMXfvvyXGMz0DFuMQJKuKRbQz5FeopclNlddR8BHzbpJU282fnyOsGnNDycmxizPrH0OKTiiSXgQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476681; c=relaxed/simple;
	bh=nz8eyDAP8ActMVY+DXN7zhQnBrM5b9VLE4uS6ZrmhBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=sIiq54a2CfZ6BDjQmQ7cV2yJjbzXapTN+nJEPpaMXsq17IUQCRaUmZuH0CRSSN5vuEO6/hx7ArTkIrNmMuCwXllPAl7HID/rbpwGr/bpL5vDuUs60wk4K1CD3A9oGkJByjQOqUyOS1WfkJuVEZX7WR524yef48cbJPUTiU7jb5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=SnNfzvIE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a70f6694; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id EC6C1130053C;
	Wed, 25 Mar 2026 18:11:18 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 18:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774476678;
	 x=1774483878; bh=M6mqwUzvrAper/bN3xuewcXmVlq92pIpxYo4QqPfYVo=; b=
	SnNfzvIEayMvvFxOqwdPoLrqnYJvY2cIiDhFrCdrj0qqj/d1A2o4F16xV3Ni5tBO
	fqdbfuhFAbOSmNaen5PEokI30zKsGzX1ql35NACfOO3ngxegHTu/iHYkucqi1Z0N
	mrYbHLwIJqUh09lqO6y1kevd0CcBXwdslOIfHKbFFPlCS6/u1Y76O5JdhZSotWYh
	IIRIGSLMDGa+JjK/3j63VHTeuNITsTkhWuYQntgOUpruMUYa55zxt/vGh+7onmCG
	d2iYS4PZfAI2D8c94E2Ym48Y8m8fh6kjS4Zl/SNGowktMXlVVyuvlRlNDzbbKyKe
	pOW+6gE+YDygXawW/t3s+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774476678; x=
	1774483878; bh=M6mqwUzvrAper/bN3xuewcXmVlq92pIpxYo4QqPfYVo=; b=a
	70f6694tz62Xc8j8aDTbl4XL8fBjUhrnpwzEFEIXCkBeppYlruRhJokcoKTyUHnL
	b9BrYuDXBrMmpQbkrPMxbO7CshUyZTBPGTbb1UYEXbStgfI8SAZjy9eADwwt8yZF
	PwbBep2h2WZdP02DQjbehNsqy/zAJSR6yT6UrGhtFRMKONSgqudxBzxoQJoUZY3s
	A+NZ4GMo09Yx/jZWkrhx0SP2GJ9Yj8UF4YcEtp4Dq+xkjWwltaTdRNoaCtxW8nCr
	CHdgaSuvZ+JolLKFQtNkxWDf82OXyrv8xs5XkOEQkLi90YR1LOg547lvt4vLZy58
	rim8oDqGtl5EA/GEbNXFQ==
X-ME-Sender: <xms:hl3EafriAVxtPaAInhLnXOwA4NjaRA_VU071yMNF-eySFJGjqUCyUg>
    <xme:hl3EaUcUwcTPpeZuuTYK8MuVk_5Vl5AdCO0R8TLp9xfmdxeixEb_A9mRolDjivqId
    74r_63N_PEL6GL1OCZXFKUmkfakOvLzOmAlwKkkM5BxdtMbcDuO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehiedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:hl3EadbGh157rIcHRoMYkHRDU0VfJsC-iI8OTCAuonPPRSyn7YnZFA>
    <xmx:hl3EaRlE9DPeE0qd3-SF0lN4PBjGIX-OMoQkd1Fa-U_4zlHxw8Oa3g>
    <xmx:hl3EaUft8gB1qD3B0CWyD1Iev4iqR69bYbkBmxEvcL18HAL-xQCLRQ>
    <xmx:hl3EaX3Y2Q2_rFfHeYqguGQNnRIGzJKRgw_OqVds3m0rI16qG4JdhQ>
    <xmx:hl3Ead5PIgqJzG-4QHbPMBoBacl6zUCopEGTh6YO4cflLoEqQ6qzTX_a>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A54FC1EA006B; Wed, 25 Mar 2026 18:11:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Wed, 25 Mar 2026 16:11:02 -0600
Subject: [PATCH v3 13/13] wifi: mt76: mt7925: enable MT7927 PCI device IDs
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260325-mt7927-wifi-support-v2-v3-13-5ca66c97a755@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3386; i=floss@jetm.me;
 h=from:subject:message-id; bh=nz8eyDAP8ActMVY+DXN7zhQnBrM5b9VLE4uS6ZrmhBc=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxF1qy4OIzFSfVctdeylxN5WN7tUEOZFYihOYc
 hArKVR8gEOJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacRdagAKCRC17sMLqGd3
 Hz13DACpvg2+LOJwEmxAMtdMLLvl9b8p3hqly1uXSDGdGGGFLf5pdYJvjqXrCejT7VLB14pVlux
 /j+bMutS/fM6jxaJguR24s8ZPwiyA8nXSFX79u0Vo9vXxxhKL6G1JpkEykVj/bgxN+oT2VHKIZi
 aKH6UrulsXzNSckegviWbRRAwDKDdfnc+I0WIW1WARdYe4Jut+WQ3CvQtd7TjJrb/6jRO0Mgb+t
 rl7SZPWfg5KoB2OjQ9ZNMfJSYlbx45P9c3B9F4Nmf95umaHzLs4BJkak3G1IMGUhsEINTudMGmc
 tHz8jkCDZvUDRwzUB4gJ5ZgN8Pn9eDKT23NQj9KcaoryYTDrTdjrCJHF2+f+QPi14xzJmTuUSth
 MZk603BcqP4binMIZJIV7z596TNGyYBwaNTQ/EQgV+qDwEnO3V4nvQz/XQVYnFyVNU22Y+fZDHJ
 oIfm3BGyGmyVXywit2ZZLfdU+wCC2TK2SKU4bqK90bOEZe2nMjUyEIRy+zhbi2rxs2B7A=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me>
References: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me>
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33899-lists,linux-wireless=lfdr.de];
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
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	NEURAL_SPAM(0.00)[0.837];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,jetm.me:dkim,jetm.me:email,jetm.me:mid,humeurlibre.fr:email,lgic.pl:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 8343332CDAF
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


