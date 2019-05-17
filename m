Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3674221E39
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2019 21:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfEQTa3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 May 2019 15:30:29 -0400
Received: from nbd.name ([46.4.11.11]:37368 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728951AbfEQTa2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 May 2019 15:30:28 -0400
Received: from p548c8c9f.dip0.t-ipconnect.de ([84.140.140.159] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hRiYk-0006cc-IE; Fri, 17 May 2019 21:30:26 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH 1/7] iw: fix memory leak inside register_mgmt_frame
Date:   Fri, 17 May 2019 21:29:50 +0200
Message-Id: <20190517192956.18372-2-john@phrozen.org>
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
 mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mgmt.c b/mgmt.c
index 60f544b..88fe3fd 100644
--- a/mgmt.c
+++ b/mgmt.c
@@ -69,9 +69,11 @@ static int register_mgmt_frame(struct nl80211_state *state,
 	NLA_PUT_U16(msg, NL80211_ATTR_FRAME_TYPE, type);
 	NLA_PUT(msg, NL80211_ATTR_FRAME_MATCH, match_len, match);
 
+	free(match);
 	return 0;
 
 nla_put_failure:
+	free(match);
 	return -ENOBUFS;
 }
 
-- 
2.20.1

