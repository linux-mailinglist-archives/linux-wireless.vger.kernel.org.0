Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933A178B08B
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjH1MgQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjH1MgJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96F3A8
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7099A623BF
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 12:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B28EC433C8
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 12:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693226165;
        bh=T8aeEteMBE1938Jofo/8dY4yvg0ImG5Ws/AcyyKCqSk=;
        h=From:To:Subject:Date:From;
        b=u8WVenw1nZTDxLEWIHBag7TKNLiH1RmDsJYCn1/vHEjTIBjVYcvWkgmgsbKZtrtKz
         98v1d3hcKxOyS2Sy2j5zLIA4sz88p+T/y5ZZMgZr5wg/K+OGCd1eavFhdVDDqyEUcX
         /H3Vg3usPh8EA0zNhG9euxAPgJ3uUAN/FBPm3ad6Z+arM6FdistWIea3zg3WUx1n2b
         cPEyP3l4VxXJgwf/vhZz68nWONU6cq1FPy0SfHhlRz5lns8yC6o4Hk3E4gVW2Sn78e
         ut0htCvZt51c3I+2JCuYvALVjV4EW7wEkxUW8g5P/y/B9+M5TGGNS+GOnKMSfJhlAo
         a71tLCqGHpf7w==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/5] MAINTAINERS: wifi: remove generic wiki links from drivers
Date:   Mon, 28 Aug 2023 15:35:59 +0300
Message-Id: <20230828123603.87621-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
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

The top level entry for wireless drivers already contains to the wiki so no
need to duplicate that in driver entries:

NETWORKING DRIVERS (WIRELESS)
[...]
W:	https://wireless.wiki.kernel.org/

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f527a9ae4b2..98bda710773d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -470,7 +470,6 @@ F:	drivers/hwmon/adm1029.c
 ADM8211 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-W:	https://wireless.wiki.kernel.org/
 F:	drivers/net/wireless/admtek/adm8211.*
 
 ADP1653 FLASH CONTROLLER DRIVER
@@ -18016,7 +18015,6 @@ REALTEK WIRELESS DRIVER (rtlwifi family)
 M:	Ping-Ke Shih <pkshih@realtek.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-W:	https://wireless.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
 F:	drivers/net/wireless/realtek/rtlwifi/
 
@@ -18545,7 +18543,6 @@ F:	drivers/media/dvb-frontends/rtl2832_sdr*
 RTL8180 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-W:	https://wireless.wiki.kernel.org/
 F:	drivers/net/wireless/realtek/rtl818x/rtl8180/
 
 RTL8187 WIRELESS DRIVER
@@ -18553,7 +18550,6 @@ M:	Hin-Tak Leung <hintak.leung@gmail.com>
 M:	Larry Finger <Larry.Finger@lwfinger.net>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-W:	https://wireless.wiki.kernel.org/
 F:	drivers/net/wireless/realtek/rtl818x/rtl8187/
 
 RTL8XXXU WIRELESS DRIVER (rtl8xxxu)

base-commit: b32add2d20ea6e62f30a3c0a7c2fb306ec5ceb3d
-- 
2.39.2

