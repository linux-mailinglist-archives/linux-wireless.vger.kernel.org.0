Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 613B8CF4E8
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 10:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfJHIVP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 04:21:15 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47337 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbfJHIVN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 04:21:13 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x988L5R3028129, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x988L5R3028129
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 8 Oct 2019 16:21:06 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 8 Oct 2019 16:21:05 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 02/10] rtw88: Enable 802.11ac beamformee support
Date:   Tue, 8 Oct 2019 16:20:53 +0800
Message-ID: <20191008082101.2494-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008082101.2494-1-yhchuang@realtek.com>
References: <20191008082101.2494-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

Enable MU-MIMO transmit beamformee support for chipset 8822b and 8822c.

If the rtw88 is in station mode and associated with an AP, and the
capabilities of both meet the requirement of beamforming, driver will
run as a beamformee and the corresponding chip settings will be set.

In addition, module parameter support_bf is added to enable or disable
beamforming.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/Makefile   |   1 +
 drivers/net/wireless/realtek/rtw88/bf.c       | 408 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/bf.h       |  92 ++++
 drivers/net/wireless/realtek/rtw88/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw88/mac80211.c |  11 +
 drivers/net/wireless/realtek/rtw88/main.c     |  38 ++
 drivers/net/wireless/realtek/rtw88/main.h     |  43 ++
 drivers/net/wireless/realtek/rtw88/reg.h      |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  46 ++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  59 +++
 10 files changed, 700 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/bf.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/bf.h

diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index 77edee2df8b8..15e12155a04c 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -14,6 +14,7 @@ rtw88-y += main.o \
 	   fw.o \
 	   ps.o \
 	   sec.o \
+	   bf.o \
 	   regd.o
 
 rtw88-$(CONFIG_RTW88_8822BE)	+= rtw8822b.o rtw8822b_table.o
