Return-Path: <linux-wireless+bounces-34017-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKwFAT6ixWlUAQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34017-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:16:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B33C33BBD3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B44F3306128E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 21:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88A83B6C11;
	Thu, 26 Mar 2026 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="hnzdRHBI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZRCdhSoA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706F83B4E8B;
	Thu, 26 Mar 2026 21:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559565; cv=none; b=ZMeCFaKk1/AAdq0clDW3y5iKDdE+J0qnO//NKXGt5uTV4+wPvHDwqXFNOpuO346Ih26Rblul9Xu5fMixnY1+wMNGtAfYAbEXnfStlvo/rRp59cmfIuQFwBWWkuXmDMt06yaZKHpkO25VL4ngioKOsJ10Ebqsn83pxxVuF08aatg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559565; c=relaxed/simple;
	bh=EttSMB/87XiHGZhWtMpgNAtlCMJydT4Yjw9bIPiDhNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=gkDbFncVuI/j+33BhrnVOUZPGzKUHsmspcMxgb0fFTxz+LjHvPg9SFuxApTvPCth+tsM4vBDKNtNd4XTjJeHipEZqyAA35jWIvzC4IzQsP8O7rPqXezlx+WAAv/entN245mgf9Nz9+k5yvazxn3DHwDqL/H+DmSKnkZ6+yBXdOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=hnzdRHBI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZRCdhSoA; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id BB1A0EC0218;
	Thu, 26 Mar 2026 17:12:43 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 17:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774559563;
	 x=1774645963; bh=JD0LmIz415XLpZYRfQu0zc+Gi+UZQoc1q5KNADfTGZk=; b=
	hnzdRHBIHG1/9WJtKjE6nR9fL+CuiqPH/7Ehd77ZDJkHY2s7UHSnDa/VLqpXXd51
	UTpboA7P+8qX/+wr8vH7TGa/jctnVhDnVzCMV8m+gPEqaK+m9rCMi2cKS8CvCSEV
	Lt4aiestcJpMdGms2VK68OhXJVwq2bb4bvU+iv08vBRa/GNupJPlIZtRP1JQ7uof
	B720PqzFPxhEiMBvB+rPecY2lxoku1K9vaQYMEoGQsAfjRsoHHlJsGwohGKURsmR
	EOSd2LN2JKW5KoCMc5C78i8ErplKaaJZjeFsZpX/t34v928K009QtWtPgXyCBCsF
	E+Kw7bJSiuaQMPG6Jq5XFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774559563; x=
	1774645963; bh=JD0LmIz415XLpZYRfQu0zc+Gi+UZQoc1q5KNADfTGZk=; b=Z
	RCdhSoAuZUUlREC6M7rMNec53ZcIUf9a2vSORueVzo2Eb7tdIXcVf9UqkGcRY+W0
	P766JJjUdAcckzx1V88ZoCj6/cQDypNwl9TP9LapKFdlAzg6rPF8uT5Izw3VFM8F
	cqR+BocczyUGySPrqOGkmqGLkaKRVIOUEJJ3kYRarqbydh58fpEQxGD7FuWkJkSC
	twppcipovYE9MLA10XWIQxmjPWEwCTnzGXVkUJwVnpWqVAatDVTEbZp0hhiKUJfa
	PZhT6YSfukgFKIigBGeijvFBJ7v9lQnqGzT8caZpoJUA/LWYTQRCWMFY74QU3ZRn
	gRxjVpTDp18Z1F9d8srdw==
X-ME-Sender: <xms:S6HFaegF3amXv9HDzCWtcBf1_CYRS20K7z10OyxnWYovcEMACymLVQ>
    <xme:S6HFaZ3H2GOd-4bZeeXARJEJ_yKX6hCfAEbgsNQb_QjeJPXgFXFsinxQ4nN5S2sUh
    F5vIDq4nigKULftcTpFBwbUJJiFMLWBA7BJp-R-kigEz1558BTMfGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthejredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepvd
    dtjeeiheeijedtveeujeevvdekjeeuveekleeijeekfeejhfefveeiffffvdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepmhgrthhthhhirghsrdgsghhgsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheplhhorhgvnhiioheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqmhgvughirghtvghksehlihhsthhsrdhinh
    hfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggvrhgvnhdrfihusehmvgguihgrthgv
    khdrtghomhdprhgtphhtthhopehmihhnghihvghnrdhhshhivghhsehmvgguihgrthgvkh
    drtghomhdprhgtphhtthhopehrhiguvghrrdhlvggvsehmvgguihgrthgvkhdrtghomhdp
    rhgtphhtthhopehsvggrnhdrfigrnhhgsehmvgguihgrthgvkhdrtghomh
