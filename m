Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55A4219943
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2019 10:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfEJIDy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 May 2019 04:03:54 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59213 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfEJIDx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 May 2019 04:03:53 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x4A83cul021569, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x4A83cul021569
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Fri, 10 May 2019 16:03:38 +0800
Received: from localhost.localdomain (172.21.69.114) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Fri, 10 May 2019 16:03:38 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>,
        <colin.king@canonical.com>
Subject: [PATCH 1/4] rtlwifi: 8192de: Reduce indentation and fix coding style
Date:   Fri, 10 May 2019 16:03:30 +0800
Message-ID: <20190510080333.3789-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190510080333.3789-1-pkshih@realtek.com>
References: <20190510080333.3789-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.114]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

This commit doesn't change logic at all. Since indentation is lower, the
wrapped statements can be put in single line that will become more
readable.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../wireless/realtek/rtlwifi/rtl8192de/dm.c   | 640 +++++++++---------
 1 file changed, 303 insertions(+), 337 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
index 7cc86bb387a1..6bbbd36cc664 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
@@ -837,365 +837,331 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 		 rtlpriv->dm.thermalvalue, rtlefuse->eeprom_thermalmeter);
 	rtl92d_phy_ap_calibrate(hw, (thermalvalue -
 				     rtlefuse->eeprom_thermalmeter));
+
+	if (!thermalvalue)
+		goto exit;
+
 	if (is2t)
 		rf = 2;
 	else
 		rf = 1;
-	if (thermalvalue) {
-		ele_d = rtl_get_bbreg(hw, ROFDM0_XATXIQIMBALANCE,
+
+	ele_d = rtl_get_bbreg(hw, ROFDM0_XATXIQIMBALANCE,  MASKDWORD) & MASKOFDM_D;
+	for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {
+		if (ele_d == (ofdmswing_table[i] & MASKOFDM_D)) {
+			ofdm_index_old[0] = (u8)i;
+
+			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				 "Initial pathA ele_d reg0x%x = 0x%lx, ofdm_index=0x%x\n",
+				 ROFDM0_XATXIQIMBALANCE,
+				 ele_d, ofdm_index_old[0]);
+			break;
+		}
+	}
+	if (is2t) {
+		ele_d = rtl_get_bbreg(hw, ROFDM0_XBTXIQIMBALANCE,
 				      MASKDWORD) & MASKOFDM_D;
 		for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {
-			if (ele_d == (ofdmswing_table[i] & MASKOFDM_D)) {
-				ofdm_index_old[0] = (u8) i;
-
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "Initial pathA ele_d reg0x%x = 0x%lx, ofdm_index=0x%x\n",
-					 ROFDM0_XATXIQIMBALANCE,
-					 ele_d, ofdm_index_old[0]);
+			if (ele_d ==
+			    (ofdmswing_table[i] & MASKOFDM_D)) {
+				ofdm_index_old[1] = (u8)i;
+				RT_TRACE(rtlpriv, COMP_POWER_TRACKING,
+					 DBG_LOUD,
+					 "Initial pathB ele_d reg 0x%x = 0x%lx, ofdm_index = 0x%x\n",
+					 ROFDM0_XBTXIQIMBALANCE, ele_d,
+					 ofdm_index_old[1]);
 				break;
 			}
 		}
-		if (is2t) {
-			ele_d = rtl_get_bbreg(hw, ROFDM0_XBTXIQIMBALANCE,
-					      MASKDWORD) & MASKOFDM_D;
-			for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {
-				if (ele_d ==
-				    (ofdmswing_table[i] & MASKOFDM_D)) {
-					ofdm_index_old[1] = (u8) i;
-					RT_TRACE(rtlpriv, COMP_POWER_TRACKING,
-						 DBG_LOUD,
-						 "Initial pathB ele_d reg 0x%x = 0x%lx, ofdm_index = 0x%x\n",
-						 ROFDM0_XBTXIQIMBALANCE, ele_d,
-						 ofdm_index_old[1]);
-					break;
-				}
-			}
-		}
-		if (rtlhal->current_bandtype == BAND_ON_2_4G) {
-			rtl92d_bandtype_2_4G(hw, &temp_cck, &cck_index_old);
-		} else {
-			temp_cck = 0x090e1317;
-			cck_index_old = 12;
-		}
+	}
+	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+		rtl92d_bandtype_2_4G(hw, &temp_cck, &cck_index_old);
+	} else {
+		temp_cck = 0x090e1317;
+		cck_index_old = 12;
+	}
 
