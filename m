Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A95456B46
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 09:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhKSIHy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 03:07:54 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:63084 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhKSIHy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 03:07:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637309093; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=/bNtQmIqRau1qefHybsIVY/qx/sWczID6KHxDtF799s=;
 b=uF4k6M6FZ1aEQL3g43uhwImrmaorTwxfGpwU4mQEAUDxuw8Cour+5WQRf+a4PG+XDbSDQj/p
 NY1ZWM1Q/Zn5LtWb946FxCOI92iTkkcTr7RVSpg47NRmQ9ScnXmOxiWyH7jPsbKj1B+9+QPd
 oHTWjOCDpaQomct1ovkfTa3wlBQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 61975aa4f5c956d49e85e3a8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Nov 2021 08:04:52
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4C501C43617; Fri, 19 Nov 2021 08:04:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64EF0C4338F;
        Fri, 19 Nov 2021 08:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 64EF0C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: add hw_param for wakeup_mhi
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1636702019-26142-1-git-send-email-quic_seevalam@quicinc.com>
References: <1636702019-26142-1-git-send-email-quic_seevalam@quicinc.com>
To:     Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163730908439.10050.9686803784287020188.kvalo@codeaurora.org>
Date:   Fri, 19 Nov 2021 08:04:52 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Seevalamuthu Mariappan <quic_seevalam@quicinc.com> wrote:

> Wakeup mhi is needed before pci_read/write only for QCA6390 and WCN6855. Since
> wakeup & release mhi is enabled for all hardwares, below mhi assert is seen in
> QCN9074 when doing 'rmmod ath11k_pci':
> 
>         Kernel panic - not syncing: dev_wake != 0
>         CPU: 2 PID: 13535 Comm: procd Not tainted 4.4.60 #1
>         Hardware name: Generic DT based system
>         [<80316dac>] (unwind_backtrace) from [<80313700>] (show_stack+0x10/0x14)
>         [<80313700>] (show_stack) from [<805135dc>] (dump_stack+0x7c/0x9c)
>         [<805135dc>] (dump_stack) from [<8032136c>] (panic+0x84/0x1f8)
>         [<8032136c>] (panic) from [<80549b24>] (mhi_pm_disable_transition+0x3b8/0x5b8)
>         [<80549b24>] (mhi_pm_disable_transition) from [<80549ddc>] (mhi_power_down+0xb8/0x100)
>         [<80549ddc>] (mhi_power_down) from [<7f5242b0>] (ath11k_mhi_op_status_cb+0x284/0x3ac [ath11k_pci])
>         [E][__mhi_device_get_sync] Did not enter M0 state, cur_state:RESET pm_state:SHUTDOWN Process
>         [E][__mhi_device_get_sync] Did not enter M0 state, cur_state:RESET pm_state:SHUTDOWN Process
>         [E][__mhi_device_get_sync] Did not enter M0 state, cur_state:RESET pm_state:SHUTDOWN Process
>         [<7f5242b0>] (ath11k_mhi_op_status_cb [ath11k_pci]) from [<7f524878>] (ath11k_mhi_stop+0x10/0x20 [ath11k_pci])
>         [<7f524878>] (ath11k_mhi_stop [ath11k_pci]) from [<7f525b94>] (ath11k_pci_power_down+0x54/0x90 [ath11k_pci])
>         [<7f525b94>] (ath11k_pci_power_down [ath11k_pci]) from [<8056b2a8>] (pci_device_shutdown+0x30/0x44)
>         [<8056b2a8>] (pci_device_shutdown) from [<805cfa0c>] (device_shutdown+0x124/0x174)
>         [<805cfa0c>] (device_shutdown) from [<8033aaa4>] (kernel_restart+0xc/0x50)
>         [<8033aaa4>] (kernel_restart) from [<8033ada8>] (SyS_reboot+0x178/0x1ec)
>         [<8033ada8>] (SyS_reboot) from [<80301b80>] (ret_fast_syscall+0x0/0x34)
> 
> Hence, disable wakeup/release mhi using hw_param for other hardwares.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01060-QCAHKSWPL_SILICONZ-1
> 
> Fixes: a05bd8513335 ("ath11k: read and write registers below unwindowed address")
> Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

081e2d6476e3 ath11k: add hw_param for wakeup_mhi

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1636702019-26142-1-git-send-email-quic_seevalam@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

