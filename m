Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11383514220
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 08:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354364AbiD2GEH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 02:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354362AbiD2GEG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 02:04:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DD6B18B0
        for <linux-wireless@vger.kernel.org>; Thu, 28 Apr 2022 23:00:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45E5B61A51
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 06:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E328DC385A4;
        Fri, 29 Apr 2022 06:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651212047;
        bh=j0Zer+6QL+0K2ksOmfZ1gu5Whw21UNJ5m6NogkXAcLA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=q2FxV6XAZ6xTTwvtsL/WPjGdsM97pNAXWQZl9Aa7NU3ia68qAZDf827BnUhnDFRxt
         egw0dtIIOLVT3nzpFFeRGei86HodnTh45+5g+bc1sLady+Oi64XeB1YoXp0yG4feKm
         G/BuiRDneJoGmxXkCAut/tnPnCCPgEw2ygZ79or15WqqdyRFomEvU4OYXFI+duuKti
         KncFs+p4OsRW68B5I5zFuX1X9yHFJjajm48iWM6Oe2hrQbwcAiHilvmzo78pLU1MhF
         vLAMHM3RNR54GJtxi81BURUZXup7m3umA2xsUgqIC9rnPQ+jCNjBV8MqS6W8lfc2tu
         42ONj7uANs6Bw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v5.18] ath11k: reduce the wait time of 11d scan and hw scan
 while add interface
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220427111619.9758-1-kvalo@kernel.org>
References: <20220427111619.9758-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165121204399.9395.8156139682593720867.kvalo@kernel.org>
Date:   Fri, 29 Apr 2022 06:00:46 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

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
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215777
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> Link: https://lore.kernel.org/r/20220328035832.14122-1-quic_wgong@quicinc.com

Patch applied to wireless.git, thanks.

bb300130e47f ath11k: reduce the wait time of 11d scan and hw scan while add interface

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220427111619.9758-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

