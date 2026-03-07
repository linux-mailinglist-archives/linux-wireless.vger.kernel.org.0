Return-Path: <linux-wireless+bounces-32702-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGe1J+d2q2mRdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32702-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:52:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C64B022923C
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10FB319080E
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597B42D8DB1;
	Sat,  7 Mar 2026 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="hE5XLWzE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j/7Zatfu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FC32BD00C;
	Sat,  7 Mar 2026 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843655; cv=none; b=VXy2Pe+CU7Nr+2RZ+GkE7PSkE/xKGWeSv7pGlRjyuNZQ+JLF0LmaIbbFWVakXxwbRB5WrSrDew4VN9SMmJ1hPOIPIQAV/ac7BhlGwTNcx/f92tfJWyHaFbfnW7vRgg0X5M+uFmJCO0veBBQ7DKty4DUQlFX0rnkthSDjeWHDqE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843655; c=relaxed/simple;
	bh=hxcSincyd2o6Rc2OyiPCHchQlCqvcUsPEmPLVBDCKXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=dYe8D5QEULCff1Jzow49HJv29d7LvY7s+iT9pZfWcAINWf5fZtBBAqti9qPDskxHrGXMY+EFZQu+V+kHE9WqdT1fnryOBdTafR51G0MJsKr+YQFoHxK+E/SVPNMY+lDAxzg/C0I7Ju7jWmNNfzD7d6g/UEOlrRR+bmu0Q2qYQOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=hE5XLWzE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j/7Zatfu; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 550E31380AB8;
	Fri,  6 Mar 2026 19:34:13 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 19:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772843653;
	 x=1772850853; bh=jrwffRQEagabaef6ha34lgm0oUqiXx0dwX24YtMs0QQ=; b=
	hE5XLWzEJob8lOH24guqZhSyPHQXFukRTWr5Litr0CDS5rbqFco1UabpHo8Acjp5
	6YtitUb2RslU8SRxY9wvguVEsFRzqupJmquzFF/nLtGqRte5A7GhZjb7gnNuWizN
	18WRwgFKfdNtkPgEuz3CILaovgs43VQviXXT407lQTOo86zRqjZSNRpMPN4FNuvi
	UcxkTt0ZFRZzaONEbUCIltTc07P3ntK6JEAdXPh3VZgSZqCqTP0ZJGxzQGq3CdRe
	v1ZYdTUx60DzCu8f3RZ8jZShI5SvhmiPUbohz/Dex55xKcPwz25br21PvfrXKc0Y
	WERjtf0ZphIBrZ7anxWt7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772843653; x=
	1772850853; bh=jrwffRQEagabaef6ha34lgm0oUqiXx0dwX24YtMs0QQ=; b=j
	/7ZatfuOus2L4xDhhH0/VTRCWNfhVvZRKAZi2t29+nCa9bBAWwQFqerxNcv3T0Zi
	CeBgZi+K8ZFjOgbY1S8epwh7SEAeNHl1UogRFBUIyE6dHO1Z8O1y1cFTFr4GiEXn
	JdaKGu0TLM/jejJgyo++mi6xHpdMt4545Ao/eEUEZhjN300qksdARXO2bHABQ6mT
	exoxDHsTIMkovnUV55tYgGe1W0347+o2Jhv/5zOigpFoZBgMGcfcOB6tQ2MeXww+
	sf57o6w1XRCwhhBZ1ii24l6Dqo4PNNGW5Vne7ySeSajI+Om6ixlP4rPV5R3Iorbi
	6RUk+EOXuwTwYQu/HoIGQ==
X-ME-Sender: <xms:hXKraVcf1UlD6M1rnlRcc_KFSLtREdiqEE8awuJnYt5JF_v_drycgg>
    <xme:hXKraeBVqRu6T8a16Kp3FPMc63jluy9oSkAKfLPd2PXSqRbhL_4Vp7BJMmz7elAtt
    Z9dvYlUcW9VDd5ou277yOCYnaCZ0RmTGsZHSkxcuLkMrr8PqQ7mXgs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepudefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehflhhoshhsse
    hjvghtmhdrmhgvpdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnohestgholh
    hlrggsohhrrgdrtghomhdprhgtphhtthhopeefudelfeeifedusehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheplhhoohhnghdrtdigtddtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprghrihgvlhdrrhhoshgvnhhfvghlugdrjeehtdesghhmrghilhdrtghomhdprhgtphht
    thhopegthhgrphhuihhsuggrrhhiohegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hiohhsrghlledtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrthhthhhirghsrdgs
    ghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrughoihdrtghhrhhishesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsrghmuhdrthholhhjrghmohesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:hXKraVFi98mWrsSHy86WdIZxLr9VXAUkEECAwj5rYxMA6I3fbt3gCA>
    <xmx:hXKraVGzgXlG3bZ96See-RO3TYjNDBcxT9R0ktZ7XYuh37ROulICaQ>
    <xmx:hXKraWDvotwF_XO96h_q3p4vKtW20_IGufiOOsqrvDTKSyvkAOCZUQ>
    <xmx:hXKraR2FON1fQhj8-3cMAo14pPp5QIxCT0AnwFV94-dp729FN4BvQw>
    <xmx:hXKraToeNZ4vogZqG-Q9zBVXPGSJKalgkx8rNIETvJP1omBulAcDzC5q>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 266991EA006B; Fri,  6 Mar 2026 19:34:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Fri, 06 Mar 2026 18:33:34 -0600
