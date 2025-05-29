Return-Path: <linux-wireless+bounces-23498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EC0AC805F
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 17:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127E717E3DF
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 15:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F14421C195;
	Thu, 29 May 2025 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PRNRUmD6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A4193062
	for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748533019; cv=none; b=CCf632bUyem6s3U2f4qt5gK5wGzdnTWzTHweGBhb66KAOSbCZdwYblWB2EiHf/LSQf01rf3h1lyQms0Q4x430zUB6rOzDSFXKpqgY3GxcHYUE2McMI3x1bqXQ66uQ6cVVLZnLbrKelqJEv3eVVgWuYPUgxWBFbScxo3xcPCcseY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748533019; c=relaxed/simple;
	bh=ICZ1Cu155OXIJjheSWbz3UBcp2adjllYSIJrXATVxEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8WB36uCKkn8sxu8eouCGuP3rdQNGeOj/rY6XYejl2q8xoS0fCH3l5A2LYb2CNHSqjwF7SGeHnnFSodPtiniMKo03PGsgL6h8oaO1syX07gburvh/Ftyy4kjc6kBOIlNIobTFT3Eu0z4w7bhbkXiS2B71P09vcu2s3mHAw6O9rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PRNRUmD6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TC1KTu024519
	for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 15:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HURl4z9pnhojRUIQ0vqLPeMmzv45VZO4aDdp97MNdBY=; b=PRNRUmD68oqGxDxd
	2e9ZmK/vMNe98AwmQOggSaendj6YvoArPreXmidbFoAukr9Ja0pnxxPyTWojRDBd
	20c19FqD/2XPuh0ciOJxaJYwV2L+IuxFlfrUCzZVUSTXfbgo6WowsxdZU9a5HKoa
	kMOslqshz1jzVjfTyjcry4pVvkECDxKKQiUk0Hm9dnpQKXG3tC75aMQ7DiQm1Cv+
	l3VY2k4Lm1/isdOaOu+1cDIDxkB3k5A3TjUvAaK9UBHtZ/X6v9tp5VXuok+VYmmG
	Uypop6Yk6AiRsnH0TS0VJ4l7VQ+sP8ciKpgEET4kk8EF0dd+EDCMyLeBets91n3J
	D/MVnw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46x03mvesp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 15:36:55 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-707cf1b0ecbso17252797b3.2
        for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 08:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748533015; x=1749137815;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HURl4z9pnhojRUIQ0vqLPeMmzv45VZO4aDdp97MNdBY=;
        b=ES7jiFn3Nu8YMSoLihLY1TUgSjcKoe8MCsU4OpQ1FgU5lc8ZKimmIrgPai8LQ0Fbr6
         QVVPqF5V99UmhF4LRlNRp9TCg/xGKvy4vWtZNUziCp1IJx6mu4dSMrfULwmU01UyHKY+
         OXKMciAnIN5Bf57j6k5MyOjJz7Nfi6w4yZd85AqxQHuPYEReROWBz2KANOuWx9nqxqaE
         Sg77T7SUKgiFXkJWAnLc1D8o0ErxrBaD/0nAjOPMXw8vx8sJ8bU+aTAYXVv7l4kXiLYX
         PsSpDePpZdwa5p7jZF3cmM7nvlCgOA5niHOF7NKkmH64vyTKDBqC+E6ysXOzG1cmyO5Z
         C5ww==
X-Gm-Message-State: AOJu0Yy0L/CFvuPvPDtmhh9XkHlpF084IP4skluP94ZYE8U8fbh+A6Vp
	JF2pjTUnM2YBIQt5AxlkEIFW5jdQ2GTy1MIU7fS8gjd6NDj0XjLtKa/3ax8OQLrMIiNP8d2aIVo
	o6KW7+VdZp8Sstg6pIkXSWwhD1SbvOp9pK6p+xqc9NryC1xhan/oaFJ8Ndr7OXslJY08qz5ihAn
	M3NA==
