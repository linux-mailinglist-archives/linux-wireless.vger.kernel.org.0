Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588A82F414F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jan 2021 02:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbhAMBpV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jan 2021 20:45:21 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:41787 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbhAMBpJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jan 2021 20:45:09 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10D1iLX11028607, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10D1iLX11028607
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Jan 2021 09:44:21 +0800
Received: from localhost (172.21.69.213) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 13 Jan
 2021 09:44:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] rtw88: 8723de: adjust the LTR setting
Date:   Wed, 13 Jan 2021 09:43:42 +0800
Message-ID: <20210113014342.3615-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

The LTR mechanism enables PCIE Endpoints to report the service latency
requirements and CPU will enter appropriate sleep state to save power
based on the LTR value.

8723de provides two registers to config the LTR, and the original setting
is too short for CPU to ente sleep state. The patch adjust the LTR setting.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 9268ea8b6dda..3fdbaf7302c5 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -60,8 +60,8 @@ static const struct rtw_hw_reg rtw8723d_txagc[] = {
 #define WLAN_MAX_AGG_NR		0x0A
 #define WLAN_AMPDU_MAX_TIME	0x1C
 #define WLAN_ANT_SEL		0x82
-#define WLAN_LTR_IDLE_LAT	0x883C883C
-#define WLAN_LTR_ACT_LAT	0x880B880B
+#define WLAN_LTR_IDLE_LAT	0x90039003
+#define WLAN_LTR_ACT_LAT	0x883c883c
 #define WLAN_LTR_CTRL1		0xCB004010
 #define WLAN_LTR_CTRL2		0x01233425
 
-- 
2.21.0

