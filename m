Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DB9700026
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 08:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbjELGNC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 02:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239719AbjELGNB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 02:13:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8DD30CF
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 23:12:55 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34C6CXisC013910, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34C6CXisC013910
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 12 May 2023 14:12:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 12 May 2023 14:12:40 +0800
Received: from [127.0.1.1] (172.16.17.85) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 12 May
 2023 14:12:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/6] wifi: rtw89: 8851b: add more chip_ops to support 8851b
Date:   Fri, 12 May 2023 14:12:14 +0800
Message-ID: <20230512061220.16544-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.85]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

8851b version B is newly introduced, but version read from register is the
same as version A. To determine their difference, add patch 1/6 helper to
read version from efuse.

Patch 2/6 is to configure MUX to help antenna diversity that use GPIO to
control antenna path.

The remaining patches are to add more basic chip_ops like other chips.

Ping-Ke Shih (6):
  wifi: rtw89: 8851b: add to read efuse version to recognize hardware
    version B
  wifi: rtw89: 8851b: configure GPIO according to RFE type
  wifi: rtw89: 8851b: add BT coexistence support function
  wifi: rtw89: 8851b: add basic power on function
  wifi: rtw89: 8851b: add set channel function
  wifi: rtw89: 8851b: add to parse efuse content

 drivers/net/wireless/realtek/rtw89/coex.c     |    7 +
 drivers/net/wireless/realtek/rtw89/core.h     |    9 +
 drivers/net/wireless/realtek/rtw89/efuse.c    |   21 +
 drivers/net/wireless/realtek/rtw89/efuse.h    |    1 +
 drivers/net/wireless/realtek/rtw89/mac.h      |    2 +
 drivers/net/wireless/realtek/rtw89/phy.c      |    1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   40 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 1659 +++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.h |   61 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |    1 +
 12 files changed, 1804 insertions(+)

-- 
2.25.1

