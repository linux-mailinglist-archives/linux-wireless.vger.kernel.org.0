Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A191A75F3BC
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 12:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjGXKqA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 06:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjGXKp7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 06:45:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12F4FD
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 03:45:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F4596106D
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649F0C433CA
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690195557;
        bh=Ol5Yj2A96zcWkTQboY61TqAzQAKxE9HzfSenoQLvF3g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ht1q+amsvx6EBCZDbGg5m7z4VIaz10rFM1S+h0cojxRhRoa4HmMh17T2CUKK7r6Fu
         ytwuU76RGEoHG+4FzIkGsd3D3aoksIKFU4LEvHsAHnDA1XCDTSvJAAilAbbWfhvKiC
         u7TSPjEzZtIFKyTLcR+ZYmXubz0QlfzyozwgyYVzwvf7eHNKf+L6HrHTkXYDxPQH/C
         1I6EnHU/QS/3xY564J8U/kbBLlSEv8v51afTlb8z8uW0JSnt989eCuAAbt/Kk+JiRl
         GdzlCG4kcsyrs9t//LC+Y9j58hdL0VHQDfbPapUUOuo4MeWchvZlfNTZq0l0mw/Qs0
         QcuzEDHoJoFZg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 9/9] MAINTAINERS: wifi: mark mlw8k as orphan
Date:   Mon, 24 Jul 2023 13:45:47 +0300
Message-Id: <20230724104547.3061709-10-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724104547.3061709-1-kvalo@kernel.org>
References: <20230724104547.3061709-1-kvalo@kernel.org>
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

Last activity from Lennert is from 2012 so mark the driver as orphan.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6538fd53887..c4d14e6b6e7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12586,9 +12586,8 @@ S:	Maintained
 F:	drivers/net/wireless/marvell/mwifiex/
 
 MARVELL MWL8K WIRELESS DRIVER
-M:	Lennert Buytenhek <buytenh@wantstofly.org>
 L:	linux-wireless@vger.kernel.org
-S:	Odd Fixes
+S:	Orphan
 F:	drivers/net/wireless/marvell/mwl8k.c
 
 MARVELL NAND CONTROLLER DRIVER
-- 
2.39.2

