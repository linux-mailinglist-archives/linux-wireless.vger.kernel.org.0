Return-Path: <linux-wireless+bounces-4413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9186872E15
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 05:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6CE1C21E07
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 04:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB97C79E4;
	Wed,  6 Mar 2024 04:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QljbtKB+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D0179B5
	for <linux-wireless@vger.kernel.org>; Wed,  6 Mar 2024 04:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709700284; cv=none; b=IO3v2KXBHxdAJ7FDnmBbNivig0vGQfzQHC6omnNj01Fte1cbeq5C8ul60Sm9MNKJQf6apTK1Uhy52IQcD1NtUfd8eUnQoC+MwtUdThx3QwwpwosB/RnGywgP86ykU3sOzQk0lOwjr1CUDh9cMJRqzlFq9L90KcEVGxZ7loeizQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709700284; c=relaxed/simple;
	bh=HgOrVK3draNDYq63qFD3REzO8c1p+cxbycwBXCYlU0E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=NdyRalx+cZwHKSLnSlDl3RiyZCGuRtzEJGVfEXyg0oqan3lmz+TGBMRwQ1w0E6AsuUdUnXUUCv+CQRTVJR2T2d0uHbu0bVZT4+w37hrZaYXOLrE8qSQeLUIpAvF7Cn/6qfHa/NGDWxajzn5BP1sDDnXh8mXtpKsD5MndxRBT9wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QljbtKB+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4260g51q014707;
	Wed, 6 Mar 2024 04:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2qH83HxliV1uVpQGC6xK96ulfWTpQIzrVHaZ2J7NW+k=; b=Ql
	jbtKB+3AttpWtH6S2P9UsKnXEMT+sIdowqq7s5OU2u3K1RtCmVYyz+uilSrCWl3q
	vnhaUyfqAXMdt1Mj9MAduVMIB61pmK9o4dR+zzXgfcNoAeO7H+Hh+eeRAfETyQEy
	PIqcQmCuPKUMC4apR7avCI2wNwJk628/b39bsOu0/jCCfbMFAfvJ1nNdZR8hJsam
	hqSJjmnMWhioVLG8989E7PLxRrwD69kPL9UEB/wbl2CAafCkCIfYUjGxXtGFr8Cn
	yXf5Q0iuzXyuFxAT99RnsG4+QJcxI2ijmdwSvJmm5Ste0VN4NBEWbzezmuReKjQk
	FJlX+oTWokbAoWmGuYNA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp028adfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 04:44:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4264iWDO028802
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 04:44:32 GMT
Received: from [10.253.9.240] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 20:44:31 -0800
Message-ID: <c9af14d1-2202-493c-9dae-7e3924e4e149@quicinc.com>
Date: Wed, 6 Mar 2024 12:44:29 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] wifi: mac80211: mlme: fix verification of puncturing
 bitmap obtained from AP
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>,
        Kalle Valo <kvalo@kernel.org>, Kalle Valo <quic_kvalo@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
References: <20230928055022.9670-1-quic_kangyang@quicinc.com>
 <20230928055022.9670-2-quic_kangyang@quicinc.com>
 <08ff36664eb34bce8e7beb425233b1e8d4a4971c.camel@sipsolutions.net>
 <d85bd8f7-a6aa-6ff7-09a8-57005e4d0779@quicinc.com>
In-Reply-To: <d85bd8f7-a6aa-6ff7-09a8-57005e4d0779@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MlkG6IrN481YpYMktXDB74gg_Hwrnhya
X-Proofpoint-ORIG-GUID: MlkG6IrN481YpYMktXDB74gg_Hwrnhya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_01,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060035



Due to Johannes's refactor of Puncturing bitmap, this patchset can be 
abandoned now.


Will prepare a new patch about puncturing bitmap for ath12k.


