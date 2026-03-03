Return-Path: <linux-wireless+bounces-32388-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CHoF7bLpmk0TwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32388-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 12:53:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DF51EEAB4
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 12:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFFAD3194B5D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 11:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B353A42315F;
	Tue,  3 Mar 2026 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UoBs1ZIa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nehq9cgK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD813E558E
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538078; cv=none; b=U++GiJhgj7XGJnl/5DMw0PtwNBIbDMXwTGyAMln/37BOp2WjrJLHbv5YLSYzVWr8JVR32fH+l1HDoQv2iGBdFdAX58p+qsDv2CdfWiYyawPN5o/Avaxk0pTJJWZOzq19dMoO0MoX7zRDJv2itVtjGPSbBnnf+1Xfa8AgdWwaqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538078; c=relaxed/simple;
	bh=ffjsi9LksuZDEc//JlkyicRZOcFj7zK4z58pIw27x+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njO1E/inmhNn1Pc4kUvUwoZiXiaI/Ad2B6S8Udueft4GHgUEwG0ySRDINLLcAHYtuqLZ0n3DjhQ56+QJ0bL/F1hb18VsbFgbqYfGtAtFku1prVmDMVynRTX3YTIO3HT7RWDA7NpC6SUhj2R3ulKOjyYWSfwQhFaWbsFf1HgQqLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UoBs1ZIa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nehq9cgK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239mj1V3951819
	for <linux-wireless@vger.kernel.org>; Tue, 3 Mar 2026 11:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z6ejIrhnkmBxeXgP4qlqYRb+DTKJ7qhF+lynUJ8Yzqc=; b=UoBs1ZIaCSEl4Fod
	hMoTwS8YqtXW3lPdKQxcphpSWz1MK03zvMZHMCV1wX4jRaymIfTdhB77RopVQhIS
	mHHjE0PjRoqvsVh2l55Rq72eqvBCU5BiwAlhocU6yngLP4rnfK11F3SqU51pMHW/
	Ffg/92frhbZts2MWRN3AJCt/Qux1yesy8i7a2dFX12sJLheQ0WbCM1b5UvcosKm1
	OAhhdmGydt3M8zm612RsKlV77KjRdujq1Jt77xkr2/mGnthTgjWdDnX3GrVIjppI
	+ZgzqbP5pB8/I76itWCQpc/6A9unyFKBwD4F43TwF32R3mFMMC5P7VBWuqlrdrQc
	Qhpw/w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnu3n8uht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 11:41:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae59e057f1so19731235ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 03:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772538075; x=1773142875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z6ejIrhnkmBxeXgP4qlqYRb+DTKJ7qhF+lynUJ8Yzqc=;
        b=Nehq9cgKhUfFBayOKmlSE6DP1eCdJ1zr0O0n6BjHyhEw4MibEwwL2gmRZCWN6YZwAJ
         A+uquSRHhIbZGbytuVOLyxFy5ix3f2En03/Vvw1Cwb6DofzAGZF3jsnTGio41w3YgRw0
         4QEovTkJGu6GIsEC3QhqFUirWiQqf/BXEJOo/9n0Hu+nSkv5Kde6Yplx4aaJvDUwrZad
         V0ic++QN57qXRhDS65mNMItOIOoXvv+c/bz6b8uSxvNHgyC7cHFqoXRMAullBkZ4ePvM
         aKmDW7F2AAB4yVGFSCtEayNqeXL/ornT00mGgMm0tjw2WRkyCwrQZvf9qLk3u1NoUDxa
         UDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772538075; x=1773142875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6ejIrhnkmBxeXgP4qlqYRb+DTKJ7qhF+lynUJ8Yzqc=;
        b=RsUxGlLax24gbe6Ngl13jCKusM/6NeCcoIy2x3utRtimqiiScmV0x1X0u8Klk+JrRH
         +QkBl1okX08Kt8AQc8Mcru/s2R0ZQ5ATBkpNLOlUtS44ix26tRDpYMyJtoKR2i5lcflJ
         4fJRjKGIfO2ImFQ2jqY/FiQwVJjdWTWKQZbtn+obY9ZZOjbP42vid4b9aRCkuKFCv+7V
         zSosIz0b1Merh8cxHoOHq9fpnGn0PJqwtPYmS2IatAtSxYQAJ2zy+PyDi7z8ojBx54bf
         z+VL+wrRw6TfOi+EqW4Rrt1MSqAvVosVe/3xvqj+gd0OayW5cYBwDl1gqmjedYaoXlE/
         Vmhw==
