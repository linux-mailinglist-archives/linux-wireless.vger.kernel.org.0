Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB58B72F793
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 10:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243268AbjFNIQP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 04:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243174AbjFNIQK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 04:16:10 -0400
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D3FC7
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 01:16:09 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:4212:0:640:eaad:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id 7DD006010A;
        Wed, 14 Jun 2023 11:16:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id vFWJkY3DSiE0-07QflHCf;
        Wed, 14 Jun 2023 11:16:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686730567;
        bh=nBnOEbUc46HozPPwzdafkzCCGz3joJB/wRrqBKBGOeM=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Nl8vux276vxdC3pPj0Nbu72PcOV3wOftlYkFT0ra3HrclJdn18y5DZOK77QgJzqJ7
         n0OcqDewTWct6uNAOpq/PkFUD/0Qxc3IJ0T2bvO1/iWOiOKXaCjoYfTBv3kJ8P+FcE
         2/Nz5R0N3Q4uUVFOTpm54CO/fDtxdDMbRS8rpu+E=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/3] [v6] wifi: rtw89: fix spelling typo of IQK debug messages
Date:   Wed, 14 Jun 2023 11:15:55 +0300
Message-Id: <20230614081555.91395-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614081555.91395-1-dmantipov@yandex.ru>
References: <20230614051116.20968-3-dmantipov@yandex.ru>
 <20230614081555.91395-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix spelling typo of IQK debug messages.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v6: add missing commit message (Ping-Ke Shih)
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

