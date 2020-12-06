Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8500A2D0282
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 11:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgLFKRg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 05:17:36 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:50195 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgLFKRf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 05:17:35 -0500
Received: from isengard.fritz.box (unknown [87.147.53.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 4151F58007E;
        Sun,  6 Dec 2020 11:16:54 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] iw: print ctrl port tx status event
Date:   Sun,  6 Dec 2020 11:16:42 +0100
Message-Id: <20201206101642.3606-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 event.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/event.c b/event.c
index 8dd4345..61395f8 100644
--- a/event.c
+++ b/event.c
@@ -1171,6 +1171,11 @@ static int print_event(struct nl_msg *msg, void *arg)
 			(unsigned long long)nla_get_u64(tb[NL80211_ATTR_COOKIE]),
 			tb[NL80211_ATTR_ACK] ? "acked" : "no ack");
 		break;
+	case NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS:
+		printf("ctrl. port TX status (cookie %llx): %s\n",
+			(unsigned long long)nla_get_u64(tb[NL80211_ATTR_COOKIE]),
+			tb[NL80211_ATTR_ACK] ? "acked" : "no ack");
+		break;
 	case NL80211_CMD_PMKSA_CANDIDATE:
 		printf("PMKSA candidate found\n");
 		break;
-- 
2.29.2

