Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F4131AB18
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Feb 2021 12:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhBMLtp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Feb 2021 06:49:45 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:52873 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhBMLto (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Feb 2021 06:49:44 -0500
Received: from legolas.fritz.box (unknown [84.174.249.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id E7E5558004F;
        Sat, 13 Feb 2021 12:49:02 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] iw: fix pointer arithmetic in __print_he_capa
Date:   Sat, 13 Feb 2021 12:48:53 +0100
Message-Id: <20210213114853.17276-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Found by fuzzing with clang fuzzer.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util.c b/util.c
index 12ba218..9f21f5f 100644
--- a/util.c
+++ b/util.c
@@ -1160,7 +1160,7 @@ static void __print_he_capa(const __u16 *mac_cap,
 
 	/* Caller didn't provide ppet; infer it, if there's trailing space. */
 	if (!ppet) {
-		ppet = (const void *)(mcs_set + mcs_used);
+		ppet = (const void *)((const __u8 *)mcs_set + mcs_used);
 		if (mcs_used < mcs_len)
 			ppet_len = mcs_len - mcs_used;
 		else
-- 
2.30.1

