Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE86B1573D7
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2020 13:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgBJMGl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Feb 2020 07:06:41 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:52864 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgBJMGl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Feb 2020 07:06:41 -0500
Received: from localhost.localdomain (unknown [109.41.129.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 3CEBD580074;
        Mon, 10 Feb 2020 13:06:39 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] iw: scan: more length checks for print_wifi_wps()
Date:   Mon, 10 Feb 2020 13:06:35 +0100
Message-Id: <20200210120635.498188-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 scan.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scan.c b/scan.c
index dbfe44c..2dedd64 100644
--- a/scan.c
+++ b/scan.c
@@ -1878,6 +1878,11 @@ static void print_wifi_wps(const uint8_t type, uint8_t len, const uint8_t *data,
 			break;
 		}
 		case 0x103c: {
+			if (sublen < 1) {
+				printf("\t * RF Bands: (invalid "
+				       "length %d)\n", sublen);
+				break;
+			}
 			__u8 val = data[4];
 			tab_on_first(&first);
 			printf("\t * RF Bands: 0x%x\n", val);
@@ -1941,6 +1946,11 @@ static void print_wifi_wps(const uint8_t type, uint8_t len, const uint8_t *data,
 			break;
 		}
 		case 0x1057: {
+			if (sublen < 1) {
+				printf("\t * AP setup locked: (invalid "
+				       "length %d)\n", sublen);
+				break;
+			}
 			__u8 val = data[4];
 			tab_on_first(&first);
 			printf("\t * AP setup locked: 0x%.2x\n", val);
-- 
2.25.0

