Return-Path: <linux-wireless+bounces-18219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F47A22D07
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 13:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0489B188676E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 12:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2851E2606;
	Thu, 30 Jan 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="uxU/ZMFq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E9A1BEF90;
	Thu, 30 Jan 2025 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738241103; cv=none; b=ENAa8C1YivMzSeMLbjmRoinP+1+NZATUTkGlJblPR/xMvWqdiJemy9Pbxajixw3XUdubUopsjMVHOmz6w9JV0IisCHSwWoyW8QfWQAHv7xhnTMjbmgaI2xcTHVUzSZpauDpVgq4g+AGClxShnXLds+YWifKCXID2uorS+H68XHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738241103; c=relaxed/simple;
	bh=GYCaJ5Vr7sOpcdfGmr8b+XBHEremvLtD3Iw/o2W4P1g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ajx6jrOMfp4VMd0g3zKS3snIi3Jouwa1i3G7fmGJEGa++Sj/UGB6kKeDVj8Eko78Oq7UhPe0DQLw6fwTC9FTydwcltmm5AGYsxu+LHYvtg++xn4qGQBlIkru0fkcDoo7ECLsTY15HCGlkIL0dMJ4fb21LptNwJd0hSrs5P/Pv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=uxU/ZMFq; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id CA145C0011;
	Thu, 30 Jan 2025 15:35:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru CA145C0011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1738240531; bh=twHoKyIKefEek4uasdsBCb2/LDkuVcyX27qfI5boU4U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=uxU/ZMFqpjy5Kfw/khXqjLNSSkX71WRZcsHs6lpGFzI3z0Kr3QNICGQMco9ZJ5nVN
	 1iBc8VS9sHJCBXiiEMdVpHgiDIfzZ75Z6W6NLrApNSh7ScEN+T4XAs0nzPuRQHGx+u
	 6FQFPvMUuGdHP8+TdelguAX8CAofx4G9JRG6bxuaTTFAKLmpzFxP3bSxiGHevoZx/l
	 zFo4bSJ5VsttK4MIOswTvl6lD9f0l6pz2aHHCCNICi96Y1Usc9C5cpz5IAJ6nOJL34
	 dLQTB8scFgk1MUIMgzTKirWgNBZ7EdMtFhcZFwJOrLl/AyqGeIDyYUs7rY5d7DIrei
	 q3UHi4Ra5pWEw==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Thu, 30 Jan 2025 15:35:31 +0300 (MSK)
Received: from localhost.maximatelecom.ru (5.1.51.69) by mmail-p-exch01.mt.ru
 (81.200.124.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Thu, 30 Jan
 2025 15:35:30 +0300
From: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>, "John W. Linville"
	<linville@tuxdriver.com>, Michael Wu <flamingice@sourmilk.net>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>,
	<syzbot+2e5c1e55b9e5c28a3da7@syzkaller.appspotmail.com>
Subject: [PATCH] wifi: nl80211: override all other flags if MONITOR_FLAG_COOK_FRAMES is set
Date: Thu, 30 Jan 2025 17:34:21 +0500
Message-ID: <20250130123432.4534-1-v.shevtsov@mt-integration.ru>
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
X-KSMG-AntiPhishing: NotDetected, bases: 2025/01/30 10:59:00
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 50 0.3.50 df4aeb250ed63fd3baa80a493fa6caee5dd9e10f, {rep_avail}, {Tracking_one_url, url3}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, ksmg01.maxima.ru:7.1.1;syzkaller.appspot.com:7.1.1,5.0.1;81.200.124.61:7.1.2;mt-integration.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 190685 [Jan 30 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/01/30 07:21:00 #27156911
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/01/30 10:59:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

It is possible to set both MONITOR_FLAG_COOK_FRAMES and MONITOR_FLAG_ACTIVE
flags simultaneously on the same monitor interface from the userspace. This
causes a sub-interface to be created with no IEEE80211_SDATA_IN_DRIVER bit
set because the monitor interface is in the cooked state and it takes
precedence over all other states. When the interface is then being deleted
the kernel calls WARN_ONCE() from check_sdata_in_driver() because of missing
that bit.

Fix this by overriding all flags if MONITOR_FLAG_COOK_FRAMES is set because
this flag is incompatible with other monitor flags being set.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 66f7ac50ed7c (nl80211: Add monitor interface configuration flags)
Reported-by: syzbot+2e5c1e55b9e5c28a3da7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2e5c1e55b9e5c28a3da7
Signed-off-by: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
---
 net/wireless/nl80211.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d7d3da0f6833..1338b0a06f8d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4220,6 +4220,10 @@ static int parse_monitor_flags(struct nlattr *nla, u32 *mntrflags)
 		if (flags[flag])
 			*mntrflags |= (1<<flag);
 
+	/* MONITOR_FLAG_COOK_FRAMES must override all other flags */
+	if (*mntrflags & MONITOR_FLAG_COOK_FRAMES)
+		*mntrflags = MONITOR_FLAG_COOK_FRAMES;
+
 	*mntrflags |= MONITOR_FLAG_CHANGED;
 
 	return 0;
-- 
2.48.1


