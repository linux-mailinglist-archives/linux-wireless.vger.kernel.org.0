Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F471AA9A9
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 16:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636582AbgDOOQv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 10:16:51 -0400
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:56106 "EHLO
        6.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2636573AbgDOOQr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 10:16:47 -0400
X-Greylist: delayed 945 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2020 10:16:45 EDT
Received: from player776.ha.ovh.net (unknown [10.108.57.95])
        by mo69.mail-out.ovh.net (Postfix) with ESMTP id CBA7A8B998
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2020 16:00:56 +0200 (CEST)
Received: from nilsand.re (host86-180-230-78.range86-180.btcentralplus.com [86.180.230.78])
        (Authenticated sender: nils@nilsand.re)
        by player776.ha.ovh.net (Postfix) with ESMTPSA id 6CF17117B0194;
        Wed, 15 Apr 2020 14:00:55 +0000 (UTC)
Date:   Wed, 15 Apr 2020 15:00:52 +0100
From:   Nils =?utf-8?Q?ANDR=C3=89-CHANG?= <nils@nilsand.re>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2] MAINTAINERS: Update URL for wireless drivers
Message-ID: <20200415140052.2lftkixe37llmtjl@nixos>
References: <20200412110724.6uaoqmjc3it73nzo@nixos>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200412110724.6uaoqmjc3it73nzo@nixos>
X-Ovh-Tracer-Id: 1411878484156974104
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrfeefgdeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtudenucfhrhhomheppfhilhhsucetpffftfmtqdevjfetpffiuceonhhilhhssehnihhlshgrnhgurdhrvgeqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpnhhonhhgnhhurdhorhhgpdhgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpkeeirddukedtrddvfedtrdejkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepnhhilhhssehnihhlshgrnhgurdhrvgdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Previously, http://wireless.kernel.org would redirect to
https://wireless.wiki.kernel.org, however, this is no longer the case
and most pages return 404.

https is used because http://wireless.kernel.org/* redirects to
https://wireless.wiki.kernel.org/*

Signed-off-by: Nils ANDRÉ-CHANG <nils@nilsand.re>
---
v2: Rebase on linus' branch

 MAINTAINERS | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..81e7fcc915ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -189,7 +189,7 @@ F:	drivers/net/hamradio/6pack.c
 M:	Johannes Berg <johannes@sipsolutions.net>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-W:	http://wireless.kernel.org/
+W:	https://wireless.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git
 F:	Documentation/driver-api/80211/cfg80211.rst
@@ -505,7 +505,7 @@ F:	drivers/hwmon/adm1029.c
 ADM8211 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-W:	http://wireless.kernel.org/
+W:	https://wireless.wiki.kernel.org/
 F:	drivers/net/wireless/admtek/adm8211.*
 
 ADP1653 FLASH CONTROLLER DRIVER
@@ -2847,14 +2847,14 @@ M:	Nick Kossifidis <mickflemm@gmail.com>
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-W:	http://wireless.kernel.org/en/users/Drivers/ath5k
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath5k
 F:	drivers/net/wireless/ath/ath5k/
 
 ATHEROS ATH6KL WIRELESS DRIVER
 M:	Kalle Valo <kvalo@codeaurora.org>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
-W:	http://wireless.kernel.org/en/users/Drivers/ath6kl
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath6kl
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 F:	drivers/net/wireless/ath/ath6kl/
 
@@ -3017,7 +3017,7 @@ B43 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 L:	b43-dev@lists.infradead.org
 S:	Odd Fixes
-W:	http://wireless.kernel.org/en/users/Drivers/b43
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/b43
 F:	drivers/net/wireless/broadcom/b43/
 
 B43LEGACY WIRELESS DRIVER
@@ -3025,7 +3025,7 @@ M:	Larry Finger <Larry.Finger@lwfinger.net>
 L:	linux-wireless@vger.kernel.org
 L:	b43-dev@lists.infradead.org
 S:	Maintained
-W:	http://wireless.kernel.org/en/users/Drivers/b43
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/b43
 F:	drivers/net/wireless/broadcom/b43legacy/
 
 BACKLIGHT CLASS/SUBSYSTEM
@@ -3840,7 +3840,7 @@ CARL9170 LINUX COMMUNITY WIRELESS DRIVER
 M:	Christian Lamparter <chunkeey@googlemail.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-W:	http://wireless.kernel.org/en/users/Drivers/carl9170
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/carl9170
 F:	drivers/net/wireless/ath/carl9170/
 
 CAVIUM I2C DRIVER
