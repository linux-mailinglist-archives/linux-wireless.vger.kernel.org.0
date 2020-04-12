Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 538D41A6088
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2020 22:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgDLUeM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Apr 2020 16:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgDLUeM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Apr 2020 16:34:12 -0400
X-Greylist: delayed 8396 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Apr 2020 13:34:11 PDT
Received: from 17.mo1.mail-out.ovh.net (17.mo1.mail-out.ovh.net [87.98.179.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1B3C0A3BF0
        for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2020 13:34:11 -0700 (PDT)
Received: from player728.ha.ovh.net (unknown [10.108.57.140])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id D1AFE1B9CBC
        for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2020 13:07:26 +0200 (CEST)
Received: from nilsand.re (host86-180-230-78.range86-180.btcentralplus.com [86.180.230.78])
        (Authenticated sender: nils@nilsand.re)
        by player728.ha.ovh.net (Postfix) with ESMTPSA id 5C4AA11405D3E;
        Sun, 12 Apr 2020 11:07:25 +0000 (UTC)
Date:   Sun, 12 Apr 2020 12:07:24 +0100
From:   Nils =?utf-8?Q?ANDR=C3=89-CHANG?= <nils@nilsand.re>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update URL for wireless drivers
Message-ID: <20200412110724.6uaoqmjc3it73nzo@nixos>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17757130381622281240
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrvdejgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfggtggugfesthekredttddtudenucfhrhhomheppfhilhhsucetpffftfmtqdevjfetpffiuceonhhilhhssehnihhlshgrnhgurdhrvgeqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpnhhonhhgnhhurdhorhhgpdhgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpkeeirddukedtrddvfedtrdejkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepnhhilhhssehnihhlshgrnhgurdhrvgdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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
 MAINTAINERS | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97dce264bc7c..5b3bc94a389e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -486,7 +486,7 @@ F:	drivers/hwmon/adm1029.c
 
 ADM8211 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
-W:	http://wireless.kernel.org/
+W:	https://wireless.wiki.kernel.org/
 S:	Orphan
 F:	drivers/net/wireless/admtek/adm8211.*
 
@@ -2821,14 +2821,14 @@ M:	Jiri Slaby <jirislaby@gmail.com>
 M:	Nick Kossifidis <mickflemm@gmail.com>
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-wireless@vger.kernel.org
-W:	http://wireless.kernel.org/en/users/Drivers/ath5k
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath5k
 S:	Maintained
 F:	drivers/net/wireless/ath/ath5k/
 
 ATHEROS ATH6KL WIRELESS DRIVER
 M:	Kalle Valo <kvalo@codeaurora.org>
 L:	linux-wireless@vger.kernel.org
-W:	http://wireless.kernel.org/en/users/Drivers/ath6kl
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath6kl
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 S:	Supported
 F:	drivers/net/wireless/ath/ath6kl/
@@ -2983,7 +2983,7 @@ F:	drivers/media/radio/radio-aztech*
 B43 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 L:	b43-dev@lists.infradead.org
-W:	http://wireless.kernel.org/en/users/Drivers/b43
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/b43
 S:	Odd Fixes
 F:	drivers/net/wireless/broadcom/b43/
 
@@ -2991,7 +2991,7 @@ B43LEGACY WIRELESS DRIVER
 M:	Larry Finger <Larry.Finger@lwfinger.net>
 L:	linux-wireless@vger.kernel.org
 L:	b43-dev@lists.infradead.org
-W:	http://wireless.kernel.org/en/users/Drivers/b43
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/b43
 S:	Maintained
 F:	drivers/net/wireless/broadcom/b43legacy/
 
@@ -3804,7 +3804,7 @@ F:	drivers/iio/light/cm*
 CARL9170 LINUX COMMUNITY WIRELESS DRIVER
 M:	Christian Lamparter <chunkeey@googlemail.com>
 L:	linux-wireless@vger.kernel.org
-W:	http://wireless.kernel.org/en/users/Drivers/carl9170
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/carl9170
 S:	Maintained
 F:	drivers/net/wireless/ath/carl9170/
 
@@ -3951,7 +3951,7 @@ F:	include/linux/cfag12864b.h
 802.11 (including CFG80211/NL80211)
 M:	Johannes Berg <johannes@sipsolutions.net>
 L:	linux-wireless@vger.kernel.org
-W:	http://wireless.kernel.org/
+W:	https://wireless.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git
 S:	Maintained
@@ -9969,7 +9969,7 @@ F:	drivers/media/radio/radio-ma901.c
 MAC80211
 M:	Johannes Berg <johannes@sipsolutions.net>
 L:	linux-wireless@vger.kernel.org
-W:	http://wireless.kernel.org/
+W:	https://wireless.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git
 S:	Maintained
@@ -12521,7 +12521,7 @@ F:	Documentation/filesystems/orangefs.txt
 
 ORINOCO DRIVER
 L:	linux-wireless@vger.kernel.org
-W:	http://wireless.kernel.org/en/users/Drivers/orinoco
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/orinoco
 W:	http://www.nongnu.org/orinoco/
 S:	Orphan
 F:	drivers/net/wireless/intersil/orinoco/
@@ -12547,7 +12547,7 @@ F:	Documentation/filesystems/overlayfs.rst
 P54 WIRELESS DRIVER
 M:	Christian Lamparter <chunkeey@googlemail.com>
 L:	linux-wireless@vger.kernel.org
-W:	http://wireless.kernel.org/en/users/Drivers/p54
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/p54
 S:	Maintained
 F:	drivers/net/wireless/intersil/p54/
 
@@ -13467,7 +13467,7 @@ F:	include/linux/printk.h
 PRISM54 WIRELESS DRIVER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-wireless@vger.kernel.org
-W:	http://wireless.kernel.org/en/users/Drivers/p54
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/p54
 S:	Obsolete
 F:	drivers/net/wireless/intersil/prism54/
 
@@ -13807,7 +13807,7 @@ F:	drivers/media/tuners/qt1010*
 QUALCOMM ATHEROS ATH10K WIRELESS DRIVER
 M:	Kalle Valo <kvalo@codeaurora.org>
 L:	ath10k@lists.infradead.org
-W:	http://wireless.kernel.org/en/users/Drivers/ath10k
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath10k
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 S:	Supported
 F:	drivers/net/wireless/ath/ath10k/
@@ -13822,7 +13822,7 @@ F:	drivers/net/wireless/ath/ath11k/
 QUALCOMM ATHEROS ATH9K WIRELESS DRIVER
 M:	QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
 L:	linux-wireless@vger.kernel.org
-W:	http://wireless.kernel.org/en/users/Drivers/ath9k
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath9k
 S:	Supported
 F:	drivers/net/wireless/ath/ath9k/
 
@@ -13918,7 +13918,7 @@ F:	drivers/media/platform/qcom/venus/
 QUALCOMM WCN36XX WIRELESS DRIVER
 M:	Kalle Valo <kvalo@codeaurora.org>
 L:	wcn36xx@lists.infradead.org
-W:	http://wireless.kernel.org/en/users/Drivers/wcn36xx
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/wcn36xx
 T:	git git://github.com/KrasnikovEugene/wcn36xx.git
 S:	Supported
 F:	drivers/net/wireless/ath/wcn36xx/
@@ -14261,7 +14261,7 @@ F:	tools/testing/selftests/rseq/
 RFKILL
 M:	Johannes Berg <johannes@sipsolutions.net>
 L:	linux-wireless@vger.kernel.org
-W:	http://wireless.kernel.org/
+W:	https://wireless.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git
 S:	Maintained
@@ -14409,7 +14409,7 @@ F:	drivers/media/dvb-frontends/rtl2832_sdr*
 
 RTL8180 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
-W:	http://wireless.kernel.org/
+W:	https://wireless.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
 S:	Orphan
 F:	drivers/net/wireless/realtek/rtl818x/rtl8180/
@@ -14419,7 +14419,7 @@ M:	Herton Ronaldo Krzesinski <herton@canonical.com>
 M:	Hin-Tak Leung <htl10@users.sourceforge.net>
 M:	Larry Finger <Larry.Finger@lwfinger.net>
 L:	linux-wireless@vger.kernel.org
-W:	http://wireless.kernel.org/
+W:	https://wireless.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
 S:	Maintained
 F:	drivers/net/wireless/realtek/rtl818x/rtl8187/
@@ -14427,7 +14427,7 @@ F:	drivers/net/wireless/realtek/rtl818x/rtl8187/
 REALTEK WIRELESS DRIVER (rtlwifi family)
 M:	Ping-Ke Shih <pkshih@realtek.com>
 L:	linux-wireless@vger.kernel.org
-W:	http://wireless.kernel.org/
+W:	https://wireless.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
 S:	Maintained
 F:	drivers/net/wireless/realtek/rtlwifi/
@@ -16781,8 +16781,8 @@ F:	Documentation/devicetree/bindings/media/ti,vpe.yaml
 
 TI WILINK WIRELESS DRIVERS
 L:	linux-wireless@vger.kernel.org
-W:	http://wireless.kernel.org/en/users/Drivers/wl12xx
-W:	http://wireless.kernel.org/en/users/Drivers/wl1251
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/wl12xx
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/wl1251
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/luca/wl12xx.git
 S:	Orphan
 F:	drivers/net/wireless/ti/
@@ -18049,7 +18049,7 @@ M:	Maya Erez <merez@codeaurora.org>
 L:	linux-wireless@vger.kernel.org
 L:	wil6210@qti.qualcomm.com
 S:	Supported
-W:	http://wireless.kernel.org/en/users/Drivers/wil6210
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/wil6210
 F:	drivers/net/wireless/ath/wil6210/
 
 WIMAX STACK
-- 
2.25.0

