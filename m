Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FF7771DD0
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Aug 2023 12:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjHGKRW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Aug 2023 06:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHGKRU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Aug 2023 06:17:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3146B10F3
        for <linux-wireless@vger.kernel.org>; Mon,  7 Aug 2023 03:17:19 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3779UNfU005049;
        Mon, 7 Aug 2023 10:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/GE3TDhrBc95GUIYVqOP5eZ7OOo9FzivmTYspTgs0rE=;
 b=ivvhGFQ1+tC0MhXGucAAIS8k9vSDCRYpGSwtoEbPcaV0HRjoY0QS5/+S6o+uKasHoM/5
 vSClEG0htA218Wjhi/lYZdubcAnJPjP8hmiH1J0DM34rjLBXbU5p7JwTVsAc0TSinGsN
 Ii1sR0m60kZ6yEoQGzgTmM/sWvrIrGlD2VppxZNBMXKxdlRyPhY7abkO1Iec7Tnz6dI9
 TJ5+cotfj9YlQqS9Cpamvh739sD/VzE6fuwAXeNLA3B1QTwQDSJ7d6juJ2VfE0M3HRq/
 gltPp4MRS1saEk7zN5rQPR6WB6h3/cLKkII8Hsa+7cysajyKF8vLKmVSimQBj/8Dvr5k pg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sax18r6jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 10:16:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 377AGuxW031993
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 10:16:56 GMT
Received: from [10.252.212.151] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 03:16:54 -0700
Message-ID: <fa70ca5e-001b-3c6b-dbc2-2853f8fc2f72@quicinc.com>
Date:   Mon, 7 Aug 2023 15:46:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] wifi: ath11k: fix boot failure with one MSI vector
Content-Language: en-US
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230601033840.2997-1-quic_bqiang@quicinc.com>
 <87fs70hlel.fsf@kernel.org>
 <545cc8e8-481d-85b2-5692-43580936b48d@quicinc.com>
 <897b61ea-36d2-1ab4-9c60-9bdfd2d9cad7@quicinc.com>
In-Reply-To: <897b61ea-36d2-1ab4-9c60-9bdfd2d9cad7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -bgYc91iUoJRUwBx6C_YQut4aBS74Fj5
X-Proofpoint-ORIG-GUID: -bgYc91iUoJRUwBx6C_YQut4aBS74Fj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_09,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070095
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/7/2023 12:53 PM, Manikanta Pubbisetty wrote:
> On 8/7/2023 12:44 PM, Baochen Qiang wrote:
>>
>> On 6/9/2023 8:26 PM, Kalle Valo wrote:
>>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>>>
>>>> Commit 5b32b6dd96633 ("ath11k: Remove core PCI references from
>>>> PCI common code") breaks with one MSI vector because it moves
>>>> affinity setting after IRQ request, see below log:
>>>>
>>>> [ 1417.278835] ath11k_pci 0000:02:00.0: failed to receive control 
>>>> response completion, polling..
>>>> [ 1418.302829] ath11k_pci 0000:02:00.0: Service connect timeout
>>>> [ 1418.302833] ath11k_pci 0000:02:00.0: failed to connect to HTT: -110
>>>> [ 1418.303669] ath11k_pci 0000:02:00.0: failed to start core: -110
>>>>
>>>> The detail is, if do affinity request after IRQ activated,
>>>> which is done in request_irq(), kernel caches that request and
>>>> returns success directly. Later when a subsequent MHI interrupt is
>>>> fired, kernel will do the real affinity setting work, as a result,
>>>> changs the MSI vector. However at that time host has configured
>>>> old vector to hardware, so host never receives CE or DP interrupts.
>>>>
>>>> Fix it by setting affinity before registering MHI controller
>>>> where host is, for the first time, doing IRQ request.
>>>>
>>>> Tested-on: WCN6855 hw2.0 PCI 
>>>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>>>>
>>>> Fixes: 5b32b6dd9663 ("ath11k: Remove core PCI references from PCI 
>>>> common code")
>>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>>> I'm worried if this breaks WCN6750 support. Manikanta, would able to
>>> test this patch on WCN6750 and let us know if breaks anything?
>> Hi Manikanta, could you help test this patch on WCN6750?
> 
> Sure, we will test and update this here.
> 

No impact on WCN6750.

Tested-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>


Thanks,
Manikanta
