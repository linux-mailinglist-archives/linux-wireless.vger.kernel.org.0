Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6490E6FBDBF
	for <lists+linux-wireless@lfdr.de>; Tue,  9 May 2023 05:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjEIDnW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 23:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjEIDnU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 23:43:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEC73AA8
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 20:43:19 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3493F0ii006760;
        Tue, 9 May 2023 03:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=95NsRauO8AStDzIRFJuJ8KLehYEfBimDTI1KRKGBzv4=;
 b=inBRS/ieG6OcdTOCCdjGpurDtFMvcjYhP0e3D/bJlKeGiwgEwJPCnDajpvVtezrgWvs8
 t7TJSTCdupxMS3Y8+R7MgLIRIPV6acm37GY3nypKkSAa7z9bP8MqkX8Rwo/O5AWIgBMy
 8CHlIeOswf5dO0tIxxzYkKkKPpyxFQrWmaVgGHIZQ+viUclENdMroPl7EAf4B92TXBGm
 fQyL9oepoEeyl2Av372AWHT/oR0GemXNgFm6FBirgBmWiuhGLObiw74sqS8+AN39YGRO
 2zfxT5dQnNam1Z7PGqmAdIFDi4iGITGoUFd34U4kdjRHJ/wdhb9XsZIXHEahK37juoum +g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf7860qfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 03:43:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3493hB1E015029
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 03:43:11 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 8 May 2023
 20:43:10 -0700
Message-ID: <b0321483-ae4e-c44f-ed41-4a83e8693f09@quicinc.com>
Date:   Tue, 9 May 2023 11:42:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] wifi: ath12k: Use msdu_end to check MCBC
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230427013021.29792-1-quic_bqiang@quicinc.com>
 <87zg6rqnhv.fsf@kernel.org>
Content-Language: en-US
From:   Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <87zg6rqnhv.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h229tHraor-Z1vMoA4MBuqPQ1BxYY3zu
X-Proofpoint-ORIG-GUID: h229tHraor-Z1vMoA4MBuqPQ1BxYY3zu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090026
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 4/29/2023 1:13 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>
>> We are seeing a very low TCP throughput testing with some specific
>> tools. This is because for sub-frames of an AMSDU, MCBC flag in
>> mpdu_start may be not valid, and as a result those frames would be
>> dropped by kernel.
>>
>> Change to get it from msdu_end.
>>
>> Tested-on: WCN7850 hw2.0 PCI
>> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/hal.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/hal.c
>> b/drivers/net/wireless/ath/ath12k/hal.c
>> index 0ec53afe9915..980ec2024b37 100644
>> --- a/drivers/net/wireless/ath/ath12k/hal.c
>> +++ b/drivers/net/wireless/ath/ath12k/hal.c
>> @@ -889,8 +889,8 @@ static u8
>> *ath12k_hw_wcn7850_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
>>   
>>   static bool ath12k_hw_wcn7850_rx_desc_is_mcbc(struct hal_rx_desc *desc)
>>   {
>> -	return __le32_to_cpu(desc->u.wcn7850.mpdu_start.info6) &
>> -	       RX_MPDU_START_INFO6_MCAST_BCAST;
>> +	return __le32_to_cpu(desc->u.wcn7850.msdu_end.info5) &
>> +	       RX_MSDU_END_INFO5_DA_IS_MCBC;
> New warnings:
>
> drivers/net/wireless/ath/ath12k/hal.c:892:16: warning: cast to restricted __le32
> drivers/net/wireless/ath/ath12k/hal.c:892:16: warning: cast from restricted __le16
>
> Please remember always run ath12k-check (with sparse installed).

Hi Kalle,

I have sent v2 where I change __le32_to_cpu to __le16_to_cpu which 
should fix this warning.

But I can not find ath12k-check, where is this tool? Could you help 
point out?

