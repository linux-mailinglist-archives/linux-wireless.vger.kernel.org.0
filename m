Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F5669D9DF
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Feb 2023 04:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjBUDza (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Feb 2023 22:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjBUDz3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Feb 2023 22:55:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE63F20543
        for <linux-wireless@vger.kernel.org>; Mon, 20 Feb 2023 19:55:28 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L3RDQB008353;
        Tue, 21 Feb 2023 03:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cfq1rCRWoe37bjZ0wgbabK0s/cVWevfafQpnqgqHxlA=;
 b=eAgbkMfCY5+Zm3ctF2BGtFHKu+A8xRxjcOztmjiuBzPk6a2eO2vPQw4afOpQqKjE4PoA
 JOUE/B7+9/xMym3h1le3j1ahfP90/Kr/qjRP6/dyOooyk4vRsCw37nLMS7XJ49F96cj1
 9Pyn90bzaLqPpsoIsQh4KZtErwg6rjE88Ri2AO9PorqkwYcC5kk8gW1jz+mGOUe2SOA2
 LLDoeMHdh+XMP9tybuTBtC69gpdwPp1yjPRstiEJF2huTRBfJMiZivcsnvV10md8pQbK
 JdxfOD7s8EBlwX0Scm8gkGfsQRHyUD7AI0bEMn8XMf3cakmZB8vIwf6wdUqn9lXaClPb 4Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ntpw9pe28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 03:55:22 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31L3tLEH001098
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 03:55:21 GMT
Received: from [10.110.58.30] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Feb
 2023 19:55:19 -0800
Message-ID: <20676cf0-fa15-24bc-8ebe-3014c85c0f7f@quicinc.com>
Date:   Mon, 20 Feb 2023 19:55:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 0/4] v3: EMA and HWSIM support in AP mode
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
References: <20221206005040.3177-1-quic_alokad@quicinc.com>
Content-Language: en-US
In-Reply-To: <20221206005040.3177-1-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mnKcwPAEkJGYqc2G62fFmer-icd01CY0
X-Proofpoint-GUID: mnKcwPAEkJGYqc2G62fFmer-icd01CY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_19,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=917 clxscore=1011
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210034
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/5/2022 4:50 PM, Aloka Dixit wrote:
> Add support for EMA AP beacon generation and mac80211_hwsim to
> test MBSSID and EMA in AP mode.
> 
> v3:
> - Added a missing NULL check for mbssid_ies in patch #1/4.
> - Hostapd hwsim tests using the changes from this version are mentioned
> in the corresponding patches and these are already merged in hostapd.git.
> - Dropped ath11k patches.
> 
> Aloka Dixit (4):
>    wifi: mac80211: generate EMA beacons in AP mode
>    wifi: mac80211_hwsim: move beacon transmission to a separate function
>    wifi: mac80211_hwsim: Multiple BSSID support
>    wifi: mac80211_hwsim: EMA support
> 
>   drivers/net/wireless/mac80211_hwsim.c |  83 +++++++++++-----
>   include/net/mac80211.h                |  68 +++++++++++++
>   net/mac80211/cfg.c                    |  11 ++-
>   net/mac80211/ieee80211_i.h            |  10 +-
>   net/mac80211/tx.c                     | 134 +++++++++++++++++++++++---
>   5 files changed, 263 insertions(+), 43 deletions(-)
> 
> 
> base-commit: 65e6af6cebefbf7d8d8ac52b71cd251c2071ad00

Hello,
Please review this series.