diff --git a/drivers/net/wireless/realtek/rtw88/bf.c b/drivers/net/wireless/realtek/rtw88/bf.c
new file mode 100644
index 000000000000..8c925e493642
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/bf.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2018-2019  Realtek Corporation.
+ */
+
+#include "main.h"
+#include "reg.h"
+#include "bf.h"
+#include "debug.h"
+
+void rtw_bf_disassoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
+		     struct ieee80211_bss_conf *bss_conf)
+{
+	struct ieee80211_hw *hw = rtwdev->hw;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
+	struct rtw_bfee *bfee = &rtwvif->bfee;
+	struct rtw_bf_info *bfinfo = &rtwdev->bf_info;
+	struct ieee80211_sta_vht_cap ic_vht_cap;
+
+	if (bfee->role == RTW_BFEE_NONE)
+		return;
+
+	ic_vht_cap = hw->wiphy->bands[NL80211_BAND_5GHZ]->vht_cap;
+
+	if (bfee->role == RTW_BFEE_MU)
+		bfinfo->bfer_mu_cnt--;
+	else if (bfee->role == RTW_BFEE_SU)
+		bfinfo->bfer_su_cnt--;
+	chip->ops->config_bfee(rtwdev, rtwvif, bfee, false);
+	bfee->role = RTW_BFEE_NONE;
+}
+
+void rtw_bf_assoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
+		  struct ieee80211_bss_conf *bss_conf)
+{
+	struct ieee80211_hw *hw = rtwdev->hw;
+	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
+	struct rtw_bfee *bfee = &rtwvif->bfee;
+	struct rtw_bf_info *bfinfo = &rtwdev->bf_info;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct ieee80211_sta *sta;
+	struct ieee80211_sta_vht_cap vht_cap;
+	struct ieee80211_sta_vht_cap ic_vht_cap;
+	u32 sound_dim;
+	u8 *bssid, i;
+
+	if (chip->band & RTW_BAND_5G) {
+		ic_vht_cap = hw->wiphy->bands[NL80211_BAND_5GHZ]->vht_cap;
+		if (!(ic_vht_cap.cap &
+		      (IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
+		       IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE)))
+			goto exit;
+	} else {
+		goto exit;
+	}
+
+	bssid = (u8 *)bss_conf->bssid;
+
+	rcu_read_lock();
+
+	sta = ieee80211_find_sta(vif, bssid);
+	if (!sta) {
+		rtw_warn(rtwdev, "failed to find station entry for bss %pM\n",
+			 bssid);
+		rcu_read_unlock();
+		goto exit;
+	}
+
+	vht_cap = sta->vht_cap;
+
+	rcu_read_unlock();
+
+	if ((ic_vht_cap.cap & IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE) &&
+	    (vht_cap.cap & IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE)) {
+		if (bfinfo->bfer_mu_cnt >= chip->bfer_mu_max_num) {
+			rtw_dbg(rtwdev, RTW_DBG_BF, "mu bfer number over limit\n");
+			goto exit;
+		}
+		bfee->role = RTW_BFEE_MU;
+		bfinfo->bfer_mu_cnt++;
+		ether_addr_copy(bfee->mac_addr, bssid);
+		bfee->p_aid = (bssid[5] << 1) | (bssid[4] >> 7);
+		bfee->aid = bss_conf->aid;
+		chip->ops->config_bfee(rtwdev, rtwvif, bfee, true);
+		return;
+	}
+	if ((ic_vht_cap.cap & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE) &&
+	    (vht_cap.cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE)) {
+		if (bfinfo->bfer_su_cnt >= chip->bfer_su_max_num) {
+			rtw_dbg(rtwdev, RTW_DBG_BF, "su bfer number over limit\n");
+			goto exit;
+		}
+		bfee->role = RTW_BFEE_SU;
+		bfinfo->bfer_su_cnt++;
+		ether_addr_copy(bfee->mac_addr, bssid);
+		bfee->g_id = 0;
+		bfee->p_aid = (bssid[5] << 1) | (bssid[4] >> 7);
+		sound_dim = vht_cap.cap &
+			    IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK;
+		sound_dim >>= IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT;
+		bfee->sound_dim = (u8)sound_dim;
+		for (i = 0; i < chip->bfer_su_max_num; i++) {
+			if (!test_bit(i, bfinfo->bfer_su_reg_maping)) {
+				set_bit(i, bfinfo->bfer_su_reg_maping);
+				bfee->su_reg_index = i;
+				break;
+			}
+		}
+		chip->ops->config_bfee(rtwdev, rtwvif, bfee, true);
+		return;
+	}
+
+exit:
+	bfee->role = RTW_BFEE_NONE;
+}
+
+void rtw_bf_init_bfer_entry_mu(struct rtw_dev *rtwdev,
+			       struct mu_bfer_init_para *param)
+{
+	u16 mu_bf_ctl = 0;
+	u8 *addr = param->bfer_address;
+	int i;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		rtw_write8(rtwdev, REG_ASSOCIATED_BFMER0_INFO + i, addr[i]);
+	rtw_write16(rtwdev, REG_ASSOCIATED_BFMER0_INFO + 6, param->paid);
+	rtw_write16(rtwdev, REG_TX_CSI_RPT_PARAM_BW20, param->csi_para);
+
+	mu_bf_ctl = rtw_read16(rtwdev, REG_WMAC_MU_BF_CTL) & 0xC000;
+	mu_bf_ctl |= param->my_aid | (param->csi_length_sel << 12);
+	rtw_write16(rtwdev, REG_WMAC_MU_BF_CTL, mu_bf_ctl);
+}
+
+void rtw_bf_cfg_sounding(struct rtw_dev *rtwdev, struct rtw_vif *vif,
+			 enum rtw_trx_desc_rate rate)
+{
+	u32 psf_ctl = 0;
+	u8 csi_rsc = 0x1;
+
+	psf_ctl = rtw_read32(rtwdev, REG_BBPSF_CTRL) |
+		  BIT_WMAC_USE_NDPARATE |
+		  (csi_rsc << 13);
+
+	rtw_write8(rtwdev, REG_SND_PTCL_CTRL, RTW_SND_CTRL_SOUNDING);
+	rtw_write8(rtwdev, REG_SND_PTCL_CTRL + 3, 0x26);
+	rtw_write8_clr(rtwdev, REG_RXFLTMAP1, BIT_RXFLTMAP1_BF_REPORT_POLL);
+	rtw_write8_clr(rtwdev, REG_RXFLTMAP4, BIT_RXFLTMAP4_BF_REPORT_POLL);
+
+	if (vif->net_type == RTW_NET_AP_MODE)
+		rtw_write32(rtwdev, REG_BBPSF_CTRL, psf_ctl | BIT(12));
+	else
+		rtw_write32(rtwdev, REG_BBPSF_CTRL, psf_ctl & ~BIT(12));
+}
+
+void rtw_bf_cfg_mu_bfee(struct rtw_dev *rtwdev, struct cfg_mumimo_para *param)
+{
+	u8 mu_tbl_sel;
+	u8 mu_valid;
+
+	mu_valid = rtw_read8(rtwdev, REG_MU_TX_CTL) &
+		   ~BIT_MASK_R_MU_TABLE_VALID;
+
+	rtw_write8(rtwdev, REG_MU_TX_CTL,
+		   (mu_valid | BIT(0) | BIT(1)) & ~(BIT(7)));
+
+	mu_tbl_sel = rtw_read8(rtwdev, REG_MU_TX_CTL + 1) & 0xF8;
+
+	rtw_write8(rtwdev, REG_MU_TX_CTL + 1, mu_tbl_sel);
+	rtw_write32(rtwdev, REG_MU_STA_GID_VLD, param->given_gid_tab[0]);
+	rtw_write32(rtwdev, REG_MU_STA_USER_POS_INFO, param->given_user_pos[0]);
+	rtw_write32(rtwdev, REG_MU_STA_USER_POS_INFO + 4,
+		    param->given_user_pos[1]);
+
+	rtw_write8(rtwdev, REG_MU_TX_CTL + 1, mu_tbl_sel | 1);
+	rtw_write32(rtwdev, REG_MU_STA_GID_VLD, param->given_gid_tab[1]);
+	rtw_write32(rtwdev, REG_MU_STA_USER_POS_INFO, param->given_user_pos[2]);
+	rtw_write32(rtwdev, REG_MU_STA_USER_POS_INFO + 4,
+		    param->given_user_pos[3]);
+}
+
+void rtw_bf_del_bfer_entry_mu(struct rtw_dev *rtwdev)
+{
+	rtw_write32(rtwdev, REG_ASSOCIATED_BFMER0_INFO, 0);
+	rtw_write32(rtwdev, REG_ASSOCIATED_BFMER0_INFO + 4, 0);
+	rtw_write16(rtwdev, REG_WMAC_MU_BF_CTL, 0);
+	rtw_write8(rtwdev, REG_MU_TX_CTL, 0);
+}
+
+void rtw_bf_del_sounding(struct rtw_dev *rtwdev)
+{
+	rtw_write8(rtwdev, REG_SND_PTCL_CTRL, 0);
+}
+
+void rtw_bf_enable_bfee_su(struct rtw_dev *rtwdev, struct rtw_vif *vif,
+			   struct rtw_bfee *bfee)
+{
+	u8 nc_index = 1;
+	u8 nr_index = bfee->sound_dim;
+	u8 grouping = 0, codebookinfo = 1, coefficientsize = 3;
+	u32 addr_bfer_info, addr_csi_rpt, csi_param;
+	u8 i;
+
+	rtw_dbg(rtwdev, RTW_DBG_BF, "config as an su bfee\n");
+
+	switch (bfee->su_reg_index) {
+	case 1:
+		addr_bfer_info = REG_ASSOCIATED_BFMER1_INFO;
+		addr_csi_rpt = REG_TX_CSI_RPT_PARAM_BW20 + 2;
+		break;
+	case 0:
+	default:
+		addr_bfer_info = REG_ASSOCIATED_BFMER0_INFO;
+		addr_csi_rpt = REG_TX_CSI_RPT_PARAM_BW20;
+		break;
+	}
+
+	/* Sounding protocol control */
+	rtw_write8(rtwdev, REG_SND_PTCL_CTRL, RTW_SND_CTRL_SOUNDING);
+
+	/* MAC address/Partial AID of Beamformer */
+	for (i = 0; i < ETH_ALEN; i++)
+		rtw_write8(rtwdev, addr_bfer_info + i, bfee->mac_addr[i]);
+
+	csi_param = (u16)((coefficientsize << 10) |
+			  (codebookinfo << 8) |
+			  (grouping << 6) |
+			  (nr_index << 3) |
+			  nc_index);
+	rtw_write16(rtwdev, addr_csi_rpt, csi_param);
+
+	/* ndp rx standby timer */
+	rtw_write8(rtwdev, REG_SND_PTCL_CTRL + 3, RTW_NDP_RX_STANDBY_TIME);
+}
+
+/* nc index: 1 2T2R 0 1T1R
+ * nr index: 1 use Nsts 0 use reg setting
+ * codebookinfo: 1 802.11ac 3 802.11n
+ */
+void rtw_bf_enable_bfee_mu(struct rtw_dev *rtwdev, struct rtw_vif *vif,
+			   struct rtw_bfee *bfee)
+{
+	struct rtw_bf_info *bf_info = &rtwdev->bf_info;
+	struct mu_bfer_init_para param;
+	u8 nc_index = 1, nr_index = 1;
+	u8 grouping = 0, codebookinfo = 1, coefficientsize = 0;
+	u32 csi_param;
+
+	rtw_dbg(rtwdev, RTW_DBG_BF, "config as an mu bfee\n");
+
+	csi_param = (u16)((coefficientsize << 10) |
+			  (codebookinfo << 8) |
+			  (grouping << 6) |
+			  (nr_index << 3) |
+			  nc_index);
+
+	rtw_dbg(rtwdev, RTW_DBG_BF, "nc=%d nr=%d group=%d codebookinfo=%d coefficientsize=%d\n",
+		nc_index, nr_index, grouping, codebookinfo,
+		coefficientsize);
+
+	param.paid = bfee->p_aid;
+	param.csi_para = csi_param;
+	param.my_aid = bfee->aid & 0xfff;
+	param.csi_length_sel = HAL_CSI_SEG_4K;
+	ether_addr_copy(param.bfer_address, bfee->mac_addr);
+
+	rtw_bf_init_bfer_entry_mu(rtwdev, &param);
+
+	bf_info->cur_csi_rpt_rate = DESC_RATE6M;
+	rtw_bf_cfg_sounding(rtwdev, vif, DESC_RATE6M);
+
+	/* accept action_no_ack */
+	rtw_write16_set(rtwdev, REG_RXFLTMAP0, BIT_RXFLTMAP0_ACTIONNOACK);
+
+	/* accept NDPA and BF report poll */
+	rtw_write16_set(rtwdev, REG_RXFLTMAP1, BIT_RXFLTMAP1_BF);
+}
+
+void rtw_bf_remove_bfee_su(struct rtw_dev *rtwdev,
+			   struct rtw_bfee *bfee)
+{
+	struct rtw_bf_info *bfinfo = &rtwdev->bf_info;
+
+	rtw_dbg(rtwdev, RTW_DBG_BF, "remove as a su bfee\n");
+	rtw_write8(rtwdev, REG_SND_PTCL_CTRL, RTW_SND_CTRL_REMOVE);
+
+	switch (bfee->su_reg_index) {
+	case 0:
+		rtw_write32(rtwdev, REG_ASSOCIATED_BFMER0_INFO, 0);
+		rtw_write16(rtwdev, REG_ASSOCIATED_BFMER0_INFO + 4, 0);
+		rtw_write16(rtwdev, REG_TX_CSI_RPT_PARAM_BW20, 0);
+		break;
+	case 1:
+		rtw_write32(rtwdev, REG_ASSOCIATED_BFMER1_INFO, 0);
+		rtw_write16(rtwdev, REG_ASSOCIATED_BFMER1_INFO + 4, 0);
+		rtw_write16(rtwdev, REG_TX_CSI_RPT_PARAM_BW20 + 2, 0);
+		break;
+	}
+
+	clear_bit(bfee->su_reg_index, bfinfo->bfer_su_reg_maping);
+	bfee->su_reg_index = 0xFF;
+}
+
+void rtw_bf_remove_bfee_mu(struct rtw_dev *rtwdev,
+			   struct rtw_bfee *bfee)
+{
+	struct rtw_bf_info *bfinfo = &rtwdev->bf_info;
+
+	rtw_write8(rtwdev, REG_SND_PTCL_CTRL, RTW_SND_CTRL_REMOVE);
+
+	rtw_bf_del_bfer_entry_mu(rtwdev);
+
+	if (bfinfo->bfer_su_cnt == 0 && bfinfo->bfer_mu_cnt == 0)
+		rtw_bf_del_sounding(rtwdev);
+}
+
+void rtw_bf_set_gid_table(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *conf)
+{
+	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
+	struct rtw_bfee *bfee = &rtwvif->bfee;
+	struct cfg_mumimo_para param;
+
+	if (bfee->role != RTW_BFEE_MU) {
+		rtw_dbg(rtwdev, RTW_DBG_BF, "this vif is not mu bfee\n");
+		return;
+	}
+
+	param.grouping_bitmap = 0;
+	param.mu_tx_en = 0;
+	memset(param.sounding_sts, 0, 6);
+	memcpy(param.given_gid_tab, conf->mu_group.membership, 8);
+	memcpy(param.given_user_pos, conf->mu_group.position, 16);
+	rtw_dbg(rtwdev, RTW_DBG_BF, "STA0: gid_valid=0x%x, user_position_l=0x%x, user_position_h=0x%x\n",
+		param.given_gid_tab[0], param.given_user_pos[0],
+		param.given_user_pos[1]);
+
+	rtw_dbg(rtwdev, RTW_DBG_BF, "STA1: gid_valid=0x%x, user_position_l=0x%x, user_position_h=0x%x\n",
+		param.given_gid_tab[1], param.given_user_pos[2],
+		param.given_user_pos[3]);
+
+	rtw_bf_cfg_mu_bfee(rtwdev, &param);
+}
+
+void rtw_bf_phy_init(struct rtw_dev *rtwdev)
+{
+	u8 tmp8;
+	u32 tmp32;
+	u8 retry_limit = 0xA;
+	u8 ndpa_rate = 0x10;
+	u8 ack_policy = 3;
+
+	tmp32 = rtw_read32(rtwdev, REG_MU_TX_CTL);
+	/* Enable P1 aggr new packet according to P0 transfer time */
+	tmp32 |= BIT_MU_P1_WAIT_STATE_EN;
+	/* MU Retry Limit */
+	tmp32 &= ~BIT_MASK_R_MU_RL;
+	tmp32 |= (retry_limit << BIT_SHIFT_R_MU_RL) & BIT_MASK_R_MU_RL;
+	/* Disable Tx MU-MIMO until sounding done */
+	tmp32 &= ~BIT_EN_MU_MIMO;
+	/* Clear validity of MU STAs */
+	tmp32 &= ~BIT_MASK_R_MU_TABLE_VALID;
+	rtw_write32(rtwdev, REG_MU_TX_CTL, tmp32);
+
+	/* MU-MIMO Option as default value */
+	tmp8 = ack_policy << BIT_SHIFT_WMAC_TXMU_ACKPOLICY;
+	tmp8 |= BIT_WMAC_TXMU_ACKPOLICY_EN;
+	rtw_write8(rtwdev, REG_WMAC_MU_BF_OPTION, tmp8);
+
+	/* MU-MIMO Control as default value */
+	rtw_write16(rtwdev, REG_WMAC_MU_BF_CTL, 0);
+	/* Set MU NDPA rate & BW source */
+	rtw_write32_set(rtwdev, REG_TXBF_CTRL, BIT_USE_NDPA_PARAMETER);
+	/* Set NDPA Rate */
+	rtw_write8(rtwdev, REG_NDPA_OPT_CTRL, ndpa_rate);
+
+	rtw_write32_mask(rtwdev, REG_BBPSF_CTRL, BIT_MASK_CSI_RATE,
+			 DESC_RATE6M);
+}
+
+void rtw_bf_cfg_csi_rate(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
+			 u8 fixrate_en, u8 *new_rate)
+{
+	u32 csi_cfg;
+	u16 cur_rrsr;
+
+	csi_cfg = rtw_read32(rtwdev, REG_BBPSF_CTRL) & ~BIT_MASK_CSI_RATE;
+	cur_rrsr = rtw_read16(rtwdev, REG_RRSR);
+
+	if (rssi >= 40) {
+		if (cur_rate != DESC_RATE54M) {
+			cur_rrsr |= BIT(DESC_RATE54M);
+			csi_cfg |= (DESC_RATE54M & BIT_MASK_CSI_RATE_VAL) <<
+				   BIT_SHIFT_CSI_RATE;
+			rtw_write16(rtwdev, REG_RRSR, cur_rrsr);
+			rtw_write32(rtwdev, REG_BBPSF_CTRL, csi_cfg);
+		}
+		*new_rate = DESC_RATE54M;
+	} else {
+		if (cur_rate != DESC_RATE24M) {
+			cur_rrsr &= ~BIT(DESC_RATE54M);
+			csi_cfg |= (DESC_RATE54M & BIT_MASK_CSI_RATE_VAL) <<
+				   BIT_SHIFT_CSI_RATE;
+			rtw_write16(rtwdev, REG_RRSR, cur_rrsr);
+			rtw_write32(rtwdev, REG_BBPSF_CTRL, csi_cfg);
+		}
+		*new_rate = DESC_RATE24M;
+	}
+}
diff --git a/drivers/net/wireless/realtek/rtw88/bf.h b/drivers/net/wireless/realtek/rtw88/bf.h
new file mode 100644
index 000000000000..96a8216dd11f
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/bf.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2018-2019  Realtek Corporation.
+ */
+
+#ifndef __RTW_BF_H_
+#define __RTW_BF_H_
+
+#define REG_TXBF_CTRL		0x042C
+#define REG_RRSR		0x0440
+#define REG_NDPA_OPT_CTRL	0x045F
+
+#define REG_ASSOCIATED_BFMER0_INFO	0x06E4
+#define REG_ASSOCIATED_BFMER1_INFO	0x06EC
+#define REG_TX_CSI_RPT_PARAM_BW20	0x06F4
+#define REG_SND_PTCL_CTRL		0x0718
+#define REG_MU_TX_CTL			0x14C0
+#define REG_MU_STA_GID_VLD		0x14C4
+#define REG_MU_STA_USER_POS_INFO	0x14C8
+#define REG_CSI_RRSR			0x1678
+#define REG_WMAC_MU_BF_OPTION		0x167C
+#define REG_WMAC_MU_BF_CTL		0x1680
+
+#define BIT_WMAC_USE_NDPARATE			BIT(30)
+#define BIT_WMAC_TXMU_ACKPOLICY_EN		BIT(6)
+#define BIT_USE_NDPA_PARAMETER			BIT(30)
+#define BIT_MU_P1_WAIT_STATE_EN			BIT(16)
+#define BIT_EN_MU_MIMO				BIT(7)
+
+#define R_MU_RL				0xf
+#define BIT_SHIFT_R_MU_RL		12
+#define BIT_SHIFT_WMAC_TXMU_ACKPOLICY	4
+#define BIT_SHIFT_CSI_RATE		24
+
+#define BIT_MASK_R_MU_RL (R_MU_RL << BIT_SHIFT_R_MU_RL)
+#define BIT_MASK_R_MU_TABLE_VALID	0x3f
+#define BIT_MASK_CSI_RATE_VAL		0x3F
+#define BIT_MASK_CSI_RATE (BIT_MASK_CSI_RATE_VAL << BIT_SHIFT_CSI_RATE)
+
+#define BIT_RXFLTMAP0_ACTIONNOACK	BIT(14)
+#define BIT_RXFLTMAP1_BF		(BIT(4) | BIT(5))
+#define BIT_RXFLTMAP1_BF_REPORT_POLL	BIT(4)
+#define BIT_RXFLTMAP4_BF_REPORT_POLL	BIT(4)
+
+#define RTW_NDP_RX_STANDBY_TIME	0x70
+#define RTW_SND_CTRL_REMOVE	0xD8
+#define RTW_SND_CTRL_SOUNDING	0xDB
+
+enum csi_seg_len {
+	HAL_CSI_SEG_4K = 0,
+	HAL_CSI_SEG_8K = 1,
+	HAL_CSI_SEG_11K = 2,
+};
+
+struct cfg_mumimo_para {
+	u8 sounding_sts[6];
+	u16 grouping_bitmap;
+	u8 mu_tx_en;
+	u32 given_gid_tab[2];
+	u32 given_user_pos[4];
+};
+
+struct mu_bfer_init_para {
+	u16 paid;
+	u16 csi_para;
+	u16 my_aid;
+	enum csi_seg_len csi_length_sel;
+	u8 bfer_address[ETH_ALEN];
+};
+
+void rtw_bf_disassoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
+		     struct ieee80211_bss_conf *bss_conf);
+void rtw_bf_assoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
+		  struct ieee80211_bss_conf *bss_conf);
+void rtw_bf_init_bfer_entry_mu(struct rtw_dev *rtwdev,
+			       struct mu_bfer_init_para *param);
+void rtw_bf_cfg_sounding(struct rtw_dev *rtwdev, struct rtw_vif *vif,
+			 enum rtw_trx_desc_rate rate);
+void rtw_bf_cfg_mu_bfee(struct rtw_dev *rtwdev, struct cfg_mumimo_para *param);
+void rtw_bf_del_bfer_entry_mu(struct rtw_dev *rtwdev);
+void rtw_bf_del_sounding(struct rtw_dev *rtwdev);
+void rtw_bf_enable_bfee_su(struct rtw_dev *rtwdev, struct rtw_vif *vif,
+			   struct rtw_bfee *bfee);
+void rtw_bf_enable_bfee_mu(struct rtw_dev *rtwdev, struct rtw_vif *vif,
+			   struct rtw_bfee *bfee);
+void rtw_bf_remove_bfee_su(struct rtw_dev *rtwdev, struct rtw_bfee *bfee);
+void rtw_bf_remove_bfee_mu(struct rtw_dev *rtwdev, struct rtw_bfee *bfee);
+void rtw_bf_set_gid_table(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *conf);
+void rtw_bf_phy_init(struct rtw_dev *rtwdev);
+void rtw_bf_cfg_csi_rate(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
+			 u8 fixrate_en, u8 *new_rate);
+#endif
diff --git a/drivers/net/wireless/realtek/rtw88/debug.h b/drivers/net/wireless/realtek/rtw88/debug.h
index 9449105f4259..cd28f675e9cb 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.h
+++ b/drivers/net/wireless/realtek/rtw88/debug.h
@@ -17,6 +17,7 @@ enum rtw_debug_mask {
 	RTW_DBG_REGD		= 0x00000100,
 	RTW_DBG_DEBUGFS		= 0x00000200,
 	RTW_DBG_PS		= 0x00000400,
+	RTW_DBG_BF		= 0x00000800,
 
 	RTW_DBG_ALL		= 0xffffffff
 };
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index d03b0b7a0e70..5dc50ff956bf 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -10,6 +10,7 @@
 #include "coex.h"
 #include "ps.h"
 #include "reg.h"