X-ME-Proxy: <xmx:S6HFaVe1_kLcMTytOKlxJA0jFPZlT8G3l4tsrGRIhcg_p0LHOMkeiw>
    <xmx:S6HFaYanEyxMNc3zHbgVw4vdqdhbGml2_Er7ObCXIn4VUKpfHnGGCg>
    <xmx:S6HFaR5A0y9OtrW23OjivQKi8NtHN144b4BWR5_a4uwhT0udt3cA1g>
    <xmx:S6HFaed_U-YNwQ-ySdC2tGYCaHfsGndQ4u00Dc-huwLYitvynYTE9g>
    <xmx:S6HFafrKYbRmiLU5xXFsjxxj5EGJJ5yNzANx73qVMMdRsiTYGE7Nmlq7>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8D0811EA006B; Thu, 26 Mar 2026 17:12:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 26 Mar 2026 15:12:33 -0600
Subject: [PATCH v4 9/9] wifi: mt76: mt7925: disable ASPM and runtime PM for
 MT7927
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-mt7927-wifi-support-v4-v4-9-8ab465addcfe@jetm.me>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
 Deren Wu <deren.wu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2658; i=floss@jetm.me;
 h=from:subject:message-id; bh=EttSMB/87XiHGZhWtMpgNAtlCMJydT4Yjw9bIPiDhNI=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxaE4XROHqnZuTIUqW2OvGZAnfVNg6oApkpJue
 J8Tatn7ChSJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacWhOAAKCRC17sMLqGd3
 H2JRC/wIb29AaG8RxZb+OShZ8cdeLylHN774vajS6QDNxzxJsJ1dK7saQwA2JNCjeaa3sCbB519
 gLAjXEk9BiJ+r+KDX89Awezkobz19vwr9BB+gVt0sTiefzWyGdpQau4OTQOtr5YBIQcs1a4QKq/
 vr/vdqJvm3GdwpM8DEJ/9SIPaAbQ3jLaq3XtWOGIb9lDZwlSqjVRYHRhlg9RdPi3kXbxu7WUqx8
 DnOYGtfJ15g7MDzUsGiZwGxPa+7M0T8EwClgslKsaxebOx2mZR4VKqxTnVfcDXfqbpGsbCmM4K3
 H8puUFKH3VqtqQonPfORsLaYdX2i/yHI4tiUEqkX/I2b1wll/0bIm9ioTEoxdrD4tXOJ4hJuWS0
 9SP3umUsT+d0P6J62C7acUnAhnUM51U3F++RkgahzaUKdu/Grt/jhd37pBAdFNgLiACOih7RXCn
 N8hbJOTygBMxhGQD85nw1R/LBJKF/q2k7yQDRHPPhsKUEicJ2W9mlqjrM1hV78To6AXBI=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me>
References: <20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me>
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34017-lists,linux-wireless=lfdr.de];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[jetm.me:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[floss@jetm.me,linux-wireless@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[jetm.me,quarantine];
	TAGGED_RCPT(0.00)[linux-wireless];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	NEURAL_SPAM(0.00)[0.518];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,jetm.me:dkim,jetm.me:email,jetm.me:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 9B33C33BBD3
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Disable PCIe ASPM unconditionally for MT7927. The CONNINFRA power
domain and WFDMA register access are unreliable with PCIe L1 active,
causing throughput to drop from 1+ Gbps to ~200 Mbps.

Disable runtime PM and deep sleep for MT7927. The combo chip shares
a CONNINFRA power domain between WiFi (PCIe) and BT (USB).
SET_OWN/CLR_OWN transitions on the LPCTL register crash the BT
firmware, requiring a full power cycle to recover. PM enablement will
be addressed in a follow-up once safe power state transitions are
determined.

Signed-off-by: Javier Tia <floss@jetm.me>
---
 drivers/net/wireless/mediatek/mt76/mt7925/init.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 3ce5d6fcc69d..4766b9343953 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -230,7 +230,8 @@ int mt7925_register_device(struct mt792x_dev *dev)
 	dev->pm.idle_timeout = MT792x_PM_TIMEOUT;
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
-	if (!mt76_is_usb(&dev->mt76)) {
+	/* MT7927: runtime PM crashes BT firmware on the shared CONNINFRA domain */
+	if (!mt76_is_usb(&dev->mt76) && !is_mt7927(&dev->mt76)) {
 		dev->pm.enable_user = true;
 		dev->pm.enable = true;
 		dev->pm.ds_enable_user = true;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 604c0e9ae7ba..1f05c212be02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -350,7 +350,10 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_pci_vec;
 
-	if (mt7925_disable_aspm)
+	is_mt7927_hw = (pdev->device == 0x6639 || pdev->device == 0x7927);
+
+	/* MT7927: ASPM L1 causes unreliable WFDMA register access */
+	if (mt7925_disable_aspm || is_mt7927_hw)
 		mt76_pci_disable_aspm(pdev);
 
 	ops = mt792x_get_mac80211_ops(&pdev->dev, &mt7925_ops,
@@ -371,7 +374,6 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	dev = container_of(mdev, struct mt792x_dev, mt76);
 	dev->fw_features = features;
 	dev->hif_ops = &mt7925_pcie_ops;
-	is_mt7927_hw = (pdev->device == 0x6639 || pdev->device == 0x7927);
 	dev->irq_map = is_mt7927_hw ? &mt7927_irq_map : &irq_map;
 	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
 	tasklet_init(&mdev->irq_tasklet, mt792x_irq_tasklet, (unsigned long)dev);

-- 
2.53.0


