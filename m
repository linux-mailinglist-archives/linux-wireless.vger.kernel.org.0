Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA99C3CDB24
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jul 2021 17:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244377AbhGSOlY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jul 2021 10:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244518AbhGSOjO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jul 2021 10:39:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E89516121E;
        Mon, 19 Jul 2021 15:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626707904;
        bh=tbjK3+KGzetC/M7kPMYQUIaqwKGcQVs9fdQyCa8T6zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ymjka9p+pP17TAeGMXy07Zec98JbS6vqe6MMW9r5IcAVvHQbUnxOqxMPELzq/q/OP
         0WsNYNTXfqc2swscRMmVGwqp+JclZlhnIkANslQQUhbJmUWuQ3dHrkYeLvy0UJjMjK
         9EG2sE7lX8uqw4csGtZU+tMfaWcccOnW9MB2eQOk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christian Lamparter <chunkeey@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 101/315] wireless: carl9170: fix LEDS build errors & warnings
Date:   Mon, 19 Jul 2021 16:49:50 +0200
Message-Id: <20210719144946.200492982@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719144942.861561397@linuxfoundation.org>
References: <20210719144942.861561397@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 272fdc0c4542fad173b44965be02a16d6db95499 ]

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

Fix this by making CARL9170_LEDS depend on MAC80211_LEDS, where
the latter supplies any needed dependencies on LEDS_CLASS.

Fixes: 1d7e1e6b1b8ed ("carl9170: Makefile, Kconfig files and MAINTAINERS")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Christian Lamparter <chunkeey@googlemail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20210530031134.23274-1-rdunlap@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/carl9170/Kconfig | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/Kconfig b/drivers/net/wireless/ath/carl9170/Kconfig
index 2e34baeaf764..2b782db20fde 100644
--- a/drivers/net/wireless/ath/carl9170/Kconfig
+++ b/drivers/net/wireless/ath/carl9170/Kconfig
@@ -15,13 +15,11 @@ config CARL9170
 
 config CARL9170_LEDS
 	bool "SoftLED Support"
-	depends on CARL9170
-	select MAC80211_LEDS
-	select LEDS_CLASS
-	select NEW_LEDS
 	default y
+	depends on CARL9170
+	depends on MAC80211_LEDS
 	help
-	  This option is necessary, if you want your device' LEDs to blink
+	  This option is necessary, if you want your device's LEDs to blink.
 
 	  Say Y, unless you need the LEDs for firmware debugging.
 
-- 
2.30.2



