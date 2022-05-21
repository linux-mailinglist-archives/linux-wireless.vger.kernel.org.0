Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8395652FE97
	for <lists+linux-wireless@lfdr.de>; Sat, 21 May 2022 19:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245194AbiEURcx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 May 2022 13:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbiEURcw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 May 2022 13:32:52 -0400
Received: from p-impout001.msg.pkvw.co.charter.net (p-impout010aa.msg.pkvw.co.charter.net [47.43.26.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789F152E45
        for <linux-wireless@vger.kernel.org>; Sat, 21 May 2022 10:32:51 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id sSy9npnEsHQLKsSy9ntM6h; Sat, 21 May 2022 17:32:50 +0000
X-Authority-Analysis: v=2.4 cv=FcIkeby6 c=1 sm=1 tr=0 ts=62892242
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17 a=yQdBAQUQAAAA:8
 a=DY4fc44Ji0MHZCRQ1l4A:9 a=SzazLyfi1tnkUD6oumHU:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH v2 4/4] rtw88: Make rtw8821c_hw_spec be static
Date:   Sat, 21 May 2022 12:32:45 -0500
Message-Id: <20220521173245.11463-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIx3QmqnvxU6BTolkQ33n7Q+rvJgltbMF6/WxbeJWheURCWPl+gHOpVgIb/cFHDNO8WQ/zuG4k4yXC00/rMVepcUI7Q+Ik9PP9C3Hn6QBnp1QfNAGupQ
 b08y6g3y6mfh0hJiCc2gD7bG/+PXy4MN6wMLidV9rrYKwcEQed98dyJAonURgAZdETchGAjpB3fIZwqityzIvFZgOvnwUtk9p8PJhfhJX/yXr4TM2a/6DqBf
 Z4czoZdax8n1q1GncKJdz4vxRb/hdt5EyL5J9xvQe+r6berR0HPvloHNusjCYBLHVMs+MbmQTgt2KQaTD5tNmG5Sk+yU6QEuODSjn8kKQ6P/znzNACZLMIsS
 zjVmzHlLqboq49zn6iancTxEBZXOANw0bTu73oiN7icvr64MGWA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sparse lists the following:

  CHECK   drivers/net/wireless/realtek/rtw88/rtw8821c.c
drivers/net/wireless/realtek/rtw88/rtw8821c.c:1880:22: warning: symbol 'rtw8821c_hw_spec' was not declared. Should it be static?

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - change subject as recommended by Kalle
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index ffee39ea5df6..c0bfda189b99 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1877,7 +1877,7 @@ static const struct rtw_reg_domain coex_info_hw_regs_8821c[] = {
 	{0x60A, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
 };
 
-struct rtw_chip_info rtw8821c_hw_spec = {
+static struct rtw_chip_info rtw8821c_hw_spec = {
 	.ops = &rtw8821c_ops,
 	.id = RTW_CHIP_TYPE_8821C,
 	.fw_name = "rtw88/rtw8821c_fw.bin",
-- 
2.36.1

