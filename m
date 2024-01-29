Return-Path: <linux-wireless+bounces-2708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E12841311
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25941C20AF5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8258F76C85;
	Mon, 29 Jan 2024 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Sokao2ad"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC8C2E85E
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555353; cv=none; b=g3g1+Blx/iMQQ3vmeM3+sJLeXdGyEA7bkufdNtwc2++B+V4aA9whQ7jJ5k6Ir5cqt6QOedt/64iomtczeRFOB9UVhh8MpkwCG37ESkyiwjUveuTTA4qJxaPajUctDo5BqmK2r0y45VNbm6ikMIlt4/9nX2sAVzacnJTtOjIGbGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555353; c=relaxed/simple;
	bh=g2YFWJy0F/HWEKhA/D4xF03WqzUAxCYsJMcOCDa0TC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U1LvRbEIHnNK/TtWiJg++8GAu5pbOcPJ47koMEF2yma5YKB8DLM8oPh1bY0ghUVTqnRpr7BJHTqjpUrYxmNaMNO5twFJTkABVyq2+OY1JwLBKsc9daw59MF0+rk2Zujd7vvgSBdxjAXNLN3xKftgzUow0y1ZCDRvdYwu2TbFCWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Sokao2ad; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=VmBnKlxSE1grhGs4+weDEjEfahkvqQF9Ye1eYlXBETo=; t=1706555352; x=1707764952; 
	b=Sokao2adLR8KLVpNs403ZTzMVcE9R2BUWTDdGPyIYU2OLMroLk3ItwiIZMR+zlgPns/FxyUu8i5
	cIoREQzOefywKqBkdrwiPTYTO4tUrc0bC7CO+qOCLcdK2WfI4UrkJGUlKcF1iObcCY+LgLfPqMBvh
	ftyj/b+DDWKjvSzxSnT6RXBeXOYksyE8yn6h95VJQnIxTvkTZIPvLR/hCNTxTnM8Ntnt128csxpB4
	6f+RWmfCFWgyKlgX47+gGiljxunpVhwSuwNLgHSwt5NwoKGDwm7E9ye1QEg69hIahoxQuGrTLlPxm
	qWMvtggA9U4Ny4buRrad64G32uuKzrQeoIvQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUX0H-000000050Gb-0TKt;
	Mon, 29 Jan 2024 20:09:09 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: accept broadcast probe responses on 6 GHz
Date: Mon, 29 Jan 2024 20:09:07 +0100
Message-ID: <20240129200907.5a89c2821897.I92e9dfa0f9b350bc7f37dd4bb38031d156d78d8a@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

On the 6 GHz band, probe responses are sent as broadcast to
optimise medium usage. However, without OCE configuration
we weren't accepting them, which is wrong, even if wpa_s is
by default enabling OCE. Accept them without the OCE config
as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/scan.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 645355e5f1bc..f9d5842601fa 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
  * Copyright 2016-2017  Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 #include <linux/if_arp.h>
@@ -237,14 +237,18 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 }
 
 static bool ieee80211_scan_accept_presp(struct ieee80211_sub_if_data *sdata,
+					struct ieee80211_channel *channel,
 					u32 scan_flags, const u8 *da)
 {
 	if (!sdata)
 		return false;
-	/* accept broadcast for OCE */
-	if (scan_flags & NL80211_SCAN_FLAG_ACCEPT_BCAST_PROBE_RESP &&
-	    is_broadcast_ether_addr(da))
+
+	/* accept broadcast on 6 GHz and for OCE */
+	if (is_broadcast_ether_addr(da) &&
+	    (channel->band == NL80211_BAND_6GHZ ||
+	     scan_flags & NL80211_SCAN_FLAG_ACCEPT_BCAST_PROBE_RESP))
 		return true;
+
 	if (scan_flags & NL80211_SCAN_FLAG_RANDOM_ADDR)
 		return true;
 	return ether_addr_equal(da, sdata->vif.addr);
@@ -293,6 +297,12 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 		wiphy_delayed_work_queue(local->hw.wiphy, &local->scan_work, 0);
 	}
 
+	channel = ieee80211_get_channel_khz(local->hw.wiphy,
+					    ieee80211_rx_status_to_khz(rx_status));
+
+	if (!channel || channel->flags & IEEE80211_CHAN_DISABLED)
+		return;
+
 	if (ieee80211_is_probe_resp(mgmt->frame_control)) {
 		struct cfg80211_scan_request *scan_req;
 		struct cfg80211_sched_scan_request *sched_scan_req;
@@ -310,19 +320,15 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 		/* ignore ProbeResp to foreign address or non-bcast (OCE)
 		 * unless scanning with randomised address
 		 */
-		if (!ieee80211_scan_accept_presp(sdata1, scan_req_flags,
+		if (!ieee80211_scan_accept_presp(sdata1, channel,
+						 scan_req_flags,
 						 mgmt->da) &&
-		    !ieee80211_scan_accept_presp(sdata2, sched_scan_req_flags,
+		    !ieee80211_scan_accept_presp(sdata2, channel,
+						 sched_scan_req_flags,
 						 mgmt->da))
 			return;
 	}
 
-	channel = ieee80211_get_channel_khz(local->hw.wiphy,
-					ieee80211_rx_status_to_khz(rx_status));
-
-	if (!channel || channel->flags & IEEE80211_CHAN_DISABLED)
-		return;
-
 	bss = ieee80211_bss_info_update(local, rx_status,
 					mgmt, skb->len,
 					channel);
-- 
2.43.0


