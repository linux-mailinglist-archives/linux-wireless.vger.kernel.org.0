Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9FF532DA2
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 17:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbiEXPgo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 11:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiEXPgm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 11:36:42 -0400
Received: from p-impout007.msg.pkvw.co.charter.net (p-impout007aa.msg.pkvw.co.charter.net [47.43.26.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF43F30F62
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 08:36:39 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id tWaMnfPwitfLptWaMny5as; Tue, 24 May 2022 15:36:39 +0000
X-Authority-Analysis: v=2.4 cv=A+F/goaG c=1 sm=1 tr=0 ts=628cfb87
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17 a=yQdBAQUQAAAA:8
 a=7-0AI3a7wxOMXNi2MH4A:9 a=SzazLyfi1tnkUD6oumHU:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH v3 0/4] rtw88: Fix some Sparse Warnings
Date:   Tue, 24 May 2022 10:36:17 -0500
Message-Id: <20220524153621.19027-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCqoHkmv2c2e1gO+0c9fPBzY3vQll1Bd36ppsv9EeX6Gi6Y6BH/C4NuwxdDmCBhe62pV/uoOICM1uLokfua5EiWsv7SG5aVC/bUL9Voy0hRsTHtoov8Z
 WF9V0pZBNvXo8O4jKP6ZrIHIYFpY8cTV51mE9TwJjW73DEPxJqnQsKIUzqIfiChYclUwTNkf2yz+GvO/rQh0IU3H5I4dJNEbNKbOXYA4iMmVBFnZoR3B7Uoz
 dVvMx1c4RCMhcfdMu3uhsd7biLtSNrKiEjpQEBvk1GUPTykuVZ0JgIhGlRKr1OPvdWf9ygKShBqYO0foLopXI7tFexjOLaniwtKmc0KofYA2KvZBAq44rU7n
 rIKPF1nVYHzN4KrZD/fKjnvojs9sFzP/3QkeEwRD07InS1mSeAk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sparse shows warnings for symbols that can be static. In these cases.
the wrong solution is suggested - again reinforcing the concept
that all tools may suggest the wrong answer, and must be checked.

Constify all *_hw_spec variables

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 Change patch subjects as recommended by Kalle
v3 Make the correct fix for the warnings - 'static' is incorrect, but const is correct
---

Larry Finger (4):
  rtw88: Fix sparse warning for rtw8822b_hw_spec
  rtw88: Fix Sparse warning for rtw8822c_hw_spec
  rtw88: Fix Sparse warning for rtw8723d_hw_spec
  rtw88: Fix Sparse warning for rtw8821c_hw_spec

 drivers/net/wireless/realtek/rtw88/rtw8723d.h  |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8723de.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723de.h | 10 ----------
 drivers/net/wireless/realtek/rtw88/rtw8821c.h  |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8821ce.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821ce.h | 10 ----------
 drivers/net/wireless/realtek/rtw88/rtw8822b.h  |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8822be.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822be.h | 10 ----------
 drivers/net/wireless/realtek/rtw88/rtw8822c.h  |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8822ce.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822ce.h | 10 ----------
 12 files changed, 12 insertions(+), 44 deletions(-)
 delete mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723de.h
 delete mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821ce.h
 delete mode 100644 drivers/net/wireless/realtek/rtw88/rtw8822be.h
 delete mode 100644 drivers/net/wireless/realtek/rtw88/rtw8822ce.h

-- 
2.36.1

