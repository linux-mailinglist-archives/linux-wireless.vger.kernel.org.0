Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38C64E622A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Mar 2022 12:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349685AbiCXLMx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Mar 2022 07:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244414AbiCXLMv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Mar 2022 07:12:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9E069CD5
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 04:11:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6FD061957
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 11:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD98C340EC;
        Thu, 24 Mar 2022 11:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648120279;
        bh=3sDJdZuqmQRonT4XtcCSSuJTz3274fknJIf1Sa9lSsY=;
        h=From:To:Cc:Subject:Date:From;
        b=UwhY/YH0tgHiPegDTfRjEh/pv9ivU8HNfs8i5+GgGByQ12csRDwEXvLV6R/13xpxG
         mJ91WqJ5eCvPUF7uDzVPgx5WVSnL59jmQQ0KwDVpcxe/vyqnBgb44qbcSRJVZBjMKO
         HTedaN1IjexDA8Y8gTdNScxwGR6vR5Jlnce8NAbNzfHFRU22YHuteAw0rA/fg4n6Gs
         CNYm5ZfXS6ZQFyvH89PaxPGKsdD4tiffQ5cMm2oFEdL69Va+VmahQEBZMBiRUCwkAV
         NyXmGNnw7SPrMWhz9uZ6D7bQ80ljKJn7ZX1GvZyWqnhQbS+6MQ27EyQle4CTHZ+8ko
         8HzK6xpD/2NIg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        nbd@nbd.name
Subject: [PATCH] MAINTAINERS: updated Lorenzo's email address
Date:   Thu, 24 Mar 2022 12:10:55 +0100
Message-Id: <e98fcf759f8c23a9736f1c4d20ca0437e4b145de.1648120046.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Using my kernel.org email.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 033af08c8239..0423416d3bba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12164,7 +12164,7 @@ F:	drivers/mmc/host/mtk-sd.c
 
 MEDIATEK MT76 WIRELESS LAN DRIVER
 M:	Felix Fietkau <nbd@nbd.name>
-M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
+M:	Lorenzo Bianconi <lorenzo@kernel.org>
 M:	Ryder Lee <ryder.lee@mediatek.com>
 R:	Shayne Chen <shayne.chen@mediatek.com>
 R:	Sean Wang <sean.wang@mediatek.com>
-- 
2.35.1

