Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD06C77516F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 05:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjHIDfn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 23:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHIDfm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 23:35:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CF910CF
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 20:35:42 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3792qAPT028530;
        Wed, 9 Aug 2023 03:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MUrn6L2oeAg1kKZjfSAiMGnJSbsi3v8N7jpAl/UNG8o=;
 b=CCV2VY3BnJT7m/pJpSUvbgVPnaTG24ltdg17USJJkcFg5tx56YSL/fNE9vhMdC/jXKU4
 mStu/lgQNYVCpWeFp0KjzajoC6lUwj5FXHLFtnVB4YeyXbPlnVprbgPZyUpLtyG9/BhL
 gCcElTcE+ZWYhYB4KeSx/mch1TI4ayLnGfjuhOAp9sF9SWq/pJKIyoyUKe565gpSuoJO
 +kgz9hrF46a407dMyuci9s7PP9pUDqhefqpU0WTZDJiDxPqI3RATeNY/GN1Q0OwB8hB/
 5sq9rQlohBRdxzQuUVQbAk+jHLbANHteylJpznC0PAvNsKq3JBIrJZfpwjJuPPbQtlOf Vw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbppchfy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 03:35:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3793ZVII027896
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 03:35:32 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 20:35:30 -0700
Message-ID: <4b53807c-cbe6-dbd6-0ff6-b0342abe7198@quicinc.com>
Date:   Wed, 9 Aug 2023 11:35:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] wifi: ath12k: Fix buffer overflow when scanning with
 extraie
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230807030806.9345-1-quic_wgong@quicinc.com>
 <6ccf4549011f0efa67523d1c171b23694122ec6c.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <6ccf4549011f0efa67523d1c171b23694122ec6c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: klIfva6_s9-dMxyTC5KMZiE5Gb-V3ktg
X-Proofpoint-GUID: klIfva6_s9-dMxyTC5KMZiE5Gb-V3ktg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_24,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=876 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090031
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/8/2023 6:55 PM, Johannes Berg wrote:
> Hi,
>
> Since I'm covering for Kalle right now ...
>
> On Sun, 2023-08-06 at 23:08 -0400, Wen Gong wrote:
[...]
> I feel these are two separate issues. Having a large enough TLV that the
> firmware cannot parse it is highly unlikely to happen, and not really an
> issue here.
>
> Please split this into two patches, and fix *just* the buffer overflow
> in a patch titled "Fix buffer overflow". I believe simply changing the
> variable type is sufficient for this, as the code is otherwise
> equivalent. That's a patch I'd take to wireless at this stage (rc5), but
> probably not the entire bigger change.
>
> johannes
Yes, let me send the 2 patch separately .
