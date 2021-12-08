Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0A446CBB5
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 04:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhLHDr1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 22:47:27 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:45484 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230023AbhLHDr1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 22:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638935036; x=1670471036;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8RWD8/zDAqoRSGI/dtAuM6QTOLamnvNj8eHPBYiL/L8=;
  b=l1soeIK4IU+epYhJ9o+lkBRIiZroFTrsozq2hD7tTMRN4IjaVaIqJ8eW
   HqXnGmNGYIZ97SLaIxY0Bt4FetTMkKJM9VtlZ0DkhrwViRfAWGO7mNyU2
   BMARfl3lAEzu8lq8RaG1Vn1tVPuZ3ziroRXVsPkcj+ufYx4NWNguuBuBU
   A=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Dec 2021 19:43:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 19:43:55 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 19:43:55 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 7 Dec 2021
 19:43:53 -0800
Message-ID: <7fe28037-bf52-71c6-b147-26af276c6759@quicinc.com>
Date:   Wed, 8 Dec 2021 11:43:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] ath11k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for
 WCN6855
Content-Language: en-US
To:     Sven Eckelmann <sven@narfation.org>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20211129101309.2931-1-quic_wgong@quicinc.com>
 <7286726.fyvdfvlfLW@ripper>
 <1880129e-ed91-25f6-bdeb-38c09ae058bb@quicinc.com>
 <3267805.el9kkjlfUZ@ripper>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <3267805.el9kkjlfUZ@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks Sven's analyze/debugging.

I see your patch "ath11k: Fix buffer overflow when scanning with extraie".

