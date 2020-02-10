Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 843E11570A3
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2020 09:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgBJIOC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Feb 2020 03:14:02 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:51526 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgBJIOB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Feb 2020 03:14:01 -0500
Received: from isengard.fritz.box (unknown [84.174.247.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id DC1A0580075;
        Mon, 10 Feb 2020 09:13:59 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/2] iw: scan: fix some format string warnings found by clang
Date:   Mon, 10 Feb 2020 09:13:54 +0100
Message-Id: <20200210081354.10390-2-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210081354.10390-1-markus.theil@tu-ilmenau.de>
References: <20200210081354.10390-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 scan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scan.c b/scan.c
index 7155cdf..98c5c10 100644
--- a/scan.c
+++ b/scan.c
@@ -1131,10 +1131,10 @@ static void print_interworking(const uint8_t type, uint8_t len,
 		printf("\t\tVenue Type: %i\n", (int)(data[2]));
 	}
 	if (len == 9)
-		printf("\t\tHESSID: %02hx:%02hx:%02hx:%02hx:%02hx:%02hx\n",
+		printf("\t\tHESSID: %02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx\n",
 		       data[3], data[4], data[5], data[6], data[7], data[8]);
 	else if (len == 7)
-		printf("\t\tHESSID: %02hx:%02hx:%02hx:%02hx:%02hx:%02hx\n",
+		printf("\t\tHESSID: %02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx\n",
 		       data[1], data[2], data[3], data[4], data[5], data[6]);
 }
 
@@ -1193,7 +1193,7 @@ static void print_11u_rcon(const uint8_t type, uint8_t len, const uint8_t *data,
 			printf("Invalid IE length.\n");
 		} else {
 			for (idx = 0; idx < ln0; idx++) {
-				printf("%02hx", data[2 + idx]);
+				printf("%02hhx", data[2 + idx]);
 			}
 			printf("\n");
 		}
@@ -1205,7 +1205,7 @@ static void print_11u_rcon(const uint8_t type, uint8_t len, const uint8_t *data,
 			printf("Invalid IE length.\n");
 		} else {
 			for (idx = 0; idx < ln1; idx++) {
-				printf("%02hx", data[2 + ln0 + idx]);
+				printf("%02hhx", data[2 + ln0 + idx]);
 			}
 			printf("\n");
 		}
@@ -1217,7 +1217,7 @@ static void print_11u_rcon(const uint8_t type, uint8_t len, const uint8_t *data,
 			printf("Invalid IE length.\n");
 		} else {
 			for (idx = 0; idx < ln2; idx++) {
-				printf("%02hx", data[2 + ln0 + ln1 + idx]);
+				printf("%02hhx", data[2 + ln0 + ln1 + idx]);
 			}
 			printf("\n");
 		}
-- 
2.25.0

