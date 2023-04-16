Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F72A6E34AC
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 03:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDPBak (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Apr 2023 21:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDPBaj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Apr 2023 21:30:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7E530E2
        for <linux-wireless@vger.kernel.org>; Sat, 15 Apr 2023 18:30:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4C3E60B5B
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 01:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321FDC433D2;
        Sun, 16 Apr 2023 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681608632;
        bh=bYb6ghmwocp4rX7u+W+xhnCicstTQzYl0xEs2c5+z2U=;
        h=From:To:Cc:Subject:Date:From;
        b=WszKeYGCsw2Vmk+TGfTQaA16kxStCzsOF6bk0YASIv8zyYo6KFV3mJ6wOliodyorv
         YcAPoATMREikjxyFaoJPZrQnMppSl74IcZPiC2ChKL6pzKfPgwIuip9MWBYnt4NLn5
         XAg/hb4ZU3ymoFCbq2C9DVHqHnUnDlTf178a+wk5yw5SHc0cBqcU5T1aeRhVbui3uh
         O3g3FQiNZNC3JjaI25yj12wYrTzmYOJEin8wL4FT2BC3YWHUuXEnluSUqlts3aIoji
         40Y99aTpVszRhT/sJKwQyk4f+KQlyumrzfSXMrNSrQEROZMZAffUU410sX+t5Cgi+k
         KiaK+xAoRknSw==
From:   Seth Forshee <sforshee@kernel.org>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Keshav <the.ridikulus.rat@gmail.com>
Subject: [PATCH] wireless-regdb: update regulatory rules for India (IN)
Date:   Sat, 15 Apr 2023 20:30:31 -0500
Message-Id: <20230416013031.158433-1-sforshee@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Increase the max EIRP for 2.4 GHz to 30 dBm, and add DFS for 5250-5350
MHz and 5470-5725 MHz.

Source:
https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-gsr-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr-1048e-dated-22102018

Signed-off-by: Seth Forshee <sforshee@kernel.org>
---
 db.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index 915a3b94d418..2a7779510cc5 100644
--- a/db.txt
+++ b/db.txt
@@ -850,11 +850,14 @@ country IL: DFS-ETSI
 	# Table B List of conditions, row 68, wireless device using 802.11a/n/ac protocol
 	(5725 - 5875 @ 80), (200 mW), AUTO-BW
 
+# Source:
+# https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-gsr-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
+# https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr-1048e-dated-22102018
 country IN:
-	(2402 - 2482 @ 40), (20)
+	(2402 - 2482 @ 40), (30)
 	(5150 - 5250 @ 80), (30)
-	(5250 - 5350 @ 80), (24)
-	(5470 - 5725 @ 160), (24)
+	(5250 - 5350 @ 80), (24), DFS
+	(5470 - 5725 @ 160), (24), DFS
 	(5725 - 5875 @ 80), (30)
 
 country IR: DFS-JP
-- 
2.34.1

