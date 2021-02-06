Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D10311E76
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Feb 2021 16:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBFPfV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Feb 2021 10:35:21 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:40988 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhBFPfQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Feb 2021 10:35:16 -0500
Received: from isengard.fritz.box (unknown [87.147.51.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 3E9C5580060;
        Sat,  6 Feb 2021 16:34:34 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/3] rfkill.c: deal with updated struct size
Date:   Sat,  6 Feb 2021 16:34:10 +0100
Message-Id: <20210206153411.19097-2-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210206153411.19097-1-markus.theil@tu-ilmenau.de>
References: <20210206153411.19097-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 rfkill.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rfkill.c b/rfkill.c
index 8cd81fe..6b5ca2c 100644
--- a/rfkill.c
+++ b/rfkill.c
@@ -45,13 +45,14 @@ static void rfkill_event(void)
 		if (n == 0)
 			continue;
 
+		memset(&event, 0, sizeof(event));
 		len = read(fd, &event, sizeof(event));
 		if (len < 0) {
 			perror("Reading of RFKILL events failed");
 			break;
 		}
 
-		if (len != RFKILL_EVENT_SIZE_V1) {
+		if (len < RFKILL_EVENT_SIZE_V1) {
 			fprintf(stderr, "Wrong size of RFKILL event\n");
 			continue;
 		}
@@ -206,6 +207,7 @@ static int rfkill_list(const char *param)
 	}
 
 	while (1) {
+		memset(&event, 0, sizeof(event));
 		len = read(fd, &event, sizeof(event));
 		if (len < 0) {
 			if (errno == EAGAIN)
@@ -214,7 +216,7 @@ static int rfkill_list(const char *param)
 			break;
 		}
 
-		if (len != RFKILL_EVENT_SIZE_V1) {
+		if (len < RFKILL_EVENT_SIZE_V1) {
 			fprintf(stderr, "Wrong size of RFKILL event\n");
 			continue;
 		}
-- 
2.30.0

