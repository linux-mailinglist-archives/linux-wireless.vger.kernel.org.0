Return-Path: <linux-wireless+bounces-33894-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAX5OKpdxGn1ygQAu9opvQ
	(envelope-from <linux-wireless+bounces-33894-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:11:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 896C832CCB0
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3BD6303E623
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DFF38D00A;
	Wed, 25 Mar 2026 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="itg6/yJN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YRLmisp5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4792A33A9CB;
	Wed, 25 Mar 2026 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476668; cv=none; b=TbDB1T2pXh1xWmiBltehONif/sf3s0PofW+1P8Lj6H9bTET0S7NoUZuP9+k52FNzOJhT36yEoRvSDWKSy0JtD6A+KybWXPXALX0E0dwk+Xu6/6qiplzgWGSRtcHIrpqR/o/dTMjv1s1xs4eEXdaCjnKlMYxmPPDhfUgK2V54dqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476668; c=relaxed/simple;
	bh=9D66lD+4PFuMZ5WOoV0TYVkhMmAV5u89PTonKlyCpD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=LZRqpJA897exsAmxvyJdtfAdpDfRH7PhrgI6LyoMAxV66rTEly/KWNaFuLtv6uU9cNsk/ORAxszBiG/CeeLIJB0qEbFJgViYRgrNj5zNOvclYpt96Rw0dCuTHgxe1pGypxeKP9HLZONKZnnGRnk3dfP8lGSc/n2xVODhQQq1dDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=itg6/yJN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YRLmisp5; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 565F9130051F;
	Wed, 25 Mar 2026 18:11:06 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 18:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774476666;
	 x=1774483866; bh=MAWmC3+lrAS/hQ/ZlJvHXy/pB/l0JqN+rUa+JFBfydA=; b=
	itg6/yJNz1ZbkzmldR2WMu2Z/zDa+2JLQqZJyd5B64r9wF04l/tz4e8IuZWhmvmi
	js9B94PjtAOiCYjQQ8P7so+BBfhZJJaiGTrRjQqYp38dIPfp/Afe/5wPEl8i+z9s
	wWTFi4vHso7fMCkCsNOSmrzP/QaGLP5SBqhjPIobUKXyVpAlP/76vEQV99waNZ8G
	4SvdNn2jY1ai+RmMV+MOp5y+GSXJS7hbTNGZQ3gOiCrf1I59qXyA5QAZ2vyuT+5d
	mV9dTUg6MLPj4aGyaqLjc2Haa86FVQ1u93WZYs8dvilzAQs6EC/Qz5Io53DHgdiL
	WLP6BmwiMIcKXKuBxOHjEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774476666; x=
	1774483866; bh=MAWmC3+lrAS/hQ/ZlJvHXy/pB/l0JqN+rUa+JFBfydA=; b=Y
	RLmisp5z2LCLTtJ0RsGYywIPRA47MiPnn45QUUrkt8NExE3Jg5eVAPcr836F7Qlu
	XoNPse5rNU4Tb/eXU8F3Ge7AvJge5T+k1YIf1mr/XSUWwA4Hc6+Hhnes9YbzFy9U
	CZPWJHMvVOwrY0usERLWXryffQ7XPIGUGlfEbkX72yBdyagbohj+IdxWxiR+UbDf
	cJU5pENkYJi7hn8sjBgtJ+Wo4sIUxDh5Lvd96fUZ0bJ4nFln/2hLiB/GLzhQ/Ti7
	pFN/zYbnxpzYhwvf5CnCPvY3Q1pLZdiaa1T6FxMA9753GbdRKSGg804KTvmAKmLX
	w9/vw1pkklR+RUO/yASMw==
X-ME-Sender: <xms:el3EaYqoVsynb-_fG8eCnM_zNteKTiGCEVcPWYfWhmPWpO9bquEPKQ>
    <xme:el3EaZeSGMMi-b17CQc8jJtkCVZ6PfyueIka61auZT748RS-7Ut_LgZcjcsQBPAOD
    vVaTrWc8J-GKxW37jfmpz5yJZYWGTuERg99Pw1Yr-f8L8v5Efor>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:el3EaeYRlK9EDz5bdoQmDhAlojO75FUQfSoFPG1XpVxkOtl2CpU5TQ>
    <xmx:el3EaemZYNTkYl4lK-XrmCoBDxnilg87_MTWo37phb-vedeAte4Mfg>
    <xmx:el3EaddW7B-R51bUvB8j9OVmPprDutS19JOkXiXVe2wS_31Wllo_ew>
    <xmx:el3Eac0qo4MIokyXynBXxsYXTJCKjoikIvbNsX3qRFpjRcaZ-ilfTw>
    <xmx:el3EaW5q9djI3sLDt-r2Qbe4DnO9fnEdVx9_4RkO1JyDM64OQYOrt_xO>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0D2251EA006B; Wed, 25 Mar 2026 18:11:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Wed, 25 Mar 2026 16:10:55 -0600
Subject: [PATCH v3 06/13] wifi: mt76: mt7925: add MT7927 chip ID helpers
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260325-mt7927-wifi-support-v2-v3-6-5ca66c97a755@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819; i=floss@jetm.me;
 h=from:subject:message-id; bh=9D66lD+4PFuMZ5WOoV0TYVkhMmAV5u89PTonKlyCpD8=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxF1qPTZoE7gPbE4ZAX/v/1dRBfrvUtgapVkGZ
 Q5tK5Fq5BSJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacRdagAKCRC17sMLqGd3
 H9enDACo8mWpO27XVQK8ZU6RQMej3yDulspjtZpKowctB69Y106jGDloEYhHHsWTPft28YVplwg
 sVvRSk/MpYWE418Niiu4sSVfK/VzC5ttJnocHUVY9zX5a4fO1kSs0ZaospIH2StuA6tGupCGqXE
 DOJwHxBbw6kUCPFW5FcuVtnXZmacByCaPQMhkGHTSp957vnc+4vXSgfhhmiETzpMQLkhQ325wnD
 kZqnCrkQxpOXbgeSH/J1l7DvgnXt7j4leQDGeXQCi9iPp58P0zp+3CoL5GH83wJUONZbQ0dmA/H
 C6DQyfd2/XG/mEjbgmA+H/u7M5zInV12PgCRZF3CMM1++MfiO7y57ddM3xxR21aGtg9guUicMOi
 Tu0cQ9cVMn0vUoLHhDCZrFp7pKRjVuaAXeTyW5gsMYm//wP4JTcA74udW7+/XHQmlOqce/uqTd+
 ZfpGQLR5L3QrhmuUQ7/1zLVwIb/mQwkpTOvK4y0iyOf1pnzAqJE+IO519JnjBSG5l4lRM=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me>
References: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me>
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-33894-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jetm.me:dkim,jetm.me:email,jetm.me:mid,lgic.pl:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,humeurlibre.fr:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 896C832CCB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MediaTek MT7927 (Filogic 380) combo chip uses MT7927 WiFi silicon
that is architecturally compatible with MT7925. Extend is_mt7925() to
match chip ID 0x7927, and add is_mt7927() for code paths that need
MT7927-specific handling.

Also add 0x7927 to is_mt76_fw_txp() to match MT7925's TXP format.

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
 drivers/net/wireless/mediatek/mt76/mt76_connac.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 3785fbf5ac99..c376efc605bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -174,7 +174,12 @@ extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
 
 static inline bool is_mt7925(struct mt76_dev *dev)
 {
-	return mt76_chip(dev) == 0x7925;
+	return mt76_chip(dev) == 0x7925 || mt76_chip(dev) == 0x7927;
+}
+
+static inline bool is_mt7927(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7927;
 }
 
 static inline bool is_320mhz_supported(struct mt76_dev *dev)
@@ -277,6 +282,7 @@ static inline bool is_mt76_fw_txp(struct mt76_dev *dev)
 	case 0x7920:
 	case 0x7922:
 	case 0x7925:
+	case 0x7927:
 	case 0x7663:
 	case 0x7622:
 		return false;

-- 
2.53.0


