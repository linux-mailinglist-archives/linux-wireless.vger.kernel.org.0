Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149D479F942
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 06:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjINEAR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 00:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjINEAQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 00:00:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578FBE4B
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 21:00:12 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E2SLqR023121;
        Thu, 14 Sep 2023 03:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qxa0umifniA79gkJomirt37sBRAKhbHvcq4sg/MXTXU=;
 b=GxSnR5Oouw7yhdXBfCd+QUb28tVkCMmg9HqzTRIjvQNmGfEN+sqiVKZyNqa6FF0bHHZa
 Jg3SQVACasVUTOxJkSchBXszCl7FJfqi50YO+2o3OGPZOixrypqFWQ0/XCL0Ndv6XRnP
 Dlk/oyeMQdoHFvuxjaoGLrg+3PnMZw/MWxkC+tBrBFBe25s50KjzJTeVpWjyqzNLaKjO
 XqJv/7PfI84NADxFmRwdMTFq9GQ8cyAILxSwK7TIDiE/O8Nl4SkG4VkS04hhxPv59n3x
 0zUEpFEaiVbs4T3d4mSu9teLiY0m+SdakL/B2v8d76WoWnXq9hN1nV8EA9oAJ2F3coIz XA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3003kbsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 03:59:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E3xu7M001731
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 03:59:56 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 13 Sep
 2023 20:59:55 -0700
Message-ID: <2bb228f8-f3dc-6c37-90b9-4708ae5131fd@quicinc.com>
Date:   Thu, 14 Sep 2023 11:59:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 2/9] wifi: cfg80211: save Power Spectral Density (PSD)
 of the regulatory rule
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        <wireless-regdb@lists.infradead.org>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
 <20230315132904.31779-3-quic_adisi@quicinc.com>
 <4cb3e92530d3f4db3b414e2a7536a0f01b765c4d.camel@sipsolutions.net>
 <46343a69-5f27-4ffa-bbd8-5b5e7616dbbf@quicinc.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <46343a69-5f27-4ffa-bbd8-5b5e7616dbbf@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TmO_v12zixgxb68qR30AOPVmXgh_uZds
X-Proofpoint-GUID: TmO_v12zixgxb68qR30AOPVmXgh_uZds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=846 clxscore=1011
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140032
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/14/2023 11:15 AM, Jeff Johnson wrote:
> On 9/13/2023 7:58 AM, Johannes Berg wrote:
>> So I'd say we shouldn't touch any of the code under #ifdef
>> CONFIG_CFG80211_CRDA_SUPPORT any more since CRDA will not continue to
>> developed with any updates here.
>
> On a related note, what will happen to ongoing wireless-regdb support 
> now that Seth has stepped down as maintainer? Have enough vendors 
> moved to self-managed such that regdb is obsolete?
currently ath10k chips are not self-managed.
