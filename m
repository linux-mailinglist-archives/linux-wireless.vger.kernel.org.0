Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1466178B08E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjH1MgR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjH1MgL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:36:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4FA12A
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95C3162DCA
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 12:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A77FC433CA
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 12:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693226168;
        bh=rXA9pAUZlQsQjsFMEEpGMrrjmRZcMzohHEebt5n6P6E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=o0wmRq310fzqEyc6OAQs3bxTpII9a1S+ZG3mDJJdNYD9ZUy+1OszaOLXmEqC4gwyA
         q7B2dMdoW0Z8UL77+IM8a3rNFz1X/vZM/+5KdvBDdU55PBMWrzJw+sT7h7GYi8my6d
         RD/OHd0nwIOoQnXyZNY5LIZhYh/55LGYWpsb9ZogEkRk1iNi+0y5fNJdLEmDdWiaA9
         4QuP3DT4Gtvokw2xaH05Ik+0hRq6TizRMWdIbqVct7Fm+UXjYNHERqHhPw8iTM6U0m
         0HAkUYh0o8Tf/2yczarI7SRkbE9fe6+cnum21G1Eo3kmq6tkgw49p7b/Z4rF0iwx9T
         co2cjbrXwUoiA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/5] MAINTAINERS: wifi: rtl8xxxu: remove git tree
Date:   Mon, 28 Aug 2023 15:36:01 +0300
Message-Id: <20230828123603.87621-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828123603.87621-1-kvalo@kernel.org>
References: <20230828123603.87621-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jes' tree hasn't been used for six years so remove it.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9672866792e8..89381b63a81d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18555,7 +18555,6 @@ RTL8XXXU WIRELESS DRIVER (rtl8xxxu)
 M:	Jes Sorensen <Jes.Sorensen@gmail.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git rtl8xxxu-devel
 F:	drivers/net/wireless/realtek/rtl8xxxu/
 
 RTRS TRANSPORT DRIVERS
-- 
2.39.2

