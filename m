Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577BF535646
	for <lists+linux-wireless@lfdr.de>; Fri, 27 May 2022 01:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242861AbiEZXBo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 May 2022 19:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiEZXBn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 May 2022 19:01:43 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9F1E08
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 16:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653606100; x=1685142100;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e/iGjFBHBiXYwZ+F0yAgDhbcHCuQHbndaIL3Xe8YFbs=;
  b=YD6IepUhwqnOLs6JQGbaJ9H9g94gJIQqP+TzZ0MfCl/1jG03M2qhkILg
   kZ+YQY8zo1eJCWMWV2b0Q5Ugg+G8eI8Tshb0gnKhlokyGaT4MENMSv+kA
   zP9GdD08YR/QA+KWKqfIZlVHmyykiQNz10tNx0GR1DQ4ymXEpp5p9zXoQ
   Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 May 2022 16:01:39 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 16:01:39 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 26 May 2022 16:01:39 -0700
Received: from [10.110.93.98] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 26 May
 2022 16:01:38 -0700
Message-ID: <e16250cb-ad5a-2a0c-27b1-b361ff7c7bb4@quicinc.com>
Date:   Thu, 26 May 2022 16:01:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC v2 42/96] cl8k: add main.c
Content-Language: en-US
To:     <viktor.barna@celeno.com>, <linux-wireless@vger.kernel.org>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        "Maksym Kokhan" <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
 <20220524113502.1094459-43-viktor.barna@celeno.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220524113502.1094459-43-viktor.barna@celeno.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/24/2022 4:34 AM, viktor.barna@celeno.com wrote:
> From: Viktor Barna <viktor.barna@celeno.com>
> 
> (Part of the split. Please, take a look at the cover letter for more
> details).
> 
> Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
> ---
>   drivers/net/wireless/celeno/cl8k/main.c | 603 ++++++++++++++++++++++++
>   1 file changed, 603 insertions(+)
>   create mode 100644 drivers/net/wireless/celeno/cl8k/main.c
> 
> diff --git a/drivers/net/wireless/celeno/cl8k/main.c b/drivers/net/wireless/celeno/cl8k/main.c
> new file mode 100644
> index 000000000000..08abb16987ef
> --- /dev/null
> +++ b/drivers/net/wireless/celeno/cl8k/main.c
> @@ -0,0 +1,603 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
> +
> +#include "tx.h"
> +#include "reg/reg_access.h"
> +#include "reg/reg_defs.h"
> +#include "stats.h"
> +#include "maintenance.h"
> +#include "vns.h"
> +#include "traffic.h"
> +#include "sounding.h"
> +#include "recovery.h"
> +#include "rates.h"
> +#include "utils.h"
> +#include "phy.h"
> +#include "radio.h"
> +#include "dsp.h"
> +#include "dfs.h"
> +#include "tcv.h"
> +#include "mac_addr.h"
> +#include "bf.h"
> +#include "rfic.h"
> +#include "e2p.h"
> +#include "chip.h"
> +#include "regdom.h"
> +#include "platform.h"
> +#include "mac80211.h"
> +#include "main.h"
> +
> +MODULE_DESCRIPTION("Celeno 11ax driver for Linux");
> +MODULE_VERSION(CONFIG_CL8K_VERSION);
> +MODULE_AUTHOR("Copyright(c) 2022 Celeno Communications Ltd");
> +MODULE_LICENSE("Dual BSD/GPL");
> +
> +static struct ieee80211_ops cl_ops = {

const?

> +	.tx                     = cl_ops_tx,
> +	.start                  = cl_ops_start,
> +	.stop                   = cl_ops_stop,
> +	.add_interface          = cl_ops_add_interface,
> +	.remove_interface       = cl_ops_remove_interface,
> +	.config                 = cl_ops_config,
> +	.bss_info_changed       = cl_ops_bss_info_changed,
> +	.start_ap               = cl_ops_start_ap,
> +	.stop_ap                = cl_ops_stop_ap,
> +	.prepare_multicast      = cl_ops_prepare_multicast,
> +	.configure_filter       = cl_ops_configure_filter,
> +	.set_key                = cl_ops_set_key,
> +	.sw_scan_start          = cl_ops_sw_scan_start,
> +	.sw_scan_complete       = cl_ops_sw_scan_complete,
> +	.sta_state              = cl_ops_sta_state,
> +	.sta_notify             = cl_ops_sta_notify,
> +	.conf_tx                = cl_ops_conf_tx,
> +	.sta_rc_update          = cl_ops_sta_rc_update,
> +	.ampdu_action           = cl_ops_ampdu_action,
> +	.post_channel_switch    = cl_ops_post_channel_switch,
> +	.flush                  = cl_ops_flush,
> +	.tx_frames_pending      = cl_ops_tx_frames_pending,
> +	.reconfig_complete      = cl_ops_reconfig_complete,
> +	.get_txpower            = cl_ops_get_txpower,
> +	.set_rts_threshold      = cl_ops_set_rts_threshold,
> +	.event_callback         = cl_ops_event_callback,
> +	.set_tim                = cl_ops_set_tim,
> +	.get_antenna            = cl_ops_get_antenna,
> +	.get_expected_throughput = cl_ops_get_expected_throughput,
> +	.sta_statistics         = cl_ops_sta_statistics,
> +	.get_survey             = cl_ops_get_survey,
> +	.hw_scan                = cl_ops_hw_scan,
> +	.cancel_hw_scan         = cl_ops_cancel_hw_scan
> +};
> +
> +static void cl_drv_workqueue_create(struct cl_hw *cl_hw)
> +{
> +	if (!cl_hw->drv_workqueue)
> +		cl_hw->drv_workqueue = create_singlethread_workqueue("drv_workqueue");
> +}
> +
> +static void cl_drv_workqueue_destroy(struct cl_hw *cl_hw)
> +{
> +	if (cl_hw->drv_workqueue) {
> +		destroy_workqueue(cl_hw->drv_workqueue);
> +		cl_hw->drv_workqueue = NULL;
> +	}
> +}
> +
> +static int cl_main_alloc(struct cl_hw *cl_hw)
> +{
> +	int ret = 0;

avoid initializers that are always overwritten, especially ones that are 
overwritten by the very first line of code

> +
> +	ret = cl_phy_data_alloc(cl_hw);
> +	if (ret)
> +		return ret;
> +
> +	ret = cl_calib_common_tables_alloc(cl_hw);
> +	if (ret)
> +		return ret;
> +
> +	ret = cl_power_table_alloc(cl_hw);
> +	if (ret)
> +		return ret;
> +
> +	return ret;
> +}
> +
> +static void cl_main_free(struct cl_hw *cl_hw)
> +{
> +	cl_phy_data_free(cl_hw);
> +	cl_calib_common_tables_free(cl_hw);
> +	cl_power_table_free(cl_hw);

hint: consider performing deinit steps in reverse order of init steps. 
it may not always matter, but when it does, you'll be happy that you're 
doing things consistently -- what happens when you try taking off your 
socks before you take off your shoes? :)

