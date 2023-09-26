Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045CF7AF03B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 18:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbjIZQGr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 12:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjIZQGq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 12:06:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB6411D
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 09:06:39 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QD4kUb019616;
        Tue, 26 Sep 2023 16:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Hmvi5r0uoIOfgf9Tuw7hGOKzWO5Nc0N/qKV4SUrHuFs=;
 b=BGd0YDQeCLiqVXLvPCFd2kz/g6Uw/CXwrbOAUFjQjbaeYpv55W7JWQCmutO0LPhIZ9M0
 Z5n5wcLli+xmo6pyaSAX8a2I/zqizxeX06eeNuquOr/Dw5+soXvu+fyv3h7kqKH7lfAp
 lJGcs6xcNZt8U0SLSU1v7MebpPub+9gMe7l1Ls2vgXPIrkFnVhMwrSLpzKD7jFN3PWAV
 Lx+Nfo+2hOyVvjqyyQ/AVgwxT+axOiXQDUtPgM50x1EXZZBddMKBVya5RGEE5thFT7dQ
 ENawB9ubZSDAkuLfD4L01vKV1TrMrTtIUMb4/9nnTU+uukdJ6sigSaoH//t7isTwNdye vg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbw9bgxtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 16:06:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38QG6YsM022120
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 16:06:34 GMT
Received: from [10.48.244.213] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 26 Sep
 2023 09:06:33 -0700
Message-ID: <9bf5f334-2e4c-492f-8b8c-65b3ae08b0b9@quicinc.com>
Date:   Tue, 26 Sep 2023 09:06:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] wifi: ath11k: fix ath11k_mac_op_remain_on_channel()
 stack usage
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Tom Rix <trix@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>
References: <30dfbf07-9ec9-4ac9-8199-9f08dbe03739@quicinc.com>
 <20230926042906.13725-1-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230926042906.13725-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: X_gr59pGPrY44WuxdyXKlGqEomfLdeuz
X-Proofpoint-ORIG-GUID: X_gr59pGPrY44WuxdyXKlGqEomfLdeuz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309260141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/25/2023 9:29 PM, Dmitry Antipov wrote:
> When compiling with clang 16.0.6, I've noticed the following:
> 
> drivers/net/wireless/ath/ath11k/mac.c:8903:12: warning: stack frame
> size (1032) exceeds limit (1024) in 'ath11k_mac_op_remain_on_channel'
> [-Wframe-larger-than]
> static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>             ^
> 68/1032 (6.59%) spills, 964/1032 (93.41%) variables
> 
> So switch to kzalloc()'ed instance of 'struct scan_req_params' like
> it's done in 'ath11k_mac_op_hw_scan()'. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


