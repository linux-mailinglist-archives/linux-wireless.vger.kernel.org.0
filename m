Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED5775FEDA
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 20:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjGXSMJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 14:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjGXSMI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 14:12:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C55AE73
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 11:12:04 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OBC9I1013704;
        Mon, 24 Jul 2023 18:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EKnswQdHDy/KVeHfCsewsEQNTYldae0s7gQsCXqe6Gk=;
 b=kPfox8bQQm621FOiJwElpFR+KfkjihtjnF+7mtlWFIkwLDfDF5hF0YVe+foJWYtDTr+b
 u67L2kHiic++lTVO4U5W8+5qIetx6YC7ma1vULEGDuVRW6/fdpGKBXOZA74ahl16I71n
 fWdzshlMMUk4h3vTosM6tYVPaz75YgacqXqN+uVr1YNPdnbFCOcHuEFH9jDGyFzL4//P
 KT7jFKXZQvxWkaaAzUUiuXZEs5ES7sMeihNOKarnmI30Ffho9DML04wQTDwzlb1uaPjN
 vZ99wrgCqvYzUjkeDYZgLkbgJaJ5KYXmrSynagdPjjuFMAQmZ1Zmllke4WDVRVtwVekG Rw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1pfh9623-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 18:11:55 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OIBsJF015821
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 18:11:54 GMT
Received: from [10.227.89.240] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 11:11:53 -0700
Message-ID: <67961f9b-1062-88e3-d634-35f015dfbead@quicinc.com>
Date:   Mon, 24 Jul 2023 11:11:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 04/11] wifi: ath12k: propagate EHT capabilities to
 userspace
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Pradeep Kumar Chitrapu" <quic_pradeepc@quicinc.com>
References: <20230602235820.23912-1-quic_alokad@quicinc.com>
 <20230602235820.23912-5-quic_alokad@quicinc.com> <87pm5xaqp8.fsf@kernel.org>
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <87pm5xaqp8.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a0AihpJ3akgZB0ID4edEOwkpWkD5cFNN
X-Proofpoint-GUID: a0AihpJ3akgZB0ID4edEOwkpWkD5cFNN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=974 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240161
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/15/2023 4:51 AM, Kalle Valo wrote:
> Aloka Dixit <quic_alokad@quicinc.com> writes:
> 
>> Propagate EHT capabilities to the userspace using a new member
>> 'eht_cap' in structure ieee80211_sband_iftype_data.
>>
>> MCS-NSS capabilities are copied depending on the supported bandwidths
>> for the given band.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
>> Signed-off-by: Pradeep Kumar Chitrapu<quic_pradeepc@quicinc.com>
> 
> [...]
> 
>> +static void ath12k_mac_copy_eht_ppet_ru(u32 ppet, u8 ppe_thres[], int ru)
>> +{
>> +	int i;
>> +	u32 val = 0;
>> +	u8 ppet_size_ru = IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE * 2;
>> +	u8 bit = IEEE80211_EHT_PPE_THRES_INFO_HEADER_SIZE;
>> +
>> +	u32p_replace_bits(&val, ppet >> (ru * ppet_size_ru),
>> +			  GENMASK(ppet_size_ru - 1, 0));
>> +
>> +	val = ((val >> IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE) & GENMASK(2, 0)) |
>> +	      ((val & GENMASK(2, 0)) << IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE);
> 
> This shifting of val looks weird. I didn't check the spec, what does it
> do? Is there any cleaner way to do this? And should have a define for
> GENMASK(2, 0)?
> 

I have a follow-up ready, based on top of the fixes you already made in 
the master pending branch, which cleans this up.

Also noticed that need to use hweight16 instead of hweight8 for 
IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK. The new version fixes it 
in this patch as well as in patch #6.

Should I send the next version?