X-Gm-Gg: ASbGnctkYyBknfXmCI/lo7xkCvnfhDTqnGxQ7JtgCDdNw/94YpoTSmDsTG2hEsdZbwe
	H1d1Zw8MGuo3McoxxpPsl7VSwLcsZztnPEUDrLHyZRA2+j0QbQWYmZDaFogBnLwqgW+fqdNiTpD
	yrHiV7jMOfet81NsuRFtf6TMP9dCM6c7CnprMNjzQDT3yPFmbZNUoighMfIuJap67mwPXqqtSIv
	wXo+KgbzCMC9j6/WsQ2fzUbzmYjgSxjqvand/ZN1BeH6hjNPWZ1wZx/jPZ+mRGz50V5yDsuAsXj
	KOw92KYhSpIKhSSth4Qt1SxFLNu2hnLdrqfDRCnC6jDQ1WWJNdwPhF9XISOBXY4/Nsc=
X-Received: by 2002:a05:622a:59c9:b0:4a3:530b:2885 with SMTP id d75a77b69052e-4a440048492mr1700831cf.22.1748533004550;
        Thu, 29 May 2025 08:36:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJqzoFyyOftMMZCzeTtDWxnsCgiqAxr42KRWDtD7npI835o0jtABQhJL/7ClkhajsePn1TvQ==
X-Received: by 2002:a17:90b:35ca:b0:312:1508:fb4e with SMTP id 98e67ed59e1d1-3124173bdfemr109760a91.17.1748532994065;
        Thu, 29 May 2025 08:36:34 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3123b29c5ecsm166331a91.3.2025.05.29.08.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 08:36:33 -0700 (PDT)
Message-ID: <908067d3-87cf-4477-959e-0dd738244d88@oss.qualcomm.com>
Date: Thu, 29 May 2025 08:36:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v11 3/3] wifi: mac80211: Set RTS threshold
 on per-radio basis
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20250522053326.4139256-1-quic_rdevanat@quicinc.com>
 <20250522053326.4139256-4-quic_rdevanat@quicinc.com>
 <e5c0fa7c-598f-40d8-b258-f935af069ff3@oss.qualcomm.com>
 <b37db169-22a6-48fb-9183-f2ed970bdd32@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b37db169-22a6-48fb-9183-f2ed970bdd32@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lUFLIPnBYY28dGlt5me2Fuuq4CkzJ93G
X-Authority-Analysis: v=2.4 cv=FuAF/3rq c=1 sm=1 tr=0 ts=68387f17 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=KJkFJz1KA5ToRKzF9ykA:9
 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: lUFLIPnBYY28dGlt5me2Fuuq4CkzJ93G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE1MCBTYWx0ZWRfXzCXc5eFe3hAq
 v84T3Asl1g8JGaxT2w/zyzofe6TlamomXGmvfuBcr8ZZln9OAk0a16H90rCKgWojetqgCFxuHxE
 weyx2hMafb5+6ZDzSgM/scw+HLm/ypREi+UJ0oIsXIkCnm6uLnt8liUWgNHkFMmzY7AphS926Og
 mxJXHr3qpmWt1vMWqPzTz+RcbDUxs0iJLrOEZpiJzLNC78eV7Np2TMnfd3/2x4iQCrhWWIpnf2m
 d7j3v9n34gcimYkb1F+q0pINIjSgIsz5KWXQeWAU3f2THO9BN6gfCDTEfS1AlDqSaDS3Lt+bE46
 ueLikfioidN7JHbeRteWD25fRVrLEK1Mg+zk2uZ5Axly8DsAWljX/s9rujysag/zmZQuG4/OtN8
 AqNHNUufsA3gHgneXSIYH3o5VuivFUJ3EhGF9yvaeC3H7hHPBIeetKBQgweV3UWHa0/3T2H9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290150

