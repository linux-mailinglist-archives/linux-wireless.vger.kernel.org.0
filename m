Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD6E64DD3F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Dec 2022 16:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLOPFK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Dec 2022 10:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiLOPFJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Dec 2022 10:05:09 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0D93055C
        for <linux-wireless@vger.kernel.org>; Thu, 15 Dec 2022 07:05:07 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFEm8Bf026894;
        Thu, 15 Dec 2022 15:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UpvWyTnElu3rN+4LGj/tlp+9gE7yWwfXwvYa0DMyft4=;
 b=om9vehMlSHMY1EsCU/NddVF5kvB0o0KpgBLE1wpAD2Jc/thovphibZUtMecceSBHFG8Y
 wZ0jd/0j3xXwtmox3ajWYEbnRBakyY2SQMfRsfOMdbs4Kl46Xpa2hsuPUwFrbsHBybqk
 Yu4lPbsodLgycP8tetiVmC9PdCWWSk4s4xqIT0gx34F/01Bc3IXGU3aLQrdrSKKLIA0f
 5D2E61Rtpp0vkbL8IQSZnY6NxearZMCem/AO7uMlZBV82ishWSV8FLLnH0AaSlU7e6BD
 Z03yWtw62DzTW6gXCjwUZtNRzOVEKlfvocZbFN+vPNZD7KW3atRuZS+25HZPTgT9P6Wo oQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mg06rsc17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 15:04:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BFF4vTo005476
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 15:04:57 GMT
Received: from [10.253.8.132] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 15 Dec
 2022 07:04:56 -0800
Message-ID: <03e1625e-8989-c465-754b-de3d4b466c58@quicinc.com>
Date:   Thu, 15 Dec 2022 23:04:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 01/15] mac80211: split bss_info_changed method
Content-Language: en-US
From:   Wen Gong <quic_wgong@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
 <20220601093922.347d47c279fe.I15937cfe8405999084f164ddf57390f8b8d2bc61@changeid>
 <c38b4da8-488b-2d09-631a-1bb6c07440a6@quicinc.com>
 <3483d05c1d5a39b9243b54d9f28450344a897655.camel@sipsolutions.net>
 <bd6545a8-57a3-5849-52d5-c1a449ab1712@quicinc.com>
 <d0994456d3a9ea00b5cc472df7822d53d189399e.camel@sipsolutions.net>
 <7e72034a-497a-000c-d7bf-3ec974af9e1c@quicinc.com>
 <f210cf2a6e3f62156ae6a9d6c7de20e16bd4d6e6.camel@sipsolutions.net>
 <95a1604c-f323-0fea-46a8-bf554da28fca@quicinc.com>
 <92fc96e7-6305-ca2f-7f13-5d26d704c7f0@quicinc.com>
In-Reply-To: <92fc96e7-6305-ca2f-7f13-5d26d704c7f0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kt7vp0A6o8yX3HxFLE94l2zqCmLeW5aa
X-Proofpoint-ORIG-GUID: Kt7vp0A6o8yX3HxFLE94l2zqCmLeW5aa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_08,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=783 clxscore=1011
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150122
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/19/2022 12:32 PM, Wen Gong wrote:
> On 10/18/2022 6:10 PM, Wen Gong wrote:
>> On 10/18/2022 5:51 PM, Johannes Berg wrote:
>>> On Tue, 2022-10-18 at 17:50 +0800, Wen Gong wrote:
>>>>> https://p.sipsolutions.net/0652bbbbe350b126.txt
>>>> Conflict happened while run "git am" the patch.
>>>>
>>>> Because missing the  "changed |= BSS_CHANGED_EHT_PUNCTURING;" in my
>>>> local code,
>>>>
>>>> also it is missing in
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/tree/net/mac80211/util.c 
>>>>
>>>>
>>>> Maybe "changed |= BSS_CHANGED_EHT_PUNCTURING;" is only existed in your
>>>> local code?
>>>>
>>> Ah yes, we didn't upstream that because there's still this discussion
>>> about handling puncturing. But you can probably apply around that.
>>>
>>> johannes
>>
>> Yes, after apply it.
>>
>> and apply "commit 3d901102922723eedce6ef10ebd03315a7abb8a5 wifi: 
>> mac80211: implement link switching" to
>>
>> fix build error because my local code is not latest.
>>
>> it is built success, I will try it later.
>>
> Hi johannes,
>
> After above change, no error/kernel crash happened while reconfig 
> single MLO link which link id is 2.

Hi Johannes,

I see this patch https://p.sipsolutions.net/0652bbbbe350b126.txt is not 
merged to 
https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/tree/net/mac80211/util.c

will your merge it later?


