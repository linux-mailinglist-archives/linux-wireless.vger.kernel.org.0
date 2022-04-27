Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320D4511594
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 13:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiD0L1l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 07:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiD0L1k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 07:27:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B2433A12
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 04:24:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1D65611C4
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 11:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C81EC385A9;
        Wed, 27 Apr 2022 11:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651058669;
        bh=LTGwnbGRpiim9T3RVtgFxvcwX/HqM66APROkek98ZdY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=QqjVfVfeYrg4Sdk6EU9lunChpyV3z/3p5CS24BqGpyJD9SF5yzB5Rf4+jlHSkUYQs
         DKDJCLjOLNPf1BMU8lvLlk2/gdgt38lpTcbsGCuiaz5VEauR8j+Wxgg73DO0k61kp1
         J3/Rzprs1gnAruO0GaGKrhezMIItUvVYVrpM4yazkJ56Pd21E1wmjsrK7mMCwDjuhA
         l3VyLxVE4BfKnMrP8GO8r2vC7V8OHtuPek8rE4sfTMt3X/VtA6Ax2VXs5r2VGT9toY
         H6+osXni21iKuT1nblC+fZg8HwQuOCqPD7bzyKJJqpP3NxwBpjN5qP2Vze+Nsv/lnW
         8dhFUwIzLLPAQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5.18] ath11k: reduce the wait time of 11d scan and hw scan while add interface
References: <20220427111619.9758-1-kvalo@kernel.org>
Date:   Wed, 27 Apr 2022 14:24:26 +0300
In-Reply-To: <20220427111619.9758-1-kvalo@kernel.org> (Kalle Valo's message of
        "Wed, 27 Apr 2022 14:16:19 +0300")
Message-ID: <87bkwm22hh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> From: Wen Gong <quic_wgong@quicinc.com>
>
> (cherry picked from commit 1f682dc9fb3790aa7ec27d3d122ff32b1eda1365 in wireless-next)
>
> Currently ath11k will wait 11d scan complete while add interface in
> ath11k_mac_op_add_interface(), when system resume without enable
> wowlan, ath11k_mac_op_add_interface() is called for each resume, thus
> it increase the resume time of system. And ath11k_mac_op_hw_scan()
> after ath11k_mac_op_add_interface() also needs some time cost because
> the previous 11d scan need more than 5 seconds when 6 GHz is enabled,
> then the scan started event will indicated to ath11k after the 11d
> scan completed.
>
> While 11d scan/hw scan is running in firmware, if ath11k update channel
> list to firmware by WMI_SCAN_CHAN_LIST_CMDID, then firmware will cancel
> the current scan which is running, it lead the scan failed. The patch
> commit 9dcf6808b253 ("ath11k: add 11d scan offload support") used
> finish_11d_scan/finish_11d_ch_list/pending_11d to synchronize the 11d
> scan/hw scan/channel list between ath11k/firmware/mac80211 and to avoid
> the scan fail.
>
> Add wait operation before ath11k update channel list, function
> ath11k_reg_update_chan_list() will wait until the current 11d scan/hw
> scan completed. And remove the wait operation of start 11d scan and
> waiting channel list complete in hw scan. After these changes, resume
> time cost reduce about 5 seconds and also hw scan time cost reduced
> obviously, and scan failed not seen.
>
> The 11d scan is sent to firmware only one time for each interface added
> in mac.c, and it is moved after the 1st hw scan because 11d scan will
> cost some time and thus leads the AP scan result update to UI delay.
> Currently priority of ath11k's hw scan is WMI_SCAN_PRIORITY_LOW, and
> priority of 11d scan in firmware is WMI_SCAN_PRIORITY_MEDIUM, then the
> 11d scan which sent after hw scan will cancel the hw scan in firmware,
> so change the priority to WMI_SCAN_PRIORITY_MEDIUM for the hw scan which
> is in front of the 11d scan, thus it will not happen scan cancel in
> firmware.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>
> Fixes: 9dcf6808b253 ("ath11k: add 11d scan offload support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> Link: https://lore.kernel.org/r/20220328035832.14122-1-quic_wgong@quicinc.com

I forgot to include the link to the bug report:

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215777

I'll add that during commit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
