Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1656E9390
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 14:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjDTMBj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 08:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDTMBh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 08:01:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FDB49FA
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 05:01:36 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KBd7GJ013872;
        Thu, 20 Apr 2023 12:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/osUqaY8L97bUbhwKBxcNk7Zju//5cRg3Q3fd+/UWMg=;
 b=d/v8cTt9ZfiVBZewJXUbwrGZu8OfjXh0zhWaCY1lAXy+vTm+cxxlaI4Gnw9Afh8xByAg
 W1DQM+P3SsA3IQwNsxq456xmCu9lk+zwEQVm6yqyAz9rOG0BqC4zAgy5tWIS8ubiEwHk
 M6Q9gdOxlCYbDwDNx9ukwt2x2ZWSTdQcczSsMhgjHKWLI3JFJRGDrCiSuU2Aop50fKHn
 gytRDJ+Ug1RpmlOZ04RPknVzYsEDnjCwdbulPOX2S/6b234Yp2z/s3+dWWxlwl1dg84O
 JjD4ZrJY8Fu0WqcbQ1w6xIPesFVdKEmzYnYJWaDcCxMyrHWJ7rEZks5kUACfQXKCYEMJ jw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q2p521xj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 12:01:32 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33KC1Vf9024903
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 12:01:31 GMT
Received: from [10.242.242.48] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 20 Apr
 2023 05:01:29 -0700
Message-ID: <825cf403-b833-beff-02d4-cf8fbab89eb0@quicinc.com>
Date:   Thu, 20 Apr 2023 17:31:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/4] ath11k: factory test mode support
Content-Language: en-US
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230420113653.1686-1-quic_rajkbhag@quicinc.com>
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <20230420113653.1686-1-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Dy1LPdddnxWZgTGziZhSgYEaUvZesVnj
X-Proofpoint-GUID: Dy1LPdddnxWZgTGziZhSgYEaUvZesVnj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_07,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=972 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200097
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/20/2023 5:06 PM, Raj Kumar Bhagat wrote:
> Device is booted in factory test mode to calibrate the board.
> The commands are sent from a userspace application, which is
> sent to firmware using wmi commands. Firmware will send the
> response back to the application which stores the calibration
> data in caldata.bin file. This file will be loaded when the
> device boots up normally next time.
> 
> Govindaraj Saminathan (3):
>   wifi: ath11k: remove unused function ath11k_tm_event_wmi
>   wifi: ath11k: optimize ath11k_tm_cmd_get_version
>   wifi: ath11k: factory test mode support
> 
> Sowmiya Sree Elavalagan (1):
>   wifi: ath11k: Allow ath11k to boot without caldata in ftm mode
> 
> ---
> v2:
> - added separate patch for removal of ath11k_tm_event_wmi()
> - added separate patch for changes in ath11k_tm_cmd_get_version()
> - removed unused cmd and updated documentation for enum ath11k_tm_cmd
> - changed warning print to debug print
> ---
> 
>  drivers/net/wireless/ath/ath11k/ahb.c        |   3 +-
>  drivers/net/wireless/ath/ath11k/core.c       |  20 +-
>  drivers/net/wireless/ath/ath11k/core.h       |  15 +-
>  drivers/net/wireless/ath/ath11k/mac.c        |  13 +-
>  drivers/net/wireless/ath/ath11k/pci.c        |   3 +-
>  drivers/net/wireless/ath/ath11k/qmi.c        |  10 +-
>  drivers/net/wireless/ath/ath11k/testmode.c   | 320 ++++++++++++++++---
>  drivers/net/wireless/ath/ath11k/testmode.h   |  20 +-
>  drivers/net/wireless/ath/ath11k/testmode_i.h |  16 +
>  drivers/net/wireless/ath/ath11k/wmi.c        |  40 ++-
>  drivers/net/wireless/ath/ath11k/wmi.h        |  20 ++
>  drivers/net/wireless/ath/ath11k/wow.c        |   3 +-
>  12 files changed, 419 insertions(+), 64 deletions(-)
> 
> 
> base-commit: 12f167f02a1abe2c8817496a902de00758285b92

Please ignore this patch series. Tested-on tag is missing for patches 1/4 and
2/4. Will send v3 with correct Tested-on tag.

Thanks,
Raj
