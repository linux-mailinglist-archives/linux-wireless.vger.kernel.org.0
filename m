Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AF37D0323
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 22:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346488AbjJSU1A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 16:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346397AbjJSU06 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 16:26:58 -0400
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC25116
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 13:26:55 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 47620 invoked from network); 19 Oct 2023 22:26:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1697747212; bh=Q6ZBYELMVHsxNm7isqsjBhnMYfcd4Vz4LHYMwrilyeY=;
          h=From:To:Cc:Subject;
          b=G5mNu6N9acLKUo8vUcaEB16hToA+sy14TD9+pflltWEMJSLIjBIvjOxm1Qu020ES1
           QM9zJFejqv7scYrO/LnP1cY0Fc/OSUO/LB1/0/TEulBjhvitZ+JhE0ORnqyUTxMvnF
           U2xr9pik1all9ajREyBXVmAfW3LcZzqFgy80jMCQ=
Received: from 89-64-13-175.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.175])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-wireless@vger.kernel.org>; 19 Oct 2023 22:26:52 +0200
From:   stf_xl@wp.pl
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>
Subject: [PATCH] MAINTAINERS: drop Helmut Schaa from rt2x00 maintener list
Date:   Thu, 19 Oct 2023 22:26:51 +0200
Message-Id: <20231019202651.518136-1-stf_xl@wp.pl>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 4dc2c7b0474e1b3fb8c54c0569926d64
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [gePk]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Stanislaw Gruszka <stf_xl@wp.pl>

Helmut hasn't been responding to rt2x00 related emails since 2016,
remove him from rt2x00 mainterner list.

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a7bd8bd80e9..122aacf77295 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17926,7 +17926,6 @@ F:	arch/mips/boot/dts/ralink/mt7621*
 
 RALINK RT2X00 WIRELESS LAN DRIVER
 M:	Stanislaw Gruszka <stf_xl@wp.pl>
-M:	Helmut Schaa <helmut.schaa@googlemail.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
 F:	drivers/net/wireless/ralink/rt2x00/
-- 
2.25.4

