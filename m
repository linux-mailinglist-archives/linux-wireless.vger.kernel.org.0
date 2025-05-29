Return-Path: <linux-wireless+bounces-23494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23804AC7C69
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 13:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8DCA1BC12D4
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 11:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68531227E98;
	Thu, 29 May 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q3vTJi0U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B131E573F
	for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517098; cv=none; b=FoxE7Ed5tTvZu52bt+V3r3najbm+5Z2fNPD14P7pTqYN1uJWWTNl6veIVFQ4GIMkbYkusOomUIG73SKg/2GLdJBrmb7ygNCk0+Nz5x26Su65qFdPqGF8AemzAI91IGftnOATEZ9nND3Ifaje4ZgHEmR7rmohlXwbVlGafKb3rkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517098; c=relaxed/simple;
	bh=vPwJX79Kry4/xBnifvC0CTfzokzyXFZsemYjy6tFvAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n6uq4ElZC475NROn97edW9MIMYn+DSrUroIxzrHMBTVdNU8SFJLVxKnHdqHUgeTFk2zNvt92z7aiBriTFFwnhcslpzDceyxCv1Wn2xb8byel4OHhPEVcljfegl+CI0ZYcdfnfKhiCkZjy/7ed34OJYhY+kyzhu9YPt13u77J+gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q3vTJi0U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T9l4Ks012686;
	Thu, 29 May 2025 11:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cCUP8a5R7c8W7g5GvPZQKhm7OuDTnkINaXUML4WitHc=; b=Q3vTJi0UfNYx+6NV
	OLu8g9p+cpTSFhnMfZoWf+aqv61VmMkiIsffyC6FMsCpr+bI2s/EAUt4x3y4tI8v
	jsMHyJoQ6ew34PG68VerUBoQN5OcAiN1LBMDOjyHD/EHU55wX9XsRyyA/gqoY0kS
	t0JesUUAj4ONzEhznf4nNKxq9rZi6IS+kdE5gSAKqg7uZlxYnsT48+I6TIHNb7nQ
	aqDTzwsGT6tlqCX6E4c03ut9+Kdkaoa4LpJR5aCiH7rlGtEYEM/zi0rCOiUSqZvb
	3ISuyf13A+jXyXVoynBgGGhaavDMw7B9RuxGRBsuijTCPHWiDMtB8kX8LIUGeBGG
	Yp8eBA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w691fyr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 11:11:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54TBBUDG007228
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 11:11:30 GMT
Received: from [10.152.206.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 29 May
 2025 04:11:28 -0700
Message-ID: <b37db169-22a6-48fb-9183-f2ed970bdd32@quicinc.com>
Date: Thu, 29 May 2025 16:41:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v11 3/3] wifi: mac80211: Set RTS threshold
 on per-radio basis
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250522053326.4139256-1-quic_rdevanat@quicinc.com>
 <20250522053326.4139256-4-quic_rdevanat@quicinc.com>
 <e5c0fa7c-598f-40d8-b258-f935af069ff3@oss.qualcomm.com>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <e5c0fa7c-598f-40d8-b258-f935af069ff3@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=WfoMa1hX c=1 sm=1 tr=0 ts=683840e3 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=ooOCkVw_uSDplHzVo54A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 9NFpm2UsoxDHi-YjJ48SZOJmLm-MAxRr
X-Proofpoint-ORIG-GUID: 9NFpm2UsoxDHi-YjJ48SZOJmLm-MAxRr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDEwOCBTYWx0ZWRfX/MpJOHONtvSp
 DSydvet3edz139A73UTzZVZhTOZZnQaMhWdOgPtxiOUKees6GAWs66d3sw5g61XpTN9YsHkULDe
 o5nN/0IsX8UotsHTjoeaLEX+9BwkFNS5UYMtnc5xDNljrz3rXQsFx0nxqL6trnlpEOoUkX/99Pu
 JAiLL5z4WXO8tOdMTR1O7iYSp2YWyrHJ4wGZ3kZc/tX8jWYIveUSd+9ufSKwqY4AUNHkdde7wtD
 fUv/vLlMXOmw2MSt57zpfz4TZepd47jmK7VZ8Fc5vhK7vmwBCC4Lv/x/bq6oHlgsGV4WtUV1UDV
 c0IocfrxaeYj1EQoll84Tim1jW85egwjTEo/t2I+xU1+8+6Wabcm2pL1/1jizOG7EzSJjmv50ic
 azxvVY8thT63VaDKjWhh4APvxslczIk9qktRHdoLnQFUjJfGbjp1G30uwksocnjOo3OThPEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_06,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290108



