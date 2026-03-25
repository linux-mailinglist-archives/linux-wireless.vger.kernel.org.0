Return-Path: <linux-wireless+bounces-33888-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDPDC3ddxGn1ygQAu9opvQ
	(envelope-from <linux-wireless+bounces-33888-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:11:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8751D32CC91
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 419AD30238F1
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D35E3537C9;
	Wed, 25 Mar 2026 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="kwYOWB1m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g20KQ18Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A03B33A9CB;
	Wed, 25 Mar 2026 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476657; cv=none; b=WP6CDqSHcQErLhXO5ZwfHPnLjdnYpFpO4ofYuPA0OdQEXSmuwOPHjamnBXeSH4Hp7JmnYdhvrKO9fT6A0Z6DDwl7nBabQmYkZQmyk/ogxlHvcl5/WPkcnjOJ3tAeSFpTt2CGeyi4h5e9/6O5kpQughZe7vdjwRzqvIsf4u2Sz7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476657; c=relaxed/simple;
	bh=DizT/ddlZFD7KX9YeoKrBVdFFWkgs3dXjw0pBgdRG1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=gy1VKHqLsVShRu900aI7fD4qs50HlimSC6rxuFVUDcYNuTHTS/2lOnwy+1UrHLzgIgHwRiwdSHN1DTsEb6M3DpSOGby/NBzmWO8DgGnMV7ygyyQvnoJxCGmJeO5q/HC3fgcBBcQIH42ELh7DrlXryf+AWKE5caQYhYY+TwDRn6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=kwYOWB1m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g20KQ18Y; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 6983A130050A;
	Wed, 25 Mar 2026 18:10:54 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 18:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774476654;
	 x=1774483854; bh=cvt3lJ9bUn/nS9x0h5+rL6WI6mE1I309IFcyKJoRia4=; b=
	kwYOWB1ms5OH7QzL1JH6bQVFjQALUmA8xgZWm8i8yQ7tSNwh8uVE+s2ayiny8UBj
	zItlJT0hOy6ypw8mF/K9T32dEze4VYt7E3VY5xFGsJPLcF6+ObTReRFiNm961THD
	ZzG3FR8YcF2yKUIYFyClLcV8qtCc3zKOtyNpNcwaodz+hR/rdpNYbci7mrFvLrWY
	zySvIkY02hh/T1mUU/tXpvrU/SHs4dtqxAYdwYGKgGiY9tNXWWjZGGUt99GrCq5D
	Nh8XMixaD9D+ly6J04SJ3Ikjuw31PAkLgRs/eQ1xJbq7bbldXjbZ7TJM9uO1CyE8
	eXECwEz5L1Qpj/GDjMmhxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774476654; x=
	1774483854; bh=cvt3lJ9bUn/nS9x0h5+rL6WI6mE1I309IFcyKJoRia4=; b=g
	20KQ18YO2ga0+bfQ4hTAhWDBkJ3fA9YafihX9S4oEf39wiv6ddCI7GrHq0t0fnW1
	3+XKm/6j3LnXzlBAcFFALynfpNKilGG8TVwWLbG+ENc/GXQ/iHJUuBQGXuhO9zvr
	AjzX8ql3g8NIZl36CARLET21eqWqslNXd3bjDrdIvLxPEDkg1rZ3WwJaMzQ0jPGt
	20C4avUB0sQca+MR1JWGOPyMZ/jty9Oh5VmExMOj0XC6meAu0Qbx8Og8V6mSkAqM
	dqBgvkngHBGo3xqWRFR/5EtizH3w4GfPfYw9gxihf6iFj3XGNHpkX20kuhXbd0fE
	jZVpGEok39GQau5jQf9nA==
X-ME-Sender: <xms:bl3EaYuKu4kvyWH_ho9CzCtsrLM7G6wHJgsbcN0hcaIA4dTsRdk6nw>
    <xme:bl3EaQSzBUE2Av0l9MMHtqL9cezl5zBXsYIUo_X3Qv1_mFIJjQ9_025A3XDtwwP3K
    cXFT7YU57BywCBA99VU6iXYljBDZRBtx3o6TcUC3hkCZMKneeTN>
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
X-ME-Proxy: <xmx:bl3Eaf_zMmGyuTIvyQdG2vRw1kDJCyb06fjOHJvIMk9rdqTZy5ZsoQ>
    <xmx:bl3EaY5UNVHf20RBPtvT_3k-73LkA8UVpCpyvtWKN0ylI3Jq_OHmew>
    <xmx:bl3EaRgNTIwEZzSLEM1rGOjexD9ft_Bg29agHROj0t91bMV9iAbIOQ>
    <xmx:bl3EaXoqDggjdymLuHPYOWVoCZ-voVOqMwYTHxs13sB4cgSF8rcvQQ>
    <xmx:bl3EaYHnLppdurzCK4Bl8Xtz2WaFqPbTzo5mJvYGCRoGxuG-T8fCaGNH>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1CA7D1EA006C; Wed, 25 Mar 2026 18:10:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Wed, 25 Mar 2026 16:10:50 -0600
Subject: [PATCH v3 01/13] wifi: mt76: mt7925: fix stale pointer comparisons
 in change_vif_links
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260325-mt7927-wifi-support-v2-v3-1-5ca66c97a755@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1810; i=floss@jetm.me;
 h=from:subject:message-id; bh=DizT/ddlZFD7KX9YeoKrBVdFFWkgs3dXjw0pBgdRG1k=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxF1psC0hLCRzjME8P4BchWxGbQKnGDkG2s0SU
 Pb2kwM/SG2JAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacRdaQAKCRC17sMLqGd3
 H3ihDAClMgWNmFGBvIc41K+2GkosPVqd7mIMJ7jeNi/bvKlG73i4DUvihCHEp1xVm+UWUBj63yo
 lRSxzjJaayRjv+kHy5euXu4n/BN0JZgo8y/cIUUGJPp6idk7Kgc8OFAYbHhuxS/wT2g8kTkHElF
 7KLqZGZAtB9LavkgPrtSgklWfG/d1AHTAm/TkQBdFmmQ+83v1phQVGlSsPD/3HUlYPRt3ak1qOK
 xlyfAsvzRpvhLj+9xePow2WEjnkEG1zOwM1oJNCH1AgUgLN00ri5gfhEvqxOxKY6BekZzaLwZhi
 J7bhKfy2Jix4u5q7T8A6SAmxxEaow/RRKldkYTexSZ3hxSAUqapOmsgJQT4CIpQxFcaVEcCh/0/
 aD1NMQj43Vv7XYHAQ4QTNb6nQLBzj/vXnAVDtNaXYFiCTkdiqwVYCkmb/GX4upSVrqZRS1vXs+B
 JBP/fF3W6v7wZLOCBjhyqs/ufJpgArICFhmXKCR2VmvAN/ur/kqH5TDjU3SO0HbmeWiro=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me>
References: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me>
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-33888-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jetm.me:dkim,jetm.me:email,jetm.me:mid,humeurlibre.fr:email,lgic.pl:email]
X-Rspamd-Queue-Id: 8751D32CC91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the error path of mt7925_change_vif_links(), the free: label iterates
over link_ids to clean up, but compares against `mconf` and `mlink`
which hold stale values from the last loop iteration rather than the
current link_id being freed.

Use array-indexed access (mconfs[link_id] / mlinks[link_id]) to compare
against the correct per-link pointers.

Fixes: 69acd6d910b0 ("wifi: mt76: mt7925: add mt7925_change_vif_links")
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
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 2d358a96640c..f128a198f81d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2047,9 +2047,9 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		rcu_assign_pointer(mvif->link_conf[link_id], NULL);
 		rcu_assign_pointer(mvif->sta.link[link_id], NULL);
 
-		if (mconf != &mvif->bss_conf)
+		if (mconfs[link_id] != &mvif->bss_conf)
 			devm_kfree(dev->mt76.dev, mconfs[link_id]);
-		if (mlink != &mvif->sta.deflink)
+		if (mlinks[link_id] != &mvif->sta.deflink)
 			devm_kfree(dev->mt76.dev, mlinks[link_id]);
 	}
 

-- 
2.53.0


