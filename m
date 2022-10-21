Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A23607766
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 14:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJUM6L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 08:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJUM6K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 08:58:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29CA26CDC3
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 05:58:07 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LAv13s024820;
        Fri, 21 Oct 2022 12:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iLFvZSezdnztViUvjIAOG0oo2yImz9pK9/lXvoihPHw=;
 b=kqWZ8HPgrxH2Xgq2+VTTaGXsJOUcKE8CSFtLPlcUtcMYXmbw/eNM1LFtrj5HzVckBhAK
 1FmzZRjUazEaMeKowqy2KGt5jLN6TGRfgb35HfJkDxUr2gHZACXyCChx9eV/7grGtDtx
 4wvZyaRsyDdxXBrZX699SK/eFFCUnqicMOhlKhB9XykX7NU7vnaG/y20oNPe/Kbm8X/V
 u6F8CtygrbO+142zQkqJBmBqDWlr5UQRn2QuHRf4A9/zsLf2vjnUiQU2+DtrMsXK9C42
 NPY17TmrDCfR2mKb6w/veyZJC5PzMwTR34GvSu8HSnV5wGpcWQh2+m9U8EoK3E7Qfbva Vw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kbrq98rmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 12:58:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29LCw4W3019997
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 12:58:04 GMT
Received: from [10.216.6.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 21 Oct
 2022 05:58:02 -0700
Message-ID: <e2a8f2d4-01aa-4a3e-d887-6ee6da83ad8e@quicinc.com>
Date:   Fri, 21 Oct 2022 18:27:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC 2/4] wifi: nl80211: send underlying multi-hardware channel
 capabilities to user space
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
 <20220920100518.19705-3-quic_vthiagar@quicinc.com>
 <9d09ce8fa217cdba7a79f4b35e4a4663e3a66e16.camel@sipsolutions.net>
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <9d09ce8fa217cdba7a79f4b35e4a4663e3a66e16.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e96y_9MxB46bkhG0EbAD5OSJioACSo_D
X-Proofpoint-ORIG-GUID: e96y_9MxB46bkhG0EbAD5OSJioACSo_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 10/21/2022 5:43 PM, Johannes Berg wrote:
> On Tue, 2022-09-20 at 15:35 +0530, Vasanthakumar Thiagarajan wrote:
>>
>> +++ b/include/uapi/linux/nl80211.h
>> @@ -2749,6 +2749,12 @@ enum nl80211_commands {
>>    *	When used with %NL80211_CMD_FRAME_TX_STATUS, indicates the ack RX
>>    *	timestamp. When used with %NL80211_CMD_FRAME RX notification, indicates
>>    *	the incoming frame RX timestamp.
>> + *
>> + * @NL80211_ATTR_MULTI_HW_MACS: nested attribute to send the hardware mac
> 
> Not sure I'd call this multiple MACs? It's multiple devices in some
> sense, but from a spec POV at least, I'd think our NIC also has multiple
> MACs when it doesn't use this infrastructure. Might get a bit confusing?
> 
> Maybe just stick to "multi_hw" or so?

Yeah, I was not very comfortable calling it multiple MACs either. Sure, 
let me just stick to multi_hw.

> 
>> +/**
>> + * nl80211_multi_hw_mac_attrs - multi-hw mac attributes
>> + *
>> + * @NL80211_MULTI_HW_MAC_ATTR_INVALID: invalid
>> + * @NL80211_MULTI_HW_MAC_ATTR_IDX: (u8) array index in wiphy @hw_chans to refer an
>> + *	underlying hw mac for which the supported channel list is advertised.
> 
> I'd prefer this to be primarily written from a userspace POV, so the
> whole "@hw_chans" etc isn't really right. Maybe say something like
> 
> "(u8) multi-HW index used to refer to an underlying HW ...; internally
> the index of the wiphy's @hw_chans array."
> 
> or so?

Sure, thanks.

> 
>> + * @NL80211_MULTI_HW_MAC_ATTR_FREQS: array of supported center frequencies
> 
> FWIW, Jakub has started advertising for using the same attribute
> multiple times to have arrays, so you'd just have
> 
>   {NL80211_MULTI_HW_ATTR_FREQ: 2412},
>   {NL80211_MULTI_HW_ATTR_FREQ: 2417},
>   {NL80211_MULTI_HW_ATTR_FREQ: 2422},
> 
> etc. in the message. Not sure we want to try that here, but it'd also
> simplify splitting messages for dumps.
>

we have to do that for every channel? let me check.

> 
>> +static int nl80211_put_multi_hw_support(struct wiphy *wiphy,
>> +					struct sk_buff *msg)
>> +{
>> +	struct nlattr *hw_macs, *hw_mac;
>> +	struct nlattr *freqs;
>> +	int i, c;
>> +
>> +	if (!wiphy->num_hw)
>> +		return 0;
>> +
>> +	hw_macs = nla_nest_start(msg, NL80211_ATTR_MULTI_HW_MACS);
>> +	if (!hw_macs)
>> +		return -ENOBUFS;
>> +
>> +	for (i = 0; i < wiphy->num_hw; i++) {
>> +		hw_mac = nla_nest_start(msg, i + 1);
>> +		if (!hw_mac)
>> +			return -ENOBUFS;
>> +
>> +		if (nla_put_u8(msg, NL80211_MULTI_HW_MAC_ATTR_IDX, i))
>> +			return -ENOBUFS;
>> +
>> +		freqs = nla_nest_start(msg,
>> +				       NL80211_MULTI_HW_MAC_ATTR_FREQS);
>> +		if (!freqs)
>> +			return -ENOBUFS;
>> +
>> +		for (c = 0; c < wiphy->hw_chans[i]->n_chans; c++)
>> +			if (nla_put_u32(msg, c + 1,
>> +					wiphy->hw_chans[i]->chans[c].center_freq))
>> +				return -ENOBUFS;
> 
> Ah you used a nested array even.
> 
> So the argument for using a real array would've been that it's smaller,
> but I guess with nested that argument goes way.
> 
> Would you mind trying Jakub's preferred approach here and see how that
> works out?
> 
> For the generator basically you'd just have
> 
> hw_mac = nla_nest_start();
> nla_put_u8(IDX, i)
> for (c = 0; c < ...; c++)
> 	nla_put_u32(MULTI_HW_ATTR_FREQ, ...->chans[c].center_freq);
> 

I'll try this, thanks!

Vasanth