-		if (!rtlpriv->dm.thermalvalue) {
-			rtlpriv->dm.thermalvalue =
-				 rtlefuse->eeprom_thermalmeter;
-			rtlpriv->dm.thermalvalue_lck = thermalvalue;
-			rtlpriv->dm.thermalvalue_iqk = thermalvalue;
-			rtlpriv->dm.thermalvalue_rxgain =
-					 rtlefuse->eeprom_thermalmeter;
-			for (i = 0; i < rf; i++)
-				rtlpriv->dm.ofdm_index[i] = ofdm_index_old[i];
-			rtlpriv->dm.cck_index = cck_index_old;
+	if (!rtlpriv->dm.thermalvalue) {
+		rtlpriv->dm.thermalvalue = rtlefuse->eeprom_thermalmeter;
+		rtlpriv->dm.thermalvalue_lck = thermalvalue;
+		rtlpriv->dm.thermalvalue_iqk = thermalvalue;
+		rtlpriv->dm.thermalvalue_rxgain = rtlefuse->eeprom_thermalmeter;
+		for (i = 0; i < rf; i++)
+			rtlpriv->dm.ofdm_index[i] = ofdm_index_old[i];
+		rtlpriv->dm.cck_index = cck_index_old;
+	}
+	if (rtlhal->reloadtxpowerindex) {
+		for (i = 0; i < rf; i++)
+			rtlpriv->dm.ofdm_index[i] = ofdm_index_old[i];
+		rtlpriv->dm.cck_index = cck_index_old;
+		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			 "reload ofdm index for band switch\n");
+	}
+	rtlpriv->dm.thermalvalue_avg
+		    [rtlpriv->dm.thermalvalue_avg_index] = thermalvalue;
+	rtlpriv->dm.thermalvalue_avg_index++;
+	if (rtlpriv->dm.thermalvalue_avg_index == AVG_THERMAL_NUM)
+		rtlpriv->dm.thermalvalue_avg_index = 0;
+	for (i = 0; i < AVG_THERMAL_NUM; i++) {
+		if (rtlpriv->dm.thermalvalue_avg[i]) {
+			thermalvalue_avg += rtlpriv->dm.thermalvalue_avg[i];
+			thermalvalue_avg_count++;
 		}
-		if (rtlhal->reloadtxpowerindex) {
+	}
+	if (thermalvalue_avg_count)
+		thermalvalue = (u8)(thermalvalue_avg / thermalvalue_avg_count);
+	if (rtlhal->reloadtxpowerindex) {
+		delta = (thermalvalue > rtlefuse->eeprom_thermalmeter) ?
+		    (thermalvalue - rtlefuse->eeprom_thermalmeter) :
+		    (rtlefuse->eeprom_thermalmeter - thermalvalue);
+		rtlhal->reloadtxpowerindex = false;
+		rtlpriv->dm.done_txpower = false;
+	} else if (rtlpriv->dm.done_txpower) {
+		delta = (thermalvalue > rtlpriv->dm.thermalvalue) ?
+		    (thermalvalue - rtlpriv->dm.thermalvalue) :
+		    (rtlpriv->dm.thermalvalue - thermalvalue);
+	} else {
+		delta = (thermalvalue > rtlefuse->eeprom_thermalmeter) ?
+		    (thermalvalue - rtlefuse->eeprom_thermalmeter) :
+		    (rtlefuse->eeprom_thermalmeter - thermalvalue);
+	}
+	delta_lck = (thermalvalue > rtlpriv->dm.thermalvalue_lck) ?
+	    (thermalvalue - rtlpriv->dm.thermalvalue_lck) :
+	    (rtlpriv->dm.thermalvalue_lck - thermalvalue);
+	delta_iqk = (thermalvalue > rtlpriv->dm.thermalvalue_iqk) ?
+	    (thermalvalue - rtlpriv->dm.thermalvalue_iqk) :
+	    (rtlpriv->dm.thermalvalue_iqk - thermalvalue);
+	delta_rxgain =
+		(thermalvalue > rtlpriv->dm.thermalvalue_rxgain) ?
+		(thermalvalue - rtlpriv->dm.thermalvalue_rxgain) :
+		(rtlpriv->dm.thermalvalue_rxgain - thermalvalue);
+	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		 "Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x delta 0x%x delta_lck 0x%x delta_iqk 0x%x\n",
+		 thermalvalue, rtlpriv->dm.thermalvalue,
+		 rtlefuse->eeprom_thermalmeter, delta, delta_lck,
+		 delta_iqk);
+	if (delta_lck > rtlefuse->delta_lck && rtlefuse->delta_lck != 0) {
+		rtlpriv->dm.thermalvalue_lck = thermalvalue;
+		rtl92d_phy_lc_calibrate(hw);
+	}
+
+	if (delta == 0 || !rtlpriv->dm.txpower_track_control)
+		goto check_delta;
+
+	rtlpriv->dm.done_txpower = true;
+	delta = (thermalvalue > rtlefuse->eeprom_thermalmeter) ?
+	    (thermalvalue - rtlefuse->eeprom_thermalmeter) :
+	    (rtlefuse->eeprom_thermalmeter - thermalvalue);
+	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+		offset = 4;
+		if (delta > INDEX_MAPPING_NUM - 1)
+			index = index_mapping[offset][INDEX_MAPPING_NUM - 1];
+		else
+			index = index_mapping[offset][delta];
+		if (thermalvalue > rtlpriv->dm.thermalvalue) {
 			for (i = 0; i < rf; i++)
-				rtlpriv->dm.ofdm_index[i] = ofdm_index_old[i];
-			rtlpriv->dm.cck_index = cck_index_old;
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "reload ofdm index for band switch\n");
-		}
-		rtlpriv->dm.thermalvalue_avg
-			    [rtlpriv->dm.thermalvalue_avg_index] = thermalvalue;
-		rtlpriv->dm.thermalvalue_avg_index++;
-		if (rtlpriv->dm.thermalvalue_avg_index == AVG_THERMAL_NUM)
-			rtlpriv->dm.thermalvalue_avg_index = 0;
-		for (i = 0; i < AVG_THERMAL_NUM; i++) {
-			if (rtlpriv->dm.thermalvalue_avg[i]) {
-				thermalvalue_avg +=
-					 rtlpriv->dm.thermalvalue_avg[i];
-				thermalvalue_avg_count++;
-			}
-		}
-		if (thermalvalue_avg_count)
-			thermalvalue = (u8) (thermalvalue_avg /
-					thermalvalue_avg_count);
-		if (rtlhal->reloadtxpowerindex) {
-			delta = (thermalvalue > rtlefuse->eeprom_thermalmeter) ?
-			    (thermalvalue - rtlefuse->eeprom_thermalmeter) :
-			    (rtlefuse->eeprom_thermalmeter - thermalvalue);
-			rtlhal->reloadtxpowerindex = false;
-			rtlpriv->dm.done_txpower = false;
-		} else if (rtlpriv->dm.done_txpower) {
-			delta = (thermalvalue > rtlpriv->dm.thermalvalue) ?
-			    (thermalvalue - rtlpriv->dm.thermalvalue) :
-			    (rtlpriv->dm.thermalvalue - thermalvalue);
+				ofdm_index[i] -= delta;
+			cck_index -= delta;
 		} else {
-			delta = (thermalvalue > rtlefuse->eeprom_thermalmeter) ?
-			    (thermalvalue - rtlefuse->eeprom_thermalmeter) :
-			    (rtlefuse->eeprom_thermalmeter - thermalvalue);
+			for (i = 0; i < rf; i++)
+				ofdm_index[i] += index;
+			cck_index += index;
 		}
