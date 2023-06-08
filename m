Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAF2727BE7
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 11:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjFHJvt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 05:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjFHJvs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 05:51:48 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E842A269E
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 02:51:46 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5503:0:640:7fc3:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id 1971160055;
        Thu,  8 Jun 2023 12:51:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8pRApaJDbuQ0-9IpHXBWZ;
        Thu, 08 Jun 2023 12:51:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686217904;
        bh=/N7XX5gwYrWo3EennO5Vrtz3u7axCo0Yzv9z0xZaWgM=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=KiVlJH33fD2Iy3YxfPMivyAeCo6Ut0fhXHzE4JMZ2Bvayol+F+zS/Bq4Jz5pkrxFM
         9ukmNCVD4ADgjH2DK+AkRm4mQrJIqOvVY7WvL2g8vpRpNlg5ryBrTiibBdYqf0sXOj
         J9vi1YqhH9JChi9WJ03mNwFTqsZTPJ4iQ457Sd1k=
Authentication-Results: mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/4] [v2] wifi: rtlwifi: remove unused dualmac control leftovers
Date:   Thu,  8 Jun 2023 12:50:49 +0300
Message-Id: <20230608095051.116702-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608095051.116702-1-dmantipov@yandex.ru>
References: <20230605100700.111644-1-dmantipov@yandex.ru>
 <20230608095051.116702-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove 'struct rtl_dualmac_easy_concurrent_ctl' of 'struct rtl_priv'
and related code in '_rtl_pci_tx_chk_waitq()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: adjust to match series
---
 drivers/net/wireless/realtek/rtlwifi/pci.c  | 5 -----
 drivers/net/wireless/realtek/rtlwifi/wifi.h | 9 ---------
 2 files changed, 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index ca79f652fef3..028a7c97bacf 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -482,11 +482,6 @@ static void _rtl_pci_tx_chk_waitq(struct ieee80211_hw *hw)
 	if (!rtlpriv->rtlhal.earlymode_enable)
 		return;
 
-	if (rtlpriv->dm.supp_phymode_switch &&
-	    (rtlpriv->easy_concurrent_ctl.switch_in_process ||
-	    (rtlpriv->buddy_priv &&
-	    rtlpriv->buddy_priv->easy_concurrent_ctl.switch_in_process)))
-		return;
 	/* we just use em for BE/BK/VI/VO */
 	for (tid = 7; tid >= 0; tid--) {
 		u8 hw_queue = ac_to_hwq[rtl_tid_to_ac(tid)];
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index bc1d68cb9183..307e059ec8aa 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2496,14 +2496,6 @@ struct rtl_debug {
 #define MIMO_PS_DYNAMIC			1
 #define MIMO_PS_NOLIMIT			3
 
-struct rtl_dualmac_easy_concurrent_ctl {
-	enum band_type currentbandtype_backfordmdp;
-	bool close_bbandrf_for_dmsp;
-	bool change_to_dmdp;
-	bool change_to_dmsp;
-	bool switch_in_process;
-};
-
 struct rtl_dmsp_ctl {
 	bool activescan_for_slaveofdmsp;
 	bool scan_for_anothermac_fordmsp;
@@ -2744,7 +2736,6 @@ struct rtl_priv {
 	struct list_head list;
 	struct rtl_priv *buddy_priv;
 	struct rtl_global_var *glb_var;
-	struct rtl_dualmac_easy_concurrent_ctl easy_concurrent_ctl;
 	struct rtl_dmsp_ctl dmsp_ctl;
 	struct rtl_locks locks;
 	struct rtl_works works;
-- 
2.40.1

