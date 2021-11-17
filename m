Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E17B45426A
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 09:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhKQILg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 03:11:36 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:49470 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbhKQILb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 03:11:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637136513; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=aqwnkTtpw2IZjM/VcTVU4OqzZRbA+nxEKy/Q4nJXkU0=; b=U6U54+tN2qPjayRJVPy76JxH8JYOIUOKZcsSktfiW37a78MXNUgkzv3ZZll1SCfzywM9Kc+o
 fxK0inJGYZQF96ruggAHBU5R9t/uKhVGIw+IdwMqpGG+04fwSdFQld/5CQ92mdFv+8pW0wHU
 IGcV6H7z3ZTtgeRNEWEwn3Xxmpc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6194b881665450d43a01ae20 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Nov 2021 08:08:33
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A19E1C43460; Wed, 17 Nov 2021 08:08:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE8F5C4338F;
        Wed, 17 Nov 2021 08:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org DE8F5C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 0/3] ath11k: add feature for device recovery
References: <20211015035459.14190-1-wgong@codeaurora.org>
        <87h7cdh970.fsf@codeaurora.org>
        <a9efda4011061f2f0d57ea597b9b8f0e@codeaurora.org>
Date:   Wed, 17 Nov 2021 10:08:28 +0200
In-Reply-To: <a9efda4011061f2f0d57ea597b9b8f0e@codeaurora.org> (Wen Gong's
        message of "Tue, 16 Nov 2021 12:19:28 +0800")
Message-ID: <87sfvvdx1f.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2021-11-15 20:53, Kalle Valo wrote:
>> Wen Gong <wgong@codeaurora.org> writes:
>>
>>> From: Wen Gong <quic_wgong@quicinc.com>
>>>
>>> v3: remove time_left set but not used in
>>>     "ath11k: add synchronization operation between reconfigure of
>>> mac80211 and ath11k_base"
>>>
>>> v2: s/initilized/initialized in commit log of patch
>>>     "ath11k: add synchronization operation between reconfigure of
>>> mac80211 and ath11k_base"
>>>
>>> Add support for device recovery.
>>>
>>> Wen Gong (3):
>>>   ath11k: add ath11k_qmi_free_resource() for recovery
>>>   ath11k: add support for device recovery for QCA6390
>>>   ath11k: add synchronization operation between reconfigure of
>>> mac80211
>>>     and ath11k_base
>>
>> I did some quick testing (commit 4716d5bb1e16 in pending branch) and it
>> does not seem to work for me:
>>
>> oot@nuc1:~# echo assert > /sys/kernel/debug/ath11k/qca6390\
>> hw2.0/simulate_fw_crash
>> root@nuc1:~# iw wlan0 scan
>> command failed: Connection timed out (-110)
>> root@nuc1:~#
>>
>> Kernel logs have:
>>
>> [  118.903092] ath11k_pci 0000:06:00.0: BAR 0: assigned [mem
>> 0xdb000000-0xdbffffff 64bit]
>> [  118.925164] ath11k_pci 0000:06:00.0: MSI vectors: 32
>> [  118.925285] ath11k_pci 0000:06:00.0: qca6390 hw2.0
>> [  119.093214] mhi mhi0: Requested to power ON
>> [  119.095430] mhi mhi0: Power on setup success
>> [  119.423735] mhi mhi0: Wait for device to enter SBL or Mission mode
>> [  119.543030] ath11k_pci 0000:06:00.0: chip_id 0x0 chip_family 0xb
>> board_id 0xff soc_id 0xffffffff
>> [  119.543197] ath11k_pci 0000:06:00.0: fw_version 0x101c06cc
>> fw_build_timestamp 2020-06-24 19:50 fw_build_id
>> [  230.101077] ip (2367) used greatest stack depth: 24384 bytes left
>> [  283.663895] ath11k_pci 0000:06:00.0: simulating firmware assert
>> crash
>> [  283.738422] ath11k_pci 0000:06:00.0: firmware crashed:
>> MHI_CB_SYS_ERROR
>> [  295.236831] ath11k_pci 0000:06:00.0: wmi command 12290 timeout
>> [  295.237937] ath11k_pci 0000:06:00.0: failed to send
>> WMI_STOP_SCAN_CMDID
>> [  295.238467] ath11k_pci 0000:06:00.0: failed to stop wmi scan: -11
>> [  295.240049] ath11k_pci 0000:06:00.0: failed to stop scan: -11
>> [  295.240558] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>>
>
> I have sent v4, it is not to fix your fail:)
> It added patch "ath11k: fix invalid m3 buffer address".
> https://patchwork.kernel.org/project/linux-wireless/cover/20211116041522.23529-1-quic_wgong@quicinc.com/
>
>
>> Also there should be a clear ath11k_warn() message when firmware
>> recovery was successful, I could not find one from patches.
>
> Yes, if recovery succes, it will have "success" log.

Where are the printouts? I cannot find any ath11k_warn() messages in v4.
Basically I would want to see something like this when the firmware
crashes:

firmware crashed, restarting it

And once the firmware is running again:

firmware restarted succesfully

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
