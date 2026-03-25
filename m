Return-Path: <linux-wireless+bounces-33891-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP0GKc9fxGkuywQAu9opvQ
	(envelope-from <linux-wireless+bounces-33891-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:21:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1424332CD90
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE4A430AD9D0
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C8A38A703;
	Wed, 25 Mar 2026 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="OQsGv0aL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k7oo8hWg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C4D39A06E;
	Wed, 25 Mar 2026 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476661; cv=none; b=YcIqmYHLRvztf3GnvGAyFpwvrBVDDRe+Rbfs0KlThp6NivEIeQb0G0rJ4EJgsodqqz9ucphWMKGW3yVy9Ht8nj2kV2noNCLR3b1+/x2Jbe/mfCEugZv2KwXuUjGd32QBY/lvj3XewpSQfKd+F4YMQ/J0FdQXlSHjVt8Kt3AaAoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476661; c=relaxed/simple;
	bh=BZB4eayi5CQeKoa7X5LI8ihvLOiSO2F3JQGoBG3iu4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=ADch3EIi2G4LL7GBmg0LVH1JrANMdhfNQkPM9wHymDFXg3l94ibvSmd4ERuu0EcR/QyxMzg/Di08pikyCTe0M1gn1weP1rpztoMozxZlVz5BiN3RqHTOvhlLgiWAOoIdo6fxrrThe3FzrRzpNizXWNzoXXPstAiYR0+/JuwctfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=OQsGv0aL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k7oo8hWg; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 9D62A1300515;
	Wed, 25 Mar 2026 18:10:58 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 18:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774476658;
	 x=1774483858; bh=e5QLbR8nQwufqPNpMgHuGuZt5CzJuoJvqK1picXhn/k=; b=
	OQsGv0aLIs+JY7ipXM0S7ALef1RpUvGYzUpV5gJvtZu0LS482WTtPwMIkri0fcY/
	1H+EfCRvXEIfb07qKlXOsTB+oQSovETzPOfcQfuIBszRJ7ThJHW2gk8Yso5am6Dr
	7Z/8uWzQ0SD+5p3MUJV5boCe4thDl4zbEmh2wWzx19EP5xGx0BlK9QYO1HmIygOx
	INM9uFV395rTygUvdHw2zVLN9umTnGkq2N7DYCV8LnodqKx0vxWY3AaBhcT1t8Q7
	tunFGlZWNok466qMiTrij20G10bWoX8vfxcB/S5KqCei03OoBNiCJz6KMIvMr8TG
	/tE8hIOimbfaMl4Bt4NAjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774476658; x=
	1774483858; bh=e5QLbR8nQwufqPNpMgHuGuZt5CzJuoJvqK1picXhn/k=; b=k
	7oo8hWg29ExIIr477Ucy4gov44CjbnB2/2RbqTCjmomAyzZBaIP4F+KvLDBNdlg1
	Eglm4Bw+1/OZTX2QNSi6ULIMcKk5W8TVI7p9KIFoY0TOIzRgdDSqm5PDr/vqXLhw
	7MOEjQkQfDJHgUD7C5ohp4u4u13wKoC1f3JCkSeEH8Lm21x1HJx4zUz/1H36M8GE
	mTAmWQOM87dlG4Ur1NLwpR4ycu/O3zYWfL2RMa5mFfk9JUxk0WoLuN3J/FJjRxNx
	Unx6GPj0m/HUPu7AHnwte60WUCcCmNIrqF3Ydw7ZlckQGOuKVtzaFwYMIn7sJZ9h
	dw7MzpRh9/gUaU6QSA7uw==
X-ME-Sender: <xms:cl3EadF7_AUSWDng8Qc54wUlkbwJCN7gzHG0y-KJJqlxWsN65fGwIg>
    <xme:cl3EadJR-aHYk5vmMigJFhRq-6N__frQOMEjjMJBa9jRTjaZxHpwBjtrtCMbi_a54
    4k4RlK_5Ce0Y_wcb8rzeKT9SsAqyX4_0xDFTSoPbG1Su-im-XGl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehiedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:cl3EadVja6eEtisrXwr7ruzQJwIKYpJWDN9y1DQ-YGL6jCoG9AxSow>
    <xmx:cl3Eaaw2_5g4xmqS6ea7Yza_muiKyD5nMUdkGnCtZN8hZVV2Hewc8Q>
    <xmx:cl3Ead5HEPbDwGEC3-fFA8GPRD86vVJE1DsRv1PbfzjG98cv7ZVPFw>
    <xmx:cl3EacgU8T-3VlFkrM5q13yAZNoCHn19x0kqw8RB68pxTFMx_YunUA>
    <xmx:cl3EaWUq7yW8zW9hiZOPzyo3Timc5559XYWioxv2BACs8m2whwBK5Xrs>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4F9BD1EA006B; Wed, 25 Mar 2026 18:10:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Wed, 25 Mar 2026 16:10:52 -0600
Subject: [PATCH v3 03/13] wifi: mt76: mt7925: handle 320MHz bandwidth in
 RXV and TXS
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260325-mt7927-wifi-support-v2-v3-3-5ca66c97a755@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005; i=floss@jetm.me;
 h=from:subject:message-id; bh=BZB4eayi5CQeKoa7X5LI8ihvLOiSO2F3JQGoBG3iu4g=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxF1pAqM0OjgRKzZzz+COTIrszcH61TvR7Y4ZW
 XxTxDBRh8aJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacRdaQAKCRC17sMLqGd3
 H4G4DACeGc4oF99VE9s4IYS1SQfwXsrwfwBwdh2hDlI/myXA0dY78kxUJ69KyH2VWzP7erQZf55
 sqxPgO0xxxXhSdVQ7hKIYiqKdRPaN1yhCyQPSmD0N4Tiwc6/abo4X1eF/xWLtKqL3+yM+MqZFrr
 JpA5I1CeZZZ/jYKLabF9lLx3QfhT+TUa5HHMPW+UBxddI8/BmwShC6iAvXV0g1JLXP0gAWm+Qjh
 yHU2XzUAvMHtDdSvY7Lnn5eApiR0YYK9LJoyZCPOOoSxWKbgI1ahEl0DKciIyHseC62T7MB2JMu
 Gujss3PCCvihB3ogPskLF00fSg1C9wMwLdmKR07CWFNn8gimwTVMhGxlvFIk3Ht8B41LHrnAdGZ
 bdMADJWUnbbsHrkvakvFCyK5EIfHIvD46dvWgRyNoyyuUNyxFsPk1THhbPoS3dHbiVhj+VxmUhm
 KGo4LHca/OiJ0UMLyYClUyHSSYp7ewIMdR+d76KwlFlA15e7LfcM1O3HW+ELHiq6Bshko=
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
	TAGGED_FROM(0.00)[bounces-33891-lists,linux-wireless=lfdr.de];
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
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	NEURAL_SPAM(0.00)[0.415];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,jetm.me:dkim,jetm.me:email,jetm.me:mid,humeurlibre.fr:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lgic.pl:email]
X-Rspamd-Queue-Id: 1424332CD90
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

The RX vector (RXV) and TX status (TXS) parsing in mac.c lack handling
for 320MHz channel width. When the hardware reports 320MHz in the
bandwidth field, mt7925_mac_fill_rx_rate() returns -EINVAL and
mt7925_mac_add_txs_skb() records no bandwidth stats.

Add IEEE80211_STA_RX_BW_320 cases to both functions. The RXV parser
also handles BW_320+1 since the hardware can report 320MHz in two
adjacent encoding positions.

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
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 9 +++++++++
 1 file changed, 9 insertions(+)

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

-- 
2.53.0