-		delta_lck = (thermalvalue > rtlpriv->dm.thermalvalue_lck) ?
-		    (thermalvalue - rtlpriv->dm.thermalvalue_lck) :
-		    (rtlpriv->dm.thermalvalue_lck - thermalvalue);
-		delta_iqk = (thermalvalue > rtlpriv->dm.thermalvalue_iqk) ?
-		    (thermalvalue - rtlpriv->dm.thermalvalue_iqk) :
-		    (rtlpriv->dm.thermalvalue_iqk - thermalvalue);
-		delta_rxgain =
-			(thermalvalue > rtlpriv->dm.thermalvalue_rxgain) ?
-			(thermalvalue - rtlpriv->dm.thermalvalue_rxgain) :
-			(rtlpriv->dm.thermalvalue_rxgain - thermalvalue);
+	} else if (rtlhal->current_bandtype == BAND_ON_5G) {
+		rtl92d_bandtype_5G(rtlhal, ofdm_index,
+				   &internal_pa, thermalvalue,
+				   delta, rf, rtlefuse, rtlpriv,
+				   rtlphy, index_mapping,
+				   index_mapping_internal_pa);
+	}
+	if (is2t) {
+		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			 "temp OFDM_A_index=0x%x, OFDM_B_index = 0x%x,cck_index=0x%x\n",
+			 rtlpriv->dm.ofdm_index[0],
+			 rtlpriv->dm.ofdm_index[1],
+			 rtlpriv->dm.cck_index);
+	} else {
 		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x delta 0x%x delta_lck 0x%x delta_iqk 0x%x\n",
-			 thermalvalue, rtlpriv->dm.thermalvalue,
-			 rtlefuse->eeprom_thermalmeter, delta, delta_lck,
-			 delta_iqk);
-		if ((delta_lck > rtlefuse->delta_lck) &&
-		    (rtlefuse->delta_lck != 0)) {
-			rtlpriv->dm.thermalvalue_lck = thermalvalue;
-			rtl92d_phy_lc_calibrate(hw);
+			 "temp OFDM_A_index=0x%x,cck_index = 0x%x\n",
+			 rtlpriv->dm.ofdm_index[0],
+			 rtlpriv->dm.cck_index);
+	}
+	for (i = 0; i < rf; i++) {
+		if (ofdm_index[i] > OFDM_TABLE_SIZE_92D - 1)
+			ofdm_index[i] = OFDM_TABLE_SIZE_92D - 1;
+		else if (ofdm_index[i] < ofdm_min_index)
+			ofdm_index[i] = ofdm_min_index;
+	}
+	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+		if (cck_index > CCK_TABLE_SIZE - 1) {
+			cck_index = CCK_TABLE_SIZE - 1;
+		} else if (internal_pa ||
+			   rtlhal->current_bandtype == BAND_ON_2_4G) {
+			if (ofdm_index[i] < ofdm_min_index_internal_pa)
+				ofdm_index[i] = ofdm_min_index_internal_pa;
+		} else if (cck_index < 0) {
+			cck_index = 0;
 		}
