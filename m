Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13639155B30
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 16:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgBGPyO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 10:54:14 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:41605 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgBGPyO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 10:54:14 -0500
Received: from localhost.localdomain (unknown [109.41.128.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 67C7C580075;
        Fri,  7 Feb 2020 16:54:12 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 1/3] iw: scan: add missing word for rm capabilities
Date:   Fri,  7 Feb 2020 16:54:04 +0100
Message-Id: <20200207155406.8985-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scan.c b/scan.c
index fd522d4..a07636a 100644
--- a/scan.c
+++ b/scan.c
@@ -609,7 +609,7 @@ static void print_rm_enabled_capabilities(const uint8_t type, uint8_t len,
 	PRINT_RM_CAPA(2, "Parallel Measurements");
 	PRINT_RM_CAPA(3, "Repeated Measurements");
 	PRINT_RM_CAPA(4, "Beacon Passive Measurement");
-	PRINT_RM_CAPA(5, "Beacon Active");
+	PRINT_RM_CAPA(5, "Beacon Active Measurement");
 	PRINT_RM_CAPA(6, "Beacon Table Measurement");
 	PRINT_RM_CAPA(7, "Beacon Measurement Reporting Conditions");
 	PRINT_RM_CAPA(8, "Frame Measurement");
-- 
2.25.0

