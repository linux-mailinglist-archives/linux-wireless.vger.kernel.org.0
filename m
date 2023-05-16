Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1EE7047B3
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 10:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjEPIZ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 04:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjEPIZV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 04:25:21 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FB89B
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 01:25:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34G8P0kM4024403, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34G8P0kM4024403
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 16 May 2023 16:25:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 16 May 2023 16:25:08 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 16 May
 2023 16:25:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: rtw89: refine packet offload handling under SER
Date:   Tue, 16 May 2023 16:24:41 +0800
Message-ID: <20230516082441.11154-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230516082441.11154-1-pkshih@realtek.com>
References: <20230516082441.11154-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

H2C of packet offload needs to wait FW ACK by C2H. But, it's possible
that packet offload happens during SER (system error recovery), e.g.
SER L2 which restarts HW. More, packet offload flow isn't deferrable.
So, the H2C wait may get `ret == 1` (unreachable).

However, the logic FW deals with packet offload is simple enough, just
clone content. It means that as long as the H2C is issued successfully,
the thing will succeed sooner or later. Therefore, after we add a debug
log when receiving ACK to packet offload, it would be acceptable that
during SER, packet offload don't really wait for ACK. And, if debugging,
we can still check its debug logs. Besides, we can expect that if we see
SER before receiving ACK to packet offload, those debug logs of the ACK
have a time difference.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 4 ++--
 drivers/net/wireless/realtek/rtw89/mac.c | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index b7befcfd4a913..f7d4f9d14736d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2467,7 +2467,7 @@ int rtw89_fw_h2c_del_pkt_offload(struct rtw89_dev *rtwdev, u8 id)
 	cond = RTW89_FW_OFLD_WAIT_COND_PKT_OFLD(id, RTW89_PKT_OFLD_OP_DEL);
 
 	ret = rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
-	if (ret) {
+	if (ret < 0) {
 		rtw89_debug(rtwdev, RTW89_DBG_FW,
 			    "failed to del pkt ofld: id %d, ret %d\n",
 			    id, ret);
@@ -2517,7 +2517,7 @@ int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
 	cond = RTW89_FW_OFLD_WAIT_COND_PKT_OFLD(alloc_id, RTW89_PKT_OFLD_OP_ADD);
 
 	ret = rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
-	if (ret) {
+	if (ret < 0) {
 		rtw89_debug(rtwdev, RTW89_DBG_FW,
 			    "failed to add pkt ofld: id %d, ret %d\n",
 			    alloc_id, ret);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index acba53cf7cc31..f637fdafc7f10 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4456,6 +4456,9 @@ rtw89_mac_c2h_pkt_ofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h,
 	struct rtw89_completion_data data = {};
 	unsigned int cond;
 
+	rtw89_debug(rtwdev, RTW89_DBG_FW, "pkt ofld rsp: id %d op %d len %d\n",
+		    pkt_id, pkt_op, pkt_len);
+
 	data.err = !pkt_len;
 	cond = RTW89_FW_OFLD_WAIT_COND_PKT_OFLD(pkt_id, pkt_op);
 
-- 
2.25.1