-		if (delta > 0 && rtlpriv->dm.txpower_track_control) {
-			rtlpriv->dm.done_txpower = true;
-			delta = (thermalvalue > rtlefuse->eeprom_thermalmeter) ?
-			    (thermalvalue - rtlefuse->eeprom_thermalmeter) :
-			    (rtlefuse->eeprom_thermalmeter - thermalvalue);
-			if (rtlhal->current_bandtype == BAND_ON_2_4G) {
-				offset = 4;
-				if (delta > INDEX_MAPPING_NUM - 1)
-					index = index_mapping[offset]
-						[INDEX_MAPPING_NUM - 1];
-				else
-					index = index_mapping[offset][delta];
-				if (thermalvalue > rtlpriv->dm.thermalvalue) {
-					for (i = 0; i < rf; i++)
-						ofdm_index[i] -= delta;
-					cck_index -= delta;
-				} else {
-					for (i = 0; i < rf; i++)
-						ofdm_index[i] += index;
-					cck_index += index;
-				}
-			} else if (rtlhal->current_bandtype == BAND_ON_5G) {
-				rtl92d_bandtype_5G(rtlhal, ofdm_index,
-						   &internal_pa, thermalvalue,
-						   delta, rf, rtlefuse, rtlpriv,
-						   rtlphy, index_mapping,
-						   index_mapping_internal_pa);
-			}
-			if (is2t) {
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "temp OFDM_A_index=0x%x, OFDM_B_index = 0x%x,cck_index=0x%x\n",
-					 rtlpriv->dm.ofdm_index[0],
-					 rtlpriv->dm.ofdm_index[1],
-					 rtlpriv->dm.cck_index);
-			} else {
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "temp OFDM_A_index=0x%x,cck_index = 0x%x\n",
-					 rtlpriv->dm.ofdm_index[0],
-					 rtlpriv->dm.cck_index);
-			}
-			for (i = 0; i < rf; i++) {
-				if (ofdm_index[i] > OFDM_TABLE_SIZE_92D - 1)
-					ofdm_index[i] = OFDM_TABLE_SIZE_92D - 1;
-				else if (ofdm_index[i] < ofdm_min_index)
-					ofdm_index[i] = ofdm_min_index;
-			}
-			if (rtlhal->current_bandtype == BAND_ON_2_4G) {
-				if (cck_index > CCK_TABLE_SIZE - 1) {
-					cck_index = CCK_TABLE_SIZE - 1;
-				} else if (internal_pa ||
-					   rtlhal->current_bandtype ==
-					   BAND_ON_2_4G) {
-					if (ofdm_index[i] <
-					    ofdm_min_index_internal_pa)
-						ofdm_index[i] =
-						     ofdm_min_index_internal_pa;
-				} else if (cck_index < 0) {
-					cck_index = 0;
-				}
-			}
-			if (is2t) {
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "new OFDM_A_index=0x%x, OFDM_B_index = 0x%x, cck_index=0x%x\n",
-					 ofdm_index[0], ofdm_index[1],
-					 cck_index);
-			} else {
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "new OFDM_A_index=0x%x,cck_index = 0x%x\n",
-					 ofdm_index[0], cck_index);
-			}
-			ele_d = (ofdmswing_table[(u8) ofdm_index[0]] &
-						 0xFFC00000) >> 22;
-			val_x = rtlphy->iqk_matrix
-						[indexforchannel].value[0][0];
-			val_y = rtlphy->iqk_matrix
-						[indexforchannel].value[0][1];
-			if (val_x != 0) {
-				if ((val_x & 0x00000200) != 0)
-					val_x = val_x | 0xFFFFFC00;
-				ele_a =
-				    ((val_x * ele_d) >> 8) & 0x000003FF;
-
-				/* new element C = element D x Y */
-				if ((val_y & 0x00000200) != 0)
-					val_y = val_y | 0xFFFFFC00;
-				ele_c = ((val_y * ele_d) >> 8) & 0x000003FF;
-
-				/* wirte new elements A, C, D to regC80 and
-				 * regC94, element B is always 0 */
-				value32 = (ele_d << 22) | ((ele_c & 0x3F) <<
-					  16) | ele_a;
-				rtl_set_bbreg(hw, ROFDM0_XATXIQIMBALANCE,
-					      MASKDWORD, value32);
-
-				value32 = (ele_c & 0x000003C0) >> 6;
-				rtl_set_bbreg(hw, ROFDM0_XCTXAFE, MASKH4BITS,
-					      value32);
-
-				value32 = ((val_x * ele_d) >> 7) & 0x01;
-				rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(24),
-					      value32);
+	}
+	if (is2t) {
+		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			 "new OFDM_A_index=0x%x, OFDM_B_index = 0x%x, cck_index=0x%x\n",
+			 ofdm_index[0], ofdm_index[1],
+			 cck_index);
+	} else {
+		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			 "new OFDM_A_index=0x%x,cck_index = 0x%x\n",
+			 ofdm_index[0], cck_index);
+	}
+	ele_d = (ofdmswing_table[ofdm_index[0]] & 0xFFC00000) >> 22;
+	val_x = rtlphy->iqk_matrix[indexforchannel].value[0][0];
+	val_y = rtlphy->iqk_matrix[indexforchannel].value[0][1];
+	if (val_x != 0) {
+		if ((val_x & 0x00000200) != 0)
+			val_x = val_x | 0xFFFFFC00;
+		ele_a = ((val_x * ele_d) >> 8) & 0x000003FF;
+
+		/* new element C = element D x Y */
+		if ((val_y & 0x00000200) != 0)
+			val_y = val_y | 0xFFFFFC00;
+		ele_c = ((val_y * ele_d) >> 8) & 0x000003FF;
+
+		/* write new elements A, C, D to regC80 and
+		 * regC94, element B is always 0
+		 */
+		value32 = (ele_d << 22) | ((ele_c & 0x3F) << 16) | ele_a;
+		rtl_set_bbreg(hw, ROFDM0_XATXIQIMBALANCE,
+			      MASKDWORD, value32);
+
+		value32 = (ele_c & 0x000003C0) >> 6;
+		rtl_set_bbreg(hw, ROFDM0_XCTXAFE, MASKH4BITS,
+			      value32);
+
+		value32 = ((val_x * ele_d) >> 7) & 0x01;
+		rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(24),
+			      value32);
 
