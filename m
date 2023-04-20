Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AEA6E8EB0
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 11:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjDTJzN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 05:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDTJzM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 05:55:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD1D10F
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 02:55:11 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K9haS0016455;
        Thu, 20 Apr 2023 09:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8Qn5q/7ax1KIXG8AqHLj5T63wtVyklBZfXUgFt4XpSM=;
 b=G+5QXeiwtlqPr5Q6MEeAnkR9O7Yuo/i0SBF0XTpUA5TCi/DmCpu/ocL1NLQ69OlTRPhI
 xYrrKqGPiCq+Rv7Yn8o6VSaLOhAkyiuGKMZxZr0/DUN5uCuhX3v+OFmFgS2kAWPdjdK0
 Wg2fi695WzLSsgpSIq4KAc2tiju5vMW2Yl0fcK3acrxj9qUw8qq1o6xLn263jWkqM6wY
 aSJMxveI6jxQ1LtVnVLII87JjJrlyX8E5zFwBC0JKTG94z4eiqDqmxx2r6YyFodZvZPM
 4mjv+lWJ/n25KQD0sEsdeWwCKTrwYIDuB6x/neFI8Zkxjsvdd2r+QkCCYn8+Rp1BHUS/ 8g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q2nn81r2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 09:54:58 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33K9svHB010058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 09:54:57 GMT
Received: from [10.242.242.48] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 20 Apr
 2023 02:54:36 -0700
Message-ID: <7d4eacd9-71be-e75f-fad4-ec07c00041d5@quicinc.com>
Date:   Thu, 20 Apr 2023 15:24:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] wifi: ath11k: factory test mode support
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Govindaraj Saminathan" <quic_gsaminat@quicinc.com>,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
References: <20230213130854.2473-1-quic_rajkbhag@quicinc.com>
 <20230213130854.2473-2-quic_rajkbhag@quicinc.com> <87mt4hnfk2.fsf@kernel.org>
Content-Language: en-US
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <87mt4hnfk2.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RFRIjXMJs9kUZ2L_-MIrkk5XIeGVq5M3
X-Proofpoint-GUID: RFRIjXMJs9kUZ2L_-MIrkk5XIeGVq5M3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_06,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200079
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/13/2023 3:23 PM, Kalle Valo wrote:
> Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:
> 
>> From: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
>>
>> Add support to process factory test mode commands(FTM) for calibration.
>> By default firmware start with NORMAL mode and to process the FTM commands
>> firmware needs to be restarted in FTM mode using module parameter ftm_mode.
>> The pre-request is all the radios should be down before starting the test.
>>
>> When start command ATH11K_TM_CMD_TESTMODE_START is received, ar state
>> is set to Test Mode. If the FTM command or event length is greater
>> than 256 bytes, it will be broken down into multiple segments and
>> encoded with TLV header if it is segmented commands, else it is sent
>> to firmware as it is.
>>
>> On receiving UTF event from firmware, if it is segmented event, the driver
>> will wait until it receives all the segments and notify the complete
>> data to user application. In case the segmented sequence are missed or
>> lost from the firmware, driver will skip the already received partial data.
>>
>> In case of unsegmented UTF event from firmware, driver notifies the
>> data to the user application as it comes. Applications handles
>> the data further.
>>
>> Command to boot in ftm mode
>> insmod ath11k ftm_mode=1
>>
>> Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
>> Co-developed-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
>> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> 
> [...]
> 
>> --- a/drivers/net/wireless/ath/ath11k/core.c
>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>> @@ -1,7 +1,7 @@
>>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>>  /*
>>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
>>   */
>>  
>>  #include <linux/module.h>
>> @@ -32,6 +32,10 @@ module_param_named(frame_mode, ath11k_frame_mode, uint, 0644);
>>  MODULE_PARM_DESC(frame_mode,
>>  		 "Datapath frame mode (0: raw, 1: native wifi (default), 2: ethernet)");
>>  
>> +unsigned int ath11k_ftm_mode;
>> +module_param_named(ftm_mode, ath11k_ftm_mode, uint, 0444);
>> +MODULE_PARM_DESC(ftm_mode, "Boots up in factory test mode");
> 
> I changed this to bool as there's only two values, true or false.
> 
>> @@ -1362,6 +1366,11 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
>>  {
>>  	int ret;
>>  
>> +	if (ath11k_ftm_mode) {
>> +		ab->fw_mode = ATH11K_FIRMWARE_MODE_FTM;
>> +		ath11k_info(ab, "Booting in ftm mode\n");
>> +	}
> 
> I changed this to:
> 
> "Booting in factory test mode\n"
> 
>> @@ -1822,6 +1832,10 @@ static void ath11k_core_post_reconfigure_recovery(struct ath11k_base *ab)
>>  			ath11k_warn(ab,
>>  				    "device is wedged, will not restart radio %d\n", i);
>>  			break;
>> +		case ATH11K_STATE_TM:
>> +			ath11k_warn(ab, "fw mode reset done radio %d\n", i);
>> +			break;
> 
> What is this warning supposed to tell the user? Should it be a debug
> message instead?

Will move this to debug message in version 2.


Thanks,
Raj

