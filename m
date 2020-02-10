Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD02D157204
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2020 10:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgBJJqZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Feb 2020 04:46:25 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:52014 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgBJJqZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Feb 2020 04:46:25 -0500
Received: from isengard.fritz.box (unknown [84.174.247.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 122EA580074;
        Mon, 10 Feb 2020 10:46:23 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/2] iw: scan: better length checks in print_wifi_wps()
Date:   Mon, 10 Feb 2020 10:46:19 +0100
Message-Id: <20200210094619.14416-2-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210094619.14416-1-markus.theil@tu-ilmenau.de>
References: <20200210094619.14416-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 scan.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/scan.c b/scan.c
index a5beb0e..dbfe44c 100644
--- a/scan.c
+++ b/scan.c
@@ -1829,6 +1829,11 @@ static void print_wifi_wps(const uint8_t type, uint8_t len, const uint8_t *data,
 		switch (subtype) {
 		case 0x104a:
 			tab_on_first(&first);
+			if (sublen < 1) {
+				printf("\t * Version: (invalid "
+				       "length %d)\n", sublen);
+				break;
+			}
 			printf("\t * Version: %d.%d\n", data[4] >> 4, data[4] & 0xF);
 			break;
 		case 0x1011:
@@ -1861,6 +1866,11 @@ static void print_wifi_wps(const uint8_t type, uint8_t len, const uint8_t *data,
 			printf("\t * Model Number: %.*s\n", sublen, data + 4);
 			break;
 		case 0x103b: {
+			if (sublen < 1) {
+				printf("\t * Response Type: (invalid "
+				       "length %d)\n", sublen);
+				break;
+			}
 			__u8 val = data[4];
 			tab_on_first(&first);
 			printf("\t * Response Type: %d%s\n",
@@ -1874,6 +1884,11 @@ static void print_wifi_wps(const uint8_t type, uint8_t len, const uint8_t *data,
 			break;
 		}
 		case 0x1041: {
+			if (sublen < 1) {
+				printf("\t * Selected Registrar: (invalid "
+				       "length %d)\n", sublen);
+				break;
+			}
 			__u8 val = data[4];
 			tab_on_first(&first);
 			printf("\t * Selected Registrar: 0x%x\n", val);
@@ -1884,6 +1899,11 @@ static void print_wifi_wps(const uint8_t type, uint8_t len, const uint8_t *data,
 			printf("\t * Serial Number: %.*s\n", sublen, data + 4);
 			break;
 		case 0x1044: {
+			if (sublen < 1) {
+				printf("\t * Wi-Fi Protected Setup State: (invalid "
+				       "length %d)\n", sublen);
+				break;
+			}
 			__u8 val = data[4];
 			tab_on_first(&first);
 			printf("\t * Wi-Fi Protected Setup State: %d%s%s\n",
@@ -1928,6 +1948,11 @@ static void print_wifi_wps(const uint8_t type, uint8_t len, const uint8_t *data,
 		}
 		case 0x1008:
 		case 0x1053: {
+			if (sublen < 2) {
+				printf("\t * Config methods: (invalid "
+				       "length %d)\n", sublen);
+				break;
+			}
 			__u16 meth = (data[4] << 8) + data[5];
 			bool comma = false;
 			tab_on_first(&first);
-- 
2.25.0

