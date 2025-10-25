Return-Path: <linux-wireless+bounces-28255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25143C09758
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19A03AEAB4
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201D730C60C;
	Sat, 25 Oct 2025 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDvbFg6k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F03090F7;
	Sat, 25 Oct 2025 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409129; cv=none; b=jqwj1bavP6nmTImPPWnL4qYDOnC4fodOtCxd+t4bhH6vRTCB2K7CPpNsOJyEXvhZJrw+tesYxsg8B6LoKdiNlXyNoUFeWSkkfS18hq8FDTYr3oXHkCsL2OOcpcSK1VNPXnoGcnKthM90Sq0n5bT377aHgOvTgzXV2kNw4BBC9L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409129; c=relaxed/simple;
	bh=eZtBbOBL0b4kmGXZubuxk4FnOOlr3qqqWwl+rHIVSro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7zKYrLM0si9oOIz4++F2kTJtm3zkM14kQpHeZUb4wpr+WS4oTAksEWKYraAbnrDtqialg0SHcsgPtbCuhSdsr7fj7/fuRucHG7HWWO+/xvQS3MjQevC/DukpEFlI2zCiYO10vPFtw8jfARJcyhqIYcRZPrnPp8z7Ene3vYR06I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDvbFg6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3E9C4CEF5;
	Sat, 25 Oct 2025 16:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409128;
	bh=eZtBbOBL0b4kmGXZubuxk4FnOOlr3qqqWwl+rHIVSro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uDvbFg6kj/dEgBVtdECVcBJlj1aZgL1NDSfj2VU8aimp1Ik42GU9p2ylg+uFvPaGA
	 GHZAx/64OrfpbTKZYbG5qlj5CMpnE1/6v5s1UKHm7C6eWMz9RFl9l52TYwRsLuVg7q
	 0rsjtRAGbvIpcmC3luGgrhXOoh9g3BZ6BycmImfA0HmRjVAJBHQKDe+GEIG5YJh2rd
	 jfxrLxsPyk4CLcwkvlLSN0C8gt8bmogtZSCJJzmQT8vnFUlESYoVWbVkSKUrdfMP+l
	 1X0YlRhwtqd2fF+A/8YnRgv0ravhhOwBBAo10D1PTiwEAZ1CV6JZ6Oym97Gqu8b1Pg
	 9A8zhNjhQ4BUQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kuan-Chung Chen <damon.chen@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] wifi: rtw89: fix BSSID comparison for non-transmitted BSSID
Date: Sat, 25 Oct 2025 11:57:22 -0400
Message-ID: <20251025160905.3857885-211-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kuan-Chung Chen <damon.chen@realtek.com>

[ Upstream commit c4c16c88e78417424b4e3f33177e84baf0bc9a99 ]

For non-transmitted connections, beacons are received from the
transmitted BSSID. Fix this to avoid missing beacon statistics.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250811123950.15697-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

Explanation

- What it fixes
  - In rtw89, beacon frames are filtered per-VIF by comparing the frame
    BSSID (`iter_data->bssid`) to `bss_conf->bssid`. Today that check is
    unconditional, so when associated to a nontransmitted BSSID in an
    MBSSID set, beacons sent by the transmitter BSSID never match and
    the driver drops out before updating beacon-related stats. See the
    unconditional check at
    drivers/net/wireless/realtek/rtw89/core.c:2276.
  - As a result, the driver silently misses key updates triggered only
    for beacons: TSF sync, RSSI EWMA for beacons, beacon bandwidth
    index, beacon-rate sampling and the beacon counter. These are all
    under the beacon-handling block starting at
    drivers/net/wireless/realtek/rtw89/core.c:2284 (e.g.,
    `rtw89_vif_sync_bcn_tsf`, `rtw89_fw_h2c_rssi_offload`,
    `ewma_rssi_add`, `pkt_stat->beacon_nr++`).
  - The commit teaches the driver to, for beacon frames only, compare
    against `bss_conf->transmitter_bssid` when
    `bss_conf->nontransmitted` is true; otherwise fall back to
    `bss_conf->bssid`. This matches 802.11 MBSSID behavior where the
    TxBSSID transmits the beacon for nontransmitted profiles. The new
    `target_bssid` logic is inserted next to `const u8 *bssid =
    iter_data->bssid;` at drivers/net/wireless/realtek/rtw89/core.c:2254
    and replaces the unconditional comparison at
    drivers/net/wireless/realtek/rtw89/core.c:2276.

- Why it’s correct
  - mac80211 already models MBSSID with `bss_conf->nontransmitted` and
    `bss_conf->transmitter_bssid` (include/net/mac80211.h:812,
    include/net/mac80211.h:814). Using the transmitter BSSID only for
    beacons when on a nontransmitted BSSID is the correct interpretation
    of the spec and consistent with how other drivers behave.
  - Cross-driver precedent: ath12k selects `transmitter_bssid` when
    `nontransmitted` for station links
    (drivers/net/wireless/ath/ath12k/mac.c:633), reinforcing that this
    pattern is standard.

- Scope and risk
  - Change is small and self-contained: one extra `const u8
    *target_bssid` and a conditional selection for the comparison in a
    single function (`rtw89_vif_rx_stats_iter`).
  - It only affects handling of beacon frames and only when
    `nontransmitted` is true. All other frames and the general
    comparison path remain unchanged, minimizing regression risk.
  - No API/ABI or architectural changes; it uses existing mac80211
    fields present in 6.17 (include/net/mac80211.h:812,
    include/net/mac80211.h:814).

- User impact
  - Without this, associated stations on nontransmitted BSSIDs miss
    beacon-derived stats (TSF sync, RSSI EWMA, beacon counters/rates),
    which can degrade link monitoring, roaming decisions, and power
    behavior.
  - With this fix, rtw89 correctly accounts beacons for such
    connections, restoring expected functionality.

- Stable backport criteria
  - Important bugfix with user-visible impact: YES.
  - Small and contained change: YES (one function, a few lines).
  - No new features or interface changes: YES.
  - Minimal regression risk: YES.
  - Confined to a driver subsystem: YES (rtw89 only).
  - Explicit stable tag not present, but the nature of the fix fits
    stable policy.

Given the above, this is a good candidate for backporting to stable
trees that have rtw89 and MBSSID support (e.g., 6.17.x and other
maintained series with these fields and code paths).

 drivers/net/wireless/realtek/rtw89/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 5dd05b296e71c..0f7a467671ca8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2246,6 +2246,7 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	struct ieee80211_bss_conf *bss_conf;
 	struct rtw89_vif_link *rtwvif_link;
 	const u8 *bssid = iter_data->bssid;
+	const u8 *target_bssid;
 
 	if (rtwdev->scanning &&
 	    (ieee80211_is_beacon(hdr->frame_control) ||
@@ -2267,7 +2268,10 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 		goto out;
 	}
 
-	if (!ether_addr_equal(bss_conf->bssid, bssid))
+	target_bssid = ieee80211_is_beacon(hdr->frame_control) &&
+		       bss_conf->nontransmitted ?
+		       bss_conf->transmitter_bssid : bss_conf->bssid;
+	if (!ether_addr_equal(target_bssid, bssid))
 		goto out;
 
 	if (is_mld) {
-- 
2.51.0


