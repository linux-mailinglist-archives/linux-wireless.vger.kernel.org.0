Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC7F2AFECB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 06:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgKLFiy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 00:38:54 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:38682 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgKLDPh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 22:15:37 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AC3FVTf8025866, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AC3FVTf8025866
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 11:15:31 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 12 Nov 2020 11:15:30 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 04/11] rtw88: coex: Add force flag for coexistence table function
Date:   Thu, 12 Nov 2020 11:14:23 +0800
Message-ID: <20201112031430.4846-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201112031430.4846-1-pkshih@realtek.com>
References: <20201112031430.4846-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Because sometimes hardware action may be unpredictable.
(Ex: after WLAN LPS...etc)
Add a check mechanism if the action is triggered by
some concerned case, it can force to write the table again.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 62 +++++++++++++----------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index cbc0b7417887..d098a0c2c099 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -851,9 +851,19 @@ static void rtw_coex_set_gnt_wl(struct rtw_dev *rtwdev, u8 state)
 	rtw_coex_write_indirect_reg(rtwdev, LTE_COEX_CTRL, 0x0300, state);
 }
 
-static void rtw_coex_set_table(struct rtw_dev *rtwdev, u32 table0, u32 table1)
+static void rtw_coex_set_table(struct rtw_dev *rtwdev, bool force, u32 table0,
+			       u32 table1)
 {
 #define DEF_BRK_TABLE_VAL 0xf0ffffff
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+
+	/* If last tdma is wl slot toggle, force write table*/
+	if (!force && coex_dm->reason != COEX_RSN_LPS) {
+		if (table0 == rtw_read32(rtwdev, REG_BT_COEX_TABLE0) &&
+		    table1 == rtw_read32(rtwdev, REG_BT_COEX_TABLE1))
+			return;
+	}
 	rtw_write32(rtwdev, REG_BT_COEX_TABLE0, table0);
 	rtw_write32(rtwdev, REG_BT_COEX_TABLE1, table1);
 	rtw_write32(rtwdev, REG_BT_COEX_BRK_TABLE, DEF_BRK_TABLE_VAL);
@@ -863,7 +873,7 @@ static void rtw_coex_set_table(struct rtw_dev *rtwdev, u32 table0, u32 table1)
 		table1);
 }
 
-static void rtw_coex_table(struct rtw_dev *rtwdev, u8 type)
+static void rtw_coex_table(struct rtw_dev *rtwdev, bool force, u8 type)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
@@ -876,13 +886,13 @@ static void rtw_coex_table(struct rtw_dev *rtwdev, u8 type)
 
 	if (efuse->share_ant) {
 		if (type < chip->table_sant_num)
-			rtw_coex_set_table(rtwdev,
+			rtw_coex_set_table(rtwdev, force,
 					   chip->table_sant[type].bt,
 					   chip->table_sant[type].wl);
 	} else {
 		type = type - 100;
 		if (type < chip->table_nsant_num)
-			rtw_coex_set_table(rtwdev,
+			rtw_coex_set_table(rtwdev, force,
 					   chip->table_nsant[type].bt,
 					   chip->table_nsant[type].wl);
 	}
@@ -1331,7 +1341,7 @@ static void rtw_coex_action_coex_all_off(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
 
@@ -1375,7 +1385,7 @@ static void rtw_coex_action_freerun(struct rtw_dev *rtwdev)
 	else
 		rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[level]);
 
-	rtw_coex_table(rtwdev, 100);
+	rtw_coex_table(rtwdev, false, 100);
 	rtw_coex_tdma(rtwdev, false, 100);
 }
 
@@ -1400,7 +1410,7 @@ static void rtw_coex_action_bt_whql_test(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
 
@@ -1425,7 +1435,7 @@ static void rtw_coex_action_bt_relink(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
 
@@ -1456,7 +1466,7 @@ static void rtw_coex_action_bt_idle(struct rtw_dev *rtwdev)
 
 	if (table_case != 0xff && tdma_case != 0xff) {
 		rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G_FREERUN);
-		rtw_coex_table(rtwdev, table_case);
+		rtw_coex_table(rtwdev, false, table_case);
 		rtw_coex_tdma(rtwdev, false, tdma_case);
 		return;
 	}
@@ -1490,7 +1500,7 @@ static void rtw_coex_action_bt_idle(struct rtw_dev *rtwdev)
 		}
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
 
@@ -1585,7 +1595,7 @@ static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], wifi hi(%d), bt page(%d)\n",
 		wl_hi_pri, coex_stat->bt_page);
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
 
@@ -1621,7 +1631,7 @@ static void rtw_coex_action_bt_hfp(struct rtw_dev *rtwdev)
 		}
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
 
@@ -1694,7 +1704,7 @@ static void rtw_coex_action_bt_hid(struct rtw_dev *rtwdev)
 		}
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
 
@@ -1736,7 +1746,7 @@ static void rtw_coex_action_bt_a2dp(struct rtw_dev *rtwdev)
 			tdma_case = 113;
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
 
@@ -1775,7 +1785,7 @@ static void rtw_coex_action_bt_a2dpsink(struct rtw_dev *rtwdev)
 		}
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
 
@@ -1812,7 +1822,7 @@ static void rtw_coex_action_bt_pan(struct rtw_dev *rtwdev)
 			tdma_case = 119;
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
 
@@ -1856,7 +1866,7 @@ static void rtw_coex_action_bt_a2dp_hid(struct rtw_dev *rtwdev)
 			tdma_case = 113;
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
 
@@ -1894,7 +1904,7 @@ static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
 			tdma_case = 120;
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
 
@@ -1929,7 +1939,7 @@ static void rtw_coex_action_bt_pan_hid(struct rtw_dev *rtwdev)
 			tdma_case = 119;
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
 
@@ -1963,7 +1973,7 @@ static void rtw_coex_action_bt_a2dp_pan_hid(struct rtw_dev *rtwdev)
 			tdma_case = 120;
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
 
@@ -1990,7 +2000,7 @@ static void rtw_coex_action_wl_under5g(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
 
@@ -2014,7 +2024,7 @@ static void rtw_coex_action_wl_only(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
 
@@ -2043,7 +2053,7 @@ static void rtw_coex_action_wl_native_lps(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
 
@@ -2081,7 +2091,7 @@ static void rtw_coex_action_wl_linkscan(struct rtw_dev *rtwdev)
 		}
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
 
@@ -2105,7 +2115,7 @@ static void rtw_coex_action_wl_not_connected(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
 
@@ -2337,7 +2347,7 @@ static void __rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only)
 	}
 
 	/* PTA parameter */
-	rtw_coex_table(rtwdev, 0);
+	rtw_coex_table(rtwdev, false, 0);
 	rtw_coex_tdma(rtwdev, true, 0);
 	rtw_coex_query_bt_info(rtwdev);
 }
-- 
2.21.0

