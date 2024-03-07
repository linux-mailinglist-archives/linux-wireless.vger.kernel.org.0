Return-Path: <linux-wireless+bounces-4464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B828755D3
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 19:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 796ADB20EF4
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 18:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5E81EB41;
	Thu,  7 Mar 2024 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="CTx6ZrRg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84166131E21
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 18:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835066; cv=none; b=leBNODOjzmCnWGrExTc+TJyaVsSYuAYTJAQD1ZXw1/OhzaCIm9lD2pfHqavmKu0Ts7/p0hOJjj03N0f8Ym4pnbrVOw05aYw04VVWzmxCXyi7+AaKU1+WdOA+oRAcY1lBtHSXvwacmEppeOM8yUT+8B6sRy5C/vRXjpSn7iokHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835066; c=relaxed/simple;
	bh=r8w0jxoIxEBMmPbvMRnvhHSdH7fEeRNFxJby4ghsCTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MKfb9MQU76r0DO809W7eiFZSwqhjhPQXmKWtObqOTo/h0/bwohWp5CGIS4D7Y4hN7e82UOrFruiYFbZ1DsEpwqexVfnDl3ZXm2drfWBod0wggeJnrK/hY3OBJnUKIP7UzYZiP60tLkBWTHaP1ze/aGOwtWrYcLixN18+HEsjWZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=CTx6ZrRg; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 19E3250007C
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 18:10:55 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 8A5CE13C2B0;
	Thu,  7 Mar 2024 10:10:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8A5CE13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709835054;
	bh=r8w0jxoIxEBMmPbvMRnvhHSdH7fEeRNFxJby4ghsCTE=;
	h=From:To:Cc:Subject:Date:From;
	b=CTx6ZrRgfk8R2pqKuzM64YUsMyqKHl8vgj2CUq576Ne4zk8rhRdr3pM/qckZXF8vH
	 guQc79KnuXeoX3hLI9kNZqxKsjWFehslhfueaMtHzW5fq3ufnEW+J0QcEaBjez/dSq
	 fBF4WGPEp/UFL0dbjROubm7j+b6psuWPeK2PAb0Q=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: mac80211:  Improve bss-color configuration.
Date: Thu,  7 Mar 2024 10:10:39 -0800
Message-ID: <20240307181039.3219840-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1709835055-p8pEwi970ox3
X-MDID-O:
 us5;ut7;1709835055;p8pEwi970ox3;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

Always tell driver to apply bss color settings if beacon indicates
the bss coloring has been set.

And only enable bss coloring if beacon indicates bss color setting
is valid and also enabled.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/cfg.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 327682995c92..aaa62c05428c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1314,7 +1314,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
 		changed |= BSS_CHANGED_HE_OBSS_PD;
 
-		if (params->beacon.he_bss_color.enabled)
+		if (params->beacon.he_bss_color_valid)
 			changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
@@ -1494,6 +1494,7 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	int err;
 	struct ieee80211_bss_conf *link_conf;
 	u64 changed = 0;
+	bool color_en;
 
 	lockdep_assert_wiphy(wiphy);
 
@@ -1530,9 +1531,9 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	if (err < 0)
 		return err;
 
-	if (beacon->he_bss_color_valid &&
-	    beacon->he_bss_color.enabled != link_conf->he_bss_color.enabled) {
-		link_conf->he_bss_color.enabled = beacon->he_bss_color.enabled;
+	color_en = beacon->he_bss_color.enabled && beacon->he_bss_color_valid;
+	if (color_en != link_conf->he_bss_color.enabled) {
+		link_conf->he_bss_color.enabled = color_en;
 		changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
-- 
2.42.0


