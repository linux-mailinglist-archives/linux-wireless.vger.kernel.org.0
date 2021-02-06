Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F793311E3E
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Feb 2021 16:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBFPGA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Feb 2021 10:06:00 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:40845 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhBFPFd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Feb 2021 10:05:33 -0500
Received: from isengard.fritz.box (unknown [87.147.51.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 3D20E58005E;
        Sat,  6 Feb 2021 16:04:40 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] iw: add option to print human readable event time
Date:   Sat,  6 Feb 2021 16:04:32 +0100
Message-Id: <20210206150432.10456-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 event.c | 30 ++++++++++++++++++++++++------
 iw.h    |  2 +-
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/event.c b/event.c
index 61395f8..8bdbbe9 100644
--- a/event.c
+++ b/event.c
@@ -3,6 +3,7 @@
 #include <net/if.h>
 #include <errno.h>
 #include <inttypes.h>
+#include <time.h>
 #include "iw.h"
 
 static int no_seq_check(struct nl_msg *msg, void *arg)
@@ -905,12 +906,13 @@ static int print_event(struct nl_msg *msg, void *arg)
 	int rem_nst;
 	__u16 status;
 
-	if (args->time || args->reltime) {
+	if (args->time || args->reltime || args->ctime) {
 		unsigned long long usecs, previous;
 
 		previous = 1000000ULL * args->ts.tv_sec + args->ts.tv_usec;
 		gettimeofday(&args->ts, NULL);
 		usecs = 1000000ULL * args->ts.tv_sec + args->ts.tv_usec;
+
 		if (args->reltime) {
 			if (!args->have_ts) {
 				usecs = 0;
@@ -918,7 +920,16 @@ static int print_event(struct nl_msg *msg, void *arg)
 			} else
 				usecs -= previous;
 		}
-		printf("%llu.%06llu: ", usecs/1000000, usecs % 1000000);
+
+		if (args->ctime) {
+			struct tm *tm = localtime(&args->ts.tv_sec);
+			char buf[255];
+
+			memset(buf, 0, 255);
+			strftime(buf, sizeof(buf), "%Y-%m-%d %H:%M:%S", tm);
+			printf("[%s.%06lu]: ", buf, args->ts.tv_usec);
+		} else
+			printf("%llu.%06llu: ", usecs/1000000, usecs % 1000000);
 	}
 
 	nla_parse(tb, NL80211_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
@@ -1407,6 +1418,7 @@ static int print_events(struct nl80211_state *state,
 			enum id_input id)
 {
 	struct print_event_args args;
+	int num_time_formats = 0;
 	int ret;
 
 	memset(&args, 0, sizeof(args));
@@ -1417,17 +1429,22 @@ static int print_events(struct nl80211_state *state,
 	while (argc > 0) {
 		if (strcmp(argv[0], "-f") == 0)
 			args.frame = true;
-		else if (strcmp(argv[0], "-t") == 0)
+		else if (strcmp(argv[0], "-t") == 0) {
+			num_time_formats++;
 			args.time = true;
-		else if (strcmp(argv[0], "-r") == 0)
+		} else if (strcmp(argv[0], "-T") == 0) {
+			num_time_formats++;
+			args.ctime = true;
+		} else if (strcmp(argv[0], "-r") == 0) {
+			num_time_formats++;
 			args.reltime = true;
-		else
+		} else
 			return 1;
 		argc--;
 		argv++;
 	}
 
-	if (args.time && args.reltime)
+	if (num_time_formats > 1)
 		return 1;
 
 	if (argc)
@@ -1442,5 +1459,6 @@ static int print_events(struct nl80211_state *state,
 TOPLEVEL(event, "[-t|-r] [-f]", 0, 0, CIB_NONE, print_events,
 	"Monitor events from the kernel.\n"
 	"-t - print timestamp\n"
+	"-T - print absolute, human-readable timestamp\n"
 	"-r - print relative timestamp\n"
 	"-f - print full frame for auth/assoc etc.");
diff --git a/iw.h b/iw.h
index 807adec..7f7f4fc 100644
--- a/iw.h
+++ b/iw.h
@@ -181,7 +181,7 @@ int handle_cmd(struct nl80211_state *state, enum id_input idby,
 struct print_event_args {
 	struct timeval ts; /* internal */
 	bool have_ts; /* must be set false */
-	bool frame, time, reltime;
+	bool frame, time, reltime, ctime;
 };
 
 __u32 listen_events(struct nl80211_state *state,
-- 
2.30.0

