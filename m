Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A080476E6AA
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 13:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbjHCLT2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 07:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbjHCLT1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 07:19:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9B21BF
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 04:19:15 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3739KAM1015034;
        Thu, 3 Aug 2023 11:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8mz2ihCaUMzYESp5GUdiI/VzVrVVh1vnt+863SOsE+o=;
 b=p5RgS63EEwcdlCf+m4FDhsZzO5WBVFLiLW6Mqz5iiN/ust+sySq1JH3XnAqVuWq0QwjN
 crWbwZc34GtTzmAShEH/pPBvoRZYKg7l+ama7doXnK1eyn4qapnyxdcwuWQHqhX/8lU0
 7pAXtKdoKKqUvlXCs1aFkw2mT/qrIETZ3Rl5Hkhpn0kCFYiB7/xVizfmTPEoZ6uhInhd
 8ffJzaXABAwuRGTjHy9l7IpucUG2RAB5lD1TEo/EZe5X5hc8Tj/T53kVodhCzh+iJ6Xn
 wLomH0/elNX/BlJMNgKxc4U/pH9v2mbzk+ajtxME1g68BJ+mzuFlEURa41q6GeZJP1mm pg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7upp1qjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 11:19:07 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 373BJ6Mg021183
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 11:19:06 GMT
Received: from [10.201.204.39] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 3 Aug
 2023 04:19:05 -0700
Message-ID: <97ad035b-61b5-fbcf-ba81-aadbe7a0b7c4@quicinc.com>
Date:   Thu, 3 Aug 2023 16:49:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: fix WARN_ON during
 ath12k_mac_update_vif_chan
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230802085852.19821-1-quic_mdharane@quicinc.com>
 <20230802085852.19821-2-quic_mdharane@quicinc.com>
 <54733de9-db66-f1c4-9ad5-4d1f31529c05@quicinc.com>
From:   Manish Dharanenthiran <quic_mdharane@quicinc.com>
In-Reply-To: <54733de9-db66-f1c4-9ad5-4d1f31529c05@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WZElMT0PaPHcMc7Basak0UMAVKyfLhxF
X-Proofpoint-ORIG-GUID: WZElMT0PaPHcMc7Basak0UMAVKyfLhxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_09,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=932 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 8/2/2023 8:29 PM, Jeff Johnson wrote:
> On 8/2/2023 1:58 AM, Manish Dharanenthiran wrote:
>> Fix WARN_ON() from ath12k_mac_update_vif_chan() if vdev is not up.
>> Since change_chanctx can be called even before vdev_up.
>>
>> Do vdev stop followed by a vdev start in case of vdev is down.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1
> 
> Has this been tested on WCN7850? My understanding is that firmware may 
> expect vdev down and then vdev restart
Hi Jeff,

No, not tested with WCN7850 chip-set. But, we will be sending vdev_down 
before starting the restart sequence. Let me get help from MCC team to 
test this patch and update the changes, if needed.
> 
>>
>> Signed-off-by: Manish Dharanenthiran <quic_mdharane@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c | 27 +++++++++++++++++++++------
>>   1 file changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c 
>> b/drivers/net/wireless/ath/ath12k/mac.c
>> index 1bb9802ef569..0ab95e138d1d 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -5698,13 +5698,28 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
>>           if (WARN_ON(!arvif->is_started))
>>               continue;
>> -        if (WARN_ON(!arvif->is_up))
>> -            continue;
>> +        /* Firmware expect vdev_restart only if vdev is up.
>> +         * If vdev is down then it expect vdev_stop->vdev_start.
>> +         */
>> +        if (arvif->is_up) {
>> +            ret = ath12k_mac_vdev_restart(arvif, &vifs[i].new_ctx->def);
>> +            if (ret) {
>> +                ath12k_warn(ab, "failed to restart vdev %d: %d\n",
>> +                        arvif->vdev_id, ret);
>> +                continue;
>> +            }
>> +        } else {
>> +            ret = ath12k_mac_vdev_stop(arvif);
>> +            if (ret) {
>> +                ath12k_warn(ab, "failed to stop vdev %d: %d\n",
>> +                        arvif->vdev_id, ret);
>> +                continue;
>> +            }
>> -        ret = ath12k_mac_vdev_restart(arvif, &vifs[i].new_ctx->def);
>> -        if (ret) {
>> -            ath12k_warn(ab, "failed to restart vdev %d: %d\n",
>> -                    arvif->vdev_id, ret);
>> +            ret = ath12k_mac_vdev_start(arvif, &vifs[i].new_ctx->def);
>> +            if (ret)
>> +                ath12k_warn(ab, "failed to start vdev %d: %d\n",
>> +                        arvif->vdev_id, ret);
>>               continue;
>>           }
> 
