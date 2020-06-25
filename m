Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854B3209F3A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 15:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404949AbgFYNJB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 09:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404945AbgFYNI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 09:08:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8606EC08C5DB
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 06:08:56 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1joRcc-00BrnC-R6; Thu, 25 Jun 2020 15:08:54 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     me@bcopeland.com
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 8/9] wmediumd: lib: minor code cleanups
Date:   Thu, 25 Jun 2020 15:08:43 +0200
Message-Id: <20200625150754.75ace08e3899.I2631363a1d417f16437bccb99d089277b981e788@changeid>
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

---
 wmediumd/lib/loop.c      |  1 +
 wmediumd/lib/sched.c     |  2 +-
 wmediumd/lib/schedctrl.c |  3 ---
 wmediumd/lib/vhost.c     | 20 ++++++++++----------
 wmediumd/lib/wallclock.c |  2 +-
 5 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/wmediumd/lib/loop.c b/wmediumd/lib/loop.c
index e5595a33234d..67f6876165c7 100644
--- a/wmediumd/lib/loop.c
+++ b/wmediumd/lib/loop.c
@@ -50,6 +50,7 @@ void usfstl_loop_wait_and_handle(void)
 		struct usfstl_loop_entry *tmp;
 		fd_set rd_set, exc_set;
 		unsigned int max = 0, num;
+
 		FD_ZERO(&rd_set);
 		FD_ZERO(&exc_set);
 
diff --git a/wmediumd/lib/sched.c b/wmediumd/lib/sched.c
index f23c8190fdce..2694a034d7dd 100644
--- a/wmediumd/lib/sched.c
+++ b/wmediumd/lib/sched.c
@@ -262,7 +262,7 @@ static void usfstl_sched_restore_blocked_jobs(struct usfstl_scheduler *sched)
 					      entry) {
 		if (job == sched->allowed_job ||
 		    !((1 << job->group) & sched->blocked_groups))
-		usfstl_sched_restore_job(sched, job);
+			usfstl_sched_restore_job(sched, job);
 	}
 }
 
diff --git a/wmediumd/lib/schedctrl.c b/wmediumd/lib/schedctrl.c
index ed5a9089124d..540826026d68 100644
--- a/wmediumd/lib/schedctrl.c
+++ b/wmediumd/lib/schedctrl.c
@@ -122,9 +122,6 @@ static void usfstl_sched_ctrl_wait(struct usfstl_scheduler *sched)
 
 #define JOB_ASSERT_VAL(j) (j) ? (j)->name : "<NULL>"
 
-extern struct usfstl_sched_ctrl g_schedCtrl;
-extern struct usfstl_scheduler g_usfstl_task_scheduler;
-
 void usfstl_sched_ctrl_start(struct usfstl_sched_ctrl *ctrl,
 			     const char *socket,
 			     uint32_t nsec_per_tick,
diff --git a/wmediumd/lib/vhost.c b/wmediumd/lib/vhost.c
index 9f116f57f04a..cc35d8cd7aa4 100644
--- a/wmediumd/lib/vhost.c
+++ b/wmediumd/lib/vhost.c
@@ -69,8 +69,8 @@ CONV(64)
 
 static struct usfstl_vhost_user_buf *
 usfstl_vhost_user_get_virtq_buf(struct usfstl_vhost_user_dev_int *dev,
-			      unsigned int virtq_idx,
-			      struct usfstl_vhost_user_buf *fixed)
+				unsigned int virtq_idx,
+				struct usfstl_vhost_user_buf *fixed)
 {
 	struct usfstl_vhost_user_buf *buf = fixed;
 	struct vring *virtq = &dev->virtqs[virtq_idx].virtq;
@@ -103,8 +103,8 @@ usfstl_vhost_user_get_virtq_buf(struct usfstl_vhost_user_dev_int *dev,
 	} while (more);
 
 	if (n_in > fixed->n_in_sg || n_out > fixed->n_out_sg) {
-	    	size_t sz = sizeof(*buf);
-	    	struct iovec *vec;
+		size_t sz = sizeof(*buf);
+		struct iovec *vec;
 
 		sz += (n_in + n_out) * sizeof(*vec);
 
@@ -242,7 +242,7 @@ static void usfstl_vhost_user_send_virtq_buf(struct usfstl_vhost_user_dev_int *d
 	__sync_synchronize();
 
 	virtq->used->idx = cpu_to_virtio16(dev, widx);
-	
+
 	if (call_fd < 0 &&
 	    dev->ext.protocol_features &
 			(1ULL << VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS) &&
@@ -302,7 +302,7 @@ static void usfstl_vhost_user_send_virtq_buf(struct usfstl_vhost_user_dev_int *d
 }
 
 static void usfstl_vhost_user_handle_queue(struct usfstl_vhost_user_dev_int *dev,
-					 unsigned int virtq_idx)
+					   unsigned int virtq_idx)
 {
 	/* preallocate on the stack for most cases */
 	struct iovec in_sg[SG_STACK_PREALLOC] = { };
@@ -338,7 +338,7 @@ static void usfstl_vhost_user_job_callback(struct usfstl_job *job)
 }
 
 static void usfstl_vhost_user_virtq_kick(struct usfstl_vhost_user_dev_int *dev,
-				       unsigned int virtq)
+					 unsigned int virtq)
 {
 	if (!(dev->ext.server->input_queues & (1ULL << virtq)))
 		return;
@@ -439,7 +439,7 @@ static void usfstl_vhost_user_dev_free(struct usfstl_vhost_user_dev_int *dev)
 }
 
 static void usfstl_vhost_user_get_msg_fds(struct msghdr *msghdr,
-					int *outfds, int max_fds)
+					  int *outfds, int max_fds)
 {
 	struct cmsghdr *msg;
 	int fds;
@@ -774,8 +774,8 @@ void *usfstl_vhost_user_to_va(struct usfstl_vhost_user_dev *extdev, uint64_t add
 			   dev->regions[region].size)
 			return (uint8_t *)dev->region_vaddr[region] +
 			       (addr -
-			        dev->regions[region].user_addr +
-			        dev->regions[region].mmap_offset);
+				dev->regions[region].user_addr +
+				dev->regions[region].mmap_offset);
 	}
 
 	USFSTL_ASSERT(0, "cannot translate address %"PRIx64"\n", addr);
diff --git a/wmediumd/lib/wallclock.c b/wmediumd/lib/wallclock.c
index b4750621348a..4f62a5894329 100644
--- a/wmediumd/lib/wallclock.c
+++ b/wmediumd/lib/wallclock.c
@@ -63,7 +63,7 @@ void usfstl_sched_wallclock_wait(struct usfstl_scheduler *sched)
 }
 
 void usfstl_sched_wallclock_init(struct usfstl_scheduler *sched,
-			       unsigned int ns_per_tick)
+				 unsigned int ns_per_tick)
 {
 	USFSTL_ASSERT(!sched->external_request && !sched->external_wait);
 
-- 
2.26.2