+#include "bf.h"
 #include "debug.h"
 
 static void rtw_ops_tx(struct ieee80211_hw *hw,
@@ -157,6 +158,7 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 	rtwvif->stats.tx_cnt = 0;
 	rtwvif->stats.rx_cnt = 0;
 	rtwvif->in_lps = false;
+	memset(&rtwvif->bfee, 0, sizeof(struct rtw_bfee));
 	rtwvif->conf = &rtw_vif_port[port];
 	rtw_txq_init(rtwdev, vif->txq);
 
@@ -348,11 +350,14 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 			rtw_fw_download_rsvd_page(rtwdev, vif);
 			rtw_send_rsvd_page_h2c(rtwdev);
 			rtw_coex_media_status_notify(rtwdev, conf->assoc);
+			if (rtw_bf_support)
+				rtw_bf_assoc(rtwdev, vif, conf);
 		} else {
 			rtw_leave_lps(rtwdev);
 			net_type = RTW_NET_NO_LINK;
 			rtwvif->aid = 0;
 			rtw_reset_rsvd_page(rtwdev);
+			rtw_bf_disassoc(rtwdev, vif, conf);
 		}
 
 		rtwvif->net_type = net_type;
@@ -368,6 +373,12 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_BEACON)
 		rtw_fw_download_rsvd_page(rtwdev, vif);
 
