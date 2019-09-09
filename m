Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D627DADFD4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 22:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbfIIUOG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 16:14:06 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:52486 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731972AbfIIUOG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 16:14:06 -0400
Received: from v-f24-64.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 3AA96104B;
        Mon,  9 Sep 2019 13:14:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3AA96104B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1568060045;
        bh=w6y9HuM2L42xLMAW9g5SiLkogh8H80Jjpx9kY/hroqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jR94SEQiDlMDA6n4xJVBFuxK1ph3e48gRJNL1pK18r9E1Jk1OxR4HiNRvNQz6shrP
         tKTbNO2Vy9eiFsOOMFpxXKpik5Vjb3852mNgnY/2U5J/miQN2ZfEj1dMMYSarZtSr5
         l8xHk3iGuQx/aPPrFUCGGiNppfSw7AC2OHvKnMZo=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH-v2 2/2] iw:  Print current time in station info dump
Date:   Mon,  9 Sep 2019 13:13:57 -0700
Message-Id: <1568060037-7481-2-git-send-email-greearb@candelatech.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1568060037-7481-1-git-send-email-greearb@candelatech.com>
References: <1568060037-7481-1-git-send-email-greearb@candelatech.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This lets us more precisely calculate the absolute timestamp
of last-rix (ie, now - idle).

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 station.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/station.c b/station.c
index 61a317d..1be3974 100644
--- a/station.c
+++ b/station.c
@@ -7,6 +7,7 @@
 #include <netlink/genl/ctrl.h>
 #include <netlink/msg.h>
 #include <netlink/attr.h>
+#include <time.h>
 
 #include "nl80211.h"
 #include "iw.h"
@@ -326,6 +327,12 @@ static int print_sta_handler(struct nl_msg *msg, void *arg)
 		[NL80211_STA_INFO_ACK_SIGNAL_AVG] = { .type = NLA_U8 },
 	};
 	char *chain;
+	struct timeval now;
+	unsigned long long now_ms;
+
+	gettimeofday(&now, NULL);
+	now_ms = now.tv_sec * 1000;
+	now_ms += (now.tv_usec / 1000);
 
 	nla_parse(tb, NL80211_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
 		  genlmsg_attrlen(gnlh, 0), NULL);
@@ -571,12 +578,22 @@ static int print_sta_handler(struct nl_msg *msg, void *arg)
 			nla_get_u32(sinfo[NL80211_STA_INFO_CONNECTED_TIME]));
 	if (sinfo[NL80211_STA_INFO_ASSOC_AT_BOOTTIME]) {
 		unsigned long long bt;
+		struct timespec now_ts;
+		unsigned long long boot_ns;
+		unsigned long long assoc_at_ms;
+
+		clock_gettime(CLOCK_BOOTTIME, &now_ts);
+		boot_ns = now_ts.tv_sec * 1000000000;
+		boot_ns += now_ts.tv_nsec;
+
 		bt = (unsigned long long)nla_get_u64(sinfo[NL80211_STA_INFO_ASSOC_AT_BOOTTIME]);
-		printf("\n\tassociated at:\t%llu.%.3llus [boottime]",
+		printf("\n\tassociated at [boottime]:\t%llu.%.3llus",
 		       bt/1000000000, (bt%1000000000)/1000000);
+		assoc_at_ms = now_ms - ((boot_ns - bt) / 1000000);
+		printf("\n\tassociated at:\t%llu ms", assoc_at_ms);
 	}
 
-	printf("\n");
+	printf("\n\tcurrent time:\t%llu ms\n", now_ms);
 	return NL_SKIP;
 }
 
-- 
2.7.5

