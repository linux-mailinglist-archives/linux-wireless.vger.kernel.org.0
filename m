Return-Path: <linux-wireless+bounces-22861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C53AB2F58
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 08:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28933A531B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 06:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D543254856;
	Mon, 12 May 2025 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jj61mFcJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFC780B
	for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747030215; cv=none; b=PuMiYClwkqMB8RwpxdvRqg1mVa64duXqhQvf3+D/zeoAoU7qBw42KcuFLD9fcZ9M6uQjrXk2pdB/HBZhg4OZW+woPbUpGiSXn1Sk78WlBWmRIPobeLwEe4WIOT6LLPUSk0r24gtkLRgY8m4EOo81zdEf7HPAS3Rgxwx7qYiAVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747030215; c=relaxed/simple;
	bh=QOuBuraH2d++QH/XscGiYjNjfsDDnXsKXFxsfhLG36Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eWOclW+k94/YbVoeeuok2u/FIOAuc12qUbkRIG1r1fh3Mck82SQO3IG5lsjQ/+/Vx+N2aMYjmdgdOnQBP8NvfSX3H+nsYJN+K9X7HFOy1ZoywA6q66ZcWdIM6fwjfKRc+q2TLL0aDFFmxZX4P7iDC+Rd5Fh5hV2APd9XlAtrJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jj61mFcJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C0LJsc024716;
	Mon, 12 May 2025 06:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	scGl9DWUFBg7Q9A5wxfhxcpyJ9Q+AxGDsLA2yVdGlpU=; b=Jj61mFcJCu0hB+fQ
	xHyM0ANW15vQO6i8ZBKPMxPJfeIXmUuY6rvDXOe9uEgKZddjppYyhc4OS2uO2E93
	IkHpALiRRIVNVUO6hONrr50BwvA/31SB9l9G6VCJlh0VDsQZAoDpdEXNk/EDtz2v
	lCkI4kRfoIAyGNikZQru9vwE8NPwaCGkxq2POXnTZvxMjlhP4DLNj5XDJnrHGS44
	8V1R8NuE1dxitOUw8MtX2dBE8enTINcLZWXBrp2CjC0ppcEcNASXJwl46T/QRvqx
	ga2uhdqyEVJzoHvYOgGhmE4yPNmLabjTUTRCFmOhDr6D8Jf9epByWBtw2QO1uLr4
	/g3FQg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hxd1k87c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 06:10:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54C6A2xx013168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 06:10:02 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 11 May
 2025 23:09:56 -0700
Message-ID: <4c88816a-d3af-426a-8373-922a4a6c5825@quicinc.com>
Date: Mon, 12 May 2025 14:09:46 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath11k: support DBS and DFS compatibility
To: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>, <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, Mihai Moldovan <ionic@ionic.de>
References: <20241127022742.4016870-1-quic_yuzha@quicinc.com>
 <e8eb20ec-d022-45e4-82d9-00a4ab575676@quicinc.com>
 <31e80294-5202-4210-ac22-842b08250c16@quicinc.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <31e80294-5202-4210-ac22-842b08250c16@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA2MyBTYWx0ZWRfX+y2txZ8Qqq68
 Y/9eRoenCRYw237MFgKO4R/GLAvxcdLHcC3sEwc/4u078pH1hrPFo8Qo1LCsox6sEEb4YtnOU3v
 FbpFmWXAYy3uHi0WQ2mSKtK6gqd0K05gErrwjCrApg7NzM13TaGFfxUHsCIYwPLkdCCMRLgFoz3
 ldOyanpKJGXhcrtTj/CURC8lVpfDWQWf+2+sfzShgqIx6uTx5ToJsytl+y3T0zRbdUlWrZaZdAv
 dZv7o2220D2ILD1Ux4KZ1DH4roBUPIVYJau1h2mqDnH/S4PFZTiSMwN7CyS67XqSRwJssl+5WdK
 MK7PWAydwkpGKcJ3LtUPciEDBgV0ZLu9Ln1O8gtBRxctpCOSKrvnwVVXe0d/ro2NTvexFQ7OEv8
 vydjKTH8vR+JEtYvn9P71kWNMhmVr/AZCeYlErHdQL9A/sLqbhfBy6zebG3dIjl5vp7w8HRf
