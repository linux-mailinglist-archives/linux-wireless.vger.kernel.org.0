Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AAD65CC77
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jan 2023 05:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjADE5c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 23:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjADE5a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 23:57:30 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C93017E39
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 20:57:29 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3041OAqv031215;
        Wed, 4 Jan 2023 04:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KRwAMjnpltsWvxcNtrraxKdFNHuaR97XLM81aAxzojw=;
 b=ftcZHasFZsYO7CYoa2exbDPU0LXmgPktN0tYyB9qR23Z9oMja6sHbctfh9hoew15Ykwv
 AKlLN7HPcf0vIZqEjdXiF9PZsnLYDtyE00uqXyXAH2Y8ts/H2cNVOlZSgGgRrjGs/F3W
 IMPUJUomGjY4syFjvGm3n52c+EDE+80TsNQQP5LY/jGLtrIa0YmZFqhdXMnc300t0Enj
 +DIkL34gAUlpQZqjPF9kyJkjK7DmsezbYWnrRaM7IfJq1aW8OikJF2RGWkI/IBATHfrC
 vp8JaCjtPuF0auMVYeS6cF5uGs1t/582Ab7YMPkHvNhjzRFXLF+pIqLa/cXRczXHxhlW Cg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mvsvv90j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 04:57:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3044vKAJ009183
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Jan 2023 04:57:20 GMT
Received: from [10.201.165.48] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 3 Jan 2023
 20:57:19 -0800
Message-ID: <61261415-b98b-7476-fd55-3141a26d0dd6@quicinc.com>
Date:   Wed, 4 Jan 2023 10:26:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] wifi: ath11k: Set ext passive scan flag to adjust passive
 scan start time
Content-Language: en-US
To:     Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20221222131720.11368-1-quic_tamizhr@quicinc.com>
 <e11e4312-d373-ba54-6d48-a9c471f78532@quicinc.com>
From:   Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
In-Reply-To: <e11e4312-d373-ba54-6d48-a9c471f78532@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iHN3Wh0SyweoBDP85HYxumxN58BqfBXo
X-Proofpoint-GUID: iHN3Wh0SyweoBDP85HYxumxN58BqfBXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_02,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=982
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301040040
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/2/2023 3:49 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 12/22/2022 6:47 PM, Tamizh Chelvam Raja wrote:
>> Set the WMI_SCAN_FLAG_EXT_PASSIVE_SCAN_START_TIME_ENHANCE flag
>> while sending the scan command.  If this flag is enabled when the
>> incoming scan request comes with a strict start time and its duration
>> overlaps with next TBTT, then target adjust the start time accordingly
>> for passive scan. Target supporting this feature will advertise
>> WMI_TLV_SERVICE_PASSIVE_SCAN_START_TIME_ENHANCE.
>>
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01467-QCAHKSWPL_SILICONZ-1
>>
> 
> If this change fixes any user visible issue, better to include that details.
> 
There are no user visible issues without this change.


-- 
Regards,
Tamizh
