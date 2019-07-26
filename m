Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC77575D43
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 05:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfGZDFp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jul 2019 23:05:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfGZDFp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jul 2019 23:05:45 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4215B22C7B;
        Fri, 26 Jul 2019 03:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564110344;
        bh=Y29MUXuDYdstyBzAWyG59lJsLhGluwMoAhM8BIMoREU=;
        h=From:To:Cc:Subject:Date:From;
        b=GMUDSTwS/SwQy5qRmGO3iHdMqztQ3z0MkIBahoQIlYn22Qv+cxKYaiXmTMyE0/nsU
         Pj4Wt7Qic8DLxfuDgW4kk8CHDVxdnndvogDfqqfjUhGbrXJ8CK6yrjJSgIXpDvlDRu
         2nydUMKlMVqb7dmY1LNGtDYIVjzyljr1cWClSSvc=
Received: by wens.tw (Postfix, from userid 1000)
        id BC6525FC41; Fri, 26 Jul 2019 11:05:39 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     seth.forshee@canonical.com
Cc:     Chen-Yu Tsai <wens@csie.org>, wireless-regdb@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH] wireless-regdb: Extend 5470-5725 MHz range to 5730 MHz for Taiwan (TW)
Date:   Fri, 26 Jul 2019 11:05:38 +0800
Message-Id: <20190726030538.16784-1-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
The Linux kernel however does not seem capable of considering them
most restrictive subset of multiple rules.

Since 5725 ~ 5730 MHz belongs to the next range which has looser
requirements, we can do this manually and extend the range by 5 MHz
to make the kernel happy and be able to use channel 144.

Also, looking at the US regulations, which the TW ones are based on,
The DFS range ends at 5730 MHz, while the next range starts at 5735
MHz. This doesn't match the actual regulations, but is skewed to meet
wireless channel boundaries. I prefer the database match the law,
and be adjuested only if necessary.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

I have a vague impression that you asked about the range boundaries
when I first updated the rules for Taiwan. And here we are again.

---
 db.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index 37393e6..2e149b6 100644
--- a/db.txt
+++ b/db.txt
@@ -1249,7 +1249,11 @@ country TW: DFS-FCC
 	# 5.15 ~ 5.25 GHz: 30 dBm for master mode, 23 dBm for clients
 	(5150 - 5250 @ 80), (23), AUTO-BW
 	(5250 - 5350 @ 80), (23), DFS, AUTO-BW
-	(5470 - 5725 @ 160), (23), DFS
+	# This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
+	# Since 5725 ~ 5730 MHz belongs to the next range which has looser
+	# requirements, we can extend the range by 5 MHz to make the kernel
+	# happy and be able to use channel 144.
+	(5470 - 5730 @ 160), (23), DFS
 	(5725 - 5850 @ 80), (30)
 	# 60g band, LP0002 section 3.13.1.1 (3)(C), EIRP=40dBm(43dBm peak)
 	(57000 - 66000 @ 2160), (40)
-- 
2.20.1

