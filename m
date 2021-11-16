Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC19452915
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Nov 2021 05:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbhKPEY3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 23:24:29 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:10364 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241583AbhKPEW2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 23:22:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637036370; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=sB5/D994UQzTBtAp85fzMLbbNaRpZcBYwnSVLxcQl9c=;
 b=Piy4qIciZnXGfp+Xcr8K+uv8Hdu8VthKqeXl+PSpJkgfKSJD6UEFq3ZcU7q+/+3kwNPZ7O8p
 tl7+TYHJhQvz5LbGMR+8H1XxRUqTAGenfO6ZkjXAvgcHnkmFKHCmxFAEQA4TPpMSfXraoQ3j
 krd/4QhlG+4saTWXRoj+2TLCBRc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6193315260a72f61100e8869 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Nov 2021 04:19:30
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7527DC43460; Tue, 16 Nov 2021 04:19:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA06CC4338F;
        Tue, 16 Nov 2021 04:19:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Nov 2021 12:19:28 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 0/3] ath11k: add feature for device recovery
In-Reply-To: <87h7cdh970.fsf@codeaurora.org>
References: <20211015035459.14190-1-wgong@codeaurora.org>
 <87h7cdh970.fsf@codeaurora.org>
Message-ID: <a9efda4011061f2f0d57ea597b9b8f0e@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-15 20:53, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> writes:
> 
>> From: Wen Gong <quic_wgong@quicinc.com>
>> 
>> v3: remove time_left set but not used in
>>     "ath11k: add synchronization operation between reconfigure of 
>> mac80211 and ath11k_base"
>> 
>> v2: s/initilized/initialized in commit log of patch
>>     "ath11k: add synchronization operation between reconfigure of 
>> mac80211 and ath11k_base"
>> 
>> Add support for device recovery.
>> 
>> Wen Gong (3):
>>   ath11k: add ath11k_qmi_free_resource() for recovery
>>   ath11k: add support for device recovery for QCA6390
>>   ath11k: add synchronization operation between reconfigure of 
>> mac80211
>>     and ath11k_base
> 
> I did some quick testing (commit 4716d5bb1e16 in pending branch) and it
> does not seem to work for me:
> 
> oot@nuc1:~# echo assert > /sys/kernel/debug/ath11k/qca6390\
> hw2.0/simulate_fw_crash
> root@nuc1:~# iw wlan0 scan
> command failed: Connection timed out (-110)
> root@nuc1:~#
> 
> Kernel logs have:
> 
> [  118.903092] ath11k_pci 0000:06:00.0: BAR 0: assigned [mem
> 0xdb000000-0xdbffffff 64bit]
> [  118.925164] ath11k_pci 0000:06:00.0: MSI vectors: 32
> [  118.925285] ath11k_pci 0000:06:00.0: qca6390 hw2.0
> [  119.093214] mhi mhi0: Requested to power ON
> [  119.095430] mhi mhi0: Power on setup success
> [  119.423735] mhi mhi0: Wait for device to enter SBL or Mission mode
> [  119.543030] ath11k_pci 0000:06:00.0: chip_id 0x0 chip_family 0xb
> board_id 0xff soc_id 0xffffffff
> [  119.543197] ath11k_pci 0000:06:00.0: fw_version 0x101c06cc
> fw_build_timestamp 2020-06-24 19:50 fw_build_id
> [  230.101077] ip (2367) used greatest stack depth: 24384 bytes left
> [  283.663895] ath11k_pci 0000:06:00.0: simulating firmware assert 
> crash
> [  283.738422] ath11k_pci 0000:06:00.0: firmware crashed: 
> MHI_CB_SYS_ERROR
> [  295.236831] ath11k_pci 0000:06:00.0: wmi command 12290 timeout
> [  295.237937] ath11k_pci 0000:06:00.0: failed to send 
> WMI_STOP_SCAN_CMDID
> [  295.238467] ath11k_pci 0000:06:00.0: failed to stop wmi scan: -11
> [  295.240049] ath11k_pci 0000:06:00.0: failed to stop scan: -11
> [  295.240558] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
> 

I have sent v4, it is not to fix your fail:)
It added patch "ath11k: fix invalid m3 buffer address".
https://patchwork.kernel.org/project/linux-wireless/cover/20211116041522.23529-1-quic_wgong@quicinc.com/


> Also there should be a clear ath11k_warn() message when firmware
> recovery was successful, I could not find one from patches.

Yes, if recovery succes, it will have "success" log.
