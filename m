Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977634EC6D0
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Mar 2022 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbiC3Oml (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Mar 2022 10:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbiC3Omk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Mar 2022 10:42:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9029E0BE
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 07:40:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5D76FCE1D6A
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 14:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6786AC340EC
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648651251;
        bh=iVRT4dVQKY394dSLHmlqx8DiQrpYG2wQ00ttFzMvByk=;
        h=From:To:Subject:Date:From;
        b=b3OsHfUD8D5/o1Lm4lRr4wrPOdxMx7Kp72swwJNLsDyRto4j/qy/zfVFM9cVr8KkI
         Bu8yZmg6a2t3gYMe22LvERa7LO8Xq/H9BR70pKPkXRyupnWvL1rX+g+VIUCUeQQi2u
         f+k4QwjKsfwec1tL7x7WKCj69ni8muRfGpPHfMHPvIGxqVHGg2ekkmAfSNMx4o4v35
         PbGveRhBbzqRsD4KEcYa0COX/z+guQvQPteVAzc5FjH3p/5AaT9ENXAy5ELkraszPk
         iMhYJnHcFoYcwT4nfiX1oKpsTP5gSi7cbrPdm5cwOpRru4RzrNMKiFssvJseG1Wsij
         NiaSFsbKuWtoA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] MAINTAINERS: mark wil6210 as orphan
Date:   Wed, 30 Mar 2022 17:40:46 +0300
Message-Id: <20220330144046.11229-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maya is not working on wil6210 anymore so mark it as orphan.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e406a6db67d0..64c55d9412ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20964,10 +20964,8 @@ S:	Maintained
 F:	drivers/hid/hid-wiimote*
 
 WILOCITY WIL6210 WIRELESS DRIVER
-M:	Maya Erez <merez@codeaurora.org>
 L:	linux-wireless@vger.kernel.org
-L:	wil6210@qti.qualcomm.com
-S:	Supported
+S:	Orphan
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/wil6210
 F:	drivers/net/wireless/ath/wil6210/
 

base-commit: 24b488061b97a6c6ff82c433e6843eaf54f41f3c
-- 
2.30.2

