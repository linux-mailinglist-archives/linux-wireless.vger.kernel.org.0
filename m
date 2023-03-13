Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D146B7330
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 10:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCMJxO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 05:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjCMJxM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 05:53:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF695C158
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 02:53:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 03A3ECE0F93
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 09:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDEFC433D2;
        Mon, 13 Mar 2023 09:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678701187;
        bh=x6u+QHZ/yrtW4oMxZ8xAVWornOHySm8Eqv6ZRws+RJ4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=e87vmpaRJifq2wYx2gksixrWREbapknb0xgWauBH2MNYzywJ602czAostEH4qdjXt
         33RHWqsO40ZjD7DhWXYRhLFqQa0NzhEbEVVarUu8O0dloa6hvDzEDRhGuPXtCkCeal
         hH/eIcgRl71z18Amj0XbgwrX2mI5IK75Y//FyQ9zuT+f7N3/c0PpdxoyJbwFHtgY+o
         U4KjJl4jJ8DDRResbdXfSa9KOQqJfbwZSWZ5X+9EPlBxfsB/uHexmNtgy2yB7m32aY
         /ofPSMxiXSDVmADSc3XWDxBx+L/8ZJ7SY/+szXBfzqmvHTlNCHTnZkEKwkizwigWvg
         qxczu8+B8icGQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Govindaraj Saminathan <quic_gsaminat@quicinc.com>,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Subject: Re: [PATCH 1/2] wifi: ath11k: factory test mode support
References: <20230213130854.2473-1-quic_rajkbhag@quicinc.com>
        <20230213130854.2473-2-quic_rajkbhag@quicinc.com>
Date:   Mon, 13 Mar 2023 11:53:01 +0200
In-Reply-To: <20230213130854.2473-2-quic_rajkbhag@quicinc.com> (Raj Kumar
        Bhagat's message of "Mon, 13 Feb 2023 18:38:53 +0530")
Message-ID: <87mt4hnfk2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:

> From: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
>
> Add support to process factory test mode commands(FTM) for calibration.
> By default firmware start with NORMAL mode and to process the FTM commands
> firmware needs to be restarted in FTM mode using module parameter ftm_mode.
> The pre-request is all the radios should be down before starting the test.
>
> When start command ATH11K_TM_CMD_TESTMODE_START is received, ar state
> is set to Test Mode. If the FTM command or event length is greater
> than 256 bytes, it will be broken down into multiple segments and
> encoded with TLV header if it is segmented commands, else it is sent
> to firmware as it is.
>
> On receiving UTF event from firmware, if it is segmented event, the driver
> will wait until it receives all the segments and notify the complete
> data to user application. In case the segmented sequence are missed or
> lost from the firmware, driver will skip the already received partial data.
>
> In case of unsegmented UTF event from firmware, driver notifies the
> data to the user application as it comes. Applications handles
> the data further.
>
> Command to boot in ftm mode
> insmod ath11k ftm_mode=1
>
> Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
> Co-developed-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

[...]

> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>  /*
>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #include <linux/module.h>
> @@ -32,6 +32,10 @@ module_param_named(frame_mode, ath11k_frame_mode, uint, 0644);
>  MODULE_PARM_DESC(frame_mode,
>  		 "Datapath frame mode (0: raw, 1: native wifi (default), 2: ethernet)");
>  
> +unsigned int ath11k_ftm_mode;
> +module_param_named(ftm_mode, ath11k_ftm_mode, uint, 0444);
> +MODULE_PARM_DESC(ftm_mode, "Boots up in factory test mode");

I changed this to bool as there's only two values, true or false.

> @@ -1362,6 +1366,11 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
>  {
>  	int ret;
>  
> +	if (ath11k_ftm_mode) {
> +		ab->fw_mode = ATH11K_FIRMWARE_MODE_FTM;
> +		ath11k_info(ab, "Booting in ftm mode\n");
> +	}

I changed this to:

"Booting in factory test mode\n"

> @@ -1822,6 +1832,10 @@ static void ath11k_core_post_reconfigure_recovery(struct ath11k_base *ab)
>  			ath11k_warn(ab,
>  				    "device is wedged, will not restart radio %d\n", i);
>  			break;
> +		case ATH11K_STATE_TM:
> +			ath11k_warn(ab, "fw mode reset done radio %d\n", i);
> +			break;

What is this warning supposed to tell the user? Should it be a debug
message instead?

> @@ -530,6 +531,7 @@ enum ath11k_state {
>  	ATH11K_STATE_RESTARTING,
>  	ATH11K_STATE_RESTARTED,
>  	ATH11K_STATE_WEDGED,
> +	ATH11K_STATE_TM,

For consistency I renamed this to ATH11K_STATE_FTM.

> --- a/drivers/net/wireless/ath/ath11k/debug.h
> +++ b/drivers/net/wireless/ath/ath11k/debug.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: BSD-3-Clause-Clear */
>  /*
>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #ifndef _ATH11K_DEBUG_H_
> @@ -33,6 +34,7 @@ __printf(2, 3) void ath11k_err(struct ath11k_base *ab, const char *fmt, ...);
>  __printf(2, 3) void ath11k_warn(struct ath11k_base *ab, const char *fmt, ...);
>  
>  extern unsigned int ath11k_debug_mask;
> +extern unsigned int ath11k_ftm_mode;

As the variable is is in core.c I moved this to core.h.

> @@ -5838,6 +5841,11 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
>  	struct ath11k_pdev *pdev = ar->pdev;
>  	int ret;
>  
> +	if (ath11k_ftm_mode) {
> +		ath11k_err(ab, "fail to start mac operations in ftm mode\n");

I changed this to:

ath11k_warn(ab, "mac operations not supported in factory test mode\n");

> +		return -EWOULDBLOCK;

EWOULDBLOCK is defined as EAGAIN, so it doesn't look approriate here. I
changed it to EOPNOTSUPP.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
