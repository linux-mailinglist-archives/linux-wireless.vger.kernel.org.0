Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC9947CD56
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 08:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238327AbhLVHJo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 02:09:44 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:57111 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239295AbhLVHJo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 02:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640156984; x=1671692984;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H7Dok7WK0H59Mj54+rSDd7Yj5ML+6uiquMm8Ib7Shlk=;
  b=tQfpXrCvUgmi9DlSU84ehM0u+auKvE2h2yqEQ4HHX83UrZmCfyA5m/ga
   1APBl1EYCr3KVqNhFpo481dC6n+rGECjBrrbauNyEA601SMhaOugBkjEb
   rLbrdU8yCLxpGMrUo59NUTTkfFlmZo8QN/+DXrsh3rf4PWLYJGTWT3v+8
   g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Dec 2021 23:09:43 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 23:09:41 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 21 Dec 2021 23:09:39 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 21 Dec
 2021 23:09:38 -0800
Message-ID: <a9c1ed53-d83e-141f-abdf-3a8fe91f142d@quicinc.com>
Date:   Wed, 22 Dec 2021 15:09:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] ath11k: free peer for station when disconnect from AP
 for QCA6390/WCN6855
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20211215063442.15629-1-quic_wgong@quicinc.com>
 <87a6gu9sy8.fsf@codeaurora.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <87a6gu9sy8.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/21/2021 6:02 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> writes:
>
>> Commit b4a0f54156ac ("ath11k: move peer delete after vdev stop of station
>> for QCA6390 and WCN6855") is to fix firmware crash by changing the WMI
>> command sequence, but actually skip all the peer delete operation, then
>> it lead commit 58595c9874c6 ("ath11k: Fixing dangling pointer issue upon
>> peer delete failure") not take effect, and then happened a use-after-free
>> warning from KASAN. because the peer->sta is not set to NULL and then used
>> later.
>>
...
> I still see unknown peer warnings during suspend:
>
> [  506.782421] wlan0: authenticate with xx:xx:xx:xx:xx:xx
> [  506.845984] wlan0: send auth to xx:xx:xx:xx:xx:xx (try 1/3)
> [  506.852199] wlan0: authenticated
> [  506.855886] wlan0: associate with xx:xx:xx:xx:xx:xx (try 1/3)
> [  506.862157] wlan0: RX AssocResp from xx:xx:xx:xx:xx:xx (capab=0x431 status=0 aid=2)
> [  506.887866] wlan0: associated
> [  507.603717] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
> [  510.610907] PM: suspend entry (deep)
> [  510.611871] Filesystems sync: 0.000 seconds
> [  510.663217] Freezing user space processes ... (elapsed 0.003 seconds) done.
> [  510.668909] OOM killer disabled.
> [  510.670619] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [  510.674552] printk: Suspending console(s) (use no_console_suspend to debug)
> [  510.679606] wlan0: deauthenticating from xx:xx:xx:xx:xx:xx by local choice (Reason: 3=DEAUTH_LEAVING)
> [  510.722483] e1000e: EEE TX LPI TIMER: 00000011
> [  510.764835] ath11k_pci 0000:06:00.0: peer-unmap-event: unknown peer id 10
> [  511.374486] ACPI: EC: interrupt blocked
> [  511.440359] ACPI: PM: Preparing to enter system sleep state S3
> [  511.473142] ACPI: EC: event blocked

Hi Kalle,

patch v3 which has sent has fixed the warning "ath11k_pci 0000:06:00.0: 
peer-unmap-event: unknown peer id 10".

...

>>   		ath11k_mac_dec_num_stations(arvif, sta);
>>   		spin_lock_bh(&ar->ab->base_lock);
>>   		peer = ath11k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
>>   		if (peer && peer->sta == sta) {
>> -			ath11k_warn(ar->ab, "Found peer entry %pM n vdev %i after it was supposedly removed\n",
>> -				    vif->addr, arvif->vdev_id);
>> +			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
>> +				   "Found peer entry %pM n vdev %i after it was supposedly removed\n",
>> +				   vif->addr, arvif->vdev_id);
> I'm not sure about changing this warning to a debug message, though I
> don't have time to analyse this right now. But what if there's a race
> condition somewhere still?
patch v3 which has sent has changed it back to ath11k_warn().
