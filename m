Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1448D21E3B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2019 21:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfEQTaa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 May 2019 15:30:30 -0400
Received: from nbd.name ([46.4.11.11]:37384 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbfEQTa3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 May 2019 15:30:29 -0400
Received: from p548c8c9f.dip0.t-ipconnect.de ([84.140.140.159] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hRiYm-0006cc-53; Fri, 17 May 2019 21:30:28 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH 4/7] iw: fix fd leak inside handle_netns
Date:   Fri, 17 May 2019 21:29:53 +0200
Message-Id: <20190517192956.18372-5-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517192956.18372-1-john@phrozen.org>
References: <20190517192956.18372-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: John Crispin <john@phrozen.org>
---
 phy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/phy.c b/phy.c
index a4425ea..ba89d46 100644
--- a/phy.c
+++ b/phy.c
@@ -1,6 +1,7 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <strings.h>
+#include <unistd.h>
 #include <sys/param.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -531,7 +532,7 @@ static int handle_netns(struct nl80211_state *state,
 			enum id_input id)
 {
 	char *end;
-	int fd;
+	int fd = -1;
 
 	if (argc < 1 || !*argv[0])
 		return 1;
@@ -559,6 +560,8 @@ static int handle_netns(struct nl80211_state *state,
 	return 1;
 
  nla_put_failure:
+	if (fd >= 0)
+		close(fd);
 	return -ENOBUFS;
 }
 COMMAND(set, netns, "{ <pid> | name <nsname> }",
-- 
2.20.1