On 10/19/2023 11:25 AM, Kang Yang wrote:
> 
> 
> On 10/18/2023 7:39 PM, Johannes Berg wrote:
>>>   static bool ieee80211_config_puncturing(struct ieee80211_link_data 
>>> *link,
>>>                       const struct ieee80211_eht_operation *eht_oper,
>>>                       u64 *changed)
>>>   {
>>> +    struct cfg80211_chan_def rx_chandef = link->conf->chandef;
>>>       u16 bitmap = 0, extracted;
>>> +    u8 bw = 0;
>>>       if ((eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT) &&
>>>           (eht_oper->params &
>>> @@ -5684,6 +5706,28 @@ static bool ieee80211_config_puncturing(struct 
>>> ieee80211_link_data *link,
>>>           const u8 *disable_subchannel_bitmap = info->optional;
>>>           bitmap = get_unaligned_le16(disable_subchannel_bitmap);
>>> +        bw = u8_get_bits(info->control, IEEE80211_EHT_OPER_CHAN_WIDTH);
>>> +        rx_chandef.width = ieee80211_rx_bw_to_nlwidth(bw);
>>
>> But looking here, it clearly _doesn't_ make sense. IEEE80211_STA_RX_BW_*
>> is a purely internal API, has nothing to do with the spec.
>>
>> All this might even be "accidentally correct", but it really isn't right
>> at all - the values in IEEE80211_EHT_OPER_CHAN_WIDTH are
>> IEEE80211_EHT_OPER_CHAN_WIDTH_*, not IEEE80211_STA_RX_BW_*.
>>
> 
> 
> 
> Oh, sorry that i didn't notice IEEE80211_EHT_OPER_CHAN_WIDTH_*, will 
> replace them.
> 
> 
>>
>>
>> More generally though, I don't even understand the change.
> 
> 
> During assoc, downgrade may happen in func ieee80211_config_bw(). In 
> this situation, the bandwidth in beacon and the bandwidth after 
> downgrade(chandef->width, maybe i should call it local bandwidth during 
> below context, will use this name in next version) during assoc will be 
> different.
> 
> The change is based on this point.
> 
> 
>>
>>> +        if (rx_chandef.width == NL80211_CHAN_WIDTH_80)
>>> +            rx_chandef.center_freq1 =
>>> +                ieee80211_channel_to_frequency(info->ccfs0,
>>> +                                   rx_chandef.chan->band);
>>> +        else if (rx_chandef.width == NL80211_CHAN_WIDTH_160 ||
>>> +             rx_chandef.width == NL80211_CHAN_WIDTH_320)
>>> +            rx_chandef.center_freq1 =
>>> +                ieee80211_channel_to_frequency(info->ccfs1,
>>> +                                   rx_chandef.chan->band);
>>> +    }
>>> +
>>> +    if (!cfg80211_valid_disable_subchannel_bitmap(&bitmap,
>>> +                              &rx_chandef)) {
> 
> 
> Here i change you code 
> cfg80211_valid_disable_subchannel_bitmap(&bitmap,&link->conf->chandef) to
> cfg80211_valid_disable_subchannel_bitmap(&bitmap,&rx_chandef)
> 
> As described above, downgrade may happen before enter 
> ieee80211_config_puncturing(), so the bandwidth in link->conf->chandef 
> may be different with bandwidth in beacon.
> 
> Here, the bitmap you used is from eht_oper in beacon, but the bandwidth 
> you used is local bandwidth. They are not match. This is the first issue.
> 
> 
>>> +        link_info(link,
>>> +              "Got an invalid disable subchannel bitmap from AP %pM: 
>>> bitmap = 0x%x, bw = 0x%x. disconnect\n",
>>> +              link->u.mgd.bssid,
>>> +              bitmap,
>>> +              rx_chandef.width);
>>> +        return false;
>>>       }
>>>       extracted = ieee80211_extract_dis_subch_bmap(eht_oper,
>> // I've filled in the context here in the patch
> 
> 
> Here is move the cfg80211_valid_disable_subchannel_bitmap() before the 
> ieee80211_extract_dis_subch_bmap(), cause i think check should done 
> before extract.
> 
> This is the second issue i said(perhaps not a issue).
> 
> 
> 
>>>                                                       
>>> &link->conf->chandef,
>>>                                                       bitmap);
>>>
>>>          /* accept if there are no changes */
>>>          if (!(*changed & BSS_CHANGED_BANDWIDTH) &&
>>>              extracted == link->conf->eht_puncturing)
>>>                  return true;
>>
>> but ... ieee80211_extract_dis_subch_bmap actually already takes the
>> bandwidth from eht_oper into account!
> 
> Yes, the ieee80211_extract_dis_subch_bmap realy takes the bandwidth from 
> eht_oper into account, and the local_bw in this func is the local 
> bandwidth i discuss.
> 
> You already notice the difference between bandwidth from eht_oper and 
> local bandwidth in ieee80211_extract_dis_subch_bmap(). I think you 
> should also take it into account when you use 
> cfg80211_valid_disable_subchannel_bitmap(), right?
> 
> BTW, do you want to verify the bitmap from eht_oper, or the extracted 
> bitmap?
> 
> Anyway, whether you want to verify the bitmap from eht_oper or extracted 
> bitmap in cfg80211_valid_disable_subchannel_bitmap(), the bitmap and 
> bandwidth must correspond.
> 
> 
> 
>>> -    if (!cfg80211_valid_disable_subchannel_bitmap(&bitmap,
>>> -                              &link->conf->chandef)) {
>>
>> So are you saying that the real bug is that we're missing to update the
>> link->conf->chandef with the EHT operation from the assoc response?
>>
>> But you didn't fix that issue ... so not sure?
> 
> 
> I have described my patch with the comments above, maybe i should make 
> my commit log more coherent.
> 
> 
> Besides, this is you first version, i made some comments on Nov. 21, 
> 2022, 7:29 a.m. Maybe you already forget them.
> https://patchwork.kernel.org/project/linux-wireless/patch/20220325140859.e48bf244f157.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid/
> 
> 
>>
>> johannes
>>
> 

