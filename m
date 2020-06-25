Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DDD209F43
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 15:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404971AbgFYNJM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 09:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404932AbgFYNIz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 09:08:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E4BC08C5DB
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 06:08:55 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1joRcb-00BrnC-JM; Thu, 25 Jun 2020 15:08:53 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     me@bcopeland.com
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/9] wmediumd: init time controller connection later
Date:   Thu, 25 Jun 2020 15:08:39 +0200
Message-Id: <20200625150754.86118afacfc9.I314c0396c470f9368b46dc7a8758394e560f48ac@changeid>
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

Some infrastructure that starts wmediumd might wait for it
to start up by checking the sockets it should offer exist,
yet have time stopped during startup for debug purposes.

Initialize the time connection later so that the startup
can happen regardless of such a scenario. Nothing can be
processed on any of the sockets until we actually get to
the mainloop anyway, so this is entirely safe.

---
 wmediumd/wmediumd.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/wmediumd/wmediumd.c b/wmediumd/wmediumd.c
index 0f45c75be9c9..d7ffd8396d8a 100644
--- a/wmediumd/wmediumd.c
+++ b/wmediumd/wmediumd.c
@@ -1181,18 +1181,6 @@ int main(int argc, char *argv[])
 		usfstl_sched_add_job(&scheduler, &ctx.intf_job);
 	}
 
-	if (time_socket) {
-		usfstl_sched_ctrl_start(&ctrl, time_socket,
-				      1000 /* nsec per usec */,
-				      (uint64_t)-1 /* no ID */,
-				      &scheduler);
-		vusrv.scheduler = &scheduler;
-		vusrv.ctrl = &ctrl;
-		ctx.ctrl = &ctrl;
-	} else {
-		usfstl_sched_wallclock_init(&scheduler, 1000);
-	}
-
 	if (vusrv.socket)
 		usfstl_vhost_user_server_start(&vusrv);
 
@@ -1213,6 +1201,18 @@ int main(int argc, char *argv[])
 	if (api_socket)
 		usfstl_uds_create(api_socket, wmediumd_api_connected, &ctx);
 
+	if (time_socket) {
+		usfstl_sched_ctrl_start(&ctrl, time_socket,
+				      1000 /* nsec per usec */,
+				      (uint64_t)-1 /* no ID */,
+				      &scheduler);
+		vusrv.scheduler = &scheduler;
+		vusrv.ctrl = &ctrl;
+		ctx.ctrl = &ctrl;
+	} else {
+		usfstl_sched_wallclock_init(&scheduler, 1000);
+	}
+
 	while (1) {
 		if (time_socket) {
 			usfstl_sched_next(&scheduler);
-- 
2.26.2

