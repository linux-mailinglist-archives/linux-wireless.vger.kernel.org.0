Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610522F8D65
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Jan 2021 13:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbhAPMxk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Jan 2021 07:53:40 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:36246 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbhAPMxj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Jan 2021 07:53:39 -0500
Received: from legolas.fritz.box (unknown [84.174.243.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 644EA58008F;
        Sat, 16 Jan 2021 13:52:04 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 4/4] rfkill: support hard block reason in C code
Date:   Sat, 16 Jan 2021 13:51:46 +0100
Message-Id: <20210116125146.31932-5-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210116125146.31932-1-markus.theil@tu-ilmenau.de>
References: <20210116125146.31932-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 rfkill.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/rfkill.c b/rfkill.c
index 8cd81fe..7fa5c39 100644
--- a/rfkill.c
+++ b/rfkill.c
@@ -51,15 +51,16 @@ static void rfkill_event(void)
 			break;
 		}
 
-		if (len != RFKILL_EVENT_SIZE_V1) {
+		if (len != RFKILL_EVENT_SIZE_V1 && len != RFKILL_EVENT_SIZE_V1 + 1) {
 			fprintf(stderr, "Wrong size of RFKILL event\n");
 			continue;
 		}
 
 		gettimeofday(&tv, NULL);
-		printf("%ld.%06u: idx %u type %u op %u soft %u hard %u\n",
+		printf("%ld.%06u: idx %u type %u op %u soft %u hard %u hard block reasons 0x%02x\n",
 			(long) tv.tv_sec, (unsigned int) tv.tv_usec,
-			event.idx, event.type, event.op, event.soft, event.hard);
+			event.idx, event.type, event.op, event.soft, event.hard,
+			event.hard_block_reasons);
 		fflush(stdout);
 	}
 
@@ -214,7 +215,7 @@ static int rfkill_list(const char *param)
 			break;
 		}
 
-		if (len != RFKILL_EVENT_SIZE_V1) {
+		if (len != RFKILL_EVENT_SIZE_V1 && len != RFKILL_EVENT_SIZE_V1 + 1) {
 			fprintf(stderr, "Wrong size of RFKILL event\n");
 			continue;
 		}
@@ -242,6 +243,16 @@ static int rfkill_list(const char *param)
 						type2string(event.type));
 		printf("\tSoft blocked: %s\n", event.soft ? "yes" : "no");
 		printf("\tHard blocked: %s\n", event.hard ? "yes" : "no");
+		if (len >= RFKILL_EVENT_SIZE_V1 + 1) {
+			printf("\tHard block reasons: ");
+			if (event.hard_block_reasons == 0)
+				printf("[NONE]");
+			if (event.hard_block_reasons & RFKILL_HARD_BLOCK_NOT_OWNER)
+				printf("[NOT_OWNER]");
+			if (event.hard_block_reasons & RFKILL_HARD_BLOCK_SIGNAL)
+				printf("[SIGNAL]");
+			printf("\n");
+		}
 	}
 
 	close(fd);
-- 
2.30.0

