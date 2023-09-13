Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B1079F3FE
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 23:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjIMVrf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 17:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjIMVrf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 17:47:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7521739
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 14:47:30 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DLU5jv032217;
        Wed, 13 Sep 2023 21:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zOB3TMXlxQOWd47wWRW7tjVhC+s1Kxj//yl7XOtF23Y=;
 b=Thzihdd1ymcA2OeBUuJslxExytxbpJcoTl2meLQWx7ibF1FRnhMZ5ziCBlaJntHonfjH
 C7F0vfRyypQLX0iXvoINH9bFdxubtV3uy4F7xqn0AVkp4a5qtNfWnsmFHHjP9965cBX7
 hLm5OwOTlafuTty8DyLFA+4tgQNgPTRJm6t7pOV3fJYBP9V3ZmcIru8uJP7ycGHAxpkz
 9co973PqDGcbXHHGwZzRHJGc6amwZM0MmJoG7FLIQ03LJaodRVyiSeh4H/oJxh60Um2M
 FgYw2poh8y299uzUI8X7PkOz5vDBwWGf7OmGFH3UG5oD6k6ih1PtZtMshi8eTvBBzFY/ YA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y8e2tnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 21:47:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38DLlQeN011881
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 21:47:26 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 13 Sep
 2023 14:47:24 -0700
Message-ID: <97243829-2858-494c-bf14-c0133eaaf063@quicinc.com>
Date:   Wed, 13 Sep 2023 14:47:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] wifi: cfg80211/mac80211: extend 6 GHz support for
 all power modes
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Wen Gong <quic_wgong@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
CC:     <linux-wireless@vger.kernel.org>,
        "kernel@quicinc.com" <kernel@quicinc.com>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
 <319ecb67faac8a2e50408f2bfa28f2431a6e6b9a.camel@sipsolutions.net>
 <efa43e0a-9ef1-4989-0a45-dc6425d9b96b@quicinc.com>
 <51d4c1a8fe45366b4c3f2baf490ba64d8cced56f.camel@sipsolutions.net>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <51d4c1a8fe45366b4c3f2baf490ba64d8cced56f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 42Tn13xmpZOsmA8XaKE3GphDk0U7GfCz
X-Proofpoint-GUID: 42Tn13xmpZOsmA8XaKE3GphDk0U7GfCz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_16,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=495 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130179
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/13/2023 7:55 AM, Johannes Berg wrote:
> So really all you've achieved right now is again reminding me how little
> you really care about upstream?

I have to step in here. As someone who worked many years on the 
out-of-tree Android drivers I understand where you're coming from. But 
attitudes change, and my transition to the upstream team is a reflection 
of that. I believe everyone from Qualcomm currently contributing to 
nl/cfg/mac80211 are doing so in support of upstream ath11k/12k drivers. 
There are a multitude of patches that you'll get to see once the 
precursor work is out of the way.

I'd prefer to stick to technical discussions :)

Wen,
Can you update your patch to better describe WHY your change is needed?

/jeff



