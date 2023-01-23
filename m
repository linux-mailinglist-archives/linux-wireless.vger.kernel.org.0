Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52366677AF3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 13:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjAWMbl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 07:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAWMbk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 07:31:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB48BB9A
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 04:31:39 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NAhhtm010749;
        Mon, 23 Jan 2023 12:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eIueq/6TkkWHbgnhnAc899kEhfOWaHxHPhxL213Z+Aw=;
 b=JbkM06kufFh5OW5bX6fE8Holr+je/WQ8OWv8LImlCwMDb66t7adw/xXi3tYJVEGIF48n
 TrIWc5oXCcHXFjofR+cGxXYDNNz1iP1yOFTvbVhosL0G03/bIm/6QYO14nXcYC0dCSb4
 Qey22w4t5jZv+kzZaTyfxxfGKDWq1HVLEFz/Q3MRTiWFBsZma/atQng14tF1JG4IEDce
 5SGuld+Fy1UWFEsld57q2/JLcx4/Ue/LQ4fX59aepitz7ThGZ+IFYyI6UJrC5N1pwFmm
 V7oEwb/0P7dlioZXxXzlfrDBrS1O0EzQMmMqsO2FrcRLMftEmFpubn/EAz0ggtKjrxSL 8w== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89gt2ujw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 12:31:27 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30NCVQhI028620
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 12:31:26 GMT
Received: from [10.50.9.135] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 04:31:25 -0800
Message-ID: <debfeadf-1a5a-6913-ba24-c6733930f63c@quicinc.com>
Date:   Mon, 23 Jan 2023 18:01:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] wifi: ath11k: Add tx ack signal support for mgmt packets
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Abinaya Kalaiselvan <quic_akalaise@quicinc.com>
References: <20221219053844.4084486-1-quic_mkenna@quicinc.com>
 <87fsc8xsgl.fsf@kernel.org>
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
In-Reply-To: <87fsc8xsgl.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LFUoryNR2VKr6M-0AG2rhMiCHpb-ckY4
X-Proofpoint-ORIG-GUID: LFUoryNR2VKr6M-0AG2rhMiCHpb-ckY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_09,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1011 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230118
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 1/18/2023 12:03 PM, Kalle Valo wrote:
> Maharaja Kennadyrajan <quic_mkenna@quicinc.com> writes:
>
>> From: Abinaya Kalaiselvan <quic_akalaise@quicinc.com>
>>
>> Add support to notify tx ack signal values for mgmt
>> packets to userspace through NL interface.
>>
>> Advertise NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT flag
>> to enable this feature and it will be used for data
>> packets as well.
>>
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Abinaya Kalaiselvan <quic_akalaise@quicinc.com>
>> Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
> [...]
>
>> --- a/drivers/net/wireless/ath/ath11k/wmi.h
>> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
>> @@ -2309,6 +2309,7 @@ struct wmi_init_cmd {
>>   } __packed;
>>   
>>   #define WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64 BIT(5)
>> +#define WMI_RSRC_CFG_FLAG1_ACK_RSSI BIT(18)
>>   
>>   struct wmi_resource_config {
>>   	u32 tlv_header;
>> @@ -4541,6 +4542,8 @@ struct wmi_mgmt_tx_compl_event {
>>   	u32 desc_id;
>>   	u32 status;
>>   	u32 pdev_id;
>> +	u32 ppdu_id;
>> +	u32 ack_rssi;
>>   } __packed;
> Adding these two fields increases the minimum length for
> WMI_TAG_MGMT_TX_COMPL_EVENT:
>
> 	[WMI_TAG_MGMT_TX_COMPL_EVENT]
> 		= { .min_len = sizeof(struct wmi_mgmt_tx_compl_event) },
>
> If we have a firmware version which doesn't include ppdu_id and ack_rssi
> in WMI_TAG_MGMT_TX_COMPL_EVENT ath11k will drop those events. Not sure
> what to do.
>
> Is it certain that all ath11k firmware versions have ppdu_id and
> ack_rssi? Or should handle so in ath11k that ppdu_id and ack_rssi can be
> optional in the event?

[Maha]: All ath11k firmware versions have ppdu_id and ack_rssi. So, 
there won't be issue

with minimum length for this event.

