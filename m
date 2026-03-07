Return-Path: <linux-wireless+bounces-32693-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLuHO4h1q2kvdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32693-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:47:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 900882291A2
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 706CF314925B
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AC4219A8A;
	Sat,  7 Mar 2026 00:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="VqUgf8l6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PxN8a+CZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C68296BDA;
	Sat,  7 Mar 2026 00:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843630; cv=none; b=ZkYWLHxJFdHDVaOkA7mftxK1IBm2K9SxVpvoXbNssU1crZCF1fGZrw70DqUemgiZ3ln3Nv4XnXQvZl6Twm7EmfpqMcIhSalZBJtgRHZcurH3p16ayB+eyGIYeYzT+ohLyRIDqYq9LKf6fhJw4YLDlGsmAK6Oq7lcBPuXzTXyCDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843630; c=relaxed/simple;
	bh=/GuNqbGp0WkGquAlj8TXYsYcaj5pBN2o2/Bv/wZ77ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=SLkP2Duh75XswXTVDxCpT5fewk2IiOrHyt4q1sOAkahfVfPTCFG3BJSOg6bb+/RS2LhZyyOvgq+SIKv0xmuhbBUlzz650+urlVu/BPvcEfb7PLRxxdV/wbX0uhB4X+ZD2aLciFXlLp3sUoKB/PGaqgKUxRIgaRLcziMeG/RqfgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=VqUgf8l6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PxN8a+CZ; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 61C441380A41;
	Fri,  6 Mar 2026 19:33:43 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 19:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772843623;
	 x=1772850823; bh=xEjAv72VHfGiLkHrAlhjKdzunRhjRylRiDm2CPYMkMg=; b=
	VqUgf8l6NKdxxYY9MfmUdJ6PUlCpH+rPu8/beBLr/Gwt0Z6l4wBEp4UbQ3O4i6SO
	vNH6avfimdjBtmj8MZgHWqxpdFL23V+OR9V01hU1zNbJBpeQ3jrmdtTp4hvr4VES
	MngUCxDjVyD1yBmb+Gx+rdGCo8N4QER/gYccrawCpE6cT14715/eoK6b3guQYGSG
	d3WRsqNEP8kk/C9xA9o7pnDZYMfCtK0RGELWmjW5hJEqPRlELosN3UFyQ0myqd5h
	vce5wo7VkfQyJOn2oR3qgJZ5NOp9KHS2T5YfwM8e1pXiV9scE4Jwykkiwetfef9L
	vEQYXZ2Xnno3YrACM/OFHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772843623; x=
	1772850823; bh=xEjAv72VHfGiLkHrAlhjKdzunRhjRylRiDm2CPYMkMg=; b=P
	xN8a+CZjQJDaBAsvMh45NZDG8oXXJ5t+eYp6462ZKcQvMQxVt7mJ1o9rB5LFFi1w
	WIeKPGvaxZIRIljNS/ke32tR99S1OwAPidWf0D8EIR5DlHIoAGnmRBNaZIZtg3RM
	Wp/EJGE1/sT6CWeHga6zVLq4PCz5cW9C4F6f6Z5CVFFCy8YjH2gCUlGIhXQO6l6W
	Ol+c22YAFmNOL/jsypy+ZtYboCi77o+s2E2He81DVb6uYC9jwNEMbJupXD84nRg3
	Wh3H93/p8KtKYRTM+qKH/OVeYxOhTs3SVjVPWGA8h9XEBn5fb3YXJWEpBKnxC0ay
	WEx7p1Ip5+nLfmex9Zu+g==
X-ME-Sender: <xms:Z3KrabsTnRIICcU1GqYBlqJihm13e7WNtopgNQCvBc7zkoumePh0hQ>
    <xme:Z3KraXQ8jkJ77Tc6yCbKgxAgJrFBhtd0q00GFOO9hVWh635laSsPMLMO9pgT7Ybol
    NY1btsr6EHteqOswwFcPMfcJQAYk0RD9J0KXwIRGwDp_XSDdFfb5nwS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Z3KraQvN4Eb179clXP7UqJzfDZjEI80NGiUZd5XnMy1ZitCbQTVCbg>
    <xmx:Z3KraSUjZLi8UnWiNQic9-cNlBVpC6QVESJy4AYZwvSMvRqupyPUGQ>
    <xmx:Z3KraZVFfk7z8Hgw02swPJLg9KG2A8XU-DctV6O4z7QRGSlxN657jw>
    <xmx:Z3KraVRORkYizhpv5k2rnc2IM5zWfqe61Y-sXzU851cFM70ucwej0A>
    <xmx:Z3KraWIkZQIpFyBA-CzujkSeY_2cvNS1z9ofpqskQ82imAl8MFeoGi68>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 356C81EA006C; Fri,  6 Mar 2026 19:33:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Fri, 06 Mar 2026 18:33:25 -0600