> +}
> +
> +static void cl_free_hw(struct cl_hw *cl_hw)
> +{
> +	if (!cl_hw)
> +		return;
> +
> +	cl_temperature_wait_for_measurement(cl_hw->chip, cl_hw->tcv_idx);
> +
> +	cl_tcv_config_free(cl_hw);
> +
> +	if (cl_hw->hw->wiphy->registered)
> +		ieee80211_unregister_hw(cl_hw->hw);
> +
> +	cl_chip_unset_hw(cl_hw->chip, cl_hw);
> +	ieee80211_free_hw(cl_hw->hw);

I'm paranoid so I always set pointers to NULL when I've freed the 
underlying data so that nothing else can later dereference them, and 
potentially lead to use-after-free or double-free

> +}
> +
> +static void cl_free_chip(struct cl_chip *chip)
> +{
> +	cl_free_hw(chip->cl_hw_tcv0);
> +	cl_free_hw(chip->cl_hw_tcv1);
> +}
> +
> +static int cl_prepare_hw(struct cl_chip *chip, u8 tcv_idx,
> +			 const struct cl_driver_ops *drv_ops)
> +{
> +	struct cl_hw *cl_hw = NULL;

another initializer that is immediately overwritten by the first line of 
code

> +	struct ieee80211_hw *hw;
> +	int ret = 0;
> +
> +	hw = ieee80211_alloc_hw(sizeof(struct cl_hw), &cl_ops);
> +	if (!hw) {
> +		cl_dbg_chip_err(chip, "ieee80211_alloc_hw failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	cl_hw_init(chip, hw->priv, tcv_idx);
> +
> +	cl_hw = hw->priv;
> +	cl_hw->hw = hw;
> +	cl_hw->tcv_idx = tcv_idx;
> +	cl_hw->sx_idx = chip->conf->ci_tcv1_chains_sx0 ? 0 : tcv_idx;
> +	cl_hw->chip = chip;
> +
> +	/*
> +	 * chip0, tcv0 --> 0
> +	 * chip0, tcv1 --> 1
> +	 * chip1, tcv0 --> 2
> +	 * chip1, tcv1 --> 3
> +	 */
> +	cl_hw->idx = chip->idx * CHIP_MAX + tcv_idx;
> +
> +	cl_hw->drv_ops = drv_ops;
> +
> +	SET_IEEE80211_DEV(hw, chip->dev);
> +
> +	ret = cl_tcv_config_alloc(cl_hw);
> +	if (ret)
> +		goto out_free_hw;
> +
> +	ret = cl_tcv_config_read(cl_hw);
> +	if (ret)
> +		goto out_free_hw;
> +
> +	cl_chip_set_hw(chip, cl_hw);
> +
> +	ret = cl_mac_addr_set(cl_hw);
> +	if (ret) {
> +		cl_dbg_err(cl_hw, "cl_mac_addr_set failed\n");
> +		goto out_free_hw;
> +	}
> +
> +	if (cl_band_is_6g(cl_hw))
> +		cl_hw->nl_band = NL80211_BAND_6GHZ;
> +	else if (cl_band_is_5g(cl_hw))
> +		cl_hw->nl_band = NL80211_BAND_5GHZ;
> +	else
> +		cl_hw->nl_band = NL80211_BAND_2GHZ;
> +
> +	if (cl_band_is_24g(cl_hw))
> +		cl_hw->hw_mode = HW_MODE_BG;
> +	else
> +		cl_hw->hw_mode = HW_MODE_A;
> +
> +	cl_hw->wireless_mode = WIRELESS_MODE_HT_VHT_HE;
> +
> +	cl_cap_dyn_params(cl_hw);
> +
> +	cl_dbg_verbose(cl_hw, "cl_hw created\n");
> +
> +	return 0;
> +
> +out_free_hw:
> +	cl_free_hw(cl_hw);
> +
> +	return ret;
> +}
> +
> +void cl_main_off(struct cl_hw *cl_hw)
> +{
> +	cl_irq_disable(cl_hw, cl_hw->ipc_e2a_irq.all);
> +	cl_ipc_stop(cl_hw);
> +
> +	if (!test_bit(CL_DEV_INIT, &cl_hw->drv_flags)) {
> +		cl_tx_off(cl_hw);
> +		cl_rx_off(cl_hw);
> +		cl_msg_rx_flush_all(cl_hw);
> +	}
> +
> +	cl_fw_file_cleanup(cl_hw);
> +}
> +
> +static void _cl_main_deinit(struct cl_hw *cl_hw)
> +{
> +	if (!cl_hw)
> +		return;
> +
> +	ieee80211_unregister_hw(cl_hw->hw);
> +
> +	/* Send reset message to firmware */
> +	cl_msg_tx_reset(cl_hw);
> +
> +	cl_hw->is_stop_context = true;
> +
> +	cl_drv_workqueue_destroy(cl_hw);
> +
> +	cl_scanner_deinit(cl_hw);
> +
> +	cl_noise_close(cl_hw);
> +	cl_maintenance_close(cl_hw);
> +	cl_vns_close(cl_hw);
> +	cl_rssi_assoc_exit(cl_hw);
> +	cl_radar_close(cl_hw);
> +	cl_sounding_close(cl_hw);
> +	cl_chan_info_deinit(cl_hw);
> +	cl_wrs_api_close(cl_hw);
> +	cl_main_off(cl_hw);
> +	/* These 2 must be called after cl_tx_off() (which is called from cl_main_off) */
> +	cl_tx_amsdu_txhdr_deinit(cl_hw);
> +	cl_sw_txhdr_deinit(cl_hw);
> +	cl_fw_dbg_trigger_based_deinit(cl_hw);
> +	cl_stats_deinit(cl_hw);
> +	cl_main_free(cl_hw);
> +	cl_fw_file_release(cl_hw);
> +
> +	cl_ipc_deinit(cl_hw);
> +	cl_hw_deinit(cl_hw, cl_hw->tcv_idx);
> +	vfree(cl_hw->tx_queues);
> +}
> +
> +void cl_main_deinit(struct cl_chip *chip)
> +{
> +	struct cl_chip_conf *conf = chip->conf;
> +	struct cl_hw *cl_hw_tcv0 = chip->cl_hw_tcv0;
> +	struct cl_hw *cl_hw_tcv1 = chip->cl_hw_tcv1;
> +
> +	if (cl_chip_is_tcv1_enabled(chip) && cl_hw_tcv1)
> +		_cl_main_deinit(cl_hw_tcv1);
> +
> +	if (cl_chip_is_tcv0_enabled(chip) && cl_hw_tcv0)
> +		_cl_main_deinit(cl_hw_tcv0);
> +
> +	if (conf->ci_phy_dev != PHY_DEV_DUMMY) {
> +		if (!conf->ci_phy_load_bootdrv)
> +			cl_phy_off(cl_hw_tcv1);
> +
> +		cl_phy_off(cl_hw_tcv0);
> +	}
> +
> +	cl_platform_dealloc(chip);
> +
> +	cl_free_chip(chip);
> +}
> +
> +static struct cl_controller_reg all_controller_reg = {

if this is read-only then consider making it const

> +	.breset = XMAC_BRESET,
> +	.debug_enable = XMAC_DEBUG_ENABLE,
> +	.dreset = XMAC_DRESET,
> +	.ocd_halt_on_reset = XMAC_OCD_HALT_ON_RESET,
> +	.run_stall = XMAC_RUN_STALL
> +};
> +
> +void cl_main_reset(struct cl_chip *chip, struct cl_controller_reg *controller_reg)

would need to add const to 2nd param if you make the table const.
even if you didn't make the table const, it is good form to declare 
pointer params as const if you don't write back into the struct

> +{
> +	/* Release TRST & BReset to enable JTAG connection to FPGA A */
> +	u32 regval;
> +
> +	/* 1. return to reset value */
> +	regval = macsys_gcu_xt_control_get(chip);
> +	regval |= controller_reg->ocd_halt_on_reset;
> +	regval &= ~(controller_reg->dreset | controller_reg->run_stall | controller_reg->breset);
> +	macsys_gcu_xt_control_set(chip, regval);
> +
> +	regval = macsys_gcu_xt_control_get(chip);
> +	regval |= controller_reg->dreset;
> +	macsys_gcu_xt_control_set(chip, regval);
> +
> +	/* 2. stall xtensa & release ocd */
> +	regval = macsys_gcu_xt_control_get(chip);
> +	regval |= controller_reg->run_stall;
> +	regval &= ~controller_reg->ocd_halt_on_reset;
> +	macsys_gcu_xt_control_set(chip, regval);
> +
> +	/* 3. breset release & debug enable */
> +	regval = macsys_gcu_xt_control_get(chip);
> +	regval |= (controller_reg->debug_enable | controller_reg->breset);
> +	macsys_gcu_xt_control_set(chip, regval);
> +
> +	msleep(100);
> +}
> +
> +int cl_main_on(struct cl_hw *cl_hw)
> +{
> +	struct cl_chip *chip = cl_hw->chip;
> +	int ret;
> +	u32 regval;
> +
> +	cl_hw->fw_active = false;
> +
> +	cl_txq_init(cl_hw);
> +
> +	cl_hw_assert_info_init(cl_hw);
> +
> +	if (cl_recovery_in_progress(cl_hw))
> +		cl_main_reset(chip, &cl_hw->controller_reg);
> +
> +	ret = cl_fw_file_load(cl_hw);
> +	if (ret) {
> +		cl_dbg_err(cl_hw, "cl_fw_file_load failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Clear CL_DEV_FW_ERROR after firmware loaded */
> +	clear_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags);
> +
> +	if (cl_recovery_in_progress(cl_hw))
> +		cl_ipc_recovery(cl_hw);
> +
> +	regval = macsys_gcu_xt_control_get(chip);
> +
> +	/* Set fw to run */
> +	if (cl_hw->fw_active)
> +		regval &= ~cl_hw->controller_reg.run_stall;
> +
> +	/* Set umac to run */
> +	if (chip->umac_active)
> +		regval &= ~UMAC_RUN_STALL;
> +
> +	/* Ack all possibly pending IRQs */
> +	ipc_xmac_2_host_ack_set(chip, cl_hw->ipc_e2a_irq.all);
> +	macsys_gcu_xt_control_set(chip, regval);
> +	cl_irq_enable(cl_hw, cl_hw->ipc_e2a_irq.all);
> +	/*
> +	 * cl_irq_status_sync will set CL_DEV_FW_SYNC when fw raises IPC_IRQ_E2A_SYNC
> +	 * (indicate its ready to accept interrupts)
> +	 */
> +	ret = wait_event_interruptible_timeout(cl_hw->fw_sync_wq,
> +					       test_and_clear_bit(CL_DEV_FW_SYNC,
> +								  &cl_hw->drv_flags),
> +					       msecs_to_jiffies(5000));
> +
> +	if (ret == 0) {
> +		pr_err("[%s]: FW synchronization timeout.\n", __func__);
> +		cl_hw_assert_check(cl_hw);
> +		ret = -ETIMEDOUT;
> +		goto out_free_cached_fw;
> +	} else if (ret == -ERESTARTSYS) {
> +		goto out_free_cached_fw;
> +	}
> +
> +	return 0;
> +
> +out_free_cached_fw:
> +	cl_irq_disable(cl_hw, cl_hw->ipc_e2a_irq.all);
> +	cl_fw_file_release(cl_hw);
> +	return ret;
> +}
> +
> +static int __cl_main_init(struct cl_hw *cl_hw)
> +{
> +	int ret;
> +
> +	if (!cl_hw)
> +		return 0;
> +
> +	if (cl_regd_init(cl_hw, cl_hw->hw->wiphy))
> +		cl_dbg_err(cl_hw, "regulatory failed\n");
> +
> +	/*
> +	 * ieee80211_register_hw() will take care of calling wiphy_register() and
> +	 * also ieee80211_if_add() (because IFTYPE_STATION is supported)
> +	 * which will internally call register_netdev()
> +	 */
> +	ret = ieee80211_register_hw(cl_hw->hw);
> +	if (ret) {
> +		cl_dbg_err(cl_hw, "ieee80211_register_hw failed\n");
> +		cl_main_deinit(cl_hw->chip);
> +
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int _cl_main_init(struct cl_hw *cl_hw)
> +{
> +	int ret = 0;
> +
> +	if (!cl_hw)
> +		return 0;
> +
> +	set_bit(CL_DEV_INIT, &cl_hw->drv_flags);
> +
> +	/* By default, set FEM mode to opertional mode. */
> +	cl_hw->fem_mode = FEM_MODE_OPERETIONAL;
> +
> +	cl_vif_init(cl_hw);
> +
> +	cl_drv_workqueue_create(cl_hw);
> +
> +	init_waitqueue_head(&cl_hw->wait_queue);
> +	init_waitqueue_head(&cl_hw->fw_sync_wq);
> +	init_waitqueue_head(&cl_hw->radio_wait_queue);
> +
> +	mutex_init(&cl_hw->dbginfo.mutex);
> +	mutex_init(&cl_hw->msg_tx_mutex);
> +	mutex_init(&cl_hw->set_channel_mutex);
> +
> +	spin_lock_init(&cl_hw->tx_lock_agg);
> +	spin_lock_init(&cl_hw->tx_lock_cfm_agg);
> +	spin_lock_init(&cl_hw->tx_lock_single);
> +	spin_lock_init(&cl_hw->tx_lock_bcmc);
> +	spin_lock_init(&cl_hw->channel_info_lock);
> +
> +	ret = cl_ipc_init(cl_hw);
> +	if (ret) {
> +		cl_dbg_err(cl_hw, "cl_ipc_init failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	cl_chip_set_rfic_version(cl_hw);
> +
> +	/* Validate calib params should be called after setting the rfic version */
> +	cl_tcv_config_validate_calib_params(cl_hw);
> +
> +	cl_hw->tx_queues = vzalloc(sizeof(*cl_hw->tx_queues));
> +	if (!cl_hw->tx_queues) {
> +		cl_ipc_deinit(cl_hw);
> +		return -ENOMEM;
> +	}
> +
> +	ret = cl_main_on(cl_hw);
> +	if (ret) {
> +		cl_dbg_err(cl_hw, "cl_main_on failed %d\n", ret);
> +		cl_ipc_deinit(cl_hw);
> +		vfree(cl_hw->tx_queues);
> +
> +		return ret;
> +	}
> +
> +	ret = cl_main_alloc(cl_hw);
> +	if (ret)
> +		goto out_free;
> +
> +	/* Reset firmware */
> +	ret = cl_msg_tx_reset(cl_hw);
> +	if (ret)
> +		goto out_free;
> +
> +	cl_calib_power_read(cl_hw);
> +	cl_sta_init(cl_hw);
> +	cl_sw_txhdr_init(cl_hw);
> +	cl_tx_amsdu_txhdr_init(cl_hw);
> +	cl_rx_init(cl_hw);
> +	cl_prot_mode_init(cl_hw);
> +	cl_radar_init(cl_hw);
> +	cl_sounding_init(cl_hw);
> +	cl_traffic_init(cl_hw);
> +	ret = cl_vns_init(cl_hw);
> +	if (ret)
> +		goto out_free;
> +
> +	cl_maintenance_init(cl_hw);
> +	cl_rssi_assoc_init(cl_hw);
> +	cl_agg_cfm_init(cl_hw);
> +	cl_single_cfm_init(cl_hw);
> +	cl_bcmc_cfm_init(cl_hw);
> +#ifdef CONFIG_CL8K_DYN_MCAST_RATE
> +	cl_dyn_mcast_rate_init(cl_hw);
> +#endif /* CONFIG_CL8K_DYN_MCAST_RATE */
> +#ifdef CONFIG_CL8K_DYN_BCAST_RATE
> +	cl_dyn_bcast_rate_init(cl_hw);
> +#endif /* CONFIG_CL8K_DYN_BCAST_RATE */
> +	cl_wrs_api_init(cl_hw);
> +	cl_dfs_init(cl_hw);
> +	cl_noise_init(cl_hw);
> +	ret = cl_fw_dbg_trigger_based_init(cl_hw);
> +	if (ret)
> +		goto out_free;
> +
> +	cl_stats_init(cl_hw);
> +	cl_cca_init(cl_hw);
> +	cl_bf_init(cl_hw);
> +
> +	ret = cl_scanner_init(cl_hw);
> +	if (ret)
> +		goto out_free;
> +
> +	/* Start firmware */
> +	ret = cl_msg_tx_start(cl_hw);
> +	if (ret)
> +		goto out_free;
> +
> +	return 0;
> +
> +out_free:
> +	cl_main_free(cl_hw);
> +	vfree(cl_hw->tx_queues);
> +
> +	return ret;
> +}
> +
> +int cl_main_init(struct cl_chip *chip, const struct cl_driver_ops *drv_ops)
> +{
> +	int ret = 0;
> +	struct cl_chip_conf *conf = chip->conf;
> +
> +	/* All cores needs to be reset first (once per chip) */
> +	cl_main_reset(chip, &all_controller_reg);
> +
> +	/* Prepare HW for TCV0 */
> +	if (cl_chip_is_tcv0_enabled(chip)) {
> +		ret = cl_prepare_hw(chip, TCV0, drv_ops);
> +
> +		if (ret) {
> +			cl_dbg_chip_err(chip, "Prepare HW for TCV0 failed %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	/* Prepare HW for TCV1 */
> +	if (cl_chip_is_tcv1_enabled(chip)) {
> +		ret = cl_prepare_hw(chip, TCV1, drv_ops);
> +
> +		if (ret) {
> +			cl_dbg_chip_err(chip, "Prepare HW for TCV1 failed %d\n", ret);
> +			cl_free_hw(chip->cl_hw_tcv0);
> +			return ret;
> +		}
> +	}
> +
> +	if (!conf->ci_phy_load_bootdrv &&
> +	    conf->ci_phy_dev != PHY_DEV_DUMMY) {
> +		ret = cl_radio_boot(chip);
> +		if (ret) {
> +			cl_dbg_chip_err(chip, "RF boot failed %d\n", ret);
> +			return ret;
> +		}
> +
> +		ret = cl_dsp_load_regular(chip);
> +		if (ret) {
> +			cl_dbg_chip_err(chip, "DSP load failed %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = _cl_main_init(chip->cl_hw_tcv0);
> +	if (ret) {
> +		cl_free_chip(chip);
> +		return ret;
> +	}
> +
> +	ret = _cl_main_init(chip->cl_hw_tcv1);
> +	if (ret) {
> +		_cl_main_deinit(chip->cl_hw_tcv0);
> +		cl_free_chip(chip);
> +		return ret;
> +	}
> +
> +	ret = __cl_main_init(chip->cl_hw_tcv0);
> +	if (ret)
> +		return ret;
> +
> +	ret = __cl_main_init(chip->cl_hw_tcv1);
> +	if (ret)
> +		return ret;
> +
> +#ifdef CONFIG_CL8K_EEPROM_STM24256
> +	if (conf->ci_calib_eeprom_en && conf->ce_production_mode && conf->ce_calib_runtime_en)
> +		cl_e2p_read_eeprom_start_work(chip);
> +#endif
> +
> +	return ret;
> +}

