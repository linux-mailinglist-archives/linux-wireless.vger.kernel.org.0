Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE04574CA24
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jul 2023 05:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGJDDu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jul 2023 23:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGJDDt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jul 2023 23:03:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9F3EC
        for <linux-wireless@vger.kernel.org>; Sun,  9 Jul 2023 20:03:48 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A2kObw029979;
        Mon, 10 Jul 2023 03:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LoxxLL/+E/9qdH8uQyJ4p3c8CVoRc1vARGpSw0cg3To=;
 b=Ey1GfxGAxqGIVunP3U4uajBo7bTGbNMjWThaPWCRN1Dr/lf9vna6olZq6VRoKii4w7rg
 5kCawOS/8Qoi+fB8/VFWa52GTEKGElPMO+wzY7RCJmeJ8esCiUtB5d0AvZLdY90TgB8Z
 wJkZJJzNf824WBZAcs2wonzNp1UttH+gfiIcev6Ap7SzjTkbHCRU74WKsYfGk3RArEv+
 YDEbgZjQokq6wQMTdj3Xm0ew0CNz1dFN3B7A9xASOaz7TBtmzEooRaK+O6Jr7gZWTTUY
 hFoALMd5w/wKncYjk/RtrrBZoA2xkMLYF61QHes1m+mlpRjTc1VZQYjBe1N6EpgtNmyh Ag== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rq0jpja2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 03:03:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36A33haA012406
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 03:03:43 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 9 Jul
 2023 20:03:42 -0700
Message-ID: <2579553c-2e7f-787c-ad6b-9d21f8a08b39@quicinc.com>
Date:   Mon, 10 Jul 2023 11:03:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] wifi: ath11k: fix data out of sync for channel list
 for reg update
Content-Language: en-US
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230329091235.19500-1-quic_wgong@quicinc.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20230329091235.19500-1-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gX-VbmAx3IAmbPffUYFiaBG1j-boV1UI
X-Proofpoint-GUID: gX-VbmAx3IAmbPffUYFiaBG1j-boV1UI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_02,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100026
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/29/2023 5:12 PM, Wen Gong wrote:
> Currently there are two threads to updating/fetch data of channel
> list, and there are no synchronization for the data, it leads data out
> of sync for channel list for reg update.
>
> So change the call flow to make sure the fetch data running after the
> update data finished, then data of channel list become synchronization.
>
> Fixes: f45cb6b29cd3 ("wifi: ath11k: avoid deadlock during regulatory update in ath11k_regd_update()")
>
> Wen Gong (2):
>    wifi: ath11k: move update channel list from update reg worker to reg
>      notifier
>    wifi: ath11k: move udpate channel list to worker for wait flag
>
>   drivers/net/wireless/ath/ath11k/core.c |   1 +
>   drivers/net/wireless/ath/ath11k/core.h |   4 +
>   drivers/net/wireless/ath/ath11k/mac.c  |  13 ++++
>   drivers/net/wireless/ath/ath11k/reg.c  | 100 ++++++++++++++++---------
>   drivers/net/wireless/ath/ath11k/reg.h  |   1 +
>   drivers/net/wireless/ath/ath11k/wmi.h  |   1 +
>   6 files changed, 86 insertions(+), 34 deletions(-)
>
>
> base-commit: 5aa9ff08c0b71be15a607341fa5344546e19ceb2

Hi Kalle,

Will you plan to merge it or will you give comments?

