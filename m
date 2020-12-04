Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8CB2CE534
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 02:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgLDBjS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Dec 2020 20:39:18 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:46814 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLDBjS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Dec 2020 20:39:18 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0B41cTd95010331, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0B41cTd95010331
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 4 Dec 2020 09:38:29 +0800
Received: from localhost (172.21.69.213) by RTEXMB04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 4 Dec 2020
 09:38:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <kevin_yang@realtek.com>
Subject: [PATCH] rtw88: declare hw supports ch 144
Date:   Fri, 4 Dec 2020 09:38:23 +0800
Message-ID: <20201204013823.3729-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXH365.realtek.com.tw (172.21.6.37) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

When driver was developed, FCC regulation didn't enable channel 144
and there was no demand for channel 144 at that time. Although HW
actually supports channel 144, driver didn't announce channel 144.
Therefore, channel 144 (20 MHz), channel 142 (40 MHz) and channel
138 (80 MHz) couldn't be used.

Today, channel 144 has been enabled by regulations and
is gradually being supported. With test requirements,
we declare hw supports channel 144.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 47969a6f957c..e7c1ae454524 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -67,6 +67,7 @@ static struct ieee80211_channel rtw_channeltable_5g[] = {
 	{.center_freq = 5660, .hw_value = 132,},
 	{.center_freq = 5680, .hw_value = 136,},
 	{.center_freq = 5700, .hw_value = 140,},
+	{.center_freq = 5720, .hw_value = 144,},
 	{.center_freq = 5745, .hw_value = 149,},
 	{.center_freq = 5765, .hw_value = 153,},
 	{.center_freq = 5785, .hw_value = 157,},
-- 
2.21.0

