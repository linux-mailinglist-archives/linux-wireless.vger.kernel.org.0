Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42265AB4C1
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbiIBPMr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 11:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbiIBPMU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 11:12:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FD6F2409
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:43:10 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282ALVqc006624;
        Fri, 2 Sep 2022 14:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oZ5K+UNsuZA7cUYC58nWlsPW/fbHGRlaRgZj15lW/kw=;
 b=iIYT4IrAeWOxPEFrpctnW+pH7jMDWh8urHYfcKaW9hEnNx2/cxqJ+gdcrQp3AwBjHXkh
 7vennxU20CM6G84hpY/EmEVuC6+FaecmtKjHHTDj3Ud4326cSyDBxIPwsvVdneMsDT1U
 aluGsxfFlcomLvGrSwqm4zooRWSDe/AMS0U+ju7pRCwzSQsm9T0DS1bPWD3D4Z0MxDgV
 vuQMX/KgcspAHLHqqZ2oerAqmPhWpMd5LD/v3koXzcQXIO9HPv5uBhyzSQmIdDUWlsjJ
 /IeWlUpmQO044bHbTdW+PxXGuuHOberPIDxzsXhF8nx6gg21hJhpcPfZQwYUq7jVU30e jg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jb7hat1ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 14:31:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 282EV1uH015490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 14:31:01 GMT
Received: from [10.216.52.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 2 Sep 2022
 07:30:59 -0700
Message-ID: <5c07bcd5-574c-b13b-44c2-ef8ed9f23cf0@quicinc.com>
Date:   Fri, 2 Sep 2022 20:00:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] ath11k: Enable threaded NAPI on WCN6750
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>
CC:     Kalle Valo <kvalo@kernel.org>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20220720135113.15755-1-quic_mpubbise@quicinc.com>
 <20220720135113.15755-2-quic_mpubbise@quicinc.com>
 <87czceaqng.fsf@kernel.org>
 <dcc14883-51c9-c1bb-bbea-1b309eccedf2@quicinc.com>
 <CA+HBbNGEoSyfbs=FHtWyvBnG_jh9m=Q9KW=Pcfq+pDdHWEV4mw@mail.gmail.com>
 <7615c815-ca2e-c6f1-b627-6e10f1272442@quicinc.com>
 <CA+HBbNEm9GhYcXQ9gXEb=U4x=BZTDp4UBqF8eNH1N0uCBLdadQ@mail.gmail.com>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <CA+HBbNEm9GhYcXQ9gXEb=U4x=BZTDp4UBqF8eNH1N0uCBLdadQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -Sz-B3tC1xAAuuBpkjavbXVi8VdFaNUu
