Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C7B7779DA
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 15:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjHJNqr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 09:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjHJNqr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 09:46:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D6D26B8
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 06:46:46 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AAJECY024365;
        Thu, 10 Aug 2023 13:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iOAvJZH5JY+Z/57aBU4Dk2Q0ieWD9M1c8GTw6TAKfro=;
 b=nCpYsSvDfBcm+d7vG18cAWOlTM7tv+WAirOPAhGlBAdFWspkKePv+GNXfQ7bd5orjqXg
 +okvBQwzbituoPTgrqaegGlBRAt0dE/pAVb7VgpGnZIdsi5GfIMlgTEYXYbSAGhmYMeQ
 2PgB7uDPN3WTKFjlASgS1nXU3rH4AHm/AyYTy5hqkRTQ5yFAv8rlv1BvPJO1tnQuu+HO
 iL5vzDr2bmy3LFY8plPf9B+ZB2iFBtATuT49Vyn8ISw+1oFrRuo9QPeiKljt6oarPKQ/
 scigFlvVOws8Ulswm+726NCPDpUIQ9jxD+wsMgeIcbVekotaQ/UlUZNpp/9hmMj/g7OA 6Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sc5ffbhm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 13:46:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37ADkRlr008604
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 13:46:27 GMT
Received: from [10.111.183.64] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 06:46:27 -0700
Message-ID: <53b0e1af-c013-72d0-d98d-38ae44962dec@quicinc.com>
Date:   Thu, 10 Aug 2023 06:46:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: Fix buffer overflow when scanning with
 extraie
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230809081241.32765-1-quic_wgong@quicinc.com>
 <4e63a318-2aa0-2993-ae03-5544c6e41390@quicinc.com>
 <3206e181-f770-c599-87e1-364114b9746a@quicinc.com>
 <db119d06-7549-3be9-524f-327485d34da9@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <db119d06-7549-3be9-524f-327485d34da9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XuEi1uWN8RLmsPXe07kQ98qW_Y7fJdJD
X-Proofpoint-GUID: XuEi1uWN8RLmsPXe07kQ98qW_Y7fJdJD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=823
 mlxscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/9/2023 9:31 PM, Wen Gong wrote:
> On 8/10/2023 2:16 AM, Jeff Johnson wrote:
>> On 8/9/2023 10:31 AM, Jeff Johnson wrote:
>>> On 8/9/2023 1:12 AM, Wen Gong wrote:
>>>>
> [...]
>>>
>>> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>
>> Wen, can you please add a Fixes: tag since based upon the discussion 
>> you actually observed a crash
>>
> Jeff, do you mean I should add the crash call stack or other thing in 
> this patch?
> 
> The crash is observed by Sven Eckelmann <sven@narfation.org>  on 07 Dec 
> 2021 here:
> Subject: Re: [PATCH] ath11k: enable 
> IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN6855
> https://lore.kernel.org/linux-wireless/3267805.el9kkjlfUZ@ripper/
> 
> 
> 

It isn't necessary to add a call stack. Based upon the above you should 
add both a Fixes: tag and a Link: tag. These go in the tags section of 
the commit text before the Signed-off-by:

<https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes>
A Fixes: tag indicates that the patch fixes an issue in a previous 
commit. It is used to make it easy to determine where a bug originated, 
which can help review a bug fix. This tag also assists the stable kernel 
team in determining which stable kernel versions should receive your 
fix. This is the preferred method for indicating a bug fixed by the 
patch. See Describe your changes for more details.


<https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-changes>
If related discussions or any other background information behind the 
change can be found on the web, add 'Link:' tags pointing to it. If the 
patch is a result of some earlier mailing list discussions or something 
documented on the web, point to it.