-			} else {
-				rtl_set_bbreg(hw, ROFDM0_XATXIQIMBALANCE,
-					      MASKDWORD,
-					      ofdmswing_table
-					      [(u8)ofdm_index[0]]);
-				rtl_set_bbreg(hw, ROFDM0_XCTXAFE, MASKH4BITS,
-					      0x00);
-				rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD,
-					      BIT(24), 0x00);
-			}
+	} else {
+		rtl_set_bbreg(hw, ROFDM0_XATXIQIMBALANCE,
+			      MASKDWORD,
+			      ofdmswing_table[(u8)ofdm_index[0]]);
+		rtl_set_bbreg(hw, ROFDM0_XCTXAFE, MASKH4BITS,
+			      0x00);
+		rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD,
+			      BIT(24), 0x00);
+	}
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "TxPwrTracking for interface %d path A: X = 0x%lx, Y = 0x%lx ele_A = 0x%lx ele_C = 0x%lx ele_D = 0x%lx 0xe94 = 0x%lx 0xe9c = 0x%lx\n",
-				 rtlhal->interfaceindex,
-				 val_x, val_y, ele_a, ele_c, ele_d,
-				 val_x, val_y);
-
-			if (cck_index >= CCK_TABLE_SIZE)
-				cck_index = CCK_TABLE_SIZE - 1;
-			if (cck_index < 0)
-				cck_index = 0;
-			if (rtlhal->current_bandtype == BAND_ON_2_4G) {
-				/* Adjust CCK according to IQK result */
-				if (!rtlpriv->dm.cck_inch14) {
-					rtl_write_byte(rtlpriv, 0xa22,
-						       cckswing_table_ch1ch13
-						       [(u8)cck_index][0]);
-					rtl_write_byte(rtlpriv, 0xa23,
-						       cckswing_table_ch1ch13
-						       [(u8)cck_index][1]);
-					rtl_write_byte(rtlpriv, 0xa24,
-						       cckswing_table_ch1ch13
-						       [(u8)cck_index][2]);
-					rtl_write_byte(rtlpriv, 0xa25,
-						       cckswing_table_ch1ch13
-						       [(u8)cck_index][3]);
-					rtl_write_byte(rtlpriv, 0xa26,
-						       cckswing_table_ch1ch13
-						       [(u8)cck_index][4]);
-					rtl_write_byte(rtlpriv, 0xa27,
-						       cckswing_table_ch1ch13
-						       [(u8)cck_index][5]);
-					rtl_write_byte(rtlpriv, 0xa28,
-						       cckswing_table_ch1ch13
-						       [(u8)cck_index][6]);
-					rtl_write_byte(rtlpriv, 0xa29,
-						       cckswing_table_ch1ch13
-						       [(u8)cck_index][7]);
-				} else {
-					rtl_write_byte(rtlpriv, 0xa22,
-						       cckswing_table_ch14
-						       [(u8)cck_index][0]);
-					rtl_write_byte(rtlpriv, 0xa23,
-						       cckswing_table_ch14
-						       [(u8)cck_index][1]);
-					rtl_write_byte(rtlpriv, 0xa24,
-						       cckswing_table_ch14
-						       [(u8)cck_index][2]);
-					rtl_write_byte(rtlpriv, 0xa25,
-						       cckswing_table_ch14
-						       [(u8)cck_index][3]);
-					rtl_write_byte(rtlpriv, 0xa26,
-						       cckswing_table_ch14
-						       [(u8)cck_index][4]);
-					rtl_write_byte(rtlpriv, 0xa27,
-						       cckswing_table_ch14
-						       [(u8)cck_index][5]);
-					rtl_write_byte(rtlpriv, 0xa28,
-						       cckswing_table_ch14
-						       [(u8)cck_index][6]);
-					rtl_write_byte(rtlpriv, 0xa29,
-						       cckswing_table_ch14
-						       [(u8)cck_index][7]);
-				}
-			}
-			if (is2t) {
-				ele_d = (ofdmswing_table[(u8) ofdm_index[1]] &
-						0xFFC00000) >> 22;
-				val_x = rtlphy->iqk_matrix
-						[indexforchannel].value[0][4];
-				val_y = rtlphy->iqk_matrix
-						[indexforchannel].value[0][5];
-				if (val_x != 0) {
-					if ((val_x & 0x00000200) != 0)
-						/* consider minus */
-						val_x = val_x | 0xFFFFFC00;
-					ele_a = ((val_x * ele_d) >> 8) &
-						0x000003FF;
-					/* new element C = element D x Y */
-					if ((val_y & 0x00000200) != 0)
-						val_y =
-						    val_y | 0xFFFFFC00;
-					ele_c =
-					    ((val_y *
-					      ele_d) >> 8) & 0x00003FF;
-					/* write new elements A, C, D to regC88
-					 * and regC9C, element B is always 0
-					 */
-					value32 = (ele_d << 22) |
-						  ((ele_c & 0x3F) << 16) |
-						  ele_a;
-					rtl_set_bbreg(hw,
-						      ROFDM0_XBTXIQIMBALANCE,
-						      MASKDWORD, value32);
-					value32 = (ele_c & 0x000003C0) >> 6;
-					rtl_set_bbreg(hw, ROFDM0_XDTXAFE,
-						      MASKH4BITS, value32);
-					value32 = ((val_x * ele_d) >> 7) & 0x01;
-					rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD,
-						      BIT(28), value32);
-				} else {
-					rtl_set_bbreg(hw,
-						      ROFDM0_XBTXIQIMBALANCE,
-						      MASKDWORD,
-						      ofdmswing_table
-						      [(u8) ofdm_index[1]]);
-					rtl_set_bbreg(hw, ROFDM0_XDTXAFE,
-						      MASKH4BITS, 0x00);
-					rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD,
-						      BIT(28), 0x00);
-				}
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "TxPwrTracking path B: X = 0x%lx, Y = 0x%lx ele_A = 0x%lx ele_C = 0x%lx ele_D = 0x%lx 0xeb4 = 0x%lx 0xebc = 0x%lx\n",
-					 val_x, val_y, ele_a, ele_c,
-					 ele_d, val_x, val_y);
-			}
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "TxPwrTracking 0xc80 = 0x%x, 0xc94 = 0x%x RF 0x24 = 0x%x\n",
-				 rtl_get_bbreg(hw, 0xc80, MASKDWORD),
-				 rtl_get_bbreg(hw, 0xc94, MASKDWORD),
-				 rtl_get_rfreg(hw, RF90_PATH_A, 0x24,
-					       RFREG_OFFSET_MASK));
-		}
-		if ((delta_iqk > rtlefuse->delta_iqk) &&
-		    (rtlefuse->delta_iqk != 0)) {
-			rtl92d_phy_reset_iqk_result(hw);
-			rtlpriv->dm.thermalvalue_iqk = thermalvalue;
-			rtl92d_phy_iq_calibrate(hw);
+	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		 "TxPwrTracking for interface %d path A: X = 0x%lx, Y = 0x%lx ele_A = 0x%lx ele_C = 0x%lx ele_D = 0x%lx 0xe94 = 0x%lx 0xe9c = 0x%lx\n",
+		 rtlhal->interfaceindex,
+		 val_x, val_y, ele_a, ele_c, ele_d,
+		 val_x, val_y);
+
+	if (cck_index >= CCK_TABLE_SIZE)
+		cck_index = CCK_TABLE_SIZE - 1;
+	if (cck_index < 0)
+		cck_index = 0;
+	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+		/* Adjust CCK according to IQK result */
+		if (!rtlpriv->dm.cck_inch14) {
+			rtl_write_byte(rtlpriv, 0xa22,
+				       cckswing_table_ch1ch13[cck_index][0]);
+			rtl_write_byte(rtlpriv, 0xa23,
+				       cckswing_table_ch1ch13[cck_index][1]);
+			rtl_write_byte(rtlpriv, 0xa24,
+				       cckswing_table_ch1ch13[cck_index][2]);
+			rtl_write_byte(rtlpriv, 0xa25,
+				       cckswing_table_ch1ch13[cck_index][3]);
+			rtl_write_byte(rtlpriv, 0xa26,
+				       cckswing_table_ch1ch13[cck_index][4]);
+			rtl_write_byte(rtlpriv, 0xa27,
+				       cckswing_table_ch1ch13[cck_index][5]);
+			rtl_write_byte(rtlpriv, 0xa28,
+				       cckswing_table_ch1ch13[cck_index][6]);
+			rtl_write_byte(rtlpriv, 0xa29,
+				       cckswing_table_ch1ch13[cck_index][7]);
+		} else {
+			rtl_write_byte(rtlpriv, 0xa22,
+				       cckswing_table_ch14[cck_index][0]);
+			rtl_write_byte(rtlpriv, 0xa23,
+				       cckswing_table_ch14[cck_index][1]);
+			rtl_write_byte(rtlpriv, 0xa24,
+				       cckswing_table_ch14[cck_index][2]);
+			rtl_write_byte(rtlpriv, 0xa25,
+				       cckswing_table_ch14[cck_index][3]);
+			rtl_write_byte(rtlpriv, 0xa26,
+				       cckswing_table_ch14[cck_index][4]);
+			rtl_write_byte(rtlpriv, 0xa27,
+				       cckswing_table_ch14[cck_index][5]);
+			rtl_write_byte(rtlpriv, 0xa28,
+				       cckswing_table_ch14[cck_index][6]);
+			rtl_write_byte(rtlpriv, 0xa29,
+				       cckswing_table_ch14[cck_index][7]);
 		}
