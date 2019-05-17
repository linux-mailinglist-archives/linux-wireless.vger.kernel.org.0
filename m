Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B7C21E3E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2019 21:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfEQTac (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 May 2019 15:30:32 -0400
Received: from nbd.name ([46.4.11.11]:37390 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728970AbfEQTa3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 May 2019 15:30:29 -0400
Received: from p548c8c9f.dip0.t-ipconnect.de ([84.140.140.159] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hRiYm-0006cc-Fu; Fri, 17 May 2019 21:30:28 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH 5/7] iw: fix memory leak inside parse_sched_scan
Date:   Fri, 17 May 2019 21:29:54 +0200
Message-Id: <20190517192956.18372-6-john@phrozen.org>
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
 scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scan.c b/scan.c
index b0b7828..980bfb4 100644
--- a/scan.c
+++ b/scan.c
@@ -355,11 +355,12 @@ int parse_sched_scan(struct nl_msg *msg, int *argc, char ***argv)
 nla_put_failure:
 	if (match)
 		nla_nest_end(msg, match);
+out:
 	nlmsg_free(freqs);
 	nlmsg_free(matchset);
 	nlmsg_free(scan_plans);
+	nlmsg_free(ssids);
 
-out:
 	*argc = c;
 	*argv = v;
 	return err;
-- 
2.20.1