On 5/28/2025 11:41 PM, Jeff Johnson wrote:
> On 5/21/2025 10:33 PM, Roopni Devanathan wrote:
>> Add support to get the radio for which RTS threshold needs to be changed
>> from userspace. Pass on this radio index to underlying drivers as an
>> additional argument.
>>
>> A value of -1 indicates radio index is not mentioned and that the
>> configuration applies to all radio(s) of the wiphy.
>>
>> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ar5523/ar5523.c      |  3 ++-
>>  drivers/net/wireless/ath/ath10k/mac.c         |  5 ++--
>>  drivers/net/wireless/ath/ath11k/mac.c         |  4 +++-
>>  drivers/net/wireless/ath/ath12k/mac.c         |  4 +++-
>>  drivers/net/wireless/ath/ath9k/htc_drv_main.c |  3 ++-
>>  drivers/net/wireless/ath/wcn36xx/main.c       |  3 ++-
>>  .../net/wireless/intel/iwlwifi/mld/mac80211.c |  3 ++-
>>  .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 ++-
>>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 ++-
>>  drivers/net/wireless/marvell/mwl8k.c          |  3 ++-
>>  .../net/wireless/mediatek/mt76/mt7615/main.c  |  3 ++-
>>  drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 +-
>>  .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
>>  .../net/wireless/mediatek/mt76/mt7915/main.c  |  3 ++-
>>  .../net/wireless/mediatek/mt76/mt7921/main.c  |  3 ++-
>>  .../net/wireless/mediatek/mt76/mt7925/main.c  |  3 ++-
>>  .../net/wireless/mediatek/mt76/mt7996/main.c  |  3 ++-
>>  drivers/net/wireless/mediatek/mt7601u/main.c  |  3 ++-
>>  drivers/net/wireless/purelifi/plfxlc/mac.c    |  3 ++-
>>  .../net/wireless/ralink/rt2x00/rt2800lib.c    |  2 +-
>>  .../net/wireless/ralink/rt2x00/rt2800lib.h    |  2 +-
>>  drivers/net/wireless/realtek/rtl8xxxu/core.c  |  3 ++-
>>  drivers/net/wireless/realtek/rtw88/mac80211.c |  3 ++-
>>  drivers/net/wireless/realtek/rtw89/mac80211.c |  3 ++-
>>  drivers/net/wireless/rsi/rsi_91x_mac80211.c   |  2 ++
>>  drivers/net/wireless/silabs/wfx/sta.c         |  2 +-
>>  drivers/net/wireless/silabs/wfx/sta.h         |  2 +-
>>  drivers/net/wireless/st/cw1200/sta.c          |  2 +-
>>  drivers/net/wireless/st/cw1200/sta.h          |  2 +-
>>  drivers/net/wireless/ti/wl1251/main.c         |  3 ++-
>>  drivers/net/wireless/ti/wlcore/main.c         |  3 ++-
>>  drivers/net/wireless/virtual/mac80211_hwsim.c |  4 +++-
> 
> ...
> 
>> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
>> index 82617579d910..553bcfebe8cc 100644
>> --- a/include/net/mac80211.h
>> +++ b/include/net/mac80211.h
>> @@ -4572,7 +4572,8 @@ struct ieee80211_ops {
>>  			    struct ieee80211_key_conf *key,
>>  			    struct ieee80211_key_seq *seq);
>>  	int (*set_frag_threshold)(struct ieee80211_hw *hw, u32 value);
>> -	int (*set_rts_threshold)(struct ieee80211_hw *hw, u32 value);
>> +	int (*set_rts_threshold)(struct ieee80211_hw *hw, int radio_id,
>> +				 u32 value);
>>  	int (*sta_add)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>  		       struct ieee80211_sta *sta);
>>  	int (*sta_remove)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> 
> rather than have one patch that modifies the get_rts_threshold API, another
> that modifies the set_rts_threshold API, and future ones that will modify
> others, should we put these interface changes that affect all drivers in a
> single patch so that the individual driver maintainers only have to deal with
> this disruption once rather than for each attribute?
> 
> that means enumerating all the attributes we want to maintain on a per-radio
> basis up front. do we have that list?
> 
> /jeff

From the cover letter, here's the list of potential per-radio attributes:
NL80211_ATTR_WIPHY_FREQ
NL80211_ATTR_WIPHY_ANTENNA_TX
NL80211_ATTR_WIPHY_ANTENNA_RX
NL80211_ATTR_WIPHY_RETRY_SHORT
NL80211_ATTR_WIPHY_RETRY_LONG
NL80211_ATTR_WIPHY_FRAG_THRESHOLD
NL80211_ATTR_WIPHY_RTS_THRESHOLD
NL80211_ATTR_WIPHY_COVERAGE_CLASS
NL80211_ATTR_WIPHY_DYN_AC

If we are going to change the interfaces of all the handlers of these
attributes, I can assign a default radio_idx (-1) to all the APIs. Can I go
ahead implementing this?

- Roopni.

