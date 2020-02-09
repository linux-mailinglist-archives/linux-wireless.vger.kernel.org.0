Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C723156BA7
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2020 17:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgBIQ7S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Feb 2020 11:59:18 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:49163 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbgBIQ7P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Feb 2020 11:59:15 -0500
Received: from isengard.fritz.box (unknown [84.174.247.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id E4A4C580068;
        Sun,  9 Feb 2020 17:59:12 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 1/8] iw: scan: parse measurement pilot element
Date:   Sun,  9 Feb 2020 17:58:55 +0100
Message-Id: <20200209165902.44110-2-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200209165902.44110-1-markus.theil@tu-ilmenau.de>
References: <20200209165902.44110-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 scan.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/scan.c b/scan.c
index 50a4147..a6cb3bb 100644
--- a/scan.c
+++ b/scan.c
@@ -1530,6 +1530,47 @@ static void print_supp_op_classes(const uint8_t type, uint8_t len,
 		}
 }
 
+static void print_measurement_pilot_tx(const uint8_t type, uint8_t len,
+				       const uint8_t *data,
+				       const struct print_ies_data *ie_buffer)
+{
+	printf("\n");
+	printf("\t\t * interval: %d TUs\n", data[0]);
+
+	if(len <= 1)
+		return;
+
+	uint8_t *p = (uint8_t *) data + 1;
+	uint8_t len_remaining = len - 1;
+	
+	while (len_remaining >=5) {
+		uint8_t subelement_id = *p;
+		++p;
+		uint8_t len = *p;
+		++p;
+
+		len_remaining -= 2;
+
+		/* 802.11-2016 only allows vendor specific elements */
+		if (subelement_id != 221) {
+			printf("\t\t * <Invalid subelement ID %d>\n", subelement_id);
+			return;
+		}
+
+		printf("\t\t * vendor specific: OUI %.2x:%.2x:%.2x, data:",
+			p[0], p[1], p[2]);
+		len_remaining -= 3;
+
+		if (len > len_remaining)
+			printf(" <Parse error, element too short>\n");
+			return;
+
+		while (p < p + len)
+			printf(" %.2x", *p);
+		printf("\n");
+	}
+}
+
 static void print_obss_scan_params(const uint8_t type, uint8_t len,
 				   const uint8_t *data,
 				   const struct print_ies_data *ie_buffer)
@@ -1652,6 +1693,7 @@ static const struct ie_print ieprinters[] = {
 	[45] = { "HT capabilities", print_ht_capa, 26, 26, BIT(PRINT_SCAN), },
 	[47] = { "ERP D4.0", print_erp, 1, 255, BIT(PRINT_SCAN), },
 	[59] = { "Supported operating classes", print_supp_op_classes, 1, 255, BIT(PRINT_SCAN), },
+	[66] = { "Measurement Pilot Transmission", print_measurement_pilot_tx, 1, 255, BIT(PRINT_SCAN), },
 	[74] = { "Overlapping BSS scan params", print_obss_scan_params, 14, 255, BIT(PRINT_SCAN), },
 	[61] = { "HT operation", print_ht_op, 22, 22, BIT(PRINT_SCAN), },
 	[62] = { "Secondary Channel Offset", print_secchan_offs, 1, 1, BIT(PRINT_SCAN), },
-- 
2.25.0

