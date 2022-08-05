Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABB958AE95
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Aug 2022 19:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbiHERCK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Aug 2022 13:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiHERCJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Aug 2022 13:02:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350BC6C131
        for <linux-wireless@vger.kernel.org>; Fri,  5 Aug 2022 10:02:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D047C617C5
        for <linux-wireless@vger.kernel.org>; Fri,  5 Aug 2022 17:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2070EC433D7;
        Fri,  5 Aug 2022 17:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659718928;
        bh=1+Qb+ix8DYrQCOxf2+36kitT4cPxXf5MGa4SyjGI06Q=;
        h=From:To:Cc:Subject:Date:From;
        b=kYgulyfLHsGYOFJC8x6pP3FCYxLSSjzc3j/NZzAaSSBr84aGu+3axeTCG112zb08y
         nkoOGcCslZAgXeoOaSmtawhTH9rMZOvzJxb8oOFoDxm/Rx+0jAa6U6nHe7mTnvNIxj
         L4Yj+t+7+EVDbQnA6FRtnKfBVCngu7NHoheQgnLdo1IN4U7omkTL/8wm6am0Yxd/of
         dp77LNlRlZtX4YWt3OyavI98xQfg4zMKvSKi163BoCuTSZPu6qKJecoZ5hJS3kXatF
         4C/sApebhpAKL/s6RciA+0Nr983H6ICVTJA4rwMjyVS1Vb9vVn9QNJDdjtybnDvr/D
         Q6WaRzACby9GA==
From:   Seth Forshee <sforshee@kernel.org>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Murtaza Saeed <mnk.saeed@gmail.com>
Subject: [PATCH] wireless-regdb: update 5 GHz rules for PK and add 60 GHz rule
Date:   Fri,  5 Aug 2022 12:02:07 -0500
Message-Id: <20220805170207.121080-1-sforshee@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[1] contains updated information for 5 GHz in PK as well as information
for 60 GHz use. Update the rules to match.

[1] https://www.pta.gov.pk/assets/media/iot_srd_regulatory_framework_01-06-2022.pdf

Cc: Murtaza Saeed <mnk.saeed@gmail.com>
Signed-off-by: Seth Forshee <sforshee@kernel.org>
---
 db.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/db.txt b/db.txt
index 16abf2951e77..07cdf4a29e49 100644
--- a/db.txt
+++ b/db.txt
@@ -1362,8 +1362,14 @@ country PH: DFS-FCC
 country PK: DFS-JP
 	# https://fab.gov.pk/type-approval/
 	# https://pta.gov.pk/media/Pakistan_Table_of_Frequency_Allocations.pdf
-	(2402 - 2482 @ 40), (20)
-	(5725 - 5875 @ 80), (30)
+	# https://www.pta.gov.pk/assets/media/iot_srd_regulatory_framework_01-06-2022.pdf
+	(2402 - 2482 @ 40), (100 mW)
+	(5150 - 5270 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
+	(5270 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW
+	(5470 - 5610 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW
+	(5610 - 5725 @ 80), (200 mW), AUTO-BW
+	(5725 - 5875 @ 80), (1000 mW)
+	(57000 - 66000 @ 2160), (40)
 
 # PL as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
-- 
2.34.1

