Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574035AB345
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiIBOTp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237270AbiIBOTZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:19:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A9E6D55E
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 06:45:09 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282CZmNL025629;
        Fri, 2 Sep 2022 13:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=n4QDxE91DOeLikzE3ZT9rkU6ZRmGhAas02yLLDHaNPQ=;
 b=ekCPzDl/p3RRJLcwtvhE8A9rA0X+mmBgYBhn01UkuofZ55tvzvqwjmK72nZ4dr/iAitV
 qY3EIVmJ3XifVENj1l1NamC+SFDgX6z//XIuDk4XpDpIcLEpodZ4PtprGuEJQi9Kg45L
 fxWRsAhhieseuYaPS3NmOn246yV033pLw5HSNPglWuBRJsMxrBQaj+cZ2zhcuYruLfTR
 FN7RCrbhNHd7OGkiqOaeWkgmZd4eECAFWnwleGAyeXTwxAG+4DvLyMxYT2rDfxwuZ5G9
 Mx+7UTyKYEZ3UGpyKLeY7d0KcqBwXThX1dFMki/VlFImI9weeBoOnY5kEIY0+WKcPBPg Rw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jb3k3akdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 13:44:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 282DihGx023859
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 13:44:43 GMT
Received: from [10.216.25.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 2 Sep 2022
 06:44:41 -0700
Message-ID: <11bfe6a5-0081-1cf7-b8ef-be5ab3d85ff4@quicinc.com>
Date:   Fri, 2 Sep 2022 19:14:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] ath11k: Add multi TX ring support for WCN6750
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20220720135113.15755-1-quic_mpubbise@quicinc.com>
 <20220720135113.15755-3-quic_mpubbise@quicinc.com>
 <878rn2aqln.fsf@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <878rn2aqln.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4IwdeuubSx5XeRTiS6qJ0zTDKbAXgoou
X-Proofpoint-ORIG-GUID: 4IwdeuubSx5XeRTiS6qJ0zTDKbAXgoou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020066
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/2/2022 6:19 PM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>> Currently in the case of WCN6750, only one TCL ring is used for TX,
>> this is limiting the TX throughput in 160 MHz case, enabling multiple
>> TCL rings on WCN6750 has shown an improvement of nearly 300 Mbps in
>> the case of TCP TX, therefore add the support of multi TX ring for
>> WCN6750.
>>
>> Currently TCL ring is selected based on CPU ID, this logic cannot be
>> applied for WCN6750 as there is chance of out of order TX of packets
>> and to avoid this, choose TCL ring based on flow hash so that packets
>> of the same flow will end up on same TCL ring. For the same reason,
>> TCL ring retry logic is also not applicable for WCN6750.
>>
>> Also the mapping of TCL, WBM & RBM IDs for WCN6750 is different from
>> existing devices. Create a new TCM/WBM/RBM mapping for WCN6750.
>>
>> Change does not impact existing ath11k devices.
> 
> It would also nice to document _why_ it doesn't impact existing (or do
> you mean "other"?) devices.
> 

Yes, I mean the change doesn't impact other supported ath11k devices.
This will be applicable only for WCN6750.

I'll rephrase it.

Thanks,
Manikanta
