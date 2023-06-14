Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A2C72F400
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 07:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242780AbjFNFLm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 01:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242776AbjFNFLk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 01:11:40 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB98C1A3
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 22:11:38 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:2087:0:640:7bf5:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id 08CD36003F;
        Wed, 14 Jun 2023 08:11:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id IBTjaD2WmGk0-EYUFwky2;
        Wed, 14 Jun 2023 08:11:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686719496;
        bh=ns/eV/vxVxvtNLSZ5sT6VZeUk0iBw1geXEZlBM8ZdEo=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=e4wQvLTpYtXGCX1mcG0i7aa0LSa9VPk4w/ss6KIk6LidbbXKxWnVS/l1W38ipEz6f
         4QmSzERhXfLkHQrbyZk+wTSVTzcXDfH/OFlIOvvRrUsbk132wtPOAjBD+4L7f4NeB4
         45z+1kx65fr3WWpU3goO6hg+cOcFb7roD1Z4NUMw=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/3] [v5] wifi: rtw89: fix spelling typo of IQK debug messages
Date:   Wed, 14 Jun 2023 08:11:16 +0300
Message-Id: <20230614051116.20968-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614051116.20968-1-dmantipov@yandex.ru>
References: <20230613100154.116586-3-dmantipov@yandex.ru>
 <20230614051116.20968-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v5: adjust to match series and consolidate all typo fixes (Ping-Ke Shih)
---
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index 466fa8e406da..48f1bcc46eda 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -1586,7 +1586,7 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 			      BTC_WRFK_ONESHOT_START);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
-		    "[IQK]==========IQK strat!!!!!==========\n");
+		    "[IQK]==========IQK start!!!!!==========\n");
 	iqk_info->iqk_times++;
 	iqk_info->version = RTW8851B_IQK_VER;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 3107eed52f15..fa018e1f499b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -1617,7 +1617,7 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
-		    "[IQK]==========IQK strat!!!!!==========\n");
+		    "[IQK]==========IQK start!!!!!==========\n");
 	iqk_info->iqk_times++;
 	iqk_info->version = RTW8852B_IQK_VER;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 3423bdacc23c..de7714f871d5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -1525,7 +1525,7 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
-		    "[IQK]==========IQK strat!!!!!==========\n");
+		    "[IQK]==========IQK start!!!!!==========\n");
 	iqk_info->iqk_times++;
 	iqk_info->version = RTW8852C_IQK_VER;
 
-- 
2.40.1

