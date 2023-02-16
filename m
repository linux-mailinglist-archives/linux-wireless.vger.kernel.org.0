Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EFA69980F
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Feb 2023 15:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjBPO46 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Feb 2023 09:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjBPO4z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Feb 2023 09:56:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561C753573
        for <linux-wireless@vger.kernel.org>; Thu, 16 Feb 2023 06:56:44 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G769kW009063;
        Thu, 16 Feb 2023 14:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tRPqnb6HTZVYp3Qfl3xd3ZhIT3OLq4+xr1PNcSTAGeg=;
 b=jMVZJ1id2tCzOlar+eu/i9R6FittIRHGp18wYtUkBH5z0zYp2n4mwxVQxtbN4pc+3wMD
 sviu7eZbQreBvrToVRD2/3kdMGpqI2jruTuvGb7vYt+SWXZ898+my6NKofaj53uDdKnZ
 k3im4OAYfKGiSg9DWmQqbXbuHbGQLUcWeoiD1H2Sb96+GbvU7f0PrxRwzI3JC4GKQnzq
 mCYCpCfZ4WvwFUYCH0W1H3JAgvXhFClbj9yNi9xnpOhfhKgc0IDA+Dk0COKhtgXn/nKV
 j+TLqTN2DUQcK370ELzj81s1/eMmbnwqWAH05XAn4A8WacWtp59Ow1YZxJj/NjuHkYJ6 hQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nsft5s1u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 14:56:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31GEuZnT014678
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 14:56:35 GMT
Received: from [10.216.4.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 16 Feb
 2023 06:56:33 -0800
Message-ID: <00bc8c5e-dcc2-ccea-27ca-489f852bef99@quicinc.com>
Date:   Thu, 16 Feb 2023 20:26:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/2] ath11k: factory test mode support
Content-Language: en-US
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230213130854.2473-1-quic_rajkbhag@quicinc.com>
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20230213130854.2473-1-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6Iw3mZyAsohZhjSnKwTb58JEGBT4VVWg
X-Proofpoint-GUID: 6Iw3mZyAsohZhjSnKwTb58JEGBT4VVWg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_10,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1011 adultscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160129
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 2/13/2023 6:38 PM, Raj Kumar Bhagat wrote:
> Device is booted in factory test mode to calibrate the board.
> The commands are sent from a userspace application, which is
> sent to firmware using wmi commands. Firmware will send the
> response back to the application which stores the calibration
> data in caldata.bin file. This file will be loaded when the
> device boots up normally next time.
> 
> Govindaraj Saminathan (1):
>    wifi: ath11k: factory test mode support
> 
> Sowmiya Sree Elavalagan (1):
>    wifi: ath11k: Allow ath11k to boot without caldata in ftm mode
> 
>   drivers/net/wireless/ath/ath11k/ahb.c        |   3 +-
>   drivers/net/wireless/ath/ath11k/core.c       |  20 +-
>   drivers/net/wireless/ath/ath11k/core.h       |  14 +-
>   drivers/net/wireless/ath/ath11k/debug.h      |   2 +
>   drivers/net/wireless/ath/ath11k/mac.c        |  13 +-
>   drivers/net/wireless/ath/ath11k/pci.c        |   3 +-
>   drivers/net/wireless/ath/ath11k/qmi.c        |  10 +-
>   drivers/net/wireless/ath/ath11k/testmode.c   | 323 ++++++++++++++++---
>   drivers/net/wireless/ath/ath11k/testmode.h   |  21 +-
>   drivers/net/wireless/ath/ath11k/testmode_i.h |  19 ++
>   drivers/net/wireless/ath/ath11k/wmi.c        |  40 ++-
>   drivers/net/wireless/ath/ath11k/wmi.h        |  20 ++
>   drivers/net/wireless/ath/ath11k/wow.c        |   3 +-
>   13 files changed, 427 insertions(+), 64 deletions(-)
> 
> 
> base-commit: ddd8e84e007263f3aa8993f32a3dd4dc8ec0876a

Series LGTM
