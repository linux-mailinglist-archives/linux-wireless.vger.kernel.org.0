Return-Path: <linux-wireless+bounces-33527-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJHgMtZ5vGnOzAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33527-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:33:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 492A22D3247
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E54CE302AF17
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 22:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA0C40B6CE;
	Thu, 19 Mar 2026 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="j7oNWlNE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0Kdn/7P2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24B83BC66D;
	Thu, 19 Mar 2026 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959091; cv=none; b=K19mqFDR5yxJ3kku5d1JsTDUea+v4nFcX7KM2nK0B2fofdGu3/tUQxDmMV8nukIM2wU8Ox1auSYHDH+uQC6DZVyX5naWVFdSK9mnHMzqDcfJyJ+6+Q4UvTKvFY2vWYivc3N6JTN+wF5DJw1JpkDDvHbZXV5+OXKVC/7fH3skPok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959091; c=relaxed/simple;
	bh=uQ1a1G+lRE1F+q+YVMCHkXinyGF8yjF8AUl5IYMWZrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=VJNKd5l1tdCG21L1C/G4okQ5dLv15NvzI+xIAJe2nPcxqzdalCg+cYSImDQgeI+zwEo07BKgIHIIleF+nmWo+xyKqyzeE4ZBjepYhn7KYJi5TjPILnEjm3G2P4XUfxfF84y6aeUiKHGzs0Hcro1v7E1vrvY7HqkL9fYmOClaL/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=j7oNWlNE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0Kdn/7P2; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 3385213000BD;
	Thu, 19 Mar 2026 18:24:43 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 18:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773959083;
	 x=1773966283; bh=/yRhuFGZGZrTj2kPKFgXclQoMf/ev6Z+NOFxeNH1k6c=; b=
	j7oNWlNEPXaW038KeL+K3IwPv1DsNivvSdQjhF8N0hH3P+giTT8aOmGkdgq3Q5e6
	ov8d58/q9mW7zoRExDdwxVmNGHj7iJUFGbm6MTKEpQA/0CgT50TTUkUE7jKmwdLO
	HF30dxw4UdgKhAnVgrHDChdHSehEcxVDwLgDn5iDsz+k0JaM3CEX1LyH2StGDh3h
	42pLLdWoBoCkL4GXVNcYwqZZD8ng7VfWHUmT8/cma2Lrd8q/IU/DQSGF0MP1pHN/
	ausaVZfy+VMuW6t69B7/A804gkHYRNBe6t0Wti8HSfM4uP7DgxMqnMueamn4NETm
	QaQb7H5NNJZBPXronheFMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773959083; x=
	1773966283; bh=/yRhuFGZGZrTj2kPKFgXclQoMf/ev6Z+NOFxeNH1k6c=; b=0
	Kdn/7P21f8UMISDFHzTNG2vS4kxFXsEYDjFjS3NEuwiolsgtfXjIgAm0Y84l1wUM
	/OSSmTtCfcdVA4juVqzEgFb7GJXY0aviyAADv9Flm+CDfvhkua4Wa3jE0jgRtlJf
	5fSbKzLYACUWZZdmt2hwKCcwaiA+2nimSjtaXcPoS6KiYGg3QxbTLxOtfz6j/ZRd
	39A+M3Owlf9xc1A6yrQ4uiyGqj46bgFBW1iRTOQqN71e8OPNnhENTWLAXDmh0bEm
	b2Llqz5GplOVnUMGyblsFsTgf6YPMvfKzxcAHYgICHx8Bu9aNFczPmgWnpdWWj9u
	OQCjJV1RAqRK8mplvKiog==
