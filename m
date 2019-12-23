Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2DFD129684
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2019 14:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLWNbu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 08:31:50 -0500
Received: from srv2.anyservers.com ([77.79.239.202]:35586 "EHLO
        srv2.anyservers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfLWNbt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 08:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=asmblr.net;
         s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SUrMh+BHIOC24ZAm0n+NADsw/cuWmXCc+FgBPXPbD4Y=; b=TClo9OT2jIrZGlaK67Yi396Uun
        2yOfamIZ273XsqGc0S0vdku3Vcv4k8dGZLuRBjpPxD/tP3TAD6AaqyUFHcHdTPx4nYAkh0gKFfH8L
        OVCrvsEtpRLbMLmuqoPd/enqMhcunbXPOWaBbdIPLnaezNwTAtbueaxLtGg3b1t/q9v2gUMHfltjI
        0B5rT4nuHx/idmjvQuSIKn92ehP2vYzhVL3vvwaa0hIrIQbld2CiZLHyijiEiQD8xoZycLvjEqlQo
        mLi0Nwj706sm2G2WW0k00YoEcKLczhKm56vqJEtbnHN3m/ocDRKmeXmkjR/+3mGkoOIdpw5hKZQ3T
        dSlT8JcQ==;
Received: from 89-64-37-27.dynamic.chello.pl ([89.64.37.27]:49046 helo=milkyway.galaxy)
        by srv2.anyservers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <amade@asmblr.net>)
        id 1ijMxQ-00Gi5o-0n; Mon, 23 Dec 2019 13:37:08 +0100
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amade@asmblr.net>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amade@asmblr.net>
Subject: [PATCH 4/9] rtlwifi: rtl8192cu: Remove sw.h header
Date:   Mon, 23 Dec 2019 13:37:10 +0100
Message-Id: <20191223123715.7177-5-amade@asmblr.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191223123715.7177-1-amade@asmblr.net>
References: <20191223123715.7177-1-amade@asmblr.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv2.anyservers.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - asmblr.net
X-Get-Message-Sender-Via: srv2.anyservers.com: authenticated_id: amade@asmblr.net
X-Authenticated-Sender: srv2.anyservers.com: amade@asmblr.net
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It has one define, which is already defined in include from reg.h.
All functions are declared in their own headers and included in *.c
files belonging to them.
This makes sw.h unnecessary, so we can remove it.

Signed-off-by: Amadeusz Sławiński <amade@asmblr.net>
---
 .../wireless/realtek/rtlwifi/rtl8192cu/sw.c   |  1 -
 .../wireless/realtek/rtlwifi/rtl8192cu/sw.h   | 27 -------------------
 2 files changed, 28 deletions(-)
 delete mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.h

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
index 6b954059e830..b53daf1b29f7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
@@ -12,7 +12,6 @@
 #include "mac.h"
 #include "dm.h"
 #include "rf.h"
-#include "sw.h"
 #include "trx.h"
 #include "led.h"
 #include "hw.h"
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.h
deleted file mode 100644
index 662440c4cdc9..000000000000
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 2009-2012  Realtek Corporation.*/
-
-#ifndef __RTL92CU_SW_H__
-#define __RTL92CU_SW_H__
-
-#define EFUSE_MAX_SECTION	16
-
-void rtl92cu_phy_rf6052_set_cck_txpower(struct ieee80211_hw *hw,
-					u8 *powerlevel);
-void rtl92cu_phy_rf6052_set_ofdm_txpower(struct ieee80211_hw *hw,
-					u8 *ppowerlevel, u8 channel);
-bool _rtl92cu_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
-					    u8 configtype);
-bool _rtl92cu_phy_config_bb_with_pgheaderfile(struct ieee80211_hw *hw,
-						    u8 configtype);
-void _rtl92cu_phy_lc_calibrate(struct ieee80211_hw *hw, bool is2t);
-void rtl92cu_phy_set_rf_reg(struct ieee80211_hw *hw,
-			   enum radio_path rfpath,
-			   u32 regaddr, u32 bitmask, u32 data);
-bool rtl92cu_phy_set_rf_power_state(struct ieee80211_hw *hw,
-				   enum rf_pwrstate rfpwr_state);
-u32 rtl92cu_phy_query_rf_reg(struct ieee80211_hw *hw,
-			    enum radio_path rfpath, u32 regaddr, u32 bitmask);
-void rtl92cu_phy_set_bw_mode_callback(struct ieee80211_hw *hw);
-
-#endif
-- 
2.24.1

