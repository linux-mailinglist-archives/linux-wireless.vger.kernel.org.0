Return-Path: <linux-wireless+bounces-33521-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCWOHfp3vGmFzAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33521-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:26:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB742D2F40
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDB60302B22D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 22:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54827402437;
	Thu, 19 Mar 2026 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="pKi+BpSP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fQkDRwHF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68613FA5D5;
	Thu, 19 Mar 2026 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959078; cv=none; b=KU//q8r4T3KD3pBgk6MmJK8LG/PyGek/fxf/cA8shJpriN0+/CQAAqaTVvBPbgzEtaNFotogupbyyVrc5VQ1eiUi3NYrh3LLvxS0jZZ6ArRgM5xB8iyIYQIIinOOYO98YSK/uixc+J0NmkvFfYUPxPtRkSm9Zwah/IiPUxjM1rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959078; c=relaxed/simple;
	bh=jWvfRpWdnEYpKJDJ/Bf+bOhjtZ1T5Q852eESr9hihqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=K7c4TvmkyaSipb7ek5x7EPT/6PIhaO5FlapYCPbE6m+Fxj6UPl5Tmu90w5gV91H1TyALOixOQTtg/v2ZH36sr1OAVgW0IWcD+duQGHZUbtMkwfguCH4mEUz3n7cVdE39touW4USK98U6XB9dx4dGmf3Tu1eVHtKPNly+E/h1oU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=pKi+BpSP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fQkDRwHF; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 47F1C13000AB;
	Thu, 19 Mar 2026 18:24:32 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 18:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773959071;
	 x=1773966271; bh=cxJCLr7x83TM4awgiz8RT2JSmXJWiLKIRsJPIkFRlRI=; b=
	pKi+BpSPAVEBTx7LUQJAjzdQvRTRmP2UnXfwUeNNY12Zd6CV+LA1K5Kld84qLwdF
	KAAJ2LlcqzQ3sANZPOtpKCPTJuMqCVdL0ufOPd6cHz8KqS/Cz+Qdhv5GiOhqbvJ7
	ry115CpzpDHwQPvuZOpd7wDC1w3uNpaHBYOAOtquBwe3wL/WzwDXoxp8MAiOqo6r
	ynrKM5MFmFjOmLlw20dEfeikRpLIsXPkda9hRInwps9vhzF5GoaPPI+LlxVJyL/j
	DS+TsIJ5dBhaTfkKDIz1YkOgP0JwN27jVDjYQPJUlBjl5GAoXllz0C2S89NuCTLO
	Ql3f/KHypNbUWfMG7TPZxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773959071; x=
	1773966271; bh=cxJCLr7x83TM4awgiz8RT2JSmXJWiLKIRsJPIkFRlRI=; b=f
	QkDRwHFMmnIrABgsjgwYQa132GEYXhxlnoAzkcwuHhaENeofbrd2HHFlzNWLNFDU
	1T35rxG24MwaJHXZsLiggQ2P/6Bayy7F5zcg1YyWJOAgc8nvu6kH4OzC98j7Egb9
	Y0G8WdkZoO2lIh84q8N64EVqP8CzKuL6kOWifF5wlhL0RkWFHpw4mY9rLMQo4JDC
	SwVLRQqjpw5dXMsjd9R/7FdKgtt1Zb8FOFkfFbINigp094XEyggNAd5a4eC4ZKLn
	ICc8IK1IxPfsNDH9kKwxTNzPBCnAGtTex/9jV/Jg/A7Dvt9C1hyaFUtuDSgsxpzB
	mDNNfveTMgD6DecgoxV5Q==
