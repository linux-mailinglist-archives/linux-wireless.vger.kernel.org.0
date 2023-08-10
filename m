Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A48776F13
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 06:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjHJEbM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 00:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjHJEbL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 00:31:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777F42111
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 21:31:11 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A3n13B000789;
        Thu, 10 Aug 2023 04:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wlev2qeJ4WmYDKLuS/x8z2R0JwPe54XPqBnP7NgQoqQ=;
 b=mcQGecPy+7MPb+BibJv6RAZmMZKMosY10MvJVXPBbfsm3niqIwmIGSpfsZ9vumj1/duN
 IjMnkkrcaGGS+gP+njM1etjNSor+iOm/wOBhdafQTqhyzXa+m7K7Lq9jTGtyjdVNcB/2
 NyVUUhC+gzsfsq1pKThi+z4ivzYTEfjM1yXs/yho78uMGmsTqUAGn0n+LVec6nrYV80Z
 N/QN3708xBFtBalpDd3e7YqPHKTY3dPaiu71CoC1VyWnGlLGADdZQlC8bqow08iEkUIv
 9cIOA8Sr6YDGv+Q5PxQJA5jsRh5Bg2l+/5oGcpv3RDKZosIOI0Lz6iSk4+PLS82CkNtX 0w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sch7crpnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 04:31:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A4V60F010526
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 04:31:06 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 21:31:04 -0700
Message-ID: <db119d06-7549-3be9-524f-327485d34da9@quicinc.com>
Date:   Thu, 10 Aug 2023 12:31:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] wifi: ath12k: Fix buffer overflow when scanning with
 extraie
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230809081241.32765-1-quic_wgong@quicinc.com>
 <4e63a318-2aa0-2993-ae03-5544c6e41390@quicinc.com>
 <3206e181-f770-c599-87e1-364114b9746a@quicinc.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <3206e181-f770-c599-87e1-364114b9746a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3a71D-IOYlAES0ebsgtH_dxLIL5byYue
X-Proofpoint-GUID: 3a71D-IOYlAES0ebsgtH_dxLIL5byYue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_03,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=398 mlxscore=0 adultscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100038
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/10/2023 2:16 AM, Jeff Johnson wrote:
> On 8/9/2023 10:31 AM, Jeff Johnson wrote:
>> On 8/9/2023 1:12 AM, Wen Gong wrote:
>>>
[...]
>>
>> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>
> Wen, can you please add a Fixes: tag since based upon the discussion 
> you actually observed a crash
>
Jeff, do you mean I should add the crash call stack or other thing in 
this patch?

The crash is observed by Sven Eckelmann <sven@narfation.org>  on 07 Dec 
2021 here:
Subject: Re: [PATCH] ath11k: enable 
IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN6855
https://lore.kernel.org/linux-wireless/3267805.el9kkjlfUZ@ripper/



