Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B565BB49E
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 01:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiIPXHY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 19:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiIPXHW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 19:07:22 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FD6BB6AA
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 16:07:22 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1oZKQa-00071y-28;
        Sat, 17 Sep 2022 01:07:20 +0200
Date:   Sat, 17 Sep 2022 00:07:15 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/15] rt2x00: move helper functions up in file
Message-ID: <YyUBox9ZFftKHXkD@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move register access helper functions up to the head of the file so
they can be used in all functions.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 32b8867b7aa1e2..1cb30a992841e3 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -198,6 +198,26 @@ static void rt2800_rfcsr_write_dccal(struct rt2x00_dev *rt2x00dev,
 	rt2800_rfcsr_write_bank(rt2x00dev, 7, reg, value);
 }
 
+static void rt2800_bbp_dcoc_write(struct rt2x00_dev *rt2x00dev,
+				  const u8 reg, const u8 value)
+{
+	rt2800_bbp_write(rt2x00dev, 158, reg);
+	rt2800_bbp_write(rt2x00dev, 159, value);
+}
+
+static u8 rt2800_bbp_dcoc_read(struct rt2x00_dev *rt2x00dev, const u8 reg)
+{
+	rt2800_bbp_write(rt2x00dev, 158, reg);
+	return rt2800_bbp_read(rt2x00dev, 159);
+}
+
+static void rt2800_bbp_glrt_write(struct rt2x00_dev *rt2x00dev,
+				  const u8 reg, const u8 value)
+{
+	rt2800_bbp_write(rt2x00dev, 195, reg);
+	rt2800_bbp_write(rt2x00dev, 196, value);
+}
+
 static u8 rt2800_rfcsr_read(struct rt2x00_dev *rt2x00dev,
 			    const unsigned int word)
 {
@@ -6954,26 +6974,6 @@ static void rt2800_init_bbp_5592(struct rt2x00_dev *rt2x00dev)
 		rt2800_bbp_write(rt2x00dev, 103, 0xc0);
 }
 
-static void rt2800_bbp_glrt_write(struct rt2x00_dev *rt2x00dev,
-				  const u8 reg, const u8 value)
-{
-	rt2800_bbp_write(rt2x00dev, 195, reg);
-	rt2800_bbp_write(rt2x00dev, 196, value);
-}
-
-static void rt2800_bbp_dcoc_write(struct rt2x00_dev *rt2x00dev,
-				  const u8 reg, const u8 value)
-{
-	rt2800_bbp_write(rt2x00dev, 158, reg);
-	rt2800_bbp_write(rt2x00dev, 159, value);
-}
-
-static u8 rt2800_bbp_dcoc_read(struct rt2x00_dev *rt2x00dev, const u8 reg)
-{
-	rt2800_bbp_write(rt2x00dev, 158, reg);
-	return rt2800_bbp_read(rt2x00dev, 159);
-}
-
 static void rt2800_init_bbp_6352(struct rt2x00_dev *rt2x00dev)
 {
 	u8 bbp;
-- 
2.37.3