X-Proofpoint-ORIG-GUID: -Sz-B3tC1xAAuuBpkjavbXVi8VdFaNUu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/2/2022 7:16 PM, Robert Marko wrote:
> On Fri, Sep 2, 2022 at 3:42 PM Manikanta Pubbisetty
> <quic_mpubbise@quicinc.com> wrote:
>>
>> On 9/2/2022 6:50 PM, Robert Marko wrote:
>>> On Fri, Sep 2, 2022 at 3:18 PM Manikanta Pubbisetty
>>> <quic_mpubbise@quicinc.com> wrote:
>>>>
>>>> On 9/2/2022 6:18 PM, Kalle Valo wrote:
>>>>> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>>>>>
>>>>>> Enable threaded NAPI on WCN6750. Unlike traditional NAPI poll which
>>>>>> runs in softirq context and on the core which scheduled the NAPI,
>>>>>> threaded NAPI makes use of kernel threads which are under direct
>>>>>> control of the scheduler and helps in balancing the NAPI processing
>>>>>> load across multiple CPUs thereby improving throughput.
>>>>>>
>>>>>> In the case of WCN6750, enabling threaded NAPI has improved
>>>>>> 160 MHz RX throughput by nearly 400 Mbps. This should give similar
>>>>>> gains for other ath11k devices as well, therefore enable threaded
>>>>>> NAPI on all other devices.
>>>>>>
>>>>>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>>>>>>
>>>>>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>>>>>> ---
>>>>>>     drivers/net/wireless/ath/ath11k/ahb.c  | 1 +
>>>>>>     drivers/net/wireless/ath/ath11k/pcic.c | 1 +
>>>>>>     2 files changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
>>>>>> index d7d33d5cdfc5..e44e2f29a88f 100644
>>>>>> --- a/drivers/net/wireless/ath/ath11k/ahb.c
>>>>>> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
>>>>>> @@ -314,6 +314,7 @@ static void ath11k_ahb_ext_irq_enable(struct ath11k_base *ab)
>>>>>>                struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
>>>>>>
>>>>>>                if (!irq_grp->napi_enabled) {
>>>>>> +                    dev_set_threaded(&irq_grp->napi_ndev, true);
>>>>>>                        napi_enable(&irq_grp->napi);
>>>>>>                        irq_grp->napi_enabled = true;
>>>>>>                }
>>>>>> diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
>>>>>> index cf12b98c480d..c703db19de51 100644
>>>>>> --- a/drivers/net/wireless/ath/ath11k/pcic.c
>>>>>> +++ b/drivers/net/wireless/ath/ath11k/pcic.c
>>>>>> @@ -440,6 +440,7 @@ void ath11k_pcic_ext_irq_enable(struct ath11k_base *ab)
>>>>>>                struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
>>>>>>
>>>>>>                if (!irq_grp->napi_enabled) {
>>>>>> +                    dev_set_threaded(&irq_grp->napi_ndev, true);
>>>>>>                        napi_enable(&irq_grp->napi);
>>>>>>                        irq_grp->napi_enabled = true;
>>>>>>                }
>>>>>
>>>>> The commit log claims that this enabled _only_ on WCN6750 but aren't we
>>>>> enabling it on all ath11k hardware, or am I missing something? I admit I
>>>>> didn't check this very carefully.
>>>>>
>>>>> (reads the commit log one more time)
>>>>>
>>>>> Ah, in the last sentence you mention that it's enabled on all hardware.
>>>>> That's quite easy to miss and the commit log is quite misleading, please
>>>>> emphasise already in the title and the first sentence that this is for
>>>>> all hardware.
>>>>
>>>> My Bad, yes you right. The patch was made initially only for WCN6750 and
>>>> was enabled later for all devices.
>>>>
>>>>>
>>>>> Also more testing would be nice. Enabling something like this with
>>>>> testing only on one hardware family (WCN7850) can be risky. I always get
>>>>> warm fuzzy feelings if a patch is tested with all three hardware
>>>>> families we currently support:
>>>>>
>>>>> * IPQ8074 etc
>>>>> * QCA6390 etc
>>>>> * WCN7850
>>>>>
>>>>
>>>> WCN7850 should be an ath12k device If I'm correct.
>>>>
>>>> Regardless of the chip family, even I feel that the tput changes like
>>>> these should be tested on all the chipsets. Availability of the hardware
>>>> and time are something which are stopping me in testing the changes on
>>>> all supported targets.
>>>>
>>>> As I said, I had made the changes only to WCN6750 initially (using a
>>>> hw_param). Can we take that approach for now and enable this for other
>>>> targets only if required & upon thorough testing?
>>>
>>> I can tell you that on IPQ8074 threaded NAPI really improves perfromance.
>>>
>>
>> Great. Do you have any test results on IPQ8074?
> 
> I dont have full test results, but on Poco F2 Pro as the client @80MHz AX
> I got ~720Mbps compared to ~550Mbps before.
> 
> I can tell you that in OpenWrt, we have had it enabled for 6+ months
> at this point
> and its been really good.
> 

That's a significant improvement, great to hear that. We have another 
strong reason to have this change in upstream driver.

Thanks,
Manikanta
