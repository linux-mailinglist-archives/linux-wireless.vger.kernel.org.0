Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF1852FE94
	for <lists+linux-wireless@lfdr.de>; Sat, 21 May 2022 19:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbiEURcM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 May 2022 13:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245194AbiEURcK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 May 2022 13:32:10 -0400
Received: from p-impout002.msg.pkvw.co.charter.net (p-impout002aa.msg.pkvw.co.charter.net [47.43.26.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB305468E
        for <linux-wireless@vger.kernel.org>; Sat, 21 May 2022 10:32:09 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id sSxHnqW0wFl1esSxUnDBbh; Sat, 21 May 2022 17:32:09 +0000
X-Authority-Analysis: v=2.4 cv=EpDBEAQA c=1 sm=1 tr=0 ts=62892219
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17 a=yQdBAQUQAAAA:8
 a=_g3nijcsGpEXjt1jd1AA:9 a=SzazLyfi1tnkUD6oumHU:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH v2 1/4] rtw88: Make rtw8822b_hw_spec be static
Date:   Sat, 21 May 2022 12:31:41 -0500
Message-Id: <20220521173144.9917-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220521173144.9917-1-Larry.Finger@lwfinger.net>
References: <20220521173144.9917-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCGE8qQHh3fonggzUXUenLTpSOkYaoDkLIXt7UQMdN/uO29hF6XPIFQTaHfLN+9DJ8nO2C3DmzIup0Ng/ydVTcGV/aeMYDJ6FMdUPoBMt5fN4FmhtUne
 fcrhk5nRwSGuysmEFUWNPavNTqZIAsuQEZN6x2axW/wj37DMoVHLcp8I3LjAt/4D8dp0KQ7fa8b8hIh+bO4nMypeVajIr0y8gRfiS7iR5bgqpA5Ko3HMuAwy
 QqmWxb//PbkCEYutRWBg469nUTebF5iZJ4u/wPLMkpFubzwlon8v0OzvkRxSwRfDNM2wRndWvtKtkcm2VyWPhIWxdEE//5H4aEAE6C00NA8QMIGY3DqFAE7R
 EW7Vp9vnDqtLR2VxylnjDe4cPSe77viuIsqoNlyblpu4GdhERX8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sparse lists the following for rtw88:

  CHECK   drivers/net/wireless/realtek/rtw88/rtw8822b.c
drivers/net/wireless/realtek/rtw88/rtw8822b.c:2500:22: warning: symbol 'rtw8822b_hw_spec' was not declared. Should it be static?

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - change subject as recommended by Kalle

---
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index dccd722b8e62..60c4e75df035 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2497,7 +2497,7 @@ static struct rtw_hw_reg_offset rtw8822b_edcca_th[] = {
 	[EDCCA_TH_H2L_IDX] = {{.addr = 0x8a4, .mask = MASKBYTE1}, .offset = 0},
 };
 
-struct rtw_chip_info rtw8822b_hw_spec = {
+static struct rtw_chip_info rtw8822b_hw_spec = {
 	.ops = &rtw8822b_ops,
 	.id = RTW_CHIP_TYPE_8822B,
 	.fw_name = "rtw88/rtw8822b_fw.bin",
-- 
2.36.1

