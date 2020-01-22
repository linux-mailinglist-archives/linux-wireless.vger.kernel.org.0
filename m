Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A87145CDA
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2020 21:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgAVUGd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jan 2020 15:06:33 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:53990 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgAVUGc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jan 2020 15:06:32 -0500
Received: from legolas.fritz.box (unknown [91.53.47.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 5663158007B;
        Wed, 22 Jan 2020 21:06:30 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] iw: scan: print radio measurement capabilities
Date:   Wed, 22 Jan 2020 21:06:16 +0100
Message-Id: <20200122200616.7897-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 scan.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/scan.c b/scan.c
index bfd39e4..fd522d4 100644
--- a/scan.c
+++ b/scan.c
@@ -582,6 +582,61 @@ static void print_supprates(const uint8_t type, uint8_t len,
 	printf("\n");
 }
 
+static void print_rm_enabled_capabilities(const uint8_t type, uint8_t len,
+			    const uint8_t *data,
+			    const struct print_ies_data *ie_buffer)
+{
+	__u64 capa = data[0] |
+		     data[1] << 8 |
+		     data[2] << 16 |
+		     data[3] << 24 |
+		     ((__u64) data[4]) << 32;
+
+	printf("\n");
+	printf("\t\tCapabilities: 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
+							     data[0], data[1],
+							     data[2], data[3],
+							     data[4]);
+
+#define PRINT_RM_CAPA(_bit, _str) \
+	do { \
+		if (capa & BIT(_bit)) \
+			printf("\t\t\t" _str "\n"); \
+	} while (0)
+
+	PRINT_RM_CAPA(0, "Link Measurement");
+	PRINT_RM_CAPA(1, "Neighbor Report");
+	PRINT_RM_CAPA(2, "Parallel Measurements");
+	PRINT_RM_CAPA(3, "Repeated Measurements");
+	PRINT_RM_CAPA(4, "Beacon Passive Measurement");
+	PRINT_RM_CAPA(5, "Beacon Active");
+	PRINT_RM_CAPA(6, "Beacon Table Measurement");
+	PRINT_RM_CAPA(7, "Beacon Measurement Reporting Conditions");
+	PRINT_RM_CAPA(8, "Frame Measurement");
+	PRINT_RM_CAPA(9, "Channel Load");
+	PRINT_RM_CAPA(10, "Noise Histogram Measurement");
+	PRINT_RM_CAPA(11, "Statistics Measurement");
+	PRINT_RM_CAPA(12, "LCI Measurement");
+	PRINT_RM_CAPA(13, "LCI Azimuth");
+	PRINT_RM_CAPA(14, "Transmit Stream/Category Measurement");
+	PRINT_RM_CAPA(15, "Triggered Transmit Stream/Category");
+	PRINT_RM_CAPA(16, "AP Channel Report");
+	PRINT_RM_CAPA(17, "RM MIB Capability");
+
+	PRINT_RM_CAPA(27, "Measurement Pilot Transmission Information");
+	PRINT_RM_CAPA(28, "Neighbor Report TSF Offset");
+	PRINT_RM_CAPA(29, "RCPI Measurement");
+	PRINT_RM_CAPA(30, "RSNI Measurement");
+	PRINT_RM_CAPA(31, "BSS Average Access Delay");
+	PRINT_RM_CAPA(32, "BSS Available Admission");
+	PRINT_RM_CAPA(33, "Antenna");
+	PRINT_RM_CAPA(34, "FTM Range Report");
+	PRINT_RM_CAPA(35, "Civic Location Measurement");
+
+	printf("\t\tNonoperating Channel Max Measurement Duration: %i\n", data[3] >> 5);
+	printf("\t\tMeasurement Pilot Capability: %i\n", data[4] & 7);
+}
+
 static void print_ds(const uint8_t type, uint8_t len, const uint8_t *data,
 		     const struct print_ies_data *ie_buffer)
 {
@@ -1540,6 +1595,7 @@ static const struct ie_print ieprinters[] = {
 	[192] = { "VHT operation", print_vht_oper, 5, 255, BIT(PRINT_SCAN), },
 	[48] = { "RSN", print_rsn, 2, 255, BIT(PRINT_SCAN), },
 	[50] = { "Extended supported rates", print_supprates, 0, 255, BIT(PRINT_SCAN), },
+	[70] = { "RM enabled capabilities", print_rm_enabled_capabilities, 5, 5, BIT(PRINT_SCAN), },
 	[113] = { "MESH Configuration", print_mesh_conf, 7, 7, BIT(PRINT_SCAN), },
 	[114] = { "MESH ID", print_ssid, 0, 32, BIT(PRINT_SCAN) | BIT(PRINT_LINK), },
 	[127] = { "Extended capabilities", print_capabilities, 0, 255, BIT(PRINT_SCAN), },
-- 
2.25.0

