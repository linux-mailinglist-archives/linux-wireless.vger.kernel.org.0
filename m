Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD97913147A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 16:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgAFPKb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 10:10:31 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:41878 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgAFPKb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 10:10:31 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id EC56758006E;
        Mon,  6 Jan 2020 16:10:29 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/4] iw: event: parse stop ap and frame wait cancel events
Date:   Mon,  6 Jan 2020 16:10:22 +0100
Message-Id: <20200106151024.124315-3-markus.theil@tu-ilmenau.de>
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
 event.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/event.c b/event.c
index baeafae..6900bd3 100644
--- a/event.c
+++ b/event.c
@@ -1026,6 +1026,11 @@ static int print_event(struct nl_msg *msg, void *arg)
 			nla_get_u32(tb[NL80211_ATTR_WIPHY_FREQ]),
 			(unsigned long long)nla_get_u64(tb[NL80211_ATTR_COOKIE]));
 		break;
+	case NL80211_CMD_FRAME_WAIT_CANCEL:
+		printf("frame wait cancel on freq %d (cookie %llx)\n",
+			nla_get_u32(tb[NL80211_ATTR_WIPHY_FREQ]),
+			(unsigned long long)nla_get_u64(tb[NL80211_ATTR_COOKIE]));
+		break;
 	case NL80211_CMD_NOTIFY_CQM:
 		parse_cqm_event(tb);
 		break;
@@ -1119,6 +1124,9 @@ static int print_event(struct nl_msg *msg, void *arg)
 	case NL80211_CMD_STA_OPMODE_CHANGED:
 		parse_sta_opmode_changed(tb);
 		break;
+	case NL80211_CMD_STOP_AP:
+		printf("stop ap\n");
+		break;
 	default:
 		printf("unknown event %d (%s)\n",
 		       gnlh->cmd, command_name(gnlh->cmd));
-- 
2.24.1

