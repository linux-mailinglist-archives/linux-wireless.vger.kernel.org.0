Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED2552FE96
	for <lists+linux-wireless@lfdr.de>; Sat, 21 May 2022 19:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346686AbiEURcZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 May 2022 13:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbiEURcV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 May 2022 13:32:21 -0400
Received: from p-impout002.msg.pkvw.co.charter.net (p-impout002aa.msg.pkvw.co.charter.net [47.43.26.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E43A55218
        for <linux-wireless@vger.kernel.org>; Sat, 21 May 2022 10:32:20 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id sSxHnqW0wFl1esSxfnDBdF; Sat, 21 May 2022 17:32:20 +0000
X-Authority-Analysis: v=2.4 cv=EpDBEAQA c=1 sm=1 tr=0 ts=62892224
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17 a=yQdBAQUQAAAA:8
 a=x68MAS-g3-2hpnaHOukA:9 a=SzazLyfi1tnkUD6oumHU:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH v2 3/4] rtw88: Make rtw8723d_hw_spec be static
Date:   Sat, 21 May 2022 12:31:43 -0500
Message-Id: <20220521173144.9917-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220521173144.9917-1-Larry.Finger@lwfinger.net>
References: <20220521173144.9917-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHNEAVP52c06TAw0EXK+P+LdCoyAI1eOpCOBblfIT/diRMQo85HZ5ApFjgtFrfuCjWRQkyHe4oM9EQURzs7rQuux7cKzQaG7DfGoeUsDDFKWEBD1Id2r
 xEStU9lSJXtj/he3LjNG1motAmJXALfx37BtorldoHFZAvahjv6BMVmPfTOeRdvgHTHW/cVN9QLDeKCt8n1UNkUFn1Jq7Ggy5a283Ig0kkrPX0WdmjUs7I1p
 Ado04srvJ62X3czMscxuNL5cJBh1d2iXQoH8GeSotCM3O/ssA42ibNHJcQwW5gMALT3hPiOBpJ4esArZnSdNJOjy1GUyQVDRT/2Fpwt8dFn18IJlUJR6cWSL
 hyFVgvn+8DrEV1mKXLC4t3xIwPiJcmV+VIisuEQNKHaDNqw/eLQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sparse lists the following:

  CHECK   drivers/net/wireless/realtek/rtw88/rtw8723d.c
drivers/net/wireless/realtek/rtw88/rtw8723d.c:2704:22: warning: symbol 'rtw8723d_hw_spec' was not declared. Should it be static?

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - change subject as recommended by Kalle
---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 93cce44df531..05e826e6ed0d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2701,7 +2701,7 @@ static const struct rtw_reg_domain coex_info_hw_regs_8723d[] = {
 	{0x953, BIT(1), RTW_REG_DOMAIN_MAC8},
 };
 
-struct rtw_chip_info rtw8723d_hw_spec = {
+static struct rtw_chip_info rtw8723d_hw_spec = {
 	.ops = &rtw8723d_ops,
 	.id = RTW_CHIP_TYPE_8723D,
 	.fw_name = "rtw88/rtw8723d_fw.bin",
-- 
2.36.1

