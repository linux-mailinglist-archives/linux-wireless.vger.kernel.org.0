Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF12766210
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 04:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjG1CuW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 22:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjG1CuV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 22:50:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B4F2126
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 19:50:20 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S2YHEn008385;
        Fri, 28 Jul 2023 02:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=S/ezvRekaPKOSQwBMKmteFRdglAZupaMj9eDIie4AiM=;
 b=n6o0tmh8hOWAcPN8i3yu7w+/q474MFeS3n3Y15I4g+0OQG/htS7xJHEnuu62F3zyep/Q
 rA/Y2RY0jqIt7nSEpm7+FS5lpopyZcw818cYcQkjyonZZWclbq/uMHN+4YvgCnorqHgo
 6gM0nl74SHVxWDn9OX1EmiMZFiOg4HuDr8SQ6P81R2S6tYwWm4E55jxbcH/qBncU87zQ
 yiQ/uFIsojVjcrB3uad9FpsrjPyeEtkzL7HXCBt6HuTNZAAQyFni+3v4ZAFNTkUv+Tsf
 ee8IWj9TTnBuofXDGq48VNt1zMBitcDJrlagwvfYr+kAY3WG/hkHooUYoUug4rBTtKsE 9Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3f582vum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 02:50:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36S2oEAg024677
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 02:50:14 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 19:50:13 -0700
Message-ID: <7f15df67-c3df-0315-0ee7-07158860de63@quicinc.com>
Date:   Fri, 28 Jul 2023 10:50:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 06/11] wifi: ath12k: prepare EHT peer assoc parameters
Content-Language: en-US
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
References: <20230725224034.14045-1-quic_alokad@quicinc.com>
 <20230725224034.14045-7-quic_alokad@quicinc.com>
 <293dd873-1d9d-afc0-a122-48dfe4bb0fde@quicinc.com>
 <333fd74a-4178-3cef-5748-62a14ba2da5a@quicinc.com>
 <47396ec0-a0b3-8275-b29d-9ed72a9922cf@quicinc.com>
 <eac30246-1360-2854-3f53-28bdf5a24e24@quicinc.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <eac30246-1360-2854-3f53-28bdf5a24e24@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PjmArUkY_U154yPAvWuJnwkH1H0rDYYi
X-Proofpoint-ORIG-GUID: PjmArUkY_U154yPAvWuJnwkH1H0rDYYi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280025
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/28/2023 12:59 AM, Aloka Dixit wrote:
> On 7/26/2023 10:48 PM, Wen Gong wrote:
>> On 7/27/2023 12:38 AM, Aloka Dixit wrote:
>>> On 7/25/2023 8:43 PM, Wen Gong wrote:
>>>> On 7/26/2023 6:40 AM, Aloka Dixit wrote:
>>>> [...]
>>>>> +
>>>>> +static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
>>>>> +                    struct ieee80211_vif *vif,
>>>>> +                    struct ieee80211_sta *sta,
>>>>> +                    struct ath12k_wmi_peer_assoc_arg *arg)
>>>>> +{
>>>>> +
>>>> This is the IEs of my AP below, then it will still entered into 
>>>> this branch for my ath12k station mode.
>>>> sta->deflink.eht_cap and sta->deflink.he_cap is copied from peer 
>>>> remote, for ath12k station mode, peer
>>>> remote is the AP. The field only_20mhz is only valid when the IEs 
>>>> is from a station which only support
>>>> 20 MHz.
>>>>
>>>> I think the flag from_ap should be added here as well as function 
>>>> ieee80211_eht_mcs_nss_size().
>>>>
>>>> Please correct me if wrong.
>>>>
>>>
>>> Okay, can you fix this in a follow-up patch?
>>> I don't have a device to test the station mode to verify a fix.
>>> Thanks.
>> The fix patch is simple like this (I have verified OK), you can merge 
>> it to your patch.😁
>>
>> It is to not use only_20mhz when ath12k is station mode.
>>
>
> Thanks Wen.
>
> It would be simpler if the current version, which works for the 
> majority of cases for both AP and non-AP STA mode, gets reviewed first 
> considering 10/11 patches will remain same for the next version.
> Every time I re-base the series I have to test, add cover-letter, 
> change-log in 11 patches. Seems like an overkill for a non-crash 
> related fix which can be reviewed separately.
>
> Let's see what Kalle thinks.

The change is simple here, and I have verified on WCN7850 station mode 
successfully.

I think you do not need re-base and re-test😁

Anyway, let's see what Kalle thinks.

@ -2482,6 +2482,7 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
         const struct ieee80211_eht_mcs_nss_supp_bw *mcs_nss_supp_bw;
         u8 mcs_idx = WMI_EHTCAP_TXRX_MCS_NSS_IDX_80;
+       bool is_local_sta = arvif->vif->type == NL80211_IFTYPE_STATION;

         eht_cap = &sta->link[link_id]->eht_cap;

@@ -2522,7 +2523,7 @@ static void ath12k_peer_assoc_h_eht(struct ath12k 
*ar,
                 fallthrough;

         default:
-               if ((he_cap->he_cap_elem.phy_cap_info[0] &
+               if (!is_local_sta && 
(he_cap->he_cap_elem.phy_cap_info[0] &) {

