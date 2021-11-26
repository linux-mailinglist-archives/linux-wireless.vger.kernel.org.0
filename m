Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7581245E823
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 07:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359059AbhKZG7x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 01:59:53 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:32847 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236083AbhKZG5x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 01:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637909680; x=1669445680;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=DrvK08oQNJfPnaNUh5MjFL2jVPdYwk4HW0BWKsUchZE=;
  b=ytsu4lFR7U2CHseRPFGJJRVTGbVvyqgYGl2t9gaGYUKfyZnq7mM4mHp4
   7673MsrTgTlBXWLS4ovwzuaT3JN4q/8l1TbzM6YB7cwgvZRHK3/mazdiw
   q32vlN1NmkMPZDdcgpk/nib+VzMH5wRWhoZPaqqyR37kepmi502AXRpJF
   I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Nov 2021 22:54:40 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 22:54:39 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 22:54:39 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 25 Nov
 2021 22:54:38 -0800
Message-ID: <b91ce5b3-d000-e42b-a67c-dd377123440d@quicinc.com>
Date:   Fri, 26 Nov 2021 14:54:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] ath11k: add wait operation for tx management packets
 for flush from mac80211
Content-Language: en-US
From:   Wen Gong <quic_wgong@quicinc.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20211118095254.7916-1-quic_wgong@quicinc.com>
 <871r389ycu.fsf@codeaurora.org>
 <f19a7d40-02a4-f651-44c6-2e8f0c14ce9f@quicinc.com>
In-Reply-To: <f19a7d40-02a4-f651-44c6-2e8f0c14ce9f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

I have sent new version patch, I have test it for connect/disconnect, it 
is OK now, it will not happen timed out.

https://patchwork.kernel.org/project/linux-wireless/patch/20211126064934.26490-1-quic_wgong@quicinc.com/

[PATCH v3] ath11k: add wait operation for tx management packets for 
flush from mac80211

On 11/26/2021 11:32 AM, Wen Gong wrote:
> Hi Kalle,
>
> I have found the reason.
>
> I will send new version to fix it.
>
> It is because commit c0b0d2e87d91ce283c8766b4b3c2ec9ac90ebf96 (ath11k: 
> Increment pending_mgmt_tx count before tx send invoke) which commit at 
> Nov 15 11:25:52 2021.
>
> And my rebase is auto merged by git, then it inc twice for 
> num_pending_mgmt_tx.
>
> wgong@wgong-HP3-Z230-SFF-Workstation:~/ath11k/ath-upstream$ git 
> cherry-pick 0869610178a1
> Auto-merging drivers/net/wireless/ath/ath11k/wmi.c
> Auto-merging drivers/net/wireless/ath/ath11k/mac.c
> Auto-merging drivers/net/wireless/ath/ath11k/core.h
> Auto-merging drivers/net/wireless/ath/ath11k/core.c
> [add_wait_mgmt_ath-202111221436 954d233dbe34] ath11k: add wait 
> operation for tx management packets for flush from mac80211
>
> On 11/22/2021 8:19 PM, Kalle Valo wrote:
>> Wen Gong <quic_wgong@quicinc.com> writes:
>>
>>> In ath11k, tx of management packet is doing in a work queue. Sometimes
>>> the workqueue does not finish tx immediately, then it lead after the 
>>> next
>>> step of vdev delete finished, it start to send the management packet to
>>> firmware and lead firmware crash.
>>>
>>> ieee80211_set_disassoc have logic of ieee80211_flush_queues after it
>>> send_deauth_disassoc to ath11k, its purpose is make sure the deauth
>>> was actually sent, so it need to change ath11k to match the purpose
>>> of mac80211.
>>>
>>> To address these issue wait for tx mgmt and tx data packets.
>>>
>>> Tested-on: QCA6390 hw2.0 PCI 
>>> WLAN.HST.1.0.1-01230-QCAHSTSWPLZ_V2_TO_X86-1
>>>
>>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>> I sometimes see new warnings with this patch:
>>
>> [  142.346474] ath11k_pci 0000:06:00.0: failed to flush mgmt transmit 
>> queue 0
>> [  147.466367] ath11k_pci 0000:06:00.0: failed to flush mgmt transmit 
>> queue 0
>>
>> And more importantly this breaks suspend on my NUC testbox:
>>
>> [  175.141820] PM: suspend entry (deep)
>> [  175.150512] Filesystems sync: 0.008 seconds
>> [  175.229703] Freezing user space processes ... (elapsed 0.003 
>> seconds) done.
>> [  175.233506] OOM killer disabled.
>> [  175.233588] Freezing remaining freezable tasks ... (elapsed 0.001 
>> seconds) done.
>> [  175.242457] printk: Suspending console(s) (use no_console_suspend 
>> to debug)
>> [  175.245269] wlan0: deauthenticating from 00:03:7f:48:81:59 by 
>> local choice (Reason: 3=DEAUTH_LEAVING)
>> [  175.285881] e1000e: EEE TX LPI TIMER: 00000011
>> [  180.745259] ath11k_pci 0000:06:00.0: failed to flush mgmt transmit 
>> queue 0
>> [  185.864977] ath11k_pci 0000:06:00.0: failed to flush mgmt transmit 
>> queue 0
>> [  185.970601] PM: Some devices failed to suspend, or early wake 
>> event detected
>> [  185.974081] usb usb3: root hub lost power or was reset
>> [  185.974135] usb usb4: root hub lost power or was reset
>> [  186.098870] nvme nvme0: 8/0/0 default/read/poll queues
>> [  186.297077] OOM killer enabled.
>> [  186.297361] Restarting tasks ... done.
>> [  186.343733] PM: suspend exit
>>
>> My setup:
>>
>> Tag:    ath-202111221111
>>
>> [  151.123732] ath11k_pci 0000:06:00.0: MSI vectors: 32
>> [  151.123851] ath11k_pci 0000:06:00.0: qca6390 hw2.0
>> [  151.720618] ath11k_pci 0000:06:00.0: chip_id 0x0 chip_family 0xb 
>> board_id 0xff soc_id 0xffffffff
>> [  151.720912] ath11k_pci 0000:06:00.0: fw_version 0x101c06cc 
>> fw_build_timestamp 2020-06-24 19:50 fw_build_id
>>
