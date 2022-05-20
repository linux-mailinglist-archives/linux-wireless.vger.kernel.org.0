Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4F952F36A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 20:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350841AbiETSru (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 14:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352945AbiETSrs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 14:47:48 -0400
Received: from p-impout002.msg.pkvw.co.charter.net (p-impout002aa.msg.pkvw.co.charter.net [47.43.26.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2147913276D
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 11:47:47 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id s7dFnjjoIFl1es7dfnBCba; Fri, 20 May 2022 18:46:16 +0000
X-Authority-Analysis: v=2.4 cv=EpDBEAQA c=1 sm=1 tr=0 ts=6287e1f8
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17 a=yQdBAQUQAAAA:8
 a=-nFclCnxJA8rJoUu8tsA:9 a=SzazLyfi1tnkUD6oumHU:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 3/4] rtw88: Fix Sparse warning for rtw8723d
Date:   Fri, 20 May 2022 13:45:27 -0500
Message-Id: <20220520184528.4078-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520184528.4078-1-Larry.Finger@lwfinger.net>
References: <20220520184528.4078-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKXVMTPLxZi3UuKkdY28tTfDA+DUoqqumw1DP2/kUejPFmFMiAjtcdxEldg+RhXkjI5WPBfmcM5J41MBrPiVovs2US2TQilKJJHQ0o8qaWH2UOoz5nay
 dYvA0MtRDBPjcgfwKAY4lY9NpM+gioKvAgTNC5V8JN0uzXUCCZEqVlwOgK2MNP85fUaSfHdTItaQK8CPil8qvoCl3NB1eOpbBjt9d8p87zRHFPAvuex9nmpN
 29Pt93cCOGL8E9gDgSy8g9FPNedDqH1tPp1I3M5iyO4bGh4fneW3ndXy5kEq+UCp1KlY7EiQYRitmwc9byuAi8KgA8QsWFZKaOOjOrHRYrt2BAaMCEn+djrS
 C873pa2TTbzK/YCbptAnYn7/zjNMiAtJib8juBXc8l47gJiKouE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sparse list the following:

  CHECK   drivers/net/wireless/realtek/rtw88/rtw8723d.c
drivers/net/wireless/realtek/rtw88/rtw8723d.c:2704:22: warning: symbol 'rtw8723d_hw_spec' was not declared. Should it be static?

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
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

