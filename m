Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C321156BA4
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2020 17:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgBIQ7R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Feb 2020 11:59:17 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:49183 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgBIQ7R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Feb 2020 11:59:17 -0500
Received: from isengard.fritz.box (unknown [84.174.247.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id E2A6858007B;
        Sun,  9 Feb 2020 17:59:14 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 8/8] iw: scan: fix undefined behaviour in print_vht_capa()
Date:   Sun,  9 Feb 2020 17:59:02 +0100
Message-Id: <20200209165902.44110-9-markus.theil@tu-ilmenau.de>
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
 scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scan.c b/scan.c
index e2a620a..8f8d8ba 100644
--- a/scan.c
+++ b/scan.c
@@ -1473,8 +1473,8 @@ static void print_vht_capa(const uint8_t type, uint8_t len, const uint8_t *data,
 			   const struct print_ies_data *ie_buffer)
 {
 	printf("\n");
-	print_vht_info(data[0] | (data[1] << 8) |
-		       (data[2] << 16) | (data[3] << 24),
+	print_vht_info((__u32) data[0] | ((__u32)data[1] << 8) |
+		       ((__u32)data[2] << 16) | ((__u32)data[3] << 24),
 		       data + 4);
 }
 
-- 
2.25.0

