Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99523394AE0
	for <lists+linux-wireless@lfdr.de>; Sat, 29 May 2021 09:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhE2HRF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 May 2021 03:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE2HRE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 May 2021 03:17:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A17AC061574;
        Sat, 29 May 2021 00:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lP+gOPGEdSQsYs+wpEUstBEX/Os02KFbsZt+jZwnsa0=; b=1Y/LARd2iZo4Kv/GWpXjRCe8X/
        a/3DdMYZWAX24uWhZ5IeC4FRD6u6qot+sHl3IK39NNiH1O0XOVQ8WpoWI/euBadZd4sX4pTmaB8aw
        Z4i/BVLtKGZoYfwaJtZjTJuibNWonIFAzKw0s8qlDcXH1eoMIJJB2NULXf57OBkUea3tC3beC3aqD
        y2TofShFu5Bi79e+/b6VYdeatiDhcxFqRPadMWxIiulkVfHMNxbYxBtB9PGE3YTqJsS8FhVZVfsEA
        x4AEc75+vZWVx9NspwEAkPaZEZFyXzN0xGxjyGZg23xP5R6tRbwlfq52lRsTfytQFdjD4VFyrF5sz
        mAstOwaQ==;
Received: from [2601:1c0:6280:3f0::ce7d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lmtBt-003jea-N7; Sat, 29 May 2021 07:15:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] wireless: carl9170: fix LEDS build errors & warnings
Date:   Sat, 29 May 2021 00:15:23 -0700
Message-Id: <20210529071523.2044-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

kernel test robot reports over 200 build errors and warnings
that are due to this Kconfig problem when CARL9170=m,
MAC80211=y, and LEDS_CLASS=m.

WARNING: unmet direct dependencies detected for MAC80211_LEDS
  Depends on [n]: NET [=y] && WIRELESS [=y] && MAC80211 [=y] && (LEDS_CLASS [=m]=y || LEDS_CLASS [=m]=MAC80211 [=y])
  Selected by [m]:
  - CARL9170_LEDS [=y] && NETDEVICES [=y] && WLAN [=y] && WLAN_VENDOR_ATH [=y] && CARL9170 [=m]

CARL9170_LEDS selects MAC80211_LEDS even though its kconfig
dependencies are not met. This happens because 'select' does not follow
any Kconfig dependency chains.

Fix this by making the select depend on LEDS_CLASS=y or
LEDS_CLASS=MAC80211, just as this is done for ath9k.

Fixes: 1d7e1e6b1b8ed ("carl9170: Makefile, Kconfig files and MAINTAINERS")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/ath/carl9170/Kconfig |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- linux-next-20210528.orig/drivers/net/wireless/ath/carl9170/Kconfig
+++ linux-next-20210528/drivers/net/wireless/ath/carl9170/Kconfig
@@ -17,9 +17,7 @@ config CARL9170
 config CARL9170_LEDS
 	bool "SoftLED Support"
 	depends on CARL9170
-	select MAC80211_LEDS
-	select LEDS_CLASS
-	select NEW_LEDS
+	select MAC80211_LEDS if LEDS_CLASS=y || LEDS_CLASS=MAC80211
 	default y
 	help
 	  This option is necessary, if you want your device' LEDs to blink