-		if (delta_rxgain > 0 && rtlhal->current_bandtype == BAND_ON_5G
-		    && thermalvalue <= rtlefuse->eeprom_thermalmeter) {
-			rtlpriv->dm.thermalvalue_rxgain = thermalvalue;
-			rtl92d_dm_rxgain_tracking_thermalmeter(hw);
+	}
+	if (is2t) {
+		ele_d = (ofdmswing_table[ofdm_index[1]] & 0xFFC00000) >> 22;
+		val_x = rtlphy->iqk_matrix[indexforchannel].value[0][4];
+		val_y = rtlphy->iqk_matrix[indexforchannel].value[0][5];
+		if (val_x != 0) {
+			if ((val_x & 0x00000200) != 0)
+				/* consider minus */
+				val_x = val_x | 0xFFFFFC00;
+			ele_a = ((val_x * ele_d) >> 8) & 0x000003FF;
+			/* new element C = element D x Y */
+			if ((val_y & 0x00000200) != 0)
+				val_y = val_y | 0xFFFFFC00;
+			ele_c = ((val_y * ele_d) >> 8) & 0x00003FF;
+			/* write new elements A, C, D to regC88
+			 * and regC9C, element B is always 0
+			 */
+			value32 = (ele_d << 22) | ((ele_c & 0x3F) << 16) | ele_a;
+			rtl_set_bbreg(hw,
+				      ROFDM0_XBTXIQIMBALANCE,
+				      MASKDWORD, value32);
+			value32 = (ele_c & 0x000003C0) >> 6;
+			rtl_set_bbreg(hw, ROFDM0_XDTXAFE,
+				      MASKH4BITS, value32);
+			value32 = ((val_x * ele_d) >> 7) & 0x01;
+			rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD,
+				      BIT(28), value32);
+		} else {
+			rtl_set_bbreg(hw,
+				      ROFDM0_XBTXIQIMBALANCE,
+				      MASKDWORD,
+				      ofdmswing_table[ofdm_index[1]]);
+			rtl_set_bbreg(hw, ROFDM0_XDTXAFE,
+				      MASKH4BITS, 0x00);
+			rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD,
+				      BIT(28), 0x00);
 		}
