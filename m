Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 988DB156BA5
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2020 17:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgBIQ7R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Feb 2020 11:59:17 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:49182 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgBIQ7R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Feb 2020 11:59:17 -0500
Received: from isengard.fritz.box (unknown [84.174.247.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id A0847580078;
        Sun,  9 Feb 2020 17:59:14 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 7/8] iw: scan: fix undefined behaviour in rm capa print
Date:   Sun,  9 Feb 2020 17:59:01 +0100
Message-Id: <20200209165902.44110-8-markus.theil@tu-ilmenau.de>
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
 scan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scan.c b/scan.c
index b3e7baa..e2a620a 100644
--- a/scan.c
+++ b/scan.c
@@ -586,10 +586,10 @@ static void print_rm_enabled_capabilities(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
 			    const struct print_ies_data *ie_buffer)
 {
-	__u64 capa = data[0] |
-		     data[1] << 8 |
-		     data[2] << 16 |
-		     data[3] << 24 |
+	__u64 capa = ((__u64) data[0]) |
+		     ((__u64) data[1]) << 8 |
+		     ((__u64) data[2]) << 16 |
+		     ((__u64) data[3]) << 24 |
 		     ((__u64) data[4]) << 32;
 
 	printf("\n");
-- 
2.25.0

