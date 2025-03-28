Return-Path: <linux-wireless+bounces-20903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDFDA741FA
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 02:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816F63B6508
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 01:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71DA15746E;
	Fri, 28 Mar 2025 01:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="hdzrZCD+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B835537F8;
	Fri, 28 Mar 2025 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743124606; cv=none; b=Hyjr5mQ4XX9ZPzsQKcwNjMnqLaArA255b6bWUH/UcDiL7DztQCePTqhptdFlArUR7sVlrP4NpAUTEjPLedILOkk9RaFd5VDBxolct2OvGQUYvLN0V4xEe0ptMFwBwSsrG8wNf9ml57cBzfTMBnGWxBmKYIqgsqt1B95rL/i8Uxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743124606; c=relaxed/simple;
	bh=7mFZoI3oUwSgsrtXYgoQO4zWvGggFBPc0QqMqh4qw+A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lnfoGam3AYZqHxKJ3SN5D5aKKhgqgqeEiAfz17vfHtYq6cytsEzgu08QarDuHEZq1MQiQ6vpDJCTbBqRSj54azNoEiObiB4XOo5dujlhTHEUJafINFPbNh5rrGk5BySQukbtuYAx43UkY6IoC+2a9JTxY3BT/KfIGX1D8NNzG8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=hdzrZCD+; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 2E78CC0006;
	Fri, 28 Mar 2025 04:16:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 2E78CC0006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743124599; bh=Kl/vgxvkF6dodXZC7H99NoGlSRboIwJ+apzfaBVvyhU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=hdzrZCD+3zDPhxnZFcNkUbYYdjSZw7+VmbBOOHzyAS/FV9mcVY1qtHTQaEU75SRDN
	 jkXQy41Fqr8CP8UyUvVQlRvRT+3eGtFAU1Wp11cUcyW0LChXv/7oqoXrhDAtQWdVQt
	 3E+jksolptpjPbxbrxFU8Zpa3K5FjhTd7+tHIfuBcLM4KCRW2XHpgwJTAemvLgKMlI
	 IDpYffeKC6Q42FdqQxaGvrsHCNRZtHsHiFoHWrEnPG/xQw2AubDbQglKE553DrSCo3
	 dEyxFOehdCx14wcMHS8jg7FjPH1M5gsHV04cN/0jpXMk8V4CyIupeAaGSuIje4wvtb
	 DDpKk3hJ+7FzA==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Fri, 28 Mar 2025 04:16:39 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 28 Mar 2025 04:16:38 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, "John W. Linville"
	<linville@tuxdriver.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] cfg80211: Avoid calling WARN_ON() on -ENOMEM in cfg80211_switch_netns()
Date: Fri, 28 Mar 2025 04:16:18 +0300
Message-ID: <20250328011619.743980-1-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 81.200.124.61:7.1.2;ksmg01.maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mt-integration.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192175 [Mar 27 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/27 22:37:00 #27871126
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

It's pointless to call WARN_ON() in case of an allocation failure in
device_rename(), since it only leads to useless splats caused by deliberate
fault injections, so avoid it.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 04600794958f ("cfg80211: support sysfs namespaces")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
 net/wireless/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 828e29872633..7c0ca2fd3b45 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -201,7 +201,7 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 	wiphy_net_set(&rdev->wiphy, net);
 
 	err = device_rename(&rdev->wiphy.dev, dev_name(&rdev->wiphy.dev));
-	WARN_ON(err);
+	WARN_ON(err && err != -ENOMEM);
 
 	nl80211_notify_wiphy(rdev, NL80211_CMD_NEW_WIPHY);
 
-- 
2.39.5