+	if (changed & BSS_CHANGED_MU_GROUPS) {
+		struct rtw_chip_info *chip = rtwdev->chip;
+
+		chip->ops->set_gid_table(rtwdev, vif, conf);
+	}
+
 	if (changed & BSS_CHANGED_ERP_SLOT)
 		rtw_conf_tx(rtwdev, rtwvif);
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index e0cc4c11e513..683c23823513 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -14,16 +14,20 @@
 #include "efuse.h"
 #include "tx.h"
 #include "debug.h"
+#include "bf.h"
 
 unsigned int rtw_fw_lps_deep_mode;
 EXPORT_SYMBOL(rtw_fw_lps_deep_mode);
+bool rtw_bf_support = true;
 unsigned int rtw_debug_mask;
 EXPORT_SYMBOL(rtw_debug_mask);
 
 module_param_named(lps_deep_mode, rtw_fw_lps_deep_mode, uint, 0644);
+module_param_named(support_bf, rtw_bf_support, bool, 0644);
 module_param_named(debug_mask, rtw_debug_mask, uint, 0644);
 
 MODULE_PARM_DESC(lps_deep_mode, "Deeper PS mode. If 0, deep PS is disabled");
+MODULE_PARM_DESC(support_bf, "Set Y to enable beamformee support");
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 
 static struct ieee80211_channel rtw_channeltable_2g[] = {
@@ -126,9 +130,29 @@ static struct ieee80211_supported_band rtw_band_5ghz = {
 };
 
 struct rtw_watch_dog_iter_data {
+	struct rtw_dev *rtwdev;
 	struct rtw_vif *rtwvif;
 };
 
+static void rtw_dynamic_csi_rate(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif)
+{
+	struct rtw_bf_info *bf_info = &rtwdev->bf_info;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 fix_rate_enable = 0;
+	u8 new_csi_rate_idx;
+
+	if (rtwvif->bfee.role != RTW_BFEE_SU &&
+	    rtwvif->bfee.role != RTW_BFEE_MU)
+		return;
+
+	chip->ops->cfg_csi_rate(rtwdev, rtwdev->dm_info.min_rssi,
+				bf_info->cur_csi_rpt_rate,
+				fix_rate_enable, &new_csi_rate_idx);
+
+	if (new_csi_rate_idx != bf_info->cur_csi_rpt_rate)
+		bf_info->cur_csi_rpt_rate = new_csi_rate_idx;
+}
+
 static void rtw_vif_watch_dog_iter(void *data, u8 *mac,
 				   struct ieee80211_vif *vif)
 {
@@ -139,6 +163,8 @@ static void rtw_vif_watch_dog_iter(void *data, u8 *mac,
 		if (vif->bss_conf.assoc)
 			iter_data->rtwvif = rtwvif;
 
+	rtw_dynamic_csi_rate(iter_data->rtwdev, rtwvif);
+
 	rtwvif->stats.tx_unicast = 0;
 	rtwvif->stats.rx_unicast = 0;
 	rtwvif->stats.tx_cnt = 0;
@@ -192,6 +218,7 @@ static void rtw_watch_dog_work(struct work_struct *work)
 
 	rtw_phy_dynamic_mechanism(rtwdev);
 
+	data.rtwdev = rtwdev;
 	/* use atomic version to avoid taking local->iflist_mtx mutex */
 	rtw_iterate_vifs_atomic(rtwdev, rtw_vif_watch_dog_iter, &data);
 
@@ -870,6 +897,12 @@ static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
 		       IEEE80211_VHT_CAP_HTC_VHT |
 		       IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK |
 		       0;
+
+	vht_cap->cap |= IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
+			IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE;
+	vht_cap->cap |= (rtwdev->hal.bfee_sts_cap <<
+			IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT);
+
 	mcs_map = IEEE80211_VHT_MCS_SUPPORT_0_9 << 0 |
 		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 4 |
 		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 6 |
@@ -1005,6 +1038,8 @@ static int rtw_chip_parameter_setup(struct rtw_dev *rtwdev)
 	/* default use ack */
 	rtwdev->hal.rcr |= BIT_VHT_DACK;
 
+	hal->bfee_sts_cap = 3;
+
 	return ret;
 }
 
@@ -1340,6 +1375,9 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 
 	rtw_debugfs_init(rtwdev);
 
+	rtwdev->bf_info.bfer_mu_cnt = 0;
+	rtwdev->bf_info.bfer_su_cnt = 0;
+
 	return 0;
 }
 EXPORT_SYMBOL(rtw_register_hw);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 417c4200b758..2834c1eaeb91 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -28,6 +28,7 @@
 #define RTW_RF_PATH_MAX			4
 #define HW_FEATURE_LEN			13
 
+extern bool rtw_bf_support;
 extern unsigned int rtw_fw_lps_deep_mode;
 extern unsigned int rtw_debug_mask;
 extern const struct ieee80211_ops rtw_ops;
@@ -633,6 +634,34 @@ struct rtw_sta_info {
 	struct rtw_ra_report ra_report;
 };
 
+enum rtw_bfee_role {
+	RTW_BFEE_NONE,
+	RTW_BFEE_SU,
+	RTW_BFEE_MU
+};
+
+struct rtw_bfee {
+	enum rtw_bfee_role role;
+
+	u16 p_aid;
+	u8 g_id;
+	u8 mac_addr[ETH_ALEN];
+	u8 sound_dim;
+
+	/* SU-MIMO */
+	u8 su_reg_index;
+
+	/* MU-MIMO */
+	u16 aid;
+};
+
+struct rtw_bf_info {
+	u8 bfer_mu_cnt;
+	u8 bfer_su_cnt;
+	DECLARE_BITMAP(bfer_su_reg_maping, 2);
+	u8 cur_csi_rpt_rate;
+};
+
 struct rtw_vif {
 	struct ieee80211_vif *vif;
 	enum rtw_net_type net_type;
@@ -646,6 +675,8 @@ struct rtw_vif {
 
 	struct rtw_traffic_stats stats;
 	bool in_lps;
+
+	struct rtw_bfee bfee;
 };
 
 struct rtw_regulatory {
@@ -678,6 +709,13 @@ struct rtw_chip_ops {
 	void (*dpk_track)(struct rtw_dev *rtwdev);
 	void (*cck_pd_set)(struct rtw_dev *rtwdev, u8 level);
 	void (*pwrtrack_check)(struct rtw_dev *rtwdev);
+	void (*config_bfee)(struct rtw_dev *rtwdev, struct rtw_vif *vif,
+			    struct rtw_bfee *bfee, bool enable);
+	void (*set_gid_table)(struct rtw_dev *rtwdev,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *conf);
+	void (*cfg_csi_rate)(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
+			     u8 fixrate_en, u8 *new_rate);
 
 	/* for coex */
 	void (*coex_set_init)(struct rtw_dev *rtwdev);
@@ -935,6 +973,9 @@ struct rtw_chip_info {
 	u8 iqk_threshold;
 	const struct rtw_pwr_track_tbl *pwr_track_tbl;
 
+	u8 bfer_su_max_num;
+	u8 bfer_mu_max_num;
+
 	/* coex paras */
 	u32 coex_para_ver;
 	u8 bt_desired_ver;
@@ -1372,6 +1413,7 @@ struct rtw_hal {
 	u8 rf_path_num;
 	u8 antenna_tx;
 	u8 antenna_rx;
+	u8 bfee_sts_cap;
 
 	/* protect tx power section */
 	struct mutex tx_power_mutex;
@@ -1409,6 +1451,7 @@ struct rtw_dev {
 	struct rtw_sec_desc sec;
 	struct rtw_traffic_stats stats;
 	struct rtw_regulatory regd;
+	struct rtw_bf_info bf_info;
 
 	struct rtw_dm_info dm_info;
 	struct rtw_coex coex;
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index bd04c3fad1ee..a6d1260acb91 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -325,6 +325,7 @@
 #define REG_RXFLTMAP0		0x06A0
 #define REG_RXFLTMAP1		0x06A2
 #define REG_RXFLTMAP2		0x06A4
+#define REG_RXFLTMAP4		0x068A
 #define REG_BT_COEX_TABLE0	0x06C0
 #define REG_BT_COEX_TABLE1	0x06C4
 #define REG_BT_COEX_BRK_TABLE	0x06C8
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 51b7f5eb9e9d..f3ef5913ae81 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -13,6 +13,7 @@
 #include "mac.h"
 #include "reg.h"
 #include "debug.h"
+#include "bf.h"
 
 static void rtw8822b_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
 				     u8 rx_path, bool is_tx2_path);
@@ -121,6 +122,13 @@ static void rtw8822b_pwrtrack_init(struct rtw_dev *rtwdev)
 	dm_info->thermal_meter_k = rtwdev->efuse.thermal_meter_k;
 }
 
+static void rtw8822b_phy_bf_init(struct rtw_dev *rtwdev)
+{
+	rtw_bf_phy_init(rtwdev);
+	/* Grouping bitmap parameters */
+	rtw_write32(rtwdev, 0x1C94, 0xAFFFAFFF);
+}
+
 static void rtw8822b_phy_set_param(struct rtw_dev *rtwdev)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
@@ -153,6 +161,8 @@ static void rtw8822b_phy_set_param(struct rtw_dev *rtwdev)
 
 	rtw8822b_phy_rfe_init(rtwdev);
 	rtw8822b_pwrtrack_init(rtwdev);
+
+	rtw8822b_phy_bf_init(rtwdev);
 }
 
 #define WLAN_SLOT_TIME		0x09
@@ -1452,6 +1462,37 @@ void rtw8822b_pwrtrack_check(struct rtw_dev *rtwdev)
 	dm_info->pwrtrack_trigger = false;
 }
 
+static void rtw8822b_bf_config_bfee_su(struct rtw_dev *rtwdev,
+				       struct rtw_vif *vif,
+				       struct rtw_bfee *bfee, bool enable)
+{
+	if (enable)
+		rtw_bf_enable_bfee_su(rtwdev, vif, bfee);
+	else
+		rtw_bf_remove_bfee_su(rtwdev, bfee);
+}
+
+static void rtw8822b_bf_config_bfee_mu(struct rtw_dev *rtwdev,
+				       struct rtw_vif *vif,
+				       struct rtw_bfee *bfee, bool enable)
+{
+	if (enable)
+		rtw_bf_enable_bfee_mu(rtwdev, vif, bfee);
+	else
+		rtw_bf_remove_bfee_mu(rtwdev, bfee);
+}
+
+static void rtw8822b_bf_config_bfee(struct rtw_dev *rtwdev, struct rtw_vif *vif,
+				    struct rtw_bfee *bfee, bool enable)
+{
+	if (bfee->role == RTW_BFEE_SU)
+		rtw8822b_bf_config_bfee_su(rtwdev, vif, bfee, enable);
+	else if (bfee->role == RTW_BFEE_MU)
+		rtw8822b_bf_config_bfee_mu(rtwdev, vif, bfee, enable);
+	else
+		rtw_warn(rtwdev, "wrong bfee role\n");
+}
+
 static struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822b[] = {
 	{0x0086,
 	 RTW_PWR_CUT_ALL_MSK,
@@ -1999,6 +2040,9 @@ static struct rtw_chip_ops rtw8822b_ops = {
 	.false_alarm_statistics	= rtw8822b_false_alarm_statistics,
 	.phy_calibration	= rtw8822b_phy_calibration,
 	.pwrtrack_check		= rtw8822b_pwrtrack_check,
+	.config_bfee		= rtw8822b_bf_config_bfee,
+	.set_gid_table		= rtw_bf_set_gid_table,
+	.cfg_csi_rate		= rtw_bf_cfg_csi_rate,
 
 	.coex_set_init		= rtw8822b_coex_cfg_init,
 	.coex_set_ant_switch	= rtw8822b_coex_cfg_ant_switch,
@@ -2316,6 +2360,8 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 	.rfe_defs_size = ARRAY_SIZE(rtw8822b_rfe_defs),
 	.pwr_track_tbl = &rtw8822b_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
+	.bfer_su_max_num = 2,
+	.bfer_mu_max_num = 1,
 
 	.coex_para_ver = 0x19062706,
 	.bt_desired_ver = 0x6,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index ddf16ff4bb35..434b7d726ee5 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -14,6 +14,7 @@
 #include "reg.h"
 #include "debug.h"
 #include "util.h"
+#include "bf.h"
 
 static void rtw8822c_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
 				     u8 rx_path, bool is_tx2_path);
@@ -1068,6 +1069,8 @@ static void rtw8822c_phy_set_param(struct rtw_dev *rtwdev)
 
 	rtw8822c_rf_init(rtwdev);
 	rtw8822c_pwrtrack_init(rtwdev);
+
+	rtw_bf_phy_init(rtwdev);
 }
 
 #define WLAN_TXQ_RPT_EN		0x1F
@@ -2075,6 +2078,57 @@ static void rtw8822c_coex_cfg_wl_rx_gain(struct rtw_dev *rtwdev, bool low_gain)
 	}
 }
 
+static void rtw8822c_bf_enable_bfee_su(struct rtw_dev *rtwdev,
+				       struct rtw_vif *vif,
+				       struct rtw_bfee *bfee)
+{
+	u8 csi_rsc = 0;
+	u32 tmp6dc;
+
+	rtw_bf_enable_bfee_su(rtwdev, vif, bfee);
+
+	tmp6dc = rtw_read32(rtwdev, REG_BBPSF_CTRL) |
+			    BIT_WMAC_USE_NDPARATE |
+			    (csi_rsc << 13);
+	if (vif->net_type == RTW_NET_AP_MODE)
+		rtw_write32(rtwdev, REG_BBPSF_CTRL, tmp6dc | BIT(12));
+	else
+		rtw_write32(rtwdev, REG_BBPSF_CTRL, tmp6dc & ~BIT(12));
+
+	rtw_write32(rtwdev, REG_CSI_RRSR, 0x550);
+}
+
+static void rtw8822c_bf_config_bfee_su(struct rtw_dev *rtwdev,
+				       struct rtw_vif *vif,
+				       struct rtw_bfee *bfee, bool enable)
+{
+	if (enable)
+		rtw8822c_bf_enable_bfee_su(rtwdev, vif, bfee);
+	else
+		rtw_bf_remove_bfee_su(rtwdev, bfee);
+}
+
+static void rtw8822c_bf_config_bfee_mu(struct rtw_dev *rtwdev,
+				       struct rtw_vif *vif,
+				       struct rtw_bfee *bfee, bool enable)
+{
+	if (enable)
+		rtw_bf_enable_bfee_mu(rtwdev, vif, bfee);
+	else
+		rtw_bf_remove_bfee_mu(rtwdev, bfee);
+}
+
+static void rtw8822c_bf_config_bfee(struct rtw_dev *rtwdev, struct rtw_vif *vif,
+				    struct rtw_bfee *bfee, bool enable)
+{
+	if (bfee->role == RTW_BFEE_SU)
+		rtw8822c_bf_config_bfee_su(rtwdev, vif, bfee, enable);
+	else if (bfee->role == RTW_BFEE_MU)
+		rtw8822c_bf_config_bfee_mu(rtwdev, vif, bfee, enable);
+	else
+		rtw_warn(rtwdev, "wrong bfee role\n");
+}
+
 struct dpk_cfg_pair {
 	u32 addr;
 	u32 bitmask;
@@ -3678,6 +3732,9 @@ static struct rtw_chip_ops rtw8822c_ops = {
 	.phy_calibration	= rtw8822c_phy_calibration,
 	.cck_pd_set		= rtw8822c_phy_cck_pd_set,
 	.pwrtrack_check		= rtw8822c_pwrtrack_check,
+	.config_bfee		= rtw8822c_bf_config_bfee,
+	.set_gid_table		= rtw_bf_set_gid_table,
+	.cfg_csi_rate		= rtw_bf_cfg_csi_rate,
 
 	.coex_set_init		= rtw8822c_coex_cfg_init,
 	.coex_set_ant_switch	= NULL,
@@ -3998,6 +4055,8 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.dpd_ratemask = DIS_DPD_RATEALL,
 	.pwr_track_tbl = &rtw8822c_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
+	.bfer_su_max_num = 2,
+	.bfer_mu_max_num = 1,
 
 	.coex_para_ver = 0x19062706,
 	.bt_desired_ver = 0x6,
-- 
2.17.1