X-Gm-Message-State: AOJu0YzQuT0Y07ioax/NRx27W+6Q2wp9i/dokKiGi2NCsJ/9Ff0zMqT1
	JOs1mGuzaUJq7uFbTpCuWbRNDXBnaVK/ZbQboNuUDvTZ5A9Itc1QzgCrbuYYdcPI20SC/jfhJGt
	Qz5Lg+mOYewHYxW1+AU6JDlBbUUfBK3vPCtEbB9Z/F/fefz+KBVDIzzoK8hRXWdnfi81o0Q==
X-Gm-Gg: ATEYQzzi1IfXnynbSKBJSq4JDK/vzOcgWHmGu5AI+S4OwFZ14b6C4srj2iSClOKrzt8
	MTc0lZAzvi3gJT/XPgwpWk4+G0QknSXsIfLlkb5pLdo9TxLCL6Z6ymWHY/K51JalaZz8Wch3NBU
	UYNRRA2K8F0Hch/7eEf9cwOHEMSAAuk3N+frBmTr/hl3paNMKfmDN2G66QAIPltZcgpxbr7drCF
	KU+bHIQ1LY9b4KWAslVMSYCDai92nrFkMpL25WMHuFmKQCYFxEIqGPNt6DJufDRX2GxhvafB9/h
	SKbngrOhsaAkFhJVoresTGxbjsv9G7jtCFEd6Ra9O+TvG2aZEb8AGkj1ZvcQB7WiveLYcGj1cIj
	OjU6X864aVG8/Ujl3KeoQIp8ekDb2l0HIsfoo+kUhcHR3IFa8Oa2U9/9encsgQ3Q=
X-Received: by 2002:a17:902:da8f:b0:2a1:388d:8ef3 with SMTP id d9443c01a7336-2ae2e401d21mr164027495ad.18.1772538075086;
        Tue, 03 Mar 2026 03:41:15 -0800 (PST)
X-Received: by 2002:a17:902:da8f:b0:2a1:388d:8ef3 with SMTP id d9443c01a7336-2ae2e401d21mr164027365ad.18.1772538074573;
        Tue, 03 Mar 2026 03:41:14 -0800 (PST)
Received: from [10.152.199.53] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f996sm162429675ad.50.2026.03.03.03.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 03:41:13 -0800 (PST)
Message-ID: <a882918a-0d6f-4eac-ada9-5d4bd748b33c@oss.qualcomm.com>
Date: Tue, 3 Mar 2026 17:11:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v4 2/2] wifi: mac80211_hwsim: Add UHR
 capabilities to the driver
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260217054731.3667600-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <20260217054731.3667600-3-karthikeyan.kathirvel@oss.qualcomm.com>
 <d52fdbe5d9a483b5746b7253b512958d1460a9a1.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <d52fdbe5d9a483b5746b7253b512958d1460a9a1.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JaexbEKV c=1 sm=1 tr=0 ts=69a6c8dc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=oJrowrCMtk5DI0Br3tgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 5Mj2Zyj-tPRf6N80uGIMmqoWBGbr2OCU
X-Proofpoint-GUID: 5Mj2Zyj-tPRf6N80uGIMmqoWBGbr2OCU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA5MCBTYWx0ZWRfX3cx0M6SdO266
 n3zICiIDf2P5XDp+sz0H2WG8gb5zwWHWPtCCQyN+Tw/TovULEXs0O6Aved8GhudrjtldpTTAjU9
 VIHmn0ENhnpgXkj9qHwNJdtfZUA3V/I+adLUGoBHXWrHczG2MGJlbUNdZWEOE4qyS6fySlPcAUk
 1foYi3Pn9bkhrHGeQ82FxbRC/ZHv8P5Xh/Uccs8u4eD+bhZ5ei8mp7G3GCS91wBcJghjpIPwYHf
 ZmLlS9Iu7+jOJsWG6/GbguMaOZJOaRpZI8YTf1nU4E73d9GgQhoCrgmI4ofmnshpGSsl5m9Qw1f
 qyw1ReHZYMOVfZTV7M3BcKk3NoVejL4XMpd0gA5hObXarvz/mhnUepq6x5Z2wm7vzUobrQ/d3yV
 Tv1OxbwRMcUxzThzk9HgFjpFt77F366HGoSoAZN/zxiyJnoA4Lg/F+Ft6D3Vw1o7rzvf/haWRf1
 Q43tAB0im5oGJ0Vb/Sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030090
