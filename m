Return-Path: <linux-wireless+bounces-34013-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO/MELKhxWlUAQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34013-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:14:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B88DA33BB82
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC46F3077DC5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 21:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9773AB280;
	Thu, 26 Mar 2026 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="gklpjtoV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R8W6jflH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0283AA1A7;
	Thu, 26 Mar 2026 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559558; cv=none; b=g9e5szBpASoNkuKkFOZCLHKbWgiDcp0rWsNhEU7yqYPmTCrnzT8SA+8hglqrYPKfIjahPhBO21koUpeNrrbVLuiNVUG7RCzz1tyg6zybbLTqGAv+NQ3imJhycZyuP4wzAVnK3pzt97aMz32jYYOCoiGPuEnckCmsrmGaMRv3aOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559558; c=relaxed/simple;
	bh=7sKfSMgYBAE2lHy4UYHmoX7t5FfxzJIRdxoV8d7AnaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=MiVG5/Q8VRZjifSbaAGZEl19hgR3RmnQJMuBJW9j7Ifh6OBTA7jQI1pROXDlfHQXacAPkvFV2ioE8ytWayycdg693Ec2jf5J/3RcDqgrL5cQyGLir5SFqDMasobFbFDYweHUK411KSkIJpYHQVxuW6lLR7X9y1zfA9GZqcOxrBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=gklpjtoV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R8W6jflH; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 1BA331380152;
	Thu, 26 Mar 2026 17:12:37 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 17:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774559557;
	 x=1774566757; bh=N3dmHBJtWcH4aVH4pX6EfK6KRYUSDVkPQKuxD2W990A=; b=
	gklpjtoVjcj9oIinOqFY/pOXhSaEqJgFusBFEm00BNsoaO54QVQOQL3d0qFEuaqi
	CJ5t0w5WohMU97fW1WYerapPf0NEOLCzT7Ok9JPbwBUJ0DfvaIkmiCoA1K8vBwAw
	tEZIWm5ikslBSvCFt7gKsGSsPu/elP+UKjLuG40jdb6vBnKdG/AySYBN15q/+v6R
	ZiX1KyuvPoqZPsSfbabXpG+Tdplh1k1lLlGj7a/G6Sb71gyFr9pdESeGqRCFcAhc
	ij5q946c7j5TfqcI5GsKM5oQcgzMxuiHcI4tj4Htr34DlTdiQIlEnz9f+PewVqgM
	MECIhB5LHL09KA6YO8qrQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774559557; x=
	1774566757; bh=N3dmHBJtWcH4aVH4pX6EfK6KRYUSDVkPQKuxD2W990A=; b=R
	8W6jflHp+g41OdhSUKtiehs86ox7orJik1h1A6K2d436qyWrZ1sFLny5reCIKkbs
	bdLPL4zMdEjtUCxNoipt5BB+PboTz5twIxMl7Y4izr5dG7Lji5bJI0vcePndYNr9
	6S9yjy8OC2Ir8IMWOkEyP8rdOPXubm/IgWYDGWldLVBWSv/8eJWxWmsuZ65e0GTd
	lnmA6jic8CVJ8/QXJ2OD8b1rL7em9Ddeuzw5QdqgR1pOy0OmYZJKYXw1sfUs41EW
	qV9aWCsJAustHWkcSxnPZ1l+b3Vq+LygIfY2efqTLK1N/i9UPuJ2AapqAVpcN9St
	v95ixcuwR5480ZTUEIDsg==
X-ME-Sender: <xms:RKHFafKWMLoFg8HhGZjA8qpUSavxkz7c248BxYHX32rsKhhuM85g1g>
    <xme:RKHFad-E9MxYJ63jqew42okRl-P_bEWAau_HPCGXB9pPpjwi9nJeYVrXKJIVugtqm
    Swb76-fBPeMWFjBiIvXkZzA6GNw75N6tnv45E730GhHoK-gEEgq_5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekgeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:RaHFaQ7aMDrhFSxv6Z7oLIb27TpT8k4xRIlyqAUNPBnZnxiS59pXcA>
    <xmx:RaHFafHC1elual7e66fTvffPuTrmpyTzLda_76tx2Z68ynkDWuHzPQ>
    <xmx:RaHFaT__C0l3Y-4VdbExsEwD4io-D7NPdAEyJvA6g9iLPwFMlIo7JQ>
    <xmx:RaHFaRVPS-fo4ODNOnodztBs4oNUHZNn4O9Puwy_dAlnSkoTyO6bIw>
    <xmx:RaHFaUzifzvaGjEFwARiYJhrY0X-61_KfUHiy11ZTuROE_9GFxJVljy5>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DEF1B1EA006B; Thu, 26 Mar 2026 17:12:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 26 Mar 2026 15:12:29 -0600
