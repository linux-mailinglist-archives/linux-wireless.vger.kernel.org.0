Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE98209F39
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 15:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404964AbgFYNI7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 09:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404949AbgFYNI5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 09:08:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0067BC08C5C1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 06:08:56 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1joRcd-00BrnC-4E; Thu, 25 Jun 2020 15:08:55 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     me@bcopeland.com
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 9/9] wmediumd: lib: wallclock: fix timerfd handling
Date:   Thu, 25 Jun 2020 15:08:44 +0200
Message-Id: <20200625150754.61ba963a8ccf.I2aa70a3d80eba03d766b354a4ba05e8fb15e8287@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625130844.22893-1-johannes@sipsolutions.net>
References: <20200625130844.22893-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we have a timerfd for wallclock integration, it is possible
that the following scenario happens:
 * we insert an event in to the scheduler at time T
 * some job handling handles the event loop and the fd
   becomes readable and the read is handled
 * we go back to the scheduler, now waiting for time T,
   but the fd doesn't become readable because it already
   had

This causes the scheduler to lose synchronization and nothing
really works - this manifested for example when having virtual
ethernet with a low latency, where the real processing time
may be more than the latency.

Fix this by keeping the loop entry only active when we need it,
so that the fd becomes readable we don't handle it until we're
in a situation where we actually want to.

---
 wmediumd/lib/wallclock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/wmediumd/lib/wallclock.c b/wmediumd/lib/wallclock.c
index 4f62a5894329..3fb09accba61 100644
--- a/wmediumd/lib/wallclock.c
+++ b/wmediumd/lib/wallclock.c
@@ -56,9 +56,13 @@ void usfstl_sched_wallclock_wait(struct usfstl_scheduler *sched)
 {
 	sched->wallclock.timer_triggered = 0;
 
+	usfstl_loop_register(&sched->wallclock.entry);
+
 	while (!sched->wallclock.timer_triggered)
 		usfstl_loop_wait_and_handle();
 
+	usfstl_loop_unregister(&sched->wallclock.entry);
+
 	usfstl_sched_set_time(sched, sched->prev_external_sync);
 }
 
@@ -76,8 +80,6 @@ void usfstl_sched_wallclock_init(struct usfstl_scheduler *sched,
 	sched->wallclock.entry.handler = usfstl_sched_wallclock_handle_fd;
 
 	sched->wallclock.nsec_per_tick = ns_per_tick;
-
-	usfstl_loop_register(&sched->wallclock.entry);
 }
 
 void usfstl_sched_wallclock_exit(struct usfstl_scheduler *sched)
@@ -87,8 +89,6 @@ void usfstl_sched_wallclock_exit(struct usfstl_scheduler *sched)
 
 	sched->external_request = NULL;
 	sched->external_wait = NULL;
-
-	usfstl_loop_unregister(&sched->wallclock.entry);
 	close(sched->wallclock.entry.fd);
 }
 
-- 
2.26.2

