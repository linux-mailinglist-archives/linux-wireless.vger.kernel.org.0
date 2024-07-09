Return-Path: <linux-wireless+bounces-10100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6454F92B145
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 09:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAA128251F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 07:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CB713BC30;
	Tue,  9 Jul 2024 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="kubutPiP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9469A14534C
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510563; cv=none; b=IRE5roKvu6BIOYYYq6zkS2AIUJCA9QuruXJzfZR5OyXybIS430YMVzgCwFQ9L9l7PDOx7+XxY3oFzL/CLlqI8jhdpEQq3uBL3gkfI7Ly49/SkPkBrSZgpQxhlWkElpojJBW6CCryHC+q6tHRIfxHhRFadzYI4CCx5RT7kDfpX74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510563; c=relaxed/simple;
	bh=AkA4yKvw9Z+PNExFNMH6Alu8digK21EXy6pWT2EbeaA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VuCFb1EGK9AEGL83z/mFGIi5OOBC9IFfdM4XZ/V+0Sy3JAqHVNzRbNZrKmJiJrjMl71fWyKD2aY4uTW6awqd9LfRvP3X7vEn/AamTXED5M0XOdsh6Ex0GktklHfmODLxFR3sV6CW0F8HXICTY3W2Ps0q1Mtz5J9BHO9JGtP80qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=kubutPiP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4697ZabqE483122, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720510536; bh=AkA4yKvw9Z+PNExFNMH6Alu8digK21EXy6pWT2EbeaA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=kubutPiPzrdqsHgY09QwTWWL3/sbfMADDKzlrDYxoeKlx5SdDO/dmMBm8Qqn0d7t7
	 uo7XbnZ43iUG7iwJGKSCLJga6i7gj8LQjDllgKB8u6+AOJsX/YoSe9eEzkTlONk4L2
	 CXccTel6cNLBl5v2TVTkjWE2yOe/MubSOTGSrDmJngSysknviD1KCajjBYyRd6c1WI
	 RILVQs9Bi/Iq3FmbdwzxYFl7pj2z5m3yn58wI3GojcMUeitMSl8nN3FnvdAxxk6qWE
	 qEaZ0fM65XANSoDQ1obJD7QTqozy89YEnF8Jx8j8HlS9NMRF25geemLct25G3Q7HT3
	 qVhdprRbAt9jQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4697ZabqE483122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 15:35:36 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 15:35:37 +0800
Received: from localhost.localhost (172.21.69.104) by RTEXMBS03.realtek.com.tw
 (172.21.6.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 9 Jul
 2024 15:35:36 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: mac80211: chanctx emulation set CHANGE_CHANNEL when in_reconfig
Date: Tue, 9 Jul 2024 15:35:31 +0800
Message-ID: <20240709073531.30565-1-kevin_yang@realtek.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Chanctx emulation didn't info IEEE80211_CONF_CHANGE_CHANNEL to drivers
during ieee80211_restart_hw (ieee80211_emulate_add_chanctx). It caused
non-chanctx drivers to not stand on the correct channel after recovery.
RX then behaved abnormally. Finally, disconnection/reconnection occurred.

So, set IEEE80211_CONF_CHANGE_CHANNEL when in_reconfig.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
---
 net/mac80211/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 7578ea56c12f..85a267bdb3e3 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -148,7 +148,7 @@ static u32 ieee80211_calc_hw_conf_chan(struct ieee80211_local *local,
 	offchannel_flag ^= local->hw.conf.flags & IEEE80211_CONF_OFFCHANNEL;
 
 	/* force it also for scanning, since drivers might config differently */
-	if (offchannel_flag || local->scanning ||
+	if (offchannel_flag || local->scanning || local->in_reconfig ||
 	    !cfg80211_chandef_identical(&local->hw.conf.chandef, &chandef)) {
 		local->hw.conf.chandef = chandef;
 		changed |= IEEE80211_CONF_CHANGE_CHANNEL;
-- 
2.39.0


