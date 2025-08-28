Return-Path: <linux-wireless+bounces-26753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44729B39CDB
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 14:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0573DA000A8
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 12:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90E626A0B1;
	Thu, 28 Aug 2025 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="NsL3k/f7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CAA30FF3F
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383481; cv=none; b=eyThIoGYw+xf5z0I4MWe862pz3egFx0VKILx98b0kjzjUjDKAz8QSKMAs3CQGC4W5UvrMnscVkTSKj5I4k+SFSEoMo/x5ka/MVkfiMhV45QRiTdZdPKuQDCJ5b9rSuzI2fGBsQkxi9Oznr9XMRdzV2otgYX5ZcJM7nvOmJWUQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383481; c=relaxed/simple;
	bh=0UGs9fS0FbGA79p2lqf0nnsaKsGJV69NM4yZQXvun2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FF99sJhkSAWqfEZPvzQdzV1KU7uPvjEDOz/pPQ1VUpX43BDT21U3taMONWmIz0TYxIX+aav6Bzx41yHzZ9NCH595KqRVlgEaWuqufbGRqE4D6qXUqJssW+QzWDk2qlsIkHW9zF7HfBZw6UCB22pnhe2403tb5isP+goKaKVYD2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=NsL3k/f7; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kSNp+WYl19+YkA/hp1VvTTh79/httiy5gntorw3guFM=; b=NsL3k/f7MbvYXp3wg5kOh5YmiS
	/9wfadyNdkjmL5rSqi9bwVJkLmD9QTcgMPRWwJuRfBY6hYWtkB1a1VjXtGdSWGjd0hlNneBHSSAtX
	bKBg7aa0gSXuToUPD1b8GsyHdYDd5Hc/Rmgr5X2CywnsgA86h1Ucy/BdMn6Eaz/ab5Lw=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1urbZg-00GFXd-16;
	Thu, 28 Aug 2025 14:17:52 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH 2/2] wifi: mac80211: estimate expected throughput if not provided by driver/rc
Date: Thu, 28 Aug 2025 14:17:51 +0200
Message-ID: <20250828121751.78077-2-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828121751.78077-1-nbd@nbd.name>
References: <20250828121751.78077-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Estimate the tx throughput based on the expected per-packet tx time.
This is useful for mesh implementations that rely on expected throughput,
e.g. 802.11s or batman-adv.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/sta_info.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 8c550aab9bdc..3d2134abf23c 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2956,6 +2956,27 @@ static void sta_set_link_sinfo(struct sta_info *sta,
 	}
 }
 
+static u32 sta_estimate_expected_throughput(struct sta_info *sta,
+					    struct station_info *sinfo)
+{
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	struct ieee80211_local *local = sdata->local;
+	struct rate_info *ri = &sinfo->txrate;
+	struct ieee80211_hw *hw = &local->hw;
+	struct ieee80211_chanctx_conf *conf;
+	u32 duration;
+	u8 band = 0;
+
+	conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
+	if (conf)
+			band = conf->def.chan->band;
+
+	duration = ieee80211_rate_expected_tx_airtime(hw, NULL, ri, band, true, 1024);
+	duration += duration >> 4; /* add assumed packet error rate of ~6% */
+
+	return ((1024 * USEC_PER_SEC) / duration) * 8;
+}
+
 void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		   bool tidstats)
 {
@@ -3180,6 +3201,8 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_TDLS_PEER);
 
 	thr = sta_get_expected_throughput(sta);
+	if (!thr && (sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)))
+	    thr = sta_estimate_expected_throughput(sta, sinfo);
 
 	if (thr != 0) {
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT);
-- 
2.51.0


