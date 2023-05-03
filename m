Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4EE6F5B50
	for <lists+linux-wireless@lfdr.de>; Wed,  3 May 2023 17:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjECPhg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 May 2023 11:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjECPhe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 May 2023 11:37:34 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2475FED
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 08:37:30 -0700 (PDT)
Date:   Wed, 03 May 2023 15:37:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1683128246; x=1683387446;
        bh=FMyyXRiBpi2ZzOsj4yKM1kFIw32QWP9CASHkYRcfdv0=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=ZOYBudaRZy32doE4kwIbMyEWCBQk/tWpMaCw0uEtpdah9kGiW7Sw1xGO6F2dRjuVY
         1I7a6bjPKr5Nt6SkAIOexzqzPbmN6sWFB2gXJUAGgVbE61B8Xfpsfj7NFhxQBMqCa0
         NaqCeV4nntqC+NPLnyX/ayovjaH1tVLsIiko4V/QiHqkK+gZ3oSLE7CZ3UzOaW7JNX
         ddVaFEB/se8lLuks5T74LJcOV9kBKRrRE0Gf4m8xhd70daqJHGiAIXwbOa3YuNpnHv
         ShXHe1OEgTWtrvC/pQ/J2W6MCneT23vmoKse6ewaDhLhBasA0AsVb9IyBosIFwacA7
         ph5cHE+xWLoCQ==
To:     "sforshee@kernel.org" <sforshee@kernel.org>
From:   Tavio Wong <tavio.wong@proton.me>
Cc:     "wireless-regdb@lists.infradead.org" 
        <wireless-regdb@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: [PATCH] wireless-regdb: Update regulatory rules for Hong Kong (HK)
Message-ID: <lPLmWUrjD7qCP9xceeomrJkM3UROE54cq2gp0jV2M-FeSKypWU2OB1smaPcro_p8kRHjXUcZd31egElc_z46nBTC5IMr9l31VNApPck5V6E=@proton.me>
Feedback-ID: 49883000:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update frequency ranges and max EIRP for 2.4 GHz and 5 GHz, and add support=
 for
6 GHz based on latest HK regulations.

Source:
https://www.ofca.gov.hk/filemanager/ofca/en/content_401/hkca1039.pdf (2.4 G=
Hz and 5 GHz)
https://www.ofca.gov.hk/filemanager/ofca/en/content_401/hkca1081.pdf (6 GHz=
)

Signed-off-by: Tavio Wong <tavio.wong@proton.me>
---
 db.txt | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index 8d103b4..ac2429e 100644
--- a/db.txt
+++ b/db.txt
@@ -748,12 +748,16 @@ country GY:
 =09(5490 - 5730 @ 160), (23), DFS
 =09(5735 - 5835 @ 80), (30)

+# Source:
+# https://www.ofca.gov.hk/filemanager/ofca/en/content_401/hkca1039.pdf (2.=
4 GHz and 5 GHz)
+# https://www.ofca.gov.hk/filemanager/ofca/en/content_401/hkca1081.pdf (6 =
GHz)
 country HK: DFS-ETSI
-=09(2402 - 2482 @ 40), (20)
-=09(5170 - 5250 @ 80), (17), AUTO-BW
-=09(5250 - 5330 @ 80), (24), DFS, AUTO-BW
-=09(5490 - 5710 @ 160), (24), DFS
-=09(5735 - 5835 @ 80), (30)
+=09(2400 - 2483.5 @ 40), (36)
+=09(5150 - 5250 @ 80), (23), AUTO-BW, NO-OUTDOOR
+=09(5250 - 5350 @ 80), (23), DFS, AUTO-BW, NO-OUTDOOR
+=09(5470 - 5730 @ 160), (27), DFS
+=09(5730 - 5850 @ 80), (36)
+=09(5925 - 6425 @ 160), (14)

 country HN: DFS-FCC
 =09(2402 - 2482 @ 40), (20)
--
2.40.1
