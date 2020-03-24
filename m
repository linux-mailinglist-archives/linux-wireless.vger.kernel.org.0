Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7163A19162E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 17:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgCXQVz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 12:21:55 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:44237 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbgCXQVy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 12:21:54 -0400
Received: from sauron.fritz.box (unknown [87.147.56.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 9F465580068;
        Tue, 24 Mar 2020 17:21:52 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] iw: event: also handle reg change on wiphy
Date:   Tue, 24 Mar 2020 17:21:49 +0100
Message-Id: <20200324162149.3178-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 event.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/event.c b/event.c
index 51aff97..b132b17 100644
--- a/event.c
+++ b/event.c
@@ -931,8 +931,12 @@ static int print_event(struct nl_msg *msg, void *arg)
 	case NL80211_CMD_SCHED_SCAN_RESULTS:
 		printf("got scheduled scan results\n");
 		break;
+	case NL80211_CMD_WIPHY_REG_CHANGE:
 	case NL80211_CMD_REG_CHANGE:
-		printf("regulatory domain change: ");
+		if(gnlh->cmd == NL80211_CMD_WIPHY_REG_CHANGE)
+			printf("regulatory domain change (phy): ");
+		else
+			printf("regulatory domain change: ");
 
 		reg_type = nla_get_u8(tb[NL80211_ATTR_REG_TYPE]);
 
-- 
2.26.0

