Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F276C156BA8
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2020 17:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgBIQ7S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Feb 2020 11:59:18 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:49181 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgBIQ7R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Feb 2020 11:59:17 -0500
Received: from isengard.fritz.box (unknown [84.174.247.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 558B7580076;
        Sun,  9 Feb 2020 17:59:14 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 6/8] iw: scan: fix buffer over-read in print_p2p
Date:   Sun,  9 Feb 2020 17:59:00 +0100
Message-Id: <20200209165902.44110-7-markus.theil@tu-ilmenau.de>
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
 scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scan.c b/scan.c
index f57925d..b3e7baa 100644
--- a/scan.c
+++ b/scan.c
@@ -2036,7 +2036,7 @@ static inline void print_p2p(const uint8_t type, uint8_t len,
 		case 0x12: /* invitation flags */
 		case 0xdd: /* vendor specific */
 		default: {
-			const __u8 *subdata = data + 4;
+			const __u8 *subdata = data + 3;
 			__u16 tmplen = sublen;
 
 			tab_on_first(&first);
-- 
2.25.0

