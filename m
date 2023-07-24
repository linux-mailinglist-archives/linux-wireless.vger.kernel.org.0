Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B2075F3B6
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 12:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjGXKpz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 06:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjGXKpy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 06:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB189C
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 03:45:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 421036106D
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA82C433C9
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690195552;
        bh=Pl/SOromHKnceMuxzK7X4u16xrlbYa1B4Axunyq40wo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=A95gH/9CmBNd/Dsh6Sn8kptRGRaKMmMwLshjG5glkwG1z3F3it98T0Hdk/IJtr1y0
         IqkQLtWDP3RABS9sTnUyDf6yBH7wh83W6zrkR8NMmdmJvhBLKyC3+n4obCJ6G+GrKp
         pZVEYMk6ID6TpJyjepU1w8ChXSsWe/f1qZbuVxCmJvbVTORtMhD7cZvTIfda1IluYI
         mCB9jBUfiHcQamlzD1pKr3peYzx6En3KUPi+8/+wfV8kZ5mCi6NXPhg6dm+W59gNGv
         KLtQoe95P+w6xjMpOctXdp1UYIz408bHGmNvcXFw/gTNqDqocDa3rwUrPz95262Tfj
         5Kzh/vTOZCTPw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/9] MAINTAINERS: wifi: mark cw1200 as orphan
Date:   Mon, 24 Jul 2023 13:45:41 +0300
Message-Id: <20230724104547.3061709-4-kvalo@kernel.org>
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

Last activity from Solomon is from 2013 so mark the driver orphan.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea84170767d5..b61a50895535 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5451,8 +5451,7 @@ F:	Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml
 F:	drivers/net/can/ctucanfd/
 
 CW1200 WLAN driver
-M:	Solomon Peachy <pizza@shaftnet.org>
-S:	Maintained
+S:	Orphan
 F:	drivers/net/wireless/st/cw1200/
 
 CX18 VIDEO4LINUX DRIVER
-- 
2.39.2

