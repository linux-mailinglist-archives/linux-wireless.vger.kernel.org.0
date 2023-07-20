Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7FD75A71F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jul 2023 09:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGTHDr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jul 2023 03:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGTHDo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jul 2023 03:03:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A643B1711
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 00:03:43 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K56mhg007200;
        Thu, 20 Jul 2023 07:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yXgt4FHATKYK0VOfUc9aRHAK7qmm0qh15o3ne/8jeLQ=;
 b=TVlVlk3P/Zn2S6u0KFAcg8e0H3ah183LJy//Hka/i+bD38KzrF6kkjX3WjoMUXRUKEl+
 hXI2nN75dwFRi8w89Op9U+wg9GodShnDXG24Fq+EI8jZphl8w9hJbnyNdxMoC6YmSG9O
 f0OLA8jWdG9HlR0oCnIOQODkUPd2u8BqjnHW7lSRIzSb/VERFtw3UdXm7cKATv4Ah53w
 IDIWofRal7bi23vj8pBCcPmp9xQFczOyXFWf+FwWcD6zpvXkH+e9ejFhB1MJhSgqFUOy
 Poyb168rqBbvwUkCFgxD7yqUXvxFqEGoCiLZCpyR/5Wcl489meqSHU5welM+8w08LSBF Mw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rx728u2em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 07:03:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K73d1T018397
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 07:03:39 GMT
Received: from [10.216.33.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 00:03:37 -0700
Message-ID: <6cd11c6d-8ea8-c605-1c91-f550dd891149@quicinc.com>
Date:   Thu, 20 Jul 2023 12:33:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: mac80211: Add support to randomize TA of auth and
 deauth frames
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20230112012415.167556-3-quic_vjakkam@quicinc.com>
 <20230307102225.74883-1-johannes@sipsolutions.net>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <20230307102225.74883-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KRclQ3GwiaoEIUNFwECMgwyc1Sx-jnZ2
X-Proofpoint-ORIG-GUID: KRclQ3GwiaoEIUNFwECMgwyc1Sx-jnZ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=731 impostorscore=0 spamscore=0 clxscore=1011 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200058
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 3/7/2023 3:52 PM, Johannes Berg wrote:
> ---
> So this is the patch I ended up with after some cleanups, but
> then at the end I noticed you didn't unset the temp address
> when the remain-on-channel expires, and wasn't sure exactly
> how that should be handled, and you probably have the better
> test setup right now too ...
>
> johannes
> ---

Hi Johannes,

I verified this patch using below "mac80211_hwsim" and hostap patches. 
It is working fine.

https://patchwork.kernel.org/project/linux-wireless/patch/20230112012415.167556-4-quic_vjakkam@quicinc.com/

https://patchwork.ozlabs.org/project/hostap/list/?series=335502&state=* 
<https://patchwork.ozlabs.org/project/hostap/list/?series=335502&state=*> 
- hostap HWSIM test changes

---

veeru

