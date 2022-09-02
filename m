Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B7F5AB342
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbiIBOTR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbiIBOSu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:18:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119E4106DB4
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 06:44:42 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282Ar9Ot006598;
        Fri, 2 Sep 2022 12:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OR00aDu05wizlIsoeTPnNtPz9tPjGRV1Toqs51iUOek=;
 b=ks271CKm9WnHfL1HAK+npwlHmzxcDHgBrKaOZYEOvbtia24ik29dEGfuFls59AUpmQVa
 1Yy74HXfjZbt3dnUDfRSapASJhH4d8azPsezoUlBXw9IUhWkvWDADSjKB+5Kr6YL6FgC
 j/7LjlLQrwO1YrYWFuGGGmpUxW2HIUP6igqMzrpquUh5Z91gwMC5T/bdalUeIyFXvc+h
 uoQCvzuWq3r7S9VQpBdDeprRT1IOe8AUZ0sJ5Vhe22PyCdQ8ZcpP8r4S7PPuW1RqKo5z
 4472IQnKefy6fc21j5Zto9Oij+0W+574h53lp6TkVV3VJxkioT7wvHWo8S40NvN46IWJ zw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jb5k925bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 12:54:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 282CsS4K007408
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 12:54:28 GMT
Received: from [10.216.25.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 2 Sep 2022
 05:54:27 -0700
Message-ID: <6fd6c592-3bad-ce39-24ea-e28d5ad98e7b@quicinc.com>
Date:   Fri, 2 Sep 2022 18:24:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] ath11k: Enable threaded NAPI on WCN6750
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20220720135113.15755-2-quic_mpubbise@quicinc.com>
 <166212222808.10242.13626602156198198987.kvalo@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <166212222808.10242.13626602156198198987.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O3jMhQAjcFGgTxSPJIuGklltC0ToKwdA
X-Proofpoint-GUID: O3jMhQAjcFGgTxSPJIuGklltC0ToKwdA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=855 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/2/2022 6:07 PM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:
> 
>> Enable threaded NAPI on WCN6750. Unlike traditional NAPI poll which
>> runs in softirq context and on the core which scheduled the NAPI,
>> threaded NAPI makes use of kernel threads which are under direct
>> control of the scheduler and helps in balancing the NAPI processing
>> load across multiple CPUs thereby improving throughput.
>>
>> In the case of WCN6750, enabling threaded NAPI has improved
>> 160 MHz RX throughput by nearly 400 Mbps. This should give similar
>> gains for other ath11k devices as well, therefore enable threaded
>> NAPI on all other devices.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>>
>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> 
> Fails to apply and no base commit provided, so please rebase.
> 
> error: patch failed: drivers/net/wireless/ath/ath11k/core.c:111
> error: drivers/net/wireless/ath/ath11k/core.c: patch does not apply
> error: patch failed: drivers/net/wireless/ath/ath11k/hw.h:205
> error: drivers/net/wireless/ath/ath11k/hw.h: patch does not apply
> stg import: Diff does not apply cleanly
> 
> 3 patches set to Changes Requested.
> 
> 12924009 [1/3] ath11k: Enable threaded NAPI on WCN6750
> 12924011 [2/3] ath11k: Add multi TX ring support for WCN6750
> 12924010 [3/3] ath11k: Increase TCL data ring size for WCN6750
> 

Sure, thanks!
