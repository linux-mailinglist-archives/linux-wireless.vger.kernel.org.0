Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DCC7B2931
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 02:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjI2ABL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 20:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI2ABK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 20:01:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A18199
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 17:01:06 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SMul0Q004460;
        Fri, 29 Sep 2023 00:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MbikhNSNH7OtfWCkgn9Dx4LK9xIPCdbC2zEj+QIsT5g=;
 b=WB1GY+z9aPylHgmKNLLo8zgW2TLX+U5attt8Tvh2viiq8AiHAy+86GzO0PlsFTxemS6I
 jGZn4ogvnEI7RLGrXxi20WCw+n2pzLM06itfGBSdTGOnVjkpmULnnWrwsq6Dr0XqrZgi
 yJU61uUxSb+ZBP2YrfPQ53eoiSiBHfc8dOCp8WJnaocRh6JSBlZWsT7PQjGKtACfaNy6
 KAFkHab1B/pS9v8C+HslY+E0oz1hXrV7LbBN+KaGwgxxZcYTl1b6uxhAGhU9OAls3t4g
 /52F+RH9yurHCxgItnCv7orHvSQPJPyWtxIa9YBhKC69iN+k546l5pgrdRFFufvrYbyf JQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tctcnkax7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 00:00:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38T00sg8012533
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 00:00:54 GMT
Received: from [10.111.177.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 28 Sep
 2023 17:00:54 -0700
Message-ID: <7877b596-6124-4028-8293-147a66a51ebf@quicinc.com>
Date:   Thu, 28 Sep 2023 17:00:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/18] wifi: cfg80211: wext: convert return value to
 kernel-doc
Content-Language: en-US
To:     <gregory.greenman@intel.com>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
References: <20230928143539.1037500-1-gregory.greenman@intel.com>
 <20230928172905.ab3b9274bf07.If263f9f6726d6ad4661f8603e6a4485e0385d67f@changeid>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230928172905.ab3b9274bf07.If263f9f6726d6ad4661f8603e6a4485e0385d67f@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EA1hAHEQr0ZjV50JZxWbooCoK2-krnLL
X-Proofpoint-ORIG-GUID: EA1hAHEQr0ZjV50JZxWbooCoK2-krnLL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_23,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=831 malwarescore=0 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/28/2023 7:35 AM, gregory.greenman@intel.com wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Since I'm getting a warning here right now, fix the
> kernel-doc to be "Returns:" rather than just writing
> that out in the doc paragraph.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> ---
>   net/wireless/wext-compat.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
> index d23ce088bffa..2371069f3c43 100644
> --- a/net/wireless/wext-compat.c
> +++ b/net/wireless/wext-compat.c
> @@ -7,7 +7,7 @@
>    * we directly assign the wireless handlers of wireless interfaces.
>    *
>    * Copyright 2008-2009	Johannes Berg <johannes@sipsolutions.net>
> - * Copyright (C) 2019-2022 Intel Corporation
> + * Copyright (C) 2019-2023 Intel Corporation
>    */
>   
>   #include <linux/export.h>
> @@ -227,7 +227,7 @@ EXPORT_WEXT_HANDLER(cfg80211_wext_giwrange);
>    * cfg80211_wext_freq - get wext frequency for non-"auto"
>    * @freq: the wext freq encoding
>    *
> - * Returns a frequency, or a negative error code, or 0 for auto.
> + * Returns: a frequency, or a negative error code, or 0 for auto.

again, shouldn't this be Return:

>    */
>   int cfg80211_wext_freq(struct iw_freq *freq)
>   {

