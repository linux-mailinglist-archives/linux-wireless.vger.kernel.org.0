Return-Path: <linux-wireless+bounces-32704-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJedOKd1q2lfdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32704-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:47:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C9F2291CE
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91C473055D90
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACEA292936;
	Sat,  7 Mar 2026 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="mmdpkpPN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zGdh/DSl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ED32DECC2;
	Sat,  7 Mar 2026 00:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843662; cv=none; b=kaa0kGXVpDTPwCsvfpvnTeT4/BsT+AhYYTcMOKJ7rIXYWy19y5D8Epf0UFkVfWuwQnT7Eb5CiCWG7AWBrdF6FNl7p2E+bhkde7OHtpfrOVJvoOTe49ZemNiAYO4n6ISMRXbbNIo8Z40xzYwPVXdSKySO21rEVb9ET8srOoWkS3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843662; c=relaxed/simple;
	bh=FBeFSy1I2Ej/Rmy+rPE0clpNt2XFsm4ZXHwh2cfDcfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=eOdQAZ4TYbb/LdnNBH9lP0uQq+rnpiSiDu7tga6flhs7MvauL8Ad16jLuAbp5PIPcAdx9REUXzEugfBAW65v0WMedTa8CCNoF2hyQQp+0g80QWmavfZheSFh4RXPdf1F2GWSgkaUWwAG+0vIDLzj++ojgSFeqQbec3Evfen4zaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=mmdpkpPN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zGdh/DSl; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 134921380A0D;
	Fri,  6 Mar 2026 19:34:20 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 19:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772843660;
	 x=1772850860; bh=z2sKP+4tUnUqyho0LMUgfgxbAgv1pZ1Bs689dh5tfZg=; b=
	mmdpkpPNc4Jcgpb16Mz+25WVFpP+t2y+G/oGZsCMMRSYi5m2gNOG/+r+b4/dFBg1
	lonz8TVj85habrjtK76LfrQuFkg/aF2HzGm6Hf6nRmWwD/xBlmrfmA8jVoc8hTNC
	I+mKPBUlrAAZ+RqnrEtpJxX9Kp0r2XZm6srhPleziBqDoEnQeNe03MJSxP1z3sXD
	Mg2nN48HUWLfosiOQor+fiuhpcyBkMxTIURY9xP5EJWIgNjcIrUKudPx2QniMMy0
	jPaTO+Onqt6K9E8hVMwXmgt78UQHJ3Ll5ZilkiescDLaWp3Vztb9pyg4Vc5gV1q/
	HxT9alY+2yOgF4WuRfo1mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772843660; x=
	1772850860; bh=z2sKP+4tUnUqyho0LMUgfgxbAgv1pZ1Bs689dh5tfZg=; b=z
	Gdh/DSlUxsI/Ebu6vvCL0tccBiw/WEFh6NbHwuE66CnMPDC+0pUMJweC4d6ivMQi
	//JuNCUjjCN8Na8LF7xz1qlRo2p3kRY6z5DEh6OkkT+XVWrxlK7PY4jK1s6U++0Z
	F87tc8QkHN7imNYxYNXr8HdTxUUbmpu4S/zq19c5LAa0SbfogGbflEU7p1dYkrb+
	xkEYdce7GE8F8/GMF+WurI6xaUCqKSPvsTbHTq4PqYYI9G0GhIpMb+PNY+la6bA0
	ADIBVHhfWGVG1zjO+AQ+G/39E5nB54OsVfHtma8TaiZmJzOoB5oCiha8csuGOiUf
	l6LOmKxJyFWTrwIXDdu3g==
X-ME-Sender: <xms:i3KraZe0OPeJOWQFgqdTqbfpiEMjzl6-8DhY8kU1YUlPkrTlV_LjrA>
    <xme:i3KraSBiJ37orFn0ecu-1soNnCP4QroyPZjKr6reMoBZnVwTMESa9SoqyBuuXPgSE
    TwUENjbGgFbULxVowx3nUtn3k-wkVQPbaZznehj424A89GPi1nEJyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepte
    egveefkeetvdfhteduueehgfehhfeiveeifeeflefgteeuhfelfeefjeeikeeunecuffho
    mhgrihhnpehmthejiedrsggrnhgunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhmvgdpnhgspghrtghpthhtohep
    vdefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhgvghlohhgihhorggttg
    hhihhnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohep
    feduleefieefudesghhmrghilhdrtghomhdprhgtphhtthhopehlohhonhhgrddtgidttd
    esghhmrghilhdrtghomhdprhgtphhtthhopegrrhhivghlrdhrohhsvghnfhgvlhgurdej
    hedtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrghpuhhishgurghrihhogeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhoshgrlheltdesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmrghtthhhihgrshdrsghgghesghhmrghilhdrtghomhdprhgtphhtth
    hopehrrgguohhirdgthhhrihhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrmhhu
    rdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:i3Kraaf2f_K6Y6VSlscKH0HWNNEcFx-Xe7DEblNDLRZCrMY_Uerrhw>
    <xmx:jHKraZECW26qXVvrYdLXfJLhzMunD0RvQ5pizBvJh9S6BvUyQYmCQw>
    <xmx:jHKraZFu5jT74CmkeAOFtG7QR9uv8edKfpBdeGPyIMhN7d1R6hgbuw>
    <xmx:jHKraaApwkXZpwJmCUpCQ8G5sWH7OGsW2cGV314_Z2bFGIJDOSrsbg>
    <xmx:jHKraa7YDZExUFPS7ZzyfSS2V6YUZI6H7cvOBtIMgGZQdfRVuSsFs736>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D708F1EA006B; Fri,  6 Mar 2026 19:34:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Fri, 06 Mar 2026 18:33:36 -0600
