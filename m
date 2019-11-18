Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41BDAFFD42
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 04:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfKRDPS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Nov 2019 22:15:18 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:38006 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfKRDPS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Nov 2019 22:15:18 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAI3F07e028821, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAI3F07e028821
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 18 Nov 2019 11:15:00 +0800
Received: from localhost.localdomain (172.21.69.95) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 18 Nov 2019 11:14:59 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <Larry.Finger@lwfinger.net>, <dev@lynxeye.de>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] rtlwifi: set proper udelay within rf_serial_read
Date:   Mon, 18 Nov 2019 11:14:55 +0800
Message-ID: <20191118031455.3893-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191118031455.3893-1-pkshih@realtek.com>
References: <20191118031455.3893-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.95]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

Since read RF register is an indirect access that hardware needs time to
accomplish read action, but there's no ready bit, so delay is required to
guarantee the read value is correct. After investigating internal documents,
these delays are reduced as proper values.

Reported-by: Lucas Stach <dev@lynxeye.de>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c         | 4 ++--
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c         | 3 +--
 drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c | 4 +---
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
index 7e3e512da739..455d6a4628cb 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
@@ -164,9 +164,9 @@ static u32 _rtl88e_phy_rf_serial_read(struct ieee80211_hw *hw,
 	    (newoffset << 23) | BLSSIREADEDGE;
 	rtl_set_bbreg(hw, RFPGA0_XA_HSSIPARAMETER2, MASKDWORD,
 		      tmplong & (~BLSSIREADEDGE));
-	mdelay(1);
+	udelay(10);
 	rtl_set_bbreg(hw, pphyreg->rfhssi_para2, MASKDWORD, tmplong2);
-	mdelay(2);
+	udelay(120);
 	if (rfpath == RF90_PATH_A)
 		rfpi_enable = (u8)rtl_get_bbreg(hw, RFPGA0_XA_HSSIPARAMETER1,
 						BIT(8));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
index 89fd83333292..330dea839153 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
@@ -158,9 +158,8 @@ static u32 _rtl92ee_phy_rf_serial_read(struct ieee80211_hw *hw,
 		   (newoffset << 23) | BLSSIREADEDGE;
 	rtl_set_bbreg(hw, RFPGA0_XA_HSSIPARAMETER2, MASKDWORD,
 		      tmplong & (~BLSSIREADEDGE));
-	mdelay(1);
 	rtl_set_bbreg(hw, pphyreg->rfhssi_para2, MASKDWORD, tmplong2);
-	mdelay(2);
+	udelay(20);
 	if (rfpath == RF90_PATH_A)
 		rfpi_enable = (u8)rtl_get_bbreg(hw, RFPGA0_XA_HSSIPARAMETER1,
 						BIT(8));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
index aae14c68bf69..debecc623a01 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
@@ -89,12 +89,10 @@ u32 rtl8723_phy_rf_serial_read(struct ieee80211_hw *hw,
 	    (newoffset << 23) | BLSSIREADEDGE;
 	rtl_set_bbreg(hw, RFPGA0_XA_HSSIPARAMETER2, MASKDWORD,
 		      tmplong & (~BLSSIREADEDGE));
-	mdelay(1);
 	rtl_set_bbreg(hw, pphyreg->rfhssi_para2, MASKDWORD, tmplong2);
-	mdelay(1);
 	rtl_set_bbreg(hw, RFPGA0_XA_HSSIPARAMETER2, MASKDWORD,
 		      tmplong | BLSSIREADEDGE);
-	mdelay(1);
+	udelay(120);
 	if (rfpath == RF90_PATH_A)
 		rfpi_enable = (u8) rtl_get_bbreg(hw, RFPGA0_XA_HSSIPARAMETER1,
 						 BIT(8));
-- 
2.21.0

