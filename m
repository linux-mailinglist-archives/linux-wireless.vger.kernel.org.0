Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B3345024E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 11:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbhKOKYk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 05:24:40 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:27362 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhKOKYi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 05:24:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636971703; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=c7g98jhJOJwoW5CEHJwOtHOjiWD9jMWwgmgSb4PibHI=; b=Is78vPA7qYMid8F+3o6CsSTXibV+cw7OztlfA6SZOaBrD/yuCb4U+4q7NorhEDOQqhVx0S8M
 yG00ZTT0Xjj9q2G/24xpXPQQ/gEbgHoan5i/ArvZ8dcxynM3PCptuwGwBg9Q2YTc+BsZzStB
 MrMpX33AIkiW/qYZh6752/n422I=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 619234b511cd6d4077aa92a2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Nov 2021 10:21:41
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8D55DC43616; Mon, 15 Nov 2021 10:21:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F514C43460;
        Mon, 15 Nov 2021 10:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 3F514C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath11k: add hw_param for wakeup_mhi
References: <1636702019-26142-1-git-send-email-quic_seevalam@quicinc.com>
Date:   Mon, 15 Nov 2021 12:21:36 +0200
In-Reply-To: <1636702019-26142-1-git-send-email-quic_seevalam@quicinc.com>
        (Seevalamuthu Mariappan's message of "Fri, 12 Nov 2021 12:56:59
        +0530")
Message-ID: <87czn1iurz.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Seevalamuthu Mariappan <quic_seevalam@quicinc.com> writes:

> Wakeup mhi is needed before pci_read/write only for QCA6390
> and WCN6855. Since wakeup & release mhi is enabled for all
> hardwares, below mhi assert is seen in QCN9074.
>
> 	Kernel panic - not syncing: dev_wake != 0
> 	CPU: 2 PID: 13535 Comm: procd Not tainted 4.4.60 #1
> 	Hardware name: Generic DT based system
> 	[<80316dac>] (unwind_backtrace) from [<80313700>] (show_stack+0x10/0x14)
> 	[<80313700>] (show_stack) from [<805135dc>] (dump_stack+0x7c/0x9c)
> 	[<805135dc>] (dump_stack) from [<8032136c>] (panic+0x84/0x1f8)
> 	[<8032136c>] (panic) from [<80549b24>] (mhi_pm_disable_transition+0x3b8/0x5b8)
> 	[<80549b24>] (mhi_pm_disable_transition) from [<80549ddc>] (mhi_power_down+0xb8/0x100)
> 	[<80549ddc>] (mhi_power_down) from [<7f5242b0>] (ath11k_mhi_op_status_cb+0x284/0x3ac [ath11k_pci])
> 	[E][__mhi_device_get_sync] Did not enter M0 state, cur_state:RESET pm_state:SHUTDOWN Process
> 	[E][__mhi_device_get_sync] Did not enter M0 state, cur_state:RESET pm_state:SHUTDOWN Process
> 	[E][__mhi_device_get_sync] Did not enter M0 state, cur_state:RESET pm_state:SHUTDOWN Process
> 	[<7f5242b0>] (ath11k_mhi_op_status_cb [ath11k_pci]) from [<7f524878>] (ath11k_mhi_stop+0x10/0x20 [ath11k_pci])
> 	[<7f524878>] (ath11k_mhi_stop [ath11k_pci]) from [<7f525b94>] (ath11k_pci_power_down+0x54/0x90 [ath11k_pci])
> 	[<7f525b94>] (ath11k_pci_power_down [ath11k_pci]) from [<8056b2a8>] (pci_device_shutdown+0x30/0x44)
> 	[<8056b2a8>] (pci_device_shutdown) from [<805cfa0c>] (device_shutdown+0x124/0x174)
> 	[<805cfa0c>] (device_shutdown) from [<8033aaa4>] (kernel_restart+0xc/0x50)
> 	[<8033aaa4>] (kernel_restart) from [<8033ada8>] (SyS_reboot+0x178/0x1ec)
> 	[<8033ada8>] (SyS_reboot) from [<80301b80>] (ret_fast_syscall+0x0/0x34)
>
> Hence, disable wakeup/release mhi using hw_param for other hardwares.
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01060-QCAHKSWPL_SILICONZ-1
>
> Fixes: a05bd85133 ("ath11k: read and write registers below unwindowed address")
> Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>

The commit log is not quite clear, are you saying that commit a05bd85133
broke QCN9074 support altogether? Or it was failing only in some cases?
I can update the commit log.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
