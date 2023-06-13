Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E65C72E571
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 16:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbjFMOLC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 10:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242897AbjFMOJx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 10:09:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111B6F4
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 07:09:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6AD56369C
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 14:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4F1C433F1
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 14:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686665365;
        bh=UWviLmUQtcOm7LzTkSJw98/7WABHY5pbWNAmzo5BxxI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HHPscYgjiFynln4B7eHkS9jFtXArrNMn+Rj2UmPZmiKGa9F7HpYz6MYXAlPvEPwt4
         dSeXUGmuufEynKxdEGC2tVB/T3+zAl5NvdHvj23q+Tjld/yryqhhsFYw2eHSvPv6bv
         /9VUNk+m9xluyxE0KgGw2pw2scMXI3aHCNftI+d0lWCV+7REr1O39fcHK3MvJA1bu/
         5kuCLMLkLi7Wd0H2aHrzZisUa7Xo5snQmYzhYMOmPEiW79QJvHg8LAikbO/TJcQ+y4
         /vCOWTXlF5yy205RedbEM7itqTzJBMGE8qqMiM3DNTpGsMFUm5kbk/2YGF2Lt7U/Wc
         PYhxDGIFtAYfw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/4] wifi: ray_cs: fix stringop-truncation GCC warning
Date:   Tue, 13 Jun 2023 17:09:18 +0300
Message-Id: <20230613140918.389690-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230613140918.389690-1-kvalo@kernel.org>
References: <20230613140918.389690-1-kvalo@kernel.org>
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

GCC 12.2 with W=1 warns:

drivers/net/wireless/legacy/ray_cs.c:630:17: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]

The driver uses SSID as a string which is just wrong, it should be treated as a
byte array instead. But as the driver is ancient and most likely there are no
users so convert it to use strscpy(). This makes sure that the string is
NUL-terminated and also the warning is fixed.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/legacy/ray_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/legacy/ray_cs.c b/drivers/net/wireless/legacy/ray_cs.c
index 4b53a9c70e7e..8ace797ce951 100644
--- a/drivers/net/wireless/legacy/ray_cs.c
+++ b/drivers/net/wireless/legacy/ray_cs.c
@@ -627,7 +627,7 @@ static void init_startup_params(ray_dev_t *local)
 	local->sparm.b4.a_acting_as_ap_status = TYPE_STA;
 
 	if (essid != NULL)
-		strncpy(local->sparm.b4.a_current_ess_id, essid, ESSID_SIZE);
+		strscpy(local->sparm.b4.a_current_ess_id, essid, ESSID_SIZE);
 } /* init_startup_params */
 
 /*===========================================================================*/
-- 
2.30.2

