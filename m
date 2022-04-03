Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B798E4F0BB6
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Apr 2022 20:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbiDCSQm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Apr 2022 14:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbiDCSQl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Apr 2022 14:16:41 -0400
Received: from p-impout001.msg.pkvw.co.charter.net (p-impout001aa.msg.pkvw.co.charter.net [47.43.26.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618F52AE2F
        for <linux-wireless@vger.kernel.org>; Sun,  3 Apr 2022 11:14:47 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1004.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id b4kNnNiwLf37fb4kNnaDTK; Sun, 03 Apr 2022 18:14:44 +0000
X-Authority-Analysis: v=2.4 cv=FcAkeby6 c=1 sm=1 tr=0 ts=6249e414
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17 a=yQdBAQUQAAAA:8
 a=yJd_YRbtkJDNio965FAA:9 a=SzazLyfi1tnkUD6oumHU:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] wireless: Change Kconfig to select WEXT_PRIV
Date:   Sun,  3 Apr 2022 13:14:31 -0500
Message-Id: <20220403181431.21811-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOfctA+4gJ8nK4GdwDZcMOW2NGDRyVREUzM20Ks0STeeftoaSdhNAAIy7+vKhEx2cgf3Hus/QZEQ91faPvfV8cdVmL1UtObJE8V1Kryhiaa2gt//xNV+
 lEmyleKkMKUUrDR85nQL9WE4bBPZu5FiooONCXUz3gXyXUZWRXe2OVSbhtBO0AYS6JqGwd9uJhJzi2LAUr4N1rzgakTKQ/jq9BS/H5X2dJyrEPad2y8HnX2d
 jkgGVpDVtHwxM9JbfDoc4w6MYcai8WuF4QWaB0YCVpnDPs2u+g6+hnsjOp7cIUDRpgHnJfNLHCSSU7ULYzGM1tgcYT5pLEMu2Qp8QI8Kc6BE4kGCx6ATGLXU
 ESwY4Gh25nbLxbePZ+E/pc9f5PZ8VA==
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

File net/wireless/Kconfig contains two blind configuration variables,
namely WEXT_PRIV and WEXT_SPY. If those variables are already in the
configuration file, they will be retained, but there is no way to
set them if they are missing other than to manually edit .config.
They should be enabled if either WIRELESS_EXT or CFG80211_WEXT are set
in the same manner as WEXT_CORE and WEXT_PROC.

Personally, the setting of WEXT_SPY is not important; however, openSUSE
and Ubuntu both enable it in their default kernels. Other distros have
not been checked, but it is likely that they also enable that setting.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 net/wireless/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/wireless/Kconfig b/net/wireless/Kconfig
index f620acd2a0f5..9c216af3ca55 100644
--- a/net/wireless/Kconfig
+++ b/net/wireless/Kconfig
@@ -12,10 +12,12 @@ config WEXT_PROC
 	depends on WEXT_CORE
 
 config WEXT_SPY
-	bool
+	def_bool y
+	depends on CFG80211_WEXT || WIRELESS_EXT
 
 config WEXT_PRIV
-	bool
+	def_bool y
+	depends on CFG80211_WEXT || WIRELESS_EXT
 
 config CFG80211
 	tristate "cfg80211 - wireless configuration API"
-- 
2.35.1

