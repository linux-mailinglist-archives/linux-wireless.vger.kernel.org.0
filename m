Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96ED79E4AB
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 12:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbjIMKRL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 06:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239615AbjIMKRK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 06:17:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA0B1996
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 03:17:06 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38D9ldBA012425;
        Wed, 13 Sep 2023 10:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HKEQrBNFyvJI/zD44cJ2pqhpQw50EUobihvK3AaXJUg=;
 b=GLak9UzSLx5lQs6gxyB6WTUzZITi9bd8D3Ob/62kkfG97iN9z3JxmJC8OB5nDjsd/9hG
 89ThziDuzOcf9bRiT2hlBvkGQM8l72rYquB9jN+lo/jjqPwBhZzH5YMwtUfvwPKOZg/R
 +2igqyeKlzeo+U649lKCx+2Vu/J2cuc9qcOy2KWwzvkJLNTKMD3TpHczXkw7qecxEN6u
 mf5rT+7I7+sbAdE+VzM7r04NzyJj6brxZCfQXMUMnZz1abX+jdZo39LJma4aMQ3spiQA
 f6RoPJyTybnGAcK4pguhOP0GxWOL19j4dp9vLVeWxNw5zRZ7W6hLTA6M+iHjThGht8b7 Vw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3ar3g2bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 10:16:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38DAGu9W007622
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 10:16:56 GMT
Received: from [10.50.29.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 13 Sep
 2023 03:16:54 -0700
Message-ID: <511f23be-7b7b-42d9-9c3e-25edfa5d7323@quicinc.com>
Date:   Wed, 13 Sep 2023 15:46:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] wifi: cfg80211: export DFS CAC time and usable
 state helper functions
To:     Johannes Berg <johannes@sipsolutions.net>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20230912051857.2284-1-quic_adisi@quicinc.com>
 <20230912051857.2284-2-quic_adisi@quicinc.com>
 <f436ea028da7b016241f307348286be6cfe7df65.camel@sipsolutions.net>
Content-Language: en-US
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <f436ea028da7b016241f307348286be6cfe7df65.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LT7zZJggEuwtyh_hu58Y1mBPjY6zVH0z
X-Proofpoint-ORIG-GUID: LT7zZJggEuwtyh_hu58Y1mBPjY6zVH0z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_04,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=699
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130080
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/13/23 14:58, Johannes Berg wrote:
> On Tue, 2023-09-12 at 10:48 +0530, Aditya Kumar Singh wrote:
>> cfg80211 has cfg80211_chandef_dfs_usable() function to know whether
>> at least one channel in the chandef is in usable state or not. Also,
>> cfg80211_chandef_dfs_cac_time() function is there which tells the CAC
>> time required for the given chandef.
>>
> 
> Should we really export the time function just for a debug messages?
> That seems like a waste of space?
>
Yes absolutely. But actually as a follow up of this patch, we have 
Background DFS patch in pipeline which requires us to send the CAC time 
to firmware. So its actually needed there. And may be once we do this, 
other drivers also may start using this?

