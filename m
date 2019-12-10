Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53FC118AB1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 15:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfLJOWy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Dec 2019 09:22:54 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:44890 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfLJOWy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Dec 2019 09:22:54 -0500
Received: from isengard.tu-ilmenau.de (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id C6077580073;
        Tue, 10 Dec 2019 15:22:52 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/2] iw: event: add set interface command
Date:   Tue, 10 Dec 2019 15:22:45 +0100
Message-Id: <20191210142245.13972-2-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210142245.13972-1-markus.theil@tu-ilmenau.de>
References: <20191210142245.13972-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds support for CMD_SET_INTERFACE which is called
when switching to mesh or ap mode.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 event.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/event.c b/event.c
index f17e78e..0cedeb9 100644
--- a/event.c
+++ b/event.c
@@ -668,6 +668,46 @@ static void parse_new_peer_candidate(struct nlattr **attrs)
 	printf("\n");
 }
 
+static void parse_set_interface(struct nlattr **attrs)
+{
+	printf("set interface");
+
+	if (attrs[NL80211_ATTR_IFTYPE]) {
+		printf(" type ");
+		switch (nla_get_u32(attrs[NL80211_ATTR_IFTYPE])) {
+		case NL80211_IFTYPE_STATION:
+			printf("station");
+			break;
+		case NL80211_IFTYPE_AP:
+			printf("access point");
+			break;
+		case NL80211_IFTYPE_MESH_POINT:
+			printf("mesh point");
+			break;
+		case NL80211_IFTYPE_ADHOC:
+			printf("ad-hoc");
+			break;
+		case NL80211_IFTYPE_MONITOR:
+			printf("monitor");
+			break;
+		default:
+			printf("unknown");
+		}
+	}
+
+	if (attrs[NL80211_ATTR_MESH_ID]) {
+		printf(" meshid ");
+		print_ssid_escaped(nla_len(attrs[NL80211_ATTR_MESH_ID]),
+				   nla_data(attrs[NL80211_ATTR_MESH_ID]));
+	}
+
+	if (attrs[NL80211_ATTR_4ADDR]) {
+		printf(" use 4addr %i", nla_get_u8(attrs[NL80211_ATTR_4ADDR]));
+	}
+
+	printf("\n");
+}
+
 static int print_event(struct nl_msg *msg, void *arg)
 {
 	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
@@ -1011,6 +1051,10 @@ static int print_event(struct nl_msg *msg, void *arg)
 		parse_new_peer_candidate(tb);
 		break;
 	}
+	case NL80211_CMD_SET_INTERFACE: {
+		parse_set_interface(tb);
+		break;
+	}
 	default:
 		printf("unknown event %d (%s)\n",
 		       gnlh->cmd, command_name(gnlh->cmd));
-- 
2.24.0

