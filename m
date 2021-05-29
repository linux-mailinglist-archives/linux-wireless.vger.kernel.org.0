Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A4F394D29
	for <lists+linux-wireless@lfdr.de>; Sat, 29 May 2021 18:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhE2Qp7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 May 2021 12:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhE2Qp7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 May 2021 12:45:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E601AC061574
        for <linux-wireless@vger.kernel.org>; Sat, 29 May 2021 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xi8Hckx6I6kriebdsDJfh9Bh9Zr3qvC0QyzFQQMwYnA=; b=qW+KLVDnTdoLNyZvVf5VwzIuSw
        b1SMxcOxJHHwU/e8+TAbr9dVjOl8ahlbhDahBE54V9DbyMC/XrV4kbHW4IfjV7uqgoKimt+8q9lNW
        sMvLc5SGQ19NM+5CvkgTeeLVK0514uRArFTnb9UHJFTyshR52HXueOdsBZ33CMg4pCTQi0/YrDFrr
        Ag74U3bgt+7SiPAbZwKM1V/mJBHC7PoXfNXamm6blUjGI4U11aylN8Q/n/p2N3YEBz4RAMyEtzXhA
        y05acIdnWj7m+zgK73gXZmhmQqeL0eIYIrz/aKM+MhjZz+5QDVgfMH+7q0HNe9N3rsXZX3cH4/IrZ
        8kRzZegw==;
Received: from [2601:1c0:6280:3f0::ce7d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ln24T-007aLN-En; Sat, 29 May 2021 16:44:21 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] wireless: carl9170: fix LEDS build errors & warnings
Date:   Sat, 29 May 2021 09:44:20 -0700
Message-Id: <20210529164420.11454-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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

Fix this by making CARL9170_LEDS always set/enabled if certain
conditions are met: LEDS_CLASS=y or LEDS_CLASS=CARL9170, just as
this is done for Mediatek MT76.

Fixes: 1d7e1e6b1b8ed ("carl9170: Makefile, Kconfig files and MAINTAINERS")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
---
v2: modify as suggesed by Arnd

 drivers/net/wireless/ath/carl9170/Kconfig |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- linux-next-20210528.orig/drivers/net/wireless/ath/carl9170/Kconfig
+++ linux-next-20210528/drivers/net/wireless/ath/carl9170/Kconfig
@@ -15,16 +15,10 @@ config CARL9170
 	  If you choose to build a module, it'll be called carl9170.
 
 config CARL9170_LEDS
-	bool "SoftLED Support"
-	depends on CARL9170
-	select MAC80211_LEDS
-	select LEDS_CLASS
-	select NEW_LEDS
+	bool
 	default y
-	help
-	  This option is necessary, if you want your device' LEDs to blink
-
-	  Say Y, unless you need the LEDs for firmware debugging.
+	depends on CARL9170
+	depends on LEDS_CLASS=y || LEDS_CLASS=CARL9170
 
 config CARL9170_DEBUGFS
 	bool "DebugFS Support"
