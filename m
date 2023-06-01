Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA75719A2E
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 12:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjFAKwg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 06:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjFAKwf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 06:52:35 -0400
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38322107
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 03:52:32 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2f8a:0:640:b50b:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id 5226A46CCF;
        Thu,  1 Jun 2023 13:52:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HqLcU81DgW20-0fumOvUT;
        Thu, 01 Jun 2023 13:52:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1685616749;
        bh=XaBzVD5jcJMDHfUVok2ptaaXP0rSxTmg/wpU7T+PayY=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=ZCPK99KUy9rwGPVqZipV7vEFvYUaUzuJWsvHGuRVT4tB/1L0Ei6+ig3XnL3PbTqc3
         PcfsoCwo/TxBvmNmSMLLWtGAXsx9An+d07+6YwyTY51rR+5ezjU8lv7cuVhQonCMQA
         EAvzQltqZZK8kHvGcNQYLyR2377Fal87ffeWKO6o=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] rtlwifi: rtl8188ee: mark RTX_POWER_{BEFORE,AFTER}_IQK_A reads as unused
Date:   Thu,  1 Jun 2023 13:52:15 +0300
Message-Id: <20230601105215.27013-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b2198915-0e92-de99-d950-be46c2bd8e91@yandex.ru>
References: <b2198915-0e92-de99-d950-be46c2bd8e91@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

According to Ping-Ke Shih, it may be unsafe to remove BB register reads
even if we don't interested in their values. OTOH such a reads may confuse
compilers (when the most strictness warning options are enabled) and/or
static analysis tools. So it may be helpful to convert related calls of
'rtl_get_bbreg()' to 'void' and mark such a cases with special comment
just to make them easier to find and maybe even fix in the future.

This is generally inspired by 6c75eab0417b9e5b05a18dbfc373e27a8ef876d8.

Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
index 12d0b3a87af7..856c626cc99b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
@@ -1475,8 +1475,8 @@ static u8 _rtl88e_phy_path_a_rx_iqk(struct ieee80211_hw *hw, bool config_pathb)
 	mdelay(IQK_DELAY_TIME);
 
 	reg_eac = rtl_get_bbreg(hw, RRX_POWER_AFTER_IQK_A_2, MASKDWORD);
-	reg_e94 = rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_A, MASKDWORD);
-	reg_e9c = rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_A, MASKDWORD);
+	/* unused */ (void)rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_A, MASKDWORD);
+	/* unused */ (void)rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_A, MASKDWORD);
 	reg_ea4 = rtl_get_bbreg(hw, RRX_POWER_BEFORE_IQK_A_2, MASKDWORD);
 
 	if (!(reg_eac & BIT(27)) &&
-- 
2.40.1

