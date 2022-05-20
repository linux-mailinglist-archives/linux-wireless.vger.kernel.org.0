Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079FC52F367
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 20:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352922AbiETSr0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 14:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349781AbiETSrZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 14:47:25 -0400
X-Greylist: delayed 91 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 May 2022 11:47:23 PDT
Received: from p-impout002.msg.pkvw.co.charter.net (p-impout002aa.msg.pkvw.co.charter.net [47.43.26.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44A4132751
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 11:47:22 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id s7dFnjjoIFl1es7dFnBCWt; Fri, 20 May 2022 18:45:50 +0000
X-Authority-Analysis: v=2.4 cv=EpDBEAQA c=1 sm=1 tr=0 ts=6287e1de
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17 a=yQdBAQUQAAAA:8
 a=pFrt_0-HpuFnp4kU71sA:9 a=SzazLyfi1tnkUD6oumHU:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 0/4] rtw88: Fix some Sparse warnings
Date:   Fri, 20 May 2022 13:45:24 -0500
Message-Id: <20220520184528.4078-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOwFp80jOi7Kz3zaue5dQ8p7NkeN1giyOLXDHQBTA+gu55anU1NMFRZHEd5mwDn3hV609RXHvFuSaK0iqolviKDXgh04bj/pi13y2OvgihbAgOv+vUwn
 hFdSVL5QVQZTaC+YLICZYoo3WthQwYR3G4fitSlgmdYzaoK9eAvPljrEmihYLCcb/AoSx7jmQRbr0SXS23PYSRJdAaved4GW8cmbKWuszL8lz7mt1N1NcKCP
 vYN7+9cTnKcvtbe1qhxbgvLGa79WF/0WCEzS1PT5Jzcfav8yhipM8wosPwXFPHl9wJM9wc1NM1TmL7xQCa2UrKVpiPuLbgZ5Oe3j2Y/OApB6oHpL9jRpcIl+
 ryblEHTweyZ1Vb0sr2ZerKNXqHxCosQdKYTeE2CG3AX97ZFiAm4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sparse shows warnings for symbols that can be static.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>


Larry Finger (4):
  rtw88: Fix Sparse warning for rtw8822b
  rtw88: Fix Sparse warning for rtw8822c
  rtw88: Fix Sparse warning for rtw8723d
  rtw88: Fix Sparse warning for rtw8821c

 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.36.1

