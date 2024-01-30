Return-Path: <linux-wireless+bounces-2850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 789AC842B77
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 19:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1351F2584C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 18:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5AB151CC4;
	Tue, 30 Jan 2024 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="jTGVBHed"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D858612D
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638135; cv=none; b=skDc2+wQ9rJPRuCE5BsNupQ0/GEG2kEMXRZfp1K7XoH+/shu/gnIBw58Lu0Nc+3ihuj7E87KDkFopkmhWKdB+wHGCLexnIFSGj0DuUNOlDfuMTLaAi+vOZ2sB6MVQmMg16SYcuU8HomnBZC13TPWMiPrYj3Lp5sIAkr71TUusRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638135; c=relaxed/simple;
	bh=hirXS9P95TZ1txLBVVJE58YC3yxQ/S/QWBJR8BjxY4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QPAMZSVvXdXzdmeHXTBu7d7wBSbhZBZPXxyA0grtyGjFJoPhJ8kiKj9kvujTd6swSGXCABITUWcDYpmsD1THSZYAXntk66q0bD6UF1XZFikVKQdOfuRHB/mh7LPRotU4V0sdtwcap7JBbhOgohEudfvUs4Bu2++Pf1hpL7c1Rh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=jTGVBHed; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 117A99C008F
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 18:08:50 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 47F7813C2B0;
	Tue, 30 Jan 2024 10:08:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 47F7813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1706638130;
	bh=hirXS9P95TZ1txLBVVJE58YC3yxQ/S/QWBJR8BjxY4Y=;
	h=From:To:Cc:Subject:Date:From;
	b=jTGVBHedTdpsxaUCc/Lth0xgymVLIQBlNhLI2mWf43mBYJn50UrdOAnAkDZq8dTtg
	 RCeIR+k/ABx6WDH7g1MC6EVHZl0yIilZqZww4v5hfUJcR7Be1j6x9klGxYcCBC/pLD
	 LpeCHiBfIkLVnedtdKDi10keyy0b4SstrWBpAC88=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mac80211:  Ensure bss-coloring is always configured
Date: Tue, 30 Jan 2024 10:08:48 -0800
Message-ID: <20240130180848.776867-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1706638131-oA4s7Bf6UaUO
X-MDID-O:
 us5;at1;1706638131;oA4s7Bf6UaUO;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

Old code would not set it to disabled, just assumed that driver
would default to disabled.  Change this to explicitly request
bss color be flushed on initial driver configuration.

And I think the beacon-change logic was slightly wrong, so adjust
that as well.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/cfg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 1c7fb0959cfd..1a6c6c764cbc 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1331,8 +1331,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
 		changed |= BSS_CHANGED_HE_OBSS_PD;
 
-		if (params->beacon.he_bss_color.enabled)
-			changed |= BSS_CHANGED_HE_BSS_COLOR;
+		changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
 	if (params->he_cap) {
@@ -1512,6 +1511,7 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	int err;
 	struct ieee80211_bss_conf *link_conf;
 	u64 changed = 0;
+	bool color_en;
 
 	lockdep_assert_wiphy(wiphy);
 
@@ -1549,9 +1549,9 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 		return err;
 	changed |= err;
 
-	if (beacon->he_bss_color_valid &&
-	    beacon->he_bss_color.enabled != link_conf->he_bss_color.enabled) {
-		link_conf->he_bss_color.enabled = beacon->he_bss_color.enabled;
+	color_en = beacon->he_bss_color.enabled && beacon->he_bss_color_valid;
+	if (color_en != link_conf->he_bss_color.enabled) {
+		link_conf->he_bss_color.enabled = color_en;
 		changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
-- 
2.41.0


