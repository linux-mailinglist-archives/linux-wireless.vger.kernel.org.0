Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CA27DE97C
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Nov 2023 01:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjKBAiH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Nov 2023 20:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjKBAiG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Nov 2023 20:38:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334A5A6
        for <linux-wireless@vger.kernel.org>; Wed,  1 Nov 2023 17:38:01 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A20boSuB2121831, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 3A20boSuB2121831
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Nov 2023 08:37:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Nov 2023 08:37:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 2 Nov 2023
 08:37:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: coex: use struct assignment to replace memcpy() to append TDMA content
Date:   Thu, 2 Nov 2023 08:37:16 +0800
Message-ID: <20231102003716.25815-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: license violation
X-KSE-Antivirus-Attachment-Filter-Interceptor-Info: license violation
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To notify firmware TDMA timeslot assignment, append TDMA parameters when
sending policy H2C firmware command. However, compiler warns we do memcpy()
data to val[] field of TLV struct. To avoid this, assign the struct value
with simple '=' instead. Compile tested only.

rtw89/coex.c: In function '_append_tdma':
drivers/net/wireless/realtek/rtw89/coex.c:1585:17:
 warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
 1585 |                 memcpy(&v3->tdma, &dm->tdma, sizeof(v3->tdma));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/net/wireless/realtek/rtw89/coex.h:8,
                 from drivers/net/wireless/realtek/rtw89/coex.c:5:
drivers/net/wireless/realtek/rtw89/core.h:2703:37:
 note: at offset [5714, 71249] into destination object 'ver' of size 8
 2703 |         const struct rtw89_btc_ver *ver;
      |                                     ^~~
drivers/net/wireless/realtek/rtw89/coex.c:1579:17:
 warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
 1579 |                 memcpy(v, &dm->tdma, sizeof(*v));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw89/core.h:2703:37:
 note: at offset [5710, 71245] into destination object 'ver' of size 8
 2703 |         const struct rtw89_btc_ver *ver;
      |                                     ^~~

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310301908.Wrj0diqe-lkp@intel.com/
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index bdcc172639e4..b842cd9a86f8 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1576,13 +1576,13 @@ static void _append_tdma(struct rtw89_dev *rtwdev)
 	if (ver->fcxtdma == 1) {
 		v = (struct rtw89_btc_fbtc_tdma *)&tlv->val[0];
 		tlv->len = sizeof(*v);
-		memcpy(v, &dm->tdma, sizeof(*v));
+		*v = dm->tdma;
 		btc->policy_len += BTC_TLV_HDR_LEN + sizeof(*v);
 	} else {
 		tlv->len = sizeof(*v3);
 		v3 = (struct rtw89_btc_fbtc_tdma_v3 *)&tlv->val[0];
 		v3->fver = ver->fcxtdma;
-		memcpy(&v3->tdma, &dm->tdma, sizeof(v3->tdma));
+		v3->tdma = dm->tdma;
 		btc->policy_len += BTC_TLV_HDR_LEN + sizeof(*v3);
 	}
 
-- 
2.25.1

