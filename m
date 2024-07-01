Return-Path: <linux-wireless+bounces-9775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2F591E206
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 16:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6604FB20C32
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94F81607A1;
	Mon,  1 Jul 2024 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="jiorGqoZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611B91649BF
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843217; cv=none; b=fLOGymUSJ7dSd8KjPlRU6cbCpb02PDSAwwrtSfZqWoOQmMOUyNPTUQsSBIh501cqLdDRA/f0kzh6l48VRIg2o62UcjpRn5XLlZy4Gw7enepG1JFUoS8teafNWUSttXNr6uN6LQo0Xsda2FQHd6Mc9Mbv5AX5vT5a6TVOVSdMJFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843217; c=relaxed/simple;
	bh=cTgimfrWshSaIicjkqCEGFHqZbRJ6FxTuzES2KJI+uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoB5iAlhZTiLurfiMMH5uY9zaMR0Ekuj0jYP7bMwwZIjPbkm1bMXG+/GaoklBO5baSFLSWNrlraICyTLV4sEAzMsKHuKD+bP6HEtAMvS7TCJSm/P4yIApQ5wwC8tQfLoL4RyuOR9/AwWD/U6hMWc9WLISkDu6LyjVroG2fUjVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=jiorGqoZ; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Tojz4OudxD5DBp2PA2+KRIAkcR1dJrFxmA0POn6n400=; b=jiorGqoZi+CSQ84RJtKJ1bkpuA
	5XUXfU179hwSeNR5tKPC35Ju0uTOkYCkCe9C2Ith5clNJJ4y0tRWNEidk9lSTxTeO4huX9jFbeC0m
	68MtsTDJ9UrPCBkln05wkQVNYkPHRZFx5eoG0tI4weOmkOC1JjW2BjGxFUBobQytGNt8=;
Received: from p4ff13dca.dip0.t-ipconnect.de ([79.241.61.202] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sOHma-001Qfu-0J;
	Mon, 01 Jul 2024 16:13:28 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [PATCH v3 06/10] wifi: mac80211: add radio index to ieee80211_chanctx_conf
Date: Mon,  1 Jul 2024 16:13:21 +0200
Message-ID: <5e82c58a18e6684537415a5cfd17a55de90bdcbc.1719843147.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.a50ea6fd728e14cfdaafeb9cfac003364713c8e7.1719843147.git-series.nbd@nbd.name>
References: <cover.a50ea6fd728e14cfdaafeb9cfac003364713c8e7.1719843147.git-series.nbd@nbd.name>
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
index bd0f8aefa797..e78ccbe38d6d 100644
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
index 06a65dc6f6c6..6c4d02cb07bb 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -656,7 +656,8 @@ ieee80211_chanctx_radar_required(struct ieee80211_local *local,
 static struct ieee80211_chanctx *
 ieee80211_alloc_chanctx(struct ieee80211_local *local,
 			const struct ieee80211_chan_req *chanreq,
-			enum ieee80211_chanctx_mode mode)
+			enum ieee80211_chanctx_mode mode,
+			int radio_idx)
 {
 	struct ieee80211_chanctx *ctx;
 
@@ -674,6 +675,7 @@ ieee80211_alloc_chanctx(struct ieee80211_local *local,
 	ctx->conf.rx_chains_dynamic = 1;
 	ctx->mode = mode;
 	ctx->conf.radar_enabled = false;
+	ctx->conf.radio_idx = radio_idx;
 	_ieee80211_recalc_chanctx_min_def(local, ctx, NULL, false);
 
 	return ctx;
@@ -714,7 +716,7 @@ ieee80211_new_chanctx(struct ieee80211_local *local,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	ctx = ieee80211_alloc_chanctx(local, chanreq, mode);
+	ctx = ieee80211_alloc_chanctx(local, chanreq, mode, -1);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
@@ -1155,7 +1157,7 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 			    !list_empty(&curr_ctx->reserved_links))
 				return -EBUSY;
 
-			new_ctx = ieee80211_alloc_chanctx(local, chanreq, mode);
+			new_ctx = ieee80211_alloc_chanctx(local, chanreq, mode, -1);
 			if (!new_ctx)
 				return -ENOMEM;
 
-- 
git-series 0.9.1

