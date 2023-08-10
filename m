Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCC7776F2C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 06:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjHJErA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 00:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjHJEq7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 00:46:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA101982;
        Wed,  9 Aug 2023 21:46:58 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A4ctEM024311;
        Thu, 10 Aug 2023 04:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=80TgkSOn3r8Pny1tEgsCx24DCuBgp5vRLONNgzfdUJE=;
 b=dGUG1FK6QHlB1hVKPrL2nMv4sz7ugd8isqMYG4jGoLshN79e2gtM8k+z85pyTY9BhX7b
 Qie1oFqb3CssrW0vZD6UJuYrLotTLAQ38wJkkVXATp56UsWTpsuZMMYtac90qyouxVWI
 YS27ttZDBWIepDjqV+jVzzDVlXt4IfQQ3CYxS8WK4joKZ5tsWdU4J8Iui0B/bQxt7/Zk
 x6TCRg3rF8Ao6s3n+nnC4i5cZmOL5di4xEE9OPVrXEFtijqhP5CfiDE1555J925cjuUi
 M7e42CAPbBVTdo4O4y21Y74Z8vVyPmaDr8nKKCMC3tegkyEElOD435Tr3lNKKe0+N55r eQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sc1ny2upu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 04:46:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A4kSqf028319
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 04:46:28 GMT
Received: from [10.204.118.225] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 21:46:24 -0700
Message-ID: <25b778d4-81dc-506b-47f1-e9f16d49682f@quicinc.com>
Date:   Thu, 10 Aug 2023 10:16:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "Revert "wifi: ath11k: Enable threaded NAPI""
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     Johan Hovold <johan+linaro@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230809073432.4193-1-johan+linaro@kernel.org>
 <42f78c02-1ddc-cf1c-694f-abf9059dfb60@quicinc.com>
 <ZNNZVsFb3_Dt_NMb@hovoldconsulting.com>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <ZNNZVsFb3_Dt_NMb@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6nDj2Hu3oNy2GWeh8iYUNTmCTdfnVwCk
X-Proofpoint-ORIG-GUID: 6nDj2Hu3oNy2GWeh8iYUNTmCTdfnVwCk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_03,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=470 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100041
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 8/9/2023 2:46 PM, Johan Hovold wrote:
> On Wed, Aug 09, 2023 at 02:32:37PM +0530, Manikanta Pubbisetty wrote:
>> On 8/9/2023 1:04 PM, Johan Hovold wrote:
>>> This reverts commit d265ebe41c911314bd273c218a37088835959fa1.
>>>
>>> Disabling threaded NAPI causes the Lenovo ThinkPad X13s to hang (e.g. no
>>> more interrupts received) almost immediately during RX.
>>>
>>> Apparently something broke since commit 13aa2fb692d3 ("wifi: ath11k:
>>> Enable threaded NAPI") so that a simple revert is no longer possible.
>>>
>>
>> This is getting as weird as it would get :)
>>
>>> As commit d265ebe41c91 ("Revert "wifi: ath11k: Enable threaded NAPI"")
>>> does not address the underlying issue reported with QCN9074, it seems we
>>> need to reenable threaded NAPI before fixing both bugs properly.
>>>
>>
>> It seems that the revert has actually solved the issue reported with
>> QCN9074.
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=217536
> 
> Sure, but it's only a workaround as the underlying cause has not been
> identified.
> 
>> We were trying to reproduce the problem on X86+QCN9074 (with threaded
>> NAPI) from quite some time, but there is no repro yet.
>>
>> Actually, enabling/disabling threaded NAPI is a simple affair; I'm
>> wondering to hear that interrupts are blocked due  to not having
>> threaded NAPI.
> 
> It sounds to me like the driver's locking is broken if moving to softirq
> processing hangs the machine like this. But I have not had time to try
> to try to track it down besides verifying that reenabling threaded NAPI
> makes the problem go away.
> 
>> What is the chip that Lenovo Thinkpad X13s is having?
> 
> It's a WCN6855 (QCNFA765).
> 

Also it is worth to give a try with this patch here 
https://patchwork.kernel.org/project/linux-wireless/patch/20230601033840.2997-1-quic_bqiang@quicinc.com/ 
. This seems to be fixing some known interrupt issue on WCN6855. Could 
you pls give a try?

Thanks,
Manikanta
