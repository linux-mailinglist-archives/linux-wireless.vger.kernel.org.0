Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FE375272A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jul 2023 17:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjGMPdd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jul 2023 11:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjGMPdJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jul 2023 11:33:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF9E1B6
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 08:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E728B6191F
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 15:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37571C433C8;
        Thu, 13 Jul 2023 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689262349;
        bh=WQFjEtFufJ9Tdlobk76SGYhT3e/x20/LKDpgwBze+BA=;
        h=From:To:Cc:Subject:Date:From;
        b=Z3+RFsMdCjwLDYOXruyPVEhTKiHy2u4smI2oKWh3jO16x8rEXfmeuJ/tjELVa21wH
         lVPpCFigcrwoJAYerudJlTW4HUJA+IRaAZn8sE0MQDUcDy3Ms58kcoPiHFdheVpcjs
         5PqxJGUcLTl6uagiaRgc5DKMgpzfKWPXasvmXNxQcFoQO2AHgmfe0ZeSaxFO5hgrLX
         dE0trSoZZNApx3K6g2lvstWms3+GC6L7FmdZthD3fmiri4kAZwvqsqu7K5crypTLRR
         lxST6PT9yc6gTCLxocLy0/1aHWMwIDecDUOy/L3yqZ1kzzQ9oH1MV5a7HuVaf5g9cv
         vmH64jMINL64g==
From:   Seth Forshee <sforshee@kernel.org>
To:     wireless-regdb@lists.infradead.org
Cc:     Atahan Bostan <ooatahanturan@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?wireless-regdb:=20Update=20regulatory=20info=20?= =?UTF-8?q?for=20T=C3=BCrkiye=20(TR)?=
Date:   Thu, 13 Jul 2023 10:32:28 -0500
Message-ID: <20230713153228.241774-1-sforshee@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Based on [1], add support for 6GHz and make minor adjustments to other
ranges.

[1] https://www.btk.gov.tr/uploads/pages/ftm-teknik-olcutler-ek-5.pdf

Signed-off-by: Seth Forshee <sforshee@kernel.org>
---
 db.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/db.txt b/db.txt
index ef4e60972d8a..0af4f9458e0b 100644
--- a/db.txt
+++ b/db.txt
@@ -1676,14 +1676,14 @@ country TN: DFS-ETSI
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 
 # Source:
-# By-Law on Short Range Radio Devices (SRD) Oct 2015
-# https://www.btk.gov.tr/File/?path=ROOT%2f1%2fDocuments%2fOrdinance%2fBY%2DLAW%20ON%20SHORT%20RANGE%20DEVICES.pdf
-# Article 8
+# Technical Criteria for Radio Devices and Systems Excluded from Frequency Allocation, Sept 9, 2022
+# https://www.btk.gov.tr/uploads/pages/ftm-teknik-olcutler-ek-5.pdf
 country TR: DFS-ETSI
 	(2400 - 2483.5 @ 40), (20)
-	(5170 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW
-	(5250 - 5330 @ 80), (20), DFS, NO-OUTDOOR, AUTO-BW
-	(5470 - 5725 @ 160), (27), DFS
+	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5330 @ 80), (20), DFS, NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (27), DFS, wmmrule=ETSI
+	(5495 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
 
-- 
2.41.0

