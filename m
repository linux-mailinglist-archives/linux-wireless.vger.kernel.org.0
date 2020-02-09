Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5924F156BA0
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2020 17:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgBIQ7P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Feb 2020 11:59:15 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:49166 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBIQ7P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Feb 2020 11:59:15 -0500
Received: from isengard.fritz.box (unknown [84.174.247.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 347B558006E;
        Sun,  9 Feb 2020 17:59:13 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/8] iw: scan: fix buffer over-read in print_ies()
Date:   Sun,  9 Feb 2020 17:58:56 +0100
Message-Id: <20200209165902.44110-3-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200209165902.44110-1-markus.theil@tu-ilmenau.de>
References: <20200209165902.44110-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch correctly checks, if enough data bytes for parsing IEs are
present (-2 in check for type and length). Furthermore, it adds a
nullptr and length check to ease future fuzzing.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 scan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scan.c b/scan.c
index a6cb3bb..14138ca 100644
--- a/scan.c
+++ b/scan.c
@@ -2181,7 +2181,10 @@ void print_ies(unsigned char *ie, int ielen, bool unknown,
 		.ie = ie,
 		.ielen = ielen };
 
-	while (ielen >= 2 && ielen >= ie[1]) {
+	if (ie == NULL || ielen < 0)
+		return;
+
+	while (ielen >= 2 && ielen - 2 >= ie[1]) {
 		if (ie[0] < ARRAY_SIZE(ieprinters) &&
 		    ieprinters[ie[0]].name &&
 		    ieprinters[ie[0]].flags & BIT(ptype)) {
-- 
2.25.0

