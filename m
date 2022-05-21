Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6AD52FE93
	for <lists+linux-wireless@lfdr.de>; Sat, 21 May 2022 19:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344212AbiEURcB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 May 2022 13:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbiEURcA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 May 2022 13:32:00 -0400
Received: from p-impout002.msg.pkvw.co.charter.net (p-impout002aa.msg.pkvw.co.charter.net [47.43.26.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85173BBF7
        for <linux-wireless@vger.kernel.org>; Sat, 21 May 2022 10:31:57 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id sSxHnqW0wFl1esSxHnDBaN; Sat, 21 May 2022 17:31:56 +0000
X-Authority-Analysis: v=2.4 cv=EpDBEAQA c=1 sm=1 tr=0 ts=6289220c
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17 a=yQdBAQUQAAAA:8
 a=i_adScBDxswSB8NuF64A:9 a=SzazLyfi1tnkUD6oumHU:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH v2 0/4] rtw88: Make some symbols be static
Date:   Sat, 21 May 2022 12:31:40 -0500
Message-Id: <20220521173144.9917-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOo6j5XJBlRRHqn1JTb3l6F5drycqWnkVj6SY7lRByCL6rZQXPLYDpNSSsX6D8cTw/ftzg6LKav0F7T7lk79eSYQz6EMR7FsXfo9eHXNDYDWVbpb0vVN
 +GF6y4okrS60ENDY6pPfDL0GHUxFdjdFUqjjTJ5iBiAxC51khjAvPN7kQgFMHlv5LsXTjfCh3zK5aTudokKaXAVZYuDeCNHsxgYhGq6JVH538c/IGxPpct7L
 gQe/UZvvLcuYki0rfAQrtBc5WK+yLD25DK55EyPU8ckAiFVbAvdAnxnXYU0v3xGJoaUe9dJRcwr5dFHUxDWeBnjuYkd48HLweycf3TKJnRy1mLfGboa/QCDR
 KJJoWkcZ2A/0LqCjbLn29+MH8TA8nF2c6L8/eA7viHHOASYo+lc=
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
---
v2 Change patch subjects as recommended by Kalle
---
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

