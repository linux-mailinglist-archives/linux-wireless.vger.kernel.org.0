Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E1032571C
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 20:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhBYTxr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 14:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhBYTvt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 14:51:49 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48E2C061574
        for <linux-wireless@vger.kernel.org>; Thu, 25 Feb 2021 11:50:58 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lFMet-008Zjo-Nf; Thu, 25 Feb 2021 20:50:47 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org, Bob Copeland <me@bobcopeland.com>
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wmediumd: lib: sched: fix another scheduling corner case
Date:   Thu, 25 Feb 2021 20:50:42 +0100
Message-Id: <20210225195042.2657805-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When running with an external scheduler that also uses the
event loop, we can detect e.g. a client disconnecting from
a server while in usfstl_sched_forward(), causing us to not
have a job anymore on the scheduler afterwards, which then
causes the assert at the end to get reached erroneously.

Move the job check and external wait into the loop so these
cases are covered correctly.

This actually happened in wmediumd on client disconnect at
this exact time, while running usfstl_sched_forward().
---
 wmediumd/lib/sched.c | 48 ++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/wmediumd/lib/sched.c b/wmediumd/lib/sched.c
index 7ebd81a99b4e..7d0618b49cf2 100644
--- a/wmediumd/lib/sched.c
+++ b/wmediumd/lib/sched.c
@@ -182,22 +182,38 @@ void usfstl_sched_start(struct usfstl_scheduler *sched)
 
 struct usfstl_job *usfstl_sched_next(struct usfstl_scheduler *sched)
 {
-	struct usfstl_job *job;
-
-	/*
-	 * If external scheduler is active, we might get here with nothing
-	 * to do, so we just need to wait for an external input/job which
-	 * will add an job to our scheduler in usfstl_sched_add_job().
-	 *
-	 * And due to the fact that we don't have any API for canceling external
-	 * time request, we can request external time which adds a job on the
-	 * external scheduler and cancel internally, and get scheduled to run
-	 * with nothing to do.
-	 */
-	while (usfstl_list_empty(&sched->joblist) && sched->external_request)
-		usfstl_sched_external_wait(sched);
+	while (true) {
+		struct usfstl_job *job = usfstl_sched_next_pending(sched, NULL);
+
+		if (!job) {
+			/*
+			 * If external scheduler is active, we might get here
+			 * with nothing to do, so we just need to wait for an
+			 * external input/job which will add a job to our
+			 * scheduler.
+			 *
+			 * Due to the fact that we don't have any API for
+			 * cancelling external time requests, we might have
+			 * requested time from the external scheduler for a
+			 * job that subsequently got removed, ending up here
+			 * without a job, or one further in the future which
+			 * would cause usfstl_sched_forward() to wait again.
+			 *
+			 * Additionally, we might only remove the job we just
+			 * found during the usfstl_sched_forward() below, if
+			 * that causes the main loop to run and we detect an
+			 * event that causes a job removal (such as a client
+			 * disconnecting from a server), so the job pointer we
+			 * have might go stale. Hence, all of this needs to be
+			 * checked in the overall loop.
+			 */
+			if (sched->external_request) {
+				usfstl_sched_external_wait(sched);
+				continue;
+			}
+			break;
+		}
 
-	while ((job = usfstl_sched_next_pending(sched, NULL))) {
 		/*
 		 * Forward, but only if job isn't in the past - this
 		 * can happen if some job was inserted while we
@@ -214,6 +230,8 @@ struct usfstl_job *usfstl_sched_next(struct usfstl_scheduler *sched)
 		 * might have inserted an earlier job into the timeline.
 		 * If it's not this job's turn yet, reinsert it and check
 		 * what's up next in the next loop iteration.
+		 *
+		 * Also, 'job' might now have been removed, see above.
 		 */
 		if (usfstl_sched_next_pending(sched, NULL) != job)
 			continue;
-- 
2.26.2

