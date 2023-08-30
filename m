Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB45078E2EA
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Aug 2023 00:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344145AbjH3W6o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 18:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344287AbjH3W6j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 18:58:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4592CC0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 15:58:21 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ULGdb0032328;
        Wed, 30 Aug 2023 22:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ODKiYE9OB0DWn4KrTRo7ikfCC4mEUmjVGp92f6ximWY=;
 b=HAQBpwhnEq4wdk0fSivPH919c14Nu98VZbGhiTK3zTqlKLN+BfS84vBbQuflTwzevlp5
 fWCBKPXk7HzLrPdCEZ0rJV44zI1pPH88Qr5tav8OlBZ2kQROJbEzMnrHXxVVsJCP/LW2
 rvwpKKI7R5USpwaLXi0zNe4vkXfTpaKxUnXQGo+pkX+IrSRU8pv6B2/v51qvDA2st/9F
 SCAfHdrIpQLarh5txAt2T9Qo1eOW6mfaSEufbyoxvDyxafgCwJ21+oCHM5IP22k6I/lN
 GT51D1ueBUQREL1GcyLZ4rGvlWB3x8r7frR/yi/hxx/6uABOqx9NXwCMhhIrzSE6cYlf QQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st9vx0gdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 22:12:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UMC6wG017389
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 22:12:06 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 30 Aug
 2023 15:12:06 -0700
Message-ID: <17cbe235-de63-4561-9c17-4c2c1b541e91@quicinc.com>
Date:   Wed, 30 Aug 2023 15:12:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix boot failure with one MSI vector
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
CC:     Baochen Qiang <quic_bqiang@quicinc.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230601033840.2997-1-quic_bqiang@quicinc.com>
 <87fs70hlel.fsf@kernel.org>
 <545cc8e8-481d-85b2-5692-43580936b48d@quicinc.com>
 <897b61ea-36d2-1ab4-9c60-9bdfd2d9cad7@quicinc.com>
 <fa70ca5e-001b-3c6b-dbc2-2853f8fc2f72@quicinc.com>
 <fcb783b4-95e9-24d8-a656-b273a79598a0@quicinc.com>
 <4720b820-523a-477a-436c-72fceb4a6a12@quicinc.com>
 <87sf8bi6lo.fsf@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87sf8bi6lo.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rUaD_9Ig-RxQTrZhg3OVkaxYQ_ENc7Tz
X-Proofpoint-ORIG-GUID: rUaD_9Ig-RxQTrZhg3OVkaxYQ_ENc7Tz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_18,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=789 impostorscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 clxscore=1015 adultscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/22/2023 5:50 AM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>> On 8/7/2023 8:59 PM, Jeff Johnson wrote:
>>> On 8/7/2023 3:16 AM, Manikanta Pubbisetty wrote:
>>>> No impact on WCN6750.
>>>>
>>>> Tested-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>>> Can you provide a Tested-on: flag that Kalle can add to the commit
>>> text?
>>>
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-01160-QCAMSLSWPLZ-1
> 
> Excellent, thanks. The more Tested-on tags I see on the patch the more
> confidence I have for the patch.
> 

This fixes my spurious bootup failure :)

Tested-on: WCN6855 hw2.1 PCI 
WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