Subject: [PATCH v4 5/9] wifi: mt76: mt7925: advertise EHT 320MHz
 capabilities for 6GHz band
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260326-mt7927-wifi-support-v4-v4-5-8ab465addcfe@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4614; i=floss@jetm.me;
 h=from:subject:message-id; bh=7sKfSMgYBAE2lHy4UYHmoX7t5FfxzJIRdxoV8d7AnaQ=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxaE4FpgpvSgVsJlA1KXsjKuNHsYnoCuE/gDkz
 7V15J/XoMGJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacWhOAAKCRC17sMLqGd3
 H2yJC/9ok/ueHwBJgN/EQwe1zahjF/ofm+2BtKnzj6N9qcsh1q1yGOjnuBsT2tVOhl50u6n3adi
 qp0341r4RtDTEGrgzIKWyrhYzbc15N06rRL1USHzesggBWwRG/AGudHwkS/ufUiik0sPomAmPe6
 UuIVoBfpeS3LUDrq5O8hMayHQ8Dzyzefy4PJxFg/kYZZAKSBva2yO/6JU4UzL1DPLm55PgjjcKm
 nCUndD4VCTPFf+HFnlrXMbFa7F9NAa7X2d5qNquVaouOhBCF0BGoqYG67pC6V7cuIsy9Y6q72lN
 kOQvO7p+W9BUFJ8wsq5YF2e4KDnwyS4a5qg3EYLBQam77y1N386cXjaFb0oYzV/yqcNbqOHuGkF
 rx2z8VbcWBj2KPaGFxVL/rxQcVLnN8J/1U4VO1hICEvHpWaOF8h89Ex0C0SAHEkU9zpFTHXU0oM
 oOOOF3/u/zYdDVtFhaPEVJHYTp8IWkLTbvYM8ekDvAK4rwQLVPGWPJRb/UmpoiPkKeW7g=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me>
References: <20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me>
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-34013-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,jetm.me:dkim,jetm.me:email,jetm.me:mid,humeurlibre.fr:email,messagingengine.com:dkim,lgic.pl:email]
X-Rspamd-Queue-Id: B88DA33BB82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mt7925_init_eht_caps() only populates EHT MCS/NSS maps for BW <= 80
and BW = 160, but never sets BW = 320. This means iw phy shows no
320MHz MCS map entries even though the hardware supports 320MHz
operation in the 6GHz band.

Add the missing 320MHz capability bits for 6GHz:
  - PHY_CAP0: IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ
  - PHY_CAP1: beamformee SS for 320MHz
  - PHY_CAP2: sounding dimensions for 320MHz
  - PHY_CAP6: MCS15 support for 320MHz width
  - MCS/NSS: populate bw._320 maps for 6GHz band

Introduce is_320mhz_supported() to gate 320MHz on MT7927 only, since
MT7925 does not support 320MHz operation.

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
 drivers/net/wireless/mediatek/mt76/mt76_connac.h |  5 +++++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 22 +++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 813d61bffc2c..393a7952f86b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -177,6 +177,11 @@ static inline bool is_mt7925(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7925;
 }
 
+static inline bool is_320mhz_supported(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7927;
+}
+
 static inline bool is_mt7920(struct mt76_dev *dev)
 {
 	return mt76_chip(dev) == 0x7920;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index f128a198f81d..cfce851a94e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -183,6 +183,10 @@ mt7925_init_eht_caps(struct mt792x_phy *phy, enum nl80211_band band,
 		IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMER |
 		IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE;
 
+	if (band == NL80211_BAND_6GHZ && is_320mhz_supported(&phy->dev->mt76))
+		eht_cap_elem->phy_cap_info[0] |=
+			IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+
 	eht_cap_elem->phy_cap_info[0] |=
 		u8_encode_bits(u8_get_bits(sts - 1, BIT(0)),
 			       IEEE80211_EHT_PHY_CAP0_BEAMFORMEE_SS_80MHZ_MASK);
@@ -193,10 +197,20 @@ mt7925_init_eht_caps(struct mt792x_phy *phy, enum nl80211_band band,
 		u8_encode_bits(sts - 1,
 			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK);
 
+	if (band == NL80211_BAND_6GHZ && is_320mhz_supported(&phy->dev->mt76))
+		eht_cap_elem->phy_cap_info[1] |=
+			u8_encode_bits(sts - 1,
+				       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK);
+
 	eht_cap_elem->phy_cap_info[2] =
 		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_80MHZ_MASK) |
 		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_160MHZ_MASK);
 
+	if (band == NL80211_BAND_6GHZ && is_320mhz_supported(&phy->dev->mt76))
+		eht_cap_elem->phy_cap_info[2] |=
+			u8_encode_bits(sts - 1,
+				       IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK);
+
 	eht_cap_elem->phy_cap_info[3] =
 		IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK |
 		IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
@@ -217,7 +231,8 @@ mt7925_init_eht_caps(struct mt792x_phy *phy, enum nl80211_band band,
 		u8_encode_bits(u8_get_bits(0x11, GENMASK(1, 0)),
 			       IEEE80211_EHT_PHY_CAP5_MAX_NUM_SUPP_EHT_LTF_MASK);
 
-	val = width == NL80211_CHAN_WIDTH_160 ? 0x7 :
+	val = width == NL80211_CHAN_WIDTH_320 ? 0xf :
+	      width == NL80211_CHAN_WIDTH_160 ? 0x7 :
 	      width == NL80211_CHAN_WIDTH_80 ? 0x3 : 0x1;
 	eht_cap_elem->phy_cap_info[6] =
 		u8_encode_bits(u8_get_bits(0x11, GENMASK(4, 2)),
@@ -239,6 +254,11 @@ mt7925_init_eht_caps(struct mt792x_phy *phy, enum nl80211_band band,
 	eht_nss->bw._160.rx_tx_mcs9_max_nss = val;
 	eht_nss->bw._160.rx_tx_mcs11_max_nss = val;
 	eht_nss->bw._160.rx_tx_mcs13_max_nss = val;
+	if (band == NL80211_BAND_6GHZ && is_320mhz_supported(&phy->dev->mt76)) {
+		eht_nss->bw._320.rx_tx_mcs9_max_nss = val;
+		eht_nss->bw._320.rx_tx_mcs11_max_nss = val;
+		eht_nss->bw._320.rx_tx_mcs13_max_nss = val;
+	}
 }
 
 int mt7925_init_mlo_caps(struct mt792x_phy *phy)

-- 
2.53.0


