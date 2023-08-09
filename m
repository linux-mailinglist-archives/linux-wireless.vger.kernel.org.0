Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6ED776714
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 20:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjHISQT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 14:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHISQS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 14:16:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0481F1736
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 11:16:18 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379F7YgO027866;
        Wed, 9 Aug 2023 18:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VhuCsA9LB+H+wDhsrYRHsMw1UdW8ekrXuowjSWfJlqY=;
 b=ZiPuKpX5I0QBwGl+ns57jqRf1+q555WTuqu+oFjbHc6w9KNyySHwbN79s1yDCrD0UcGb
 k22yanIE253QsWUsYHyoox9qz0xQ14w6TfGXEW2qSVR3/WO2zUq9V5EVrkzPFRzRLF9X
 7KuvswGtkvy6/JckRPYbKCACR4pl7G5HDVqeo+5SrtbeoUtwDw8GuBO08i2YpVHQti0p
 93NKPk2aKRdDS2F+lgPQz2MXxnNY+zaPqaAMcRHnWt6pTad50ZHOOCZH9jaVWaDUEwEc
 eJ5TwI2rj9O3ZXzkZdfvde6H9Eo645qKgGz5OnH935CIL1wzuhSrT2Smkx3rRZMck+zK ow== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbpqs3b36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 18:16:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 379IGFNq013537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 18:16:15 GMT
Received: from [10.111.180.219] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 11:16:14 -0700
Message-ID: <3206e181-f770-c599-87e1-364114b9746a@quicinc.com>
Date:   Wed, 9 Aug 2023 11:16:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: Fix buffer overflow when scanning with
 extraie
Content-Language: en-US
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230809081241.32765-1-quic_wgong@quicinc.com>
 <4e63a318-2aa0-2993-ae03-5544c6e41390@quicinc.com>
In-Reply-To: <4e63a318-2aa0-2993-ae03-5544c6e41390@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WkHK5tlI47vBkbRddeUTOPJ1SUi84lAx
X-Proofpoint-ORIG-GUID: WkHK5tlI47vBkbRddeUTOPJ1SUi84lAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_14,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090160
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/9/2023 10:31 AM, Jeff Johnson wrote:
> On 8/9/2023 1:12 AM, Wen Gong wrote:
>> If cfg80211 is providing extraie's for a scanning process then ath12k 
>> will
>> copy that over to the firmware. The extraie.len is a 32 bit value in 
>> struct
>> element_info and describes the amount of bytes for the vendor information
>> elements.
>>
>> The problem is the allocation of the buffer. It has to align the TLV
>> sections by 4 bytes. But the code was using an u8 to store the newly
>> calculated length of this section (with alignment). And the new
>> calculated length was then used to allocate the skbuff. But the actual
>> code to copy in the data is using the extraie.len and not the calculated
>> "aligned" length.
>>
>> The length of extraie with IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS enabled
>> was 264 bytes during tests with a wifi card. But it only allocated 8
>> bytes (264 bytes % 256) for it. As consequence, the code to memcpy the
>> extraie into the skb was then just overwriting data after skb->end. 
>> Things
>> like shinfo were therefore corrupted. This could usually be seen by a 
>> crash
>> in skb_zcopy_clear which tried to call a ubuf_info callback (using a 
>> bogus
>> address).
>>
>> Tested-on: WCN7850 hw2.0 PCI 
>> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>
>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> 
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Wen, can you please add a Fixes: tag since based upon the discussion you 
actually observed a crash

