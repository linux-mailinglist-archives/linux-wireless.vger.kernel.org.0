Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C4152F649
	for <lists+linux-wireless@lfdr.de>; Sat, 21 May 2022 01:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiETXe3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 19:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354168AbiETXeT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 19:34:19 -0400
Received: from p-impout004.msg.pkvw.co.charter.net (p-impout004aa.msg.pkvw.co.charter.net [47.43.26.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3315C19FF7E
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 16:34:18 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id sC8PnpMeGgPEBsC8PnwOtQ; Fri, 20 May 2022 23:34:18 +0000
X-Authority-Analysis: v=2.4 cv=b8OhX/Kx c=1 sm=1 tr=0 ts=6288257a
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17 a=yQdBAQUQAAAA:8
 a=-T2n4f4YjXFfwt-Rkg4A:9 a=SzazLyfi1tnkUD6oumHU:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 4/4] rtw88: Fix Sparse warning for rtw8821c
Date:   Fri, 20 May 2022 18:34:12 -0500
Message-Id: <20220520233412.28642-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAw0jDXAitRG48RfETEUjehGX9vql6/F3mY6rautzZTytO99a6srRz1cBNGGmd5CatVG0KFl9Sy2jZ9nYWnGyjper45YJngK01bUD/NkI2XsLdzr1LPa
 CnVbOeG04g1PUYl30CcHaUOcz6X/b6NZOJRvUW9FoSgqP7QU0XjBZGlLoDqz9KhYrMUoqnh4i0b8NydgjiZOJWSptKANNwpUj1Ox2JpkQTzQjaOxMxgHICO/
 BJH2BKPwwVGPMnoWC6Y7zIO/h0mEculPE9xQm7owjynvEOGafQ/8LRjYOiTWkWtJCDL/+p2LrYU4C7cDQgZ5Um1hL/B1y17MFheEuzTFw/eDS6+wa/YjvT1q
 D9QAU5bzQGouRpJ+/UTNkLWM7SvJDf1Kt1hy+AznJnG5QfKRPOs=
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

