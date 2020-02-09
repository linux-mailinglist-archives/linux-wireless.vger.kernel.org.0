Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F33156BA3
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2020 17:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgBIQ7Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Feb 2020 11:59:16 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:49172 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgBIQ7P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Feb 2020 11:59:15 -0500
Received: from isengard.fritz.box (unknown [84.174.247.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id BB199580074;
        Sun,  9 Feb 2020 17:59:13 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 4/8] iw: scan: fix buffer over-read in parsing roaming consortium
Date:   Sun,  9 Feb 2020 17:58:58 +0100
Message-Id: <20200209165902.44110-5-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200209165902.44110-1-markus.theil@tu-ilmenau.de>
References: <20200209165902.44110-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ANQP and OI length are always present, increase min. length by 2.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scan.c b/scan.c
index 2d11f81..9a02363 100644
--- a/scan.c
+++ b/scan.c
@@ -1707,7 +1707,7 @@ static const struct ie_print ieprinters[] = {
 	[127] = { "Extended capabilities", print_capabilities, 0, 255, BIT(PRINT_SCAN), },
 	[107] = { "802.11u Interworking", print_interworking, 0, 255, BIT(PRINT_SCAN), },
 	[108] = { "802.11u Advertisement", print_11u_advert, 0, 255, BIT(PRINT_SCAN), },
-	[111] = { "802.11u Roaming Consortium", print_11u_rcon, 0, 255, BIT(PRINT_SCAN), },
+	[111] = { "802.11u Roaming Consortium", print_11u_rcon, 2, 255, BIT(PRINT_SCAN), },
 	[195] = { "Transmit Power Envelope", print_tx_power_envelope, 2, 5, BIT(PRINT_SCAN), },
 };
 
-- 
2.25.0