X-ME-Sender: <xms:qne8aXdvP-Vgj62WELDuMlHAgtagySAO1rRmL4IqP126sgkjHMhOEA>
    <xme:qne8aYAzamktIkO7y4dO7vQPgbnpENsIRXh6QtJ4mkaqXxoXrkGKccmeofUsan4f9
    VyeURD1JC6PoMClUYKH895wz35sBIFI0vHJrnpseWJ1oqC7OgPv5co>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepte
    egveefkeetvdfhteduueehgfehhfeiveeifeeflefgteeuhfelfeefjeeikeeunecuffho
    mhgrihhnpehmthejiedrsggrnhgunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhmvgdpnhgspghrtghpthhtohep
    vddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhgvghlohhgihhorggttg
    hhihhnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohep
    feduleefieefudesghhmrghilhdrtghomhdprhgtphhtthhopehlohhonhhgrddtgidttd
    esghhmrghilhdrtghomhdprhgtphhtthhopegrrhhivghlrdhrohhsvghnfhgvlhgurdej
    hedtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrghpuhhishgurghrihhogeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhoshgrlheltdesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmrghtthhhihgrshdrsghgghesghhmrghilhdrtghomhdprhgtphhtth
    hopehrrgguohhirdgthhhrihhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrmhhu
    rdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:qne8aQsPRLAsawKGP2xGSXMXM5s3OaGhrmYju7PzqiA_jTY7lfxRpw>
    <xmx:q3e8aaqg2rANkfu2nRm0TfAdbervb-Uo_hw24aevAzk5AhVmSFO56A>
    <xmx:q3e8aQSd3jkBLhWM2YJuLS60gDc9qwAYm1rOaAI6JHEEm32GcnBXtQ>
    <xmx:q3e8afZ5U_IzLx8W5t0xTrUuIxkJspyYXie_xyKxVVYfMOxjYbmrwA>
    <xmx:q3e8aesSRWfHafs7dhrJbXKHEhxQiANfn8bj1HJN5uteUM_sgNO7dtG->
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D6FB31EA006C; Thu, 19 Mar 2026 18:24:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 19 Mar 2026 16:24:27 -0600
Subject: [PATCH v2 11/13] wifi: mt76: mt7925: fix band_idx for stable
 5GHz/6GHz operation
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260319-mt7927-wifi-support-v2-v2-11-d627a7fad70d@jetm.me>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Deren Wu <deren.wu@mediatek.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Marcin FM <marcin@lgic.pl>,
 =?utf-8?q?=E5=BC=A0=E6=97=AD=E6=B6=B5?= <Loong.0x00@gmail.com>,
 Cristian-Florin Radoi <radoi.chris@gmail.com>,
 George Salukvadze <giosal90@gmail.com>, Evgeny Kapusta <3193631@gmail.com>,
 Samu Toljamo <samu.toljamo@gmail.com>,
 Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>,
 Chapuis Dario <chapuisdario4@gmail.com>,
 =?utf-8?q?Thibaut_Fran=C3=A7ois?= <tibo@humeurlibre.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8944; i=floss@jetm.me;
 h=from:subject:message-id; bh=uQ1a1G+lRE1F+q+YVMCHkXinyGF8yjF8AUl5IYMWZrQ=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpvHeRCORlkzEHkL2BxLTLVSIZNnrUd85b7+MHm
 mtX5OyRRN2JAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCabx3kQAKCRC17sMLqGd3
 H4kwC/9NkPhymTfP8freC3WRvVYMipev9KDJJbZY03wWgILjhdYkqy7MRaDyZSGWMLNqXeVHGbu
 F2K3xnr2ZbYqwYAKwq8TqhsIvd6jWYGNnYRWKiCOb+WzvBuYTgRSfDRIwZC0nfwXBQlDl5dyvo3
 bOZo+mk/nJvo0vXPL0Y7vVr4xwx1koRGaDi+5k0nOqEi59mjY0qpD4P4tBSFQKPCBCmhwZ0MHjC
 fzR34mQYayFa7Y7MMSBq6WSwCh/wdK+2VGLOilus9pzr0oPzcweslsCP8AHV7wFhs0FW0aNwZqc
 AXkQubeUJqtJ8OTxdlhikNf9AfEDBKpv3ye3TsaSBFlPLaeqZzizyvPNbVn+B+WGFHMO6QvaR6M
 xzvoPheWTiVHesjgRDGwlwb0WpbkIHrOC43IqpBUbiN4QRttntqUMk7pNAVEP21LbF7lP91dDNj
 2tDIZcTlRtq7yX5AKKh7uf0g9k7cRtLeRPg44RdX/w5CNtNTa2MwLyQe41jdD2tvgiCOE=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