-		if (rtlpriv->dm.txpower_track_control)
-			rtlpriv->dm.thermalvalue = thermalvalue;
+		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			 "TxPwrTracking path B: X = 0x%lx, Y = 0x%lx ele_A = 0x%lx ele_C = 0x%lx ele_D = 0x%lx 0xeb4 = 0x%lx 0xebc = 0x%lx\n",
+			 val_x, val_y, ele_a, ele_c,
+			 ele_d, val_x, val_y);
+	}
+	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		 "TxPwrTracking 0xc80 = 0x%x, 0xc94 = 0x%x RF 0x24 = 0x%x\n",
+		 rtl_get_bbreg(hw, 0xc80, MASKDWORD),
+		 rtl_get_bbreg(hw, 0xc94, MASKDWORD),
+		 rtl_get_rfreg(hw, RF90_PATH_A, 0x24,
+			       RFREG_OFFSET_MASK));
+
+check_delta:
+	if (delta_iqk > rtlefuse->delta_iqk && rtlefuse->delta_iqk != 0) {
+		rtl92d_phy_reset_iqk_result(hw);
+		rtlpriv->dm.thermalvalue_iqk = thermalvalue;
+		rtl92d_phy_iq_calibrate(hw);
 	}
+	if (delta_rxgain > 0 && rtlhal->current_bandtype == BAND_ON_5G &&
+	    thermalvalue <= rtlefuse->eeprom_thermalmeter) {
+		rtlpriv->dm.thermalvalue_rxgain = thermalvalue;
+		rtl92d_dm_rxgain_tracking_thermalmeter(hw);
+	}
+	if (rtlpriv->dm.txpower_track_control)
+		rtlpriv->dm.thermalvalue = thermalvalue;
 
+exit:
 	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "<===\n");
 }
 
-- 
2.21.0

