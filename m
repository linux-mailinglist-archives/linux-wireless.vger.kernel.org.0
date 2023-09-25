Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96E17AD688
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 12:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjIYK6i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 06:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjIYK6f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 06:58:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F49E6B
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 03:58:09 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PAUVhn031234;
        Mon, 25 Sep 2023 10:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UivVDXNChTXUIsXPWXljXgTqRLdkGeTmOqnJP9TR378=;
 b=eYzent5SRuOyO3qng3ST68aOUy0rQBzhfobCJ8o+jgneDLXigRwX2me3sg4mNt1I9fUf
 fKbeDKSGO3I+jZDN9Bb8cKFYUxQmHLE4bRDmF2EixX59+lXlrVar+e2ABwGoSdighdAu
 QoKQoNgAOjjDQBoAT15Jgv2esQ6OeBbYg2LTwE+AztBafFgr2is6aln+UX+pyh/iA4OJ
 1MPKHKwf1ofqH0cBF5nRnfzl0+tCqeAkqZL4I9aMkwdWO2g1qDBAQsHgUn0xybEA/8Ri
 bmBGRdmecEPw3WfWAppNkGIQhcJB9zOAGWqd54MvVfL69o1onG2DBz3xe/vaUF9vvyBh CA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9rddbj67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:58:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38PAvxGw004856
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:57:59 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 03:57:57 -0700
Message-ID: <fc02a441-bad9-6fba-bde8-dabd01d5ee18@quicinc.com>
Date:   Mon, 25 Sep 2023 18:57:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 05/13] wifi: ath11k: update regulatory rules when
 connect to AP on 6 GHz band for station
Content-Language: en-US
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>,
        <quic_jjohnson@quicinc.com>
References: <20230920082349.29111-1-quic_wgong@quicinc.com>
 <20230920082349.29111-6-quic_wgong@quicinc.com>
 <5e9439c5-fc02-4a18-8cc8-c76998bfcbc6@quicinc.com>
 <1f739d62-d5c0-a64b-ef9b-d5fd7b79755e@quicinc.com>
 <47e2ce79-2885-489c-b567-fdbcb120d056@quicinc.com>
 <2aae986b-1d16-3b75-d2c9-a740f6817650@quicinc.com>
 <5f95f931-e75f-459b-a7c7-b175ba12f981@quicinc.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <5f95f931-e75f-459b-a7c7-b175ba12f981@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MqLJatQSC28JHKi562Q0MLkM8IWeRTEH
X-Proofpoint-ORIG-GUID: MqLJatQSC28JHKi562Q0MLkM8IWeRTEH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_08,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250081
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/25/2023 6:52 PM, Aditya Kumar Singh wrote:
> On 9/25/23 16:13, Wen Gong wrote:
>> On 9/22/2023 9:18 PM, Aditya Kumar Singh wrote:
>>> On 9/22/23 15:32, Wen Gong wrote:
>>>> On 9/22/2023 5:39 PM, Aditya Kumar Singh wrote:
>>>>> On 9/20/23 13:53, Wen Gong wrote:
>>>>>
>>>>>> +    if (ath11k_mac_supports_6ghz_cc_ext(ar) &&
>>>>>> +        ctx->def.chan->band == NL80211_BAND_6GHZ &&
>>>>>> +        arvif->vdev_type == WMI_VDEV_TYPE_STA) {
>>>>>> +        reg_info = &ab->reg_info_store[ar->pdev_idx];
>>>>>> +        power_type = vif->bss_conf.power_type;
>>>>>> +        ath11k_dbg(ab, ATH11K_DBG_MAC, "mac chanctx power type 
>>>>>> %d\n",
>>>>>> +               power_type);
>>>>>> +        if (power_type == IEEE80211_REG_UNSET_AP)
>>>>>> +            power_type = IEEE80211_REG_LPI_AP;
>>>>> Why having _UNSET_ power type in vif->bss_conf.power_type is fine? 
>>>>> Typically, during association, we would be setting this from the 
>>>>> beacon/association response frame's HE 6 GHz Operation Info Field. 
>>>>> So is it fine if the field is carrying some info which we don't 
>>>>> know (or may be don't support it yet)? Why are we masking it with 
>>>>> _LPI_ mode?
>>>>>
>>>>> Also, I see that currently mac80211 only sets LPI or SP. So let's 
>>>>> say STA is trying to connect to VLP AP, mac80211 will set it as 
>>>>> _UNSET_. And then here, we will be treating it as LPI AP. Is that 
>>>>> fine?
>>>>
>>>> Currently only SP/LPI are defined in "Table E-12—Regulatory Info 
>>>> subfield encoding in the United States" of IEEE Std 802.11ax™‐2021.
>>>>
>>>> So maybe I need to set power_type to VLP when it is UNSET here.
>>> Yeah, or may be deny association if we don't support that mode? I 
>>> would let others comment on this.
>> Do you know how to check which mode support by ath11k?
> IMHO we should not maintain two different supported modes, one in 
> driver and another in mac80211. I mean w.r.t mac80211 we should try to 
> match it as far as possible. In this case, we can return error from 
> mac80211 itself when a non-supported mode (as in VLP) is trying to 
> associate? Since as you have quoted, VLP is not yet defined in spec 
> IEEE Std 802.11ax‐2021 so why to mask the mode and continue in 
> mac80211 itself?
>
> If we do like this, then mac80211 will not simply set _UNSET_ for 6 
> GHz client interface and in driver if we see its still _UNSET_ then we 
> can be sure that something has gone wrong and we can take steps 
> accordingly.
Yes, I will change to return fail for _UNSET_.
