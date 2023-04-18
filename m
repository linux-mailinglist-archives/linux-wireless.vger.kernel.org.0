Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A89E6E5DCB
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjDRJpa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjDRJpI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:45:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AA510D9
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:44:53 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I6sRg8001497;
        Tue, 18 Apr 2023 09:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pSa87Phvong5znlW6iCp9Njmh5hkovsXrhBiT10FP7c=;
 b=fp92tDsmiDuRfOzeDjl58me5qY8JXfjetuuHVhAZaUWNByAagHNSD3kd7OWOwTCvQXKT
 rxETwpaNf6VPKKz5QcZlx8xKxx3/koHOWikPT7h+k4vuqeiWbgMpQ34qC//T2AoBr8uf
 GadiJVkBkoLg3YUDApG6qDf++AOsBnYSkHTezvSoyr72Up7cCGTjt67RHWjs3ZjxdPWg
 zp6NfMIfjzQOBe7hw3inWoiIUk6NFkUJXRMhoPyKXlZVWPcIithHOSRq68aILg5ugark
 4gCUWH8pCsXaqG9+9MnkJVOMU9zkFbmgZEisH0dXrR8vjoNwjOBeZjVvrBcjqJqV3QJV TA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1nk4gf4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:44:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33I9ikfS017950
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:44:46 GMT
Received: from [10.253.75.31] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 18 Apr
 2023 02:44:44 -0700
Message-ID: <a371eb4f-7d79-eeb4-5208-f9a342798021@quicinc.com>
Date:   Tue, 18 Apr 2023 17:44:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <c7fd18fa-531f-a90d-a8fb-442a5aa66d7d@quicinc.com>
 <d1fda46a-2481-8e05-e0a5-9f2bd3850ff4@quicinc.com>
 <868131d13ed7c4c8b5d4938adcd71cf1ff8e9677.camel@sipsolutions.net>
 <5765e3c5-46d4-e92b-a93b-4a2649acff2a@quicinc.com>
 <37958ca93039114b98909d730ff57dd1d10bb68d.camel@sipsolutions.net>
 <b9c6d022-12c3-a696-c4b9-cb14a6d30a45@quicinc.com>
 <91577d586475d290e08dee9e535cb6b4896e06d4.camel@sipsolutions.net>
 <edfc26b5-f6d1-2ab7-f3cc-60a74c8c334d@quicinc.com>
 <61268d31f8a6dd4eea10fcb6048d39244bc584e2.camel@sipsolutions.net>
 <870ce439-85b1-f02c-70e5-2d424fd73372@quicinc.com>
 <34ed0938b69ead648da1aa250a2e081054fb49d4.camel@sipsolutions.net>
 <34212873-0b71-7f39-b064-6b50d8e514b4@quicinc.com>
 <09b156b1ef05377ca7fa0db35e8e13beb5c60e2c.camel@sipsolutions.net>
 <13980456-11a6-384c-7be2-63c005410267@quicinc.com>
 <ab8f9ed0f04873cafb81cc1c9f5d5c804b146aa9.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <ab8f9ed0f04873cafb81cc1c9f5d5c804b146aa9.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CNy9E5ERZbVkyzMTsYHhP7v4Si55eZbo
X-Proofpoint-GUID: CNy9E5ERZbVkyzMTsYHhP7v4Si55eZbo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_05,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=491 malwarescore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180083
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/18/2023 5:38 PM, Johannes Berg wrote:
> On Tue, 2023-04-18 at 17:37 +0800, Wen Gong wrote:
>
>
>>>> the sdata->u.mgd.assoc_data is NOT empty,
>>>>
>>>> and the sdata->u.mgd.assoc_data->link[link_id].addr is valid,
>>>>
>>>> it is addr by eth_random_addr(assoc_data->link[i].addr) in
>>>> ieee80211_mgd_assoc().
>>>>
>>> Exactly, so we've already decided on the address long before we actually
>>> add the link data structure, so your callback would be much too late.
>>> We'd need to have it called from ieee80211_mgd_assoc() already?
>> For the 2nd link, is it OK for me to use the random addr which is set in
>> ieee80211_mgd_assoc().
>>
>> I only need to set the 1st assoc link in low driver.
>>
> Ah. But does it make sense to restrict the API for that? I mean, if you
> just change the prototype a little bit and call it without the link
> conf, you can easily solve this problem too, no?
Sorry, I am not sure how to solve this problem by remove the link conf 
in prototype.
>
> Then your driver just has to call eth_radnom_addr() when it's "don't
> care", but that's OK?
Yes, it is also OK for me to call eth_radnom_addr()for 2nd link.
>
> johannes
