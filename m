Return-Path: <linux-wireless+bounces-32703-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bBlQCZ11q2lfdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32703-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:47:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1513E2291B8
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D45B3051AB9
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBE42DB7AE;
	Sat,  7 Mar 2026 00:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="VSPLO6rY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5ZgzmB2o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A412DAFA1;
	Sat,  7 Mar 2026 00:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843658; cv=none; b=V9jVaBFxQ/rUTQB/Ta8jGuw2zya7i25kAPFqsVv+B92dv4fusj7WP30CokBzrnHRWGw/kmIdzErRYR5NbKPf4ua2gg0WqCp0blQh/vwAVzItDMsX4YwLitJnkT6hwJBTNJ6mZA8emR4XBLBXmKGxeQuno82DyUyOqo0Vq90wnWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843658; c=relaxed/simple;
	bh=I+my/0PvchaearqqG/a7SXVT9SRugYd7pzKrmWjv3Dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=GdofbMqkZ4EtnHyiMcOGcRSe09m1+Artg5+R+mbVYFek+7PdmgqEFnM6iOsLHNuhyBA0oAceSE+F+/cs2oi4F/Z/c+9edVYr7pyiJnNmVqD3KPqZctXDxCibpNYWwR7FoPainYBP4p4xNoCtIaaQkCzJ1C+FuVJx7bcBGNhbNBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=VSPLO6rY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5ZgzmB2o; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 2B7941380783;
	Fri,  6 Mar 2026 19:34:17 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 19:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772843657;
	 x=1772850857; bh=m1zT+FghB6YhIIp2sgwQx7UzD3lNCmEI6z5nrADAygg=; b=
	VSPLO6rYYIYhHwB11m5lvqLhQfV0BQG4s9WbEfHXSfniFCMg/ev8w/CWEM1yxxMX
	XRP/7Cbu2RDcGHDu94kB2hXDVpcBXt+u/QkxZeaJLDeRW3eUlT1wYlMXCKHW2xw5
	3Os5TIXYn8SQLt0V2zrRl6cPy5x4Ee2nZjqPnXhmcUatG2xbpv6W9/55x35yP7rp
	KQM8KglwWXLDm+6IF43Hn80C38yMLLLynL534PqqJO5Rkx7GD09hu/xF8iEdcqUj
	FofV65LIPi+InPyKB+88bQgp+p/epgNp4leY7rD3+v0eMwSWOs6O7O9lFSygsKpz
	LmNm1u/9jbxDaJSKrf5YMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772843657; x=
	1772850857; bh=m1zT+FghB6YhIIp2sgwQx7UzD3lNCmEI6z5nrADAygg=; b=5
	ZgzmB2ow6YdLNwBpPpEuNjuAnvQqXLYq+2lhyeyjQkJuJEA40peb2X6aYRaX5OFm
	hDO1Lk92UlBdumflVov4CXwib47XcwmEjdWRVDWNv/r4OZUGv1ZPy0tJ09bWHSVc
	h3bzNZoNOgMGAnVkq3zy2fEx4QohnpSiHnJtwLjQhxY9SsOYcQ3kH9FgsJ4s4ukD
	gEDyHswylq5PA1TIqlUk2sbZfL9y/v/qc38m4yxqwQgiO4RBv7xfhC10AgwgAKWx
	wfFrF4m6SIgZTX95q7wIjpLOwKzs6pSQAvEi3Jp8SKkcCnt/CmDQo5lmSS/RYCnc
	dtMxedlcaJYNGvK4562Mg==
X-ME-Sender: <xms:iXKraSqAvzWVpEGYy1yTe6f_V0pFu5JqmCAqJI7PjuJKRvNoOEAjEg>
    <xme:iXKrabch9l1qJtHWJTQHvHZxYLrGK7jCn_94apN-vXgLSkC_z-A-wKhOgAcdxJznQ
    4Mg8o8DFMSF-2Hp9qbyhAHcvY_HN9DgpEwdfFjtXy1q8aidleviSro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepudegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehflhhoshhsse
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
X-ME-Proxy: <xmx:iXKraSp1KeibkMB82S65CrHf8a7GQbdY6qHbf7v_U9rqQ_cauzeBuQ>
    <xmx:iXKraViS84k1H5cSTLKDHp3nddr-xyh24FN5IvijQMRODOymnQsbQg>
    <xmx:iXKraUxwfCP8bchItlfVDuB_8uVyxVX81kjHF6jdY4TWadTKQgqd5Q>
    <xmx:iXKraT_okmNH9v74Qb6cNxsCGODAHOMUEB1J4g6iHQYWeaYI18DL5w>
    <xmx:iXKraW09vseMNh4kKCXeoLtRvvADeyxElHAtYiEwmekXdCck4MiaWjd4>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F25D01EA006B; Fri,  6 Mar 2026 19:34:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Fri, 06 Mar 2026 18:33:35 -0600
Subject: [PATCH 16/18] wifi: mt76: mt7925: fix stale pointer comparisons in
 change_vif_links
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-mt7927-wifi-support-v1-16-c77e7445511d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; i=floss@jetm.me;
 h=from:subject:message-id; bh=I+my/0PvchaearqqG/a7SXVT9SRugYd7pzKrmWjv3Dc=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpq3JQa9CQDT7yyw0v7f1AJ1E1OA5S8IgRzwmih
 pYM34spFrKJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCaatyUAAKCRC17sMLqGd3
 HxZVDACn3a8K6Dz+qaREBw5xmpcItg/OXRAr+MFLMeCJUzELSe13b5rXqWTa6qaVJmybeiPNcK0
 X+aLJs2O9CcUc0mA9FmEo7vU3xf4t19OrtzVEP5Ew1Gl6o5zUtlX7loN+cv0s07d6mIbs2RjZbi
 oh9a/sH9seN0pxGbgtj66EKj6ZFKDLaYGs3kUoTibxZUAcwJNoDAahRalcVteiOs+JnVWjuBM9k
 h2UxYjnmqMEBieFmPOCvAz7Ro7rTTBraU2y8ohPKQUmeGD6Z/CB8LPpaux43eY5qtA2RF5YMDRF
 glPTf5aUEKqWzbQQxQs4k6J1cAMMv8WvG3637mrpwoCqc/6ViGQLcijrrT6aHMRK06HhU8FRoRW
 0crNbn5paf9qjSjhLZmfH8T7j1xZIoWciq/1rzK5gIo3iDYLrl6EVtH+ZBC10OQqwKk9A4GsfEn
 /muF5w6HW1l+jicBzIFSlmmW2aTvXwVYb5htNOxrqORb1fSINPJ+b3VlLUDz++VXb9lhE=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
X-Rspamd-Queue-Id: 1513E2291B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32703-lists,linux-wireless=lfdr.de];
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
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	NEURAL_SPAM(0.00)[0.728];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[humeurlibre.fr:email,messagingengine.com:dkim,lgic.pl:email,anthropic.com:email,jetm.me:dkim,jetm.me:email,jetm.me:mid]
X-Rspamd-Action: add header
X-Spam: Yes

In the error path of mt7925_change_vif_links(), the free: label iterates
over link_ids to clean up, but compares against `mconf` and `mlink`
which hold stale values from the last loop iteration rather than the
current link_id being freed.

Use array-indexed access (mconfs[link_id] / mlinks[link_id]) to compare
against the correct per-link pointers.

Fixes: 69acd6d910b0 ("wifi: mt76: mt7925: add MLO support")
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
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 4e1265886f20..f82c56c46324 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2073,9 +2073,9 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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


