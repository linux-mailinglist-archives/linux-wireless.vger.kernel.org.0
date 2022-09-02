Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63E75AA68E
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 05:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiIBDsP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Sep 2022 23:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbiIBDsI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Sep 2022 23:48:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2DA65560
        for <linux-wireless@vger.kernel.org>; Thu,  1 Sep 2022 20:48:05 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2823cDvZ024174;
        Fri, 2 Sep 2022 03:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=U+jWr+3B0VIeR5Z9mFg5X2RsWuN+puYztEtaB1ZZ+/s=;
 b=gg3EzgmCRLlLyIx5Zk0S7z3Qzv56QSWdBfYT51NymNK3ZNlIIVFj8L88QSDuag34/zIZ
 msI4zBkRyt3sKIcCB4dP2+84RTT3uV6MD4Pl8Dgo4zcX1P17A5XVAQJpri2L27mYSZbs
 cHDNuN+qie6IQaN+g+RjAI0gCTyiZZTROBDvN68cUV9+ZD+A4w6TTObiVxrYAHlME8C+
 YtGq5a4zQgVbQ3iZAMuk1bH+ldzEp6T8otsG35JZDx2F9mmk7Eqs8WTrncG4hNwfVlYx
 oHINozum/Y87AubI7Z7vxDKr/wVGGUjpOGItLH+QqyxHL46Kb5JPRNwPUyj9THrwqwKW wA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jba0500r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 03:47:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2823VjN1009764
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 03:31:45 GMT
Received: from [10.216.51.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 1 Sep 2022
 20:31:43 -0700
Message-ID: <838ff2d7-4cae-741b-b952-1c765bc71216@quicinc.com>
Date:   Fri, 2 Sep 2022 09:01:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/2] wifi: mac80211: extend rx API with link_id for MLO
 connection
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
References: <20220817104213.2531-1-quic_vthiagar@quicinc.com>
 <87mtbje60u.fsf@kernel.org>
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <87mtbje60u.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lrqoS_9CQd_2GetzMRT006HZQGQwvJKh
X-Proofpoint-ORIG-GUID: lrqoS_9CQd_2GetzMRT006HZQGQwvJKh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1011 spamscore=0 mlxlogscore=487 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020017
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 9/1/2022 4:05 PM, Kalle Valo wrote:
> Vasanthakumar <quic_vthiagar@quicinc.com> writes:
> 
>> From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
> 
> Your last name is missing from SMTP From header:
> 
> From:   Vasanthakumar <quic_vthiagar@quicinc.com>
> 
> If you fix that git doesn't need to add a second From header to the mail
> body.
> 

Sure, ill fix this. Thanks for pointing this out.

Vasanth
