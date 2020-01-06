Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8C613147C
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 16:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgAFPKc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 10:10:32 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:41875 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgAFPKb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 10:10:31 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id DC43258006C;
        Mon,  6 Jan 2020 16:10:29 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 1/4] iw: event: handle interface add/del
Date:   Mon,  6 Jan 2020 16:10:21 +0100
Message-Id: <20200106151024.124315-2-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106151024.124315-1-markus.theil@tu-ilmenau.de>
References: <20200106151024.124315-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 event.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/event.c b/event.c
index 2a12ca6..baeafae 100644
--- a/event.c
+++ b/event.c
@@ -668,9 +668,22 @@ static void parse_new_peer_candidate(struct nlattr **attrs)
 	printf("\n");
 }
 
-static void parse_set_interface(struct nlattr **attrs)
+static void parse_recv_interface(struct nlattr **attrs, int command)
 {
-	printf("set interface");
+	switch (command) {
+	case NL80211_CMD_NEW_INTERFACE:
+		printf("new interface");
+		break;
+	case NL80211_CMD_DEL_INTERFACE:
+		printf("del interface");
+		break;
+	case NL80211_CMD_SET_INTERFACE:
+		printf("set interface");
+		break;
+	default:
+		printf("unknown interface command (%i) received\n", command);
+		return;
+	}
 
 	if (attrs[NL80211_ATTR_IFTYPE]) {
 		printf(" type ");
@@ -787,8 +800,11 @@ static int print_event(struct nl_msg *msg, void *arg)
 		  genlmsg_attrlen(gnlh, 0), NULL);
 
 	if (tb[NL80211_ATTR_IFINDEX] && tb[NL80211_ATTR_WIPHY]) {
-		if_indextoname(nla_get_u32(tb[NL80211_ATTR_IFINDEX]), ifname);
-		printf("%s (phy #%d): ", ifname, nla_get_u32(tb[NL80211_ATTR_WIPHY]));
+		/* if_indextoname may fails on delete interface/wiphy event */
+		if(if_indextoname(nla_get_u32(tb[NL80211_ATTR_IFINDEX]), ifname))
+			printf("%s (phy #%d): ", ifname, nla_get_u32(tb[NL80211_ATTR_WIPHY]));
+		else
+			printf("phy #%d: ", nla_get_u32(tb[NL80211_ATTR_WIPHY]));
 	} else if (tb[NL80211_ATTR_WDEV] && tb[NL80211_ATTR_WIPHY]) {
 		printf("wdev 0x%llx (phy #%d): ",
 			(unsigned long long)nla_get_u64(tb[NL80211_ATTR_WDEV]),
@@ -1095,8 +1111,10 @@ static int print_event(struct nl_msg *msg, void *arg)
 	case NL80211_CMD_NEW_PEER_CANDIDATE:
 		parse_new_peer_candidate(tb);
 		break;
+	case NL80211_CMD_NEW_INTERFACE:
 	case NL80211_CMD_SET_INTERFACE:
-		parse_set_interface(tb);
+	case NL80211_CMD_DEL_INTERFACE:
+		parse_recv_interface(tb, gnlh->cmd);
 		break;
 	case NL80211_CMD_STA_OPMODE_CHANGED:
 		parse_sta_opmode_changed(tb);
-- 
2.24.1

