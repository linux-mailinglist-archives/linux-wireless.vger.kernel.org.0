Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1223C2886
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jul 2021 19:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhGIRlI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jul 2021 13:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhGIRlH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jul 2021 13:41:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CB3C0613DD
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jul 2021 10:38:23 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1m1uS9-0000Ta-Nz; Fri, 09 Jul 2021 19:38:17 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1m1uS9-0003kR-3k; Fri, 09 Jul 2021 19:38:17 +0200
Date:   Fri, 9 Jul 2021 19:38:17 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 07/24] rtw89: add MAC files
Message-ID: <20210709173817.GB2099@pengutronix.de>
References: <20210618064625.14131-1-pkshih@realtek.com>
 <20210618064625.14131-8-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210618064625.14131-8-pkshih@realtek.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 19:37:35 up 131 days,  3:13, 150 users,  load average: 0.56, 0.79,
 0.53
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 18, 2021 at 02:46:08PM +0800, Ping-Ke Shih wrote:
> Provide interfaces to access MAC function blocks including power-on/off
> configuration.
> 
> MAC initialization does power-on, and then enable HCI to download firmware.
> The BB, RF, DMAC and CMAC function blocks are enabled, and then configure
> TXRX settings that contains DMAC, CMAC, interrupt mask, and RPQ parameters.
> DMAC is short for data MAC, including data link engine (DLE), HCI function
> control (HFC), MPDU processor, security engine and so on. CMAC is short for
> control MAC, including scheduler, address CAM, RX filter, CCA control,
> TMAC, RMAC, protocol component and so on.
> 
> The full MAC initialization is done for normal use case when user does
> network interface up. When device is probing, driver does partial
> initialization to do power-on and download firmware, because we need to
> read hardware capabilities from efuse and firmware.
> 
> MAC supports five ports, so we can have five VIFs at most. To control MAC
> port, we control a set of registers, and the most important one among them
> is port_cfg register named R_AX_PORT_CFG_P0. We can turn on/off the port
> function and configure network type (STA or AP mode) by this register.
> The address and BSSID corresponding to this port are given by address
> and BSSID CAM that is set by firmware via H2C command.
> 
> Since BT coexistence code needs to access coex registers, some help
> functions are provided to make WiFi-only case work.
> 
> To access MAC registers, normally we use rtw89_writeXX/rtw89_readYY, but
> we use rtw89_mac_txpwr_write32_ZZ to access TX power register with proper
> address range checking.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/mac.c | 4070 ++++++++++++++++++++++
>  drivers/net/wireless/realtek/rtw89/mac.h |  905 +++++
>  2 files changed, 4975 insertions(+)
>  create mode 100644 drivers/net/wireless/realtek/rtw89/mac.c
>  create mode 100644 drivers/net/wireless/realtek/rtw89/mac.h
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> new file mode 100644
> index 000000000000..e00652e11941
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -0,0 +1,4070 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/* Copyright(c) 2019-2020  Realtek Corporation
> + */
> +
> +#include "cam.h"
> +#include "debug.h"
> +#include "fw.h"
> +#include "mac.h"
> +#include "ps.h"
> +#include "reg.h"
> +#include "util.h"
> +
> +int rtw89_mac_check_mac_en(struct rtw89_dev *rtwdev, u8 mac_idx,
> +			   enum rtw89_mac_hwmod_sel sel)
> +{
> +	u32 val, r_val;
> +
> +	if (sel == RTW89_DMAC_SEL) {
> +		r_val = rtw89_read32(rtwdev, R_AX_DMAC_FUNC_EN);
> +		val = (B_AX_MAC_FUNC_EN | B_AX_DMAC_FUNC_EN);
> +	} else if (sel == RTW89_CMAC_SEL && mac_idx == 0) {
> +		r_val = rtw89_read32(rtwdev, R_AX_CMAC_FUNC_EN);
> +		val = B_AX_CMAC_EN;
> +	} else if (sel == RTW89_CMAC_SEL && mac_idx == 1) {
> +		r_val = rtw89_read32(rtwdev, R_AX_SYS_ISO_CTRL_EXTEND);
> +		val = B_AX_CMAC1_FEN;
> +	} else {
> +		return -EINVAL;
> +	}
> +	if (r_val == RTW89_R32_EA || r_val == RTW89_R32_DEAD ||
> +	    (val & r_val) != val)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +int rtw89_mac_write_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 val)
> +{
> +	u8 lte_ctrl;
> +	int ret;
> +
> +	ret = read_poll_timeout(rtw89_read8, lte_ctrl, (lte_ctrl & BIT(5)) != 0,
> +				50, 50000, false, rtwdev, R_AX_LTE_CTRL + 3);
> +	if (ret)
> +		rtw89_err(rtwdev, "[ERR]lte not ready(W)\n");
> +
> +	rtw89_write32(rtwdev, R_AX_LTE_WDATA, val);
> +	rtw89_write32(rtwdev, R_AX_LTE_CTRL, 0xC00F0000 | offset);
> +
> +	return ret;
> +}
> +
> +int rtw89_mac_read_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 *val)
> +{
> +	u8 lte_ctrl;
> +	int ret;
> +
> +	ret = read_poll_timeout(rtw89_read8, lte_ctrl, (lte_ctrl & BIT(5)) != 0,
> +				50, 50000, false, rtwdev, R_AX_LTE_CTRL + 3);
> +	if (ret)
> +		rtw89_err(rtwdev, "[ERR]lte not ready(W)\n");
> +
> +	rtw89_write32(rtwdev, R_AX_LTE_CTRL, 0x800F0000 | offset);
> +	*val = rtw89_read32(rtwdev, R_AX_LTE_RDATA);
> +
> +	return ret;
> +}
> +
> +static
> +int dle_dfi_ctrl(struct rtw89_dev *rtwdev, struct rtw89_mac_dle_dfi_ctrl *ctrl)
> +{
> +	u32 ctrl_reg, data_reg, ctrl_data;
> +	u32 val;
> +	int ret;
> +
> +	switch (ctrl->type) {
> +	case DLE_CTRL_TYPE_WDE:
> +		ctrl_reg = R_AX_WDE_DBG_FUN_INTF_CTL;
> +		data_reg = R_AX_WDE_DBG_FUN_INTF_DATA;
> +		ctrl_data = FIELD_PREP(B_AX_WDE_DFI_TRGSEL, ctrl->target) |
> +			    FIELD_PREP(B_AX_WDE_DFI_ADDR, ctrl->addr) |
> +			    B_AX_WDE_DFI_ACTIVE;
> +		break;
> +	case DLE_CTRL_TYPE_PLE:
> +		ctrl_reg = R_AX_PLE_DBG_FUN_INTF_CTL;
> +		data_reg = R_AX_PLE_DBG_FUN_INTF_DATA;
> +		ctrl_data = FIELD_PREP(B_AX_PLE_DFI_TRGSEL, ctrl->target) |
> +			    FIELD_PREP(B_AX_PLE_DFI_ADDR, ctrl->addr) |
> +			    B_AX_PLE_DFI_ACTIVE;
> +		break;
> +	default:
> +		rtw89_warn(rtwdev, "[ERR] dfi ctrl type %d\n", ctrl->type);
> +		return -EINVAL;
> +	}
> +
> +	rtw89_write32(rtwdev, ctrl_reg, ctrl_data);
> +
> +	ret = read_poll_timeout_atomic(rtw89_read32, val, !(val & B_AX_WDE_DFI_ACTIVE),
> +				       1, 1000, false, rtwdev, ctrl_reg);
> +	if (ret) {
> +		rtw89_warn(rtwdev, "[ERR] dle dfi ctrl 0x%X set 0x%X timeout\n",
> +			   ctrl_reg, ctrl_data);
> +		return ret;
> +	}
> +
> +	ctrl->out_data = rtw89_read32(rtwdev, data_reg);
> +	return 0;
> +}
> +
> +static int dle_dfi_quota(struct rtw89_dev *rtwdev,
> +			 struct rtw89_mac_dle_dfi_quota *quota)
> +{
> +	struct rtw89_mac_dle_dfi_ctrl ctrl;
> +	int ret;
> +
> +	ctrl.type = quota->dle_type;
> +	ctrl.target = DLE_DFI_TYPE_QUOTA;
> +	ctrl.addr = quota->qtaid;
> +	ret = dle_dfi_ctrl(rtwdev, &ctrl);
> +	if (ret) {
> +		rtw89_warn(rtwdev, "[ERR]dle_dfi_ctrl %d\n", ret);
> +		return ret;
> +	}
> +
> +	quota->rsv_pgnum = FIELD_GET(B_AX_DLE_RSV_PGNUM, ctrl.out_data);
> +	quota->use_pgnum = FIELD_GET(B_AX_DLE_USE_PGNUM, ctrl.out_data);
> +	return 0;
> +}
> +
> +static int dle_dfi_qempty(struct rtw89_dev *rtwdev,
> +			  struct rtw89_mac_dle_dfi_qempty *qempty)
> +{
> +	struct rtw89_mac_dle_dfi_ctrl ctrl;
> +	u32 ret;
> +
> +	ctrl.type = qempty->dle_type;
> +	ctrl.target = DLE_DFI_TYPE_QEMPTY;
> +	ctrl.addr = qempty->grpsel;
> +	ret = dle_dfi_ctrl(rtwdev, &ctrl);
> +	if (ret) {
> +		rtw89_warn(rtwdev, "[ERR]dle_dfi_ctrl %d\n", ret);
> +		return ret;
> +	}
> +
> +	qempty->qempty = FIELD_GET(B_AX_DLE_QEMPTY_GRP, ctrl.out_data);
> +	return 0;
> +}
> +
> +static void dump_err_status_dispatcher(struct rtw89_dev *rtwdev)
> +{
> +	rtw89_info(rtwdev, "R_AX_HOST_DISPATCHER_ALWAYS_IMR=0x%08x ",
> +		   rtw89_read32(rtwdev, R_AX_HOST_DISPATCHER_ERR_IMR));
> +	rtw89_info(rtwdev, "R_AX_HOST_DISPATCHER_ALWAYS_ISR=0x%08x\n",
> +		   rtw89_read32(rtwdev, R_AX_HOST_DISPATCHER_ERR_ISR));
> +	rtw89_info(rtwdev, "R_AX_CPU_DISPATCHER_ALWAYS_IMR=0x%08x ",
> +		   rtw89_read32(rtwdev, R_AX_CPU_DISPATCHER_ERR_IMR));
> +	rtw89_info(rtwdev, "R_AX_CPU_DISPATCHER_ALWAYS_ISR=0x%08x\n",
> +		   rtw89_read32(rtwdev, R_AX_CPU_DISPATCHER_ERR_ISR));
> +	rtw89_info(rtwdev, "R_AX_OTHER_DISPATCHER_ALWAYS_IMR=0x%08x ",
> +		   rtw89_read32(rtwdev, R_AX_OTHER_DISPATCHER_ERR_IMR));
> +	rtw89_info(rtwdev, "R_AX_OTHER_DISPATCHER_ALWAYS_ISR=0x%08x\n",
> +		   rtw89_read32(rtwdev, R_AX_OTHER_DISPATCHER_ERR_ISR));
> +}
> +
> +static void rtw89_mac_dump_qta_lost(struct rtw89_dev *rtwdev)
> +{
> +	struct rtw89_mac_dle_dfi_qempty qempty;
> +	struct rtw89_mac_dle_dfi_quota quota;
> +	struct rtw89_mac_dle_dfi_ctrl ctrl;
> +	u32 val, not_empty, i;
> +	int ret;
> +
> +	qempty.dle_type = DLE_CTRL_TYPE_PLE;
> +	qempty.grpsel = 0;
> +	ret = dle_dfi_qempty(rtwdev, &qempty);
> +	if (ret)
> +		rtw89_warn(rtwdev, "%s: query DLE fail\n", __func__);
> +	else
> +		rtw89_info(rtwdev, "DLE group0 empty: 0x%x\n", qempty.qempty);
> +
> +	for (not_empty = ~qempty.qempty, i = 0; not_empty != 0; not_empty >>= 1, i++) {
> +		if (!(not_empty & BIT(0)))
> +			continue;
> +		ctrl.type = DLE_CTRL_TYPE_PLE;
> +		ctrl.target = DLE_DFI_TYPE_QLNKTBL;
> +		ctrl.addr = (QLNKTBL_ADDR_INFO_SEL_0 ? QLNKTBL_ADDR_INFO_SEL : 0) |
> +			    FIELD_PREP(QLNKTBL_ADDR_TBL_IDX_MASK, i);
> +		ret = dle_dfi_ctrl(rtwdev, &ctrl);
> +		if (ret)
> +			rtw89_warn(rtwdev, "%s: query DLE fail\n", __func__);
> +		else
> +			rtw89_info(rtwdev, "qidx%d pktcnt = %ld\n", i,
> +				   FIELD_GET(QLNKTBL_DATA_SEL1_PKT_CNT_MASK,
> +					     ctrl.out_data));
> +	}
> +
> +	quota.dle_type = DLE_CTRL_TYPE_PLE;
> +	quota.qtaid = 6;
> +	ret = dle_dfi_quota(rtwdev, &quota);
> +	if (ret)
> +		rtw89_warn(rtwdev, "%s: query DLE fail\n", __func__);
> +	else
> +		rtw89_info(rtwdev, "quota6 rsv/use: 0x%x/0x%x\n",
> +			   quota.rsv_pgnum, quota.use_pgnum);
> +
> +	val = rtw89_read32(rtwdev, R_AX_PLE_QTA6_CFG);
> +	rtw89_info(rtwdev, "[PLE][CMAC0_RX]min_pgnum=0x%lx\n",
> +		   FIELD_GET(B_AX_PLE_Q6_MIN_SIZE_MASK, val));
> +	rtw89_info(rtwdev, "[PLE][CMAC0_RX]max_pgnum=0x%lx\n",
> +		   FIELD_GET(B_AX_PLE_Q6_MAX_SIZE_MASK, val));
> +
> +	dump_err_status_dispatcher(rtwdev);
> +}
> +
> +static void rtw89_mac_dump_l0_to_l1(struct rtw89_dev *rtwdev,
> +				    enum mac_ax_err_info err)
> +{
> +	u32 dbg, event;
> +
> +	dbg = rtw89_read32(rtwdev, R_AX_SER_DBG_INFO);
> +	event = FIELD_GET(B_AX_L0_TO_L1_EVENT_MASK, dbg);
> +
> +	switch (event) {
> +	case MAC_AX_L0_TO_L1_RX_QTA_LOST:
> +		rtw89_info(rtwdev, "quota lost!\n");
> +		rtw89_mac_dump_qta_lost(rtwdev);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static void rtw89_mac_dump_err_status(struct rtw89_dev *rtwdev,
> +				      enum mac_ax_err_info err)
> +{
> +	u32 dmac_err, cmac_err;
> +
> +	if (err != MAC_AX_ERR_L1_ERR_DMAC &&
> +	    err != MAC_AX_ERR_L0_PROMOTE_TO_L1)
> +		return;
> +
> +	rtw89_info(rtwdev, "--->\nerr=0x%x\n", err);
> +	rtw89_info(rtwdev, "R_AX_SER_DBG_INFO =0x%08x\n",
> +		   rtw89_read32(rtwdev, R_AX_SER_DBG_INFO));
> +
> +	cmac_err = rtw89_read32(rtwdev, R_AX_CMAC_ERR_ISR);
> +	rtw89_info(rtwdev, "R_AX_CMAC_ERR_ISR =0x%08x\n", cmac_err);
> +	dmac_err = rtw89_read32(rtwdev, R_AX_DMAC_ERR_ISR);
> +	rtw89_info(rtwdev, "R_AX_DMAC_ERR_ISR =0x%08x\n", dmac_err);
> +
> +	if (dmac_err) {
> +		rtw89_info(rtwdev, "R_AX_WDE_ERR_FLAG_CFG =0x%08x ",
> +			   rtw89_read32(rtwdev, R_AX_WDE_ERR_FLAG_CFG));
> +		rtw89_info(rtwdev, "R_AX_PLE_ERR_FLAG_CFG =0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_CFG));
> +	}
> +
> +	if (dmac_err & B_AX_WDRLS_ERR_FLAG) {
> +		rtw89_info(rtwdev, "R_AX_WDRLS_ERR_IMR =0x%08x ",
> +			   rtw89_read32(rtwdev, R_AX_WDRLS_ERR_IMR));
> +		rtw89_info(rtwdev, "R_AX_WDRLS_ERR_ISR =0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_WDRLS_ERR_ISR));
> +	}
> +
> +	if (dmac_err & B_AX_WSEC_ERR_FLAG) {
> +		rtw89_info(rtwdev, "R_AX_SEC_ERR_IMR_ISR =0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_SEC_DEBUG));
> +		rtw89_info(rtwdev, "SEC_local_Register 0x9D00 =0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_SEC_ENG_CTRL));
> +		rtw89_info(rtwdev, "SEC_local_Register 0x9D04 =0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_SEC_MPDU_PROC));
> +		rtw89_info(rtwdev, "SEC_local_Register 0x9D10 =0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_SEC_CAM_ACCESS));
> +		rtw89_info(rtwdev, "SEC_local_Register 0x9D14 =0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_SEC_CAM_RDATA));
> +		rtw89_info(rtwdev, "SEC_local_Register 0x9D18 =0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_SEC_CAM_WDATA));
> +		rtw89_info(rtwdev, "SEC_local_Register 0x9D20 =0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_SEC_TX_DEBUG));
> +		rtw89_info(rtwdev, "SEC_local_Register 0x9D24 =0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_SEC_RX_DEBUG));
> +		rtw89_info(rtwdev, "SEC_local_Register 0x9D28 =0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_SEC_TRX_PKT_CNT));
> +		rtw89_info(rtwdev, "SEC_local_Register 0x9D2C =0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_SEC_TRX_BLK_CNT));
> +	}
> +
> +	if (dmac_err & B_AX_MPDU_ERR_FLAG) {
> +		rtw89_info(rtwdev, "R_AX_MPDU_TX_ERR_IMR =0x%08x ",
> +			   rtw89_read32(rtwdev, R_AX_MPDU_TX_ERR_IMR));
> +		rtw89_info(rtwdev, "R_AX_MPDU_TX_ERR_ISR =0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_MPDU_TX_ERR_ISR));
> +		rtw89_info(rtwdev, "R_AX_MPDU_RX_ERR_IMR =0x%08x ",
> +			   rtw89_read32(rtwdev, R_AX_MPDU_RX_ERR_IMR));
> +		rtw89_info(rtwdev, "R_AX_MPDU_RX_ERR_ISR =0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_MPDU_RX_ERR_ISR));
> +	}
> +
> +	if (dmac_err & B_AX_STA_SCHEDULER_ERR_FLAG) {
> +		rtw89_info(rtwdev, "R_AX_STA_SCHEDULER_ERR_IMR =0x%08x ",
> +			   rtw89_read32(rtwdev, R_AX_STA_SCHEDULER_ERR_IMR));
> +		rtw89_info(rtwdev, "R_AX_STA_SCHEDULER_ERR_ISR= 0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_STA_SCHEDULER_ERR_ISR));
> +	}
> +
> +	if (dmac_err & B_AX_WDE_DLE_ERR_FLAG) {
> +		rtw89_info(rtwdev, "R_AX_WDE_ERR_IMR=0x%08x ",
> +			   rtw89_read32(rtwdev, R_AX_WDE_ERR_IMR));
> +		rtw89_info(rtwdev, "R_AX_WDE_ERR_ISR=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_WDE_ERR_ISR));
> +		rtw89_info(rtwdev, "R_AX_PLE_ERR_IMR=0x%08x ",
> +			   rtw89_read32(rtwdev, R_AX_PLE_ERR_IMR));
> +		rtw89_info(rtwdev, "R_AX_PLE_ERR_FLAG_ISR=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_ISR));
> +		dump_err_status_dispatcher(rtwdev);
> +	}
> +
> +	if (dmac_err & B_AX_TXPKTCTRL_ERR_FLAG) {
> +		rtw89_info(rtwdev, "R_AX_TXPKTCTL_ERR_IMR_ISR=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR));
> +		rtw89_info(rtwdev, "R_AX_TXPKTCTL_ERR_IMR_ISR_B1=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR_B1));
> +	}
> +
> +	if (dmac_err & B_AX_PLE_DLE_ERR_FLAG) {
> +		rtw89_info(rtwdev, "R_AX_WDE_ERR_IMR=0x%08x ",
> +			   rtw89_read32(rtwdev, R_AX_WDE_ERR_IMR));
> +		rtw89_info(rtwdev, "R_AX_WDE_ERR_ISR=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_WDE_ERR_ISR));
> +		rtw89_info(rtwdev, "R_AX_PLE_ERR_IMR=0x%08x ",
> +			   rtw89_read32(rtwdev, R_AX_PLE_ERR_IMR));
> +		rtw89_info(rtwdev, "R_AX_PLE_ERR_FLAG_ISR=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_ISR));
> +		rtw89_info(rtwdev, "R_AX_WD_CPUQ_OP_0=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_0));
> +		rtw89_info(rtwdev, "R_AX_WD_CPUQ_OP_1=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_1));
> +		rtw89_info(rtwdev, "R_AX_WD_CPUQ_OP_2=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_2));
> +		rtw89_info(rtwdev, "R_AX_WD_CPUQ_OP_STATUS=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_STATUS));
> +		rtw89_info(rtwdev, "R_AX_PL_CPUQ_OP_0=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_0));
> +		rtw89_info(rtwdev, "R_AX_PL_CPUQ_OP_1=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_1));
> +		rtw89_info(rtwdev, "R_AX_PL_CPUQ_OP_2=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_2));
> +		rtw89_info(rtwdev, "R_AX_PL_CPUQ_OP_STATUS=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_STATUS));
> +		rtw89_info(rtwdev, "R_AX_RXDMA_PKT_INFO_0=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_0));
> +		rtw89_info(rtwdev, "R_AX_RXDMA_PKT_INFO_1=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_1));
> +		rtw89_info(rtwdev, "R_AX_RXDMA_PKT_INFO_2=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_2));
> +		dump_err_status_dispatcher(rtwdev);
> +	}
> +
> +	if (dmac_err & B_AX_PKTIN_ERR_FLAG) {
> +		rtw89_info(rtwdev, "R_AX_PKTIN_ERR_IMR =0x%08x ",
> +			   rtw89_read32(rtwdev, R_AX_PKTIN_ERR_IMR));
> +		rtw89_info(rtwdev, "R_AX_PKTIN_ERR_ISR =0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_PKTIN_ERR_ISR));
> +		rtw89_info(rtwdev, "R_AX_PKTIN_ERR_IMR =0x%08x ",
> +			   rtw89_read32(rtwdev, R_AX_PKTIN_ERR_IMR));
> +		rtw89_info(rtwdev, "R_AX_PKTIN_ERR_ISR =0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_PKTIN_ERR_ISR));
> +	}
> +
> +	if (dmac_err & B_AX_DISPATCH_ERR_FLAG)
> +		dump_err_status_dispatcher(rtwdev);
> +
> +	if (dmac_err & B_AX_DLE_CPUIO_ERR_FLAG) {
> +		rtw89_info(rtwdev, "R_AX_CPUIO_ERR_IMR=0x%08x ",
> +			   rtw89_read32(rtwdev, R_AX_CPUIO_ERR_IMR));
> +		rtw89_info(rtwdev, "R_AX_CPUIO_ERR_ISR=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_CPUIO_ERR_ISR));
> +	}
> +
> +	if (dmac_err & BIT(11)) {
> +		rtw89_info(rtwdev, "R_AX_BBRPT_COM_ERR_IMR_ISR=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_BBRPT_COM_ERR_IMR_ISR));
> +	}
> +
> +	if (cmac_err & B_AX_SCHEDULE_TOP_ERR_IND) {
> +		rtw89_info(rtwdev, "R_AX_SCHEDULE_ERR_IMR=0x%08x ",
> +			   rtw89_read32(rtwdev, R_AX_SCHEDULE_ERR_IMR));
> +		rtw89_info(rtwdev, "R_AX_SCHEDULE_ERR_ISR=0x%04x\n",
> +			   rtw89_read16(rtwdev, R_AX_SCHEDULE_ERR_ISR));
> +	}
> +
> +	if (cmac_err & B_AX_PTCL_TOP_ERR_IND) {
> +		rtw89_info(rtwdev, "R_AX_PTCL_IMR0=0x%08x ",
> +			   rtw89_read32(rtwdev, R_AX_PTCL_IMR0));
> +		rtw89_info(rtwdev, "R_AX_PTCL_ISR0=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_PTCL_ISR0));
> +	}
> +
> +	if (cmac_err & B_AX_DMA_TOP_ERR_IND) {
> +		rtw89_info(rtwdev, "R_AX_DLE_CTRL=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_DLE_CTRL));
> +	}
> +
> +	if (cmac_err & B_AX_PHYINTF_ERR_IND) {
> +		rtw89_info(rtwdev, "R_AX_PHYINFO_ERR_IMR=0x%04x\n",
> +			   rtw89_read16(rtwdev, R_AX_PHYINFO_ERR_IMR));
> +	}
> +
> +	if (cmac_err & B_AX_TXPWR_CTRL_ERR_IND) {
> +		rtw89_info(rtwdev, "R_AX_TXPWR_IMR=0x%08x ",
> +			   rtw89_read32(rtwdev, R_AX_TXPWR_IMR));
> +		rtw89_info(rtwdev, "R_AX_TXPWR_ISR=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_TXPWR_ISR));
> +	}
> +
> +	if (cmac_err & B_AX_WMAC_RX_ERR_IND) {
> +		rtw89_info(rtwdev, "R_AX_DBGSEL_TRXPTCL=0x%08x ",
> +			   rtw89_read32(rtwdev, R_AX_DBGSEL_TRXPTCL));
> +		rtw89_info(rtwdev, "R_AX_PHYINFO_ERR_ISR=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_PHYINFO_ERR_ISR));
> +	}
> +
> +	if (cmac_err & B_AX_WMAC_TX_ERR_IND) {
> +		rtw89_info(rtwdev, "R_AX_TMAC_ERR_IMR_ISR=0x%08x ",
> +			   rtw89_read32(rtwdev, R_AX_TMAC_ERR_IMR_ISR));
> +		rtw89_info(rtwdev, "R_AX_DBGSEL_TRXPTCL=0x%08x\n",
> +			   rtw89_read32(rtwdev, R_AX_DBGSEL_TRXPTCL));
> +	}
> +
> +	rtwdev->hci.ops->dump_err_status(rtwdev);
> +
> +	if (err == MAC_AX_ERR_L0_PROMOTE_TO_L1)
> +		rtw89_mac_dump_l0_to_l1(rtwdev, err);
> +
> +	rtw89_info(rtwdev, "<---\n");
> +}
> +
> +u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev)
> +{
> +	u32 err;
> +	int ret;
> +
> +	ret = read_poll_timeout(rtw89_read32, err, (err != 0), 1000, 100000,
> +				false, rtwdev, R_AX_HALT_C2H_CTRL);
> +	if (ret) {
> +		rtw89_warn(rtwdev, "Polling FW err status fail\n");
> +		return ret;
> +	}
> +
> +	err = rtw89_read32(rtwdev, R_AX_HALT_C2H);
> +	rtw89_write32(rtwdev, R_AX_HALT_C2H_CTRL, 0);
> +
> +	rtw89_fw_st_dbg_dump(rtwdev);
> +	rtw89_mac_dump_err_status(rtwdev, err);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(rtw89_mac_get_err_status);
> +
> +int rtw89_mac_set_err_status(struct rtw89_dev *rtwdev, u32 err)
> +{
> +	u32 halt;
> +	int ret = 0;
> +
> +	if (err > MAC_AX_SET_ERR_MAX) {
> +		rtw89_err(rtwdev, "Bad set-err-status value 0x%08x\n", err);
> +		return -EINVAL;
> +	}
> +
> +	ret = read_poll_timeout(rtw89_read32, halt, (halt == 0x0), 1000,
> +				100000, false, rtwdev, R_AX_HALT_H2C_CTRL);
> +	if (ret) {
> +		rtw89_err(rtwdev, "FW doesn't receive previous msg\n");
> +		return -EFAULT;
> +	}
> +
> +	rtw89_write32(rtwdev, R_AX_HALT_H2C, err);
> +	rtw89_write32(rtwdev, R_AX_HALT_H2C_CTRL, B_AX_HALT_H2C_TRIGGER);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(rtw89_mac_set_err_status);
> +
> +struct rtw89_hfc_prec_cfg rtw_hfc_preccfg_pcie = {
> +	2, 40, 0, 0, 1, 0, 0, 0
> +};
> +
> +struct rtw89_hfc_prec_cfg rtw_hfc_preccfg_pcie_wd128 = {
> +	2, 40, 0, 0, 1, 0, 0, 0
> +};
> +
> +struct rtw89_hfc_prec_cfg rtw_hfc_preccfg_pcie_stf = {
> +	1, 40, 64, 64, 1, 0, 1, 1
> +};
> +
> +static int hfc_reset_param(struct rtw89_dev *rtwdev)
> +{
> +	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
> +	struct rtw89_hfc_param_ini param_ini = {NULL};
> +	u8 qta_mode = rtwdev->mac.dle_info.qta_mode;
> +
> +	switch (rtwdev->hci.type) {
> +	case RTW89_HCI_TYPE_PCIE:
> +		param_ini = rtwdev->chip->hfc_param_ini[qta_mode];
> +		param->en = 0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (param_ini.pub_cfg)
> +		param->pub_cfg = param_ini.pub_cfg;
> +
> +	if (param_ini.prec_cfg) {
> +		param->prec_cfg = param_ini.prec_cfg;
> +		rtwdev->hal.sw_amsdu_max_size =
> +				param->prec_cfg->wp_ch07_prec * HFC_PAGE_UNIT;
> +	}
> +
> +	if (param_ini.ch_cfg)
> +		param->ch_cfg = param_ini.ch_cfg;
> +
> +	memset(&param->ch_info, 0, sizeof(param->ch_info));
> +	memset(&param->pub_info, 0, sizeof(param->pub_info));
> +	param->mode = param_ini.mode;
> +
> +	return 0;
> +}
> +
> +static int hfc_ch_cfg_chk(struct rtw89_dev *rtwdev, u8 ch)
> +{
> +	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
> +	struct rtw89_hfc_ch_cfg *ch_cfg = param->ch_cfg;
> +	struct rtw89_hfc_pub_cfg *pub_cfg = param->pub_cfg;
> +	struct rtw89_hfc_prec_cfg *prec_cfg = param->prec_cfg;
> +
> +	if (ch >= RTW89_DMA_CH_NUM)
> +		return -EINVAL;
> +
> +	if ((ch_cfg[ch].min && ch_cfg[ch].min < prec_cfg->ch011_prec) ||
> +	    ch_cfg[ch].max > pub_cfg->pub_max)
> +		return -EINVAL;
> +	if (ch_cfg[ch].grp >= grp_num)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int hfc_pub_info_chk(struct rtw89_dev *rtwdev)
> +{
> +	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
> +	struct rtw89_hfc_pub_cfg *cfg = param->pub_cfg;
> +	struct rtw89_hfc_pub_info *info = &param->pub_info;
> +
> +	if (info->g0_used + info->g1_used + info->pub_aval != cfg->pub_max) {
> +		if (rtwdev->chip->chip_id == RTL8852A)
> +			return 0;
> +		else
> +			return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hfc_pub_cfg_chk(struct rtw89_dev *rtwdev)
> +{
> +	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
> +	struct rtw89_hfc_pub_cfg *pub_cfg = param->pub_cfg;
> +
> +	if (pub_cfg->grp0 + pub_cfg->grp1 != pub_cfg->pub_max)
> +		return 0;
> +
> +	return 0;
> +}
> +
> +static int hfc_ch_ctrl(struct rtw89_dev *rtwdev, u8 ch)
> +{
> +	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
> +	struct rtw89_hfc_ch_cfg *cfg = param->ch_cfg;
> +	int ret = 0;
> +	u32 val = 0;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	ret = hfc_ch_cfg_chk(rtwdev, ch);
> +	if (ret)
> +		return ret;
> +
> +	if (ch > RTW89_DMA_B1HI)
> +		return -EINVAL;
> +
> +	val = u32_encode_bits(cfg[ch].min, B_AX_MIN_PG_MASK) |
> +	      u32_encode_bits(cfg[ch].max, B_AX_MAX_PG_MASK) |
> +	      (cfg[ch].grp ? B_AX_GRP : 0);
> +	rtw89_write32(rtwdev, R_AX_ACH0_PAGE_CTRL + ch * 4, val);
> +
> +	return 0;
> +}
> +
> +static int hfc_upd_ch_info(struct rtw89_dev *rtwdev, u8 ch)
> +{
> +	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
> +	struct rtw89_hfc_ch_info *info = param->ch_info;
> +	struct rtw89_hfc_ch_cfg *cfg = param->ch_cfg;
> +	u32 val;
> +	u32 ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	if (ch > RTW89_DMA_H2C)
> +		return -EINVAL;
> +
> +	val = rtw89_read32(rtwdev, R_AX_ACH0_PAGE_INFO + ch * 4);
> +	info[ch].aval = u32_get_bits(val, B_AX_AVAL_PG_MASK);
> +	if (ch < RTW89_DMA_H2C)
> +		info[ch].used = u32_get_bits(val, B_AX_USE_PG_MASK);
> +	else
> +		info[ch].used = cfg[ch].min - info[ch].aval;
> +
> +	return 0;
> +}
> +
> +static int hfc_pub_ctrl(struct rtw89_dev *rtwdev)
> +{
> +	struct rtw89_hfc_pub_cfg *cfg = rtwdev->mac.hfc_param.pub_cfg;
> +	u32 val;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	ret = hfc_pub_cfg_chk(rtwdev);
> +	if (ret)
> +		return ret;
> +
> +	val = u32_encode_bits(cfg->grp0, B_AX_PUBPG_G0_MASK) |
> +	      u32_encode_bits(cfg->grp1, B_AX_PUBPG_G1_MASK);
> +	rtw89_write32(rtwdev, R_AX_PUB_PAGE_CTRL1, val);
> +
> +	val = u32_encode_bits(cfg->wp_thrd, B_AX_WP_THRD_MASK);
> +	rtw89_write32(rtwdev, R_AX_WP_PAGE_CTRL2, val);
> +
> +	return 0;
> +}
> +
> +static int hfc_upd_mix_info(struct rtw89_dev *rtwdev)
> +{
> +	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
> +	struct rtw89_hfc_pub_cfg *pub_cfg = param->pub_cfg;
> +	struct rtw89_hfc_prec_cfg *prec_cfg = param->prec_cfg;
> +	struct rtw89_hfc_pub_info *info = &param->pub_info;
> +	u32 val;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	val = rtw89_read32(rtwdev, R_AX_PUB_PAGE_INFO1);
> +	info->g0_used = u32_get_bits(val, B_AX_G0_USE_PG_MASK);
> +	info->g1_used = u32_get_bits(val, B_AX_G1_USE_PG_MASK);
> +	val = rtw89_read32(rtwdev, R_AX_PUB_PAGE_INFO3);
> +	info->g0_aval = u32_get_bits(val, B_AX_G0_AVAL_PG_MASK);
> +	info->g1_aval = u32_get_bits(val, B_AX_G1_AVAL_PG_MASK);
> +	info->pub_aval =
> +		u32_get_bits(rtw89_read32(rtwdev, R_AX_PUB_PAGE_INFO2),
> +			     B_AX_PUB_AVAL_PG_MASK);
> +	info->wp_aval =
> +		u32_get_bits(rtw89_read32(rtwdev, R_AX_WP_PAGE_INFO1),
> +			     B_AX_WP_AVAL_PG_MASK);
> +
> +	val = rtw89_read32(rtwdev, R_AX_HCI_FC_CTRL);
> +	param->en = val & B_AX_HCI_FC_EN ? 1 : 0;
> +	param->h2c_en = val & B_AX_HCI_FC_CH12_EN ? 1 : 0;
> +	param->mode = u32_get_bits(val, B_AX_HCI_FC_MODE_MASK);
> +	prec_cfg->ch011_full_cond =
> +		u32_get_bits(val, B_AX_HCI_FC_WD_FULL_COND_MASK);
> +	prec_cfg->h2c_full_cond =
> +		u32_get_bits(val, B_AX_HCI_FC_CH12_FULL_COND_MASK);
> +	prec_cfg->wp_ch07_full_cond =
> +		u32_get_bits(val, B_AX_HCI_FC_WP_CH07_FULL_COND_MASK);
> +	prec_cfg->wp_ch811_full_cond =
> +		u32_get_bits(val, B_AX_HCI_FC_WP_CH811_FULL_COND_MASK);
> +
> +	val = rtw89_read32(rtwdev, R_AX_CH_PAGE_CTRL);
> +	prec_cfg->ch011_prec = u32_get_bits(val, B_AX_PREC_PAGE_CH011_MASK);
> +	prec_cfg->h2c_prec = u32_get_bits(val, B_AX_PREC_PAGE_CH12_MASK);
> +
> +	val = rtw89_read32(rtwdev, R_AX_PUB_PAGE_CTRL2);
> +	pub_cfg->pub_max = u32_get_bits(val, B_AX_PUBPG_ALL_MASK);
> +
> +	val = rtw89_read32(rtwdev, R_AX_WP_PAGE_CTRL1);
> +	prec_cfg->wp_ch07_prec = u32_get_bits(val, B_AX_PREC_PAGE_WP_CH07_MASK);
> +	prec_cfg->wp_ch811_prec = u32_get_bits(val, B_AX_PREC_PAGE_WP_CH811_MASK);
> +
> +	val = rtw89_read32(rtwdev, R_AX_WP_PAGE_CTRL2);
> +	pub_cfg->wp_thrd = u32_get_bits(val, B_AX_WP_THRD_MASK);
> +
> +	val = rtw89_read32(rtwdev, R_AX_PUB_PAGE_CTRL1);
> +	pub_cfg->grp0 = u32_get_bits(val, B_AX_PUBPG_G0_MASK);
> +	pub_cfg->grp1 = u32_get_bits(val, B_AX_PUBPG_G1_MASK);
> +
> +	ret = hfc_pub_info_chk(rtwdev);
> +	if (param->en && ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void hfc_h2c_cfg(struct rtw89_dev *rtwdev)
> +{
> +	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
> +	struct rtw89_hfc_prec_cfg *prec_cfg = param->prec_cfg;
> +	u32 val;
> +
> +	val = u32_encode_bits(prec_cfg->h2c_prec, B_AX_PREC_PAGE_CH12_MASK);
> +	rtw89_write32(rtwdev, R_AX_CH_PAGE_CTRL, val);
> +
> +	rtw89_write32_mask(rtwdev, R_AX_HCI_FC_CTRL,
> +			   B_AX_HCI_FC_CH12_FULL_COND_MASK,
> +			   prec_cfg->h2c_full_cond);
> +}
> +
> +static void hfc_mix_cfg(struct rtw89_dev *rtwdev)
> +{
> +	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
> +	struct rtw89_hfc_pub_cfg *pub_cfg = param->pub_cfg;
> +	struct rtw89_hfc_prec_cfg *prec_cfg = param->prec_cfg;
> +	u32 val;
> +
> +	val = u32_encode_bits(prec_cfg->ch011_prec, B_AX_PREC_PAGE_CH011_MASK) |
> +	      u32_encode_bits(prec_cfg->h2c_prec, B_AX_PREC_PAGE_CH12_MASK);
> +	rtw89_write32(rtwdev, R_AX_CH_PAGE_CTRL, val);
> +
> +	val = u32_encode_bits(pub_cfg->pub_max, B_AX_PUBPG_ALL_MASK);
> +	rtw89_write32(rtwdev, R_AX_PUB_PAGE_CTRL2, val);
> +
> +	val = u32_encode_bits(prec_cfg->wp_ch07_prec,
> +			      B_AX_PREC_PAGE_WP_CH07_MASK) |
> +	      u32_encode_bits(prec_cfg->wp_ch811_prec,
> +			      B_AX_PREC_PAGE_WP_CH811_MASK);
> +	rtw89_write32(rtwdev, R_AX_WP_PAGE_CTRL1, val);
> +
> +	val = u32_replace_bits(rtw89_read32(rtwdev, R_AX_HCI_FC_CTRL),
> +			       param->mode, B_AX_HCI_FC_MODE_MASK);
> +	val = u32_replace_bits(val, prec_cfg->ch011_full_cond,
> +			       B_AX_HCI_FC_WD_FULL_COND_MASK);
> +	val = u32_replace_bits(val, prec_cfg->h2c_full_cond,
> +			       B_AX_HCI_FC_CH12_FULL_COND_MASK);
> +	val = u32_replace_bits(val, prec_cfg->wp_ch07_full_cond,
> +			       B_AX_HCI_FC_WP_CH07_FULL_COND_MASK);
> +	val = u32_replace_bits(val, prec_cfg->wp_ch811_full_cond,
> +			       B_AX_HCI_FC_WP_CH811_FULL_COND_MASK);
> +	rtw89_write32(rtwdev, R_AX_HCI_FC_CTRL, val);
> +}
> +
> +static void hfc_func_en(struct rtw89_dev *rtwdev, bool en, bool h2c_en)
> +{
> +	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
> +	u32 val;
> +
> +	val = rtw89_read32(rtwdev, R_AX_HCI_FC_CTRL);
> +	param->en = en;
> +	param->h2c_en = h2c_en;
> +	val = en ? (val | B_AX_HCI_FC_EN) : (val & ~B_AX_HCI_FC_EN);
> +	val = h2c_en ? (val | B_AX_HCI_FC_CH12_EN) :
> +			 (val & ~B_AX_HCI_FC_CH12_EN);
> +	rtw89_write32(rtwdev, R_AX_HCI_FC_CTRL, val);
> +}
> +
> +static int hfc_init(struct rtw89_dev *rtwdev, bool reset, bool en, bool h2c_en)
> +{
> +	u8 ch;
> +	u32 ret = 0;
> +
> +	if (reset)
> +		ret = hfc_reset_param(rtwdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	hfc_func_en(rtwdev, false, false);
> +
> +	if (!en && h2c_en) {
> +		hfc_h2c_cfg(rtwdev);
> +		hfc_func_en(rtwdev, en, h2c_en);
> +		return ret;
> +	}
> +
> +	for (ch = RTW89_DMA_ACH0; ch < RTW89_DMA_H2C; ch++) {
> +		ret = hfc_ch_ctrl(rtwdev, ch);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = hfc_pub_ctrl(rtwdev);
> +	if (ret)
> +		return ret;
> +
> +	hfc_mix_cfg(rtwdev);
> +	if (en || h2c_en) {
> +		hfc_func_en(rtwdev, en, h2c_en);
> +		udelay(10);
> +	}
> +	for (ch = RTW89_DMA_ACH0; ch < RTW89_DMA_H2C; ch++) {
> +		ret = hfc_upd_ch_info(rtwdev, ch);
> +		if (ret)
> +			return ret;
> +	}
> +	ret = hfc_upd_mix_info(rtwdev);
> +
> +	return ret;
> +}
> +
> +#define PWR_POLL_CNT	2000
> +static int pwr_cmd_poll(struct rtw89_dev *rtwdev,
> +			const struct rtw89_pwr_cfg *cfg)
> +{
> +	u8 val = 0;
> +	int ret;
> +	u32 addr = cfg->base == PWR_INTF_MSK_SDIO ?
> +		   cfg->addr | SDIO_LOCAL_BASE_ADDR : cfg->addr;
> +
> +	ret = read_poll_timeout(rtw89_read8, val, !((val ^ cfg->val) & cfg->msk),
> +				1000, 1000 * PWR_POLL_CNT, false, rtwdev, addr);
> +
> +	if (!ret)
> +		return 0;
> +
> +	rtw89_warn(rtwdev, "[ERR] Polling timeout\n");
> +	rtw89_warn(rtwdev, "[ERR] addr: %X, %X\n", addr, cfg->addr);
> +	rtw89_warn(rtwdev, "[ERR] val: %X, %X\n", val, cfg->val);
> +
> +	return -EBUSY;
> +}
> +
> +static int rtw89_mac_sub_pwr_seq(struct rtw89_dev *rtwdev, u8 cv_msk,
> +				 u8 intf_msk, const struct rtw89_pwr_cfg *cfg)
> +{
> +	const struct rtw89_pwr_cfg *cur_cfg;
> +	u32 addr;
> +	u8 val;
> +
> +	for (cur_cfg = cfg; cur_cfg->cmd != PWR_CMD_END; cur_cfg++) {
> +		if (!(cur_cfg->intf_msk & intf_msk) ||
> +		    !(cur_cfg->cv_msk & cv_msk))
> +			continue;
> +
> +		switch (cur_cfg->cmd) {
> +		case PWR_CMD_WRITE:
> +			addr = cur_cfg->addr;
> +
> +			if (cur_cfg->base == PWR_BASE_SDIO)
> +				addr |= SDIO_LOCAL_BASE_ADDR;
> +
> +			val = rtw89_read8(rtwdev, addr);
> +			val &= ~(cur_cfg->msk);
> +			val |= (cur_cfg->val & cur_cfg->msk);
> +
> +			rtw89_write8(rtwdev, addr, val);
> +			break;
> +		case PWR_CMD_POLL:
> +			if (pwr_cmd_poll(rtwdev, cur_cfg))
> +				return -EBUSY;
> +			break;
> +		case PWR_CMD_DELAY:
> +			if (cur_cfg->val == PWR_DELAY_US)
> +				udelay(cur_cfg->addr);
> +			else
> +				fsleep(cur_cfg->addr * 1000);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int rtw89_mac_pwr_seq(struct rtw89_dev *rtwdev,
> +			     const struct rtw89_pwr_cfg * const *cfg_seq)
> +{
> +	u32 idx = 0;
> +	const struct rtw89_pwr_cfg *cfg;
> +	int ret;
> +
> +	do {
> +		cfg = cfg_seq[idx];
> +		if (!cfg)
> +			break;
> +
> +		ret = rtw89_mac_sub_pwr_seq(rtwdev, BIT(rtwdev->hal.cv),
> +					    PWR_INTF_MSK_PCIE, cfg);
> +		if (ret)
> +			return -EBUSY;
> +
> +		idx++;
> +	} while (1);
> +
> +	return 0;
> +}
> +
> +static enum rtw89_rpwm_req_pwr_state
> +rtw89_mac_get_req_pwr_state(struct rtw89_dev *rtwdev)
> +{
> +	enum rtw89_rpwm_req_pwr_state state;
> +
> +	switch (rtwdev->ps_mode) {
> +	case RTW89_PS_MODE_RFOFF:
> +		state = RTW89_MAC_RPWM_REQ_PWR_STATE_BAND0_RFOFF;
> +		break;
> +	case RTW89_PS_MODE_CLK_GATED:
> +		state = RTW89_MAC_RPWM_REQ_PWR_STATE_CLK_GATED;
> +		break;
> +	case RTW89_PS_MODE_PWR_GATED:
> +		state = RTW89_MAC_RPWM_REQ_PWR_STATE_PWR_GATED;
> +		break;
> +	default:
> +		state = RTW89_MAC_RPWM_REQ_PWR_STATE_ACTIVE;
> +		break;
> +	}
> +	return state;
> +}
> +
> +static void rtw89_mac_send_rpwm(struct rtw89_dev *rtwdev,
> +				enum rtw89_rpwm_req_pwr_state req_pwr_state)
> +{
> +	u16 request;
> +
> +	request = rtw89_read16(rtwdev, R_AX_RPWM);
> +	request ^= request | PS_RPWM_TOGGLE;
> +
> +	rtwdev->mac.rpwm_seq_num = (rtwdev->mac.rpwm_seq_num + 1) &
> +				   RPWM_SEQ_NUM_MAX;
> +	request |= FIELD_PREP(PS_RPWM_SEQ_NUM, rtwdev->mac.rpwm_seq_num);
> +
> +	request |= req_pwr_state;
> +
> +	if (req_pwr_state < RTW89_MAC_RPWM_REQ_PWR_STATE_CLK_GATED)
> +		request |= PS_RPWM_ACK;
> +
> +	rtw89_write16(rtwdev, rtwdev->hci.rpwm_addr, request);
> +}
> +
> +static int rtw89_mac_check_cpwm_state(struct rtw89_dev *rtwdev,
> +				      enum rtw89_rpwm_req_pwr_state req_pwr_state)
> +{
> +	bool request_deep_mode;
> +	bool in_deep_mode;
> +	u8 rpwm_req_num;
> +	u8 cpwm_rsp_seq;
> +	u8 cpwm_seq;
> +	u8 cpwm_status;
> +
> +	if (req_pwr_state >= RTW89_MAC_RPWM_REQ_PWR_STATE_CLK_GATED)
> +		request_deep_mode = true;
> +	else
> +		request_deep_mode = false;
> +
> +	if (rtw89_read32_mask(rtwdev, R_AX_LDM, B_AX_LDM_32K_EN))
> +		in_deep_mode = true;
> +	else
> +		in_deep_mode = false;
> +
> +	if (request_deep_mode != in_deep_mode)
> +		return -EPERM;
> +
> +	if (request_deep_mode)
> +		return 0;
> +
> +	rpwm_req_num = rtwdev->mac.rpwm_seq_num;
> +	cpwm_rsp_seq = rtw89_read16_mask(rtwdev, R_AX_CPWM,
> +					 PS_CPWM_RSP_SEQ_NUM);
> +
> +	if (rpwm_req_num != cpwm_rsp_seq)
> +		return -EPERM;
> +
> +	rtwdev->mac.cpwm_seq_num = (rtwdev->mac.cpwm_seq_num + 1) &
> +				    CPWM_SEQ_NUM_MAX;
> +
> +	cpwm_seq = rtw89_read16_mask(rtwdev, R_AX_CPWM, PS_CPWM_SEQ_NUM);
> +	if (cpwm_seq != rtwdev->mac.cpwm_seq_num)
> +		return -EPERM;
> +
> +	cpwm_status = rtw89_read16_mask(rtwdev, R_AX_CPWM, PS_CPWM_STATE);
> +	if (cpwm_status != req_pwr_state)
> +		return -EPERM;
> +
> +	return 0;
> +}
> +
> +void rtw89_mac_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
> +{
> +	enum rtw89_rpwm_req_pwr_state state;
> +	int ret;
> +
> +	if (enter)
> +		state = rtw89_mac_get_req_pwr_state(rtwdev);
> +	else
> +		state = RTW89_MAC_RPWM_REQ_PWR_STATE_ACTIVE;
> +
> +	rtw89_mac_send_rpwm(rtwdev, state);
> +	ret = read_poll_timeout_atomic(rtw89_mac_check_cpwm_state, ret, !ret,
> +				       1000, 15000, false, rtwdev, state);
> +	if (ret)
> +		rtw89_err(rtwdev, "firmware failed to ack for %s ps mode\n",
> +			  enter ? "entering" : "leaving");
> +}
> +
> +static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
> +{
> +#define PWR_ACT 1
> +	const struct rtw89_chip_info *chip = rtwdev->chip;
> +	const struct rtw89_pwr_cfg * const *cfg_seq;
> +	struct rtw89_hal *hal = &rtwdev->hal;
> +	int ret;
> +	u8 val;
> +
> +	if (on)
> +		cfg_seq = chip->pwr_on_seq;
> +	else
> +		cfg_seq = chip->pwr_off_seq;
> +
> +	if (test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
> +		rtw89_leave_ps_mode(rtwdev);
> +
> +	val = rtw89_read8(rtwdev, 0x3F1) & 0x3;
> +	if (on && val == PWR_ACT) {
> +		rtw89_err(rtwdev, "MAC has already powered on\n");
> +		return -EBUSY;
> +	}
> +
> +	ret = rtw89_mac_pwr_seq(rtwdev, cfg_seq);
> +	if (ret)
> +		return ret;
> +
> +	if (on) {
> +		set_bit(RTW89_FLAG_POWERON, rtwdev->flags);
> +		rtw89_write8(rtwdev, R_AX_SCOREBOARD + 3, MAC_AX_NOTIFY_TP_MAJOR);
> +	} else {
> +		clear_bit(RTW89_FLAG_POWERON, rtwdev->flags);
> +		clear_bit(RTW89_FLAG_FW_RDY, rtwdev->flags);
> +		rtw89_write8(rtwdev, R_AX_SCOREBOARD + 3, MAC_AX_NOTIFY_PWR_MAJOR);
> +		hal->current_channel = 0;
> +	}
> +
> +	return 0;
> +#undef PWR_ACT
> +}
> +
> +int rtw89_mac_pwr_on(struct rtw89_dev *rtwdev)
> +{
> +	int ret;
> +
> +	ret = rtw89_mac_power_switch(rtwdev, true);
> +	if (ret) {
> +		rtw89_warn(rtwdev, "power on fail\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void rtw89_mac_pwr_off(struct rtw89_dev *rtwdev)
> +{
> +	rtw89_mac_power_switch(rtwdev, false);
> +}
> +
> +static int cmac_func_en(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
> +{
> +	u32 func_en = 0;
> +	u32 ck_en = 0;
> +	u32 c1pc_en = 0;
> +	u32 addrl_func_en[] = {R_AX_CMAC_FUNC_EN, R_AX_CMAC_FUNC_EN_C1};
> +	u32 addrl_ck_en[] = {R_AX_CK_EN, R_AX_CK_EN_C1};
> +
> +	func_en = B_AX_CMAC_EN | B_AX_CMAC_TXEN | B_AX_CMAC_RXEN |
> +			B_AX_PHYINTF_EN | B_AX_CMAC_DMA_EN | B_AX_PTCLTOP_EN |
> +			B_AX_SCHEDULER_EN | B_AX_TMAC_EN | B_AX_RMAC_EN;
> +	ck_en = B_AX_CMAC_CKEN | B_AX_PHYINTF_CKEN | B_AX_CMAC_DMA_CKEN |
> +		      B_AX_PTCLTOP_CKEN | B_AX_SCHEDULER_CKEN | B_AX_TMAC_CKEN |
> +		      B_AX_RMAC_CKEN;
> +	c1pc_en = B_AX_R_SYM_WLCMAC1_PC_EN |
> +			B_AX_R_SYM_WLCMAC1_P1_PC_EN |
> +			B_AX_R_SYM_WLCMAC1_P2_PC_EN |
> +			B_AX_R_SYM_WLCMAC1_P3_PC_EN |
> +			B_AX_R_SYM_WLCMAC1_P4_PC_EN;
> +
> +	if (en) {
> +		if (mac_idx == RTW89_MAC_1) {
> +			rtw89_write32_set(rtwdev, R_AX_AFE_CTRL1, c1pc_en);
> +			rtw89_write32_clr(rtwdev, R_AX_SYS_ISO_CTRL_EXTEND,
> +					  B_AX_R_SYM_ISO_CMAC12PP);
> +			rtw89_write32_set(rtwdev, R_AX_SYS_ISO_CTRL_EXTEND,
> +					  B_AX_CMAC1_FEN);
> +		}
> +		rtw89_write32_set(rtwdev, addrl_ck_en[mac_idx], ck_en);
> +		rtw89_write32_set(rtwdev, addrl_func_en[mac_idx], func_en);
> +	} else {
> +		rtw89_write32_clr(rtwdev, addrl_func_en[mac_idx], func_en);
> +		rtw89_write32_clr(rtwdev, addrl_ck_en[mac_idx], ck_en);
> +		if (mac_idx == RTW89_MAC_1) {
> +			rtw89_write32_clr(rtwdev, R_AX_SYS_ISO_CTRL_EXTEND,
> +					  B_AX_CMAC1_FEN);
> +			rtw89_write32_set(rtwdev, R_AX_SYS_ISO_CTRL_EXTEND,
> +					  B_AX_R_SYM_ISO_CMAC12PP);
> +			rtw89_write32_clr(rtwdev, R_AX_AFE_CTRL1, c1pc_en);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int dmac_func_en(struct rtw89_dev *rtwdev)
> +{
> +	u32 val32;
> +	u32 ret = 0;
> +
> +	val32 = (B_AX_MAC_FUNC_EN | B_AX_DMAC_FUNC_EN | B_AX_MAC_SEC_EN |
> +		 B_AX_DISPATCHER_EN | B_AX_DLE_CPUIO_EN | B_AX_PKT_IN_EN |
> +		 B_AX_DMAC_TBL_EN | B_AX_PKT_BUF_EN | B_AX_STA_SCH_EN |
> +		 B_AX_TXPKT_CTRL_EN | B_AX_WD_RLS_EN | B_AX_MPDU_PROC_EN);
> +	rtw89_write32(rtwdev, R_AX_DMAC_FUNC_EN, val32);
> +
> +	val32 = (B_AX_MAC_SEC_CLK_EN | B_AX_DISPATCHER_CLK_EN |
> +		 B_AX_DLE_CPUIO_CLK_EN | B_AX_PKT_IN_CLK_EN |
> +		 B_AX_STA_SCH_CLK_EN | B_AX_TXPKT_CTRL_CLK_EN |
> +		 B_AX_WD_RLS_CLK_EN);
> +	rtw89_write32(rtwdev, R_AX_DMAC_CLK_EN, val32);
> +
> +	return ret;
> +}
> +
> +static int chip_func_en(struct rtw89_dev *rtwdev)
> +{
> +	rtw89_write32_set(rtwdev, R_AX_SPSLDO_ON_CTRL0, B_AX_OCP_L1_MASK);
> +
> +	return 0;
> +}
> +
> +static int rtw89_mac_sys_init(struct rtw89_dev *rtwdev)
> +{
> +	int ret;
> +
> +	ret = dmac_func_en(rtwdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = cmac_func_en(rtwdev, 0, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = chip_func_en(rtwdev);
> +	if (ret)
> +		return ret;
> +
> +	return ret;
> +}
> +
> +/* PCIE 64 */
> +struct rtw89_dle_size wde_size0 = {
> +	RTW89_WDE_PG_64, 4095, 1,
> +};
> +
> +/* SDIO, PCIE STF, USB */
> +struct rtw89_dle_size wde_size1 = {
> +	RTW89_WDE_PG_64, 768, 0,
> +};
> +
> +/* PCIE 128 */
> +struct rtw89_dle_size wde_size2 = {
> +	RTW89_WDE_PG_128, 2016, 32,
> +};
> +
> +/* PCIE SU TP */
> +struct rtw89_dle_size wde_size3 = {
> +	RTW89_WDE_PG_64, 496, 3600,
> +};
> +
> +/* DLFW */
> +struct rtw89_dle_size wde_size4 = {
> +	RTW89_WDE_PG_64, 0, 4096,
> +};
> +
> +/* PCIE BCN TEST */
> +struct rtw89_dle_size wde_size5 = {
> +	RTW89_WDE_PG_64, 3904, 64,
> +};
> +
> +/* PCIE 64 */
> +struct rtw89_dle_size wde_size6 = {
> +	RTW89_WDE_PG_64, 1024, 0,
> +};
> +
> +/* PCIE 128 */
> +struct rtw89_dle_size wde_size7 = {
> +	RTW89_WDE_PG_128, 960, 0,
> +};
> +
> +/* PCIE STF, USB */
> +struct rtw89_dle_size wde_size8 = {
> +	RTW89_WDE_PG_64, 256, 0,
> +};
> +
> +/* DLFW */
> +struct rtw89_dle_size wde_size9 = {
> +	RTW89_WDE_PG_64, 0, 1024,
> +};
> +
> +/* LA-PCIE */
> +struct rtw89_dle_size wde_size10 = {
> +	RTW89_WDE_PG_64, 1408, 0,
> +};
> +
> +/* PCIE */
> +struct rtw89_dle_size ple_size0 = {
> +	RTW89_PLE_PG_128, 1520, 16,
> +};
> +
> +/* PCIE STF */
> +struct rtw89_dle_size ple_size2 = {
> +	RTW89_PLE_PG_128, 3200, 0,
> +};
> +
> +/* PCIE SU TP */
> +struct rtw89_dle_size ple_size3 = {
> +	RTW89_PLE_PG_128, 330, 1206,
> +};
> +
> +/* DLFW */
> +struct rtw89_dle_size ple_size4 = {
> +	RTW89_PLE_PG_128, 64, 1472,
> +};
> +
> +/* PCIE BCN TEST */
> +struct rtw89_dle_size ple_size5 = {
> +	RTW89_PLE_PG_128, 1520, 80,
> +};
> +
> +/* PCIE 64 */
> +struct rtw89_dle_size ple_size6 = {
> +	RTW89_PLE_PG_128, 1008, 16,
> +};
> +
> +/* PCIE STF, USB */
> +struct rtw89_dle_size ple_size7 = {
> +	RTW89_PLE_PG_128, 1408, 0,
> +};
> +
> +/* DLFW */
> +struct rtw89_dle_size ple_size8 = {
> +	RTW89_PLE_PG_128, 64, 960,
> +};
> +
> +/* PCIE 128 */
> +struct rtw89_dle_size ple_size9 = {
> +	RTW89_PLE_PG_128, 576, 0,
> +};
> +
> +/* LA-PCIE */
> +struct rtw89_dle_size ple_size10 = {
> +	RTW89_PLE_PG_128, 832, 0,
> +};
> +
> +/* PCIE 64 */
> +struct rtw89_wde_quota wde_qt0 = {
> +	3792, 196, 0, 107,
> +};
> +
> +/* SDIO, PCIE STF, USB */
> +struct rtw89_wde_quota wde_qt1 = {
> +	512, 196, 0, 60,
> +};
> +
> +/* PCIE 128 */
> +struct rtw89_wde_quota wde_qt2 = {
> +	1896, 98, 0, 22,
> +};
> +
> +/* PCIE SU TP */
> +struct rtw89_wde_quota wde_qt3 = {
> +	256, 196, 0, 44,
> +};
> +
> +/* DLFW */
> +struct rtw89_wde_quota wde_qt4 = {
> +	0, 0, 0, 0,
> +};
> +
> +/* PCIE BCN TEST */
> +struct rtw89_wde_quota wde_qt5 = {
> +	3666, 196, 0, 44,
> +};
> +
> +/* PCIE 64 */
> +struct rtw89_wde_quota wde_qt6 = {
> +	968, 48, 0, 8,
> +};
> +
> +/* PCIE 128 */
> +struct rtw89_wde_quota wde_qt7 = {
> +	896, 56, 0, 8,
> +};
> +
> +/* PCIE STF, USB */
> +struct rtw89_wde_quota wde_qt8 = {
> +	236, 16, 0, 4,
> +};
> +
> +/* LA-PCIE */
> +struct rtw89_wde_quota wde_qt9 = {
> +	1392, 8, 0, 8,
> +};
> +
> +/* PCIE DBCC */
> +struct rtw89_ple_quota ple_qt0 = {
> +	264, 66, 16, 20, 26, 13, 356, 89, 32, 40, 8,
> +};
> +
> +/* PCIE DBCC */
> +struct rtw89_ple_quota ple_qt1 = {
> +	264, 66, 32, 20, 64, 13, 946, 679, 64, 128, 320,
> +};
> +
> +/* PCIE SCC */
> +struct rtw89_ple_quota ple_qt4 = {
> +	264, 0, 16, 20, 26, 13, 356, 0, 32, 40, 8,
> +};
> +
> +/* PCIE SCC */
> +struct rtw89_ple_quota ple_qt5 = {
> +	264, 0, 32, 20, 64, 13, 1101, 0, 64, 128, 120,
> +};
> +
> +/* PCIE STF SCC */
> +struct rtw89_ple_quota ple_qt8 = {
> +	1536, 0, 16, 20, 13, 13, 356, 0, 32, 40, 8,
> +};
> +
> +/* PCIE STF SCC */
> +struct rtw89_ple_quota ple_qt9 = {
> +	2702, 0, 32, 20, 64, 13, 1522, 0, 64, 128, 320,
> +};
> +
> +/* PCIE STF DBCC */
> +struct rtw89_ple_quota ple_qt10 = {
> +	2272, 0, 16, 20, 26, 13, 356, 89, 32, 40, 8
> +};
> +
> +/* PCIE STF DBCC */
> +struct rtw89_ple_quota ple_qt11 = {
> +	2600, 0, 32, 20, 64, 13, 684, 417, 64, 128, 320
> +};
> +
> +/* PCIE SU TP */
> +struct rtw89_ple_quota ple_qt12 = {
> +	50, 50, 16, 20, 26, 26, 25, 25, 32, 40, 20
> +};
> +
> +/* DLFW */
> +struct rtw89_ple_quota ple_qt13 = {
> +	0, 0, 16, 48, 0, 0, 0, 0, 0, 0, 0
> +};
> +
> +/* PCIE BCN TEST */
> +struct rtw89_ple_quota ple_qt14 = {
> +	588, 147, 16, 20, 26, 26, 356, 89, 32, 40, 80,
> +};
> +
> +/* PCIE BCN TEST */
> +struct rtw89_ple_quota ple_qt15 = {
> +	688, 247, 116, 20, 64, 126, 456, 189, 64, 128, 80,
> +};
> +
> +/* USB DBCC */
> +struct rtw89_ple_quota ple_qt16 = {
> +	2048, 0, 16, 48, 26, 26, 360, 90, 32, 40, 1,
> +};
> +
> +/* PCIE 64 */
> +struct rtw89_ple_quota ple_qt18 = {
> +	66, 0, 16, 20, 13, 13, 178, 0, 32, 14, 8,
> +};
> +
> +/* PCIE 64 */
> +struct rtw89_ple_quota ple_qt19 = {
> +	66, 0, 32, 20, 661, 13, 826, 0, 680, 14, 64,
> +};
> +
> +/* PCIE STF */
> +struct rtw89_ple_quota ple_qt20 = {
> +	962, 0, 16, 20, 80, 13, 178, 0, 32, 14, 8,
> +};
> +
> +/* PCIE STF */
> +struct rtw89_ple_quota ple_qt21 = {
> +	1047, 0, 32, 20, 165, 13, 263, 0, 117, 14, 64,
> +};
> +
> +/* PCIE 128 */
> +struct rtw89_ple_quota ple_qt22 = {
> +	269, 0, 18, 20, 15, 28, 180, 0, 34, 14, 8,
> +};
> +
> +/* LA-PCIE MIN*/
> +struct rtw89_ple_quota ple_qt23 = {
> +	156, 39, 16, 20, 26, 26, 356, 89, 32, 40, 1,
> +};
> +
> +/* LA-PCIE MAX*/
> +struct rtw89_ple_quota ple_qt24 = {
> +	187, 70, 47, 20, 64, 57, 387, 120, 64, 128, 1,
> +};
> +
> +static struct rtw89_dle_mem *get_dle_mem_cfg(struct rtw89_dev *rtwdev,
> +					     enum rtw89_qta_mode mode)
> +{
> +	struct rtw89_mac_info *mac = &rtwdev->mac;
> +	struct rtw89_dle_mem *cfg;
> +
> +	cfg = &rtwdev->chip->dle_mem[mode];
> +	if (!cfg)
> +		return NULL;
> +
> +	if (cfg->mode != mode) {
> +		rtw89_warn(rtwdev, "qta mode unmatch!\n");
> +		return NULL;
> +	}
> +
> +	mac->dle_info.wde_pg_size = cfg->wde_size->pge_size;
> +	mac->dle_info.ple_pg_size = cfg->ple_size->pge_size;
> +	mac->dle_info.qta_mode = mode;
> +	mac->dle_info.c0_rx_qta = cfg->ple_min_qt->cma0_dma;
> +	mac->dle_info.c1_rx_qta = cfg->ple_min_qt->cma1_dma;
> +
> +	return cfg;
> +}
> +
> +static inline u32 dle_used_size(struct rtw89_dle_size *wde,
> +				struct rtw89_dle_size *ple)
> +{
> +	return wde->pge_size * (wde->lnk_pge_num + wde->unlnk_pge_num) +
> +	       ple->pge_size * (ple->lnk_pge_num + ple->unlnk_pge_num);
> +}
> +
> +static void dle_func_en(struct rtw89_dev *rtwdev, bool enable)
> +{
> +	if (enable)
> +		rtw89_write32_set(rtwdev, R_AX_DMAC_FUNC_EN,
> +				  B_AX_DLE_WDE_EN | B_AX_DLE_PLE_EN);
> +	else
> +		rtw89_write32_clr(rtwdev, R_AX_DMAC_FUNC_EN,
> +				  B_AX_DLE_WDE_EN | B_AX_DLE_PLE_EN);
> +}
> +
> +static void dle_clk_en(struct rtw89_dev *rtwdev, bool enable)
> +{
> +	if (enable)
> +		rtw89_write32_set(rtwdev, R_AX_DMAC_CLK_EN,
> +				  B_AX_DLE_WDE_CLK_EN | B_AX_DLE_PLE_CLK_EN);
> +	else
> +		rtw89_write32_clr(rtwdev, R_AX_DMAC_CLK_EN,
> +				  B_AX_DLE_WDE_CLK_EN | B_AX_DLE_PLE_CLK_EN);
> +}
> +
> +static int dle_mix_cfg(struct rtw89_dev *rtwdev, struct rtw89_dle_mem *cfg)
> +{
> +	struct rtw89_dle_size *size_cfg;
> +	u32 val;
> +	u8 bound = 0;
> +
> +	val = rtw89_read32(rtwdev, R_AX_WDE_PKTBUF_CFG);
> +	size_cfg = cfg->wde_size;
> +
> +	switch (size_cfg->pge_size) {
> +	default:
> +	case RTW89_WDE_PG_64:
> +		val = u32_replace_bits(val, S_AX_WDE_PAGE_SEL_64,
> +				       B_AX_WDE_PAGE_SEL_MASK);
> +		break;
> +	case RTW89_WDE_PG_128:
> +		val = u32_replace_bits(val, S_AX_WDE_PAGE_SEL_128,
> +				       B_AX_WDE_PAGE_SEL_MASK);
> +		break;
> +	case RTW89_WDE_PG_256:
> +		rtw89_err(rtwdev, "[ERR]WDE DLE doesn't support 256 byte!\n");
> +		return -EINVAL;
> +	}
> +
> +	val = u32_replace_bits(val, bound, B_AX_WDE_START_BOUND_MASK);
> +	val = u32_replace_bits(val, size_cfg->lnk_pge_num,
> +			       B_AX_WDE_FREE_PAGE_NUM_MASK);
> +	rtw89_write32(rtwdev, R_AX_WDE_PKTBUF_CFG, val);
> +
> +	val = rtw89_read32(rtwdev, R_AX_PLE_PKTBUF_CFG);
> +	bound = (size_cfg->lnk_pge_num + size_cfg->unlnk_pge_num)
> +				* size_cfg->pge_size / DLE_BOUND_UNIT;
> +	size_cfg = cfg->ple_size;
> +
> +	switch (size_cfg->pge_size) {
> +	default:
> +	case RTW89_PLE_PG_64:
> +		rtw89_err(rtwdev, "[ERR]PLE DLE doesn't support 64 byte!\n");
> +		return -EINVAL;
> +	case RTW89_PLE_PG_128:
> +		val = u32_replace_bits(val, S_AX_PLE_PAGE_SEL_128,
> +				       B_AX_PLE_PAGE_SEL_MASK);
> +		break;
> +	case RTW89_PLE_PG_256:
> +		val = u32_replace_bits(val, S_AX_PLE_PAGE_SEL_256,
> +				       B_AX_PLE_PAGE_SEL_MASK);
> +		break;
> +	}
> +
> +	val = u32_replace_bits(val, bound, B_AX_PLE_START_BOUND_MASK);
> +	val = u32_replace_bits(val, size_cfg->lnk_pge_num,
> +			       B_AX_PLE_FREE_PAGE_NUM_MASK);
> +	rtw89_write32(rtwdev, R_AX_PLE_PKTBUF_CFG, val);
> +
> +	return 0;
> +}
> +
> +#define SET_QUOTA(_x, _module, _idx)					\
> +	do {								\
> +		val = (min_cfg->_x &					\
> +		       B_AX_ ## _module ## _MIN_SIZE_MASK) |		\
> +		      ((max_cfg->_x << 16) &				\
> +		       B_AX_ ## _module ## _MAX_SIZE_MASK);		\
> +		rtw89_write32(rtwdev,					\
> +			      R_AX_ ## _module ## _QTA ## _idx ## _CFG,	\
> +			      val);					\
> +	} while (0)
> +
> +static void wde_quota_cfg(struct rtw89_dev *rtwdev,
> +			  struct rtw89_wde_quota *min_cfg,
> +			  struct rtw89_wde_quota *max_cfg)
> +{
> +	u32 val;
> +
> +	SET_QUOTA(hif, WDE, 0);
> +	SET_QUOTA(wcpu, WDE, 1);
> +	SET_QUOTA(pkt_in, WDE, 3);
> +	SET_QUOTA(cpu_io, WDE, 4);
> +}
> +
> +static void ple_quota_cfg(struct rtw89_dev *rtwdev,
> +			  struct rtw89_ple_quota *min_cfg,
> +			  struct rtw89_ple_quota *max_cfg)
> +{
> +	u32 val;
> +
> +	SET_QUOTA(cma0_tx, PLE, 0);
> +	SET_QUOTA(cma1_tx, PLE, 1);
> +	SET_QUOTA(c2h, PLE, 2);
> +	SET_QUOTA(h2c, PLE, 3);
> +	SET_QUOTA(wcpu, PLE, 4);
> +	SET_QUOTA(mpdu_proc, PLE, 5);
> +	SET_QUOTA(cma0_dma, PLE, 6);
> +	SET_QUOTA(cma1_dma, PLE, 7);
> +	SET_QUOTA(bb_rpt, PLE, 8);
> +	SET_QUOTA(wd_rel, PLE, 9);
> +	SET_QUOTA(cpu_io, PLE, 10);
> +}
> +
> +#undef SET_QUOTA
> +
> +static void dle_quota_cfg(struct rtw89_dev *rtwdev, struct rtw89_dle_mem *cfg)
> +{
> +	wde_quota_cfg(rtwdev, cfg->wde_min_qt, cfg->wde_max_qt);
> +	ple_quota_cfg(rtwdev, cfg->ple_min_qt, cfg->ple_max_qt);
> +}
> +
> +static u32 dle_rsvd_size(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
> +{
> +	if (mode != RTW89_QTA_LAMODE)
> +		return 0;
> +
> +	return rtwdev->chip->dle_lamode_size;
> +}
> +
> +static int dle_init(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
> +		    enum rtw89_qta_mode ext_mode)
> +{
> +	struct rtw89_dle_mem *cfg, *ext_cfg;
> +	int ret = 0;
> +	u32 ini;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	cfg = get_dle_mem_cfg(rtwdev, mode);
> +	if (!cfg) {
> +		rtw89_err(rtwdev, "[ERR]get_dle_mem_cfg\n");
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	if (mode == RTW89_QTA_DLFW) {
> +		ext_cfg = get_dle_mem_cfg(rtwdev, ext_mode);
> +		if (!ext_cfg) {
> +			rtw89_err(rtwdev, "[ERR]get_dle_ext_mem_cfg %d\n",
> +				  ext_mode);
> +			ret = -EINVAL;
> +			goto error;
> +		}
> +		cfg->wde_min_qt->wcpu = ext_cfg->wde_min_qt->wcpu;
> +	}
> +
> +	if (dle_used_size(cfg->wde_size, cfg->ple_size) !=
> +	    (rtwdev->chip->fifo_size - dle_rsvd_size(rtwdev, mode))) {
> +		rtw89_err(rtwdev, "[ERR]wd/dle mem cfg\n");
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	dle_func_en(rtwdev, false);
> +	dle_clk_en(rtwdev, true);
> +
> +	ret = dle_mix_cfg(rtwdev, cfg);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR] dle mix cfg\n");
> +		goto error;
> +	}
> +	dle_quota_cfg(rtwdev, cfg);
> +
> +	dle_func_en(rtwdev, true);
> +
> +	ret = read_poll_timeout(rtw89_read32, ini,
> +				(ini & WDE_MGN_INI_RDY) == WDE_MGN_INI_RDY, 1,
> +				2000, false, rtwdev, R_AX_WDE_INI_STATUS);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]WDE cfg ready\n");
> +		return ret;
> +	}
> +
> +	ret = read_poll_timeout(rtw89_read32, ini,
> +				(ini & WDE_MGN_INI_RDY) == WDE_MGN_INI_RDY, 1,
> +				2000, false, rtwdev, R_AX_PLE_INI_STATUS);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]PLE cfg ready\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +error:
> +	dle_func_en(rtwdev, false);
> +	rtw89_err(rtwdev, "[ERR]trxcfg wde 0x8900 = %x\n",
> +		  rtw89_read32(rtwdev, R_AX_WDE_INI_STATUS));
> +	rtw89_err(rtwdev, "[ERR]trxcfg ple 0x8D00 = %x\n",
> +		  rtw89_read32(rtwdev, R_AX_PLE_INI_STATUS));
> +
> +	return ret;
> +}
> +
> +static bool dle_is_txq_empty(struct rtw89_dev *rtwdev)
> +{
> +	u32 msk32;
> +	u32 val32;
> +
> +	msk32 = B_AX_WDE_EMPTY_QUE_CMAC0_ALL_AC | B_AX_WDE_EMPTY_QUE_CMAC0_MBH |
> +		B_AX_WDE_EMPTY_QUE_CMAC1_MBH | B_AX_WDE_EMPTY_QUE_CMAC0_WMM0 |
> +		B_AX_WDE_EMPTY_QUE_CMAC0_WMM1 | B_AX_WDE_EMPTY_QUE_OTHERS |
> +		B_AX_PLE_EMPTY_QUE_DMAC_MPDU_TX | B_AX_PLE_EMPTY_QTA_DMAC_H2C |
> +		B_AX_PLE_EMPTY_QUE_DMAC_SEC_TX | B_AX_WDE_EMPTY_QUE_DMAC_PKTIN |
> +		B_AX_WDE_EMPTY_QTA_DMAC_HIF | B_AX_WDE_EMPTY_QTA_DMAC_WLAN_CPU |
> +		B_AX_WDE_EMPTY_QTA_DMAC_PKTIN | B_AX_WDE_EMPTY_QTA_DMAC_CPUIO |
> +		B_AX_PLE_EMPTY_QTA_DMAC_B0_TXPL |
> +		B_AX_PLE_EMPTY_QTA_DMAC_B1_TXPL |
> +		B_AX_PLE_EMPTY_QTA_DMAC_MPDU_TX |
> +		B_AX_PLE_EMPTY_QTA_DMAC_CPUIO |
> +		B_AX_WDE_EMPTY_QTA_DMAC_DATA_CPU |
> +		B_AX_PLE_EMPTY_QTA_DMAC_WLAN_CPU;
> +	val32 = rtw89_read32(rtwdev, R_AX_DLE_EMPTY0);
> +
> +	if ((val32 & msk32) == msk32)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int sta_sch_init(struct rtw89_dev *rtwdev)
> +{
> +	u32 p_val;
> +	u8 val;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	val = rtw89_read8(rtwdev, R_AX_SS_CTRL);
> +	val |= B_AX_SS_EN;
> +	rtw89_write8(rtwdev, R_AX_SS_CTRL, val);
> +
> +	ret = read_poll_timeout(rtw89_read32, p_val, p_val & B_AX_SS_INIT_DONE_1,
> +				1, TRXCFG_WAIT_CNT, false, rtwdev, R_AX_SS_CTRL);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]STA scheduler init\n");
> +		return ret;
> +	}
> +
> +	rtw89_write32_set(rtwdev, R_AX_SS_CTRL, B_AX_SS_WARM_INIT_FLG);
> +
> +	return 0;
> +}
> +
> +static int mpdu_proc_init(struct rtw89_dev *rtwdev)
> +{
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	rtw89_write32(rtwdev, R_AX_ACTION_FWD0, TRXCFG_MPDU_PROC_ACT_FRWD);
> +	rtw89_write32(rtwdev, R_AX_TF_FWD, TRXCFG_MPDU_PROC_TF_FRWD);
> +	rtw89_write32_set(rtwdev, R_AX_MPDU_PROC,
> +			  B_AX_APPEND_FCS | B_AX_A_ICV_ERR);
> +	rtw89_write32(rtwdev, R_AX_CUT_AMSDU_CTRL, TRXCFG_MPDU_PROC_CUT_CTRL);
> +
> +	return 0;
> +}
> +
> +static int sec_eng_init(struct rtw89_dev *rtwdev)
> +{
> +	u32 val = 0;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	val = rtw89_read32(rtwdev, R_AX_SEC_ENG_CTRL);
> +	/* init clock */
> +	val |= (B_AX_CLK_EN_CGCMP | B_AX_CLK_EN_WAPI | B_AX_CLK_EN_WEP_TKIP);
> +	/* init TX encryption */
> +	val |= (B_AX_SEC_TX_ENC | B_AX_SEC_RX_DEC);
> +	val |= (B_AX_MC_DEC | B_AX_BC_DEC);
> +	val &= ~B_AX_TX_PARTIAL_MODE;
> +	rtw89_write32(rtwdev, R_AX_SEC_ENG_CTRL, val);
> +
> +	/* init MIC ICV append */
> +	val = rtw89_read32(rtwdev, R_AX_SEC_MPDU_PROC);
> +	val |= (B_AX_APPEND_ICV | B_AX_APPEND_MIC);
> +
> +	/* option init */
> +	rtw89_write32(rtwdev, R_AX_SEC_MPDU_PROC, val);
> +
> +	return 0;
> +}
> +
> +static int dmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
> +{
> +	int ret;
> +
> +	ret = dle_init(rtwdev, rtwdev->mac.qta_mode, RTW89_QTA_INVALID);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]DLE init %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = hfc_init(rtwdev, true, true, true);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]HCI FC init %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = sta_sch_init(rtwdev);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]STA SCH init %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = mpdu_proc_init(rtwdev);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]MPDU Proc init %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = sec_eng_init(rtwdev);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]Security Engine init %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int addr_cam_init(struct rtw89_dev *rtwdev, u8 mac_idx)
> +{
> +	u32 val, reg;
> +	u16 p_val;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_ADDR_CAM_CTRL, mac_idx);
> +
> +	val = rtw89_read32(rtwdev, reg);
> +	val |= u32_encode_bits(0x7f, B_AX_ADDR_CAM_RANGE_MASK) |
> +	       B_AX_ADDR_CAM_CLR | B_AX_ADDR_CAM_EN;
> +	rtw89_write32(rtwdev, reg, val);
> +
> +	ret = read_poll_timeout(rtw89_read16, p_val, !(p_val & B_AX_ADDR_CAM_CLR),
> +				1, TRXCFG_WAIT_CNT, false, rtwdev, B_AX_ADDR_CAM_CLR);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]ADDR_CAM reset\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int scheduler_init(struct rtw89_dev *rtwdev, u8 mac_idx)
> +{
> +	u32 ret;
> +	u32 reg;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_PREBKF_CFG_0, mac_idx);
> +	rtw89_write32_mask(rtwdev, reg, B_AX_PREBKF_TIME_MASK, SCH_PREBKF_24US);
> +
> +	return 0;
> +}
> +
> +static int rtw89_mac_typ_fltr_opt(struct rtw89_dev *rtwdev,
> +				  enum rtw89_machdr_frame_type type,
> +				  enum rtw89_mac_fwd_target fwd_target,
> +				  u8 mac_idx)
> +{
> +	u32 reg;
> +	u32 val;
> +
> +	switch (fwd_target) {
> +	case RTW89_FWD_DONT_CARE:
> +		val = RX_FLTR_FRAME_DROP;
> +		break;
> +	case RTW89_FWD_TO_HOST:
> +		val = RX_FLTR_FRAME_TO_HOST;
> +		break;
> +	case RTW89_FWD_TO_WLAN_CPU:
> +		val = RX_FLTR_FRAME_TO_WLCPU;
> +		break;
> +	default:
> +		rtw89_err(rtwdev, "[ERR]set rx filter fwd target err\n");
> +		return -EINVAL;
> +	}
> +
> +	switch (type) {
> +	case RTW89_MGNT:
> +		reg = rtw89_mac_reg_by_idx(R_AX_MGNT_FLTR, mac_idx);
> +		break;
> +	case RTW89_CTRL:
> +		reg = rtw89_mac_reg_by_idx(R_AX_CTRL_FLTR, mac_idx);
> +		break;
> +	case RTW89_DATA:
> +		reg = rtw89_mac_reg_by_idx(R_AX_DATA_FLTR, mac_idx);
> +		break;
> +	default:
> +		rtw89_err(rtwdev, "[ERR]set rx filter type err\n");
> +		return -EINVAL;
> +	}
> +	rtw89_write32(rtwdev, reg, val);
> +
> +	return 0;
> +}
> +
> +static int rx_fltr_init(struct rtw89_dev *rtwdev, u8 mac_idx)
> +{
> +	int ret, i;
> +	u32 mac_ftlr, plcp_ftlr;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	for (i = RTW89_MGNT; i <= RTW89_DATA; i++) {
> +		ret = rtw89_mac_typ_fltr_opt(rtwdev, i, RTW89_FWD_TO_HOST,
> +					     mac_idx);
> +		if (ret)
> +			return ret;
> +	}
> +	mac_ftlr = rtwdev->hal.rx_fltr;
> +	plcp_ftlr = B_AX_CCK_CRC_CHK | B_AX_CCK_SIG_CHK |
> +		    B_AX_LSIG_PARITY_CHK | B_AX_SIGA_CRC_CHK |
> +		    B_AX_VHT_SU_SIGB_CRC_CHK | B_AX_VHT_MU_SIGB_CRC_CHK |
> +		    B_AX_HE_SIGB_CRC_CHK;
> +	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(R_AX_RX_FLTR_OPT, mac_idx),
> +		      mac_ftlr);
> +	rtw89_write16(rtwdev, rtw89_mac_reg_by_idx(R_AX_PLCP_HDR_FLTR, mac_idx),
> +		      plcp_ftlr);
> +
> +	return 0;
> +}
> +
> +static int cca_ctrl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
> +{
> +	u32 val, reg;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_CCA_CONTROL, mac_idx);
> +	val = rtw89_read32(rtwdev, reg);
> +	val |= (B_AX_TB_CHK_BASIC_NAV | B_AX_TB_CHK_BTCCA |
> +		B_AX_TB_CHK_EDCCA | B_AX_TB_CHK_CCA_P20 |
> +		B_AX_SIFS_CHK_BTCCA | B_AX_SIFS_CHK_CCA_P20 |
> +		B_AX_CTN_CHK_TXNAV | B_AX_CTN_CHK_INTRA_NAV |
> +		B_AX_CTN_CHK_BASIC_NAV | B_AX_CTN_CHK_BTCCA |
> +		B_AX_CTN_CHK_EDCCA | B_AX_CTN_CHK_CCA_S80 |
> +		B_AX_CTN_CHK_CCA_S40 | B_AX_CTN_CHK_CCA_S20 |
> +		B_AX_CTN_CHK_CCA_P20);
> +	val &= ~(B_AX_TB_CHK_TX_NAV | B_AX_TB_CHK_CCA_S80 |
> +		 B_AX_TB_CHK_CCA_S40 | B_AX_TB_CHK_CCA_S20 |
> +		 B_AX_SIFS_CHK_CCA_S80 | B_AX_SIFS_CHK_CCA_S40 |
> +		 B_AX_SIFS_CHK_CCA_S20 | B_AX_SIFS_CHK_EDCCA);
> +	rtw89_write32(rtwdev, reg, val);
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_RSP_CHK_SIG, mac_idx);
> +	val = rtw89_read32(rtwdev, reg);
> +	val |= (B_AX_RSP_CHK_TX_NAV | B_AX_RSP_CHK_INTRA_NAV |
> +		B_AX_RSP_CHK_BASIC_NAV | B_AX_RSP_CHK_SEC_CCA_80 |
> +		B_AX_RSP_CHK_SEC_CCA_40 | B_AX_RSP_CHK_SEC_CCA_20 |
> +		B_AX_RSP_CHK_BTCCA | B_AX_RSP_CHK_EDCCA |
> +		B_AX_RSP_CHK_CCA);
> +	rtw89_write32(rtwdev, reg, val);
> +
> +	return 0;
> +}
> +
> +static int spatial_reuse_init(struct rtw89_dev *rtwdev, u8 mac_idx)
> +{
> +	u32 reg;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +	reg = rtw89_mac_reg_by_idx(R_AX_RX_SR_CTRL, mac_idx);
> +	rtw89_write8_clr(rtwdev, reg, B_AX_SR_EN);
> +
> +	return 0;
> +}
> +
> +static int tmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
> +{
> +	u32 reg;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_MAC_LOOPBACK, mac_idx);
> +	rtw89_write32_clr(rtwdev, reg, B_AX_MACLBK_EN);
> +
> +	return 0;
> +}
> +
> +static int trxptcl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
> +{
> +	u32 reg, val, sifs;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_0, mac_idx);
> +	val = rtw89_read32(rtwdev, reg);
> +	val &= ~B_AX_WMAC_SPEC_SIFS_CCK_MASK;
> +	val |= FIELD_PREP(B_AX_WMAC_SPEC_SIFS_CCK_MASK, WMAC_SPEC_SIFS_CCK);
> +
> +	switch (rtwdev->chip->chip_id) {
> +	case RTL8852A:
> +		sifs = WMAC_SPEC_SIFS_OFDM_52A;
> +		break;
> +	case RTL8852B:
> +		sifs = WMAC_SPEC_SIFS_OFDM_52B;
> +		break;
> +	default:
> +		sifs = WMAC_SPEC_SIFS_OFDM_52C;
> +		break;
> +	}
> +	val &= ~B_AX_WMAC_SPEC_SIFS_OFDM_MASK;
> +	val |= FIELD_PREP(B_AX_WMAC_SPEC_SIFS_OFDM_MASK, sifs);
> +	rtw89_write32(rtwdev, reg, val);
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_RXTRIG_TEST_USER_2, mac_idx);
> +	rtw89_write32_set(rtwdev, reg, B_AX_RXTRIG_FCSCHK_EN);
> +
> +	return 0;
> +}
> +
> +static int rmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
> +{
> +#define TRXCFG_RMAC_CCA_TO	32
> +#define TRXCFG_RMAC_DATA_TO	15
> +#define RX_MAX_LEN_UNIT 512
> +#define PLD_RLS_MAX_PG 127
> +	int ret;
> +	u32 reg, rx_max_len, rx_qta;
> +	u16 val;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_RESPBA_CAM_CTRL, mac_idx);
> +	rtw89_write8_set(rtwdev, reg, B_AX_SSN_SEL);
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_DLK_PROTECT_CTL, mac_idx);
> +	val = rtw89_read16(rtwdev, reg);
> +	val = u16_replace_bits(val, TRXCFG_RMAC_DATA_TO,
> +			       B_AX_RX_DLK_DATA_TIME_MASK);
> +	val = u16_replace_bits(val, TRXCFG_RMAC_CCA_TO,
> +			       B_AX_RX_DLK_CCA_TIME_MASK);
> +	rtw89_write16(rtwdev, reg, val);
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_RCR, mac_idx);
> +	rtw89_write8_mask(rtwdev, reg, B_AX_CH_EN_MASK, 0x1);
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_RX_FLTR_OPT, mac_idx);
> +	if (mac_idx == RTW89_MAC_0)
> +		rx_qta = rtwdev->mac.dle_info.c0_rx_qta;
> +	else
> +		rx_qta = rtwdev->mac.dle_info.c1_rx_qta;
> +	rx_qta = rx_qta > PLD_RLS_MAX_PG ? PLD_RLS_MAX_PG : rx_qta;
> +	rx_max_len = (rx_qta - 1) * rtwdev->mac.dle_info.ple_pg_size /
> +		     RX_MAX_LEN_UNIT;
> +	rx_max_len = rx_max_len > B_AX_RX_MPDU_MAX_LEN_SIZE ?
> +		     B_AX_RX_MPDU_MAX_LEN_SIZE : rx_max_len;
> +	rtw89_write32_mask(rtwdev, reg, B_AX_RX_MPDU_MAX_LEN_MASK, rx_max_len);
> +
> +	if (rtwdev->chip->chip_id == RTL8852A &&
> +	    rtwdev->hal.cv == CHIP_CBV) {
> +		rtw89_write16_mask(rtwdev,
> +				   rtw89_mac_reg_by_idx(R_AX_DLK_PROTECT_CTL, mac_idx),
> +				   B_AX_RX_DLK_CCA_TIME_MASK, 0);
> +		rtw89_write16_set(rtwdev, rtw89_mac_reg_by_idx(R_AX_RCR, mac_idx),
> +				  BIT(12));
> +	}
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_PLCP_HDR_FLTR, mac_idx);
> +	rtw89_write8_clr(rtwdev, reg, B_AX_VHT_SU_SIGB_CRC_CHK);
> +
> +	return ret;
> +}
> +
> +static int cmac_com_init(struct rtw89_dev *rtwdev, u8 mac_idx)
> +{
> +	u32 val, reg;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_TX_SUB_CARRIER_VALUE, mac_idx);
> +	val = rtw89_read32(rtwdev, reg);
> +	val = u32_replace_bits(val, 0, B_AX_TXSC_20M_MASK);
> +	val = u32_replace_bits(val, 0, B_AX_TXSC_40M_MASK);
> +	val = u32_replace_bits(val, 0, B_AX_TXSC_80M_MASK);
> +	rtw89_write32(rtwdev, reg, val);
> +
> +	return 0;
> +}
> +
> +static bool is_qta_dbcc(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
> +{
> +	struct rtw89_dle_mem *cfg;
> +
> +	cfg = get_dle_mem_cfg(rtwdev, mode);
> +	if (!cfg) {
> +		rtw89_err(rtwdev, "[ERR]get_dle_mem_cfg\n");
> +		return false;
> +	}
> +
> +	return (cfg->ple_min_qt->cma1_dma && cfg->ple_max_qt->cma1_dma);
> +}
> +
> +static bool is_qta_poh(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
> +{
> +	return !(mode == RTW89_QTA_SCC_STF || mode == RTW89_QTA_DBCC_STF);
> +}
> +
> +static int ptcl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
> +{
> +	u32 val, reg;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	if (rtwdev->hci.type != RTW89_HCI_TYPE_PCIE)
> +		goto end;
> +
> +	if (is_qta_poh(rtwdev, rtwdev->mac.qta_mode)) {
> +		reg = rtw89_mac_reg_by_idx(R_AX_SIFS_SETTING, mac_idx);
> +		val = rtw89_read32(rtwdev, reg);
> +		val = u32_replace_bits(val, S_AX_CTS2S_TH_1K,
> +				       B_AX_HW_CTS2SELF_PKT_LEN_TH_MASK);
> +		val |= B_AX_HW_CTS2SELF_EN;
> +		rtw89_write32(rtwdev, reg, val);
> +
> +		reg = rtw89_mac_reg_by_idx(R_AX_PTCL_FSM_MON, mac_idx);
> +		val = rtw89_read32(rtwdev, reg);
> +		val = u32_replace_bits(val, S_AX_PTCL_TO_2MS, B_AX_PTCL_TX_ARB_TO_THR_MASK);
> +		val &= ~B_AX_PTCL_TX_ARB_TO_MODE;
> +		rtw89_write32(rtwdev, reg, val);
> +	}
> +
> +end:
> +	reg = rtw89_mac_reg_by_idx(R_AX_SIFS_SETTING, mac_idx);
> +	val = rtw89_read32(rtwdev, reg);
> +	val = u32_replace_bits(val, S_AX_CTS2S_TH_SEC_256B, B_AX_HW_CTS2SELF_PKT_LEN_TH_TWW_MASK);
> +	val |= B_AX_HW_CTS2SELF_EN;
> +	rtw89_write32(rtwdev, reg, val);
> +
> +	return 0;
> +}
> +
> +static int cmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
> +{
> +	int ret;
> +
> +	ret = scheduler_init(rtwdev, mac_idx);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]CMAC%d SCH init %d\n", mac_idx, ret);
> +		return ret;
> +	}
> +
> +	ret = addr_cam_init(rtwdev, mac_idx);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]CMAC%d ADDR_CAM reset %d\n", mac_idx,
> +			  ret);
> +		return ret;
> +	}
> +
> +	ret = rx_fltr_init(rtwdev, mac_idx);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]CMAC%d RX filter init %d\n", mac_idx,
> +			  ret);
> +		return ret;
> +	}
> +
> +	ret = cca_ctrl_init(rtwdev, mac_idx);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]CMAC%d CCA CTRL init %d\n", mac_idx,
> +			  ret);
> +		return ret;
> +	}
> +
> +	ret = spatial_reuse_init(rtwdev, mac_idx);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]CMAC%d Spatial Reuse init %d\n",
> +			  mac_idx, ret);
> +		return ret;
> +	}
> +
> +	ret = tmac_init(rtwdev, mac_idx);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]CMAC%d TMAC init %d\n", mac_idx, ret);
> +		return ret;
> +	}
> +
> +	ret = trxptcl_init(rtwdev, mac_idx);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]CMAC%d TRXPTCL init %d\n", mac_idx, ret);
> +		return ret;
> +	}
> +
> +	ret = rmac_init(rtwdev, mac_idx);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]CMAC%d RMAC init %d\n", mac_idx, ret);
> +		return ret;
> +	}
> +
> +	ret = cmac_com_init(rtwdev, mac_idx);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]CMAC%d Com init %d\n", mac_idx, ret);
> +		return ret;
> +	}
> +
> +	ret = ptcl_init(rtwdev, mac_idx);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]CMAC%d PTCL init %d\n", mac_idx, ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int rtw89_hw_sch_tx_en_h2c(struct rtw89_dev *rtwdev, u8 band,
> +				  u16 tx_en_u16, u16 mask_u16)
> +{
> +	u32 ret;
> +	struct rtw89_mac_c2h_info c2h_info = {0};
> +	struct rtw89_mac_h2c_info h2c_info = {0};
> +	struct rtw89_h2creg_sch_tx_en *h2creg =
> +		(struct rtw89_h2creg_sch_tx_en *)h2c_info.h2creg;
> +
> +	h2c_info.id = RTW89_FWCMD_H2CREG_FUNC_SCH_TX_EN;
> +	h2c_info.content_len = sizeof(*h2creg) - RTW89_H2CREG_HDR_LEN;
> +	h2creg->tx_en = tx_en_u16;
> +	h2creg->mask = mask_u16;
> +	h2creg->band = band;
> +
> +	ret = rtw89_fw_msg_reg(rtwdev, &h2c_info, &c2h_info);
> +	if (ret)
> +		return ret;
> +
> +	if (c2h_info.id != RTW89_FWCMD_C2HREG_FUNC_TX_PAUSE_RPT)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int rtw89_set_hw_sch_tx_en(struct rtw89_dev *rtwdev, u8 mac_idx,
> +				  u16 tx_en, u16 tx_en_mask)
> +{
> +	u32 reg = rtw89_mac_reg_by_idx(R_AX_CTN_TXEN, mac_idx);
> +	u16 val;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	if (test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
> +		return rtw89_hw_sch_tx_en_h2c(rtwdev, mac_idx,
> +					      tx_en, tx_en_mask);
> +
> +	val = rtw89_read16(rtwdev, reg);
> +	val = (val & ~tx_en_mask) | (tx_en & tx_en_mask);
> +	rtw89_write16(rtwdev, reg, val);
> +
> +	return 0;
> +}
> +
> +int rtw89_mac_stop_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx,
> +			  u16 *tx_en, enum rtw89_sch_tx_sel sel)
> +{
> +	int ret;
> +
> +	*tx_en = rtw89_read16(rtwdev,
> +			      rtw89_mac_reg_by_idx(R_AX_CTN_TXEN, mac_idx));
> +
> +	switch (sel) {
> +	case RTW89_SCH_TX_SEL_ALL:
> +		ret = rtw89_set_hw_sch_tx_en(rtwdev, mac_idx, 0, 0xffff);
> +		if (ret)
> +			return ret;
> +		break;
> +	case RTW89_SCH_TX_SEL_HIQ:
> +		ret = rtw89_set_hw_sch_tx_en(rtwdev, mac_idx,
> +					     0, B_AX_CTN_TXEN_HGQ);
> +		if (ret)
> +			return ret;
> +		break;
> +	case RTW89_SCH_TX_SEL_MG0:
> +		ret = rtw89_set_hw_sch_tx_en(rtwdev, mac_idx,
> +					     0, B_AX_CTN_TXEN_MGQ);
> +		if (ret)
> +			return ret;
> +		break;
> +	case RTW89_SCH_TX_SEL_MACID:
> +		ret = rtw89_set_hw_sch_tx_en(rtwdev, mac_idx, 0, 0xffff);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +int rtw89_mac_resume_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx, u16 tx_en)
> +{
> +	int ret;
> +
> +	ret = rtw89_set_hw_sch_tx_en(rtwdev, mac_idx, tx_en, 0xffff);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static u16 rtw89_mac_dle_buf_req(struct rtw89_dev *rtwdev, u16 buf_len,
> +				 bool wd)
> +{
> +	u32 val, reg;
> +	int ret;
> +
> +	reg = wd ? R_AX_WD_BUF_REQ : R_AX_PL_BUF_REQ;
> +	val = buf_len;
> +	val |= B_AX_BUF_REQ_EXEC;
> +	rtw89_write32(rtwdev, reg, val);
> +
> +	reg = wd ? R_AX_WD_BUF_STATUS : R_AX_PL_BUF_STATUS;
> +
> +	ret = read_poll_timeout(rtw89_read32, val, val & B_AX_BUF_STAT_DONE,
> +				1, 2000, false, rtwdev, reg);
> +	if (ret)
> +		return 0xffff;
> +
> +	return FIELD_GET(B_AX_BUF_STAT_PKTID_MASK, val);
> +}
> +
> +static int rtw89_mac_set_cpuio(struct rtw89_dev *rtwdev,
> +			       struct rtw89_cpuio_ctrl *ctrl_para,
> +			       bool wd)
> +{
> +	u32 val, cmd_type, reg;
> +	int ret;
> +
> +	cmd_type = ctrl_para->cmd_type;
> +
> +	reg = wd ? R_AX_WD_CPUQ_OP_2 : R_AX_PL_CPUQ_OP_2;
> +	val = 0;
> +	val = u32_replace_bits(val, ctrl_para->start_pktid,
> +			       B_AX_CPUQ_OP_STRT_PKTID_MASK);
> +	val = u32_replace_bits(val, ctrl_para->end_pktid,
> +			       B_AX_CPUQ_OP_END_PKTID_MASK);
> +	rtw89_write32(rtwdev, reg, val);
> +
> +	reg = wd ? R_AX_WD_CPUQ_OP_1 : R_AX_PL_CPUQ_OP_1;
> +	val = 0;
> +	val = u32_replace_bits(val, ctrl_para->src_pid,
> +			       B_AX_CPUQ_OP_SRC_PID_MASK);
> +	val = u32_replace_bits(val, ctrl_para->src_qid,
> +			       B_AX_CPUQ_OP_SRC_QID_MASK);
> +	val = u32_replace_bits(val, ctrl_para->dst_pid,
> +			       B_AX_CPUQ_OP_DST_PID_MASK);
> +	val = u32_replace_bits(val, ctrl_para->dst_qid,
> +			       B_AX_CPUQ_OP_DST_QID_MASK);
> +	rtw89_write32(rtwdev, reg, val);
> +
> +	reg = wd ? R_AX_WD_CPUQ_OP_0 : R_AX_PL_CPUQ_OP_0;
> +	val = 0;
> +	val = u32_replace_bits(val, cmd_type,
> +			       B_AX_CPUQ_OP_CMD_TYPE_MASK);
> +	val = u32_replace_bits(val, ctrl_para->macid,
> +			       B_AX_CPUQ_OP_MACID_MASK);
> +	val = u32_replace_bits(val, ctrl_para->pkt_num,
> +			       B_AX_CPUQ_OP_PKTNUM_MASK);
> +	val |= B_AX_CPUQ_OP_EXEC;
> +	rtw89_write32(rtwdev, reg, val);
> +
> +	reg = wd ? R_AX_WD_CPUQ_OP_STATUS : R_AX_PL_CPUQ_OP_STATUS;
> +
> +	ret = read_poll_timeout(rtw89_read32, val, val & B_AX_CPUQ_OP_STAT_DONE,
> +				1, 2000, false, rtwdev, reg);
> +	if (ret)
> +		return ret;
> +
> +	if (cmd_type == CPUIO_OP_CMD_GET_1ST_PID ||
> +	    cmd_type == CPUIO_OP_CMD_GET_NEXT_PID)
> +		ctrl_para->pktid = FIELD_GET(B_AX_CPUQ_OP_PKTID_MASK, val);
> +
> +	return 0;
> +}
> +
> +static int dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
> +{
> +	struct rtw89_dle_mem *cfg;
> +	struct rtw89_cpuio_ctrl ctrl_para = {0};
> +	u16 pkt_id;
> +	int ret;
> +
> +	cfg = get_dle_mem_cfg(rtwdev, mode);
> +	if (!cfg) {
> +		rtw89_err(rtwdev, "[ERR]wd/dle mem cfg\n");
> +		return -EINVAL;
> +	}
> +
> +	if (dle_used_size(cfg->wde_size, cfg->ple_size) !=
> +	    (rtwdev->chip->fifo_size - dle_rsvd_size(rtwdev, mode))) {
> +		rtw89_err(rtwdev, "[ERR]wd/dle mem cfg\n");
> +		return -EINVAL;
> +	}
> +
> +	dle_quota_cfg(rtwdev, cfg);
> +
> +	pkt_id = rtw89_mac_dle_buf_req(rtwdev, 0x20, true);
> +	if (pkt_id == 0xffff) {
> +		rtw89_err(rtwdev, "[ERR]WDE DLE buf req\n");
> +		return -ENOMEM;
> +	}
> +
> +	ctrl_para.cmd_type = CPUIO_OP_CMD_ENQ_TO_HEAD;
> +	ctrl_para.start_pktid = pkt_id;
> +	ctrl_para.end_pktid = pkt_id;
> +	ctrl_para.pkt_num = 0;
> +	ctrl_para.dst_pid = WDE_DLE_PORT_ID_WDRLS;
> +	ctrl_para.dst_qid = WDE_DLE_QUEID_NO_REPORT;
> +	ret = rtw89_mac_set_cpuio(rtwdev, &ctrl_para, true);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]WDE DLE enqueue to head\n");
> +		return -EFAULT;
> +	}
> +
> +	pkt_id = rtw89_mac_dle_buf_req(rtwdev, 0x20, false);
> +	if (pkt_id == 0xffff) {
> +		rtw89_err(rtwdev, "[ERR]PLE DLE buf req\n");
> +		return -ENOMEM;
> +	}
> +
> +	ctrl_para.cmd_type = CPUIO_OP_CMD_ENQ_TO_HEAD;
> +	ctrl_para.start_pktid = pkt_id;
> +	ctrl_para.end_pktid = pkt_id;
> +	ctrl_para.pkt_num = 0;
> +	ctrl_para.dst_pid = PLE_DLE_PORT_ID_PLRLS;
> +	ctrl_para.dst_qid = PLE_DLE_QUEID_NO_REPORT;
> +	ret = rtw89_mac_set_cpuio(rtwdev, &ctrl_para, false);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]PLE DLE enqueue to head\n");
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int band_idle_ck_b(struct rtw89_dev *rtwdev, u8 mac_idx)
> +{
> +	int ret;
> +	u32 reg;
> +	u8 val;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_PTCL_TX_CTN_SEL, mac_idx);
> +
> +	ret = read_poll_timeout(rtw89_read8, val,
> +				(val & B_AX_PTCL_TX_ON_STAT) == 0,
> +				SW_CVR_DUR_US,
> +				SW_CVR_DUR_US * PTCL_IDLE_POLL_CNT,
> +				false, rtwdev, reg);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int band1_enable(struct rtw89_dev *rtwdev)
> +{
> +	int ret, i;
> +	u32 sleep_bak[4] = {0};
> +	u32 pause_bak[4] = {0};
> +	u16 tx_en;
> +
> +	ret = rtw89_mac_stop_sch_tx(rtwdev, 0, &tx_en, RTW89_SCH_TX_SEL_ALL);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]stop sch tx %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < 4; i++) {
> +		sleep_bak[i] = rtw89_read32(rtwdev, R_AX_MACID_SLEEP_0 + i * 4);
> +		pause_bak[i] = rtw89_read32(rtwdev, R_AX_SS_MACID_PAUSE_0 + i * 4);
> +		rtw89_write32(rtwdev, R_AX_MACID_SLEEP_0 + i * 4, U32_MAX);
> +		rtw89_write32(rtwdev, R_AX_SS_MACID_PAUSE_0 + i * 4, U32_MAX);
> +	}
> +
> +	ret = band_idle_ck_b(rtwdev, 0);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]tx idle poll %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = dle_quota_change(rtwdev, rtwdev->mac.qta_mode);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]DLE quota change %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < 4; i++) {
> +		rtw89_write32(rtwdev, R_AX_MACID_SLEEP_0 + i * 4, sleep_bak[i]);
> +		rtw89_write32(rtwdev, R_AX_SS_MACID_PAUSE_0 + i * 4, pause_bak[i]);
> +	}
> +
> +	ret = rtw89_mac_resume_sch_tx(rtwdev, 0, tx_en);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]CMAC1 resume sch tx %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = cmac_func_en(rtwdev, 1, true);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]CMAC1 func en %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = cmac_init(rtwdev, 1);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]CMAC1 init %d\n", ret);
> +		return ret;
> +	}
> +
> +	rtw89_write32_set(rtwdev, R_AX_SYS_ISO_CTRL_EXTEND,
> +			  B_AX_R_SYM_FEN_WLPHYFUN_1 | B_AX_R_SYM_FEN_WLPHYGLB_1);
> +
> +	return 0;
> +}
> +
> +static int rtw89_mac_enable_imr(struct rtw89_dev *rtwdev, u8 mac_idx,
> +				enum rtw89_mac_hwmod_sel sel)
> +{
> +	u32 reg, val;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, sel);
> +	if (ret) {
> +		rtw89_err(rtwdev, "MAC%d mac_idx%d is not ready\n",
> +			  sel, mac_idx);
> +		return ret;
> +	}
> +
> +	if (sel == RTW89_DMAC_SEL) {
> +		rtw89_write32_clr(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR,
> +				  B_AX_TXPKTCTL_USRCTL_RLSBMPLEN_ERR_INT_EN |
> +				  B_AX_TXPKTCTL_USRCTL_RDNRLSCMD_ERR_INT_EN |
> +				  B_AX_TXPKTCTL_CMDPSR_FRZTO_ERR_INT_EN);
> +		rtw89_write32_clr(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR_B1,
> +				  B_AX_TXPKTCTL_USRCTL_RLSBMPLEN_ERR_INT_EN |
> +				  B_AX_TXPKTCTL_USRCTL_RDNRLSCMD_ERR_INT_EN);
> +		rtw89_write32_clr(rtwdev, R_AX_HOST_DISPATCHER_ERR_IMR,
> +				  B_AX_HDT_PKT_FAIL_DBG_INT_EN |
> +				  B_AX_HDT_OFFSET_UNMATCH_INT_EN);
> +		rtw89_write32_clr(rtwdev, R_AX_CPU_DISPATCHER_ERR_IMR,
> +				  B_AX_CPU_SHIFT_EN_ERR_INT_EN);
> +		rtw89_write32_clr(rtwdev, R_AX_PLE_ERR_IMR,
> +				  B_AX_PLE_GETNPG_STRPG_ERR_INT_EN);
> +		rtw89_write32_clr(rtwdev, R_AX_WDRLS_ERR_IMR,
> +				  B_AX_WDRLS_PLEBREQ_TO_ERR_INT_EN);
> +		rtw89_write32_set(rtwdev, R_AX_HD0IMR, B_AX_WDT_PTFM_INT_EN);
> +		rtw89_write32_clr(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR,
> +				  B_AX_TXPKTCTL_USRCTL_NOINIT_ERR_INT_EN);
> +	} else if (sel == RTW89_CMAC_SEL) {
> +		reg = rtw89_mac_reg_by_idx(R_AX_SCHEDULE_ERR_IMR, mac_idx);
> +		rtw89_write32_clr(rtwdev, reg,
> +				  B_AX_SORT_NON_IDLE_ERR_INT_EN);
> +
> +		reg = rtw89_mac_reg_by_idx(R_AX_DLE_CTRL, mac_idx);
> +		rtw89_write32_clr(rtwdev, reg,
> +				  B_AX_NO_RESERVE_PAGE_ERR_IMR |
> +				  B_AX_RXDATA_FSM_HANG_ERROR_IMR);
> +
> +		reg = rtw89_mac_reg_by_idx(R_AX_PTCL_IMR0, mac_idx);
> +		val = B_AX_F2PCMD_USER_ALLC_ERR_INT_EN |
> +		      B_AX_TX_RECORD_PKTID_ERR_INT_EN |
> +		      B_AX_FSM_TIMEOUT_ERR_INT_EN;
> +		rtw89_write32(rtwdev, reg, val);
> +
> +		reg = rtw89_mac_reg_by_idx(R_AX_PHYINFO_ERR_IMR, mac_idx);
> +		rtw89_write16_set(rtwdev, reg,
> +				  B_AXC_PHY_TXON_TIMEOUT_INT_EN |
> +				  B_AX_CCK_CCA_TIMEOUT_INT_EN |
> +				  B_AX_OFDM_CCA_TIMEOUT_INT_EN |
> +				  B_AX_DATA_ON_TIMEOUT_INT_EN |
> +				  B_AX_STS_ON_TIMEOUT_INT_EN |
> +				  B_AX_CSI_ON_TIMEOUT_INT_EN);
> +
> +		reg = rtw89_mac_reg_by_idx(R_AX_RMAC_ERR_ISR, mac_idx);
> +		val = rtw89_read32(rtwdev, reg);
> +		val |= (B_AX_RMAC_RX_CSI_TIMEOUT_INT_EN |
> +			B_AX_RMAC_RX_TIMEOUT_INT_EN |
> +			B_AX_RMAC_CSI_TIMEOUT_INT_EN);
> +		val &= ~(B_AX_RMAC_CCA_TO_IDLE_TIMEOUT_INT_EN |
> +			 B_AX_RMAC_DATA_ON_TO_IDLE_TIMEOUT_INT_EN |
> +			 B_AX_RMAC_CCA_TIMEOUT_INT_EN |
> +			 B_AX_RMAC_DATA_ON_TIMEOUT_INT_EN);
> +		rtw89_write32(rtwdev, reg, val);
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rtw89_mac_dbcc_enable(struct rtw89_dev *rtwdev, bool enable)
> +{
> +	int ret = 0;
> +
> +	if (enable) {
> +		ret = band1_enable(rtwdev);
> +		if (ret) {
> +			rtw89_err(rtwdev, "[ERR] band1_enable %d\n", ret);
> +			return ret;
> +		}
> +
> +		ret = rtw89_mac_enable_imr(rtwdev, RTW89_MAC_1, RTW89_CMAC_SEL);
> +		if (ret) {
> +			rtw89_err(rtwdev, "[ERR] enable CMAC1 IMR %d\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		rtw89_err(rtwdev, "[ERR] disable dbcc is not implemented not\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int set_host_rpr(struct rtw89_dev *rtwdev)
> +{
> +	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE &&
> +	    is_qta_poh(rtwdev, rtwdev->mac.qta_mode)) {
> +		rtw89_write32_mask(rtwdev, R_AX_WDRLS_CFG,
> +				   B_AX_WDRLS_MODE_MASK, RTW89_RPR_MODE_POH);
> +		rtw89_write32_set(rtwdev, R_AX_RLSRPT0_CFG0,
> +				  B_AX_RLSRPT0_FLTR_MAP_MASK);
> +	} else {
> +		rtw89_write32_mask(rtwdev, R_AX_WDRLS_CFG,
> +				   B_AX_WDRLS_MODE_MASK, RTW89_RPR_MODE_STF);
> +		rtw89_write32_clr(rtwdev, R_AX_RLSRPT0_CFG0,
> +				  B_AX_RLSRPT0_FLTR_MAP_MASK);
> +	}
> +
> +	rtw89_write32_mask(rtwdev, R_AX_RLSRPT0_CFG1, B_AX_RLSRPT0_AGGNUM_MASK, 30);
> +	rtw89_write32_mask(rtwdev, R_AX_RLSRPT0_CFG1, B_AX_RLSRPT0_TO_MASK, 255);
> +
> +	return 0;
> +}
> +
> +static int rtw89_mac_trx_init(struct rtw89_dev *rtwdev)
> +{
> +	enum rtw89_qta_mode qta_mode = rtwdev->mac.qta_mode;
> +	int ret;
> +
> +	ret = dmac_init(rtwdev, 0);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]DMAC init %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = cmac_init(rtwdev, 0);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]CMAC%d init %d\n", 0, ret);
> +		return ret;
> +	}
> +
> +	if (is_qta_dbcc(rtwdev, qta_mode)) {
> +		ret = rtw89_mac_dbcc_enable(rtwdev, true);
> +		if (ret) {
> +			rtw89_err(rtwdev, "[ERR]dbcc_enable init %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = rtw89_mac_enable_imr(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR] enable DMAC IMR %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = rtw89_mac_enable_imr(rtwdev, RTW89_MAC_0, RTW89_CMAC_SEL);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR] to enable CMAC0 IMR %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = set_host_rpr(rtwdev);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR] set host rpr %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void rtw89_mac_disable_cpu(struct rtw89_dev *rtwdev)
> +{
> +	clear_bit(RTW89_FLAG_FW_RDY, rtwdev->flags);
> +
> +	rtw89_write32_clr(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_WCPU_EN);
> +	rtw89_write32_clr(rtwdev, R_AX_SYS_CLK_CTRL, B_AX_CPU_CLK_EN);
> +}
> +
> +static int rtw89_mac_enable_cpu(struct rtw89_dev *rtwdev, u8 boot_reason,
> +				bool dlfw)
> +{
> +	u32 val;
> +	int ret;
> +
> +	if (rtw89_read32(rtwdev, R_AX_PLATFORM_ENABLE) & B_AX_WCPU_EN)
> +		return -EFAULT;
> +
> +	rtw89_write32(rtwdev, R_AX_HALT_H2C_CTRL, 0);
> +	rtw89_write32(rtwdev, R_AX_HALT_C2H_CTRL, 0);
> +
> +	rtw89_write32_set(rtwdev, R_AX_SYS_CLK_CTRL, B_AX_CPU_CLK_EN);
> +
> +	val = rtw89_read32(rtwdev, R_AX_WCPU_FW_CTRL);
> +	val &= ~(B_AX_WCPU_FWDL_EN | B_AX_H2C_PATH_RDY | B_AX_FWDL_PATH_RDY);
> +	val = u32_replace_bits(val, RTW89_FWDL_INITIAL_STATE,
> +			       B_AX_WCPU_FWDL_STS_MASK);
> +
> +	if (dlfw)
> +		val |= B_AX_WCPU_FWDL_EN;
> +
> +	rtw89_write32(rtwdev, R_AX_WCPU_FW_CTRL, val);
> +	rtw89_write16_mask(rtwdev, R_AX_BOOT_REASON, B_AX_BOOT_REASON_MASK,
> +			   boot_reason);
> +	rtw89_write32_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_WCPU_EN);
> +
> +	if (!dlfw) {
> +		mdelay(5);
> +
> +		ret = rtw89_fw_check_rdy(rtwdev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rtw89_mac_fw_dl_pre_init(struct rtw89_dev *rtwdev)
> +{
> +	u32 val;
> +	int ret;
> +
> +	val = B_AX_MAC_FUNC_EN | B_AX_DMAC_FUNC_EN | B_AX_DISPATCHER_EN |
> +	      B_AX_PKT_BUF_EN;
> +	rtw89_write32(rtwdev, R_AX_DMAC_FUNC_EN, val);
> +
> +	val = B_AX_DISPATCHER_CLK_EN;
> +	rtw89_write32(rtwdev, R_AX_DMAC_CLK_EN, val);
> +
> +	ret = dle_init(rtwdev, RTW89_QTA_DLFW, rtwdev->mac.qta_mode);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]DLE pre init %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = hfc_init(rtwdev, true, false, true);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]HCI FC pre init %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static void rtw89_mac_hci_func_en(struct rtw89_dev *rtwdev)
> +{
> +	rtw89_write32_set(rtwdev, R_AX_HCI_FUNC_EN,
> +			  B_AX_HCI_TXDMA_EN | B_AX_HCI_RXDMA_EN);
> +}
> +
> +void rtw89_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
> +{
> +	rtw89_write8_set(rtwdev, R_AX_SYS_FUNC_EN,
> +			 B_AX_FEN_BBRSTB | B_AX_FEN_BB_GLB_RSTN);
> +	rtw89_write32_set(rtwdev, R_AX_WLRF_CTRL,
> +			  B_AX_WLRF1_CTRL_7 | B_AX_WLRF1_CTRL_1 |
> +			  B_AX_WLRF_CTRL_7 | B_AX_WLRF_CTRL_1);
> +	rtw89_write8_set(rtwdev, R_AX_PHYREG_SET, PHYREG_SET_ALL_CYCLE);
> +}
> +
> +void rtw89_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
> +{
> +	rtw89_write8_clr(rtwdev, R_AX_SYS_FUNC_EN,
> +			 B_AX_FEN_BBRSTB | B_AX_FEN_BB_GLB_RSTN);
> +	rtw89_write32_clr(rtwdev, R_AX_WLRF_CTRL,
> +			  B_AX_WLRF1_CTRL_7 | B_AX_WLRF1_CTRL_1 |
> +			  B_AX_WLRF_CTRL_7 | B_AX_WLRF_CTRL_1);
> +	rtw89_write8_clr(rtwdev, R_AX_PHYREG_SET, PHYREG_SET_ALL_CYCLE);
> +}
> +
> +int rtw89_mac_partial_init(struct rtw89_dev *rtwdev)
> +{
> +	int ret;
> +
> +	ret = rtw89_mac_power_switch(rtwdev, true);
> +	if (ret) {
> +		rtw89_mac_power_switch(rtwdev, false);
> +		ret = rtw89_mac_power_switch(rtwdev, true);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	rtw89_mac_hci_func_en(rtwdev);
> +
> +	if (rtwdev->hci.ops->mac_pre_init) {
> +		ret = rtwdev->hci.ops->mac_pre_init(rtwdev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = rtw89_mac_fw_dl_pre_init(rtwdev);
> +	if (ret)
> +		return ret;
> +
> +	rtw89_mac_disable_cpu(rtwdev);
> +	ret = rtw89_mac_enable_cpu(rtwdev, 0, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = rtw89_fw_download(rtwdev, RTW89_FW_NORMAL);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +int rtw89_mac_init(struct rtw89_dev *rtwdev)
> +{
> +	int ret;
> +
> +	ret = rtw89_mac_partial_init(rtwdev);
> +	if (ret)
> +		goto fail;
> +
> +	rtw89_mac_enable_bb_rf(rtwdev);
> +	if (ret)
> +		goto fail;
> +
> +	ret = rtw89_mac_sys_init(rtwdev);
> +	if (ret)
> +		goto fail;
> +
> +	ret = rtw89_mac_trx_init(rtwdev);
> +	if (ret)
> +		goto fail;
> +
> +	if (rtwdev->hci.ops->mac_post_init) {
> +		ret = rtwdev->hci.ops->mac_post_init(rtwdev);
> +		if (ret)
> +			goto fail;
> +	}
> +
> +	rtw89_fw_h2c_set_ofld_cfg(rtwdev);
> +
> +	return ret;
> +fail:
> +	rtw89_mac_power_switch(rtwdev, false);
> +
> +	return ret;
> +}
> +
> +static void rtw89_mac_dmac_tbl_init(struct rtw89_dev *rtwdev, u8 macid)
> +{
> +	u8 i;
> +
> +	for (i = 0; i < 4; i++) {
> +		rtw89_write32(rtwdev, R_AX_FILTER_MODEL_ADDR,
> +			      DMAC_TBL_BASE_ADDR + (macid << 4) + (i << 2));
> +		rtw89_write32(rtwdev, R_AX_INDIR_ACCESS_ENTRY, 0);
> +	}
> +}
> +
> +static void rtw89_mac_cmac_tbl_init(struct rtw89_dev *rtwdev, u8 macid)
> +{
> +	rtw89_write32(rtwdev, R_AX_FILTER_MODEL_ADDR,
> +		      CMAC_TBL_BASE_ADDR + macid * CCTL_INFO_SIZE);
> +	rtw89_write32(rtwdev, R_AX_INDIR_ACCESS_ENTRY, 0x4);
> +	rtw89_write32(rtwdev, R_AX_INDIR_ACCESS_ENTRY + 4, 0x400A0004);
> +	rtw89_write32(rtwdev, R_AX_INDIR_ACCESS_ENTRY + 8, 0);
> +	rtw89_write32(rtwdev, R_AX_INDIR_ACCESS_ENTRY + 12, 0);
> +	rtw89_write32(rtwdev, R_AX_INDIR_ACCESS_ENTRY + 16, 0);
> +	rtw89_write32(rtwdev, R_AX_INDIR_ACCESS_ENTRY + 20, 0xE43000B);
> +	rtw89_write32(rtwdev, R_AX_INDIR_ACCESS_ENTRY + 24, 0);
> +	rtw89_write32(rtwdev, R_AX_INDIR_ACCESS_ENTRY + 28, 0xB8109);
> +}
> +
> +static int rtw89_set_macid_pause(struct rtw89_dev *rtwdev, u8 macid, bool pause)
> +{
> +	u8 sh =  FIELD_GET(GENMASK(4, 0), macid);
> +	u8 grp = macid >> 5;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	rtw89_fw_h2c_macid_pause(rtwdev, sh, grp, pause);
> +
> +	return 0;
> +}
> +
> +static const struct rtw89_port_reg rtw_port_base = {
> +	.port_cfg = R_AX_PORT_CFG_P0,
> +	.tbtt_prohib = R_AX_TBTT_PROHIB_P0,
> +	.bcn_area = R_AX_BCN_AREA_P0,
> +	.bcn_early = R_AX_BCNERLYINT_CFG_P0,
> +	.tbtt_early = R_AX_TBTTERLYINT_CFG_P0,
> +	.tbtt_agg = R_AX_TBTT_AGG_P0,
> +	.bcn_space = R_AX_BCN_SPACE_CFG_P0,
> +	.bcn_forcetx = R_AX_BCN_FORCETX_P0,
> +	.bcn_err_cnt = R_AX_BCN_ERR_CNT_P0,
> +	.bcn_err_flag = R_AX_BCN_ERR_FLAG_P0,
> +	.dtim_ctrl = R_AX_DTIM_CTRL_P0,
> +	.tbtt_shift = R_AX_TBTT_SHIFT_P0,
> +	.bcn_cnt_tmr = R_AX_BCN_CNT_TMR_P0,
> +	.tsftr_l = R_AX_TSFTR_LOW_P0,
> +	.tsftr_h = R_AX_TSFTR_HIGH_P0
> +};
> +
> +#define BCN_INTERVAL 100
> +#define BCN_ERLY_DEF 160
> +#define BCN_SETUP_DEF 2
> +#define BCN_HOLD_DEF 200
> +#define BCN_MASK_DEF 0
> +#define TBTT_ERLY_DEF 5
> +#define BCN_SET_UNIT 32
> +#define BCN_ERLY_SET_DLY (10 * 2)
> +
> +static void rtw89_mac_port_cfg_func_sw(struct rtw89_dev *rtwdev,
> +				       struct rtw89_vif *rtwvif)
> +{
> +	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
> +	const struct rtw89_port_reg *p = &rtw_port_base;
> +
> +	if (!rtw89_read32_port_mask(rtwdev, rtwvif, p->port_cfg, B_AX_PORT_FUNC_EN))
> +		return;
> +
> +	rtw89_write32_port_clr(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_SETUP_MASK);
> +	rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_HOLD_MASK, 1);
> +	rtw89_write16_port_clr(rtwdev, rtwvif, p->tbtt_early, B_AX_TBTTERLY_MASK);
> +	rtw89_write16_port_clr(rtwdev, rtwvif, p->bcn_early, B_AX_BCNERLY_MASK);
> +
> +	msleep(vif->bss_conf.beacon_int + 1);
> +
> +	rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_PORT_FUNC_EN |
> +							    B_AX_BRK_SETUP);
> +	rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_TSFTR_RST);
> +	rtw89_write32_port(rtwdev, rtwvif, p->bcn_cnt_tmr, 0);
> +}
> +
> +static void rtw89_mac_port_cfg_tx_rpt(struct rtw89_dev *rtwdev,
> +				      struct rtw89_vif *rtwvif, bool en)
> +{
> +	const struct rtw89_port_reg *p = &rtw_port_base;
> +
> +	if (en)
> +		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_TXBCN_RPT_EN);
> +	else
> +		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_TXBCN_RPT_EN);
> +}
> +
> +static void rtw89_mac_port_cfg_rx_rpt(struct rtw89_dev *rtwdev,
> +				      struct rtw89_vif *rtwvif, bool en)
> +{
> +	const struct rtw89_port_reg *p = &rtw_port_base;
> +
> +	if (en)
> +		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_RXBCN_RPT_EN);
> +	else
> +		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_RXBCN_RPT_EN);
> +}
> +
> +static void rtw89_mac_port_cfg_net_type(struct rtw89_dev *rtwdev,
> +					struct rtw89_vif *rtwvif)
> +{
> +	const struct rtw89_port_reg *p = &rtw_port_base;
> +
> +	rtw89_write32_port_mask(rtwdev, rtwvif, p->port_cfg, B_AX_NET_TYPE_MASK,
> +				rtwvif->net_type);
> +}
> +
> +static void rtw89_mac_port_cfg_bcn_prct(struct rtw89_dev *rtwdev,
> +					struct rtw89_vif *rtwvif)
> +{
> +	const struct rtw89_port_reg *p = &rtw_port_base;
> +	bool en = rtwvif->net_type != RTW89_NET_TYPE_NO_LINK;
> +	u32 bits = B_AX_TBTT_PROHIB_EN | B_AX_BRK_SETUP;
> +
> +	if (en)
> +		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, bits);
> +	else
> +		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, bits);
> +}
> +
> +static void rtw89_mac_port_cfg_rx_sw(struct rtw89_dev *rtwdev,
> +				     struct rtw89_vif *rtwvif)
> +{
> +	const struct rtw89_port_reg *p = &rtw_port_base;
> +	bool en = rtwvif->net_type == RTW89_NET_TYPE_INFRA ||
> +		  rtwvif->net_type == RTW89_NET_TYPE_AD_HOC;
> +	u32 bit = B_AX_RX_BSSID_FIT_EN;
> +
> +	if (en)
> +		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, bit);
> +	else
> +		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, bit);
> +}
> +
> +static void rtw89_mac_port_cfg_rx_sync(struct rtw89_dev *rtwdev,
> +				       struct rtw89_vif *rtwvif)
> +{
> +	const struct rtw89_port_reg *p = &rtw_port_base;
> +	bool en = rtwvif->net_type == RTW89_NET_TYPE_INFRA ||
> +		  rtwvif->net_type == RTW89_NET_TYPE_AD_HOC;
> +
> +	if (en)
> +		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_TSF_UDT_EN);
> +	else
> +		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_TSF_UDT_EN);
> +}
> +
> +static void rtw89_mac_port_cfg_tx_sw(struct rtw89_dev *rtwdev,
> +				     struct rtw89_vif *rtwvif)
> +{
> +	const struct rtw89_port_reg *p = &rtw_port_base;
> +	bool en = rtwvif->net_type == RTW89_NET_TYPE_AP_MODE ||
> +		  rtwvif->net_type == RTW89_NET_TYPE_AD_HOC;
> +
> +	if (en)
> +		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_BCNTX_EN);
> +	else
> +		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_BCNTX_EN);
> +}
> +
> +static void rtw89_mac_port_cfg_bcn_intv(struct rtw89_dev *rtwdev,
> +					struct rtw89_vif *rtwvif)
> +{
> +	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
> +	const struct rtw89_port_reg *p = &rtw_port_base;
> +	u16 bcn_int = vif->bss_conf.beacon_int ? vif->bss_conf.beacon_int : BCN_INTERVAL;
> +
> +	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_space, B_AX_BCN_SPACE_MASK,
> +				bcn_int);
> +}
> +
> +static void rtw89_mac_port_cfg_bcn_setup_time(struct rtw89_dev *rtwdev,
> +					      struct rtw89_vif *rtwvif)
> +{
> +	const struct rtw89_port_reg *p = &rtw_port_base;
> +
> +	rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib,
> +				B_AX_TBTT_SETUP_MASK, BCN_SETUP_DEF);
> +}
> +
> +static void rtw89_mac_port_cfg_bcn_hold_time(struct rtw89_dev *rtwdev,
> +					     struct rtw89_vif *rtwvif)
> +{
> +	const struct rtw89_port_reg *p = &rtw_port_base;
> +
> +	rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib,
> +				B_AX_TBTT_HOLD_MASK, BCN_HOLD_DEF);
> +}
> +
> +static void rtw89_mac_port_cfg_bcn_mask_area(struct rtw89_dev *rtwdev,
> +					     struct rtw89_vif *rtwvif)
> +{
> +	const struct rtw89_port_reg *p = &rtw_port_base;
> +
> +	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_area,
> +				B_AX_BCN_MSK_AREA_MASK, BCN_MASK_DEF);
> +}
> +
> +static void rtw89_mac_port_cfg_tbtt_early(struct rtw89_dev *rtwdev,
> +					  struct rtw89_vif *rtwvif)
> +{
> +	const struct rtw89_port_reg *p = &rtw_port_base;
> +
> +	rtw89_write16_port_mask(rtwdev, rtwvif, p->tbtt_early,
> +				B_AX_TBTTERLY_MASK, TBTT_ERLY_DEF);
> +}
> +
> +static void rtw89_mac_port_cfg_bss_color(struct rtw89_dev *rtwdev,
> +					 struct rtw89_vif *rtwvif)
> +{
> +	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
> +	static const u32 masks[RTW89_PORT_NUM] = {
> +		B_AX_BSS_COLOB_AX_PORT_0_MASK, B_AX_BSS_COLOB_AX_PORT_1_MASK,
> +		B_AX_BSS_COLOB_AX_PORT_2_MASK, B_AX_BSS_COLOB_AX_PORT_3_MASK,
> +		B_AX_BSS_COLOB_AX_PORT_4_MASK,
> +	};
> +	u8 port = rtwvif->port;
> +	u32 reg_base;
> +	u32 reg;
> +	u8 bss_color;
> +
> +	bss_color = vif->bss_conf.he_bss_color.color;
> +	reg_base = port >= 4 ? R_AX_PTCL_BSS_COLOR_1 : R_AX_PTCL_BSS_COLOR_0;
> +	reg = rtw89_mac_reg_by_idx(reg_base, rtwvif->mac_idx);
> +	rtw89_write32_mask(rtwdev, reg, masks[port], bss_color);
> +}
> +
> +static void rtw89_mac_port_cfg_mbssid(struct rtw89_dev *rtwdev,
> +				      struct rtw89_vif *rtwvif)
> +{
> +	u8 port = rtwvif->port;
> +	u32 reg;
> +
> +	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
> +		return;
> +
> +	if (port == 0) {
> +		reg = rtw89_mac_reg_by_idx(R_AX_MBSSID_CTRL, rtwvif->mac_idx);
> +		rtw89_write32_clr(rtwdev, reg, B_AX_P0MB_ALL_MASK);
> +	}
> +}
> +
> +static void rtw89_mac_port_cfg_hiq_drop(struct rtw89_dev *rtwdev,
> +					struct rtw89_vif *rtwvif)
> +{
> +	u8 port = rtwvif->port;
> +	u32 reg;
> +	u32 val;
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_MBSSID_DROP_0, rtwvif->mac_idx);
> +	val = rtw89_read32(rtwdev, reg);
> +	val &= ~FIELD_PREP(B_AX_PORT_DROP_4_0_MSK, BIT(port));
> +	if (port == 0)
> +		val &= ~BIT(0);
> +	rtw89_write32(rtwdev, reg, val);
> +}
> +
> +static void rtw89_mac_port_cfg_func_en(struct rtw89_dev *rtwdev,
> +				       struct rtw89_vif *rtwvif)
> +{
> +	const struct rtw89_port_reg *p = &rtw_port_base;
> +
> +	rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_PORT_FUNC_EN);
> +}
> +
> +static void rtw89_mac_port_cfg_bcn_early(struct rtw89_dev *rtwdev,
> +					 struct rtw89_vif *rtwvif)
> +{
> +	const struct rtw89_port_reg *p = &rtw_port_base;
> +
> +	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_early, B_AX_BCNERLY_MASK,
> +				BCN_ERLY_DEF);
> +}
> +
> +static
> +int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
> +{
> +	int ret;
> +
> +	ret = rtw89_mac_port_update(rtwdev, rtwvif);
> +	if (ret)
> +		return ret;
> +
> +	rtw89_mac_dmac_tbl_init(rtwdev, rtwvif->mac_id);
> +	rtw89_mac_cmac_tbl_init(rtwdev, rtwvif->mac_id);
> +
> +	ret = rtw89_set_macid_pause(rtwdev, rtwvif->mac_id, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = rtw89_fw_h2c_vif_maintain(rtwdev, rtwvif, RTW89_VIF_CREATE);
> +	if (ret)
> +		return ret;
> +
> +	ret = rtw89_cam_init(rtwdev, rtwvif);
> +	if (ret)
> +		return ret;
> +
> +	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif);
> +	if (ret)
> +		return ret;
> +
> +	ret = rtw89_fw_h2c_default_cmac_tbl(rtwdev, rtwvif->mac_id);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static
> +int rtw89_mac_vif_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
> +{
> +	int ret;
> +
> +	ret = rtw89_fw_h2c_vif_maintain(rtwdev, rtwvif, RTW89_VIF_REMOVE);
> +	if (ret)
> +		return ret;
> +
> +	rtw89_cam_deinit(rtwdev, rtwvif);
> +
> +	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +void rtw89_restore_vif_cfg_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
> +{
> +	struct rtw89_dev *rtwdev = data;
> +	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
> +
> +	rtw89_mac_vif_init(rtwdev, rtwvif);
> +}
> +
> +void rtw89_remove_vif_cfg_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
> +{
> +	struct rtw89_dev *rtwdev = data;
> +	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
> +
> +	rtw89_mac_vif_deinit(rtwdev, rtwvif);
> +}
> +
> +int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
> +{
> +	u8 port = rtwvif->port;
> +
> +	if (port >= RTW89_PORT_NUM)
> +		return -EINVAL;
> +
> +	rtw89_mac_port_cfg_func_sw(rtwdev, rtwvif);
> +	rtw89_mac_port_cfg_tx_rpt(rtwdev, rtwvif, false);
> +	rtw89_mac_port_cfg_rx_rpt(rtwdev, rtwvif, false);
> +	rtw89_mac_port_cfg_net_type(rtwdev, rtwvif);
> +	rtw89_mac_port_cfg_bcn_prct(rtwdev, rtwvif);
> +	rtw89_mac_port_cfg_rx_sw(rtwdev, rtwvif);
> +	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif);
> +	rtw89_mac_port_cfg_tx_sw(rtwdev, rtwvif);
> +	rtw89_mac_port_cfg_bcn_intv(rtwdev, rtwvif);
> +	rtw89_mac_port_cfg_bcn_setup_time(rtwdev, rtwvif);
> +	rtw89_mac_port_cfg_bcn_hold_time(rtwdev, rtwvif);
> +	rtw89_mac_port_cfg_bcn_mask_area(rtwdev, rtwvif);
> +	rtw89_mac_port_cfg_tbtt_early(rtwdev, rtwvif);
> +	rtw89_mac_port_cfg_bss_color(rtwdev, rtwvif);
> +	rtw89_mac_port_cfg_mbssid(rtwdev, rtwvif);
> +	rtw89_mac_port_cfg_hiq_drop(rtwdev, rtwvif);
> +	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif);
> +	fsleep(BCN_ERLY_SET_DLY);
> +	rtw89_mac_port_cfg_bcn_early(rtwdev, rtwvif);
> +
> +	return 0;
> +}
> +
> +int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
> +{
> +	int ret;
> +
> +	rtwvif->mac_id = rtw89_core_acquire_bit_map(rtwdev->mac_id_map,
> +						    RTW89_MAX_MAC_ID_NUM);
> +	if (rtwvif->mac_id == RTW89_MAX_MAC_ID_NUM)
> +		return -ENOSPC;
> +
> +	ret = rtw89_mac_vif_init(rtwdev, rtwvif);
> +	if (ret)
> +		goto release_mac_id;
> +
> +	return 0;
> +
> +release_mac_id:
> +	rtw89_core_release_bit_map(rtwdev->mac_id_map, rtwvif->mac_id);
> +
> +	return ret;
> +}
> +
> +int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
> +{
> +	int ret;
> +
> +	ret = rtw89_mac_vif_deinit(rtwdev, rtwvif);
> +	rtw89_core_release_bit_map(rtwdev->mac_id_map, rtwvif->mac_id);
> +
> +	return ret;
> +}
> +
> +static void
> +rtw89_mac_c2h_macid_pause(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
> +{
> +}
> +
> +static void
> +rtw89_mac_c2h_rec_ack(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
> +{
> +	rtw89_debug(rtwdev, RTW89_DBG_FW,
> +		    "C2H rev ack recv, cat: %d, class: %d, func: %d, seq : %d\n",
> +		    RTW89_GET_MAC_C2H_REV_ACK_CAT(c2h->data),
> +		    RTW89_GET_MAC_C2H_REV_ACK_CLASS(c2h->data),
> +		    RTW89_GET_MAC_C2H_REV_ACK_FUNC(c2h->data),
> +		    RTW89_GET_MAC_C2H_REV_ACK_H2C_SEQ(c2h->data));
> +}
> +
> +static void
> +rtw89_mac_c2h_done_ack(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
> +{
> +	rtw89_debug(rtwdev, RTW89_DBG_FW,
> +		    "C2H done ack recv, cat: %d, class: %d, func: %d, ret: %d, seq : %d\n",
> +		    RTW89_GET_MAC_C2H_DONE_ACK_CAT(c2h->data),
> +		    RTW89_GET_MAC_C2H_DONE_ACK_CLASS(c2h->data),
> +		    RTW89_GET_MAC_C2H_DONE_ACK_FUNC(c2h->data),
> +		    RTW89_GET_MAC_C2H_DONE_ACK_H2C_RETURN(c2h->data),
> +		    RTW89_GET_MAC_C2H_DONE_ACK_H2C_SEQ(c2h->data));
> +}
> +
> +static void
> +rtw89_mac_c2h_log(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
> +{
> +	rtw89_info(rtwdev, "%*s", RTW89_GET_C2H_LOG_LEN(len),
> +		   RTW89_GET_C2H_LOG_SRT_PRT(c2h->data));
> +}
> +
> +static void (*rtw89_mac_c2h_ofld_handler[])(struct rtw89_dev *rtwdev,
> +					    struct sk_buff *c2h, u32 len) = {
> +	[RTW89_MAC_C2H_FUNC_EFUSE_DUMP] = NULL,
> +	[RTW89_MAC_C2H_FUNC_READ_RSP] = NULL,
> +	[RTW89_MAC_C2H_FUNC_PKT_OFLD_RSP] = NULL,
> +	[RTW89_MAC_C2H_FUNC_BCN_RESEND] = NULL,
> +	[RTW89_MAC_C2H_FUNC_MACID_PAUSE] = rtw89_mac_c2h_macid_pause,
> +};
> +
> +static void (*rtw89_mac_c2h_info_handler[])(struct rtw89_dev *rtwdev,
> +					    struct sk_buff *c2h, u32 len) = {
> +	[RTW89_MAC_C2H_FUNC_REC_ACK] = rtw89_mac_c2h_rec_ack,
> +	[RTW89_MAC_C2H_FUNC_DONE_ACK] = rtw89_mac_c2h_done_ack,
> +	[RTW89_MAC_C2H_FUNC_C2H_LOG] = rtw89_mac_c2h_log,
> +};
> +
> +void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
> +			  u32 len, u8 class, u8 func)
> +{
> +	void (*handler)(struct rtw89_dev *rtwdev,
> +			struct sk_buff *c2h, u32 len) = NULL;
> +
> +	switch (class) {
> +	case RTW89_MAC_C2H_CLASS_INFO:
> +		if (func < RTW89_MAC_C2H_FUNC_INFO_MAX)
> +			handler = rtw89_mac_c2h_info_handler[func];
> +		break;
> +	case RTW89_MAC_C2H_CLASS_OFLD:
> +		if (func < RTW89_MAC_C2H_FUNC_OFLD_MAX)
> +			handler = rtw89_mac_c2h_ofld_handler[func];
> +		break;
> +	case RTW89_MAC_C2H_CLASS_FWDBG:
> +		return;
> +	default:
> +		rtw89_info(rtwdev, "c2h class %d not support\n", class);
> +		return;
> +	}
> +	if (!handler) {
> +		rtw89_info(rtwdev, "c2h class %d func %d not support\n", class,
> +			   func);
> +		return;
> +	}
> +	handler(rtwdev, skb, len);
> +}
> +
> +bool rtw89_mac_get_txpwr_cr(struct rtw89_dev *rtwdev,
> +			    enum rtw89_phy_idx phy_idx,
> +			    u32 reg_base, u32 *cr)
> +{
> +	struct rtw89_dle_mem *dle_mem = rtwdev->chip->dle_mem;
> +	enum rtw89_qta_mode mode = dle_mem->mode;
> +	u32 addr = rtw89_mac_reg_by_idx(reg_base, phy_idx);
> +
> +	if (addr < R_AX_PWR_RATE_CTRL || addr > CMAC1_END_ADDR) {
> +		rtw89_err(rtwdev, "[TXPWR] addr=0x%x exceed txpwr cr\n",
> +			  addr);
> +		goto error;
> +	}
> +
> +	if (addr >= CMAC1_START_ADDR && addr <= CMAC1_END_ADDR)
> +		if (mode == RTW89_QTA_SCC || mode == RTW89_QTA_SCC_STF) {
> +			rtw89_err(rtwdev,
> +				  "[TXPWR] addr=0x%x but hw not enable\n",
> +				  addr);
> +			goto error;
> +		}
> +
> +	*cr = addr;
> +	return true;
> +
> +error:
> +	rtw89_err(rtwdev, "[TXPWR] check txpwr cr 0x%x(phy%d) fail\n",
> +		  addr, phy_idx);
> +
> +	return false;
> +}
> +
> +int rtw89_mac_cfg_ppdu_status(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable)
> +{
> +	u32 reg = rtw89_mac_reg_by_idx(R_AX_PPDU_STAT, mac_idx);
> +	int ret = 0;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	if (!enable) {
> +		rtw89_write32_clr(rtwdev, reg, B_AX_PPDU_STAT_RPT_EN);
> +		return ret;
> +	}
> +
> +	rtw89_write32(rtwdev, reg, B_AX_PPDU_STAT_RPT_EN |
> +				   B_AX_APP_MAC_INFO_RPT |
> +				   B_AX_APP_RX_CNT_RPT | B_AX_APP_PLCP_HDR_RPT |
> +				   B_AX_PPDU_STAT_RPT_CRC32);
> +	rtw89_write32_mask(rtwdev, R_AX_HW_RPT_FWD, B_AX_FWD_PPDU_STAT_MASK,
> +			   RTW89_PRPT_DEST_HOST);
> +
> +	return ret;
> +}
> +
> +void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev, u8 mac_idx)
> +{
> +#define MAC_AX_TIME_TH_SH  5
> +#define MAC_AX_LEN_TH_SH   4
> +#define MAC_AX_TIME_TH_MAX 255
> +#define MAC_AX_LEN_TH_MAX  255
> +#define MAC_AX_TIME_TH_DEF 88
> +#define MAC_AX_LEN_TH_DEF  4080
> +	struct ieee80211_hw *hw = rtwdev->hw;
> +	u32 rts_threshold = hw->wiphy->rts_threshold;
> +	u32 time_th, len_th;
> +	u32 reg;
> +
> +	if (rts_threshold == (u32)-1) {
> +		time_th = MAC_AX_TIME_TH_DEF;
> +		len_th = MAC_AX_LEN_TH_DEF;
> +	} else {
> +		time_th = MAC_AX_TIME_TH_MAX << MAC_AX_TIME_TH_SH;
> +		len_th = rts_threshold;
> +	}
> +
> +	time_th = min_t(u32, time_th >> MAC_AX_TIME_TH_SH, MAC_AX_TIME_TH_MAX);
> +	len_th = min_t(u32, len_th >> MAC_AX_LEN_TH_SH, MAC_AX_LEN_TH_MAX);
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_AGG_LEN_HT_0, mac_idx);
> +	rtw89_write16_mask(rtwdev, reg, B_AX_RTS_TXTIME_TH_MASK, time_th);
> +	rtw89_write16_mask(rtwdev, reg, B_AX_RTS_LEN_TH_MASK, len_th);
> +}
> +
> +void rtw89_mac_flush_txq(struct rtw89_dev *rtwdev, u32 queues, bool drop)
> +{
> +	bool empty;
> +	int ret;
> +
> +	if (!test_bit(RTW89_FLAG_POWERON, rtwdev->flags))
> +		return;
> +
> +	ret = read_poll_timeout(dle_is_txq_empty, empty, empty,
> +				10000, 200000, false, rtwdev);
> +	if (ret && !drop && (rtwdev->total_sta_assoc || rtwdev->scanning))
> +		rtw89_info(rtwdev, "timed out to flush queues\n");
> +}
> +
> +int rtw89_mac_coex_init(struct rtw89_dev *rtwdev, const struct rtw89_mac_ax_coex *coex)
> +{
> +	u8 val;
> +	u16 val16;
> +	u32 val32;
> +	int ret;
> +
> +	val = rtw89_read8(rtwdev, R_AX_GPIO_MUXCFG);
> +	rtw89_write8(rtwdev, R_AX_GPIO_MUXCFG, val | B_AX_ENBT);
> +
> +	val = rtw89_read8(rtwdev, R_AX_BTC_FUNC_EN);
> +	rtw89_write8(rtwdev, R_AX_BTC_FUNC_EN, val | B_AX_PTA_WL_TX_EN);
> +
> +	val = rtw89_read8(rtwdev, R_AX_BT_COEX_CFG_2 + 1);
> +	rtw89_write8(rtwdev, R_AX_BT_COEX_CFG_2 + 1, val | BIT(0));
> +
> +	val = rtw89_read8(rtwdev, R_AX_CSR_MODE);
> +	rtw89_write8(rtwdev, R_AX_CSR_MODE, val | B_AX_STATIS_BT_EN | B_AX_WL_ACT_MSK);
> +
> +	val = rtw89_read8(rtwdev, R_AX_CSR_MODE + 2);
> +	rtw89_write8(rtwdev, R_AX_CSR_MODE + 2, val | BIT(0));
> +
> +	val = rtw89_read8(rtwdev, R_AX_TRXPTCL_RESP_0 + 3);
> +	rtw89_write8(rtwdev, R_AX_TRXPTCL_RESP_0 + 3, val & ~BIT(1));
> +
> +	val16 = rtw89_read16(rtwdev, R_AX_CCA_CFG_0);
> +	val16 = (val16 | B_AX_BTCCA_EN) & ~B_AX_BTCCA_BRK_TXOP_EN;
> +	rtw89_write16(rtwdev, R_AX_CCA_CFG_0, val16);
> +
> +	ret = rtw89_mac_read_lte(rtwdev, R_AX_LTE_SW_CFG_2, &val32);
> +	if (ret) {
> +		rtw89_err(rtwdev, "Read R_AX_LTE_SW_CFG_2 fail!\n");
> +		return ret;
> +	}
> +	val32 = val32 & B_AX_WL_RX_CTRL;
> +	ret = rtw89_mac_write_lte(rtwdev, R_AX_LTE_SW_CFG_2, val32);
> +	if (ret) {
> +		rtw89_err(rtwdev, "Write R_AX_LTE_SW_CFG_2 fail!\n");
> +		return ret;
> +	}
> +
> +	switch (coex->pta_mode) {
> +	case RTW89_MAC_AX_COEX_RTK_MODE:
> +		val = rtw89_read8(rtwdev, R_AX_GPIO_MUXCFG);
> +		val &= ~B_AX_BTMODE_MASK;
> +		val |= FIELD_PREP(B_AX_BTMODE_MASK, MAC_AX_BT_MODE_0_3);
> +		rtw89_write8(rtwdev, R_AX_GPIO_MUXCFG, val);
> +
> +		val = rtw89_read8(rtwdev, R_AX_TDMA_MODE);
> +		rtw89_write8(rtwdev, R_AX_TDMA_MODE, val | B_AX_RTK_BT_ENABLE);
> +
> +		val = rtw89_read8(rtwdev, R_AX_BT_COEX_CFG_5);
> +		val &= ~B_AX_BT_RPT_SAMPLE_RATE_MASK;
> +		val |= FIELD_PREP(B_AX_BT_RPT_SAMPLE_RATE_MASK, MAC_AX_RTK_RATE);
> +		rtw89_write8(rtwdev, R_AX_BT_COEX_CFG_5, val);
> +		break;
> +	case RTW89_MAC_AX_COEX_CSR_MODE:
> +		val = rtw89_read8(rtwdev, R_AX_GPIO_MUXCFG);
> +		val &= ~B_AX_BTMODE_MASK;
> +		val |= FIELD_PREP(B_AX_BTMODE_MASK, MAC_AX_BT_MODE_2);
> +		rtw89_write8(rtwdev, R_AX_GPIO_MUXCFG, val);
> +
> +		val16 = rtw89_read16(rtwdev, R_AX_CSR_MODE);
> +		val16 &= ~B_AX_BT_PRI_DETECT_TO_MASK;
> +		val16 |= FIELD_PREP(B_AX_BT_PRI_DETECT_TO_MASK, MAC_AX_CSR_PRI_TO);
> +		val16 &= ~B_AX_BT_TRX_INIT_DETECT_MASK;
> +		val16 |= FIELD_PREP(B_AX_BT_TRX_INIT_DETECT_MASK, MAC_AX_CSR_TRX_TO);
> +		val16 &= ~B_AX_BT_STAT_DELAY_MASK;
> +		val16 |= FIELD_PREP(B_AX_BT_STAT_DELAY_MASK, MAC_AX_CSR_DELAY);
> +		val16 |= B_AX_ENHANCED_BT;
> +		rtw89_write16(rtwdev, R_AX_CSR_MODE, val16);
> +
> +		rtw89_write8(rtwdev, R_AX_BT_COEX_CFG_2, MAC_AX_CSR_RATE);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (coex->direction) {
> +	case RTW89_MAC_AX_COEX_INNER:
> +		val = rtw89_read8(rtwdev, R_AX_GPIO_MUXCFG + 1);
> +		val = (val & ~BIT(2)) | BIT(1);
> +		rtw89_write8(rtwdev, R_AX_GPIO_MUXCFG + 1, val);
> +		break;
> +	case RTW89_MAC_AX_COEX_OUTPUT:
> +		val = rtw89_read8(rtwdev, R_AX_GPIO_MUXCFG + 1);
> +		val = val | BIT(1) | BIT(0);
> +		rtw89_write8(rtwdev, R_AX_GPIO_MUXCFG + 1, val);
> +		break;
> +	case RTW89_MAC_AX_COEX_INPUT:
> +		val = rtw89_read8(rtwdev, R_AX_GPIO_MUXCFG + 1);
> +		val = val & ~(BIT(2) | BIT(1));
> +		rtw89_write8(rtwdev, R_AX_GPIO_MUXCFG + 1, val);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int rtw89_mac_cfg_gnt(struct rtw89_dev *rtwdev,
> +		      const struct rtw89_mac_ax_coex_gnt *gnt_cfg)
> +{
> +	u32 val, ret;
> +
> +	ret = rtw89_mac_read_lte(rtwdev, R_AX_LTE_SW_CFG_1, &val);
> +	if (ret) {
> +		rtw89_err(rtwdev, "Read LTE fail!\n");
> +		return ret;
> +	}
> +	val = (gnt_cfg->band[0].gnt_bt ?
> +	       B_AX_GNT_BT_RFC_S0_SW_VAL | B_AX_GNT_BT_BB_S0_SW_VAL : 0) |
> +	      (gnt_cfg->band[0].gnt_bt_sw_en ?
> +	       B_AX_GNT_BT_RFC_S0_SW_CTRL | B_AX_GNT_BT_BB_S0_SW_CTRL : 0) |
> +	      (gnt_cfg->band[0].gnt_wl ?
> +	       B_AX_GNT_WL_RFC_S0_SW_VAL | B_AX_GNT_WL_BB_S0_SW_VAL : 0) |
> +	      (gnt_cfg->band[0].gnt_wl_sw_en ?
> +	       B_AX_GNT_WL_RFC_S0_SW_CTRL | B_AX_GNT_WL_BB_S0_SW_CTRL : 0) |
> +	      (gnt_cfg->band[1].gnt_bt ?
> +	       B_AX_GNT_BT_RFC_S1_SW_VAL | B_AX_GNT_BT_BB_S1_SW_VAL : 0) |
> +	      (gnt_cfg->band[1].gnt_bt_sw_en ?
> +	       B_AX_GNT_BT_RFC_S1_SW_CTRL | B_AX_GNT_BT_BB_S1_SW_CTRL : 0) |
> +	      (gnt_cfg->band[1].gnt_wl ?
> +	       B_AX_GNT_WL_RFC_S1_SW_VAL | B_AX_GNT_WL_BB_S1_SW_VAL : 0) |
> +	      (gnt_cfg->band[1].gnt_wl_sw_en ?
> +	       B_AX_GNT_WL_RFC_S1_SW_CTRL | B_AX_GNT_WL_BB_S1_SW_CTRL : 0);
> +	ret = rtw89_mac_write_lte(rtwdev, R_AX_LTE_SW_CFG_1, val);
> +	if (ret) {
> +		rtw89_err(rtwdev, "Write LTE fail!\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int rtw89_mac_cfg_plt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt)
> +{
> +	u32 reg;
> +	u8 val;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, plt->band, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_BT_PLT, plt->band);
> +	val = (plt->tx & RTW89_MAC_AX_PLT_LTE_RX ? B_AX_TX_PLT_GNT_LTE_RX : 0) |
> +	      (plt->tx & RTW89_MAC_AX_PLT_GNT_BT_TX ? B_AX_TX_PLT_GNT_BT_TX : 0) |
> +	      (plt->tx & RTW89_MAC_AX_PLT_GNT_BT_RX ? B_AX_TX_PLT_GNT_BT_RX : 0) |
> +	      (plt->tx & RTW89_MAC_AX_PLT_GNT_WL ? B_AX_TX_PLT_GNT_WL : 0) |
> +	      (plt->rx & RTW89_MAC_AX_PLT_LTE_RX ? B_AX_RX_PLT_GNT_LTE_RX : 0) |
> +	      (plt->rx & RTW89_MAC_AX_PLT_GNT_BT_TX ? B_AX_RX_PLT_GNT_BT_TX : 0) |
> +	      (plt->rx & RTW89_MAC_AX_PLT_GNT_BT_RX ? B_AX_RX_PLT_GNT_BT_RX : 0) |
> +	      (plt->rx & RTW89_MAC_AX_PLT_GNT_WL ? B_AX_RX_PLT_GNT_WL : 0);
> +	rtw89_write8(rtwdev, reg, val);
> +
> +	return 0;
> +}
> +
> +u16 rtw89_mac_get_plt(struct rtw89_dev *rtwdev, u8 band)
> +{
> +	u32 reg;
> +	u16 cnt;
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_BT_PLT, band);
> +	cnt = rtw89_read32_mask(rtwdev, reg, B_AX_BT_PLT_PKT_CNT_MASK);
> +	rtw89_write16_set(rtwdev, reg, B_AX_BT_PLT_RST);
> +
> +	return cnt;
> +}

This function is not used, please remove.

> +void rtw89_mac_cfg_sb(struct rtw89_dev *rtwdev, u32 val)
> +{
> +	u32 fw_sb;
> +
> +	fw_sb = rtw89_read32(rtwdev, R_AX_SCOREBOARD);
> +	fw_sb = FIELD_GET(B_MAC_AX_SB_FW_MASK, fw_sb);
> +	fw_sb = fw_sb & ~B_MAC_AX_BTGS1_NOTIFY;
> +	if (!test_bit(RTW89_FLAG_POWERON, rtwdev->flags))
> +		fw_sb = fw_sb | MAC_AX_NOTIFY_PWR_MAJOR;
> +	else
> +		fw_sb = fw_sb | MAC_AX_NOTIFY_TP_MAJOR;
> +	val = FIELD_GET(B_MAC_AX_SB_DRV_MASK, val);
> +	val = B_AX_TOGGLE |
> +	      FIELD_PREP(B_MAC_AX_SB_DRV_MASK, val) |
> +	      FIELD_PREP(B_MAC_AX_SB_FW_MASK, fw_sb);
> +	rtw89_write32(rtwdev, R_AX_SCOREBOARD, val);
> +}
> +
> +u32 rtw89_mac_get_sb(struct rtw89_dev *rtwdev)
> +{
> +	return rtw89_read32(rtwdev, R_AX_SCOREBOARD);
> +}
> +
> +int rtw89_mac_cfg_ctrl_path(struct rtw89_dev *rtwdev, bool wl)
> +{
> +	u8 val = rtw89_read8(rtwdev, R_AX_SYS_SDIO_CTRL + 3);
> +
> +	val = wl ? val | BIT(2) : val & ~BIT(2);
> +	rtw89_write8(rtwdev, R_AX_SYS_SDIO_CTRL + 3, val);
> +
> +	return 0;
> +}
> +
> +bool rtw89_mac_get_ctrl_path(struct rtw89_dev *rtwdev)
> +{
> +	u8 val = rtw89_read8(rtwdev, R_AX_SYS_SDIO_CTRL + 3);
> +
> +	return FIELD_GET(B_AX_PTA_MUX_CTRL_PATH >> 24, val);
> +}
> +
> +static void rtw89_mac_bfee_ctrl(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
> +{
> +	u32 reg;
> +	u32 mask = B_AX_BFMEE_HT_NDPA_EN | B_AX_BFMEE_VHT_NDPA_EN |
> +		   B_AX_BFMEE_HE_NDPA_EN;
> +
> +	rtw89_debug(rtwdev, RTW89_DBG_BF, "set bfee ndpa_en to %d\n", en);
> +	reg = rtw89_mac_reg_by_idx(R_AX_BFMEE_RESP_OPTION, mac_idx);
> +	if (en) {
> +		set_bit(RTW89_FLAG_BFEE_EN, rtwdev->flags);
> +		rtw89_write32_set(rtwdev, reg, mask);
> +	} else {
> +		clear_bit(RTW89_FLAG_BFEE_EN, rtwdev->flags);
> +		rtw89_write32_clr(rtwdev, reg, mask);
> +	}
> +}
> +
> +static int rtw89_mac_init_bfee(struct rtw89_dev *rtwdev, u8 mac_idx)
> +{
> +	u32 reg;
> +	u32 val32;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	/* AP mode set tx gid to 63 */
> +	/* STA mode set tx gid to 0(default) */
> +	reg = rtw89_mac_reg_by_idx(R_AX_BFMER_CTRL_0, mac_idx);
> +	rtw89_write32_set(rtwdev, reg, B_AX_BFMER_NDP_BFEN);
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_CSI_RRSC, mac_idx);
> +	rtw89_write32(rtwdev, reg, CSI_RRSC_BMAP);
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_BFMEE_RESP_OPTION, mac_idx);
> +	val32 = FIELD_PREP(B_AX_BFMEE_BFRP_RX_STANDBY_TIMER_MASK, BFRP_RX_STANDBY_TIMER);
> +	val32 |= FIELD_PREP(B_AX_BFMEE_NDP_RX_STANDBY_TIMER_MASK, NDP_RX_STANDBY_TIMER);
> +	rtw89_write32(rtwdev, reg, val32);
> +	rtw89_mac_bfee_ctrl(rtwdev, mac_idx, true);
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
> +	rtw89_write32_set(rtwdev, reg, B_AX_BFMEE_BFPARAM_SEL |
> +				       B_AX_BFMEE_USE_NSTS |
> +				       B_AX_BFMEE_CSI_GID_SEL |
> +				       B_AX_BFMEE_CSI_FORCE_RETE_EN);
> +	reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_CSI_RATE, mac_idx);
> +	rtw89_write32(rtwdev, reg,
> +		      u32_encode_bits(CSI_INIT_RATE_HT, B_AX_BFMEE_HT_CSI_RATE_MASK) |
> +		      u32_encode_bits(CSI_INIT_RATE_VHT, B_AX_BFMEE_VHT_CSI_RATE_MASK) |
> +		      u32_encode_bits(CSI_INIT_RATE_HE, B_AX_BFMEE_HE_CSI_RATE_MASK));
> +
> +	return 0;
> +}
> +
> +static int rtw89_mac_set_csi_para_reg(struct rtw89_dev *rtwdev,
> +				      struct ieee80211_vif *vif,
> +				      struct ieee80211_sta *sta)
> +{
> +	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
> +	u8 mac_idx = rtwvif->mac_idx;
> +	u8 nc = 1, nr = 3, ng = 0, cb = 1, cs = 1, ldpc_en = 1, stbc_en = 1;
> +	u8 port_sel = rtwvif->port;
> +	u8 sound_dim = 3, t;
> +	u8 *phy_cap = sta->he_cap.he_cap_elem.phy_cap_info;
> +	u32 reg;
> +	u16 val;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	if ((phy_cap[3] & IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER) ||
> +	    (phy_cap[4] & IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER)) {
> +		ldpc_en &= !!(phy_cap[1] & IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD);
> +		stbc_en &= !!(phy_cap[2] & IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ);
> +		t = FIELD_GET(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
> +			      phy_cap[5]);
> +		sound_dim = min(sound_dim, t);
> +	}
> +	if ((sta->vht_cap.cap & IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE) ||
> +	    (sta->vht_cap.cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE)) {
> +		ldpc_en &= !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
> +		stbc_en &= !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_MASK);
> +		t = FIELD_GET(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
> +			      sta->vht_cap.cap);
> +		sound_dim = min(sound_dim, t);
> +	}
> +	nc = min(nc, sound_dim);
> +	nr = min(nr, sound_dim);
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
> +	rtw89_write32_set(rtwdev, reg, B_AX_BFMEE_BFPARAM_SEL);
> +
> +	val = FIELD_PREP(B_AX_BFMEE_CSIINFO0_NC_MASK, nc) |
> +	      FIELD_PREP(B_AX_BFMEE_CSIINFO0_NR_MASK, nr) |
> +	      FIELD_PREP(B_AX_BFMEE_CSIINFO0_NG_MASK, ng) |
> +	      FIELD_PREP(B_AX_BFMEE_CSIINFO0_CB_MASK, cb) |
> +	      FIELD_PREP(B_AX_BFMEE_CSIINFO0_CS_MASK, cs) |
> +	      FIELD_PREP(B_AX_BFMEE_CSIINFO0_LDPC_EN, ldpc_en) |
> +	      FIELD_PREP(B_AX_BFMEE_CSIINFO0_STBC_EN, stbc_en);
> +
> +	if (port_sel == 0)
> +		reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
> +	else
> +		reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_CSI_CTRL_1, mac_idx);
> +
> +	rtw89_write16(rtwdev, reg, val);
> +
> +	return 0;
> +}
> +
> +static int rtw89_mac_csi_rrsc(struct rtw89_dev *rtwdev,
> +			      struct ieee80211_vif *vif,
> +			      struct ieee80211_sta *sta)
> +{
> +	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
> +	u32 rrsc = BIT(RTW89_MAC_BF_RRSC_6M) | BIT(RTW89_MAC_BF_RRSC_24M);
> +	u32 reg;
> +	u8 mac_idx = rtwvif->mac_idx;
> +	int ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	if (sta->he_cap.has_he) {
> +		rrsc |= (BIT(RTW89_MAC_BF_RRSC_HE_MSC0) |
> +			 BIT(RTW89_MAC_BF_RRSC_HE_MSC3) |
> +			 BIT(RTW89_MAC_BF_RRSC_HE_MSC5));
> +	}
> +	if (sta->vht_cap.vht_supported) {
> +		rrsc |= (BIT(RTW89_MAC_BF_RRSC_VHT_MSC0) |
> +			 BIT(RTW89_MAC_BF_RRSC_VHT_MSC3) |
> +			 BIT(RTW89_MAC_BF_RRSC_VHT_MSC5));
> +	}
> +	if (sta->ht_cap.ht_supported) {
> +		rrsc |= (BIT(RTW89_MAC_BF_RRSC_HT_MSC0) |
> +			 BIT(RTW89_MAC_BF_RRSC_HT_MSC3) |
> +			 BIT(RTW89_MAC_BF_RRSC_HT_MSC5));
> +	}
> +	reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
> +	rtw89_write32_set(rtwdev, reg, B_AX_BFMEE_BFPARAM_SEL);
> +	rtw89_write32_clr(rtwdev, reg, B_AX_BFMEE_CSI_FORCE_RETE_EN);
> +	rtw89_write32(rtwdev,
> +		      rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_CSI_RRSC, mac_idx),
> +		      rrsc);
> +
> +	return 0;
> +}
> +
> +void rtw89_mac_bf_assoc(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
> +			struct ieee80211_sta *sta)
> +{
> +	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
> +
> +	if (rtw89_sta_has_beamformer_cap(sta)) {
> +		rtw89_debug(rtwdev, RTW89_DBG_BF,
> +			    "initialize bfee for new association\n");
> +		rtw89_mac_init_bfee(rtwdev, rtwvif->mac_idx);
> +		rtw89_mac_set_csi_para_reg(rtwdev, vif, sta);
> +		rtw89_mac_csi_rrsc(rtwdev, vif, sta);
> +	}
> +}
> +
> +void rtw89_mac_bf_disassoc(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
> +			   struct ieee80211_sta *sta)
> +{
> +	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
> +
> +	rtw89_mac_bfee_ctrl(rtwdev, rtwvif->mac_idx, false);
> +}
> +
> +void rtw89_mac_bf_set_gid_table(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
> +				struct ieee80211_bss_conf *conf)
> +{
> +	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
> +	u8 mac_idx = rtwvif->mac_idx;
> +	__le32 *p;
> +
> +	rtw89_debug(rtwdev, RTW89_DBG_BF, "update bf GID table\n");
> +
> +	p = (__le32 *)conf->mu_group.membership;
> +	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(R_AX_GID_POSITION_EN0, mac_idx),
> +		      le32_to_cpu(p[0]));
> +	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(R_AX_GID_POSITION_EN1, mac_idx),
> +		      le32_to_cpu(p[1]));
> +
> +	p = (__le32 *)conf->mu_group.position;
> +	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(R_AX_GID_POSITION0, mac_idx),
> +		      le32_to_cpu(p[0]));
> +	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(R_AX_GID_POSITION1, mac_idx),
> +		      le32_to_cpu(p[1]));
> +	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(R_AX_GID_POSITION2, mac_idx),
> +		      le32_to_cpu(p[2]));
> +	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(R_AX_GID_POSITION3, mac_idx),
> +		      le32_to_cpu(p[3]));
> +}
> +
> +struct rtw89_mac_bf_monitor_iter_data {
> +	struct rtw89_dev *rtwdev;
> +	struct ieee80211_sta *down_sta;
> +	int count;
> +};
> +
> +static
> +void rtw89_mac_bf_monitor_calc_iter(void *data, struct ieee80211_sta *sta)
> +{
> +	struct rtw89_mac_bf_monitor_iter_data *iter_data =
> +				(struct rtw89_mac_bf_monitor_iter_data *)data;
> +	struct ieee80211_sta *down_sta = iter_data->down_sta;
> +	int *count = &iter_data->count;
> +
> +	if (down_sta == sta)
> +		return;
> +
> +	if (rtw89_sta_has_beamformer_cap(sta))
> +		(*count)++;
> +}
> +
> +void rtw89_mac_bf_monitor_calc(struct rtw89_dev *rtwdev,
> +			       struct ieee80211_sta *sta, bool disconnect)
> +{
> +	struct rtw89_mac_bf_monitor_iter_data data;
> +
> +	data.rtwdev = rtwdev;
> +	data.down_sta = disconnect ? sta : NULL;
> +	data.count = 0;
> +	ieee80211_iterate_stations_atomic(rtwdev->hw,
> +					  rtw89_mac_bf_monitor_calc_iter,
> +					  &data);
> +
> +	rtw89_debug(rtwdev, RTW89_DBG_BF, "bfee STA count=%d\n", data.count);
> +	if (data.count)
> +		set_bit(RTW89_FLAG_BFEE_MON, rtwdev->flags);
> +	else
> +		clear_bit(RTW89_FLAG_BFEE_MON, rtwdev->flags);
> +}
> +
> +struct rtw89_mac_bfee_ctrl_iter_data {
> +	struct rtw89_dev *rtwdev;
> +	bool en;
> +};
> +
> +static void rtw89_mac_bfee_ctrl_iter(void *data, u8 *mac,
> +				     struct ieee80211_vif *vif)
> +{
> +	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
> +	struct rtw89_mac_bfee_ctrl_iter_data *iter_data =
> +				(struct rtw89_mac_bfee_ctrl_iter_data *)data;
> +	struct rtw89_dev *rtwdev = iter_data->rtwdev;
> +	bool en = iter_data->en;
> +
> +	rtw89_mac_bfee_ctrl(rtwdev, rtwvif->mac_idx, en);
> +}
> +
> +void _rtw89_mac_bf_monitor_track(struct rtw89_dev *rtwdev)
> +{
> +	struct rtw89_traffic_stats *stats = &rtwdev->stats;
> +	struct rtw89_mac_bfee_ctrl_iter_data iter_data;
> +	bool en = stats->tx_tfc_lv > stats->rx_tfc_lv ? false : true;
> +	bool old = test_bit(RTW89_FLAG_BFEE_EN, rtwdev->flags);
> +
> +	if (en == old)
> +		return;
> +
> +	iter_data.rtwdev = rtwdev;
> +	iter_data.en = en;
> +	rtw89_iterate_vifs(rtwdev, rtw89_mac_bfee_ctrl_iter, &iter_data, false);
> +}
> +
> +static int
> +__rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
> +			u32 tx_time)
> +{
> +#define MAC_AX_DFLT_TX_TIME 5280
> +	u8 mac_idx = rtwsta->rtwvif->mac_idx;
> +	u32 max_tx_time = tx_time == 0 ? MAC_AX_DFLT_TX_TIME : tx_time;
> +	u32 reg;
> +	int ret = 0;
> +
> +	if (rtwsta->cctl_tx_time) {
> +		rtwsta->ampdu_max_time = (max_tx_time - 512) >> 9;
> +		ret = rtw89_fw_h2c_txtime_cmac_tbl(rtwdev, rtwsta);
> +	} else {
> +		ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +		if (ret) {
> +			rtw89_warn(rtwdev, "failed to check cmac in set txtime\n");
> +			return ret;
> +		}
> +
> +		reg = rtw89_mac_reg_by_idx(R_AX_AMPDU_AGG_LIMIT, mac_idx);
> +		rtw89_write32_mask(rtwdev, reg, B_AX_AMPDU_MAX_TIME_MASK,
> +				   max_tx_time >> 5);
> +	}
> +
> +	return ret;
> +}
> +
> +int rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
> +			  bool resume, u32 tx_time)
> +{
> +	int ret = 0;
> +
> +	if (!resume) {
> +		rtwsta->cctl_tx_time = true;
> +		ret = __rtw89_mac_set_tx_time(rtwdev, rtwsta, tx_time);
> +	} else {
> +		ret = __rtw89_mac_set_tx_time(rtwdev, rtwsta, tx_time);
> +		rtwsta->cctl_tx_time = false;
> +	}
> +
> +	return ret;
> +}
> +
> +int rtw89_mac_get_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
> +			  u32 *tx_time)
> +{
> +	u8 mac_idx = rtwsta->rtwvif->mac_idx;
> +	u32 reg;
> +	int ret = 0;
> +
> +	if (rtwsta->cctl_tx_time) {
> +		*tx_time = (rtwsta->ampdu_max_time + 1) << 9;
> +	} else {
> +		ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +		if (ret) {
> +			rtw89_warn(rtwdev, "failed to check cmac in tx_time\n");
> +			return ret;
> +		}
> +
> +		reg = rtw89_mac_reg_by_idx(R_AX_AMPDU_AGG_LIMIT, mac_idx);
> +		*tx_time = rtw89_read32_mask(rtwdev, reg, B_AX_AMPDU_MAX_TIME_MASK) << 5;
> +	}
> +
> +	return ret;
> +}
> +
> +int rtw89_mac_set_tx_retry_limit(struct rtw89_dev *rtwdev,
> +				 struct rtw89_sta *rtwsta,
> +				 bool resume, u8 tx_retry)
> +{
> +	int ret = 0;
> +
> +	rtwsta->data_tx_cnt_lmt = tx_retry;
> +
> +	if (!resume) {
> +		rtwsta->cctl_tx_retry_limit = true;
> +		ret = rtw89_fw_h2c_txtime_cmac_tbl(rtwdev, rtwsta);
> +	} else {
> +		ret = rtw89_fw_h2c_txtime_cmac_tbl(rtwdev, rtwsta);
> +		rtwsta->cctl_tx_retry_limit = false;
> +	}
> +
> +	return ret;
> +}
> +
> +int rtw89_mac_get_tx_retry_limit(struct rtw89_dev *rtwdev,
> +				 struct rtw89_sta *rtwsta, u8 *tx_retry)
> +{
> +	u8 mac_idx = rtwsta->rtwvif->mac_idx;
> +	u32 reg;
> +	int ret = 0;
> +
> +	if (rtwsta->cctl_tx_retry_limit) {
> +		*tx_retry = rtwsta->data_tx_cnt_lmt;
> +	} else {
> +		ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +		if (ret) {
> +			rtw89_warn(rtwdev, "failed to check cmac in rty_lmt\n");
> +			return ret;
> +		}
> +
> +		reg = rtw89_mac_reg_by_idx(R_AX_TXCNT, mac_idx);
> +		*tx_retry = rtw89_read32_mask(rtwdev, reg, B_AX_L_TXCNT_LMT_MASK);
> +	}
> +
> +	return ret;
> +}
> +
> +int rtw89_mac_set_hw_muedca_ctrl(struct rtw89_dev *rtwdev,
> +				 struct rtw89_vif *rtwvif, bool en)
> +{
> +	u8 mac_idx = rtwvif->mac_idx;
> +	u16 set = B_AX_MUEDCA_EN_0 | B_AX_SET_MUEDCATIMER_TF_0;
> +	u32 reg;
> +	u32 ret;
> +
> +	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
> +	if (ret)
> +		return ret;
> +
> +	reg = rtw89_mac_reg_by_idx(R_AX_MUEDCA_EN, mac_idx);
> +	if (en)
> +		rtw89_write16_set(rtwdev, reg, set);
> +	else
> +		rtw89_write16_clr(rtwdev, reg, set);
> +
> +	return 0;
> +}
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
> new file mode 100644
> index 000000000000..efff7cbb88fe
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw89/mac.h
> @@ -0,0 +1,905 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/* Copyright(c) 2019-2020  Realtek Corporation
> + */
> +
> +#ifndef __RTW89_MAC_H__
> +#define __RTW89_MAC_H__
> +
> +#include "core.h"
> +
> +#define MAC_MEM_DUMP_PAGE_SIZE 0x40000
> +#define ADDR_CAM_ENT_SIZE  0x40
> +#define BSSID_CAM_ENT_SIZE 0x08
> +#define HFC_PAGE_UNIT 64
> +
> +enum rtw89_mac_hwmod_sel {
> +	RTW89_DMAC_SEL = 0,
> +	RTW89_CMAC_SEL = 1,
> +
> +	RTW89_MAC_INVALID,
> +};
> +
> +enum rtw89_mac_fwd_target {
> +	RTW89_FWD_DONT_CARE    = 0,
> +	RTW89_FWD_TO_HOST      = 1,
> +	RTW89_FWD_TO_WLAN_CPU  = 2
> +};
> +
> +enum rtw89_mac_wd_dma_intvl {
> +	RTW89_MAC_WD_DMA_INTVL_0S,
> +	RTW89_MAC_WD_DMA_INTVL_256NS,
> +	RTW89_MAC_WD_DMA_INTVL_512NS,
> +	RTW89_MAC_WD_DMA_INTVL_768NS,
> +	RTW89_MAC_WD_DMA_INTVL_1US,
> +	RTW89_MAC_WD_DMA_INTVL_1_5US,
> +	RTW89_MAC_WD_DMA_INTVL_2US,
> +	RTW89_MAC_WD_DMA_INTVL_4US,
> +	RTW89_MAC_WD_DMA_INTVL_8US,
> +	RTW89_MAC_WD_DMA_INTVL_16US,
> +	RTW89_MAC_WD_DMA_INTVL_DEF = 0xFE
> +};
> +
> +enum rtw89_mac_multi_tag_num {
> +	RTW89_MAC_TAG_NUM_1,
> +	RTW89_MAC_TAG_NUM_2,
> +	RTW89_MAC_TAG_NUM_3,
> +	RTW89_MAC_TAG_NUM_4,
> +	RTW89_MAC_TAG_NUM_5,
> +	RTW89_MAC_TAG_NUM_6,
> +	RTW89_MAC_TAG_NUM_7,
> +	RTW89_MAC_TAG_NUM_8,
> +	RTW89_MAC_TAG_NUM_DEF = 0xFE
> +};
> +
> +enum rtw89_mac_lbc_tmr {
> +	RTW89_MAC_LBC_TMR_8US = 0,
> +	RTW89_MAC_LBC_TMR_16US,
> +	RTW89_MAC_LBC_TMR_32US,
> +	RTW89_MAC_LBC_TMR_64US,
> +	RTW89_MAC_LBC_TMR_128US,
> +	RTW89_MAC_LBC_TMR_256US,
> +	RTW89_MAC_LBC_TMR_512US,
> +	RTW89_MAC_LBC_TMR_1MS,
> +	RTW89_MAC_LBC_TMR_2MS,
> +	RTW89_MAC_LBC_TMR_4MS,
> +	RTW89_MAC_LBC_TMR_8MS,
> +	RTW89_MAC_LBC_TMR_DEF = 0xFE
> +};
> +
> +enum rtw89_mac_cpuio_op_cmd_type {
> +	CPUIO_OP_CMD_GET_1ST_PID = 0,
> +	CPUIO_OP_CMD_GET_NEXT_PID = 1,
> +	CPUIO_OP_CMD_ENQ_TO_TAIL = 4,
> +	CPUIO_OP_CMD_ENQ_TO_HEAD = 5,
> +	CPUIO_OP_CMD_DEQ = 8,
> +	CPUIO_OP_CMD_DEQ_ENQ_ALL = 9,
> +	CPUIO_OP_CMD_DEQ_ENQ_TO_TAIL = 12
> +};
> +
> +enum rtw89_mac_wde_dle_port_id {
> +	WDE_DLE_PORT_ID_DISPATCH = 0,
> +	WDE_DLE_PORT_ID_PKTIN = 1,
> +	WDE_DLE_PORT_ID_CMAC0 = 3,
> +	WDE_DLE_PORT_ID_CMAC1 = 4,
> +	WDE_DLE_PORT_ID_CPU_IO = 6,
> +	WDE_DLE_PORT_ID_WDRLS = 7,
> +	WDE_DLE_PORT_ID_END = 8
> +};
> +
> +enum rtw89_mac_wde_dle_queid_wdrls {
> +	WDE_DLE_QUEID_TXOK = 0,
> +	WDE_DLE_QUEID_DROP_RETRY_LIMIT = 1,
> +	WDE_DLE_QUEID_DROP_LIFETIME_TO = 2,
> +	WDE_DLE_QUEID_DROP_MACID_DROP = 3,
> +	WDE_DLE_QUEID_NO_REPORT = 4
> +};
> +
> +enum rtw89_mac_ple_dle_port_id {
> +	PLE_DLE_PORT_ID_DISPATCH = 0,
> +	PLE_DLE_PORT_ID_MPDU = 1,
> +	PLE_DLE_PORT_ID_SEC = 2,
> +	PLE_DLE_PORT_ID_CMAC0 = 3,
> +	PLE_DLE_PORT_ID_CMAC1 = 4,
> +	PLE_DLE_PORT_ID_WDRLS = 5,
> +	PLE_DLE_PORT_ID_CPU_IO = 6,
> +	PLE_DLE_PORT_ID_PLRLS = 7,
> +	PLE_DLE_PORT_ID_END = 8
> +};
> +
> +enum rtw89_mac_ple_dle_queid_plrls {
> +	PLE_DLE_QUEID_NO_REPORT = 0x0
> +};
> +
> +enum rtw89_machdr_frame_type {
> +	RTW89_MGNT = 0,
> +	RTW89_CTRL = 1,
> +	RTW89_DATA = 2,
> +};
> +
> +enum rtw89_mac_dle_dfi_type {
> +	DLE_DFI_TYPE_FREEPG	= 0,
> +	DLE_DFI_TYPE_QUOTA	= 1,
> +	DLE_DFI_TYPE_PAGELLT	= 2,
> +	DLE_DFI_TYPE_PKTINFO	= 3,
> +	DLE_DFI_TYPE_PREPKTLLT	= 4,
> +	DLE_DFI_TYPE_NXTPKTLLT	= 5,
> +	DLE_DFI_TYPE_QLNKTBL	= 6,
> +	DLE_DFI_TYPE_QEMPTY	= 7,
> +};
> +
> +enum rtw89_mac_dle_wde_quota_id {
> +	WDE_QTAID_HOST_IF = 0,
> +	WDE_QTAID_WLAN_CPU = 1,
> +	WDE_QTAID_DATA_CPU = 2,
> +	WDE_QTAID_PKTIN = 3,
> +	WDE_QTAID_CPUIO = 4,
> +};
> +
> +enum rtw89_mac_dle_ple_quota_id {
> +	PLE_QTAID_B0_TXPL = 0,
> +	PLE_QTAID_B1_TXPL = 1,
> +	PLE_QTAID_C2H = 2,
> +	PLE_QTAID_H2C = 3,
> +	PLE_QTAID_WLAN_CPU = 4,
> +	PLE_QTAID_MPDU = 5,
> +	PLE_QTAID_CMAC0_RX = 6,
> +	PLE_QTAID_CMAC1_RX = 7,
> +	PLE_QTAID_CMAC1_BBRPT = 8,
> +	PLE_QTAID_WDRLS = 9,
> +	PLE_QTAID_CPUIO = 10,
> +};
> +
> +enum rtw89_mac_dle_ctrl_type {
> +	DLE_CTRL_TYPE_WDE = 0,
> +	DLE_CTRL_TYPE_PLE = 1,
> +	DLE_CTRL_TYPE_NUM = 2,
> +};
> +
> +enum rtw89_mac_ax_l0_to_l1_event {
> +	MAC_AX_L0_TO_L1_CHIF_IDLE = 0,
> +	MAC_AX_L0_TO_L1_CMAC_DMA_IDLE = 1,
> +	MAC_AX_L0_TO_L1_RLS_PKID = 2,
> +	MAC_AX_L0_TO_L1_PTCL_IDLE = 3,
> +	MAC_AX_L0_TO_L1_RX_QTA_LOST = 4,
> +	MAC_AX_L0_TO_L1_DLE_STAT_HANG = 5,
> +	MAC_AX_L0_TO_L1_PCIE_STUCK = 6,
> +	MAC_AX_L0_TO_L1_EVENT_MAX = 15,
> +};
> +
> +enum rtw89_mac_dbg_port_sel {
> +	/* CMAC 0 related */
> +	RTW89_DBG_PORT_SEL_PTCL_C0 = 0,
> +	RTW89_DBG_PORT_SEL_SCH_C0,
> +	RTW89_DBG_PORT_SEL_TMAC_C0,
> +	RTW89_DBG_PORT_SEL_RMAC_C0,
> +	RTW89_DBG_PORT_SEL_RMACST_C0,
> +	RTW89_DBG_PORT_SEL_RMAC_PLCP_C0,
> +	RTW89_DBG_PORT_SEL_TRXPTCL_C0,
> +	RTW89_DBG_PORT_SEL_TX_INFOL_C0,
> +	RTW89_DBG_PORT_SEL_TX_INFOH_C0,
> +	RTW89_DBG_PORT_SEL_TXTF_INFOL_C0,
> +	RTW89_DBG_PORT_SEL_TXTF_INFOH_C0,
> +	/* CMAC 1 related */
> +	RTW89_DBG_PORT_SEL_PTCL_C1,
> +	RTW89_DBG_PORT_SEL_SCH_C1,
> +	RTW89_DBG_PORT_SEL_TMAC_C1,
> +	RTW89_DBG_PORT_SEL_RMAC_C1,
> +	RTW89_DBG_PORT_SEL_RMACST_C1,
> +	RTW89_DBG_PORT_SEL_RMAC_PLCP_C1,
> +	RTW89_DBG_PORT_SEL_TRXPTCL_C1,
> +	RTW89_DBG_PORT_SEL_TX_INFOL_C1,
> +	RTW89_DBG_PORT_SEL_TX_INFOH_C1,
> +	RTW89_DBG_PORT_SEL_TXTF_INFOL_C1,
> +	RTW89_DBG_PORT_SEL_TXTF_INFOH_C1,
> +	/* DLE related */
> +	RTW89_DBG_PORT_SEL_WDE_BUFMGN_FREEPG,
> +	RTW89_DBG_PORT_SEL_WDE_BUFMGN_QUOTA,
> +	RTW89_DBG_PORT_SEL_WDE_BUFMGN_PAGELLT,
> +	RTW89_DBG_PORT_SEL_WDE_BUFMGN_PKTINFO,
> +	RTW89_DBG_PORT_SEL_WDE_QUEMGN_PREPKT,
> +	RTW89_DBG_PORT_SEL_WDE_QUEMGN_NXTPKT,
> +	RTW89_DBG_PORT_SEL_WDE_QUEMGN_QLNKTBL,
> +	RTW89_DBG_PORT_SEL_WDE_QUEMGN_QEMPTY,
> +	RTW89_DBG_PORT_SEL_PLE_BUFMGN_FREEPG,
> +	RTW89_DBG_PORT_SEL_PLE_BUFMGN_QUOTA,
> +	RTW89_DBG_PORT_SEL_PLE_BUFMGN_PAGELLT,
> +	RTW89_DBG_PORT_SEL_PLE_BUFMGN_PKTINFO,
> +	RTW89_DBG_PORT_SEL_PLE_QUEMGN_PREPKT,
> +	RTW89_DBG_PORT_SEL_PLE_QUEMGN_NXTPKT,
> +	RTW89_DBG_PORT_SEL_PLE_QUEMGN_QLNKTBL,
> +	RTW89_DBG_PORT_SEL_PLE_QUEMGN_QEMPTY,
> +	RTW89_DBG_PORT_SEL_PKTINFO,
> +	/* PCIE related */
> +	RTW89_DBG_PORT_SEL_PCIE_TXDMA,
> +	RTW89_DBG_PORT_SEL_PCIE_RXDMA,
> +	RTW89_DBG_PORT_SEL_PCIE_CVT,
> +	RTW89_DBG_PORT_SEL_PCIE_CXPL,
> +	RTW89_DBG_PORT_SEL_PCIE_IO,
> +	RTW89_DBG_PORT_SEL_PCIE_MISC,
> +	RTW89_DBG_PORT_SEL_PCIE_MISC2,
> +
> +	/* keep last */
> +	RTW89_DBG_PORT_SEL_LAST,
> +	RTW89_DBG_PORT_SEL_MAX = RTW89_DBG_PORT_SEL_LAST,
> +	RTW89_DBG_PORT_SEL_INVALID = RTW89_DBG_PORT_SEL_LAST,
> +};
> +
> +/* SRAM mem dump */
> +#define R_AX_INDIR_ACCESS_ENTRY 0x40000
> +
> +#define	STA_SCHED_BASE_ADDR		0x18808000
> +#define	RXPLD_FLTR_CAM_BASE_ADDR	0x18813000
> +#define	SECURITY_CAM_BASE_ADDR		0x18814000
> +#define	WOW_CAM_BASE_ADDR		0x18815000
> +#define	CMAC_TBL_BASE_ADDR		0x18840000
> +#define	ADDR_CAM_BASE_ADDR		0x18850000
> +#define	BSSID_CAM_BASE_ADDR		0x18853000
> +#define	BA_CAM_BASE_ADDR		0x18854000
> +#define	BCN_IE_CAM0_BASE_ADDR		0x18855000
> +#define	SHARED_BUF_BASE_ADDR		0x18700000
> +#define	DMAC_TBL_BASE_ADDR		0x18800000
> +#define	SHCUT_MACHDR_BASE_ADDR		0x18800800
> +#define	BCN_IE_CAM1_BASE_ADDR		0x188A0000
> +
> +#define CCTL_INFO_SIZE		32
> +
> +enum rtw89_mac_mem_sel {
> +	RTW89_MAC_MEM_SHARED_BUF,
> +	RTW89_MAC_MEM_DMAC_TBL,
> +	RTW89_MAC_MEM_SHCUT_MACHDR,
> +	RTW89_MAC_MEM_STA_SCHED,
> +	RTW89_MAC_MEM_RXPLD_FLTR_CAM,
> +	RTW89_MAC_MEM_SECURITY_CAM,
> +	RTW89_MAC_MEM_WOW_CAM,
> +	RTW89_MAC_MEM_CMAC_TBL,
> +	RTW89_MAC_MEM_ADDR_CAM,
> +	RTW89_MAC_MEM_BA_CAM,
> +	RTW89_MAC_MEM_BCN_IE_CAM0,
> +	RTW89_MAC_MEM_BCN_IE_CAM1,
> +
> +	/* keep last */
> +	RTW89_MAC_MEM_LAST,
> +	RTW89_MAC_MEM_MAX = RTW89_MAC_MEM_LAST,
> +	RTW89_MAC_MEM_INVALID = RTW89_MAC_MEM_LAST,
> +};
> +
> +enum rtw89_rpwm_req_pwr_state {
> +	RTW89_MAC_RPWM_REQ_PWR_STATE_ACTIVE = 0,
> +	RTW89_MAC_RPWM_REQ_PWR_STATE_BAND0_RFON = 1,
> +	RTW89_MAC_RPWM_REQ_PWR_STATE_BAND1_RFON = 2,
> +	RTW89_MAC_RPWM_REQ_PWR_STATE_BAND0_RFOFF = 3,
> +	RTW89_MAC_RPWM_REQ_PWR_STATE_BAND1_RFOFF = 4,
> +	RTW89_MAC_RPWM_REQ_PWR_STATE_CLK_GATED = 5,
> +	RTW89_MAC_RPWM_REQ_PWR_STATE_PWR_GATED = 6,
> +	RTW89_MAC_RPWM_REQ_PWR_STATE_HIOE_PWR_GATED = 7,
> +	RTW89_MAC_RPWM_REQ_PWR_STATE_MAX,
> +};
> +
> +struct rtw89_pwr_cfg {
> +	u16 addr;
> +	u8 cv_msk;
> +	u8 intf_msk;
> +	u8 base:4;
> +	u8 cmd:4;
> +	u8 msk;
> +	u8 val;
> +};
> +
> +enum rtw89_mac_c2h_ofld_func {
> +	RTW89_MAC_C2H_FUNC_EFUSE_DUMP,
> +	RTW89_MAC_C2H_FUNC_READ_RSP,
> +	RTW89_MAC_C2H_FUNC_PKT_OFLD_RSP,
> +	RTW89_MAC_C2H_FUNC_BCN_RESEND,
> +	RTW89_MAC_C2H_FUNC_MACID_PAUSE,
> +	RTW89_MAC_C2H_FUNC_OFLD_MAX,
> +};
> +
> +enum rtw89_mac_c2h_info_func {
> +	RTW89_MAC_C2H_FUNC_REC_ACK,
> +	RTW89_MAC_C2H_FUNC_DONE_ACK,
> +	RTW89_MAC_C2H_FUNC_C2H_LOG,
> +	RTW89_MAC_C2H_FUNC_INFO_MAX,
> +};
> +
> +enum rtw89_mac_c2h_class {
> +	RTW89_MAC_C2H_CLASS_INFO,
> +	RTW89_MAC_C2H_CLASS_OFLD,
> +	RTW89_MAC_C2H_CLASS_TWT,
> +	RTW89_MAC_C2H_CLASS_WOW,
> +	RTW89_MAC_C2H_CLASS_MCC,
> +	RTW89_MAC_C2H_CLASS_FWDBG,
> +	RTW89_MAC_C2H_CLASS_MAX,
> +};
> +
> +struct rtw89_mac_ax_coex {
> +#define RTW89_MAC_AX_COEX_RTK_MODE 0
> +#define RTW89_MAC_AX_COEX_CSR_MODE 1
> +	u8 pta_mode;
> +#define RTW89_MAC_AX_COEX_INNER 0
> +#define RTW89_MAC_AX_COEX_OUTPUT 1
> +#define RTW89_MAC_AX_COEX_INPUT 2
> +	u8 direction;
> +};
> +
> +struct rtw89_mac_ax_plt {
> +#define RTW89_MAC_AX_PLT_LTE_RX BIT(0)
> +#define RTW89_MAC_AX_PLT_GNT_BT_TX BIT(1)
> +#define RTW89_MAC_AX_PLT_GNT_BT_RX BIT(2)
> +#define RTW89_MAC_AX_PLT_GNT_WL BIT(3)
> +	u8 band;
> +	u8 tx;
> +	u8 rx;
> +};
> +
> +enum rtw89_mac_bf_rrsc_rate {
> +	RTW89_MAC_BF_RRSC_6M = 0,
> +	RTW89_MAC_BF_RRSC_9M = 1,
> +	RTW89_MAC_BF_RRSC_12M,
> +	RTW89_MAC_BF_RRSC_18M,
> +	RTW89_MAC_BF_RRSC_24M,
> +	RTW89_MAC_BF_RRSC_36M,
> +	RTW89_MAC_BF_RRSC_48M,
> +	RTW89_MAC_BF_RRSC_54M,
> +	RTW89_MAC_BF_RRSC_HT_MSC0,
> +	RTW89_MAC_BF_RRSC_HT_MSC1,
> +	RTW89_MAC_BF_RRSC_HT_MSC2,
> +	RTW89_MAC_BF_RRSC_HT_MSC3,
> +	RTW89_MAC_BF_RRSC_HT_MSC4,
> +	RTW89_MAC_BF_RRSC_HT_MSC5,
> +	RTW89_MAC_BF_RRSC_HT_MSC6,
> +	RTW89_MAC_BF_RRSC_HT_MSC7,
> +	RTW89_MAC_BF_RRSC_VHT_MSC0,
> +	RTW89_MAC_BF_RRSC_VHT_MSC1,
> +	RTW89_MAC_BF_RRSC_VHT_MSC2,
> +	RTW89_MAC_BF_RRSC_VHT_MSC3,
> +	RTW89_MAC_BF_RRSC_VHT_MSC4,
> +	RTW89_MAC_BF_RRSC_VHT_MSC5,
> +	RTW89_MAC_BF_RRSC_VHT_MSC6,
> +	RTW89_MAC_BF_RRSC_VHT_MSC7,
> +	RTW89_MAC_BF_RRSC_HE_MSC0,
> +	RTW89_MAC_BF_RRSC_HE_MSC1,
> +	RTW89_MAC_BF_RRSC_HE_MSC2,
> +	RTW89_MAC_BF_RRSC_HE_MSC3,
> +	RTW89_MAC_BF_RRSC_HE_MSC4,
> +	RTW89_MAC_BF_RRSC_HE_MSC5,
> +	RTW89_MAC_BF_RRSC_HE_MSC6,
> +	RTW89_MAC_BF_RRSC_HE_MSC7 = 31,
> +	RTW89_MAC_BF_RRSC_MAX = 32
> +};
> +
> +#define RTW89_R32_EA		0xEAEAEAEA
> +#define RTW89_R32_DEAD		0xDEADBEEF
> +#define MAC_REG_POOL_COUNT	10
> +#define ACCESS_CMAC(_addr) \
> +	({typeof(_addr) __addr = (_addr); \
> +	  __addr >= R_AX_CMAC_REG_START && __addr <= R_AX_CMAC_REG_END; })
> +
> +#define PTCL_IDLE_POLL_CNT	10000
> +#define SW_CVR_DUR_US	8
> +#define SW_CVR_CNT	8
> +
> +#define DLE_BOUND_UNIT (8 * 1024)
> +#define DLE_WAIT_CNT 2000
> +#define TRXCFG_WAIT_CNT	2000
> +
> +#define RTW89_WDE_PG_64		64
> +#define RTW89_WDE_PG_128	128
> +#define RTW89_WDE_PG_256	256
> +
> +#define S_AX_WDE_PAGE_SEL_64	0
> +#define S_AX_WDE_PAGE_SEL_128	1
> +#define S_AX_WDE_PAGE_SEL_256	2
> +
> +#define RTW89_PLE_PG_64		64
> +#define RTW89_PLE_PG_128	128
> +#define RTW89_PLE_PG_256	256
> +
> +#define S_AX_PLE_PAGE_SEL_64	0
> +#define S_AX_PLE_PAGE_SEL_128	1
> +#define S_AX_PLE_PAGE_SEL_256	2
> +
> +#define SDIO_LOCAL_BASE_ADDR    0x80000000
> +
> +#define	PWR_CMD_WRITE		0
> +#define	PWR_CMD_POLL		1
> +#define	PWR_CMD_DELAY		2
> +#define	PWR_CMD_END		3
> +
> +#define	PWR_INTF_MSK_SDIO	BIT(0)
> +#define	PWR_INTF_MSK_USB	BIT(1)
> +#define	PWR_INTF_MSK_PCIE	BIT(2)
> +#define	PWR_INTF_MSK_ALL	0x7
> +
> +#define PWR_BASE_MAC		0
> +#define PWR_BASE_USB		1
> +#define PWR_BASE_PCIE		2
> +#define PWR_BASE_SDIO		3
> +
> +#define	PWR_CV_MSK_A		BIT(0)
> +#define	PWR_CV_MSK_B		BIT(1)
> +#define	PWR_CV_MSK_C		BIT(2)
> +#define	PWR_CV_MSK_D		BIT(3)
> +#define	PWR_CV_MSK_E		BIT(4)
> +#define	PWR_CV_MSK_F		BIT(5)
> +#define	PWR_CV_MSK_G		BIT(6)
> +#define	PWR_CV_MSK_TEST		BIT(7)
> +#define	PWR_CV_MSK_ALL		0xFF
> +
> +#define	PWR_DELAY_US		0
> +#define	PWR_DELAY_MS		1
> +
> +/* STA scheduler */
> +#define SS_MACID_SH		8
> +#define SS_TX_LEN_MSK		0x1FFFFF
> +#define SS_CTRL1_R_TX_LEN	5
> +#define SS_CTRL1_R_NEXT_LINK	20
> +#define SS_LINK_SIZE		256
> +
> +/* MAC debug port */
> +#define TMAC_DBG_SEL_C0 0xA5
> +#define RMAC_DBG_SEL_C0 0xA6
> +#define TRXPTCL_DBG_SEL_C0 0xA7
> +#define TMAC_DBG_SEL_C1 0xB5
> +#define RMAC_DBG_SEL_C1 0xB6
> +#define TRXPTCL_DBG_SEL_C1 0xB7
> +#define FW_PROG_CNTR_DBG_SEL 0xF2
> +#define PCIE_TXDMA_DBG_SEL 0x30
> +#define PCIE_RXDMA_DBG_SEL 0x31
> +#define PCIE_CVT_DBG_SEL 0x32
> +#define PCIE_CXPL_DBG_SEL 0x33
> +#define PCIE_IO_DBG_SEL 0x37
> +#define PCIE_MISC_DBG_SEL 0x38
> +#define PCIE_MISC2_DBG_SEL 0x00
> +#define MAC_DBG_SEL 1
> +#define RMAC_CMAC_DBG_SEL 1
> +
> +/* TRXPTCL dbg port sel */
> +#define TRXPTRL_DBG_SEL_TMAC 0
> +#define TRXPTRL_DBG_SEL_RMAC 1
> +
> +struct rtw89_cpuio_ctrl {
> +	u16 pkt_num;
> +	u16 start_pktid;
> +	u16 end_pktid;
> +	u8 cmd_type;
> +	u8 macid;
> +	u8 src_pid;
> +	u8 src_qid;
> +	u8 dst_pid;
> +	u8 dst_qid;
> +	u16 pktid;
> +};
> +
> +struct rtw89_mac_dbg_port_info {
> +	u32 sel_addr;
> +	u8 sel_byte;
> +	u32 sel_msk;
> +	u32 srt;
> +	u32 end;
> +	u32 rd_addr;
> +	u8 rd_byte;
> +	u32 rd_msk;
> +};
> +
> +#define QLNKTBL_ADDR_INFO_SEL BIT(0)
> +#define QLNKTBL_ADDR_INFO_SEL_0 0
> +#define QLNKTBL_ADDR_INFO_SEL_1 1
> +#define QLNKTBL_ADDR_TBL_IDX_MASK GENMASK(10, 1)
> +#define QLNKTBL_DATA_SEL1_PKT_CNT_MASK GENMASK(11, 0)
> +
> +struct rtw89_mac_dle_dfi_ctrl {
> +	enum rtw89_mac_dle_ctrl_type type;
> +	u32 target;
> +	u32 addr;
> +	u32 out_data;
> +};
> +
> +struct rtw89_mac_dle_dfi_quota {
> +	enum rtw89_mac_dle_ctrl_type dle_type;
> +	u32 qtaid;
> +	u16 rsv_pgnum;
> +	u16 use_pgnum;
> +};
> +
> +struct rtw89_mac_dle_dfi_qempty {
> +	enum rtw89_mac_dle_ctrl_type dle_type;
> +	u32 grpsel;
> +	u32 qempty;
> +};
> +
> +/* Define DBG and recovery enum */
> +enum mac_ax_err_info {
> +	/* Get error info */
> +
> +	/* L0 */
> +	MAC_AX_ERR_L0_ERR_CMAC0 = 0x0001,
> +	MAC_AX_ERR_L0_ERR_CMAC1 = 0x0002,
> +	MAC_AX_ERR_L0_RESET_DONE = 0x0003,
> +	MAC_AX_ERR_L0_PROMOTE_TO_L1 = 0x0010,
> +
> +	/* L1 */
> +	MAC_AX_ERR_L1_ERR_DMAC = 0x1000,
> +	MAC_AX_ERR_L1_RESET_DISABLE_DMAC_DONE = 0x1001,
> +	MAC_AX_ERR_L1_RESET_RECOVERY_DONE = 0x1002,
> +	MAC_AX_ERR_L1_PROMOTE_TO_L2 = 0x1010,
> +	MAC_AX_ERR_L1_RCVY_STOP_DONE = 0x1011,
> +
> +	/* L2 */
> +	/* address hole (master) */
> +	MAC_AX_ERR_L2_ERR_AH_DMA = 0x2000,
> +	MAC_AX_ERR_L2_ERR_AH_HCI = 0x2010,
> +	MAC_AX_ERR_L2_ERR_AH_RLX4081 = 0x2020,
> +	MAC_AX_ERR_L2_ERR_AH_IDDMA = 0x2030,
> +	MAC_AX_ERR_L2_ERR_AH_HIOE = 0x2040,
> +	MAC_AX_ERR_L2_ERR_AH_IPSEC = 0x2050,
> +	MAC_AX_ERR_L2_ERR_AH_RX4281 = 0x2060,
> +	MAC_AX_ERR_L2_ERR_AH_OTHERS = 0x2070,
> +
> +	/* AHB bridge timeout (master) */
> +	MAC_AX_ERR_L2_ERR_AHB_TO_DMA = 0x2100,
> +	MAC_AX_ERR_L2_ERR_AHB_TO_HCI = 0x2110,
> +	MAC_AX_ERR_L2_ERR_AHB_TO_RLX4081 = 0x2120,
> +	MAC_AX_ERR_L2_ERR_AHB_TO_IDDMA = 0x2130,
> +	MAC_AX_ERR_L2_ERR_AHB_TO_HIOE = 0x2140,
> +	MAC_AX_ERR_L2_ERR_AHB_TO_IPSEC = 0x2150,
> +	MAC_AX_ERR_L2_ERR_AHB_TO_RX4281 = 0x2160,
> +	MAC_AX_ERR_L2_ERR_AHB_TO_OTHERS = 0x2170,
> +
> +	/* APB_SA bridge timeout (master + slave) */
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_DMA_WVA = 0x2200,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_DMA_UART = 0x2201,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_DMA_CPULOCAL = 0x2202,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_DMA_AXIDMA = 0x2203,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_DMA_HIOE = 0x2204,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_DMA_IDDMA = 0x2205,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_DMA_IPSEC = 0x2206,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_DMA_WON = 0x2207,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_DMA_WDMAC = 0x2208,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_DMA_WCMAC = 0x2209,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_DMA_OTHERS = 0x220A,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HCI_WVA = 0x2210,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HCI_UART = 0x2211,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HCI_CPULOCAL = 0x2212,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HCI_AXIDMA = 0x2213,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HCI_HIOE = 0x2214,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HCI_IDDMA = 0x2215,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HCI_IPSEC = 0x2216,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HCI_WDMAC = 0x2218,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HCI_WCMAC = 0x2219,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HCI_OTHERS = 0x221A,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RLX4081_WVA = 0x2220,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RLX4081_UART = 0x2221,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RLX4081_CPULOCAL = 0x2222,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RLX4081_AXIDMA = 0x2223,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RLX4081_HIOE = 0x2224,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RLX4081_IDDMA = 0x2225,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RLX4081_IPSEC = 0x2226,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RLX4081_WON = 0x2227,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RLX4081_WDMAC = 0x2228,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RLX4081_WCMAC = 0x2229,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RLX4081_OTHERS = 0x222A,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IDDMA_WVA = 0x2230,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IDDMA_UART = 0x2231,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IDDMA_CPULOCAL = 0x2232,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IDDMA_AXIDMA = 0x2233,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IDDMA_HIOE = 0x2234,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IDDMA_IDDMA = 0x2235,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IDDMA_IPSEC = 0x2236,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IDDMA_WON = 0x2237,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IDDMA_WDMAC = 0x2238,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IDDMA_WCMAC = 0x2239,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IDDMA_OTHERS = 0x223A,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HIOE_WVA = 0x2240,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HIOE_UART = 0x2241,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HIOE_CPULOCAL = 0x2242,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HIOE_AXIDMA = 0x2243,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HIOE_HIOE = 0x2244,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HIOE_IDDMA = 0x2245,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HIOE_IPSEC = 0x2246,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HIOE_WON = 0x2247,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HIOE_WDMAC = 0x2248,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HIOE_WCMAC = 0x2249,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_HIOE_OTHERS = 0x224A,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IPSEC_WVA = 0x2250,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IPSEC_UART = 0x2251,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IPSEC_CPULOCAL = 0x2252,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IPSEC_AXIDMA = 0x2253,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IPSEC_HIOE = 0x2254,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IPSEC_IDDMA = 0x2255,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IPSEC_IPSEC = 0x2256,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IPSEC_WON = 0x2257,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IPSEC_WDMAC = 0x2258,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IPSEC_WCMAC = 0x2259,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_IPSEC_OTHERS = 0x225A,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RX4281_WVA = 0x2260,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RX4281_UART = 0x2261,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RX4281_CPULOCAL = 0x2262,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RX4281_AXIDMA = 0x2263,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RX4281_HIOE = 0x2264,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RX4281_IDDMA = 0x2265,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RX4281_IPSEC = 0x2266,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RX4281_WON = 0x2267,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RX4281_WDMAC = 0x2268,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RX4281_WCMAC = 0x2269,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_RX4281_OTHERS = 0x226A,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_OTHERS_WVA = 0x2270,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_OTHERS_UART = 0x2271,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_OTHERS_CPULOCAL = 0x2272,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_OTHERS_AXIDMA = 0x2273,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_OTHERS_HIOE = 0x2274,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_OTHERS_IDDMA = 0x2275,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_OTHERS_IPSEC = 0x2276,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_OTHERS_WON = 0x2277,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_OTHERS_WDMAC = 0x2278,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_OTHERS_WCMAC = 0x2279,
> +	MAC_AX_ERR_L2_ERR_APB_SA_TO_OTHERS_OTHERS = 0x227A,
> +
> +	/* APB_BBRF bridge timeout (master) */
> +	MAC_AX_ERR_L2_ERR_APB_BBRF_TO_DMA = 0x2300,
> +	MAC_AX_ERR_L2_ERR_APB_BBRF_TO_HCI = 0x2310,
> +	MAC_AX_ERR_L2_ERR_APB_BBRF_TO_RLX4081 = 0x2320,
> +	MAC_AX_ERR_L2_ERR_APB_BBRF_TO_IDDMA = 0x2330,
> +	MAC_AX_ERR_L2_ERR_APB_BBRF_TO_HIOE = 0x2340,
> +	MAC_AX_ERR_L2_ERR_APB_BBRF_TO_IPSEC = 0x2350,
> +	MAC_AX_ERR_L2_ERR_APB_BBRF_TO_RX4281 = 0x2360,
> +	MAC_AX_ERR_L2_ERR_APB_BBRF_TO_OTHERS = 0x2370,
> +	MAC_AX_ERR_L2_RESET_DONE = 0x2400,
> +	MAC_AX_ERR_CPU_EXCEPTION = 0x3000,
> +	MAC_AX_GET_ERR_MAX,
> +	MAC_AX_DUMP_SHAREBUFF_INDICATOR = 0x80000000,
> +
> +	/* set error info */
> +	MAC_AX_ERR_L1_DISABLE_EN = 0x0001,
> +	MAC_AX_ERR_L1_RCVY_EN = 0x0002,
> +	MAC_AX_ERR_L1_RCVY_STOP_REQ = 0x0003,
> +	MAC_AX_ERR_L1_RCVY_START_REQ = 0x0004,
> +	MAC_AX_ERR_L0_CFG_NOTIFY = 0x0010,
> +	MAC_AX_ERR_L0_CFG_DIS_NOTIFY = 0x0011,
> +	MAC_AX_ERR_L0_CFG_HANDSHAKE = 0x0012,
> +	MAC_AX_ERR_L0_RCVY_EN = 0x0013,
> +	MAC_AX_SET_ERR_MAX,
> +};
> +
> +extern struct rtw89_hfc_prec_cfg rtw_hfc_preccfg_pcie;
> +extern struct rtw89_hfc_prec_cfg rtw_hfc_preccfg_pcie_wd128;
> +extern struct rtw89_hfc_prec_cfg rtw_hfc_preccfg_pcie_stf;
> +extern struct rtw89_dle_size wde_size0;
> +extern struct rtw89_dle_size wde_size1;
> +extern struct rtw89_dle_size wde_size2;
> +extern struct rtw89_dle_size wde_size3;
> +extern struct rtw89_dle_size wde_size4;
> +extern struct rtw89_dle_size wde_size5;
> +extern struct rtw89_dle_size wde_size6;
> +extern struct rtw89_dle_size wde_size7;
> +extern struct rtw89_dle_size wde_size8;
> +extern struct rtw89_dle_size wde_size9;
> +extern struct rtw89_dle_size wde_size10;
> +extern struct rtw89_dle_size ple_size0;
> +extern struct rtw89_dle_size ple_size2;
> +extern struct rtw89_dle_size ple_size3;
> +extern struct rtw89_dle_size ple_size4;
> +extern struct rtw89_dle_size ple_size5;
> +extern struct rtw89_dle_size ple_size6;
> +extern struct rtw89_dle_size ple_size7;
> +extern struct rtw89_dle_size ple_size8;
> +extern struct rtw89_dle_size ple_size9;
> +extern struct rtw89_dle_size ple_size10;
> +extern struct rtw89_wde_quota wde_qt0;
> +extern struct rtw89_wde_quota wde_qt1;
> +extern struct rtw89_wde_quota wde_qt2;
> +extern struct rtw89_wde_quota wde_qt3;
> +extern struct rtw89_wde_quota wde_qt4;
> +extern struct rtw89_wde_quota wde_qt5;
> +extern struct rtw89_wde_quota wde_qt6;
> +extern struct rtw89_wde_quota wde_qt7;
> +extern struct rtw89_wde_quota wde_qt8;
> +extern struct rtw89_wde_quota wde_qt9;
> +extern struct rtw89_ple_quota ple_qt0;
> +extern struct rtw89_ple_quota ple_qt1;
> +extern struct rtw89_ple_quota ple_qt4;
> +extern struct rtw89_ple_quota ple_qt5;
> +extern struct rtw89_ple_quota ple_qt8;
> +extern struct rtw89_ple_quota ple_qt9;
> +extern struct rtw89_ple_quota ple_qt10;
> +extern struct rtw89_ple_quota ple_qt11;
> +extern struct rtw89_ple_quota ple_qt12;
> +extern struct rtw89_ple_quota ple_qt13;
> +extern struct rtw89_ple_quota ple_qt14;
> +extern struct rtw89_ple_quota ple_qt15;
> +extern struct rtw89_ple_quota ple_qt16;
> +extern struct rtw89_ple_quota ple_qt18;
> +extern struct rtw89_ple_quota ple_qt19;
> +extern struct rtw89_ple_quota ple_qt20;
> +extern struct rtw89_ple_quota ple_qt21;
> +extern struct rtw89_ple_quota ple_qt22;
> +extern struct rtw89_ple_quota ple_qt23;
> +extern struct rtw89_ple_quota ple_qt24;
> +
> +static inline u32 rtw89_mac_reg_by_idx(u32 reg_base, u8 band)
> +{
> +	return band == 0 ? reg_base : (reg_base + 0x2000);
> +}
> +
> +static inline u32 rtw89_mac_reg_by_port(u32 base, u8 port, u8 mac_idx)
> +{
> +	return rtw89_mac_reg_by_idx(base + port * 0x40, mac_idx);
> +}
> +
> +static inline u32
> +rtw89_read32_port_mask(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
> +		       u32 base, u32 mask)
> +{
> +	u32 reg;
> +
> +	reg = rtw89_mac_reg_by_port(base, rtwvif->port, rtwvif->mac_idx);
> +	return rtw89_read32_mask(rtwdev, reg, mask);
> +}
> +
> +static inline void
> +rtw89_write32_port(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif, u32 base,
> +		   u32 data)
> +{
> +	u32 reg;
> +
> +	reg = rtw89_mac_reg_by_port(base, rtwvif->port, rtwvif->mac_idx);
> +	rtw89_write32(rtwdev, reg, data);
> +}
> +
> +static inline void
> +rtw89_write32_port_mask(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
> +			u32 base, u32 mask, u32 data)
> +{
> +	u32 reg;
> +
> +	reg = rtw89_mac_reg_by_port(base, rtwvif->port, rtwvif->mac_idx);
> +	rtw89_write32_mask(rtwdev, reg, mask, data);
> +}
> +
> +static inline void
> +rtw89_write16_port_mask(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
> +			u32 base, u32 mask, u16 data)
> +{
> +	u32 reg;
> +
> +	reg = rtw89_mac_reg_by_port(base, rtwvif->port, rtwvif->mac_idx);
> +	rtw89_write16_mask(rtwdev, reg, mask, data);
> +}
> +
> +static inline void
> +rtw89_write32_port_clr(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
> +		       u32 base, u32 bit)
> +{
> +	u32 reg;
> +
> +	reg = rtw89_mac_reg_by_port(base, rtwvif->port, rtwvif->mac_idx);
> +	rtw89_write32_clr(rtwdev, reg, bit);
> +}
> +
> +static inline void
> +rtw89_write16_port_clr(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
> +		       u32 base, u16 bit)
> +{
> +	u32 reg;
> +
> +	reg = rtw89_mac_reg_by_port(base, rtwvif->port, rtwvif->mac_idx);
> +	rtw89_write16_clr(rtwdev, reg, bit);
> +}
> +
> +static inline void
> +rtw89_write32_port_set(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
> +		       u32 base, u32 bit)
> +{
> +	u32 reg;
> +
> +	reg = rtw89_mac_reg_by_port(base, rtwvif->port, rtwvif->mac_idx);
> +	rtw89_write32_set(rtwdev, reg, bit);
> +}
> +
> +int rtw89_mac_pwr_on(struct rtw89_dev *rtwdev);
> +void rtw89_mac_pwr_off(struct rtw89_dev *rtwdev);
> +int rtw89_mac_partial_init(struct rtw89_dev *rtwdev);
> +int rtw89_mac_init(struct rtw89_dev *rtwdev);
> +int rtw89_mac_check_mac_en(struct rtw89_dev *rtwdev, u8 band,
> +			   enum rtw89_mac_hwmod_sel sel);
> +int rtw89_mac_write_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 val);
> +int rtw89_mac_read_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 *val);
> +int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
> +int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
> +int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
> +void rtw89_mac_enable_bb_rf(struct rtw89_dev *rtwdev);
> +void rtw89_mac_disable_bb_rf(struct rtw89_dev *rtwdev);
> +u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev);
> +int rtw89_mac_set_err_status(struct rtw89_dev *rtwdev, u32 err);
> +void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
> +			  u32 len, u8 class, u8 func);
> +int rtw89_mac_stop_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx,
> +			  u16 *tx_en, enum rtw89_sch_tx_sel sel);
> +int rtw89_mac_resume_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx, u16 tx_en);
> +int rtw89_mac_cfg_ppdu_status(struct rtw89_dev *rtwdev, u8 mac_ids, bool enable);
> +void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev, u8 mac_idx);
> +void rtw89_mac_flush_txq(struct rtw89_dev *rtwdev, u32 queues, bool drop);
> +int rtw89_mac_coex_init(struct rtw89_dev *rtwdev, const struct rtw89_mac_ax_coex *coex);
> +int rtw89_mac_cfg_gnt(struct rtw89_dev *rtwdev,
> +		      const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
> +int rtw89_mac_cfg_plt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt);
> +u16 rtw89_mac_get_plt(struct rtw89_dev *rtwdev, u8 band);
> +void rtw89_mac_cfg_sb(struct rtw89_dev *rtwdev, u32 val);
> +u32 rtw89_mac_get_sb(struct rtw89_dev *rtwdev);
> +bool rtw89_mac_get_ctrl_path(struct rtw89_dev *rtwdev);
> +int rtw89_mac_cfg_ctrl_path(struct rtw89_dev *rtwdev, bool wl);
> +bool rtw89_mac_get_txpwr_cr(struct rtw89_dev *rtwdev,
> +			    enum rtw89_phy_idx phy_idx,
> +			    u32 reg_base, u32 *cr);
> +void rtw89_mac_power_mode_change(struct rtw89_dev *rtwdev, bool enter);
> +void rtw89_mac_bf_assoc(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
> +			struct ieee80211_sta *sta);
> +void rtw89_mac_bf_disassoc(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
> +			   struct ieee80211_sta *sta);
> +void rtw89_mac_bf_set_gid_table(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
> +				struct ieee80211_bss_conf *conf);
> +void rtw89_mac_bf_monitor_calc(struct rtw89_dev *rtwdev,
> +			       struct ieee80211_sta *sta, bool disconnect);
> +void _rtw89_mac_bf_monitor_track(struct rtw89_dev *rtwdev);
> +void rtw89_restore_vif_cfg_iter(void *data, u8 *mac, struct ieee80211_vif *vif);
> +void rtw89_remove_vif_cfg_iter(void *data, u8 *mac, struct ieee80211_vif *vif);
> +int rtw89_mac_set_hw_muedca_ctrl(struct rtw89_dev *rtwdev,
> +				 struct rtw89_vif *rtwvif, bool en);
> +
> +static inline void rtw89_mac_bf_monitor_track(struct rtw89_dev *rtwdev)
> +{
> +	if (!test_bit(RTW89_FLAG_BFEE_MON, rtwdev->flags))
> +		return;
> +
> +	_rtw89_mac_bf_monitor_track(rtwdev);
> +}
> +
> +static inline int rtw89_mac_txpwr_read32(struct rtw89_dev *rtwdev,
> +					 enum rtw89_phy_idx phy_idx,
> +					 u32 reg_base, u32 *val)
> +{
> +	u32 cr;
> +
> +	if (!rtw89_mac_get_txpwr_cr(rtwdev, phy_idx, reg_base, &cr))
> +		return -EINVAL;
> +
> +	*val = rtw89_read32(rtwdev, cr);
> +	return 0;
> +}
> +
> +static inline int rtw89_mac_txpwr_write32(struct rtw89_dev *rtwdev,
> +					  enum rtw89_phy_idx phy_idx,
> +					  u32 reg_base, u32 val)
> +{
> +	u32 cr;
> +
> +	if (!rtw89_mac_get_txpwr_cr(rtwdev, phy_idx, reg_base, &cr))
> +		return -EINVAL;
> +
> +	rtw89_write32(rtwdev, cr, val);
> +	return 0;
> +}
> +
> +static inline int rtw89_mac_txpwr_write32_mask(struct rtw89_dev *rtwdev,
> +					       enum rtw89_phy_idx phy_idx,
> +					       u32 reg_base, u32 mask, u32 val)
> +{
> +	u32 cr;
> +
> +	if (!rtw89_mac_get_txpwr_cr(rtwdev, phy_idx, reg_base, &cr))
> +		return -EINVAL;
> +
> +	rtw89_write32_mask(rtwdev, cr, mask, val);
> +	return 0;
> +}
> +
> +int rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
> +			  bool resume, u32 tx_time);
> +int rtw89_mac_get_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
> +			  u32 *tx_time);
> +int rtw89_mac_set_tx_retry_limit(struct rtw89_dev *rtwdev,
> +				 struct rtw89_sta *rtwsta,
> +				 bool resume, u8 tx_retry);
> +int rtw89_mac_get_tx_retry_limit(struct rtw89_dev *rtwdev,
> +				 struct rtw89_sta *rtwsta, u8 *tx_retry);
> +
> +#endif
> -- 
> 2.25.1

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
