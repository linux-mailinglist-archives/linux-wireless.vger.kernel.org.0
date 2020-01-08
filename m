Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD12134381
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2020 14:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgAHNLK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jan 2020 08:11:10 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:50725 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgAHNLK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jan 2020 08:11:10 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 20F27580073;
        Wed,  8 Jan 2020 14:11:09 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] iw: event: parse channel switch
Date:   Wed,  8 Jan 2020 14:11:07 +0100
Message-Id: <20200108131107.27653-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 event.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/event.c b/event.c
index 6900bd3..51aff97 100644
--- a/event.c
+++ b/event.c
@@ -767,6 +767,83 @@ static void parse_sta_opmode_changed(struct nlattr **attrs)
 	printf("\n");
 }
 
+static void parse_ch_switch_notify(struct nlattr **attrs, int command)
+{
+	switch (command) {
+	case NL80211_CMD_CH_SWITCH_STARTED_NOTIFY:
+		printf("channel switch started");
+		break;
+	case NL80211_CMD_CH_SWITCH_NOTIFY:
+		printf("channel switch");
+		break;
+	default:
+		printf("unknown channel switch command (%i) received\n", command);
+		return;
+	}
+
+	if (attrs[NL80211_ATTR_CH_SWITCH_COUNT])
+		printf(" (count=%d)", nla_get_u32(attrs[NL80211_ATTR_CH_SWITCH_COUNT]));
+
+	if (attrs[NL80211_ATTR_WIPHY_FREQ])
+		printf(" freq=%d", nla_get_u32(attrs[NL80211_ATTR_WIPHY_FREQ]));
+
+	if (attrs[NL80211_ATTR_CHANNEL_WIDTH]) {
+		printf(" width=");
+		switch(nla_get_u32(attrs[NL80211_ATTR_CHANNEL_WIDTH])) {
+		case NL80211_CHAN_WIDTH_20_NOHT:
+		case NL80211_CHAN_WIDTH_20:
+			printf("\"20 MHz\"");
+			break;
+		case NL80211_CHAN_WIDTH_40:
+			printf("\"40 MHz\"");
+			break;
+		case NL80211_CHAN_WIDTH_80:
+			printf("\"80 MHz\"");
+			break;
+		case NL80211_CHAN_WIDTH_80P80:
+			printf("\"80+80 MHz\"");
+			break;
+		case NL80211_CHAN_WIDTH_160:
+			printf("\"160 MHz\"");
+			break;
+		case NL80211_CHAN_WIDTH_5:
+			printf("\"5 MHz\"");
+			break;
+		case NL80211_CHAN_WIDTH_10:
+			printf("\"10 MHz\"");
+			break;
+		default:
+			printf("\"unknown\"");
+		}
+	}
+
+	if (attrs[NL80211_ATTR_WIPHY_CHANNEL_TYPE]) {
+		printf(" type=");
+		switch(nla_get_u32(attrs[NL80211_ATTR_WIPHY_CHANNEL_TYPE])) {
+		case NL80211_CHAN_NO_HT:
+			printf("\"No HT\"");
+			break;
+		case NL80211_CHAN_HT20:
+			printf("\"HT20\"");
+			break;
+		case NL80211_CHAN_HT40MINUS:
+			printf("\"HT40-\"");
+			break;
+		case NL80211_CHAN_HT40PLUS:
+			printf("\"HT40+\"");
+			break;
+		}
+	}
+
+	if (attrs[NL80211_ATTR_CENTER_FREQ1])
+		printf(" freq1=%d", nla_get_u32(attrs[NL80211_ATTR_CENTER_FREQ1]));
+
+	if (attrs[NL80211_ATTR_CENTER_FREQ2])
+		printf(" freq2=%d", nla_get_u32(attrs[NL80211_ATTR_CENTER_FREQ2]));
+
+	printf("\n");
+}
+
 static int print_event(struct nl_msg *msg, void *arg)
 {
 	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
@@ -1127,6 +1204,10 @@ static int print_event(struct nl_msg *msg, void *arg)
 	case NL80211_CMD_STOP_AP:
 		printf("stop ap\n");
 		break;
+	case NL80211_CMD_CH_SWITCH_STARTED_NOTIFY:
+	case NL80211_CMD_CH_SWITCH_NOTIFY:
+		parse_ch_switch_notify(tb, gnlh->cmd);
+		break;
 	default:
 		printf("unknown event %d (%s)\n",
 		       gnlh->cmd, command_name(gnlh->cmd));
-- 
2.24.1

