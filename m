Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43CE621E40
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2019 21:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfEQTaf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 May 2019 15:30:35 -0400
Received: from nbd.name ([46.4.11.11]:37374 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728954AbfEQTa3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 May 2019 15:30:29 -0400
Received: from p548c8c9f.dip0.t-ipconnect.de ([84.140.140.159] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hRiYk-0006cc-TJ; Fri, 17 May 2019 21:30:27 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH 2/7] iw: fix endless loop inside handle_mgmt_dump
Date:   Fri, 17 May 2019 21:29:51 +0200
Message-Id: <20190517192956.18372-3-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517192956.18372-1-john@phrozen.org>
References: <20190517192956.18372-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

passing -1 will break the while loop further down in the code.

Signed-off-by: John Crispin <john@phrozen.org>
---
 mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mgmt.c b/mgmt.c
index 88fe3fd..338435d 100644
--- a/mgmt.c
+++ b/mgmt.c
@@ -109,6 +109,8 @@ static int handle_mgmt_dump(struct nl80211_state *state,
 	for (i = 3; i < argc; i += 3) {
 		if (strcmp(argv[i], "count") == 0) {
 			count = 1 + atoi(argv[i + 1]);
+			if (count < 1)
+				count = 1;
 			break;
 		}
 
-- 
2.20.1

