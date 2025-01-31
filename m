Return-Path: <linux-wireless+bounces-18245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9994AA23FA5
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 16:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337C818855EE
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA871DFDA5;
	Fri, 31 Jan 2025 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="AfriKALW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882B1DE4E5;
	Fri, 31 Jan 2025 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738337292; cv=none; b=NZNo4S1cAThaGjzR19ST5NYuQAQwYE6cvoez3hkaSSw7mmMMAi2dZt6TDiGueH7VlSSuavnLa/mMDF0JwlHStwhXkPhWdjdwWblz/QMrl+g1gHD0Lp4Zmktagn1cQQ/UV+ICcrp/UqefQb9rRtiu05HSHCmq4J7DUF9t2oIyt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738337292; c=relaxed/simple;
	bh=54STAwR00ASCZCVJI5Yh67MWr1elOz6OEnFK+SgG8lE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q888X68oGJWMprMGGMV3WJ9wR7q7oGs5ItVJXykUbA/8BIMp09H5zfX6Kcg7iv4a29y+gpME4kQO8GdgkfJj12fIY3+m/F+wgAxy6eY6nOSS+y69TB+mqeUMBIp6eLeIrtw9m0uWDQbtWSYcihQsXBnMuJbDLI/cLsHpe4rm1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=AfriKALW; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 87766C0003;
	Fri, 31 Jan 2025 18:27:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 87766C0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1738337276; bh=rW23PiXK22C21obbkHYRPKanoYKTVhrnKD7lXE0kx14=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=AfriKALW6ufLeyw7rbLZLjiIQj61DNMRNbAB+ia8zI6aznLqL/+W1eW/gX5gKhEYy
	 MfWrF0pzfwZKTOOidEM1Efnvtd0CZkXZWinIUFtmZ+Rv2Xak5LQI3JXPZn6JvZCKEe
	 xt8ru3yQMpBEr7fwL5Ad+LY7cGkaRdcZrjvvxQVGkvXUZn4ypRLp24NUZEdTV8yZjV
	 RCjIfGF8m0gqmE6UrxFmLiT76ZLswQ13ad1AG8WrixvQWoxQ0D8r5rW1G2aV+sHrEv
	 srJmUvFqJcXXFU+5DryFVevBuFhl8avS8yN9tiaOuGGKAJ/Sjmpy6YtGF3895fn1eg
	 nLIxBkNReI9pw==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Fri, 31 Jan 2025 18:27:56 +0300 (MSK)
Received: from localhost.maximatelecom.ru (5.1.51.69) by mmail-p-exch01.mt.ru
 (81.200.124.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Fri, 31 Jan
 2025 18:27:54 +0300
From: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>, Michael Wu
	<flamingice@sourmilk.net>, "John W. Linville" <linville@tuxdriver.com>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>,
	<syzbot+2e5c1e55b9e5c28a3da7@syzkaller.appspotmail.com>
Subject: [PATCH v2] wifi: nl80211: reject cooked mode if it is set along with other flags
Date: Fri, 31 Jan 2025 20:26:55 +0500
Message-ID: <20250131152657.5606-1-v.shevtsov@mt-integration.ru>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch01.mt.ru
 (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected, bases: 2025/01/31 14:37:00
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 50 0.3.50 df4aeb250ed63fd3baa80a493fa6caee5dd9e10f, {rep_avail}, {Tracking_one_url, url3}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 81.200.124.61:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;ksmg01.maxima.ru:7.1.1;mt-integration.ru:7.1.1;syzkaller.appspot.com:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 190721 [Jan 31 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/01/31 13:26:00 #27170191
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/01/31 14:37:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

It is possible to set both MONITOR_FLAG_COOK_FRAMES and MONITOR_FLAG_ACTIVE
flags simultaneously on the same monitor interface from the userspace. This
causes a sub-interface to be created with no IEEE80211_SDATA_IN_DRIVER bit
set because the monitor interface is in the cooked state and it takes
precedence over all other states. When the interface is then being deleted
the kernel calls WARN_ONCE() from check_sdata_in_driver() because of missing
that bit.

Fix this by rejecting MONITOR_FLAG_COOK_FRAMES if it is set along with
other flags.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 66f7ac50ed7c ("nl80211: Add monitor interface configuration flags")
Reported-by: syzbot+2e5c1e55b9e5c28a3da7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2e5c1e55b9e5c28a3da7
Signed-off-by: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
---
v2: update patch name and description,
    reject cooked mode if the one is set along with other flags.

 net/wireless/nl80211.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d7d3da0f6833..fdb2aac951d1 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4220,6 +4220,11 @@ static int parse_monitor_flags(struct nlattr *nla, u32 *mntrflags)
 		if (flags[flag])
 			*mntrflags |= (1<<flag);
 
+	/* cooked monitor mode is incompatible with other modes */
+	if (*mntrflags & MONITOR_FLAG_COOK_FRAMES &&
+	    *mntrflags != MONITOR_FLAG_COOK_FRAMES)
+		return -EOPNOTSUPP;
+
 	*mntrflags |= MONITOR_FLAG_CHANGED;
 
 	return 0;
-- 
2.48.1


