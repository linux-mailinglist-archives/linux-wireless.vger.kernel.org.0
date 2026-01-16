Return-Path: <linux-wireless+bounces-30912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ED1D33398
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 16:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27EDE310EA49
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B347D1EB5E3;
	Fri, 16 Jan 2026 15:31:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7F833A704
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577517; cv=none; b=rM/+k4WHnpST8eQjOCdYOZ1kXduhIZONfFSwqW3BR2FjZIJ9G96jhvhbRPR49Q3rmg/K6mW/ikAQDksEVhGOTNKhDeUua6yTcPJfVHMHB6wyM5DpFdW9cdvI5iiAtJ1McySkZug6HyZQJIWH5MV+srncUQ34XMhyr3aUGQCHSZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577517; c=relaxed/simple;
	bh=mM97t5kBs7wx1Gv3wjDrUVJJ5JJI6cTxGCxP8RdsEtk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=SrteKfVwgu5lFMhupNX8xcExl127JuDaHzidWDvVxP/MkyXfm1PecKaCYOgb0M9EiBt3ugf/CWPQHtFBjMJeSmq8+TiS7DDSMtWkIqWBJZMRpBdPTi3V9zic4Fsm5xDKffd7EpPkEyBNoLiHDqmv/NvxFqxfdYNW2VbvHdkKC/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 327BD127DC
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 16:31:43 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 26E5A1290F; Fri, 16 Jan 2026 16:31:43 +0100 (CET)
X-Spam-Level: 
X-Spam-Score: -1.0
Received: from sara (h-62-63-215-216.A163.priv.bahnhof.se [62.63.215.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id E6DF012831
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 16:31:41 +0100 (CET)
Date: Fri, 16 Jan 2026 16:31:41 +0100 (CET)
From: =?UTF-8?Q?Peter_=C3=85strand?= <astrand@lysator.liu.se>
To: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: wlcore: avoid oops when reading tsf from debugfs
Message-ID: <ac98f15b-4f6e-95c4-534d-583419068ce0@lysator.liu.se>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1474892827-1768577416=:328887"
Content-ID: <75cb0ccd-986e-1345-0604-a055723519c5@lysator.liu.se>
X-Virus-Scanned: ClamAV using ClamSMTP

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1474892827-1768577416=:328887
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <8371f99c-7786-7cdd-d497-a22f4bd312c1@lysator.liu.se>


In this case, read lock on dev_base_lock is active so calling pm_runtime_resume_and_get
or wl12xx_acx_tsf_info will cause Oops like:

[  182.282540] BUG: scheduling while atomic: cat/269/0x00000002

Signed-off-by: Peter Åstrand <astrand@lysator.liu.se>
---
 drivers/net/wireless/ti/wlcore/main.c     | 6 ++++++
 drivers/net/wireless/ti/wlcore/wlcore_i.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 12f0167d7380..1e368050e5d7 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -2338,6 +2338,7 @@ static int wl12xx_init_vif_data(struct wl1271 *wl, struct ieee80211_vif *vif)
 	wlvif->bitrate_masks[NL80211_BAND_2GHZ] = wl->conf.tx.basic_rate;
 	wlvif->bitrate_masks[NL80211_BAND_5GHZ] = wl->conf.tx.basic_rate_5;
 	wlvif->beacon_int = WL1271_DEFAULT_BEACON_INT;
+	wlvif->debug_tsf = ULLONG_MAX;
 
 	/*
 	 * mac80211 configures some values globally, while we treat them
@@ -4988,6 +4989,10 @@ static u64 wl1271_op_get_tsf(struct ieee80211_hw *hw,
 
 	wl1271_debug(DEBUG_MAC80211, "mac80211 get tsf");
 
+	/* Return cached value to debugfs */
+	if (!preemptible())
+		return wlvif->debug_tsf;
+
 	mutex_lock(&wl->mutex);
 
 	if (unlikely(wl->state != WLCORE_STATE_ON))
@@ -5000,6 +5005,7 @@ static u64 wl1271_op_get_tsf(struct ieee80211_hw *hw,
 	ret = wl12xx_acx_tsf_info(wl, wlvif, &mactime);
 	if (ret < 0)
 		goto out_sleep;
+	wlvif->debug_tsf = mactime;
 
 out_sleep:
 	pm_runtime_put_autosuspend(wl->dev);
diff --git a/drivers/net/wireless/ti/wlcore/wlcore_i.h b/drivers/net/wireless/ti/wlcore/wlcore_i.h
index 5bdcb341629c..1b9bb131f470 100644
--- a/drivers/net/wireless/ti/wlcore/wlcore_i.h
+++ b/drivers/net/wireless/ti/wlcore/wlcore_i.h
@@ -490,6 +490,9 @@ struct wl12xx_vif {
 	 */
 	u64 total_freed_pkts;
 
+	/* cached tsf for debugfs */
+	u64 debug_tsf;
+
 	/*
 	 * This struct must be last!
 	 * data that has to be saved acrossed reconfigs (e.g. recovery)
-- 
2.30.2


Br,
Peter Åstrand
--8323329-1474892827-1768577416=:328887--

