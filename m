Return-Path: <linux-wireless+bounces-32699-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB8eN5Z0q2lCdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32699-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:43:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8900229138
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C5DD303D4CE
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9A22BFC85;
	Sat,  7 Mar 2026 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="XTxAQkxH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O0qTvjl3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F69D2BD00C;
	Sat,  7 Mar 2026 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843646; cv=none; b=vFOIADThAr7Y8kCrS2a+Nwq9QxxRPFeM3uoSb1AuVPa4odCxTDBb+IETJghtJIOm3lhfivQBSvglEdvCCpK7RJSDlwFMkbwZDRIjSIufpQa2dGyD5MDjLd8VDWLAn/EzqgkPXPDokKtemZjm4nhCW/SgV8CLglS8Rv5M8xnyabM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843646; c=relaxed/simple;
	bh=2hcUPm4U/IeBMFjpuJHby3rkRBghMcipdujJQ1HSdNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=DQSQFTT1KnoMrVe2rcBX+Weg4bbk9KLwtDiyHmnvZEdmN4othiRGx6IvMLPVMnq6vvwSfU8kkcW8dFvDxOWnL/7rxXJc5PGt4ZVhI8yg9U+8CnTZsmiIfKDwfNJ7S7cXDD710JV0bd+gCmrQSE7sVcYvKs2plvNaN+mFkX3MTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=XTxAQkxH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O0qTvjl3; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 660991380AAA;
	Fri,  6 Mar 2026 19:34:04 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 19:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772843644;
	 x=1772850844; bh=jUfiJHAcvHzsW9gWJPo2SxNLeAAQDRzeb3RPmZ0qIi8=; b=
	XTxAQkxH4WHyk+x0UkMptsy8Siy8E6TXvo9huaWr95m3uQ845l3QLSe/zWWG8fCF
	53Rroci5YRAuKAH/IbnZBOObQGJkjJ6oCC3rvG6F1Q0B/9ls/RUS74tReSA7QdhW
	kAkOanK+m1qufj7b+uME3qe0CR/t1UI9kW93M/55qEcE26O1kSBZeCTYgXL9oAR+
	q4ewl8j0JQSHLCRfoZ1QharMq2gOnOZobbYWea09CLR8eRoVNLccGAhBayG5i9IE
	siKDjl1jMVqKcNEBSyMOb4qZHvvLn/VB/fO/1bbkmFhZCakcx3LcBDenqus30Qrv
	l5Np99iuPfcd9U7T7tburg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772843644; x=
	1772850844; bh=jUfiJHAcvHzsW9gWJPo2SxNLeAAQDRzeb3RPmZ0qIi8=; b=O
	0qTvjl36ezz7l/CAiGuHOZ3Ovbmq25VibALHnZ2YBoVi7FxWOodiaf5ZbH6X/ggW
	dTRspOCwUaNpquQN0N2i1N0fQSq8NxFUD+LwJEmLd3pY5VaYDcH1E98nPlYeQy62
	M5j1btjlPHoDRX/SYkKH565puLbmqUxF1kVK2WFw9h0Tn3RTpBJrtxu/OEHATuo0
	VgP2mDp0RFh+Kv/0gMg1Bmy/sYH0l7iPhtAyc0DzfV0CEbigbxUKoCwPhQzUOfIr
	+VzWGbT3KLgiYwElDvyZqHFn0887NbFwUCterPZPpHVaI9EePUjMoyfjZf3rf/8f
	fwOu5tKZM4BK0nrQI7Grw==
X-ME-Sender: <xms:fHKraf_Rh7r0F6g2RRNZAjFYXqYQpBiZNfnU2REI3AcSnuNDY68sfA>
    <xme:fHKraWhXIgfQC9koK7v8MVbsLDjyWAPAnfn8hjIm38EeFYEngfdchbBYVygSFSQfe
    lw7abDqM5VY3AMIvOSVAXBPfddFUKduSqbOrXsWFNFjNq0SAPkBELs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepuddtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehflhhoshhsse
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
X-ME-Proxy: <xmx:fHKraY-cpSaOT1uP0Y4A6BARhNJWz1kVtejImb-ZDUJWeWdr-txv5Q>
    <xmx:fHKraVkWUZdMeYAm4AE_HC7k-Y_1OhkP9tdPktvFQnvyl1rdJWlLhw>
    <xmx:fHKrabmK0mc_y5wxHtMY3oST91Uz_pLJpY-Pe-XPQWxs1oGA9ClOGA>
    <xmx:fHKraagWdrqea_uObn7bsu-5f4qHPcNa86JTMb90V1J2nLA7b34e6A>
    <xmx:fHKraeIFqPjR9keZZat0UkZl_R2yzePl2wBeqWy9qx7DutQDPEtnpWDL>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3A1881EA006B; Fri,  6 Mar 2026 19:34:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Fri, 06 Mar 2026 18:33:31 -0600
