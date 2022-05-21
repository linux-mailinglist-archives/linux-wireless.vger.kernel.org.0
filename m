Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C7752FE95
	for <lists+linux-wireless@lfdr.de>; Sat, 21 May 2022 19:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344247AbiEURcR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 May 2022 13:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbiEURcQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 May 2022 13:32:16 -0400
Received: from p-impout002.msg.pkvw.co.charter.net (p-impout002aa.msg.pkvw.co.charter.net [47.43.26.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AFA5468E
        for <linux-wireless@vger.kernel.org>; Sat, 21 May 2022 10:32:14 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id sSxHnqW0wFl1esSxZnDBcW; Sat, 21 May 2022 17:32:14 +0000
X-Authority-Analysis: v=2.4 cv=EpDBEAQA c=1 sm=1 tr=0 ts=6289221e
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17 a=yQdBAQUQAAAA:8
 a=MrPZ0le7YmToiFjRSvwA:9 a=SzazLyfi1tnkUD6oumHU:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH v2 2/4] rtw88: Make rtw8822c_hw_spec be static
Date:   Sat, 21 May 2022 12:31:42 -0500
Message-Id: <20220521173144.9917-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220521173144.9917-1-Larry.Finger@lwfinger.net>
References: <20220521173144.9917-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNIILzX9aaSShGBS3UBbmbtukIrFhJtTV1Sz8Dj9oGpguJR1FQbqcAEnduxC9TyXwB+N+Pu5vo9Ud/YZQkPn9vm+/I9iemteLxI95gytSbdeujVQ0cMd
 Xom5BR3KehhpGdSvS3FwrRFHFoPL1Gdk12ald5FiRw9qzIUogqREn6KyIbYqeP0c5bamPOA16GEuO7IzsQdx1VG9Epih+KGY+UPvsOVIghAa/IUGbDlHLEZM
 erpkhJM4W0FBq7HV9yLDC/+yCukbpq55slxi2Z0zd/zPlaZ9V/rg6QuOKuqtedR8PYgu7f2N4M3lKUvQslEt57jKFQbcSXg9265oLfwRxEsAVPwecZl+e1+p
 SmHJXTNhOVh+W5R/T1pgs4NHKjNqUTDfg5cGZ6cJVPp42j0GmWE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sparse reports the following:

  CHECK   drivers/net/wireless/realtek/rtw88/rtw8822c.c
drivers/net/wireless/realtek/rtw88/rtw8822c.c:5313:22: warning: symbol 'rtw8822c_hw_spec' was not declared. Should it be static?

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - change subject as recommended by Kalle
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index c043b5c520b9..5ae72d7f5c50 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5310,7 +5310,7 @@ static const struct rtw_reg_domain coex_info_hw_regs_8822c[] = {
 	{0xc50, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
 };
 
-struct rtw_chip_info rtw8822c_hw_spec = {
+static struct rtw_chip_info rtw8822c_hw_spec = {
 	.ops = &rtw8822c_ops,
 	.id = RTW_CHIP_TYPE_8822C,
 	.fw_name = "rtw88/rtw8822c_fw.bin",
-- 
2.36.1

