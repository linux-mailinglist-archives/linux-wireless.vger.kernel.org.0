Return-Path: <linux-wireless+bounces-34012-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH56InahxWlUAQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34012-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:13:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 364F333BB5C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7679D304511D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 21:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840F83A7858;
	Thu, 26 Mar 2026 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="mrsZhwOz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1XzLCZa+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E503A874C;
	Thu, 26 Mar 2026 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559557; cv=none; b=FUQrVHGD52atOnjIcQcrzIGhAZ2eyDt3QikaWEop15vk3JEQn1WYBsQ/lmrWKVTWFhIa0DPnIs2UIUVa7F0Q1uhthE0b3cCAtARWIhjUk+t4zgOtAosSswg+IbtO8NTacno+pQ539PLn2I2VrBCNElXteqzFKi27EPytYgm9Omw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559557; c=relaxed/simple;
	bh=b6wuUqMM9LRMdvCkKcW9uEToGwJgCsTkr6DKPTvA7cE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=uPUNYTGo3jPHn/MA3ZYrlceWhVa7n3cC2Uk40nqyf7qp3RLijLMmMz75LfCmuKDDyq1IoDSiyooW5VT5htlOQmUTgNE1W02t6MJaYozIJdGW2iTgVKkKNVbnCNL91YpVeR6J8V7o1oz4h47uJ+CK6yb29Mrzn9ZqQPxrG39QOdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=mrsZhwOz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1XzLCZa+; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 6EA371380151;
	Thu, 26 Mar 2026 17:12:35 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 17:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774559555;
	 x=1774566755; bh=3c3om6+sjsXCFA8fMVuyG6m2PTBcXdiHeFZPaFuV0Us=; b=
	mrsZhwOzgcPr9dphzmhExpP+pIM7+mJwll960UL/GxF7bdVAZ5QgE+fYHMy7+c/o
	6PpDBN19PAW7Rk+IKqqvjVAMGkiIPuAQSgJy/dDd0mQF/Z29u6XyGq3417Li1Ovf
	i6U7K1V6nNZSnOSaCdSzUj+H/u+YT7+PKH9qSlKKZWUbUqWev7EQMD763z9M9MnN
	evK1/Rk6ZUOCVY5jF/aVwqRoZskVh0EKRYeSIhkROHJYbkmCnNMyMq9ObFNejWUQ
	D7AYWvtQ604j/rJ8FsaHDT8U5QOfI6Y9XOOoKg5QRHagFOcfG23L4Ofl9Msnyj7O
	gCzTAfmw4vFWNcxayqcM6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774559555; x=
	1774566755; bh=3c3om6+sjsXCFA8fMVuyG6m2PTBcXdiHeFZPaFuV0Us=; b=1
	XzLCZa+lypjYYA1FEUvVXwCTkOcD6y7SpT6voyzeEd3zhqqZsOutw1e5y51OtG7V
	lzztd/KY+UlCr5RgwWh26lXfg7Y+xY3jrFwMm5EmUNOSV4SXIByz7Y9Glci/zOih
	jYrvgqVhAmbNu4YCuFdXQh2lEDMWdsClz8bNo6k9K3d5c+V/FJzkq7wI5CSwWOTP
	2XZArrwK7hJpH9Kl+CKBkANvZOyTBgOI4wAM3MOW5cMbctnksKf60YOOB0Jdp4An
	RhNce8EIR+518MCOBpmGgswyGqX24HZGpDeSEQzZi0zV3OVlXgxy7RiyBsM+1G+F
	Kbd4AVM78gVqsstuMfvrg==
