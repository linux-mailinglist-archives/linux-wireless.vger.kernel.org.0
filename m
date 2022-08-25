Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ECE5A0EF6
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 13:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241502AbiHYLY2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 07:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbiHYLY1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 07:24:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8A4AF0C7
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 04:24:26 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PBLowr021146;
        Thu, 25 Aug 2022 11:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pi+aMBlUhuht5aU85NJRiDkjoL8S4J/RkhYoBtUSHoM=;
 b=lOIQ4I+kYGP+U3/M8VqTLMNOtwe4KyTzQush58ZBL4lG2IyzxzMjz6Q1g9OW7Yxa3ZdV
 EseeF5AqTQMUMq2kDAHqvwrpPOrZUAhzzHdx9wRBp3u5IN4nwAfovnPuwzkZoxThRcL2
 pW3Z+VTjB99COMoV9B4IXbV4Bt7iDjdCg/I4V1j4z4a5LqTuL1FIRsTY3Itz2AjCnjbv
 efy8UU9KmpfqG9smNKur2C0ZqRBr/xuj+/skobu8e1g2Azd/+aKdU9P52CV2s7EfEJaj
 aYLFa+3VKWF0dKC5N6F0dfhSAu/3MyB7UO2T88Off5YOQXb/GZkRq/Bl9tebTJ7kO59D 3Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j644nrssn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 11:24:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27PBOMiH022872
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 11:24:22 GMT
Received: from [10.216.37.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 25 Aug
 2022 04:24:21 -0700
Message-ID: <ecce8764-1760-4617-49aa-c111305ebd55@quicinc.com>
Date:   Thu, 25 Aug 2022 16:54:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/4] ath11k: Enable low power mode when WLAN is not active
Content-Language: en-US
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20220720134959.15688-1-quic_mpubbise@quicinc.com>
 <ad99d238-dc1a-3233-fc6b-0cd49e428903@amd.com>
 <6daefd60-dcbc-06e1-8091-ea225690edf8@amd.com>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <6daefd60-dcbc-06e1-8091-ea225690edf8@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Dy4nT5NWopw63m2u0X81BNNhDmTg5shS
X-Proofpoint-GUID: Dy4nT5NWopw63m2u0X81BNNhDmTg5shS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1011 adultscore=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250044
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/23/2022 5:39 PM, Limonciello, Mario wrote:
> On 7/22/2022 17:00, Limonciello, Mario wrote:
>> On 7/20/2022 08:49, Manikanta Pubbisetty wrote:
>>> Currently, WLAN chip is powered once during driver probe and is kept
>>> ON (powered) always even when WLAN is not active; keeping the chip
>>> powered ON all the time will consume extra power which is not
>>> desirable on a battery operated device. Same is the case with non-WoW
>>> suspend, chip will not be put into low power mode when the system is
>>> suspended resulting in higher battery drain.
>>>
>>> Send QMI MODE OFF command to firmware during WiFi OFF to put device
>>> into low power mode.
>>>
>>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>>>
>>> Manikanta Pubbisetty (4):
>>>    ath11k: Fix double free issue during SRNG deinit
>>>    ath11k: Move hardware initialization logic to start()
>>>    ath11k: Enable low power mode when WLAN is not active
>>>    ath11k: Fix failed to parse regulatory event print
>>>
>>>   drivers/net/wireless/ath/ath11k/core.c | 237 ++++++++++++++++++-------
>>>   drivers/net/wireless/ath/ath11k/core.h |   8 +-
>>>   drivers/net/wireless/ath/ath11k/hal.c  |   1 +
>>>   drivers/net/wireless/ath/ath11k/mac.c  |  33 ++--
>>>   drivers/net/wireless/ath/ath11k/reg.c  |   2 +
>>>   5 files changed, 189 insertions(+), 92 deletions(-)
>>>
>>
>> This series looked potentially promising to me for a problem that I'm 
>> seeing on a notebook failing to sleep where WLAN_WAKE is asserted on 
>> the WCN6855 on resume even though WoW wasn't set at all.  This is 
>> problematic as it causes a spurious wake while SUT is reading from the 
>> EC since two IRQs are now active and the kernel wakes from that.
>> Removing the WCN6855 from the system it doesn't happen.
>>
>> I figured I'd give it a spin to see if it improved things.
>> I applied the series on top of 5.19-rc7 and it applied cleanly but I 
>> get timeouts on wlan card init (and of course suspend fails now too).
>>
>> Here's the mhi/ath11k_pci snippets:
>>
>> [    2.864110] ath11k_pci 0000:01:00.0: BAR 0: assigned [mem 
>> 0xb4000000-0xb41fffff 64bit]
>> [    2.864901] ath11k_pci 0000:01:00.0: MSI vectors: 32
>> [    2.864912] ath11k_pci 0000:01:00.0: wcn6855 hw2.1
>> [    3.106892] mhi mhi0: Requested to power ON
>> [    3.107054] mhi mhi0: Power on setup success
>> [    3.198178] mhi mhi0: Wait for device to enter SBL or Mission mode
>> [    3.971019] ath11k_pci 0000:01:00.0: chip_id 0x2 chip_family 0xb 
>> board_id 0xff soc_id 0x400c0210
>> [    3.971025] ath11k_pci 0000:01:00.0: fw_version 0x11080bbb 
>> fw_build_timestamp 2021-12-16 03:42 fw_build_id 
>> WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2
>> [    4.290328] ath11k_pci 0000:01:00.0 wlp1s0: renamed from wlan0
>> [    4.308760] ath11k_pci 0000:01:00.0: Failed to set the requested 
>> Country regulatory setting
>> [    4.309028] ath11k_pci 0000:01:00.0: Failed to set the requested 
>> Country regulatory setting
>> [   14.386201] ath11k_pci 0000:01:00.0: qmi failed wlan ini request, 
>> err = -110
>> [   14.386210] ath11k_pci 0000:01:00.0: qmi failed to send wlan fw 
>> ini:-110
>> [   14.386214] ath11k_pci 0000:01:00.0: failed to send firmware start: 
>> -110
>> [   14.386243] ath11k_pci 0000:01:00.0: failed to start firmware: -110
>> [   14.386266] ath11k_pci 0000:01:00.0: failed to setup device: -110
>> [   14.386300] ath11k_pci 0000:01:00.0: failed to start device : -110
>>
>> And so - on.
>> Is it functionally dependent on other patches in linux-next or another 
>> tree I won't see in 5.19?
> 
> I had a try with linux-next and your series but I reproduce the same 
> failure I described above.
> 
> ee3a066e4f4e (HEAD) ath11k: Fix failed to parse regulatory event print
> 4f850f1e26dc ath11k: Enable low power mode when WLAN is not active
> e320c8ef9841 ath11k: Move hardware initialization logic to start()
> dbc26036c1ef ath11k: Fix double free issue during SRNG deinit
> 18c107a1f120 (tag: next-20220722, linux-next/master) Add linux-next 
> specific files for 20220722
> 
> 

Sorry for late reply and thanks for reporting the bug.
After several rounds of discussions with the concerned teams on the 
failure that you have reported, we have root caused the issue.

The changes that I have posted will not work on other targets like 
WCN6855 as is. It requires additional changes and therefore lots of testing.

For now, I have posted a V2 enabling the "low power mode" design only on
WCN6750. I have started working on enabling the logic for other chipsets 
also. Once the changes are well tested, I'll post a separate patch to 
enable it on WCN6855. It might take a little more time.

Thanks,
Manikanta
