Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985971572F6
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2020 11:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBJKof (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Feb 2020 05:44:35 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:52399 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgBJKof (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Feb 2020 05:44:35 -0500
Received: from isengard.fritz.box (unknown [84.174.247.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 6FA58580074;
        Mon, 10 Feb 2020 11:44:33 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v2] iw: scan: fix endless loop in print_measurement_pilot_tx
Date:   Mon, 10 Feb 2020 11:44:20 +0100
Message-Id: <20200210104420.1647-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 scan.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/scan.c b/scan.c
index eaa3bef..dbfe44c 100644
--- a/scan.c
+++ b/scan.c
@@ -1548,6 +1548,7 @@ static void print_measurement_pilot_tx(const uint8_t type, uint8_t len,
 		++p;
 		uint8_t len = *p;
 		++p;
+		const uint8_t *end = p + len;
 
 		len_remaining -= 2;
 
@@ -1557,18 +1558,21 @@ static void print_measurement_pilot_tx(const uint8_t type, uint8_t len,
 			return;
 		}
 
-		printf("\t\t * vendor specific: OUI %.2x:%.2x:%.2x, data:",
-			p[0], p[1], p[2]);
-		len_remaining -= 3;
-
-		if (len > len_remaining) {
+		if (len < 3 || len > len_remaining) {
 			printf(" <Parse error, element too short>\n");
 			return;
 		}
 
-		while (p < p + len)
+		printf("\t\t * vendor specific: OUI %.2x:%.2x:%.2x, data:",
+			p[0], p[1], p[2]);
+		/* add only two here and use ++p in while loop */
+		p += 2;
+
+		while (++p < end)
 			printf(" %.2x", *p);
 		printf("\n");
+
+		len_remaining -= len;
 	}
 }
 
-- 
2.25.0

