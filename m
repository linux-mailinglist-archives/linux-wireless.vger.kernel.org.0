Return-Path: <linux-wireless+bounces-33519-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFxmDM53vGmFzAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33519-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:25:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD752D2F23
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22A2330172FB
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 22:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78E6402B84;
	Thu, 19 Mar 2026 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="lDjETvmg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uEzHl3zI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B0E3BD258;
	Thu, 19 Mar 2026 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959073; cv=none; b=eBKWgXA51ris8guWl9OEqDf2Zqn0YcB+2HAGmpNx4I9gHrl+a5NpNye8JeOsLuxBDNTRxoOLFk5lcspKZOmVLeuz+Vg5tsEDatWz0TanvJ5qGCw9rpNdkrk2jYSWGHqBoARIhTNs1btPUQle2VihUddTJpVOxfl1sifGppJO6RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959073; c=relaxed/simple;
	bh=BZB4eayi5CQeKoa7X5LI8ihvLOiSO2F3JQGoBG3iu4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=TdU1/PwPrBCU5En+GgUmk4JyLk7d8G03lUA3c79hiQSxSwMvMXkCr4DE1JU7ccoc1U0gWMwJz3FT0yVIlRvC2tn38KbG3BtpmWWpsPadHkrWvUvxjUrYTe2prF1HtQmlaczb9OAsTz/uEeaQhhVDlaGRdvf+U+x/MfMgCxAZG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=lDjETvmg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uEzHl3zI; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id ABA3913000A0;
	Thu, 19 Mar 2026 18:24:27 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 18:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773959067;
	 x=1773966267; bh=e5QLbR8nQwufqPNpMgHuGuZt5CzJuoJvqK1picXhn/k=; b=
	lDjETvmgR+vTWuZSCVwy8YODs/KyHMd7kxvGJf4QokyGGtde+JaLW7/Ko/Tu/Ci5
	7j2xV2P9QGVGJ6D+eNDuJCMbSdUBsHT+pQt8DqxjTJyHwBx/SfLuiMBb9XcXXA4+
	PdkWOQu9EifrXB+RUqQ+jF128C9iCIEJkXuXTwdDPl/pORW82EnoRsODIMW1pO4Y
	6CirWftK/Z14yyiiP/NuKEvWnsxaCPR+pL8WfroZiPC1epkAp17h2e6FGCk6II/S
	NVaZOhDtvOXDDV8mjIVaHAWGj6sKSAbZNs3h6hWz35ITtTf8ZKf+TaUrS4BCQmnN
	7plNy7cs4sLeH9Okeerepw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773959067; x=
	1773966267; bh=e5QLbR8nQwufqPNpMgHuGuZt5CzJuoJvqK1picXhn/k=; b=u
	EzHl3zIjVZwtNsQraNRc3Nk7ne1teFsNY3TA2NIoGR258ktly7rRFIDl7EPmQxBu
	M57DpMp39hO8jUhPkg/vvTlLAYhYfSVZvCzxRcY/BKXwWkD1p2gTIvXnBYMSWuEx
	gXHgce/wIpH0uLHtXJl+baoE2vBPjEN1tUVkP7WqI+ulcckP1Xv8E9+A1ahF9Iqi
	zUsqxtQuP1aib1j5QuvIRm+phmJK/ZzE7TLGh8a9QzUMG+jRFbZu3DiV7MC00H/+
	RSdhhRsdMH/XtJ4JbbnGefrsA7zM3j59gMAqtto+uLeTCpYSC3t7y0bi4CGgHOf+
	gY6i7D1A38vv9PLHCXG4w==
X-ME-Sender: <xms:m3e8ab8XoSwitPi6qUUyzz4K0tiY7HjNuKfI7MPnabnCi25AG-yxjA>
    <xme:m3e8aSiKjx2LFubVRE-PM3eVX8bLgSnIcq5buxLqnehjz2VWiAC7Sv1pYvea2n3E4
    lFYL6s5bAsuxh171L36xaGaWU18YKcxFxBeuHnMMMZ03Ey1Vc35HIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:m3e8aRP-pwOUr_2ugZnyT2XzTxq6MO_ZGBUdUBDeTxuXSKpb8yg9zA>
    <xmx:m3e8aRKXiEaWFHpFU_3re-RnS3-_q4M-0OUYKF84W-L6JX4jT6Y8fg>
    <xmx:m3e8aUz3MZiP8o5nD53X2npti5qYQPZXJIIpJ0ikfIl9WiUyflFHQA>
    <xmx:m3e8aZ6aTam6lN-MuNg11GWZBcXHCbUSxsf1bbauZf78aIGmt00xNA>
    <xmx:m3e8abPdWdEgViE_s1zipd5cjZu5TkdTuOSkJXz495bbR1IvuwYdS4de>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5B41F1EA006B; Thu, 19 Mar 2026 18:24:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 19 Mar 2026 16:24:19 -0600
Subject: [PATCH v2 03/13] wifi: mt76: mt7925: handle 320MHz bandwidth in
 RXV and TXS
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260319-mt7927-wifi-support-v2-v2-3-d627a7fad70d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005; i=floss@jetm.me;
 h=from:subject:message-id; bh=BZB4eayi5CQeKoa7X5LI8ihvLOiSO2F3JQGoBG3iu4g=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpvHeQWnFuapW0bydN/UBfu/FXVsG+kZyIG0VcK
 5p4Wpq2uHmJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCabx3kAAKCRC17sMLqGd3
 H/29C/49kH7Nj3n3Sv2PdlYuGKDDxtiZnPFShBCT9R+V39ez1E1rriegYkPJrjHFsl5uaE4Pt31
 u6Ek+dfe964al2meFioGSb0Dy2KPQNkzqcBxxAIs4uPLTTV0w6Zqvn98UOgoejxG0RW6ptGhKFj
 Z3RXnje7YVdqfzC64pCucTRCeExSHmgmNJSw3eYY6X3c+AB1D+vm1sRYCc6FQ6LzVWMfl+u2vq1
 hcpTEfl3bqRk5KV98urL5TSUHbxoBKj1mNtBQ83sVjwTqQqBL+w8KwHSjveO3uha23T9ykN2V8c
 aE4zU1NosBFD0vrUlp0OTSOD9+glulxoBAou3v4KCd3pPXH4PRprGP1PFl8vb5IHgPAHhcqv0tM
 mY0kxILKxbKpC38w76vHtPbdUF0iYcVqhNnoXQik27kO0rArhxSztxhqcn57GnJUlj7x/va5YTK
 JeV7C8d2j8O9KJt7D1TE8WvsKOgbdelsSuAUhRTB+5yikJq5ZneYa5Cmxgu0V061x/8uI=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
References: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-33519-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.157];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,lgic.pl:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,humeurlibre.fr:email,jetm.me:dkim,jetm.me:email,jetm.me:mid]
X-Rspamd-Queue-Id: CAD752D2F23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


