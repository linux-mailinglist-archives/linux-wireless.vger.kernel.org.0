Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDB57E9F23
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 15:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjKMOsw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 09:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjKMOsv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 09:48:51 -0500
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [178.154.239.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5850CD68
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 06:48:44 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c00:2f9f:0:640:dfdd:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id D5DE360ADA;
        Mon, 13 Nov 2023 17:48:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Amj84jlUtuQ0-DhcIPg3s;
        Mon, 13 Nov 2023 17:48:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1699886891; bh=CbaVwtDCYdUUp7vTYFy+ELf6W025N7vHxium9qh0kYQ=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=k1N16EZRxxgteOTolzIWsB6QCCALHiahhT7dXeIA4CZnF00zMoYwdkyVhlBWuZ2vR
         oKx6AMPn9ONrIPLHCZ+eu4ARmtDSHpu7pct2mxxQxWHmmTDMoZC9uyoZl/LmcYIEIT
         SFedB9GaSRDJzobO8ImxJFKYur8xFtwW+tOSscTQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: rtlwifi: more cleanup for struct rtl_hal
Date:   Mon, 13 Nov 2023 17:47:29 +0300
Message-ID: <20231113144734.197359-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Following commit d1e6b020c32d ("wifi: rtlwifi: cleanup struct rtl_hal"),
remove unused 'hal_coex_8723', 'current_bandtypebackup', 'master_of_dmsp'
and 'slave_of_dmsp' members of 'struct rtl_hal' as well. Compile tested
only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtlwifi/wifi.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 171a461cd812..33c3e001266f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -1605,7 +1605,6 @@ struct rtl_hal {
 	bool being_init_adapter;
 	bool mac_func_enable;
 	bool pre_edcca_enable;
-	struct bt_coexist_8723 hal_coex_8723;
 
 	enum intf_type interface;
 	u16 hw_type;		/*92c or 92d or 92s and so on */
@@ -1660,7 +1659,6 @@ struct rtl_hal {
 	/* Dual mac */
 	enum macphy_mode macphymode;
 	enum band_type current_bandtype;	/* 0:2.4G, 1:5G */
-	enum band_type current_bandtypebackup;
 	enum band_type bandset;
 	/* dual MAC 0--Mac0 1--Mac1 */
 	u32 interfaceindex;
@@ -1678,8 +1676,6 @@ struct rtl_hal {
 	bool load_imrandiqk_setting_for2g;
 
 	bool disable_amsdu_8k;
-	bool master_of_dmsp;
-	bool slave_of_dmsp;
 
 	/*for wowlan*/
 	bool enter_pnp_sleep;
-- 
2.41.0