X-Authority-Analysis: v=2.4 cv=ObSYDgTY c=1 sm=1 tr=0 ts=682190bb cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=bC-a23v3AAAA:8
 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=aCMqlG4u3zxAIDOfNM4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 4dRcVXunbVbyH3csSrrcAt1JVLvnNGVI
X-Proofpoint-GUID: 4dRcVXunbVbyH3csSrrcAt1JVLvnNGVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_02,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120063



On 5/12/2025 1:52 PM, Yu Zhang (Yuriy) wrote:
> 
> 
> On 5/12/2025 10:56 AM, Baochen Qiang wrote:
>>
>>
>> On 11/27/2024 10:27 AM, Yu Zhang(Yuriy) wrote:
>>> Now some chips which support 'support_dual_stations' will enable DBS,
>>> but will disable DFS. Restructure the ath11k_mac_setup_iface_combinations
>>> function to support DBS and DFS compatibility.
>>>
>>> About 'support_dual_station' feature can refer:
>>> https://msgid.link/20230714023801.2621802-2-quic_cjhuang@quicinc.com
>>>
>>> Add a ieee80211_iface_combination to support DBS and DFS compatibility,
>>> one combination can support DFS(same with non dual sta), another
>>> combination can support DBS. When running different scenarios that will
>>> use different ieee80211_iface_combination due to mac80211 will go through
>>> all of possible interface combinations.
>>>
>>> In addition, maximum number of interfaces of these types should be total
>>> allowed in this group.
>>>
>>> The chips affected are:
>>>
>>>   QCA6390 hw2.0
>>>   WCN6855 hw2.0
>>>   WCN6855 hw2.1
>>>
>>> Other chips are not affected.
>>>
>>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-00410-QCAHKSWPL_SILICONZ-2
>>> Tested-on: IPQ6018 hw1.0 AHB WLAN.HK.2.1.0.1-01161-QCAHKSWPL_SILICONZ-1
>>> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04402-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1.
>>> Tested-by: Mihai Moldovan <ionic@ionic.de>
>>> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1
>>>
>>> Signed-off-by: Yu Zhang(Yuriy) <quic_yuzha@quicinc.com>
>>> ---
>>> v2:
>>>   - Add tested-on IPQ8074 and IPQ6018.
>>> v3:
>>>   - Add tested-on QCA6390.
>>> ---
>>>   drivers/net/wireless/ath/ath11k/mac.c | 42 +++++++++++++++------------
>>>   1 file changed, 24 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
>>> index 31ae9b384a29..aa63f5e20f2b 100644
>>> --- a/drivers/net/wireless/ath/ath11k/mac.c
>>> +++ b/drivers/net/wireless/ath/ath11k/mac.c
>>> @@ -9911,12 +9911,17 @@ static int ath11k_mac_setup_iface_combinations(struct ath11k *ar)
>>>       struct ath11k_base *ab = ar->ab;
>>>       struct ieee80211_iface_combination *combinations;
>>>       struct ieee80211_iface_limit *limits;
>>> -    int n_limits;
>>> +    int n_limits, n_combos;
>>>       bool p2p;
>>>         p2p = ab->hw_params.interface_modes & BIT(NL80211_IFTYPE_P2P_DEVICE);
>>>   -    combinations = kzalloc(sizeof(*combinations), GFP_KERNEL);
>>> +    if (ab->hw_params.support_dual_stations)
>>> +        n_combos = 2;
>>> +    else
>>> +        n_combos = 1;
>>> +
>>> +    combinations = kcalloc(n_combos, sizeof(*combinations), GFP_KERNEL);
>>>       if (!combinations)
>>>           return -ENOMEM;
>>>   @@ -9931,7 +9936,9 @@ static int ath11k_mac_setup_iface_combinations(struct ath11k *ar)
>>>           return -ENOMEM;
>>>       }
>>>   +    limits[0].max = 1;
>>>       limits[0].types |= BIT(NL80211_IFTYPE_STATION);
>>> +    limits[1].max = 16;
>>>       limits[1].types |= BIT(NL80211_IFTYPE_AP);
>>>       if (IS_ENABLED(CONFIG_MAC80211_MESH) &&
>>>           ab->hw_params.interface_modes & BIT(NL80211_IFTYPE_MESH_POINT))
>>> @@ -9941,25 +9948,24 @@ static int ath11k_mac_setup_iface_combinations(struct ath11k *ar)
>>>       combinations[0].n_limits = n_limits;
>>>       combinations[0].beacon_int_infra_match = true;
>>>       combinations[0].beacon_int_min_gcd = 100;
>>> +    combinations[0].max_interfaces = 16;
>>> +    combinations[0].num_different_channels = 1;
>>> +    combinations[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
>>> +                        BIT(NL80211_CHAN_WIDTH_20) |
>>> +                        BIT(NL80211_CHAN_WIDTH_40) |
>>> +                        BIT(NL80211_CHAN_WIDTH_80) |
>>> +                        BIT(NL80211_CHAN_WIDTH_80P80) |
>>> +                        BIT(NL80211_CHAN_WIDTH_160);
>>>         if (ab->hw_params.support_dual_stations) {
>>>           limits[0].max = 2;
>>
>> as this limits array is assigned to combinations[0], don't you need another array that
>> would be assigned to combinations[1]?
> This limits array just for AP and STA iftypes that can be shared.

do you mean that combinations[0] and combinations[1] share the same limit configuration?
which is

limits[0].max = 2;
limits[0].types |= BIT(NL80211_IFTYPE_STATION);
limits[1].max = 16;
limits[1].types |= BIT(NL80211_IFTYPE_AP);


>>
>>> -        limits[1].max = 1;
>>
>> why is this removed?
> AP interface shouldn't be limited to only 1.
> As Jose Ignacio Tornos Martinez <jtornosm@redhat.com> issues "[PATCH] wifi: ath11k: allow
> APs combination when dual stations are supported" https://lore.kernel.org/
> all/20241202091858.200773-1-jtornosm@redhat.com/
>>
>>> -
>>> -        combinations[0].max_interfaces = ab->hw_params.num_vdevs;
>>> -        combinations[0].num_different_channels = 2;
>>> -    } else {
>>> -        limits[0].max = 1;
>>> -        limits[1].max = 16;
>>>   -        combinations[0].max_interfaces = 16;
>>> -        combinations[0].num_different_channels = 1;
>>> -        combinations[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
>>> -                            BIT(NL80211_CHAN_WIDTH_20) |
>>> -                            BIT(NL80211_CHAN_WIDTH_40) |
>>> -                            BIT(NL80211_CHAN_WIDTH_80) |
>>> -                            BIT(NL80211_CHAN_WIDTH_80P80) |
>>> -                            BIT(NL80211_CHAN_WIDTH_160);
>>> +        combinations[1].limits = limits;
>>> +        combinations[1].n_limits = n_limits;
>>> +        combinations[1].beacon_int_infra_match = true;
>>> +        combinations[1].beacon_int_min_gcd = 100;
>>> +        combinations[1].max_interfaces = ab->hw_params.num_vdevs;
>>> +        combinations[1].num_different_channels = 2;
>>>       }
>>>         if (p2p) {
>>> @@ -9970,7 +9976,7 @@ static int ath11k_mac_setup_iface_combinations(struct ath11k *ar)
>>>       }
>>>         ar->hw->wiphy->iface_combinations = combinations;
>>> -    ar->hw->wiphy->n_iface_combinations = 1;
>>> +    ar->hw->wiphy->n_iface_combinations = n_combos;
>>>         return 0;
>>>   }
>>
> 


