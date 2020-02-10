Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECF71570A2
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2020 09:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgBJIOB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Feb 2020 03:14:01 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:51523 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbgBJIOB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Feb 2020 03:14:01 -0500
Received: from isengard.fritz.box (unknown [84.174.247.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 91A62580068;
        Mon, 10 Feb 2020 09:13:59 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 1/2] iw: scan: fix if scope for print_measurement_pilot_tx()
Date:   Mon, 10 Feb 2020 09:13:53 +0100
Message-Id: <20200210081354.10390-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scan.c b/scan.c
index 8f8d8ba..7155cdf 100644
--- a/scan.c
+++ b/scan.c
@@ -1561,9 +1561,10 @@ static void print_measurement_pilot_tx(const uint8_t type, uint8_t len,
 			p[0], p[1], p[2]);
 		len_remaining -= 3;
 
-		if (len > len_remaining)
+		if (len > len_remaining) {
 			printf(" <Parse error, element too short>\n");
 			return;
+		}
 
 		while (p < p + len)
 			printf(" %.2x", *p);
-- 
2.25.0

