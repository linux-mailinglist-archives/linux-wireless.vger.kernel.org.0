Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 889C2155B31
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 16:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgBGPyP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 10:54:15 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:41608 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgBGPyP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 10:54:15 -0500
Received: from localhost.localdomain (unknown [109.41.128.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id D8B21580076;
        Fri,  7 Feb 2020 16:54:12 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/3] iw: scan: parse 'supported Operating Classes element'
Date:   Fri,  7 Feb 2020 16:54:05 +0100
Message-Id: <20200207155406.8985-2-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207155406.8985-1-markus.theil@tu-ilmenau.de>
References: <20200207155406.8985-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 scan.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/scan.c b/scan.c
index a07636a..57bb463 100644
--- a/scan.c
+++ b/scan.c
@@ -1467,6 +1467,40 @@ static void print_vht_oper(const uint8_t type, uint8_t len, const uint8_t *data,
 	printf("\t\t * VHT basic MCS set: 0x%.2x%.2x\n", data[4], data[3]);
 }
 
+static void print_supp_op_classes(const uint8_t type, uint8_t len,
+				  const uint8_t *data,
+				  const struct print_ies_data *ie_buffer)
+{
+	uint8_t *p = (uint8_t*) data;
+	const uint8_t *next_data = p + len;
+	int zero_delimiter = 0;
+	int one_hundred_thirty_delimiter = 0;
+	
+	printf("\n");
+	printf("\t\t * current operating class: %d\n", *p);
+	while (p++ < next_data) {
+		if (*p == 130) {
+			one_hundred_thirty_delimiter = 1;
+			break;
+		}
+		if (*p == 0) {
+			zero_delimiter = 0;
+			break;
+		}
+		printf("\t\t * operating class: %d\n", *p);
+	}
+	if (one_hundred_thirty_delimiter)
+		while (p++ < next_data) {
+			printf("\t\t * current operating class extension: %d\n", *p);
+		}
+	if (zero_delimiter)
+		while (p++ < next_data - 1) {
+			printf("\t\t * operating class duple: %d %d\n", p[0], p[1]);
+			if (*p == 0)
+				break;
+		}
+}
+
 static void print_obss_scan_params(const uint8_t type, uint8_t len,
 				   const uint8_t *data,
 				   const struct print_ies_data *ie_buffer)
@@ -1588,6 +1622,7 @@ static const struct ie_print ieprinters[] = {
 	[42] = { "ERP", print_erp, 1, 255, BIT(PRINT_SCAN), },
 	[45] = { "HT capabilities", print_ht_capa, 26, 26, BIT(PRINT_SCAN), },
 	[47] = { "ERP D4.0", print_erp, 1, 255, BIT(PRINT_SCAN), },
+	[59] = { "Supported operating classes", print_supp_op_classes, 1, 255, BIT(PRINT_SCAN), },
 	[74] = { "Overlapping BSS scan params", print_obss_scan_params, 14, 255, BIT(PRINT_SCAN), },
 	[61] = { "HT operation", print_ht_op, 22, 22, BIT(PRINT_SCAN), },
 	[62] = { "Secondary Channel Offset", print_secchan_offs, 1, 1, BIT(PRINT_SCAN), },
-- 
2.25.0