Subject: [PATCH 06/18] wifi: mt76: mt7925: add MT7927 power management,
 DBDC, and CNM fixes
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-mt7927-wifi-support-v1-6-c77e7445511d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3842; i=floss@jetm.me;
 h=from:subject:message-id; bh=/GuNqbGp0WkGquAlj8TXYsYcaj5pBN2o2/Bv/wZ77ng=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpq3JPuEuIqFx6W1+smCHLJTcMJHCbobukBVeO4
 0RHZ8TnRL6JAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCaatyTwAKCRC17sMLqGd3
 H9K+DACnuG0c74GfHj4EmBIxAGgIJnHfMdAEgsHrir/61rydL2mcGJfkFp13Cu+03E68r9u+qBM
 O/ocHHyE9zMcos/irDOrvSMTbFlt5vTYRsb53VAjLn4mivaJBCtvghRZiA9n242BH/blNqfi4CQ
 zIKn7vrE3ThAOff/fDR5J/TqepkU1+K142oALZfY/0+spChfkzIX2kf1dR8o+S79qApzPqJZGuV
 X/0eBlPQweihFSZ/YIO9MUBcdD5H7hf9EzX3Bky5dnNyxOKyKGib00OFsLQdeidOILzgre8CKCs
 2WIbx06z5K0oxzfah2A8VjSBz4+axjhskQgCzp2tsNlo07A74JVL3YcnS9z6lpmv/onn4J2eMzn
 +VOXDzKV62NnuVE1H490fB5jWxrsF2ty31alL7Qr3n8Kix1cGeeUTGrBai4NdUO2v450F7ikR+i
 J+4f/nzykxSescfXkMkN4RwkqBe9I0b6XCJeFtCUBgYEBeL/Yz0pQ0Qo8MjuQp6b5RdV4=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
X-Rspamd-Queue-Id: 900882291A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32693-lists,linux-wireless=lfdr.de];
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
	NEURAL_SPAM(0.00)[0.690];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[humeurlibre.fr:email,messagingengine.com:dkim,lgic.pl:email,jetm.me:dkim,jetm.me:email,jetm.me:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: add header
X-Spam: Yes

Three MT7927-specific fixes for WiFi functionality:

1. Disable runtime PM: Every CLR_OWN triggers the ROM to reinitialize
   WFDMA, destroying DMA ring configuration. Disable PM until the wake
   path properly handles MT7927.

2. Enable DBDC (dual-band): MT7927 firmware defaults to single-band
   (2.4GHz only). MT7925 firmware handles DBDC automatically, but
   MT7927 requires an explicit MCU_UNI_CMD(SET_DBDC_PARMS) with
   mbmc_en=1. Without this, 5GHz scan requests are silently discarded.

3. Force CNM capability: MT7927 firmware lacks the connac2 feature
   trailer, causing mt792x_get_mac80211_ops() to replace channel
   context operations with emulated stubs. This prevents ROC (remain
   on channel) before authentication, causing auth frames to be
   silently dropped. Force the CNM flag and restore mt7925_ops.

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
 drivers/net/wireless/mediatek/mt76/mt7925/init.c | 17 ++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 10 ++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 3ce5d6fcc69d..1e9eadca3988 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -115,6 +115,18 @@ static int __mt7925_init_hardware(struct mt792x_dev *dev)
 	if (ret)
 		goto out;
 
+	/* MT7927: Enable DBDC (dual-band) mode. Without this, firmware
+	 * defaults to 2.4GHz only and ignores 5GHz scan requests.
+	 * MT7925 firmware handles DBDC automatically. */
+	if (is_mt7927(&dev->mt76)) {
+		ret = mt7925_mcu_set_dbdc(&dev->mphy, true);
+		if (ret) {
+			dev_warn(dev->mt76.dev,
+				 "MT7927 DBDC enable failed: %d\n", ret);
+			ret = 0;
+		}
+	}
+
 out:
 	return ret;
 }
@@ -230,7 +242,10 @@ int mt7925_register_device(struct mt792x_dev *dev)
 	dev->pm.idle_timeout = MT792x_PM_TIMEOUT;
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
-	if (!mt76_is_usb(&dev->mt76)) {
+	/* MT7927: disable power management. Every CLR_OWN triggers the
+	 * ROM to reinitialize WFDMA, destroying DMA ring configuration.
+	 * Keep the device awake until the PM wake path handles MT7927. */
+	if (!mt76_is_usb(&dev->mt76) && !is_mt7927(&dev->mt76)) {
 		dev->pm.enable_user = true;
 		dev->pm.enable = true;
 		dev->pm.ds_enable_user = true;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index ca9ccfe9975c..dce9f30b68d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -527,6 +527,16 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 		goto err_free_pci_vec;
 	}
 
+	/* MT7927 firmware lacks the connac2 feature trailer, so
+	 * mt792x_get_mac80211_ops() can't detect CNM support and
+	 * replaces chanctx/ROC/mgd_prepare_tx ops with stubs.
+	 * Force CNM and restore the original mt7925 ops. */
+	if ((pdev->device == 0x6639 || pdev->device == 0x7927) &&
+	    !(features & MT792x_FW_CAP_CNM)) {
+		features |= MT792x_FW_CAP_CNM;
+		memcpy(ops, &mt7925_ops, sizeof(*ops));
+	}
+
 	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), ops, &drv_ops);
 	if (!mdev) {
 		ret = -ENOMEM;

-- 
2.53.0