Subject: [PATCH 12/18] wifi: mt76: mt7925: advertise EHT 320MHz
 capabilities for 6GHz band
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-mt7927-wifi-support-v1-12-c77e7445511d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4700; i=floss@jetm.me;
 h=from:subject:message-id; bh=2hcUPm4U/IeBMFjpuJHby3rkRBghMcipdujJQ1HSdNg=;
 b=kA0DAAoBte7DC6hndx8ByyZiAGmrclDIruDhnTwS7bbuSsddulTeXZJNLYvRrom7IwcqgcMzP
 YkBswQAAQoAHRYhBJsTsgvPDt4jRUqTybXuwwuoZ3cfBQJpq3JQAAoJELXuwwuoZ3cfetgMAICT
 DG9hcbpiIsqOVbOJJ8tNtvRfbLAQaRY+myXrn1rODTe6gOrK/fQtPY5QpBmC6EbRO6ltn3TiIo1
 BE5AH9tx3OyAqU8KxiYajOIINwQqK6nUgkm8nqnDxlyP9mTR1BBBwTqn3YZ3gZYs0S3ivVFovCX
 AG9Yor59EmTXjjngnG0s0jduP7ViEOV31PKLFvExnYfRHmuspYXI/eHBoXguNMKCzOctFpV8Ibd
 D+efzT5m6tqiwLg172HsHjxIIB9NcP5ToI4mLrCAU9NHksenVh7MvhSGOVtmnL9AmG/2GQ5omi4
 tlpaDQcd72uT4lsk3hxE+6c7MFb+I3YB9PsOZu0mPZ/lvUOykBw3tCCdQHugMy86o9iwW/JN11X
 oxn+XVe/KIxd2772AieOXnRH2nbePU/NLOKY2HU82ihxcGI3z4IFNcEQYSbqziN6qyeNbHo4HnN
 ++njPWowclCAXQXYw44lYOpKSOBl6FrQ0XC/q2rRGZuWLuFLCS8YY2SLzqPQ==
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
X-Rspamd-Queue-Id: E8900229138
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32699-lists,linux-wireless=lfdr.de];
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
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	NEURAL_SPAM(0.00)[0.673];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anthropic.com:email,messagingengine.com:dkim,humeurlibre.fr:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,jetm.me:dkim,jetm.me:email,jetm.me:mid,lgic.pl:email]
X-Rspamd-Action: add header
X-Spam: Yes

mt7925_init_eht_caps() only populates EHT MCS/NSS maps for BW <= 80
and BW = 160, but never sets BW = 320. This means iw phy shows no
320MHz MCS map entries even though the hardware supports 320MHz
operation in the 6GHz band.

Add the missing 320MHz capability bits for 6GHz, following the same
pattern as mt7996:
  - PHY_CAP0: IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ
  - PHY_CAP1: beamformee SS for 320MHz
  - PHY_CAP2: sounding dimensions for 320MHz
  - PHY_CAP6: MCS15 support for 320MHz width
  - PHY_CAP7: non-OFDMA UL MU-MIMO and MU beamformer for 320MHz
  - MCS/NSS: populate bw._320 maps for 6GHz band

Guard all 320MHz capability advertisements behind is_mt7927() since
320MHz support has only been validated on MT7927 hardware. The mt7925
standalone chip may not support 320MHz operation.

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
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 28 +++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 2d358a96640c..4e1265886f20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -183,6 +183,10 @@ mt7925_init_eht_caps(struct mt792x_phy *phy, enum nl80211_band band,
 		IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMER |
 		IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE;
 
+	if (band == NL80211_BAND_6GHZ && is_mt7927(&phy->dev->mt76))
+		eht_cap_elem->phy_cap_info[0] |=
+			IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+
 	eht_cap_elem->phy_cap_info[0] |=
 		u8_encode_bits(u8_get_bits(sts - 1, BIT(0)),
 			       IEEE80211_EHT_PHY_CAP0_BEAMFORMEE_SS_80MHZ_MASK);
@@ -193,10 +197,20 @@ mt7925_init_eht_caps(struct mt792x_phy *phy, enum nl80211_band band,
 		u8_encode_bits(sts - 1,
 			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK);
 
+	if (band == NL80211_BAND_6GHZ && is_mt7927(&phy->dev->mt76))
+		eht_cap_elem->phy_cap_info[1] |=
+			u8_encode_bits(sts - 1,
+				       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK);
+
 	eht_cap_elem->phy_cap_info[2] =
 		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_80MHZ_MASK) |
 		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_160MHZ_MASK);
 
+	if (band == NL80211_BAND_6GHZ && is_mt7927(&phy->dev->mt76))
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
@@ -230,6 +245,11 @@ mt7925_init_eht_caps(struct mt792x_phy *phy, enum nl80211_band band,
 		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ |
 		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ;
 
+	if (band == NL80211_BAND_6GHZ && is_mt7927(&phy->dev->mt76))
+		eht_cap_elem->phy_cap_info[7] |=
+			IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ |
+			IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ;
+
 	val = u8_encode_bits(nss, IEEE80211_EHT_MCS_NSS_RX) |
 	      u8_encode_bits(nss, IEEE80211_EHT_MCS_NSS_TX);
 
@@ -239,6 +259,12 @@ mt7925_init_eht_caps(struct mt792x_phy *phy, enum nl80211_band band,
 	eht_nss->bw._160.rx_tx_mcs9_max_nss = val;
 	eht_nss->bw._160.rx_tx_mcs11_max_nss = val;
 	eht_nss->bw._160.rx_tx_mcs13_max_nss = val;
+
+	if (band == NL80211_BAND_6GHZ && is_mt7927(&phy->dev->mt76)) {
+		eht_nss->bw._320.rx_tx_mcs9_max_nss = val;
+		eht_nss->bw._320.rx_tx_mcs11_max_nss = val;
+		eht_nss->bw._320.rx_tx_mcs13_max_nss = val;
+	}
 }
 
 int mt7925_init_mlo_caps(struct mt792x_phy *phy)

-- 
2.53.0


