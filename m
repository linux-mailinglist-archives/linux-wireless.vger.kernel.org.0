Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A01C155B32
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 16:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgBGPyQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 10:54:16 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:41611 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgBGPyP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 10:54:15 -0500
Received: from localhost.localdomain (unknown [109.41.128.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 575A4580078;
        Fri,  7 Feb 2020 16:54:13 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 3/3] iw: scan: parse tx power envelope
Date:   Fri,  7 Feb 2020 16:54:06 +0100
Message-Id: <20200207155406.8985-3-markus.theil@tu-ilmenau.de>
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
 scan.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/scan.c b/scan.c
index 57bb463..50a4147 100644
--- a/scan.c
+++ b/scan.c
@@ -1224,6 +1224,35 @@ static void print_11u_rcon(const uint8_t type, uint8_t len, const uint8_t *data,
 	}
 }
 
+static void print_tx_power_envelope(const uint8_t type, uint8_t len, 
+				    const uint8_t *data,
+				    const struct print_ies_data *ie_buffer)
+{
+	const uint8_t local_max_tx_power_count = data[0] & 7;
+	const uint8_t local_max_tx_power_unit_interp = (data[0] >> 3) & 7;
+	int i;
+
+	printf("\n");
+	const char *power_names[] = {
+		"Local Maximum Transmit Power For 20 MHz",
+		"Local Maximum Transmit Power For 40 MHz",
+		"Local Maximum Transmit Power For 80 MHz",
+		"Local Maximum Transmit Power For 160/80+80 MHz",
+	};
+	if (local_max_tx_power_count + 2 != len)
+		return;
+	if (local_max_tx_power_unit_interp != 0)
+		return;
+	for (i = 0; i < local_max_tx_power_count + 1; ++i) {
+		int8_t power_val = ((int8_t)data[1 + i]) >> 1;
+		int8_t point5 = data[1 + i] & 1;
+		if (point5)
+			printf("\t\t * %s: %i.5 dBm\n", power_names[i], power_val);
+		else
+			printf("\t\t * %s: %i dBm\n", power_names[i], power_val);
+	}
+}
+
 static const char *ht_secondary_offset[4] = {
 	"no secondary",
 	"above",
@@ -1637,6 +1666,7 @@ static const struct ie_print ieprinters[] = {
 	[107] = { "802.11u Interworking", print_interworking, 0, 255, BIT(PRINT_SCAN), },
 	[108] = { "802.11u Advertisement", print_11u_advert, 0, 255, BIT(PRINT_SCAN), },
 	[111] = { "802.11u Roaming Consortium", print_11u_rcon, 0, 255, BIT(PRINT_SCAN), },
+	[195] = { "Transmit Power Envelope", print_tx_power_envelope, 2, 5, BIT(PRINT_SCAN), },
 };
 
 static void print_wifi_wpa(const uint8_t type, uint8_t len, const uint8_t *data,
-- 
2.25.0

