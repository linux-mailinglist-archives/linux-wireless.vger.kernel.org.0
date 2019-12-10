Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D28C118B4F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 15:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfLJOmT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Dec 2019 09:42:19 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:44976 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfLJOmT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Dec 2019 09:42:19 -0500
Received: from isengard.tu-ilmenau.de (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 5A40358006E;
        Tue, 10 Dec 2019 15:42:17 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 1/2] iw: event: add new peer candidate command
Date:   Tue, 10 Dec 2019 15:42:14 +0100
Message-Id: <20191210144215.15263-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch prints information about mesh peering candidates.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 event.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/event.c b/event.c
index 4a932d1..f17e78e 100644
--- a/event.c
+++ b/event.c
@@ -650,6 +650,24 @@ static void parse_nan_match(struct nlattr **attrs)
 	printf("\n");
 }
 
+static void parse_new_peer_candidate(struct nlattr **attrs)
+{
+	char macbuf[ETH_ALEN * 3];
+	int32_t sig_dbm;
+
+	printf("new peer candidate");
+	if (attrs[NL80211_ATTR_MAC]) {
+		mac_addr_n2a(macbuf, nla_data(attrs[NL80211_ATTR_MAC]));
+		printf(" %s", macbuf);
+	}
+	if (attrs[NL80211_ATTR_RX_SIGNAL_DBM]) {
+		sig_dbm = nla_get_u32(attrs[NL80211_ATTR_RX_SIGNAL_DBM]);
+		printf(" %i dBm", sig_dbm);
+	}
+
+	printf("\n");
+}
+
 static int print_event(struct nl_msg *msg, void *arg)
 {
 	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
@@ -989,6 +1007,10 @@ static int print_event(struct nl_msg *msg, void *arg)
 		parse_nan_match(tb);
 		break;
 	}
+	case NL80211_CMD_NEW_PEER_CANDIDATE: {
+		parse_new_peer_candidate(tb);
+		break;
+	}
 	default:
 		printf("unknown event %d (%s)\n",
 		       gnlh->cmd, command_name(gnlh->cmd));
-- 
2.24.0

