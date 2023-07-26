Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D62763C9E
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 18:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjGZQiP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 12:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGZQiP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 12:38:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AE12118
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 09:38:14 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QD0Pj8013350;
        Wed, 26 Jul 2023 16:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xGKt1zTVOiCFCvRZdLmWEclcAJdPKv3tOfW7w4PDkdM=;
 b=mosO7Nzyib9GC1fKrqMMdR6pQPShSEk6Uw+Gs6+WVNQfjFpiIqMR9uqH0GUVQWnD5TAw
 rhO57Oyezi1NlBcGGPqKri0BxgBXkoUxL4jt6ovnVT2vl0aQYVpaWqbjPwT+cew+yWQG
 5hl3jM9XM05bIar9rLUz1QbfD0JDIQs7Yz/2NHIv/qWR/rw5Tk8wi2ygaLNI069K6DsB
 1UKpWTkssgWW0odx+khzvBGbkf5WyUEmHLQnRk8zm9u8EH1d0GAk+dP0FBhyn4AJKP93
 6D+NWXldkeLP5BMKpRud6yjsZE9+aFko6spSGQA2ilvEfb3JZy29QI4hKClDgLXIHQmc 8A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2drabe7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 16:38:09 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36QGc8mK011237
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 16:38:08 GMT
Received: from [10.110.108.92] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 26 Jul
 2023 09:38:08 -0700
Message-ID: <333fd74a-4178-3cef-5748-62a14ba2da5a@quicinc.com>
Date:   Wed, 26 Jul 2023 09:38:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 06/11] wifi: ath12k: prepare EHT peer assoc parameters
To:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
CC:     Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
References: <20230725224034.14045-1-quic_alokad@quicinc.com>
 <20230725224034.14045-7-quic_alokad@quicinc.com>
 <293dd873-1d9d-afc0-a122-48dfe4bb0fde@quicinc.com>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <293dd873-1d9d-afc0-a122-48dfe4bb0fde@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VnJ9tw1XStxTmSGMmkX_GpmQl8ZcBOVm
X-Proofpoint-ORIG-GUID: VnJ9tw1XStxTmSGMmkX_GpmQl8ZcBOVm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307260148
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/25/2023 8:43 PM, Wen Gong wrote:
> On 7/26/2023 6:40 AM, Aloka Dixit wrote:
> [...]
>> +
>> +static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
>> +                    struct ieee80211_vif *vif,
>> +                    struct ieee80211_sta *sta,
>> +                    struct ath12k_wmi_peer_assoc_arg *arg)
>> +{
>> +    const struct ieee80211_sta_eht_cap *eht_cap = &sta->deflink.eht_cap;
>> +    const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
> [...]
>> +    default:
>> +        if ((he_cap->he_cap_elem.phy_cap_info[0] &
>> +             (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
>> +              
>> IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
>> +              IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
>> +              
>> IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)) == 0) {
>> +            const struct ieee80211_eht_mcs_nss_supp_20mhz_only *bw_20 =
>> +                    &eht_cap->eht_mcs_nss_supp.only_20mhz;
>> +
> This is the IEs of my AP below, then it will still entered into this 
> branch for my ath12k station mode.
> sta->deflink.eht_cap and sta->deflink.he_cap is copied from peer remote, 
> for ath12k station mode, peer
> remote is the AP. The field only_20mhz is only valid when the IEs is 
> from a station which only support
> 20 MHz.
> 
> I think the flag from_ap should be added here as well as function 
> ieee80211_eht_mcs_nss_size().
> 
> Please correct me if wrong.
> 

Okay, can you fix this in a follow-up patch?
I don't have a device to test the station mode to verify a fix.
Thanks.
