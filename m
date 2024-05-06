Return-Path: <linux-wireless+bounces-7237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208A28BD535
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52C21F22B6C
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844311591F1;
	Mon,  6 May 2024 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="G+6bbI85"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAC615572C
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022643; cv=none; b=bMxe92m10E3fq5U5+vBbAJGnNhQdjA9Lv3m0A3BRgqB2e3cL9SUYr1+5Au8tuiMS6iVdB3B1mr0AwP16EjPpnqZKicIr4tokVW42Kk/iFfRtS+5/FHwEvlIVQouEYnTFD3Do+zmw56s9D/7PWg0NpulD4XKU/H7X6up0TeSmwYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022643; c=relaxed/simple;
	bh=gGXhPP90yeHFvktdUR2v5tNk1s/+rUuhxsStnwLtvhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MrJSds7UhpuLMkcT8iXIJGpBg4HVUKxnUquXTS/xdp1rKSdMwxKCBWZ4v2I1VL5mnMZXdhPR49lYGuuEAyAg/gFzQh88xFekTwRjTegHRa1FhaPWoi5n+BTkh7LNaZImICPS+pzUqPTTSuT1SL1oYOlxffq6s3zuLZOwO1lA/5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=G+6bbI85; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=zUkCLm9OfxbR+Ki1x7eaABorT4P2VsGMjl6gM2Zxuf8=; t=1715022640; x=1716232240; 
	b=G+6bbI856TaCwoe0d9ADe6MB0uo8Wl2/Or4Y2gmYjzLLdyk4PhHmXqSkFSviWZp9osu3biUT1TY
	HdolYpVT7ICT//Q4EQKC7WQqYet5QAu52SM+5bAHTkYuJ//XcITdCIF9933rNpnB+BiHIR0k/HOQ0
	AcyGEpguq71WgQLpTDY+2fPJcA3tf1ypUULJERDW0xR7A0gmsQf9z7u9apPKMZon7tarGtVK8VUXj
	y+HqNA8QtbSymUKc3dSxG3lOQ43dZYg+V4TsCSzilCgHOs8HwG+ZjLh3sjkvwbRnwX1XjaqUJhKzd
	V2k6Mdj+i9OxpDA5engLLh9fSk+fdf35z6Aw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s43jQ-000000089kh-3voZ;
	Mon, 06 May 2024 21:10:37 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 1/3] wifi: mac80211: cancel multi-link reconf work on disconnect
Date: Mon,  6 May 2024 21:10:33 +0200
Message-ID: <20240506211034.ac754794279f.Ib9fbb1dab50c6b67f6de9be09a6c452ce89bbd50@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This work shouldn't run after we're disconnecting. Cancel it earlier
(and then don't cancel it in stop later.)

Fixes: 8eb8dd2ffbbb ("wifi: mac80211: Support link removal using Reconfiguration ML element")
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a5f2d3cfe60d..49bcd800bdca 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3289,6 +3289,11 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 				  &ifmgd->neg_ttlm_timeout_work);
+
+	sdata->u.mgd.removed_links = 0;
+	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+				  &sdata->u.mgd.ml_reconf_work);
+
 	ieee80211_vif_set_links(sdata, 0, 0);
 
 	ifmgd->mcast_seq_last = IEEE80211_SN_MODULO;
@@ -8708,8 +8713,6 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 			  &ifmgd->teardown_ttlm_work);
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 				  &ifmgd->tdls_peer_del_work);
-	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
-				  &ifmgd->ml_reconf_work);
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 				  &ifmgd->neg_ttlm_timeout_work);
-- 
2.44.0