On 5/29/2025 4:11 AM, Roopni Devanathan wrote:
> 
> 
> On 5/28/2025 11:41 PM, Jeff Johnson wrote:
>> On 5/21/2025 10:33 PM, Roopni Devanathan wrote:
>>> Add support to get the radio for which RTS threshold needs to be changed
>>> from userspace. Pass on this radio index to underlying drivers as an
>>> additional argument.
>>>
>>> A value of -1 indicates radio index is not mentioned and that the
>>> configuration applies to all radio(s) of the wiphy.
>>>
>>> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
>>> ---
>>>  drivers/net/wireless/ath/ar5523/ar5523.c      |  3 ++-
>>>  drivers/net/wireless/ath/ath10k/mac.c         |  5 ++--
>>>  drivers/net/wireless/ath/ath11k/mac.c         |  4 +++-
>>>  drivers/net/wireless/ath/ath12k/mac.c         |  4 +++-
>>>  drivers/net/wireless/ath/ath9k/htc_drv_main.c |  3 ++-
>>>  drivers/net/wireless/ath/wcn36xx/main.c       |  3 ++-
>>>  .../net/wireless/intel/iwlwifi/mld/mac80211.c |  3 ++-
>>>  .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 ++-
>>>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 ++-
>>>  drivers/net/wireless/marvell/mwl8k.c          |  3 ++-
>>>  .../net/wireless/mediatek/mt76/mt7615/main.c  |  3 ++-
>>>  drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 +-
>>>  .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
>>>  .../net/wireless/mediatek/mt76/mt7915/main.c  |  3 ++-
>>>  .../net/wireless/mediatek/mt76/mt7921/main.c  |  3 ++-
>>>  .../net/wireless/mediatek/mt76/mt7925/main.c  |  3 ++-
>>>  .../net/wireless/mediatek/mt76/mt7996/main.c  |  3 ++-
>>>  drivers/net/wireless/mediatek/mt7601u/main.c  |  3 ++-
>>>  drivers/net/wireless/purelifi/plfxlc/mac.c    |  3 ++-
>>>  .../net/wireless/ralink/rt2x00/rt2800lib.c    |  2 +-
>>>  .../net/wireless/ralink/rt2x00/rt2800lib.h    |  2 +-
>>>  drivers/net/wireless/realtek/rtl8xxxu/core.c  |  3 ++-
>>>  drivers/net/wireless/realtek/rtw88/mac80211.c |  3 ++-
>>>  drivers/net/wireless/realtek/rtw89/mac80211.c |  3 ++-
>>>  drivers/net/wireless/rsi/rsi_91x_mac80211.c   |  2 ++
>>>  drivers/net/wireless/silabs/wfx/sta.c         |  2 +-
>>>  drivers/net/wireless/silabs/wfx/sta.h         |  2 +-
>>>  drivers/net/wireless/st/cw1200/sta.c          |  2 +-
>>>  drivers/net/wireless/st/cw1200/sta.h          |  2 +-
>>>  drivers/net/wireless/ti/wl1251/main.c         |  3 ++-
>>>  drivers/net/wireless/ti/wlcore/main.c         |  3 ++-
>>>  drivers/net/wireless/virtual/mac80211_hwsim.c |  4 +++-
>>
>> ...
>>
>>> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
>>> index 82617579d910..553bcfebe8cc 100644
>>> --- a/include/net/mac80211.h
>>> +++ b/include/net/mac80211.h
>>> @@ -4572,7 +4572,8 @@ struct ieee80211_ops {
>>>  			    struct ieee80211_key_conf *key,
>>>  			    struct ieee80211_key_seq *seq);
>>>  	int (*set_frag_threshold)(struct ieee80211_hw *hw, u32 value);
>>> -	int (*set_rts_threshold)(struct ieee80211_hw *hw, u32 value);
>>> +	int (*set_rts_threshold)(struct ieee80211_hw *hw, int radio_id,
>>> +				 u32 value);
>>>  	int (*sta_add)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>>  		       struct ieee80211_sta *sta);
>>>  	int (*sta_remove)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>
>> rather than have one patch that modifies the get_rts_threshold API, another
>> that modifies the set_rts_threshold API, and future ones that will modify
>> others, should we put these interface changes that affect all drivers in a
>> single patch so that the individual driver maintainers only have to deal with
>> this disruption once rather than for each attribute?
>>
>> that means enumerating all the attributes we want to maintain on a per-radio
>> basis up front. do we have that list?
>>
>> /jeff
> 
> From the cover letter, here's the list of potential per-radio attributes:
> NL80211_ATTR_WIPHY_FREQ
> NL80211_ATTR_WIPHY_ANTENNA_TX
> NL80211_ATTR_WIPHY_ANTENNA_RX
> NL80211_ATTR_WIPHY_RETRY_SHORT
> NL80211_ATTR_WIPHY_RETRY_LONG
> NL80211_ATTR_WIPHY_FRAG_THRESHOLD
> NL80211_ATTR_WIPHY_RTS_THRESHOLD
> NL80211_ATTR_WIPHY_COVERAGE_CLASS
> NL80211_ATTR_WIPHY_DYN_AC
> 
> If we are going to change the interfaces of all the handlers of these
> attributes, I can assign a default radio_idx (-1) to all the APIs. Can I go
> ahead implementing this?

That makes sense to me. Johannes?


