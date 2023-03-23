Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5536C5F7F
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Mar 2023 07:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjCWGMC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Mar 2023 02:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCWGMB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Mar 2023 02:12:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A5C2B618
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 23:12:00 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N3DX9R026807;
        Thu, 23 Mar 2023 06:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SJwt3xnlW00q9mAzHWH8YYtZaipZa9nTkOv4I9E8rD8=;
 b=lEh+Dts6fB7ftNys+P7ZfhXMz4xymzC5cVji17yEMJEnInjxorQPaHkdoK5KDDRkZ84A
 S2kve62SLC/6g0J/BRG76VkJUyXcjniq3Pl5zSRb7LlQXC4rmsFQteORAgeC40SZjDwE
 7sV8w/awiAd2B2WtGUJmHnKN1o1MApKZNe4bkszJKPWUihoncvwMl9pSVYPzCHe/FVsu
 bAVlzZqLXh6seFNKep7bPvXHYmNUaD9xDvErVM/7qd+oqNdLaMv3TYEzuw/LyiDytBWu
 uoWOnz5PORTWULLZtz9maE8eC09KYqU36yFDz4w+dW3hz+nKNGVoRYqe8nGIXW63qhRA hg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfrk0ujy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:11:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32N6BLw7021723
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:11:21 GMT
Received: from [10.216.59.90] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Mar
 2023 23:11:19 -0700
Message-ID: <2152e5f1-cecd-f5d2-ca4b-e7ed159f40b7@quicinc.com>
Date:   Thu, 23 Mar 2023 11:41:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] wifi: ath11k: Optimize 6 GHz scan time
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230315112103.18426-1-quic_mpubbise@quicinc.com>
 <167948612507.6445.2579526780286789940.kvalo@kernel.org>
Content-Language: en-US
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <167948612507.6445.2579526780286789940.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9qQyJx7lYdHSlp6CHFMbRMxiWwATGWqe
X-Proofpoint-ORIG-GUID: 9qQyJx7lYdHSlp6CHFMbRMxiWwATGWqe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 impostorscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230047
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/22/2023 5:25 PM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:
> 
>> Currently, time taken to scan all supported channels on WCN6750
>> is ~8 seconds and connection time is almost 10 seconds. WCN6750
>> supports three Wi-Fi bands (i.e., 2.4/5/6 GHz) and the numbers of
>> channels for scan come around ~100 channels (default case).
>> Since the chip doesn't have support for DBS (Dual Band Simultaneous),
>> scans cannot be parallelized resulting in longer scan times.
>>
>> Among the 100 odd channels, ~60 channels are in 6 GHz band. Therefore,
>> optimizing the scan for 6 GHz channels will bring down the overall
>> scan time.
>>
>> WCN6750 firmware has support to scan a 6 GHz channel based on co-located
>> AP information i.e., RNR IE which is found in the legacy 2.4/5 GHz scan
>> results. When a scan request with all supported channel list is enqueued
>> to the firmware, then based on WMI_SCAN_CHAN_FLAG_SCAN_ONLY_IF_RNR_FOUND
>> scan channel flag, firmware will scan only those 6 GHz channels for which
>> RNR IEs are found in the legacy scan results.
>>
>> In the proposed design, based on NL80211_SCAN_FLAG_COLOCATED_6GHZ scan
>> flag, driver will set the WMI_SCAN_CHAN_FLAG_SCAN_ONLY_IF_RNR_FOUND flag
>> for non-PSC channels. Since there is high probability to find 6 GHz APs
>> on PSC channels, these channels are always scanned. Only non-PSC channels
>> are selectively scanned based on cached RNR information from the legacy
>> scan results.
>>
>> If NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set in the scan flags,
>> then scan will happen on all supported channels (default behavior).
>>
>> With these optimizations, scan time is improved by 1.5-1.8 seconds on
>> WCN6750. Similar savings have been observed on WCN6855.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
>>
>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> 
> New warning:
> 
> drivers/net/wireless/ath/ath11k/mac.c:3827: line length of 91 exceeds 90 columns
> 
> I couldn't quickly figure out how to fix that, any ideas?
> 

I'd thought that max_line_length is 100 from the checkpatch.pl; I have 
sent V4 patch addressing the warning.

Thanks,
Manikanta
