Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40D575F3B7
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 12:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjGXKp4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 06:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjGXKpy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 06:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F1BF3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 03:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19CE961073
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2661BC433C7
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690195553;
        bh=Ls6YEzQskmhlc0qzoBpcpxIEt7CVw26sfbK4IGIm4OI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iv7fy536FUgqdeUzTtECjFOIoX8m9XMJRW08vyEHcCPMSZIgznzyZPp5tYAwtsPXW
         9x/B9IfBRxDHgcPVyRx3ZflkuxCk+3GAcVqlSHtrvz7sdR/X2OvyjhZ3enAlSHgqc6
         Oxq8ETyvGeWnjnhNOLCZXKLI74GpI+vb5bgxXb3R/cSvVFeudFPEK4EI9H5emQw79Z
         Dk/Sq10iq3Xe0CCCWjtyaWZK+PpjiCDpwYYt5TxiG9RIdTZfCH487/W/4m+lRaPcMH
         mVx3puWiIZ+QQ5BSvFuqocwmTkTnICEA/L1t3/xxhfUHXG/DatxL6MKrq5BnHzpMg/
         1cUDbdLAwWNDw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/9] MAINTAINERS: wifi: mark ar5523 as orphan
Date:   Mon, 24 Jul 2023 13:45:42 +0300
Message-Id: <20230724104547.3061709-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724104547.3061709-1-kvalo@kernel.org>
References: <20230724104547.3061709-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Last activity from Pontus for this driver is from 2013 so mark the driver
orphan.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b61a50895535..71a9ef392583 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21887,9 +21887,8 @@ S:	Maintained
 F:	drivers/usb/misc/apple-mfi-fastcharge.c
 
 USB AR5523 WIRELESS DRIVER
-M:	Pontus Fuchs <pontus.fuchs@gmail.com>
 L:	linux-wireless@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/net/wireless/ath/ar5523/
 
 USB ATTACHED SCSI
-- 
2.39.2