Subject: [PATCH 17/18] wifi: mt76: mt7925: fix MT7927 band_idx for stable
 5GHz/6GHz operation
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-mt7927-wifi-support-v1-17-c77e7445511d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9338; i=floss@jetm.me;
 h=from:subject:message-id; bh=FBeFSy1I2Ej/Rmy+rPE0clpNt2XFsm4ZXHwh2cfDcfU=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpq3JQAmTGAYZ1Kw0+vh2TGeLRcSnBukyEPv9rT
 ECRhIEqvjuJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCaatyUAAKCRC17sMLqGd3
 H3UbC/48nwqrnGIxLqPLNYK3/FvUvvar2et/x/UJGcfTxmHr6uYjPd4FIe521PxDI5UsZD782pg
 1mmK2m1t6WH+yXwCxDWPMvQIRIO3HVs2YmjB/AkOyyTiG4cJkVuNGozKI+nXJA+gRCEffbEuxBg
 60bZlbmZ4fEoxMZ1RPBhBUdlJA+RxfPNlS6q5iSFOVzlaqQ91oFMGOyTkHaUP1SJrKkfF/UHUDl
 15dW/8fMUyci5FvrVY+GzO9LYAB2iIEId7riEYfHUU1Ul4iVPzu0uerKtRwlC0r5dgzr/F3p62u
 jIfrksJrSpjDmqxl7QrNPDsSqCP+634eaj77ImOWXuVDJpONqiQ5kzu6PDO4Ro+3RJOCQtVX5Rn
 FNtkXmGYbXECCruR9rS71FWWW/d6y02jyZs/U5JqdiRel2GslLvnxz9WEW2cyokIMrBp53uBFtl
 5x5IoYuA4N6uiWKgJQfUddY/Ky6BSd5dqQbNiGdDYbVZ2KwG6vRfeIQrBuAkQM+J4yk1k=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
