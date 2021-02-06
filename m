Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE1A311E77
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Feb 2021 16:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhBFPf7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Feb 2021 10:35:59 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:41000 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhBFPf7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Feb 2021 10:35:59 -0500
Received: from isengard.fritz.box (unknown [87.147.51.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 65CE758006C;
        Sat,  6 Feb 2021 16:34:34 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 3/3] rfkill: support hard block reason in C code
Date:   Sat,  6 Feb 2021 16:34:11 +0100
Message-Id: <20210206153411.19097-3-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210206153411.19097-1-markus.theil@tu-ilmenau.de>
References: <20210206153411.19097-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 rfkill.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/rfkill.c b/rfkill.c
index 6b5ca2c..253ee46 100644
--- a/rfkill.c
+++ b/rfkill.c
@@ -58,9 +58,10 @@ static void rfkill_event(void)
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
 
@@ -244,6 +245,16 @@ static int rfkill_list(const char *param)
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

