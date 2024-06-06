Return-Path: <linux-wireless+bounces-8638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 503968FF44A
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 20:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9157DB27309
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 18:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0734C199235;
	Thu,  6 Jun 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ULjHJ7UT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD271991D4
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697240; cv=none; b=XV5Ze7C6t7xzw8qplNDdhWYnrLmhUIa5hLOb6knt6vtgYvxP+MYKG8bzyGmzDwHXcs06MaiB+p0aQVW8P6GvczkmkuR9sJORVj21eUUfen3I9Q+FYSZnRMN2zrqegfcCZFR0qHA1WccG/ITpHW6omfmbFi7PAvdVcL83OhopME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697240; c=relaxed/simple;
	bh=L0xoNxB36J4Mx9116ONuACgOQV074hsWsLHXB/9Pxxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiTB40igJRSXp1R6+kTmOTnJPunpLJYipfswA79FwcIJ0tLukGmSPqPqpXS2ddS1NCj6ngrc4CW4u7MbK6umdA0myYHtm4ZMVrJTFCE6blwjdyMwVx6ekRL0QqmRTt1cH86BBMhIUHmHS/caoJ6BdGDgD9TTPSZIvYMC4iydGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ULjHJ7UT; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BnRLGsQdHzBIFwy2a7a4pMb4QdK2fWR40v5UFjKAhTw=; b=ULjHJ7UTrCEMtiY3HwI8TdXR17
	qG+upRIxSdNPWxbOmlJ08J7LmHVkIDB+dJEMWCyw4bUu2l0bAYBUE7A1sRWJA6Zaq//5rRP5ewaOK
	+cmY3zBQFkPCuMcpO8ZMdxzP86GDgrh/C4UHpdbn964txnnIH+Tc3uqsTqxCeRPl706A=;
Received: from p4ff130d0.dip0.t-ipconnect.de ([79.241.48.208] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFHW7-008aic-1I;
	Thu, 06 Jun 2024 20:07:15 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [RFC v3 5/8] wifi: mac80211: add radio index to ieee80211_chanctx_conf
Date: Thu,  6 Jun 2024 20:07:10 +0200
Message-ID: <2b389cf0e43d37b6d9225392cf82fa23fd3cc385.1717696995.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
References: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Will be used to explicitly assign a channel context to a wiphy radio.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h | 2 ++
 net/mac80211/chan.c    | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ecfa65ade226..98394970c991 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -250,6 +250,7 @@ struct ieee80211_chan_req {
  * @min_def: the minimum channel definition currently required.
  * @ap: the channel definition the AP actually is operating as,
  *	for use with (wider bandwidth) OFDMA
+ * @radio_idx: index of the wiphy radio used used for this channel
  * @rx_chains_static: The number of RX chains that must always be
  *	active on the channel to receive MIMO transmissions
  * @rx_chains_dynamic: The number of RX chains that must be enabled
@@ -264,6 +265,7 @@ struct ieee80211_chanctx_conf {
 	struct cfg80211_chan_def min_def;
 	struct cfg80211_chan_def ap;
 
+	int radio_idx;
 	u8 rx_chains_static, rx_chains_dynamic;
 
 	bool radar_enabled;
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index ec16d7676088..574ae961a7cf 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -638,7 +638,8 @@ ieee80211_chanctx_radar_required(struct ieee80211_local *local,
 static struct ieee80211_chanctx *
 ieee80211_alloc_chanctx(struct ieee80211_local *local,
 			const struct ieee80211_chan_req *chanreq,
-			enum ieee80211_chanctx_mode mode)
+			enum ieee80211_chanctx_mode mode,
+			int radio_idx)
 {
 	struct ieee80211_chanctx *ctx;
 
@@ -656,6 +657,7 @@ ieee80211_alloc_chanctx(struct ieee80211_local *local,
 	ctx->conf.rx_chains_dynamic = 1;
 	ctx->mode = mode;
 	ctx->conf.radar_enabled = false;
+	ctx->conf.radio_idx = radio_idx;
 	_ieee80211_recalc_chanctx_min_def(local, ctx, NULL);
 
 	return ctx;
@@ -696,7 +698,7 @@ ieee80211_new_chanctx(struct ieee80211_local *local,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	ctx = ieee80211_alloc_chanctx(local, chanreq, mode);
+	ctx = ieee80211_alloc_chanctx(local, chanreq, mode, -1);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
@@ -1126,7 +1128,7 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 			    !list_empty(&curr_ctx->reserved_links))
 				return -EBUSY;
 
-			new_ctx = ieee80211_alloc_chanctx(local, chanreq, mode);
+			new_ctx = ieee80211_alloc_chanctx(local, chanreq, mode, -1);
 			if (!new_ctx)
 				return -ENOMEM;
 
-- 
git-series 0.9.1

