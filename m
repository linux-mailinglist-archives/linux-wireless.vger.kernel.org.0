Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74415537FBE
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 16:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiE3ODb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 10:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbiE3OBn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 10:01:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773AFC5D98;
        Mon, 30 May 2022 06:39:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8042B80DB3;
        Mon, 30 May 2022 13:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25965C3411C;
        Mon, 30 May 2022 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653917969;
        bh=6SQtvCCi7KG7ZERvGOkFPImwwLGdIpID+YyAH/hlYBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jovwoMEhgiIXWiziuiuZ5jP4+cD1GidA1Z+zgq/LmEF1AqyIhx9pYVC8wBfkSGhHF
         vjIVsKO3irX4IWm9pUCP3BPIuAbj3ZBb0fKoI2WbRgXl/FTnnUFGHk6aOaUms805ti
         YLaryWDwxrzsVhy7DAC75G2v8Hd7LoK666tRVslOpakusjZTvuXtkU6m2k6MUkPcVq
         QmNLeBp4YUdR4SwkDslvXM36/350VkLcnLNo2Ze9paqOXwC7eRflRnjhpBdeRHXSCK
         VKegZaLbUgAM9O87qpwDEwLM1cZ3fUlQnloMGuc3gBb2NbP2CnkkJGs8x8p/QjlSV5
         YmKJdTb7/0tGg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Po-Hao Huang <phhuang@realtek.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>,
        tony0620emma@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 021/109] rtw88: 8821c: fix debugfs rssi value
Date:   Mon, 30 May 2022 09:36:57 -0400
Message-Id: <20220530133825.1933431-21-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530133825.1933431-1-sashal@kernel.org>
References: <20220530133825.1933431-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

[ Upstream commit ece31c93d4d68f7eb8eea4431b052aacdb678de2 ]

RSSI value per frame is reported to mac80211 but not maintained in
our own statistics, add it back to help us debug.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20220407095858.46807-7-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 785b8181513f..f405f42d1c1b 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -506,6 +506,7 @@ static s8 get_cck_rx_pwr(struct rtw_dev *rtwdev, u8 lna_idx, u8 vga_idx)
 static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
 				   struct rtw_rx_pkt_stat *pkt_stat)
 {
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	s8 rx_power;
 	u8 lna_idx = 0;
 	u8 vga_idx = 0;
@@ -517,6 +518,7 @@ static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
 
 	pkt_stat->rx_power[RF_PATH_A] = rx_power;
 	pkt_stat->rssi = rtw_phy_rf_power_2_rssi(pkt_stat->rx_power, 1);
+	dm_info->rssi[RF_PATH_A] = pkt_stat->rssi;
 	pkt_stat->bw = RTW_CHANNEL_WIDTH_20;
 	pkt_stat->signal_power = rx_power;
 }
@@ -524,6 +526,7 @@ static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
 static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
 				   struct rtw_rx_pkt_stat *pkt_stat)
 {
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	u8 rxsc, bw;
 	s8 min_rx_power = -120;
 
@@ -543,6 +546,7 @@ static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
 
 	pkt_stat->rx_power[RF_PATH_A] = GET_PHY_STAT_P1_PWDB_A(phy_status) - 110;
 	pkt_stat->rssi = rtw_phy_rf_power_2_rssi(pkt_stat->rx_power, 1);
+	dm_info->rssi[RF_PATH_A] = pkt_stat->rssi;
 	pkt_stat->bw = bw;
 	pkt_stat->signal_power = max(pkt_stat->rx_power[RF_PATH_A],
 				     min_rx_power);
-- 
2.35.1

