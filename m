Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08934E717E
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 11:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244911AbiCYKrC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 06:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240594AbiCYKrC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 06:47:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2025B6C951
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 03:45:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5B7E616F3
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 10:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EBCC340E9;
        Fri, 25 Mar 2022 10:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648205127;
        bh=8FfUSBN/MqKEUt1dF6UlGFoqLXWVKYKCpSMOBXWYzGY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=t63Tgpy9zexB1HQ9TH5xqPlcGxCtO+Zu/iUVzhEdLK22IQiKdzr0FY6yCoXs77c1W
         kh7vZ94NfjwyffF8YhDttIzjlQCnXRguJLYmnHpYM0EPhDS5UhtHhHHDVVCJI2sqf3
         CaXaoJ3PH9XdNRtvXjze2NKJlUOoIINh+58FfJve1Go34ntZnxbIme2ywujX0ye6nx
         zO5WlM8vSJv/HmHNzuiaoJh33b6bE3rY1WmpH+flyS+hJQVyxjlMORHewsxQqw+9N7
         iUDUYNgLjSrYbg05C+yzwpXNE6xYc6z6KDVd3tgfU5zIoMjFANITMPqCBI2YcN0FRa
         RZ3ufOMy7gFKA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: reduce the wait time of 11d scan and hw scan
 while
 add interface
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220322124226.18347-1-quic_wgong@quicinc.com>
References: <20220322124226.18347-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164820512408.2234.13144214774407671269.kvalo@kernel.org>
Date:   Fri, 25 Mar 2022 10:45:26 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

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
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

I see new warnings in my regression tests:

[  755.217708] ath11k_pci 0000:06:00.0: failed to receive 11d scan complete: timed out
[  794.641670] ath11k_pci 0000:06:00.0: failed to receive 11d scan complete: timed out

Didn't investigate the patch in detail, gave up after seeing these warnings.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220322124226.18347-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

