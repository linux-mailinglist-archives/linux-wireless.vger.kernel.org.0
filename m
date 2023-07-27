Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577CF76595D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 18:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjG0Q7b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 12:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjG0Q73 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 12:59:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4002D70
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 09:59:25 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RGfCdE015523;
        Thu, 27 Jul 2023 16:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tv8JT390mOUp9ndiysJOb7NObGF6Wy7aHLN1xLb+lWQ=;
 b=dXj1/We2BcrRDszRsTewYDXqx3gn1Ug77/7N022A7Au0enHnCwack2inFPdBNOlGq8Z6
 NfnzRM3YsYQ3H2o9hdeYMzhldOqN8sgdLMdTMTGB9/pvKP1gWdQfrH5yaN4KAq37h9c3
 DHcJIWgaV0+bW9F1XMVWVizYKzgQ+pJ0PFkEVUCT29YjD36GropSdtrwLfTr3jB7lLbe
 7Ma9j4KUq8cBb2aR4WXYB7QfxxBs9h/QXASOg3PasgWMVhrN80uhcvTWN8wtMzR54mS3
 6L5+qp1HRFXXW4mcrTGv4w8XOvKmMZzeIk5KAq/FkJYXcIeh4g+r3V1cE1Kbdk8lZfFL JQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s37g0jptk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 16:59:17 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36RGxFZO004130
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 16:59:15 GMT
Received: from [10.227.89.240] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 09:59:15 -0700
Message-ID: <eac30246-1360-2854-3f53-28bdf5a24e24@quicinc.com>
Date:   Thu, 27 Jul 2023 09:59:14 -0700
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
 <333fd74a-4178-3cef-5748-62a14ba2da5a@quicinc.com>
 <47396ec0-a0b3-8275-b29d-9ed72a9922cf@quicinc.com>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <47396ec0-a0b3-8275-b29d-9ed72a9922cf@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QXSVlbefc47C3tVB2q5dYPqMNUo6nvCH
X-Proofpoint-ORIG-GUID: QXSVlbefc47C3tVB2q5dYPqMNUo6nvCH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270153
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/26/2023 10:48 PM, Wen Gong wrote:
> On 7/27/2023 12:38 AM, Aloka Dixit wrote:
>> On 7/25/2023 8:43 PM, Wen Gong wrote:
>>> On 7/26/2023 6:40 AM, Aloka Dixit wrote:
>>> [...]
>>>> +
>>>> +static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
>>>> +                    struct ieee80211_vif *vif,
>>>> +                    struct ieee80211_sta *sta,
>>>> +                    struct ath12k_wmi_peer_assoc_arg *arg)
>>>> +{
>>>> +
>>> This is the IEs of my AP below, then it will still entered into this 
>>> branch for my ath12k station mode.
>>> sta->deflink.eht_cap and sta->deflink.he_cap is copied from peer 
>>> remote, for ath12k station mode, peer
>>> remote is the AP. The field only_20mhz is only valid when the IEs is 
>>> from a station which only support
>>> 20 MHz.
>>>
>>> I think the flag from_ap should be added here as well as function 
>>> ieee80211_eht_mcs_nss_size().
>>>
>>> Please correct me if wrong.
>>>
>>
>> Okay, can you fix this in a follow-up patch?
>> I don't have a device to test the station mode to verify a fix.
>> Thanks.
> The fix patch is simple like this (I have verified OK), you can merge it 
> to your patch.😁
> 
> It is to not use only_20mhz when ath12k is station mode.
> 

Thanks Wen.

It would be simpler if the current version, which works for the majority 
of cases for both AP and non-AP STA mode, gets reviewed first 
considering 10/11 patches will remain same for the next version.
Every time I re-base the series I have to test, add cover-letter, 
change-log in 11 patches. Seems like an overkill for a non-crash related 
fix which can be reviewed separately.

Let's see what Kalle thinks.

