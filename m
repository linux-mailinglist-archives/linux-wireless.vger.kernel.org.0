Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59AB783A2D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 08:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjHVGwr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 02:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjHVGwT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 02:52:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A79CE3
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 23:52:05 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M6ksk2023423;
        Tue, 22 Aug 2023 06:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=isBPiWFb20PcYVG0Qhq2pDaldwVdKf3VhjUI2JB1nYo=;
 b=iTy1mtO37wnS1448/q2iqB4bCZLHUX1m04IXtZZgMqoBdqxmRIVtRQKZ00H19bj1vzAP
 s5A++L4DGXkFIWdF9Ml8qe/B/94Jukrj8nMI8fLw3q5rIdPxHVJRj2uSwkB3OeSZ850a
 n5d7i4HbGPgMcUUxlJpIq+AgW4uqz2mPvudjZrz1UN0FK0XbPwl69IZg/4ZbBjUAuJC2
 4yI82iqcgdLV5bmc/n4we1fVNxFvuA90LJoXiw3tsFlg/6g122pWys6fJCBp0RmmpjVM
 Mg/Qz0kr23UR4/Zp1ki8iwjbG9vrnUZzSuv5KGNxQzqXZDSiJMg3gHHwtE+mHbHJoOUO IQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smfjs8skn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 06:51:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37M6pvOi027533
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 06:51:58 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 21 Aug
 2023 23:51:56 -0700
Message-ID: <b6a0dc7e-0ac8-60d3-44aa-dad4f0f17acd@quicinc.com>
Date:   Tue, 22 Aug 2023 14:51:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 0/2] wifi: ath11k: fix data out of sync for channel list
 for reg update
Content-Language: en-US
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230329091235.19500-1-quic_wgong@quicinc.com>
 <2579553c-2e7f-787c-ad6b-9d21f8a08b39@quicinc.com>
 <14c745ff-c5c2-0c88-7280-70598b0f3eb0@quicinc.com>
In-Reply-To: <14c745ff-c5c2-0c88-7280-70598b0f3eb0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BUFnMl3wT1uM2vvIoZvRu9hSh5CI3WsL
X-Proofpoint-GUID: BUFnMl3wT1uM2vvIoZvRu9hSh5CI3WsL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_05,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220054
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

May I change the subject to "wifi: ath11k: fix firmware crash and wrong 
reg domain used in firmware and hardware" and sent new version again?

Or will you merge this version?

On 8/1/2023 1:32 PM, Wen Gong wrote:
> Hi Kalle,
>
> Will you plan to merge it or will you give comments since it has 
> deferred/pending here for 4 month ? 😁
>
> It is to fix firmware crash and reg domain used wrong in 
> firmware/hardware.
>
> On 7/10/2023 11:03 AM, Wen Gong wrote:
>> On 3/29/2023 5:12 PM, Wen Gong wrote:
>>> Currently there are two threads to updating/fetch data of channel
>>> list, and there are no synchronization for the data, it leads data out
>>> of sync for channel list for reg update.
>>>
>>> So change the call flow to make sure the fetch data running after the
>>> update data finished, then data of channel list become synchronization.
>>>
>>> Fixes: f45cb6b29cd3 ("wifi: ath11k: avoid deadlock during regulatory 
>>> update in ath11k_regd_update()")
>>>
>>> Wen Gong (2):
>>>    wifi: ath11k: move update channel list from update reg worker to reg
>>>      notifier
>>>    wifi: ath11k: move udpate channel list to worker for wait flag
>>>
>>>   drivers/net/wireless/ath/ath11k/core.c |   1 +
>>>   drivers/net/wireless/ath/ath11k/core.h |   4 +
>>>   drivers/net/wireless/ath/ath11k/mac.c  |  13 ++++
>>>   drivers/net/wireless/ath/ath11k/reg.c  | 100 
>>> ++++++++++++++++---------
>>>   drivers/net/wireless/ath/ath11k/reg.h  |   1 +
>>>   drivers/net/wireless/ath/ath11k/wmi.h  |   1 +
>>>   6 files changed, 86 insertions(+), 34 deletions(-)
>>>
>>>
>>> base-commit: 5aa9ff08c0b71be15a607341fa5344546e19ceb2
>>
>> Hi Kalle,
>>
>> Will you plan to merge it or will you give comments?
>>
