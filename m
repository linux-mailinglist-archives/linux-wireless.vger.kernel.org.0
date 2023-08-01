Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBA876A860
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 07:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjHAFdt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 01:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjHAFds (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 01:33:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80FE212F
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 22:33:20 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37157XQJ015987;
        Tue, 1 Aug 2023 05:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bWzmmG7N6knUsuMwcVF1xrZO6xxcVxQ/41A9QqZTQlA=;
 b=dh9g0Y6a/M1O1vyAfDhbf4boHooRCxe81q6rxo9EiCHScB28Sr59+r5DanXrgnr+p5BE
 P2MtsW+VwQwpYdC5vfg3ODk6/vE+R5b8Dj2ZdSpAxrKInA6S/T8U4dvnYUJxuxWhUzI6
 W78Ct4PLzmi4qZAMZSlHvZC3O1ph6cTdlkfxwOWBEUvvb5IzbnOkXj/h06wL+Slygq0w
 8LYlBasCZpy3r1bF1mONUVvyDC956x9zhn7wKa6EvOMPgj+Emu0SZhUpIiqlIXTJnmAj
 MCzWWf/vFjncovMcIBHXLsZVCwynPeF7fTBnC7SY0k/iGRWnK4kOwIqvUxKrcqDItimI vg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6d61j8v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 05:32:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3715WPlp016538
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 05:32:25 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 22:32:24 -0700
Message-ID: <14c745ff-c5c2-0c88-7280-70598b0f3eb0@quicinc.com>
Date:   Tue, 1 Aug 2023 13:32:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] wifi: ath11k: fix data out of sync for channel list
 for reg update
Content-Language: en-US
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230329091235.19500-1-quic_wgong@quicinc.com>
 <2579553c-2e7f-787c-ad6b-9d21f8a08b39@quicinc.com>
In-Reply-To: <2579553c-2e7f-787c-ad6b-9d21f8a08b39@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pNnSqAlOHtrP4PalAsWrz-3whaLeR0Yc
X-Proofpoint-ORIG-GUID: pNnSqAlOHtrP4PalAsWrz-3whaLeR0Yc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308010051
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

Will you plan to merge it or will you give comments since it has 
deferred/pending here for 4 month ? 😁

It is to fix firmware crash and reg domain used wrong in firmware/hardware.

On 7/10/2023 11:03 AM, Wen Gong wrote:
> On 3/29/2023 5:12 PM, Wen Gong wrote:
>> Currently there are two threads to updating/fetch data of channel
>> list, and there are no synchronization for the data, it leads data out
>> of sync for channel list for reg update.
>>
>> So change the call flow to make sure the fetch data running after the
>> update data finished, then data of channel list become synchronization.
>>
>> Fixes: f45cb6b29cd3 ("wifi: ath11k: avoid deadlock during regulatory 
>> update in ath11k_regd_update()")
>>
>> Wen Gong (2):
>>    wifi: ath11k: move update channel list from update reg worker to reg
>>      notifier
>>    wifi: ath11k: move udpate channel list to worker for wait flag
>>
>>   drivers/net/wireless/ath/ath11k/core.c |   1 +
>>   drivers/net/wireless/ath/ath11k/core.h |   4 +
>>   drivers/net/wireless/ath/ath11k/mac.c  |  13 ++++
>>   drivers/net/wireless/ath/ath11k/reg.c  | 100 ++++++++++++++++---------
>>   drivers/net/wireless/ath/ath11k/reg.h  |   1 +
>>   drivers/net/wireless/ath/ath11k/wmi.h  |   1 +
>>   6 files changed, 86 insertions(+), 34 deletions(-)
>>
>>
>> base-commit: 5aa9ff08c0b71be15a607341fa5344546e19ceb2
>
> Hi Kalle,
>
> Will you plan to merge it or will you give comments?
>