X-Rspamd-Queue-Id: C7DF51EEAB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32388-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 2/24/2026 9:50 PM, Johannes Berg wrote:
> On Tue, 2026-02-17 at 11:17 +0530, Karthikeyan Kathirvel wrote:
>>
>> +		.uhr_cap = {
>> +			.has_uhr = true,
>> +			.mac = {
>> +				.mac_cap[0] =
>> +					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
>> +					IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP |
> 
> I'm really not sure we should claim all of this, e.g. DPS assist, right
> now.
> 
> Also, I think you really mixed this up - a regular AP shouldn't claim
> DPS below (only mobile AP), but this here station should probably not
> normally claim DPS assist?
> 
> Just as examples! There are other issues like this such as:
> 
>> +					IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP |
> 
> I don't think the station should claim AP PUO support.
> 
> Certainly not an exhaustive list, ELR also seems wrong, etc.
> 
> johannes

Got it. It looks like this requires a deeper feature-level understanding 
or a review of the full spec document for each feature. Instead, I used 
AI to simplify this. Below, I’ve pasted the AI output, categorized by 
AP/non-AP STA and by bands. Is this approach fine? Shall I go ahead and 
make the changes based on this?

   ### UHR MAC capabilities

   |              Macro              |         Role tag      | Band tag |
   |---------------------------------|-----------------------|----------|
   | IEEE80211_UHR_MAC_CAP0_DPS_SUPP | Both (AP + non‑AP STA) | All |
   | IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP | Both | All |
   | IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP | Mobile AP only 
(reserved for non‑AP STA) | All |
   | IEEE80211_UHR_MAC_CAP0_NPCA_SUPP | Both | All |
   | IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP | Both (requires +HTC-HE=1) | All |
   | IEEE80211_UHR_MAC_CAP0_ADD_MAP_TID_SUPP | Both (conditional; EHT 
SCS Traffic Description Support) | All |
   | IEEE80211_UHR_MAC_CAP0_EOTSP_SUPP | Both | All |
   | IEEE80211_UHR_MAC_CAP1_DSO_SUPP | Both | All |
   | IEEE80211_UHR_MAC_CAP1_PEDCA_SUPP | Both | All |
   | IEEE80211_UHR_MAC_CAP1_DBE_SUPP | Both | All |
   | IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPP | Both | All |
   | IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPP | Both | All |
   | IEEE80211_UHR_MAC_CAP1_PUO_SUPP | Both (different meaning AP vs 
STA) | All |
   | IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP | Both (different meaning AP vs 
STA) | All |
   | IEEE80211_UHR_MAC_CAP1_DUO_SUPP | Both (different meaning AP vs 
STA) | All |
   | IEEE80211_UHR_MAC_CAP2_OMC_UL_MU_DIS_RX_SUPP | AP-only (reserved 
for non‑AP STA) | All |
   | IEEE80211_UHR_MAC_CAP2_AOM_SUPP | Both | All |
   | IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP | Both | All |
   | IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP | non‑AP STA only (reserved for 
AP; requires +HTC-HE=1) | All |
   | IEEE80211_UHR_MAC_CAP2_TXSPG_SUPP | Both | All |
   | IEEE80211_UHR_MAC_CAP2_TXOP_RET_IN_TXSPG | Both | All |
   | IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW | Both | All |
   | IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH | Both | All |
   | IEEE80211_UHR_MAC_CAP3_PARAM_UPD_ADV_NOTIF_INTV | AP-only (reserved 
for non‑AP STA) | All |
   | IEEE80211_UHR_MAC_CAP3_UPD_IND_TIM_INTV_LOW | AP-only (reserved for 
non‑AP STA) | All |
   | IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTV_HIGH | AP-only (reserved 
for non‑AP STA) | All |
   | IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS | AP-only | All |
   | IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE | AP-only | All |
   | IEEE80211_UHR_MAC_CAP4_CO_BF_SUPP | Both | All |

   ### UHR PHY capabilities

   |              Macro              |         Role tag      | Band tag |
   |---------------------------------|-----------------------|----------|
   | IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80 | Both | All (≤80) |
   | IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80 | non‑AP STA only 
(reserved for AP) | All (≤80) |
   | IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_160 | Both | 5/6 (160) |
   | IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_160 | non‑AP STA only 
(reserved for AP) | 5/6 (160) |
   | IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_320 | Both | 6 (320) |
   | IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_320 | non‑AP STA only 
(reserved for AP) | 6 (320) |
   | IEEE80211_UHR_PHY_CAP_ELR_RX | Both | All |
   | IEEE80211_UHR_PHY_CAP_ELR_TX | Both | All |


/KK