Subject: [PATCH 15/18] wifi: mt76: mt7925: handle 320MHz bandwidth in RXV
 and TXS
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-mt7927-wifi-support-v1-15-c77e7445511d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3297; i=floss@jetm.me;
 h=from:subject:message-id; bh=hxcSincyd2o6Rc2OyiPCHchQlCqvcUsPEmPLVBDCKXE=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpq3JQ/Ph/XMOIcOJHhpdhqnQYFcO+ygQ2fifzz
 k7b0bVNX3mJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCaatyUAAKCRC17sMLqGd3
 H7gxC/44MsaOxJ/kqaZrTDzGw6xnYAnjWHd3TdlejOUE7JkXNufE/PbJsbO4xUyS+S39GUCscOL
 wHrmBBEPZDmbqZjuHseYSI1FsGZQ82LT1hyD58b6PO7yEeIiIE+dywkDdpp/H9vROQobIqBYIQl
 GifNXuyTQldbFnLTih9Vl2bqgSURZgcdBwnnjN3QyOyV71JLoGWwaa8juFV5fEejCk1JOLc0k6M
 UdX1fpAFo01WCZfEjyXXwF4E8B2+HBiWQvsQxRYXW8Upplkb6D7MZ8VinlXJfvjeYnv8v82qlf2
 0ITDEKCZzd06gxcqBV6mADN34o4//4lAH2NIf3Roa0hPfMHqNelvCCDv6BN9zwEvtEo+J2NdfBJ
 ODAlU33sZicIq5FAhYZwUEyIQ9b2RQTrGCtm5ic/jjVpJNk0iwf6aZHGXLXxOhFHS/v5EA9RmW3
 acfdbD5tTcexs6VU1rT68S8iv268vtprMrSEyjA8IYYe8AvuhCJjyH9q5ePQpbvk8qayE=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
X-Rspamd-Queue-Id: C64B022923C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32702-lists,linux-wireless=lfdr.de];
	R_DKIM_ALLOW(0.00)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
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
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	NEURAL_SPAM(0.00)[0.655];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,jetm.me:dkim,jetm.me:email,jetm.me:mid,anthropic.com:email,humeurlibre.fr:email,rate.bw:url,lgic.pl:email,messagingengine.com:dkim]
X-Rspamd-Action: add header
X-Spam: Yes

The RX vector (RXV) and TX status (TXS) parsing in mac.c lack handling
for 320MHz channel width. When the hardware reports 320MHz in the
bandwidth field, mt7925_mac_fill_rx_rate() returns -EINVAL and
mt7925_mac_add_txs_skb() records no bandwidth stats.

Add IEEE80211_STA_RX_BW_320 cases to both functions. The RXV parser
also handles BW_320+1 since the hardware can report 320MHz in two
adjacent encoding positions.

Also fix whitespace alignment in mt792x_regs.h defines.

Assisted-by: Claude Code <noreply@anthropic.com> (claude-opus-4-6)
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
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c  | 9 +++++++++
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h | 6 +++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index caaf71c31480..ad03fc554b69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -339,6 +339,11 @@ mt7925_mac_fill_rx_rate(struct mt792x_dev *dev,
 	case IEEE80211_STA_RX_BW_160:
 		status->bw = RATE_INFO_BW_160;
 		break;
+	/* RXV can report 320 in two positions */
+	case IEEE80211_STA_RX_BW_320:
+	case IEEE80211_STA_RX_BW_320 + 1:
+		status->bw = RATE_INFO_BW_320;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -992,6 +997,10 @@ mt7925_mac_add_txs_skb(struct mt792x_dev *dev, struct mt76_wcid *wcid,
 	stats->tx_mode[mode]++;
 
 	switch (FIELD_GET(MT_TXS0_BW, txs)) {
+	case IEEE80211_STA_RX_BW_320:
+		rate.bw = RATE_INFO_BW_320;
+		stats->tx_bw[4]++;
+		break;
 	case IEEE80211_STA_RX_BW_160:
 		rate.bw = RATE_INFO_BW_160;
 		stats->tx_bw[3]++;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index b364d0038653..a2ce6872559e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -301,9 +301,9 @@
 #define MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN BIT(15)
 #define MT_WFDMA0_GLO_CFG_CSR_LBK_RX_Q_SEL_EN	BIT(20)
 #define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
-#define MT_WFDMA0_GLO_CFG_ADDR_EXT_EN		BIT(26)
 #define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO	BIT(27)
 #define MT_WFDMA0_GLO_CFG_OMIT_TX_INFO	BIT(28)
+#define MT_WFDMA0_GLO_CFG_ADDR_EXT_EN		BIT(26)
 #define MT_WFDMA0_GLO_CFG_CLK_GAT_DIS	BIT(30)
 
 #define HOST_RX_DONE_INT_ENA0		BIT(0)
@@ -509,8 +509,8 @@
 #define MT_MCIF_REMAP_WF_1_BA		0xd1034
 
 /* CBInfra CBTOP remap values */
-#define MT_CBINFRA_REMAP_WF_VAL	0x74037001
-#define MT_CBINFRA_REMAP_BT_VAL	0x70007000
+#define MT_CBINFRA_REMAP_WF_VAL		0x74037001
+#define MT_CBINFRA_REMAP_BT_VAL		0x70007000
 
 #define MT_MCIF_REMAP_WF_1_BA_VAL	0x18051803
 

-- 
2.53.0


