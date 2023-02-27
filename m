Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433066A3FAF
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 11:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjB0KtY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 05:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjB0KtX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 05:49:23 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB04C657
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 02:49:21 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31R7rIGA024285;
        Mon, 27 Feb 2023 10:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JDFuaKQWUZNcCm302JgXwZ3jPZ2XVcfcpGsT1XU/cL0=;
 b=Uqhba/WIQNjpVpFh8uPTS/fBoXLO57/FKiVlQidW5XhxSWaDKN//M7mjU2mz2+lq85Dd
 QefoCkE85nWUtXtCeYxsbluGL9Dc+I1C4T/nDgHG1sy6fY0HThczNIUBNNn2kCE3Lyb7
 ru27JFT5VZVg7O+vt0A4S9sNI2suyC8hnV8do0Kf6msquLZkJd9i1HnmUO4PMqCJ6Ove
 wqzizVEZdRY64MdhK75v+mD4qhwNzWpgAlP9C7E4aNsFiavcGux4DDQ02uD0ebOn0t4F
 ejURvio5xvcWpu5Wg24f9QG2rABMHhXSjEp/Ur8pwfOAr3l1nCVXCY0gIuU91yaJF0J2 yg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ny9nuvn72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 10:49:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31RAnDe3015262
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 10:49:13 GMT
Received: from [10.206.66.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Feb
 2023 02:49:12 -0800
Message-ID: <9efc2082-d46d-5d57-d275-1cb47277f639@quicinc.com>
Date:   Mon, 27 Feb 2023 16:19:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 3/3] ath11k: Enable low power mode when WLAN is not
 active
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230203060128.19625-1-quic_mpubbise@quicinc.com>
 <20230203060128.19625-4-quic_mpubbise@quicinc.com>
 <87cz5zruc6.fsf@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <87cz5zruc6.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wE4GSn03VrcfQcRmnMxyHJBJpZNBX9jc
X-Proofpoint-GUID: wE4GSn03VrcfQcRmnMxyHJBJpZNBX9jc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-26_22,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=896 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270082
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2/24/2023 8:20 PM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>> Currently, WLAN chip is powered once during driver probe and is kept
>> ON (powered) always even when WLAN is not active; keeping the chip
>> powered ON all the time will consume extra power which is not
>> desirable for a battery operated device. Same is the case with non-WoW
>> suspend, chip will never be put into low power mode when the system is
>> suspended resulting in higher battery drain.
>>
>> As per the recommendation, sending a PDEV suspend WMI command followed
>> by a QMI MODE OFF command will cease all WLAN activity and put the device
>> in low power mode. When WLAN interfaces are brought up, sending a QMI
>> MISSION MODE command would be sufficient to bring the chip out of low
>> power. This is a better approach than doing hif_power_down()/hif_power_up()
>> for every WiFi ON/OFF sequence since the turnaround time for entry/exit of
>> low power mode is much less. Overhead is just the time taken for sending
>> QMI MODE OFF & QMI MISSION MODE commands instead of going through the
>> entire chip boot & QMI init sequence.
>>
>> Currently the changes are applicable only for WCN6750. This can be
>> extended to other targets with a future patch.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
>>
>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> 
> [...]
> 
>> +static int ath11k_ahb_core_start_ipq8074(struct ath11k_base *ab)
>> +{
>> +	/* TODO: Currently initializing the hardware/firmware only
>> +	 * during hardware recovery. Support to shutdown/turn-on
>> +	 * the hardware during Wi-Fi OFF/ON will be added later.
>> +	 */
>> +	if (!test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags))
>> +		return 0;
>> +
>> +	return ath11k_core_start_device(ab);
>> +}
>> +
>> +static void ath11k_ahb_core_stop_ipq8074(struct ath11k_base *ab)
>> +{
>> +	/* TODO: Currently stopping the hardware/firmware only
>> +	 * during driver unload. Support to shutdown/turn-on
>> +	 * the hardware during Wi-Fi OFF/ON will be added later.
>> +	 */
>> +	if (!test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags))
>> +		return;
>> +
>> +	return ath11k_core_stop_device(ab);
>> +}
> 
> Please clarify what Wi-Fi OFF/ON exactly means on these two comments,
> it's not clear for me.
>

  By Wi-Fi OFF/ON I mean is the bringing the last wlan interface down/up
which is nothing but the non-WoW suspend/resume.


> Also I want to mention that I suspect eventually we have to always power
> off the firmware during suspend to get hibernation working:
> 

This patch will power off the firmware for WCN6750. I'm not sure how to 
get that working for other ath11k devices.

Thanks,
Manikanta
