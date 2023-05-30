Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5D1716896
	for <lists+linux-wireless@lfdr.de>; Tue, 30 May 2023 18:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjE3QEM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 May 2023 12:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjE3QEI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 May 2023 12:04:08 -0400
X-Greylist: delayed 485 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 May 2023 09:03:37 PDT
Received: from forward206b.mail.yandex.net (forward206b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52CB1B3
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 09:03:37 -0700 (PDT)
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
        by forward206b.mail.yandex.net (Yandex) with ESMTP id D3DE56011D
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 18:55:33 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:d315:0:640:bb64:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id 91BA160055;
        Tue, 30 May 2023 18:55:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HtOZWJVDSSw0-OOF9rDAJ;
        Tue, 30 May 2023 18:55:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1685462130;
        bh=FXg7yLiycbfyjLeqClI7IJ3duOREDsgEH/POcLoymhc=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=r75qLvQETEJMkGcBBexo7n0M+v7bJwKvniS5t5TJdKv8WI3kpYzsBV/H7+a/sYoqV
         e9zCc+eqXCJYDAqD5khLfxrxZ9E98/AOm/a8qWJJoM8fd28LeO7MTudlA64mPvEEp5
         ubaNOcyBK4ePkccdvuOFtiWXmGQ0zR854a4jwsfg=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>,
        Dmitriy Antipov <Dmitriy.Antipov@softline.com>
Subject: [PATCH] rtlwifi: rtl8188ee: drop RTX_POWER_BEFORE_IQK_A and RTX_POWER_AFTER_IQK_A reads
Date:   Tue, 30 May 2023 18:54:46 +0300
Message-Id: <20230530155446.555091-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
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

Drop redundant reads from RTX_POWER_BEFORE_IQK_A and RTX_POWER_AFTER_IQK_A
registers in _rtl88e_phy_path_a_rx_iqk().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitriy Antipov <Dmitriy.Antipov@softline.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
index 12d0b3a87af7..380a813acda8 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
@@ -1475,8 +1475,6 @@ static u8 _rtl88e_phy_path_a_rx_iqk(struct ieee80211_hw *hw, bool config_pathb)
 	mdelay(IQK_DELAY_TIME);
 
 	reg_eac = rtl_get_bbreg(hw, RRX_POWER_AFTER_IQK_A_2, MASKDWORD);
-	reg_e94 = rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_A, MASKDWORD);
-	reg_e9c = rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_A, MASKDWORD);
 	reg_ea4 = rtl_get_bbreg(hw, RRX_POWER_BEFORE_IQK_A_2, MASKDWORD);
 
 	if (!(reg_eac & BIT(27)) &&
-- 
2.40.1