On 12/7/2021 10:30 PM, Sven Eckelmann wrote:
> On Tuesday, 7 December 2021 05:35:04 CET Wen Gong wrote:
>> Thanks Sven a lot for your analyze.
>>
>> I still can not reproduce it.
>>
>> I think it is because the write over skb->tail in scan, because the
>> invalid address
> Yes, I thought that I wanted to write about it but it might have gone into
> another draft of the mail. So what I wanted to write was something like:
>
> The information which is used in skb_zcopy_clear/skb_zcopy/skb_zcopy_is_nouarg
> is coming from skb_shinfo. And skb_end_pointer is just a pointer to a region
> at the end of the skb buffer (skb->end). And this got corrupted by something
> Unfortunately this is correctly allocated memory and thus kasan cannot help
> us with it.
>
>
>
> [...]
>> --- a/drivers/net/wireless/ath/ath11k/wmi.c
>> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
>> @@ -2271,6 +2271,7 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
>>                   }
>>           }
>>
>> +       ath11k_info(ar->ab, "%s ptr %px skb data %px len %d over %d",
>> __func__, ptr, skb->data, skb->len, ((unsigned char
>> *)ptr)-skb->data-skb->len);
>>           ret = ath11k_wmi_cmd_send(wmi, skb,
>>                                     WMI_START_SCAN_CMDID);
>>           if (ret) {
> Changed the last part to:
>
>      ath11k_err(ar->ab, "%s ptr %px skb data %px len %d over %ld\n", __func__, ptr, skb->data, skb->len, ((unsigned char *)ptr) - skb->data - skb->len);
>
>
> The output is:
>
>      ath11k_pci 0000:01:00.0: n_ssids 1
>      ath11k_pci 0000:01:00.0: ssid[0] len 0
>      ath11k_pci 0000:01:00.0: ath11k_wmi_send_scan_start_cmd ptr ffff9217101e82b4 skb data ffff9217101e804c len 616 over 0
>
> But we are looking at the ath11k_ce_tx_process_cb function. So I would have
> expected that it is related to something which as sent out. So the first thing
> I did was to add some skb_dumps in the sent path (ath11k_htc_send) and in the
> cleanup path (skb_zcopy_clear). Something like this (just the cleanup path
> because otherwise I have to post a rather large diff):
>
>      diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>      index 819cc58ab051..c15512e2f30c 100644
>      --- a/include/linux/skbuff.h
>      +++ b/include/linux/skbuff.h
>      @@ -1547,8 +1547,10 @@ static inline void skb_zcopy_clear(struct sk_buff *skb, bool zerocopy_success)
>       	struct ubuf_info *uarg = skb_zcopy(skb);
>       
>       	if (uarg) {
>      -		if (!skb_zcopy_is_nouarg(skb))
>      +		if (!skb_zcopy_is_nouarg(skb)) {
>      +			skb_dump(KERN_ERR, skb, true);
>       			uarg->callback(skb, uarg, zerocopy_success);
>      +		}
>       
>       		skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
>       	}
>
>
> But interestingly, it already crashes to parse the fraglist in
> ath11k_htc_send. So I've added some more dump to figure out where is breaks.
> And I've noticed that it breaks after following section in
> ath11k_wmi_send_scan_start_cmd
>
> 	if (params->extraie.len)
> 		memcpy(ptr, params->extraie.ptr,
> 		       params->extraie.len);
>
> Here is the full output:
>
>      [   30.641297] ath11k_wmi_send_scan_start_cmd:2357
>      [   30.645873] skb len=616 headroom=76 headlen=616 tailroom=12
>      [   30.645873] mac=(-1,-1) net=(0,-1) trans=-1
>      [   30.645873] shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
>      [   30.645873] csum(0x0 ip_summed=0 complete_sw=0 valid=0 level=0)
>      [   30.645873] hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
>      [   30.673381] skb headroom: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   30.681073] skb headroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   30.688758] skb headroom: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   30.696465] skb headroom: 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   30.704197] skb headroom: 00000040: 00 00 00 00 00 00 00 00 00 00 00 00
>      [   30.710852] skb linear:   00000000: 9c 00 4d 00 00 a0 00 00 01 00 00 00 00 00 00 00
>      [   30.718538] skb linear:   00000010: 01 00 00 00 1f 00 00 00 32 00 00 00 96 00 00 00
>      [   30.726271] skb linear:   00000020: 32 00 00 00 f4 01 00 00 00 00 00 00 00 00 00 00
>      [   30.733954] skb linear:   00000030: 00 00 00 00 20 4e 00 00 05 00 00 00 10 00 00 00
>      [   30.741636] skb linear:   00000040: 00 00 00 00 61 00 00 00 01 00 00 00 01 00 00 00
>      [   30.749346] skb linear:   00000050: 08 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   30.757092] skb linear:   00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   30.764795] skb linear:   00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   30.772483] skb linear:   00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   30.780170] skb linear:   00000090: 00 00 00 00 28 00 00 00 1e 00 00 00 00 00 00 00
>      [   30.787854] skb linear:   000000a0: 84 01 10 00 6c 09 00 00 71 09 00 00 76 09 00 00
>      [   30.795541] skb linear:   000000b0: 7b 09 00 00 80 09 00 00 85 09 00 00 8a 09 00 00
>      [   30.803236] skb linear:   000000c0: 8f 09 00 00 94 09 00 00 99 09 00 00 9e 09 00 00
>      [   30.810933] skb linear:   000000d0: a3 09 00 00 a8 09 00 00 3c 14 00 00 50 14 00 00
>      [   30.818620] skb linear:   000000e0: 64 14 00 00 78 14 00 00 8c 14 00 00 a0 14 00 00
>      [   30.826322] skb linear:   000000f0: b4 14 00 00 c8 14 00 00 7c 15 00 00 90 15 00 00
>      [   30.834018] skb linear:   00000100: a4 15 00 00 b8 15 00 00 cc 15 00 00 e0 15 00 00
>      [   30.841712] skb linear:   00000110: f4 15 00 00 08 16 00 00 1c 16 00 00 30 16 00 00
>      [   30.849402] skb linear:   00000120: 44 16 00 00 58 16 00 00 71 16 00 00 85 16 00 00
>      [   30.857094] skb linear:   00000130: 99 16 00 00 ad 16 00 00 c1 16 00 00 43 17 00 00
>      [   30.864776] skb linear:   00000140: 57 17 00 00 6b 17 00 00 7f 17 00 00 93 17 00 00
>      [   30.872490] skb linear:   00000150: a7 17 00 00 bb 17 00 00 cf 17 00 00 e3 17 00 00
>      [   30.880182] skb linear:   00000160: f7 17 00 00 0b 18 00 00 1f 18 00 00 33 18 00 00
>      [   30.887882] skb linear:   00000170: 47 18 00 00 5b 18 00 00 6f 18 00 00 83 18 00 00
>      [   30.895581] skb linear:   00000180: 97 18 00 00 ab 18 00 00 bf 18 00 00 d3 18 00 00
>      [   30.903265] skb linear:   00000190: e7 18 00 00 fb 18 00 00 0f 19 00 00 23 19 00 00
>      [   30.910974] skb linear:   000001a0: 37 19 00 00 4b 19 00 00 5f 19 00 00 73 19 00 00
>      [   30.918675] skb linear:   000001b0: 87 19 00 00 9b 19 00 00 af 19 00 00 c3 19 00 00
>      [   30.926418] skb linear:   000001c0: d7 19 00 00 eb 19 00 00 ff 19 00 00 13 1a 00 00
>      [   30.934118] skb linear:   000001d0: 27 1a 00 00 3b 1a 00 00 4f 1a 00 00 63 1a 00 00
>      [   30.941842] skb linear:   000001e0: 77 1a 00 00 8b 1a 00 00 9f 1a 00 00 b3 1a 00 00
>      [   30.949537] skb linear:   000001f0: c7 1a 00 00 db 1a 00 00 ef 1a 00 00 03 1b 00 00
>      [   30.957221] skb linear:   00000200: 17 1b 00 00 2b 1b 00 00 3f 1b 00 00 53 1b 00 00
>      [   30.964912] skb linear:   00000210: 67 1b 00 00 7b 1b 00 00 8f 1b 00 00 a3 1b 00 00
>      [   30.972614] skb linear:   00000220: b7 1b 00 00 cb 1b 00 00 24 00 13 00 00 00 00 00
>      [   30.980315] skb linear:   00000230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   30.988010] skb linear:   00000240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   30.995696] skb linear:   00000250: 08 00 13 00 ff ff ff ff ff ff 00 00 08 00 11 00
>      [   31.003394] skb linear:   00000260: 00 00 00 00 00 00 00 00
>      [   31.009002] skb tailroom: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00
>      [   31.015646] ath11k_wmi_send_scan_start_cmd:2362
>      [   31.020217] skb len=616 headroom=76 headlen=616 tailroom=12
>      [   31.020217] mac=(-1,-1) net=(0,-1) trans=-1
>      [   31.020217] shinfo(txflags=0 nr_frags=255 gso(size=0 type=265087 segs=0))
>      [   31.020217] csum(0x0 ip_summed=0 complete_sw=0 valid=0 level=0)
>      [   31.020217] hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
>      [   31.048289] skb headroom: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   31.056015] skb headroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   31.063714] skb headroom: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   31.071425] skb headroom: 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   31.079141] skb headroom: 00000040: 00 00 00 00 00 00 00 00 00 00 00 00
>      [   31.085787] skb linear:   00000000: 9c 00 4d 00 00 a0 00 00 01 00 00 00 00 00 00 00
>      [   31.093518] skb linear:   00000010: 01 00 00 00 1f 00 00 00 32 00 00 00 96 00 00 00
>      [   31.101239] skb linear:   00000020: 32 00 00 00 f4 01 00 00 00 00 00 00 00 00 00 00
>      [   31.108947] skb linear:   00000030: 00 00 00 00 20 4e 00 00 05 00 00 00 10 00 00 00
>      [   31.116630] skb linear:   00000040: 00 00 00 00 61 00 00 00 01 00 00 00 01 00 00 00
>      [   31.124326] skb linear:   00000050: 08 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   31.132007] skb linear:   00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   31.139708] skb linear:   00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   31.147420] skb linear:   00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   31.155118] skb linear:   00000090: 00 00 00 00 28 00 00 00 1e 00 00 00 00 00 00 00
>      [   31.162798] skb linear:   000000a0: 84 01 10 00 6c 09 00 00 71 09 00 00 76 09 00 00
>      [   31.170486] skb linear:   000000b0: 7b 09 00 00 80 09 00 00 85 09 00 00 8a 09 00 00
>      [   31.178175] skb linear:   000000c0: 8f 09 00 00 94 09 00 00 99 09 00 00 9e 09 00 00
>      [   31.185876] skb linear:   000000d0: a3 09 00 00 a8 09 00 00 3c 14 00 00 50 14 00 00
>      [   31.193593] skb linear:   000000e0: 64 14 00 00 78 14 00 00 8c 14 00 00 a0 14 00 00
>      [   31.201278] skb linear:   000000f0: b4 14 00 00 c8 14 00 00 7c 15 00 00 90 15 00 00
>      [   31.208969] skb linear:   00000100: a4 15 00 00 b8 15 00 00 cc 15 00 00 e0 15 00 00
>      [   31.216655] skb linear:   00000110: f4 15 00 00 08 16 00 00 1c 16 00 00 30 16 00 00
>      [   31.224346] skb linear:   00000120: 44 16 00 00 58 16 00 00 71 16 00 00 85 16 00 00
>      [   31.232030] skb linear:   00000130: 99 16 00 00 ad 16 00 00 c1 16 00 00 43 17 00 00
>      [   31.239739] skb linear:   00000140: 57 17 00 00 6b 17 00 00 7f 17 00 00 93 17 00 00
>      [   31.247428] skb linear:   00000150: a7 17 00 00 bb 17 00 00 cf 17 00 00 e3 17 00 00
>      [   31.255141] skb linear:   00000160: f7 17 00 00 0b 18 00 00 1f 18 00 00 33 18 00 00
>      [   31.262840] skb linear:   00000170: 47 18 00 00 5b 18 00 00 6f 18 00 00 83 18 00 00
>      [   31.270591] skb linear:   00000180: 97 18 00 00 ab 18 00 00 bf 18 00 00 d3 18 00 00
>      [   31.278282] skb linear:   00000190: e7 18 00 00 fb 18 00 00 0f 19 00 00 23 19 00 00
>      [   31.285965] skb linear:   000001a0: 37 19 00 00 4b 19 00 00 5f 19 00 00 73 19 00 00
>      [   31.293675] skb linear:   000001b0: 87 19 00 00 9b 19 00 00 af 19 00 00 c3 19 00 00
>      [   31.301361] skb linear:   000001c0: d7 19 00 00 eb 19 00 00 ff 19 00 00 13 1a 00 00
>      [   31.309056] skb linear:   000001d0: 27 1a 00 00 3b 1a 00 00 4f 1a 00 00 63 1a 00 00
>      [   31.316753] skb linear:   000001e0: 77 1a 00 00 8b 1a 00 00 9f 1a 00 00 b3 1a 00 00
>      [   31.324441] skb linear:   000001f0: c7 1a 00 00 db 1a 00 00 ef 1a 00 00 03 1b 00 00
>      [   31.332138] skb linear:   00000200: 17 1b 00 00 2b 1b 00 00 3f 1b 00 00 53 1b 00 00
>      [   31.339840] skb linear:   00000210: 67 1b 00 00 7b 1b 00 00 8f 1b 00 00 a3 1b 00 00
>      [   31.347520] skb linear:   00000220: b7 1b 00 00 cb 1b 00 00 24 00 13 00 00 00 00 00
>      [   31.355232] skb linear:   00000230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   31.362920] skb linear:   00000240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      [   31.370607] skb linear:   00000250: 08 00 13 00 ff ff ff ff ff ff 00 00 08 00 11 00
>      [   31.378331] skb linear:   00000260: 01 08 02 04 0b 16 0c 12
>      [   31.383972] skb tailroom: 00000000: 18 24 32 04 30 48 60 6c 2d 1a e3 19
>      [   31.390651] skb fraglist:
>      [   31.393348] BUG: unable to handle page fault for address: 00000100000000bc
>      [   31.400317] #PF: supervisor read access in kernel mode
>      [   31.405624] #PF: error_code(0x0000) - not-present page
>      [   31.410832] PGD 0 P4D 0
>      [   31.413422] Oops: 0000 [#1] PREEMPT SMP NOPTI
>      [   31.417881] CPU: 0 PID: 520 Comm: wpa_supplicant Not tainted 5.16.0-rc1+ #5
>      [   31.424862] Hardware name: PC Engines apu2/apu2, BIOS v4.15.0.1 11/23/2021
>      [   31.431750] RIP: 0010:skb_end_pointer+0x0/0xe
>      [   31.436129] Code: dc ff ff ff c3 48 8b 07 48 83 e0 fe 48 83 c8 02 48 89 07 c3 8b 47 08 c3 89 77 08 c3 01 77 08 c3 29 77 08 c3 b8 00 00 00 00 c3 <8b> 87 bc 00 00 00 48 03 87 c0 00 00 00 c3 8b 87 bc 00 00 00 c3 e8
>      [   31.454883] RSP: 0018:ffffb0edc0427490 EFLAGS: 00010282
>      [   31.460116] RAX: ffff8ff9818b1ec0 RBX: 0000010000000000 RCX: 0000000000000000
>      [   31.467267] RDX: 0000000000000001 RSI: 0000010000000000 RDI: 0000010000000000
>      [   31.474408] RBP: ffff8ff9891a07c8 R08: 0000000000000000 R09: ffffb0edc0427370
>      [   31.481549] R10: ffffb0edc0427368 R11: ffffffffa5cd22e8 R12: 0000000000000268
>      [   31.488689] R13: 00000000ffffffff R14: 0000010000000000 R15: ffffffffc0f2198b
>      [   31.495823] FS:  00007f2725a55c00(0000) GS:ffff8ff9aac00000(0000) knlGS:0000000000000000
>      [   31.503936] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>      [   31.509706] CR2: 00000100000000bc CR3: 00000001090bc000 CR4: 00000000000406f0
>      [   31.516868] Call Trace:
>      [   31.519325]  <TASK>
>      [   31.521433]  skb_dump+0x24/0x53a
>      [   31.524688]  ? _printk+0x58/0x6f
>      [   31.527938]  skb_dump+0x532/0x53a
>      [   31.531267]  ath11k_wmi_send_scan_start_cmd.cold+0x5f2/0x793 [ath11k]
>      [   31.537785]  ath11k_mac_op_hw_scan+0x173/0x3f0 [ath11k]
>      [   31.543086]  drv_hw_scan+0x43/0x130 [mac80211]
>      [   31.547690]  __ieee80211_start_scan+0x152/0x6d0 [mac80211]
>      [   31.553306]  ieee80211_request_scan+0x2c/0x50 [mac80211]
>      [   31.558738]  rdev_scan+0x28/0xd0 [cfg80211]
>      [   31.563117]  nl80211_trigger_scan+0x3fe/0x680 [cfg80211]
>      [   31.568584]  genl_family_rcv_msg_doit+0xea/0x150
>      [   31.573223]  genl_rcv_msg+0xde/0x1d0
>      [   31.576816]  ? nl80211_send_scan_start+0x90/0x90 [cfg80211]
>      [   31.582520]  ? genl_get_cmd+0xd0/0xd0
>      [   31.586191]  netlink_rcv_skb+0x50/0xf0
>      [   31.589958]  genl_rcv+0x24/0x40
>      [   31.593109]  netlink_unicast+0x239/0x340
>      [   31.597045]  netlink_sendmsg+0x245/0x480
>      [   31.600981]  sock_sendmsg+0x5e/0x60
>      [   31.604487]  ____sys_sendmsg+0x22e/0x270
>      [   31.608440]  ? import_iovec+0x2d/0x30
>      [   31.612123]  ? sendmsg_copy_msghdr+0x7c/0xa0
>      [   31.616406]  ___sys_sendmsg+0x75/0xb0
>      [   31.620081]  ? __mod_lruvec_page_state+0x7d/0xc0
>      [   31.624714]  ? folio_add_lru+0x5c/0xa0
>      [   31.628476]  ? _raw_spin_unlock+0x16/0x30
>      [   31.632506]  ? __handle_mm_fault+0x1261/0x1520
>      [   31.636965]  __sys_sendmsg+0x59/0xa0
>      [   31.640552]  do_syscall_64+0x3b/0xc0
>      [   31.644148]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>      [   31.649208] RIP: 0033:0x7f2725ef6f33
>      [   31.652797] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 89 54 24 1c 48
>      [   31.671547] RSP: 002b:00007fff1b5f1668 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>      [   31.679122] RAX: ffffffffffffffda RBX: 0000564919260760 RCX: 00007f2725ef6f33
>      [   31.686264] RDX: 0000000000000000 RSI: 00007fff1b5f16a0 RDI: 0000000000000005
>      [   31.693406] RBP: 000056491928f6c0 R08: 0000000000000004 R09: 00007f2725fb6c00
>      [   31.700547] R10: 00007fff1b5f178c R11: 0000000000000246 R12: 0000564919260670
>      [   31.707689] R13: 00007fff1b5f16a0 R14: 0000000000000000 R15: 00007fff1b5f178c
>      [   31.714834]  </TASK>
>      [   31.717031] Modules linked in: qrtr_mhi btusb btrtl btbcm btintel bluetooth jitterentropy_rng sha512_ssse3 sha512_generic drbg ansi_cprng amd64_edac ecdh_generic edac_mce_amd ecc kvm_amd kvm irqbypass qrtr crc32_pclmul ghash_clmulni_intel ath11k_pci mhi ath11k evdev pcengines_apuv2 qmi_helpers gpio_keys_polled gpio_amd_fch aesni_intel snd_pcm crypto_simd snd_timer sdhci_pci xhci_pci snd cqhci mac80211 soundcore ehci_pci sp5100_tco cryptd libarc4 xhci_hcd sdhci ehci_hcd pcspkr igb watchdog ptp cfg80211 mmc_core k10temp i2c_piix4 fam15h_power usbcore ccp pps_core sg dca rng_core i2c_algo_bit usb_common rfkill leds_gpio gpio_keys acpi_cpufreq button fuse drm configfs ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 sd_mod t10_pi crc_t10dif crct10dif_generic ahci libahci libata crct10dif_pclmul scsi_mod crct10dif_common crc32c_intel scsi_common
>      [   31.793074] CR2: 00000100000000bc
>      [   31.796498] ---[ end trace 07252723010a83e6 ]---
>      [   31.801261] RIP: 0010:skb_end_pointer+0x0/0xe
>      [   31.805824] Code: dc ff ff ff c3 48 8b 07 48 83 e0 fe 48 83 c8 02 48 89 07 c3 8b 47 08 c3 89 77 08 c3 01 77 08 c3 29 77 08 c3 b8 00 00 00 00 c3 <8b> 87 bc 00 00 00 48 03 87 c0 00 00 00 c3 8b 87 bc 00 00 00 c3 e8
>      [   31.824842] RSP: 0018:ffffb0edc0427490 EFLAGS: 00010282
>      [   31.830105] RAX: ffff8ff9818b1ec0 RBX: 0000010000000000 RCX: 0000000000000000
>      [   31.837270] RDX: 0000000000000001 RSI: 0000010000000000 RDI: 0000010000000000
>      [   31.844441] RBP: ffff8ff9891a07c8 R08: 0000000000000000 R09: ffffb0edc0427370
>      [   31.851614] R10: ffffb0edc0427368 R11: ffffffffa5cd22e8 R12: 0000000000000268
>      [   31.858781] R13: 00000000ffffffff R14: 0000010000000000 R15: ffffffffc0f2198b
>      [   31.866020] FS:  00007f2725a55c00(0000) GS:ffff8ff9aac00000(0000) knlGS:0000000000000000
>      [   31.874141] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>      [   31.879920] CR2: 00000100000000bc CR3: 00000001090bc000 CR4: 00000000000406f0
>
>
> So the length calculated for the ath11k_wmi_alloc_skb is just wrong. Reason
> for this is the extraie_len_with_pad which is only an u8. But the
> params->extraie.len with the IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS is for me
> already 264. So the length will end up as 8 - but the length it occupies
> is still 264.
>
> But the problem is the length of the WMI_TLV_LEN. The params->extraie.len can
> be up to 32 bit and WMI_TLV_LEN only has 16 bit. So the params->extraie.len
> must also be size limited or we might run into a different problem.
>
> Kind regards,
> 	Sven