X-Rspamd-Queue-Id: E7C9F2291CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32704-lists,linux-wireless=lfdr.de];
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
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	NEURAL_SPAM(0.00)[0.704];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[humeurlibre.fr:email,messagingengine.com:dkim,lgic.pl:email,anthropic.com:email,jetm.me:dkim,jetm.me:email,jetm.me:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: add header
X-Spam: Yes

The MT7927 (Filogic 380) firmware requires explicit band_idx assignment
(0 for 2.4GHz, 1 for 5GHz/6GHz) instead of 0xff (auto-select) used by
MT7925. Without this, the firmware selects the wrong radio for 5GHz and
6GHz connections, causing WPA 4-way handshake timeout and data plane
failures on those bands.

Add mt7925_mt7927_hw_band_from_nl() helper to map nl80211_band to
hardware band index, and use it throughout the driver:

  - mac_link_bss_add: set band_idx from link channel at BSS creation
  - assign_vif_chanctx: update band_idx when channel context changes,
    resend DEV_INFO to firmware if band changed
  - bss_basic_tlv: set band_idx in BSS info sent to firmware
  - set_roc / set_mlo_roc / abort_roc: send concrete dbdcband instead
    of 0xff auto-select
  - roc_iter / roc_handle_grant: clamp invalid grant band_idx values
    using rfband as fallback, process grants for all MT7927 request
    types (not just JOIN)

All changes guarded by is_mt7927() - no impact on MT7925 behavior.

Originally discovered and fixed by marcin-fm; Loong0x00 contributed
additional improvements based on marcin-fm's patch.

Co-developed-by: Marcin FM <marcin@lgic.pl>
Signed-off-by: Marcin FM <marcin@lgic.pl>
Co-developed-by: 张旭涵 <Loong.0x00@gmail.com>
Signed-off-by: 张旭涵 <Loong.0x00@gmail.com>
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
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   | 40 +++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    | 54 ++++++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |  5 ++
 3 files changed, 87 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index f82c56c46324..fcb9f26c8b87 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -400,7 +400,24 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 
 	mconf->mt76.omac_idx = ieee80211_vif_is_mld(vif) ?
 			       0 : mconf->mt76.idx;
-	mconf->mt76.band_idx = 0xff;
+
+	if (is_mt7927(&dev->mt76)) {
+		struct ieee80211_channel *chan = NULL;
+
+		if (link_conf->chanreq.oper.chan)
+			chan = link_conf->chanreq.oper.chan;
+		else if (mvif->phy->mt76->chandef.chan)
+			chan = mvif->phy->mt76->chandef.chan;
+
+		if (chan)
+			mconf->mt76.band_idx =
+				mt7925_mt7927_hw_band_from_nl(chan->band);
+		else
+			mconf->mt76.band_idx = 0xff;
+	} else {
+		mconf->mt76.band_idx = 0xff;
+	}
+
 	mconf->mt76.wmm_idx = ieee80211_vif_is_mld(vif) ?
 			      0 : mconf->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
 	mconf->mt76.link_idx = hweight16(mvif->valid_links);
@@ -417,7 +434,8 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 
 	mlink->wcid.idx = idx;
 	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	mt76_wcid_init(&mlink->wcid, 0);
+	mt76_wcid_init(&mlink->wcid,
+		       mconf->mt76.band_idx == 0xff ? 0 : mconf->mt76.band_idx);
 
 	mt7925_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -2119,9 +2137,12 @@ static int mt7925_assign_vif_chanctx(struct ieee80211_hw *hw,
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
 
@@ -2137,6 +2158,21 @@ static int mt7925_assign_vif_chanctx(struct ieee80211_hw *hw,
 		mconf = &mvif->bss_conf;
 	}
 
+	old_band = mconf->mt76.band_idx;
+	if (is_mt7927(&dev->mt76) && ctx->def.chan) {
+		band_idx = mt7925_mt7927_hw_band_from_nl(ctx->def.chan->band);
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
index 8b5ffb240d52..3458aa8c79cb 100644
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
@@ -1378,10 +1399,15 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 		req.roc[i].center_chan2 = 0;
 		req.roc[i].center_chan2_from_ap = 0;
 
-		/* STR : 0xfe indicates BAND_ALL with enabling DBDC
-		 * EMLSR : 0xff indicates (BAND_AUTO) without DBDC
-		 */
-		req.roc[i].dbdcband = type == MT7925_ROC_REQ_JOIN ? 0xfe : 0xff;
+		if (is_mt7927(&mvif->phy->dev->mt76))
+			req.roc[i].dbdcband =
+				mt7925_mt7927_hw_band_from_nl(chan->band);
+		else
+			/* STR : 0xfe indicates BAND_ALL with enabling DBDC
+			 * EMLSR : 0xff indicates (BAND_AUTO) without DBDC
+			 */
+			req.roc[i].dbdcband = type == MT7925_ROC_REQ_JOIN ?
+					      0xfe : 0xff;
 
 		if (chan->hw_value < center_ch)
 			req.roc[i].sco = 1; /* SCA */
@@ -1419,7 +1445,9 @@ int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 			.bw_from_ap = CMD_CBW_20MHZ,
 			.center_chan = center_ch,
 			.center_chan_from_ap = center_ch,
-			.dbdcband = 0xff, /* auto */
+			.dbdcband = is_mt7927(&dev->mt76) ?
+				    mt7925_mt7927_hw_band_from_nl(chan->band) :
+				    0xff, /* auto */
 		},
 	};
 
@@ -1466,7 +1494,10 @@ int mt7925_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 			.len = cpu_to_le16(sizeof(struct roc_abort_tlv)),
 			.tokenid = token_id,
 			.bss_idx = mconf->mt76.idx,
-			.dbdcband = 0xff, /* auto*/
+			.dbdcband = is_mt7927(&dev->mt76) &&
+				    mconf->mt76.band_idx <= 1 ?
+				    mconf->mt76.band_idx :
+				    0xff, /* auto */
 		},
 	};
 
@@ -2495,6 +2526,9 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 	basic_req->phymode_ext = mt7925_get_phy_mode_ext(phy, vif, band,
 							 link_sta);
 
+	if (is_mt7927(phy->dev))
+		mconf->mt76.band_idx = mt7925_mt7927_hw_band_from_nl(band);
+
 	if (band == NL80211_BAND_2GHZ)
 		basic_req->nonht_basic_phy = cpu_to_le16(PHY_TYPE_ERP_INDEX);
 	else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index ba3d2c4de4ce..d3c89ea0afab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -63,6 +63,11 @@ enum mt7925_roc_req {
 	MT7925_ROC_REQ_NUM
 };
 
+static inline u8 mt7925_mt7927_hw_band_from_nl(enum nl80211_band band)
+{
+	return band == NL80211_BAND_2GHZ ? 0 : 1;
+}
+
 enum {
 	UNI_EVENT_ROC_GRANT = 0,
 	UNI_EVENT_ROC_GRANT_SUB_LINK = 4,

-- 
2.53.0