X-ME-Sender: <xms:Q6HFaVyG6ruaQSh5e5kCBjpHIrjoAz-wGMr2shhLDxFhXKOPoJSF4w>
    <xme:Q6HFaQGx8DfJvUnLgsviVjWdW21aenIBkwkJStbPVEGivaESI25gs6X6KEOArQ6z-
    Ji-OmH9sRD-Va6W91RMnRuxs_VwZEhZHAlbZKuD-B0QrLe7DY2A_xKX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekgedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Q6HFaWhbx8C_KZNlyXszmnPYRIVKdQc55GyIQllnyayAbQFHfwNFyw>
    <xmx:Q6HFaUOyGbufkV3bRiAGc-wtvbc7PBL5udwC8nwCwlFtaddcPDBf0g>
    <xmx:Q6HFaSmRlCcp_Glzt6sMAJhjufVNruIgtJHPjJKR6R2ZG9PlDTFcwQ>
    <xmx:Q6HFaberQcocxkCF8UOwVV8svlH8nER1D9H1OBHI4yZUEdry84hsvA>
    <xmx:Q6HFaeDc_iYXndIHBJHdNxvOCUZpS3pPxSd-gGF0jAjdR_kmFijaBy4i>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 406961EA006B; Thu, 26 Mar 2026 17:12:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 26 Mar 2026 15:12:28 -0600
Subject: [PATCH v4 4/9] wifi: mt76: mt7925: populate EHT 320MHz MCS map in
 sta_rec
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260326-mt7927-wifi-support-v4-v4-4-8ab465addcfe@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=floss@jetm.me;
 h=from:subject:message-id; bh=b6wuUqMM9LRMdvCkKcW9uEToGwJgCsTkr6DKPTvA7cE=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxaE4VlACD2f9ty4mlsbzwGy0NEwbgy6c4WFYF
 8lR4kQZQCCJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacWhOAAKCRC17sMLqGd3
 H4kfC/9KZLfgtUqSRYhbjzjUEaTO+NJNxIJ0l8g8fyZLKBpgPH+l587G1knB3e28L+Zi1C25vNu
 1tK3NTnxKFJmsOWDbM4aGzl3f5n9sdWEb//6JG4/OWgVIJYivtGeOWvV93PtTxdPaEeZsKAn055
 lLInTHEwF0Y/C3WEj8q71x54AalLIffT9IASc1Q4dRsM4L0PtR0Gibe/M0kcItULF8PZtWthOsm
 iEx0aOTdXDN1s0wWzxo0LWnjjwq8DeLreszR2ggix2hRbP4CbrSg6sLNfDDvDYVP1MMVc7nmStY
 juUMAgjHn6xX00XCuSE71ANjvdj3QTCphfcEfo+dG6b/IIEiRO74Mf6s0aK77iMaSVDxKVDTgmR
 +/Po3fFghyfJo2TSp2dQIPb4fo/gbFJPmGjGVtZrt10WmlgPtuh+j/oQC2+4nO1oSR2hB9G37EE
 ngz1QrgKkjydGeCjtyO38KlYd/anmE/xwwclZr4ZNweXVfds9yRUD3+OeqJ6guWpXX8Ig=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me>
References: <20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me>
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-34012-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jetm.me:dkim,jetm.me:email,jetm.me:mid,humeurlibre.fr:email,messagingengine.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lgic.pl:email]
X-Rspamd-Queue-Id: 364F333BB5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The sta_rec_eht structure has a mcs_map_bw320 field, and the channel
width mapping includes NL80211_CHAN_WIDTH_320, but the 320MHz MCS/NSS
map was never copied from the station's EHT capabilities to the MCU TLV.
This prevents negotiation of 320MHz channel width even when both the
hardware and firmware advertise support for it.

Add the missing memcpy for the 320MHz MCS map, matching the existing
pattern for BW20, BW80, and BW160.

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
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index dd5ecb07947b..a7f27c5014d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1683,6 +1683,7 @@ mt7925_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_link_sta *link_sta)
 		memcpy(eht->mcs_map_bw20, &mcs_map->only_20mhz, sizeof(eht->mcs_map_bw20));
 	memcpy(eht->mcs_map_bw80, &mcs_map->bw._80, sizeof(eht->mcs_map_bw80));
 	memcpy(eht->mcs_map_bw160, &mcs_map->bw._160, sizeof(eht->mcs_map_bw160));
+	memcpy(eht->mcs_map_bw320, &mcs_map->bw._320, sizeof(eht->mcs_map_bw320));
 }
 
 static void

-- 
2.53.0


