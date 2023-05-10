Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667CA6FDB50
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 12:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbjEJKGZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 06:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbjEJKGU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 06:06:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E686189
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 03:06:19 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A9sRZm026210;
        Wed, 10 May 2023 10:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=J50TnRZJRGL4MPfE6XpJpXDFU7AOXsklpyeumS3hO9U=;
 b=XQUuRZe7IeDGncXrt8Rs5Daz1IH/7yw8BPQFIdEpYPhIXVHw2DVnxwWY4d5p83OERnGt
 S8X93iXgB8KhwNpWLfOP3chWGD5asEfS84o9Pe4iNgLlPgEQt3r1eUFGDY1hXQ+tGKyg
 Udw2ZVVIO/bzwxvT/v3+BRuQ5cn0sxFDb8P226ZltsUwJnaU099k1t31dwPjxpzW1+9B
 SpcoMEiG1cbuVcfK4L1Y3bMP02Fbg7z1OfNaBYISLAZlXcuFEmvZ/X52nJvEwTw6vPxh
 GpsM7QCbKeLf/PiFJmBIWmI1SY+/Cd/6EZFKxh4KOWtqZQ3lc7qblHhPMhTna00Zsdl6 oA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfrut9v91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 10:06:17 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34AA618O023634
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 10:06:01 GMT
Received: from [10.201.192.62] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 10 May
 2023 03:06:00 -0700
Message-ID: <3a2c1732-e690-231e-d3aa-decbb72588de@quicinc.com>
Date:   Wed, 10 May 2023 15:35:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/2] ath11k: Send HT fixed rate in WMI peer fixed param
Content-Language: en-US
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230504092349.3542530-1-quic_mkenna@quicinc.com>
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
In-Reply-To: <20230504092349.3542530-1-quic_mkenna@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yMJbKlmVn-D2VCY_j3rGHGiM8WbkYfbD
X-Proofpoint-ORIG-GUID: yMJbKlmVn-D2VCY_j3rGHGiM8WbkYfbD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305100079
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Ignore this patchset, I have sent the v2 version of this patchset by 
rebasing it on latest TOT.

> Due to the firmware behavior with HT fixed rate setting,
> HT fixed rate MCS with NSS > 1 are treated as NSS = 1
> HT rates in the firmware and enables the HT fixed rate of
> NSS = 1.
>
> This leads to HT fixed rate is always configured for NSS = 1
> even though the user sets NSS = 2 or > 1 HT fixed MCS in the
> set bitrate command.
>
> Currently HT fixed MCS is sent via WMI peer assoc command.
> Fix this issue, by sending the HT fixed rate MCS in WMI peer
> fixed param instead of sending in peer assoc command.
>
> Maharaja Kennadyrajan (2):
>    ath11k: Relocate the func ath11k_mac_bitrate_mask_num_ht_rates() and
>      change hweight16 to hweight8
>    ath11k: Send HT fixed rate in WMI peer fixed param
>
>   drivers/net/wireless/ath/ath11k/mac.c | 93 ++++++++++++++++++++++-----
>   1 file changed, 76 insertions(+), 17 deletions(-)
>
