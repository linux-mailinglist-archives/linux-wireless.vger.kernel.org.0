Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DD45E7E66
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Sep 2022 17:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiIWP3t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Sep 2022 11:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiIWP3p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Sep 2022 11:29:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6FA23BC9
        for <linux-wireless@vger.kernel.org>; Fri, 23 Sep 2022 08:29:42 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NDv06n010009;
        Fri, 23 Sep 2022 15:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QRYSoXvcppTAlsEtQ+icFMv2LLPQFLzpbaoyE9skujU=;
 b=JpTXzaf5JhgVB87RZ8fe8SDKablcwgWu9Gtcmux7UVbcwc7TUQXvmANP4rEqmWaSFCQI
 +Jy7TsfFaOV0A83vZUUSOX5KebDXUYoj59KlM4euO+r5mKOZUbev7MYGHtY+NotWodj4
 0FcDOva3VxmTDgKoBOmSJHGxwTpFvF1aL+ysJFa/G3sXxg3mMgY9EMZ0G0ElHoBeGUVu
 dWBteqdGS2irqW5QHq2GjK61+zdCCp+HlsJaFDMvlY6WZb2BXQ9BYDbOT2ecBlZsNtkF
 Mcnh0yJKhHxeRT1NEDu0n/pJx64EDw8ej8DuazAoTPRflYkXge33KHYXK7m8GLP0L9vu zA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3js9vusae9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 15:29:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28NFTZCQ031627
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 15:29:35 GMT
Received: from [10.110.41.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 23 Sep
 2022 08:29:35 -0700
Message-ID: <ff7e72ae-0431-b568-32fc-7b1cbf250e20@quicinc.com>
Date:   Fri, 23 Sep 2022 08:29:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 4/5] brcmfmac: Update SSID of hidden AP while informing
 its bss to cfg80211 layer
Content-Language: en-US
To:     "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin@infineon.com>,
        Kalle Valo <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>
References: <20220914033620.12742-1-ian.lin@infineon.com>
 <20220914033620.12742-5-ian.lin@infineon.com> <87tu506mre.fsf@kernel.org>
 <d390462d-1cd2-fc3f-5b0c-bdcd332ed0bc@infineon.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <d390462d-1cd2-fc3f-5b0c-bdcd332ed0bc@infineon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VnIyLQwNVCuhsKaCxrVNeIyQWWYZDMgl
X-Proofpoint-GUID: VnIyLQwNVCuhsKaCxrVNeIyQWWYZDMgl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=812
 impostorscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230100
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/22/2022 6:52 PM, Lin Ian (CSSITB CSS ICW SW WFS / EE) wrote:
> 
> 
> On 9/22/2022 12:44 PM, Kalle Valo wrote:
>> Ian Lin <ian.lin@infineon.com> writes:
>>
>>> From: Syed Rafiuddeen <syed.rafiuddeen@cypress.com>
>>>
>>> cfg80211 layer on DUT STA is disconnecting ongoing connection attempt 
>>> after
>>> receiving association response, because cfg80211 layer does not have 
>>> valid
>>> AP bss information. On association response event, brcmfmac communicates
>>> the AP bss information to cfg80211 layer, but SSID seem to be empty 
>>> in AP
>>> bss information, and cfg80211 layer prints kernel warning and then
>>> disconnects the ongoing connection attempt.
>>>
>>> SSID is empty in SSID IE, but 'bi->SSID' contains a valid SSID, so
>>> updating the SSID for hidden AP while informing its bss information
>>> to cfg80211 layer.
>>>
>>> Signed-off-by: Syed Rafiuddeen <syed.rafiuddeen@infineon.com>
>> Syed's email address in From does not match with s-o-b.
>>
>>> @@ -3032,6 +3033,12 @@ static s32 brcmf_inform_single_bss(struct 
>>> brcmf_cfg80211_info *cfg,
>>>        notify_ielen = le32_to_cpu(bi->ie_length);
>>>        bss_data.signal = (s16)le16_to_cpu(bi->RSSI) * 100;
>>>
>>> +     ssid = brcmf_parse_tlvs(notify_ie, notify_ielen, WLAN_EID_SSID);
>>> +     if (ssid && ssid->data[0] == '\0' && ssid->len == bi->SSID_len) {
>>> +             /* Update SSID for hidden AP */
>>> +             memcpy((u8 *)ssid->data, bi->SSID, bi->SSID_len);
>>> +     }
>> memcpy() takes a void pointer so the cast is not needed.
> There should be a type casting since 'ssid' is a const pointer.
> As you saw there will be build warning in PATCH v2 (sorry I didn't 
> notice that locally)
> I will send PATCH v3 to restore type casting, is that ok?
> 

writing through a const pointer seems broken.
Should you instead remove the const qualifier from the declaration?
const struct brcmf_tlv *ssid = NULL;

if the problem is that brcmf_parse_tlvs() itself returns a const 
pointer, then I'd typecast during the assignment instead of the memcpy() 
call.

also note the NULL initializer is unnecessary since it is always 
overwritten by the call to brcmf_parse_tlvs()


