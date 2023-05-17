Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152A0706A5A
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 15:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjEQN75 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 09:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjEQN7y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 09:59:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F61330C2
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 06:59:53 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H95XoT008242;
        Wed, 17 May 2023 13:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5GyuLDnwVsozuR8eAsgE2Ab7PK+ksn54/ioU486uZVQ=;
 b=U/FXRKU32PJyIxhHJGoZNlM6SX2j3eB1LtAATcru+YatbWeyuBfUPlZG/pP1cRSYpe1+
 sxOV3JEFRpwSWw6ZRs0N4THHWAb1P84Zd2I4xEzBE8PzmAqhyBw8X6UgerXmCNsaMOSt
 V7HHrvJcZSRZsw2pkYRuEBkXWKPPCtZsTeMujg5esJb9rMyDXT1svY3LaktDO060qxoS
 gVl+0a6RQTZ4gCH8XMXAjQ6YQuzoIkISRLFKFdE6zRLBx69yTRSwihjkTAaoyaUVQRWj
 6bAZE1/yMTljLxq3iCRmm2pIqcYnPOuFkYK5BRE+k3OGKgwaHZFjowk53IjwFOztnggq Sg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qme0ma78d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 13:59:41 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HDxeiB002901
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 13:59:40 GMT
Received: from [10.201.164.214] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 17 May
 2023 06:59:38 -0700
Message-ID: <351be742-6b4d-c9fd-5583-2a8b2b296d98@quicinc.com>
Date:   Wed, 17 May 2023 19:29:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] wifi: ath11k: Add rx histogram stats
To:     Ben Greear <greearb@candelatech.com>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Abinaya Kalaiselvan <quic_akalaise@quicinc.com>
References: <20230405132804.226681-1-quic_mkenna@quicinc.com>
 <1e0de6cd-4e43-273f-2222-1c52d2b6d95e@candelatech.com>
Content-Language: en-US
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
In-Reply-To: <1e0de6cd-4e43-273f-2222-1c52d2b6d95e@candelatech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gSCAhwQhmW5wRa0eVElYx-yd4tdNXt5P
X-Proofpoint-ORIG-GUID: gSCAhwQhmW5wRa0eVElYx-yd4tdNXt5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxlogscore=740 mlxscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170114
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 4/5/2023 7:05 PM, Ben Greear wrote:
> On 4/5/23 6:28 AM, Maharaja Kennadyrajan wrote:
>> Add peer specific debugfs support to store and
>> display peer rx stats info like HE, VHT, HT,
>> legacy and NSS.
>> Also, add a debugfs knob to reset rx stats
>> specific to the peer.
>>
>> This helps  to debug the throughput related
>> issues in the UL traffic(STA to AP) by getting
>> the segregated rx_stats info like HE, VHT, HT etc,.
>>
>> There is no addition of new debugfs_file here to get
>> these segregated stats. The exising rx_stats is enhanced
>> to get these stats.
>
> I'm a big fan of stats, so nice to see you adding this.
>
> I'd also suggest adding histogram for ampdu length if you can,
> as a sta sending series of 2 frames in ampdu vs sta sending a series
> of 64 frames in ampdu will get significantly different throughput.
>
> Thanks,
> Ben
>
Hi Ben,

Thanks for your feedback and we take your request.

We will send the patch later on your requirement.


Regards,

Maharaja

