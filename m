Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60475646E61
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 12:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiLHLWM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 06:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiLHLVh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 06:21:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B66532FB
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 03:21:00 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B86s6ik000309;
        Thu, 8 Dec 2022 11:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6NuTgwIr4E0F2m0GO6n5BNfZhAIKaGVhnQfQOog/F8Y=;
 b=oVmEzv/Q1G8IfGDAfykvV38YAME5fQC0s/HgN4a1J4vnfYZtkHFDHRgojJ7ObiL/WKgY
 bR6+6elzSr3Ba1/NgHGuJRksLmw2WGAH2toRAv5NNoE/StaXXdorMfct7FNZd6XagSxK
 k8yen0ePVyVBE8AvvbhMucE9yBQl0GUQwpkn8ewlTSdU2u33/iGtNBqGGXyDcnDmbg9M
 2TmHWE5ojdHLRqNm7oCYo4terUDYyt8ydJleCMt8nfHinpCfekCLY3hIwQ7xrVpjKN9W
 iWs3SUy2IAnRtSIVqO0SUQ35rSs83eJMuHAG4tpcKUzEFlcZT9oi1cHMyiha2bHNfXOG 5w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3majt4c8e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 11:20:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B8BKm6c030065
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Dec 2022 11:20:48 GMT
Received: from [10.216.27.153] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 03:20:46 -0800
Message-ID: <692bc21e-8d65-e3b3-74e3-bc6223cb1194@quicinc.com>
Date:   Thu, 8 Dec 2022 16:50:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 0/3] Enable low power mode when WLAN is not active
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20221121110359.4652-1-quic_mpubbise@quicinc.com>
 <87bkoz8ica.fsf@kernel.org> <87y1s17j1j.fsf@kernel.org>
 <2b0ac3c4-74e3-47f1-6aa7-72f2a4176824@quicinc.com>
 <87y1ri1gay.fsf@kernel.org>
Content-Language: en-US
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <87y1ri1gay.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gzal-YRh4mRE_B2AspNT0rIeKUwN5ha8
X-Proofpoint-ORIG-GUID: gzal-YRh4mRE_B2AspNT0rIeKUwN5ha8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_06,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080094
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/8/2022 1:24 PM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>> On 11/23/2022 9:35 PM, Kalle Valo wrote:
>>
>>> Kalle Valo <kvalo@kernel.org> writes:
>>>
>>>> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>>>>
>>>>> Currently, WLAN chip is powered once during driver probe and is kept
>>>>> ON (powered) always even when WLAN is not active; keeping the chip
>>>>> powered ON all the time will consume extra power which is not
>>>>> desirable for battery operated devices. Same is the case with non-WoW
>>>>> suspend, chip will not be put into low power mode when the system is
>>>>> suspended resulting in higher battery drain.
>>>>>
>>>>> Send QMI MODE OFF command to firmware during WiFi OFF to put device
>>>>> into low power mode.
>>>>>
>>>>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>>>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
>>>>>
>>>>> Manikanta Pubbisetty (3):
>>>>>     ath11k: Fix double free issue during SRNG deinit
>>>>>     ath11k: Move hardware initialization logic to start()
>>>>>     ath11k: Enable low power mode when WLAN is not active
>>>>> ---
>>>>> V3:
>>>>>    - Removed patch "ath11k: Fix failed to parse regulatory event print" as it is not needed anymore
>>>>>    - Fixed a potential deadlock scenario reported by lockdep around ab->core_lock with V2 changes
>>>>>    - Fixed other minor issues that were found during code review
>>>>>    - Spelling corrections in the commit messages
>>>>
>>>> I still see a crash, immediately after the first rmmod:
>>>>
>>>> Nov 22 11:05:47 nuc2  [  139.378719] rmmod ath11k_pci
>>>> Nov 22 11:05:48 nuc2 [ 139.892395] general protection fault, probably
>>>> for non-canonical address 0xdffffc000000003e: 0000 [#1] PREEMPT SMP
>>>> DEBUG_PAGEALLOC KASAN
>>>> Nov 22 11:05:48 nuc2 [ 139.892453] KASAN: null-ptr-deref in range
>>>> [0x00000000000001f0-0x00000000000001f7]
>>>>
>>>> Really odd that you don't see it. Unfortunately not able to debug this
>>>> further right now.
>>>>
>>>> This is with:
>>>>
>>>> wcn6855 hw2.0 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9
>>>
>>> A bit more information how I see the crash. So first I have all modules
>>> loaded:
>>>
>>> $ lsmod
>>> Module                  Size  Used by
>>> ath11k_pci             57344  0
>>> ath11k               2015232  1 ath11k_pci
>>> mac80211             3284992  1 ath11k
>>> libarc4                16384  1 mac80211
>>> cfg80211             2494464  2 ath11k,mac80211
>>> qmi_helpers            57344  1 ath11k
>>> qrtr_mhi               20480  0
>>> mhi                   217088  2 ath11k_pci,qrtr_mhi
>>> qrtr                   98304  5 qrtr_mhi
>>> nvme                  122880  3
>>> nvme_core             299008  5 nvme
>>> $
>>>
>>> Then I just remove ath11k_pci module and boom:
>>>
>>> $ sudo rmmod ath11k_pci
>>>
>>> [ 153.658409] general protection fault, probably for non-canonical
>>> address 0xdffffc000000003e: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
>>> KASAN
>>>
>>> This happens every time, there doesn't seem to be any randomness on the
>>> behaviour.
>>>
>>
>> Thanks for the help Kalle, this is exactly what I was doing in my
>> tests. Unfortunately, I'm not able to reproduce the problem. I have
>> also tried with the exact firmware that you have pointed out. Let me
>> see if I'm missing anything.
> 
> I tested this more and patch 3 seems to be the one causing the crash. I
> didn't see this when patch 1-2 were applied.
> 
> The crash happens in ath11k_dp_process_rxdma_err() in this line:
> 
> 	srng = &ab->hal.srng_list[err_ring->ring_id];
> 
> ab looks sane to me (0xffff88814c960000) but err_ring is set to 0x200.
> Does this help?
> 

Thanks for your time and analysis on the bug.

 From the callstack() that you have shared earlier, it looks like 
ath11k_dp_process_rxdma_err() is called from dp_service_srngs which is a
napi poll callback.

To me it looks like the napi handler of the driver is getting called
after the srng resources have been de-initialized during rmmod.

I have closed examined the changes in patch 3 (I'm still doing it). so 
far, I could not find anything that could trigger this kind of a 
problem. Since NAPI is disabled upon rmmod, NAPI poll should not be called.

It's quite not clear if I'm missing something.

Thanks,
Manikanta