@@ -10063,7 +10063,7 @@ MAC80211
 M:	Johannes Berg <johannes@sipsolutions.net>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-W:	http://wireless.kernel.org/
+W:	https://wireless.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git
 F:	Documentation/networking/mac80211-injection.txt
@@ -12644,7 +12644,7 @@ F:	fs/orangefs/
 ORINOCO DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-W:	http://wireless.kernel.org/en/users/Drivers/orinoco
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/orinoco
 W:	http://www.nongnu.org/orinoco/
 F:	drivers/net/wireless/intersil/orinoco/
 
@@ -12670,7 +12670,7 @@ P54 WIRELESS DRIVER
 M:	Christian Lamparter <chunkeey@googlemail.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-W:	http://wireless.kernel.org/en/users/Drivers/p54
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/p54
 F:	drivers/net/wireless/intersil/p54/
 
 PACKING
@@ -13591,7 +13591,7 @@ PRISM54 WIRELESS DRIVER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-wireless@vger.kernel.org
 S:	Obsolete
-W:	http://wireless.kernel.org/en/users/Drivers/p54
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/p54
 F:	drivers/net/wireless/intersil/prism54/
 
 PROC FILESYSTEM
@@ -13931,7 +13931,7 @@ QUALCOMM ATHEROS ATH10K WIRELESS DRIVER
 M:	Kalle Valo <kvalo@codeaurora.org>
 L:	ath10k@lists.infradead.org
 S:	Supported
-W:	http://wireless.kernel.org/en/users/Drivers/ath10k
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath10k
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 F:	drivers/net/wireless/ath/ath10k/
 
@@ -13946,7 +13946,7 @@ QUALCOMM ATHEROS ATH9K WIRELESS DRIVER
 M:	QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
-W:	http://wireless.kernel.org/en/users/Drivers/ath9k
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath9k
 F:	drivers/net/wireless/ath/ath9k/
 
 QUALCOMM CAMERA SUBSYSTEM DRIVER
@@ -14043,7 +14043,7 @@ QUALCOMM WCN36XX WIRELESS DRIVER
 M:	Kalle Valo <kvalo@codeaurora.org>
 L:	wcn36xx@lists.infradead.org
 S:	Supported
-W:	http://wireless.kernel.org/en/users/Drivers/wcn36xx
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/wcn36xx
 T:	git git://github.com/KrasnikovEugene/wcn36xx.git
 F:	drivers/net/wireless/ath/wcn36xx/
 
@@ -14271,7 +14271,7 @@ REALTEK WIRELESS DRIVER (rtlwifi family)
 M:	Ping-Ke Shih <pkshih@realtek.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-W:	http://wireless.kernel.org/
+W:	https://wireless.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
 F:	drivers/net/wireless/realtek/rtlwifi/
 
@@ -14406,7 +14406,7 @@ RFKILL
 M:	Johannes Berg <johannes@sipsolutions.net>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-W:	http://wireless.kernel.org/
+W:	https://wireless.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git
 F:	Documentation/ABI/stable/sysfs-class-rfkill
@@ -14555,7 +14555,7 @@ F:	drivers/media/dvb-frontends/rtl2832_sdr*
 RTL8180 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-W:	http://wireless.kernel.org/
+W:	https://wireless.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
 F:	drivers/net/wireless/realtek/rtl818x/rtl8180/
 
@@ -14565,7 +14565,7 @@ M:	Hin-Tak Leung <htl10@users.sourceforge.net>
 M:	Larry Finger <Larry.Finger@lwfinger.net>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-W:	http://wireless.kernel.org/
+W:	https://wireless.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
 F:	drivers/net/wireless/realtek/rtl818x/rtl8187/
 
@@ -16920,8 +16920,8 @@ F:	drivers/media/platform/ti-vpe/
 TI WILINK WIRELESS DRIVERS
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-W:	http://wireless.kernel.org/en/users/Drivers/wl12xx
-W:	http://wireless.kernel.org/en/users/Drivers/wl1251
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/wl12xx
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/wl1251
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/luca/wl12xx.git
 F:	drivers/net/wireless/ti/
 F:	include/linux/wl12xx.h
@@ -18203,7 +18203,7 @@ M:	Maya Erez <merez@codeaurora.org>
 L:	linux-wireless@vger.kernel.org
 L:	wil6210@qti.qualcomm.com
 S:	Supported
-W:	http://wireless.kernel.org/en/users/Drivers/wil6210
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/wil6210
 F:	drivers/net/wireless/ath/wil6210/
 
 WIMAX STACK
-- 
2.25.0