References: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33527-lists,linux-wireless=lfdr.de];
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
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	NEURAL_SPAM(0.00)[0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[humeurlibre.fr:email,messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,jetm.me:dkim,jetm.me:email,jetm.me:mid,lgic.pl:email]
X-Rspamd-Queue-Id: 492A22D3247
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

The MT7927 firmware requires explicit band_idx assignment (0 for 2.4GHz,
1 for 5GHz/6GHz) instead of 0xff (auto-select) used by MT7925. Without
this, the firmware selects the wrong radio for 5GHz and 6GHz
connections, causing WPA 4-way handshake timeout and data plane failures
on those bands.

Introduce mt7925_band_idx(dev, band) helper that encapsulates the
chip check: returns the hardware band index for MT7927, or 0xff
(auto-select) for MT7925. Replace all scattered is_mt7927() + band
mapping patterns with the unified helper across BSS creation, channel
context assignment, ROC requests, and BSS info TLVs.

For ROC requests on MT7925, the helper returns 0xff which is then
refined to 0xfe (BAND_ALL with DBDC) for JOIN-type requests.

Also clamp invalid grant band_idx values using rfband as fallback, and
process grants for all MT7927 request types (not just JOIN).

Originally discovered and fixed by marcin-fm; Loong0x00 contributed
additional improvements based on marcin-fm's patch.

Co-developed-by: Marcin FM <marcin@lgic.pl>
Signed-off-by: Marcin FM <marcin@lgic.pl>
Co-developed-by: 张旭涵 <Loong.0x00@gmail.com>
Signed-off-by: 张旭涵 <Loong.0x00@gmail.com>
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
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   | 35 ++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    | 50 +++++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |  7 +++
 3 files changed, 80 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index cd043ac266fb..25f8c5a28e5c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -400,7 +400,19 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 
 	mconf->mt76.omac_idx = ieee80211_vif_is_mld(vif) ?
 			       0 : mconf->mt76.idx;
-	mconf->mt76.band_idx = 0xff;
+
+	{
+		struct ieee80211_channel *chan = NULL;
+
+		if (link_conf->chanreq.oper.chan)
+			chan = link_conf->chanreq.oper.chan;
+		else if (mvif->phy->mt76->chandef.chan)
+			chan = mvif->phy->mt76->chandef.chan;
+
+		mconf->mt76.band_idx = chan ?
+			mt7925_band_idx(&dev->mt76, chan->band) : 0xff;
+	}
+
 	mconf->mt76.wmm_idx = ieee80211_vif_is_mld(vif) ?
 			      0 : mconf->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
 	mconf->mt76.link_idx = hweight16(mvif->valid_links);
@@ -417,7 +429,8 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 
 	mlink->wcid.idx = idx;
 	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	mt76_wcid_init(&mlink->wcid, 0);
+	mt76_wcid_init(&mlink->wcid,
+		       mconf->mt76.band_idx == 0xff ? 0 : mconf->mt76.band_idx);
 
 	mt7925_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -2119,9 +2132,12 @@ static int mt7925_assign_vif_chanctx(struct ieee80211_hw *hw,
 {
 	struct mt792x_chanctx *mctx = (struct mt792x_chanctx *)ctx->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_link_sta *mlink;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct ieee80211_bss_conf *pri_link_conf;
 	struct mt792x_bss_conf *mconf;
+	u8 band_idx;
+	u8 old_band;
 
 	mutex_lock(&dev->mt76.mutex);
 
@@ -2137,6 +2153,21 @@ static int mt7925_assign_vif_chanctx(struct ieee80211_hw *hw,
 		mconf = &mvif->bss_conf;
 	}
 
+	old_band = mconf->mt76.band_idx;
+	if (ctx->def.chan) {
+		band_idx = mt7925_band_idx(&dev->mt76, ctx->def.chan->band);
+		mconf->mt76.band_idx = band_idx;
+		mlink = mt792x_sta_to_link(&mvif->sta, mconf->link_id);
+		if (mlink)
+			mlink->wcid.phy_idx = band_idx;
+
+		if (old_band != band_idx && vif->type == NL80211_IFTYPE_STATION &&
+		    mlink)
+			mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf,
+						    &mconf->mt76, &mlink->wcid,
+						    true);
+	}
+
 	mconf->mt76.ctx = ctx;
 	mctx->bss_conf = mconf;
 	mutex_unlock(&dev->mt76.mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index a7f27c5014d5..0755fee6cdff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -301,16 +301,36 @@ mt7925_mcu_connection_loss_event(struct mt792x_dev *dev, struct sk_buff *skb)
 static void
 mt7925_mcu_roc_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt7925_roc_grant_tlv *grant = priv;
+	u8 band_idx = grant->dbdcband;
 
 	if (ieee80211_vif_is_mld(vif) && vif->type == NL80211_IFTYPE_STATION)
 		return;
 
-	if (mvif->idx != grant->bss_idx)
+	if (mvif->bss_conf.mt76.idx != grant->bss_idx)
 		return;
 
-	mvif->band_idx = grant->dbdcband;
+	/* MT7927 firmware requires band_idx 0 (2.4G) or 1 (5/6G).
+	 * Clamp invalid grant values using rfband as fallback.
+	 */
+	if (is_mt7927(&mvif->phy->dev->mt76) && band_idx > 1) {
+		switch (grant->rfband) {
+		case 1: /* 2.4 GHz */
+			band_idx = 0;
+			break;
+		case 2: /* 5 GHz */
+		case 3: /* 6 GHz */
+			band_idx = 1;
+			break;
+		default:
+			band_idx = mvif->bss_conf.mt76.band_idx <= 1 ?
+				   mvif->bss_conf.mt76.band_idx : 0;
+			break;
+		}
+	}
+
+	mvif->bss_conf.mt76.band_idx = band_idx;
 }
 
 static void mt7925_mcu_roc_handle_grant(struct mt792x_dev *dev,
@@ -327,10 +347,11 @@ static void mt7925_mcu_roc_handle_grant(struct mt792x_dev *dev,
 
 	if (grant->reqtype == MT7925_ROC_REQ_ROC)
 		ieee80211_ready_on_channel(hw);
-	else if (grant->reqtype == MT7925_ROC_REQ_JOIN)
+	else if (is_mt7927(&dev->mt76) || grant->reqtype == MT7925_ROC_REQ_JOIN)
 		ieee80211_iterate_active_interfaces_atomic(hw,
 						IEEE80211_IFACE_ITER_RESUME_ALL,
 						mt7925_mcu_roc_iter, grant);
+
 	dev->phy.roc_grant = true;
 	wake_up(&dev->phy.roc_wait);
 	duration = le32_to_cpu(grant->max_interval);
@@ -1378,10 +1399,14 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 		req.roc[i].center_chan2 = 0;
 		req.roc[i].center_chan2_from_ap = 0;
 
-		/* STR : 0xfe indicates BAND_ALL with enabling DBDC
-		 * EMLSR : 0xff indicates (BAND_AUTO) without DBDC
-		 */
-		req.roc[i].dbdcband = type == MT7925_ROC_REQ_JOIN ? 0xfe : 0xff;
+		req.roc[i].dbdcband =
+			mt7925_band_idx(&mvif->phy->dev->mt76, chan->band);
+		if (req.roc[i].dbdcband == 0xff)
+			/* STR : 0xfe indicates BAND_ALL with enabling DBDC
+			 * EMLSR : 0xff indicates (BAND_AUTO) without DBDC
+			 */
+			req.roc[i].dbdcband = type == MT7925_ROC_REQ_JOIN ?
+					      0xfe : 0xff;
 
 		if (chan->hw_value < center_ch)
 			req.roc[i].sco = 1; /* SCA */
@@ -1419,7 +1444,8 @@ int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 			.bw_from_ap = CMD_CBW_20MHZ,
 			.center_chan = center_ch,
 			.center_chan_from_ap = center_ch,
-			.dbdcband = 0xff, /* auto */
+			.dbdcband = mt7925_band_idx(&dev->mt76,
+						    chan->band),
 		},
 	};
 
@@ -1466,7 +1492,9 @@ int mt7925_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 			.len = cpu_to_le16(sizeof(struct roc_abort_tlv)),
 			.tokenid = token_id,
 			.bss_idx = mconf->mt76.idx,
-			.dbdcband = 0xff, /* auto*/
+			.dbdcband = mconf->mt76.band_idx <= 1 ?
+					    mconf->mt76.band_idx :
+					    0xff, /* auto */
 		},
 	};
 
@@ -2499,6 +2527,8 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 	basic_req->phymode_ext = mt7925_get_phy_mode_ext(phy, vif, band,
 							 link_sta);
 
+	mconf->mt76.band_idx = mt7925_band_idx(phy->dev, band);
+
 	if (band == NL80211_BAND_2GHZ)
 		basic_req->nonht_basic_phy = cpu_to_le16(PHY_TYPE_ERP_INDEX);
 	else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 6b9bf1b89032..2f908d159e30 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -63,6 +63,13 @@ enum mt7925_roc_req {
 	MT7925_ROC_REQ_NUM
 };
 
+static inline u8 mt7925_band_idx(struct mt76_dev *dev, enum nl80211_band band)
+{
+	if (is_mt7927(dev))
+		return band == NL80211_BAND_2GHZ ? 0 : 1;
+	return 0xff; /* auto-select for mt7925 */
+}
+
 enum {
 	UNI_EVENT_ROC_GRANT = 0,
 	UNI_EVENT_ROC_GRANT_SUB_LINK = 4,

-- 
2.53.0