X-ME-Sender: <xms:n3e8aQzAMGSqvHHONpR-MohY8Xs37ZU9MRvZr2sCuKRCYX4gyW7RpQ>
    <xme:n3e8afFg68OD4CWHLw7HUIVQLD8Q1v5GjLCBLM3d5xiA2X8PDgqXHkhtYYkO3TPiP
    j_s358JMAEDTdmOWGBafBg0D-vSGBgpk9s_iS2QhdQOqWngH4Vq9ak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:n3e8aZj9QWu-yMXtJYkrF55J4iCJLIzl6UImYxiJyL7Z8RCd9E6xzg>
    <xmx:n3e8abPgR6OqcZj0Qn3etd3TP-FNhgol5tC2YbWq9VhXmMGPKho-UA>
    <xmx:n3e8adn2NnCQyObgZmIVhydpvu8UjpGR57on5ZV1tJ1QGX7zoofLkQ>
    <xmx:n3e8aacXA_2FyiKyVBF8RDhGfq99hxtgsX6JJYEHhFmQf14E1XFgiQ>
    <xmx:n3e8aZBl2tpse3EMvU25V4dbCs0bEOJz5Cu2JFR3LkfrmynGLEOrhiC0>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BD8E21EA006B; Thu, 19 Mar 2026 18:24:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 19 Mar 2026 16:24:21 -0600
Subject: [PATCH v2 05/13] wifi: mt76: mt7925: advertise EHT 320MHz
 capabilities for 6GHz band
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260319-mt7927-wifi-support-v2-v2-5-d627a7fad70d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5375; i=floss@jetm.me;
 h=from:subject:message-id; bh=jWvfRpWdnEYpKJDJ/Bf+bOhjtZ1T5Q852eESr9hihqk=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpvHeQHxbYUH5sDg3XnEGlwwxH0gRlfw7XCF6R6
 uYmngTGJFeJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCabx3kAAKCRC17sMLqGd3
 H8MQC/9RDOiR7d4CCTMigUzXgIC0o1u8zkcUCToGjw/DgVoHlpY5qZme3P1By5ILP6PxbpR1y90
 jcaMkhRmKpOW3zbKTh2s8KeyGgKvTJ+46aqaVTHYNGBMIY/Z20bnTTtkOCxKFfPN0fP9bkGZuk5
 RLNPBisk84QB3rTOz/ztSy4XGNQTV53R8zixuuOdpr2CuUec+onDWPtoMiy/+sD6ciK/tTgfbcu
 jgJQBH4woXaPk0/Ac+84FAQzbXTrWoZ5/ErSwSVQI3rJv0OvDMHC8CK+i8rkk2qM/di1BmlwguC
 e2wMkpkmzoWTCWndLst2qE4MdUPaD0IsgMgYWewcEhJ5YvphZzW6Sb0tnjoXkMeJoqBkBr+T/MJ
 oiE2UgYSWOGEQrOmGUVpFT8fmqLxf6KFTO/MvJrgzrwwGRcW2N5nBOHqm8eD2I1Rb3OPyE7vz7V
 sxoSI8xUP075IchcUkShGzUSAIsdFqgY/oVUS6YGob798mDTQSH1Ky/LiJCp8uJwyydd0=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
References: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-33521-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.365];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,lgic.pl:email,jetm.me:dkim,jetm.me:email,jetm.me:mid,humeurlibre.fr:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FB742D2F40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Introduce is_320mhz_supported() as a generic capability check using the
mt7925 family ID. This avoids chip-specific references in common code,
and automatically extends to new chips once they join the
is_mt7925() family via chip ID helpers.

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
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 28 +++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 813d61bffc2c..554716e01ee6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -177,6 +177,11 @@ static inline bool is_mt7925(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7925;
 }
 
+static inline bool is_320mhz_supported(struct mt76_dev *dev)
+{
+	return is_mt7925(dev);
+}
+
 static inline bool is_mt7920(struct mt76_dev *dev)
 {
 	return mt76_chip(dev) == 0x7920;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index f128a198f81d..cd043ac266fb 100644
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
@@ -230,6 +245,11 @@ mt7925_init_eht_caps(struct mt792x_phy *phy, enum nl80211_band band,
 		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ |
 		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ;
 
+	if (band == NL80211_BAND_6GHZ && is_320mhz_supported(&phy->dev->mt76))
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
+	if (band == NL80211_BAND_6GHZ && is_320mhz_supported(&phy->dev->mt76)) {
+		eht_nss->bw._320.rx_tx_mcs9_max_nss = val;
+		eht_nss->bw._320.rx_tx_mcs11_max_nss = val;
+		eht_nss->bw._320.rx_tx_mcs13_max_nss = val;
+	}
 }
 
 int mt7925_init_mlo_caps(struct mt792x_phy *phy)

-- 
2.53.0


