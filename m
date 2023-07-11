Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7951174F3DF
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jul 2023 17:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjGKPlu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jul 2023 11:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjGKPlf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jul 2023 11:41:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1073591
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jul 2023 08:40:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47AA761426
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jul 2023 15:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8714AC433C8;
        Tue, 11 Jul 2023 15:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689089986;
        bh=hh+zSKH52avPICY47P3W5frjtrDy6rqfe9rDpzZTvrk=;
        h=From:To:Cc:Subject:Date:From;
        b=YJVj7RhbFKX0Vj7r+Q64NTHjwhqLVJBTID8M9CincxguddVuEdON4llIZCXjlA1+E
         0/71oWs/njsZ+H1rWomsx90aH+dKNXLsBF/TQedDoZkka8CaYIJ1GcaBbgra1Swh+T
         wlJ+qZBjZk0y7e28JQbrntL39hwEedSyxesJ5B0smh2IUHwMwiAvkecTel2HUSb9nB
         URBmZ05BcaatwjMu6WJnoe0ANu7XppR1GGUohWgrB2npZoooj+jQUL27k5s4WxUY+f
         PiCfCo93ObM1QZtKjwzUDo9LxghiorURtft8A3hbq/5+YTT6PbSt60HoyAWqCiP0qL
         ihn2sdSM3ycdQ==
From:   Seth Forshee <sforshee@kernel.org>
To:     wireless-regdb@lists.infradead.org
Cc:     Mohammed Ismail <m.ismael@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH] wireless-regdb: Update regulatory rules for Egypt (EG) from March 2022 guidelines
Date:   Tue, 11 Jul 2023 10:39:45 -0500
Message-ID: <20230711153945.1004817-1-sforshee@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The radio spectrum guidelines document from March 2022 [1] contains no
restriction on outdoor operation and allows use of 57-66 GHz.

[1] https://www.tra.gov.eg/wp-content/uploads/2022/03/EGY-NTRA-March-2022-SRD_English_Final.pdf

Signed-off-by: Seth Forshee <sforshee@kernel.org>
---
 db.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index ef4e60972d8a..f6121326a9b0 100644
--- a/db.txt
+++ b/db.txt
@@ -575,11 +575,12 @@ country EE: DFS-ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
-# https://www.tra.gov.eg/en/industry/importing-of-equipment/Pages/Regulations-for-use-of-Wireless-Networks-Devices.aspx
+# https://www.tra.gov.eg/wp-content/uploads/2022/03/EGY-NTRA-March-2022-SRD_English_Final.pdf
 country EG: DFS-ETSI
 	(2402 - 2483.5 @ 40), (20)
-	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5150 - 5250 @ 80), (23), AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
+	(57000 - 66000 @ 2160), (40)
 
 # ES as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
-- 
2.41.0

