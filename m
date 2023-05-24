Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3429270F38F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 11:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjEXJ4t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 05:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEXJ4r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 05:56:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B509C93
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 02:56:46 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O7m05R005760;
        Wed, 24 May 2023 09:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qcpF8zSfzVjspo2Vex9JxsuTTIyVM/odywDrHK5+cTE=;
 b=OcEKOW/3WXUjuGD2IqVuvtV030D8o5/O7jM04tdO+LnGdME3/7bY1vp8w/PLCo4S0pAo
 ppJOYEq3jZhiWdDgfICX5xHm8Z4GubSXJQAD4D+VoS4MKJSuHAPt75oEIS1hM9p01Htm
 hN2YMz9u0egV6F1mlx6OaTNby3Tk9L9xixssz7WdvjHDFnQHJ8HfP0j+2kYTEPXP90we
 AnSYqUiO4qg44EHQ3pY9NS+Zl4wneRtX1Mr0DdY3Q3a7Wo5uTnEJGcmZfVavITpgnYIb
 tWktcgEmyTbqow76rretkm+sQipEPnzSdFkXqGZblN95RIn3fbumBxZslhJ+xT9pr7iQ 3A== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsa0v8tny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 09:56:41 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34O9ueRx006860
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 09:56:40 GMT
Received: from [10.201.165.164] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 24 May
 2023 02:56:38 -0700
Message-ID: <100ef4a2-5050-9ed1-f50b-54b14153e959@quicinc.com>
Date:   Wed, 24 May 2023 15:26:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3] wifi: ath11k: Add rx histogram stats
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     Tyler Stachecki <stachecki.tyler@gmail.com>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER" 
        <ath11k@lists.infradead.org>,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>, <quic_akalaise@quicinc.com>,
        <quic_mpubbise@quicinc.com>
References: <CAC6wqPVvke=Gy59yvYcaps2dwVzO=wfwdSTGNxFzAOWc5OpoDw@mail.gmail.com>
 <d6f794e3-7463-da7d-721e-00869faf4c17@quicinc.com>
 <87h6s2kr5b.fsf@kernel.org>
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
In-Reply-To: <87h6s2kr5b.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FJ2bRzXGjUqB7SQJi4qBhXedP_sqF3MN
X-Proofpoint-ORIG-GUID: FJ2bRzXGjUqB7SQJi4qBhXedP_sqF3MN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_05,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=777
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240084
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 5/24/2023 3:06 PM, Kalle Valo wrote:
> Maharaja Kennadyrajan <quic_mkenna@quicinc.com> writes:
>
>> On 5/21/2023 11:21 PM, Tyler Stachecki wrote:
>>
>>> Was this really tested on QCN9074 as the commit text suggests...?
>>>
>>>> const struct ath11k_hw_ops ipq6018_ops = {
>>>> @@ -1132,6 +1147,7 @@ const struct ath11k_hw_ops wcn6750_ops = {
>>>>    .rx_desc_get_msdu_payload = ath11k_hw_qcn9074_rx_desc_get_msdu_payload,
>>>>    .reo_setup = ath11k_hw_wcn6855_reo_setup,
>>>>    .mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
>>>> + .mpdu_info_get_mpdu_len = ath11k_hw_qcn9074_mpdu_info_get_mpdu_len,
>>> ...
>>>
>>>> +static u32 ath11k_hal_rx_mpduinfo_get_mpdu_len(struct ath11k_base *ab,
>>>> +       struct hal_rx_mpdu_info *mpdu_info)
>>>> +{
>>>> + return ab->hw_params.hw_ops->mpdu_info_get_mpdu_len(mpdu_info);
>>>> +}
>>> I think you want to put this under qcn9074_ops. As of now, when
>>> QCN9074 is present, it attempts to jump to a NULL pointer as
>>> mpdu_info_get_mpdu_len remains uninitialized for qcn9074_ops.
>>>
>>> And, do you not need to define mpdu_info_get_mpdu_len for all the
>>> other hw_ops? If so, please be careful about defining it for
>>> WCN6855/WCN6750 as there was a recent regression due to how the RX
>>> MPDU info is provided by those firmwares as it differed from
>>> IPQ8074/QCN9074. I personally do not have the appropriate literature
>>> to determine whether or not this is consequential or not here as well,
>>> though it seems like it would be:
>>> https://lore.kernel.org/linux-wireless/20230404072234.18503-3-quic_youghand@quicinc.com/
>>>
>>> Tyler
>> Thanks for your comments. Will fix this in the upcoming patchset.
> I have some comments as well but I haven't been able to send them yet. I
> recommend waiting for them before sending the next version.
Sure, Kalle.
