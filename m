Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4F734108B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 23:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhCRW40 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Mar 2021 18:56:26 -0400
Received: from mail.toke.dk ([45.145.95.4]:51699 "EHLO mail.toke.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232488AbhCRW4B (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Mar 2021 18:56:01 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Mar 2021 18:56:01 EDT
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1616107659; bh=45YSRCzrXsrnu2g64PpBQiPPUSx8YZZpeTGrkZz1nwI=;
        h=From:To:Cc:Subject:Date:From;
        b=DE31Bl09BzK23tXdCq6VLEQrBuJvl64BjILr5hi/7EHuXZua+gPVp6q6zEyOTNlij
         x+LDQMHrlKAWWpOcPfJgUSmN9WmEU//fFrTVjCfSksZHCLHxdKEB1bkz6wzrxUg9x2
         QK8Cri+AaGyULclMZpxubTFpDg9tLsaHQM9TBVeQVaY4hut+52hmCIPTYOhjAC6ojZ
         AIGb1u4inTA1kQT9q+Eq/IepEnCGC1MQ6AAhOx6g7/BJB8BMJDqBPV5zQ86c2oru1q
         KFDNz0/WIiJyW8CnkVgFqlcY4rKzXw2Mj26udm2zBusXOQqY5Kq1+tiKJySsbQF6WL
         9PBeYwBnyhx8A==
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: [PATCH] iw: Fix timestamp output on 32-bit architectures
Date:   Thu, 18 Mar 2021 23:46:55 +0100
Message-Id: <20210318224655.143489-1-toke@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 32-bit architectures, time_t is 32-bit which causes overflows in the
arithmetic involving tv_sec, leading to invalid output. Fix this by
explicitly adding ULL suffixes to the constants used in those calculations.

Fixes: 3708f614dfdd ("iw: Print current time in station info dump")
Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 station.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/station.c b/station.c
index bddea51815ee..002cf13526cc 100644
--- a/station.c
+++ b/station.c
@@ -337,7 +337,7 @@ static int print_sta_handler(struct nl_msg *msg, void *arg)
 	unsigned long long now_ms;
 
 	gettimeofday(&now, NULL);
-	now_ms = now.tv_sec * 1000;
+	now_ms = now.tv_sec * 1000ULL;
 	now_ms += (now.tv_usec / 1000);
 
 	nla_parse(tb, NL80211_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
@@ -601,7 +601,7 @@ static int print_sta_handler(struct nl_msg *msg, void *arg)
 		unsigned long long assoc_at_ms;
 
 		clock_gettime(CLOCK_BOOTTIME, &now_ts);
-		boot_ns = now_ts.tv_sec * 1000000000;
+		boot_ns = now_ts.tv_sec * 1000000000ULL;
 		boot_ns += now_ts.tv_nsec;
 
 		bt = (unsigned long long)nla_get_u64(sinfo[NL80211_STA_INFO_ASSOC_AT_BOOTTIME]);
-- 
2.30.2

