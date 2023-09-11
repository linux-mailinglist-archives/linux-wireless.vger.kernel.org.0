Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E609279A5EB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Sep 2023 10:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjIKIWO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Sep 2023 04:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjIKIWO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Sep 2023 04:22:14 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49B1E7
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 01:22:09 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38B8M2WF01002935, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38B8M2WF01002935
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 16:22:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 11 Sep 2023 16:22:01 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 11 Sep
 2023 16:22:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/6] wifi: rtw89: add to fill TX descriptor for firmware command v2
Date:   Mon, 11 Sep 2023 16:20:45 +0800
Message-ID: <20230911082049.33541-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911082049.33541-1-pkshih@realtek.com>
References: <20230911082049.33541-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This kind of TX descriptor is used to download firmware or send firmware
command. Because we want to reduce descriptor overhead and this only needs
two fields 'size' and 'type', hardware designers choose short form of
RX descriptor for it.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 20 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 127e5b2f72be..7e2ba17c278e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1235,6 +1235,26 @@ void rtw89_core_fill_txdesc_fwcmd_v1(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_core_fill_txdesc_fwcmd_v1);
 
+static __le32 rtw89_build_txwd_fwcmd0_v2(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(BE_RXD_RPKT_LEN_MASK, desc_info->pkt_size) |
+		    FIELD_PREP(BE_RXD_RPKT_TYPE_MASK, desc_info->fw_dl ?
+						      RTW89_CORE_RX_TYPE_FWDL :
+						      RTW89_CORE_RX_TYPE_H2C);
+
+	return cpu_to_le32(dword);
+}
+
+void rtw89_core_fill_txdesc_fwcmd_v2(struct rtw89_dev *rtwdev,
+				     struct rtw89_tx_desc_info *desc_info,
+				     void *txdesc)
+{
+	struct rtw89_rxdesc_short_v2 *txwd_v2 = (struct rtw89_rxdesc_short_v2 *)txdesc;
+
+	txwd_v2->dword0 = rtw89_build_txwd_fwcmd0_v2(desc_info);
+}
+EXPORT_SYMBOL(rtw89_core_fill_txdesc_fwcmd_v2);
+
 static int rtw89_core_rx_process_mac_ppdu(struct rtw89_dev *rtwdev,
 					  struct sk_buff *skb,
 					  struct rtw89_rx_phy_ppdu *phy_ppdu)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index afdac66745e5..77a6a5856cc3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5466,6 +5466,9 @@ void rtw89_core_fill_txdesc_v1(struct rtw89_dev *rtwdev,
 void rtw89_core_fill_txdesc_fwcmd_v1(struct rtw89_dev *rtwdev,
 				     struct rtw89_tx_desc_info *desc_info,
 				     void *txdesc);
+void rtw89_core_fill_txdesc_fwcmd_v2(struct rtw89_dev *rtwdev,
+				     struct rtw89_tx_desc_info *desc_info,
+				     void *txdesc);
 void rtw89_core_rx(struct rtw89_dev *rtwdev,
 		   struct rtw89_rx_desc_info *desc_info,
 		   struct sk_buff *skb);
-- 
2.25.1

