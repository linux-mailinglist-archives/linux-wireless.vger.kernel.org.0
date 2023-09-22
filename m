Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81B77AADAA
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Sep 2023 11:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjIVJSQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Sep 2023 05:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVJSP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Sep 2023 05:18:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5215E99
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 02:18:09 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M79Znr032765;
        Fri, 22 Sep 2023 09:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LonnscLcKZUYt42xOOi1psonh9Iz49FVeWCDCAFBj8g=;
 b=W5u1HdwKAF5fdIVs5FVunxpAeSF1yTX9oUdW+5SZoLySXXlC3rKBfCBny/a13u3i/Tm9
 EG4sru7wFOprOeI2xxQKux3WjIg5CN0SHEIn5cbfC2rGlvaKt42GQLGg87ZPM+3j/BrX
 Zu+7hV9AlEhC6Os5upQ5Xc3bXM/Ik8q3yx416hqIwmnGcdNLYu/NuivP7/ANzYG8AYXO
 W5zTmVgggXyH3tb7ZedaQRfJuPS+oiOBZTuXWk0Wqz3gaCcYE739UOeXk7irTWZj+bJE
 zgK4O034Mi5Rz16uDvzU0SvI0RJp1UGm4EB2XzbtTnX6Cg72KZuyhOvbFpAKzxOkLSQi Pg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8u9h9chs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 09:17:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38M9Hu8U017218
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 09:17:56 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 22 Sep
 2023 02:17:54 -0700
Message-ID: <1a52925f-0b18-9c42-4005-47de075ce1d0@quicinc.com>
Date:   Fri, 22 Sep 2023 17:17:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v6 11/13] wifi: ath11k: discard BSS_CHANGED_TXPOWER when
 EXT_TPC_REG_SUPPORT for 6 GHz
Content-Language: en-US
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>,
        <quic_jjohnson@quicinc.com>
References: <20230920082349.29111-1-quic_wgong@quicinc.com>
 <20230920082349.29111-12-quic_wgong@quicinc.com>
 <4e4024eb-b518-4a36-b230-3c413c3a06e8@quicinc.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <4e4024eb-b518-4a36-b230-3c413c3a06e8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fQVxZAipyfNEyevbZJZ80AC_k5ryocOY
X-Proofpoint-ORIG-GUID: fQVxZAipyfNEyevbZJZ80AC_k5ryocOY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_07,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 mlxlogscore=878 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220076
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/22/2023 5:04 PM, Aditya Kumar Singh wrote:
> On 9/20/23 13:53, Wen Gong wrote:
>>
[...]
>> @@ -3595,9 +3607,13 @@ static void 
>> ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
>>       if (changed & BSS_CHANGED_TXPOWER) {
>>           ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "vdev_id %i txpower %d\n",
>>                  arvif->vdev_id, info->txpower);
>> -
>> -        arvif->txpower = info->txpower;
>> -        ath11k_mac_txpower_recalc(ar);
>> +        if (ath11k_mac_supports_station_tpc(ar, arvif, 
>> &info->chandef)) {
> So even if user wants to operate in low power value, we won't be 
> allowing to do that in case of 6 GHz station mode? Only TPC power is 
> valid?
>
You are right. I think I will drop this patch. Firmware will select the 
lowest TX power from multi-source.
>> +            ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
>> +                   "discard tx power, change to set TPC power\n");
>> +        } else {
>> +            arvif->txpower = info->txpower;
>> +            ath11k_mac_txpower_recalc(ar);
>> +        }
>>       }
>>         if (changed & BSS_CHANGED_PS &&
>
>
