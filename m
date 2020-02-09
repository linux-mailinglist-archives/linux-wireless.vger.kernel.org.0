Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8563156BA1
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2020 17:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgBIQ7P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Feb 2020 11:59:15 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:49169 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgBIQ7P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Feb 2020 11:59:15 -0500
Received: from isengard.fritz.box (unknown [84.174.247.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 77DFE580073;
        Sun,  9 Feb 2020 17:59:13 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 3/8] iw: scan: fix buffer over-read in operation class parsing
Date:   Sun,  9 Feb 2020 17:58:57 +0100
Message-Id: <20200209165902.44110-4-markus.theil@tu-ilmenau.de>
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
 scan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scan.c b/scan.c
index 14138ca..2d11f81 100644
--- a/scan.c
+++ b/scan.c
@@ -1507,7 +1507,7 @@ static void print_supp_op_classes(const uint8_t type, uint8_t len,
 	
 	printf("\n");
 	printf("\t\t * current operating class: %d\n", *p);
-	while (p++ < next_data) {
+	while (++p < next_data) {
 		if (*p == 130) {
 			one_hundred_thirty_delimiter = 1;
 			break;
@@ -1519,11 +1519,11 @@ static void print_supp_op_classes(const uint8_t type, uint8_t len,
 		printf("\t\t * operating class: %d\n", *p);
 	}
 	if (one_hundred_thirty_delimiter)
-		while (p++ < next_data) {
+		while (++p < next_data) {
 			printf("\t\t * current operating class extension: %d\n", *p);
 		}
 	if (zero_delimiter)
-		while (p++ < next_data - 1) {
+		while (++p < next_data - 1) {
 			printf("\t\t * operating class duple: %d %d\n", p[0], p[1]);
 			if (*p == 0)
 				break;
-- 
2.25.0

