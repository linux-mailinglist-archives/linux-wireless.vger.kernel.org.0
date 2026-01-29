Return-Path: <linux-wireless+bounces-31334-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLu0OmyOe2kKGAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31334-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 17:44:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19239B2602
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 17:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF6E4300AC01
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 16:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D07B336ED2;
	Thu, 29 Jan 2026 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TYUn9SWL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eE2Jn61f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0367C28934F
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705046; cv=none; b=Y6dujh5225zQxS0d/6xMGuQrfEz92/A4LfvN9s5EeqpjFThDlobBaKxJJY2v28ZZ179KU5izCmAtmCu/EU4E0eD4YHZ3A5R7CDMVLRP6cxdD2Tn7VzbSX+T7pOZhyyPmS8Jyv1uTsvUbgBamjKvU0IdDjBE9FyYdHUgHOyIRrOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705046; c=relaxed/simple;
	bh=gqC0B1aZ9pG43Ku8+7PLU5bYcreHZGJwbl7ifdByDm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9Q2ZOjUt7kuvkl6HduJP9JaM0VSZObGqUnGmWzjcLE/PBOAJeypYk2im6d1MfoLx+nfuZ4Y0LVoFDnwd/TKM+xjMVFQ/2FjOqRT8HEi7beqaedqt/s5/2iQxYhAN/ZYADdAF3NynjeYU5IQgtrcW2ZZIbYaDsJ2ChQ1bJehWWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TYUn9SWL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eE2Jn61f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TASNLA2061110
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 16:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RgIHcvt+O7j+/d21SltGTzaL/Tp1PIAfMG/raoD2GUk=; b=TYUn9SWLuXwRvJQC
	NxusyPWK1ax87PRqkDYK6XCuDGKNLo6dusTaNDEQ7qcoqs9O3s9Rhacj9REM1PV4
	k4tk3noS7NhR0X8Pq8q6mcIIirXrsnee1aGfYsP/62VZhR1WU1MyXbwxRG63ZgXG
	YcdobrncaklVO43kmX0GQa+o1mWlwJFJC6BI0fQGCCBVu4zk2thZviLm7hW1iITU
	4eySFYTK7iXiP0AjvIUp1+eGNat/C24IFRhjYue3agd/YbrmO9IOMKlZ44JPGVzC
	yYX4h3ruM8ZqlQF9I1P5I4Ku+QoKqNccBMYN1gxgr9Ccw79hDefYdH2XGq+/1GTe
	vhaO3A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bypgrma3s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 16:44:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81f53036ac9so1068654b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 08:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769705042; x=1770309842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RgIHcvt+O7j+/d21SltGTzaL/Tp1PIAfMG/raoD2GUk=;
        b=eE2Jn61fdpKy5yHt9cxmwhqrxHPqhTvaSAtPsmIhtCWnPmicMHLa+U8uwg7N4uFWda
         0v+HYO0nE7Xp5b77cov3vdc427CgnYidnOP5KUeuYDHoNXjWhS/72vffpgjr/pW2pDT5
         xarS4povN7M7mGC9/8iPYtgjVYoIdFAHplm/lrk+5fnS+A/OjI3J2/s3rsvEqhEmxovu
         N3/BfGDyGZZotw0+OPJ3KdHKkIhEBE7/sgwms6rKiE2i4jeCVx2yshBcoffqY2uUDboE
         1MXrCaOPgWxSrNiLeumV7sjDVdgFEH+xcOCCCacuKbaY/7I1sG71PxhL4cro6aOOMEcs
         ONYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769705042; x=1770309842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgIHcvt+O7j+/d21SltGTzaL/Tp1PIAfMG/raoD2GUk=;
        b=U0cyIyJ/HlpH8JAPf46nmwIC5AwGj0CMW7wHFqLsyA4lsNQ2BA/tjhs6cB5WUiGORa
         dV9WeTr5sD2i9Miu/i64IDOCVcJohguU78u6ABnUz6xUztxovDQG6JibO94RUqVArNZx
         /HcckurcrZMAOtTtxrks+1k2SW7v1yV7GqxHpNcnzo6Nbj52Vu8jLAlPcTJKkxlK/Cn6
         s+4nn0u8ovUvu86NKkA9rNNY3wK2gGDIpONGBdDJiiKOvbOJFnoqs7D/gNLoAhCiDANj
         ogA49WLqmQZ5HCPh7ZRItsox6rFwrqAIb/XjJwygAoKAs6doSoZWCLCgrUpknrCsno0G
         Sq/A==
X-Forwarded-Encrypted: i=1; AJvYcCWtDYGNUaGzsqtTlZNEFJaOkxng1F8SyJtBJoK1SQywSB5kT4y9TJ6neCmGnnjuWJmHPfs6cN2lGPQqD6Yr0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+bFV63Y7B9wy/flNZSFzKT0l3zP3M68K2EX/eEd+0I7JVcXfS
	inWlrWAqqXUnT9k5waaIOPFmrfU5I+l/lEOVC+VMobyqQ0TdaA1c0gO0Yq/osuteDJ0+PP1wLPI
	DLlUBgv6TKQ/m6b/mrdJYZ/WA7kYquucNBoxTwNoWlvsUmQb61HISxhQgwN8XIxHexKeGSQ==
X-Gm-Gg: AZuq6aKE18xi59vKgNkNkaRVTbjgT4+gh7B9Mqaw39K4ieu6HnIT0wgdNqvrCQJ8ZMU
	1dZ7rO80D10SPtLwhpt/eUFyfL9mYGUHrDQ7DA6D84K+wYx3YQZwTFmdkvfLee8Zef4BgGsUPkp
	WdsqJ8jJ/CpaYLiCtsXTw7j0X1R2LE/yUdnF7TG9T7V5lB4aThXwujmdh3RXlpJTEjzKWwLcGFP
	jbUICJ5e+ASxUW9r+q7V0DTFmdLFNf1wfR6GXy8dguhOF3U4N7VkPBqbjkvgkop2nR/Ka4P9KHz
	+J0LGY1cXW9MUM7dJPkd2KaeuMmXTMcyf+hP2lnXYFgaoimwpcjMyPMyNUdJ75+0AAiHJmHOZbA
	Dh4TxFo5l1qAIiaNt8GprOAkZwJ4E9H3HGPbOy6IK/FjXbgYLQJJ+NsGm/uP1M4cwhUHc3WtP7l
	gTqdSRuQozy0+Pcv10qg/BprVc/DA5jC/kQe3UZg==
X-Received: by 2002:a05:6a00:1a92:b0:821:8492:7f66 with SMTP id d2e1a72fcca58-8236917f60bmr9374667b3a.22.1769705041788;
        Thu, 29 Jan 2026 08:44:01 -0800 (PST)
X-Received: by 2002:a05:6a00:1a92:b0:821:8492:7f66 with SMTP id d2e1a72fcca58-8236917f60bmr9374627b3a.22.1769705040958;
        Thu, 29 Jan 2026 08:44:00 -0800 (PST)
Received: from [10.50.27.148] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b19a9esm7043131b3a.11.2026.01.29.08.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 08:44:00 -0800 (PST)
Message-ID: <104f3cd9-581c-402e-b4c3-898f1deaef5b@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 22:13:57 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v5 3/3] wifi: mac80211: add initial UHR
 support
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260129092039.53d7f326bc8f.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
 <20260129092039.09be5776db3d.Ieec940b58dbf8115dab7e1e24cb5513f52c8cb2f@changeid>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <20260129092039.09be5776db3d.Ieec940b58dbf8115dab7e1e24cb5513f52c8cb2f@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=d7T4CBjE c=1 sm=1 tr=0 ts=697b8e53 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=stkexhm8AAAA:8 a=PIgmARLQAAAA:8
 a=8uO-BwtZAAAA:8 a=skU_J7KqAAAA:8 a=QgXLxvvarrpEZ4cNW1EA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=pIW3pCRaVxJDc-hWtpF8:22 a=gmoW3VEtnuKblUSCmhOl:22
 a=UmM1XOiemSxannmj3pYQ:22 a=b6CkM2rtsW-bHoL29FmJ:22
X-Proofpoint-GUID: MeFFw1EtPoGbloYYoif41VPDC7_4n6bU
X-Proofpoint-ORIG-GUID: MeFFw1EtPoGbloYYoif41VPDC7_4n6bU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDExNSBTYWx0ZWRfXxrIc877ZgmSl
 pimexFC5ccC5cd86vbsbC5OoToBhSIrqGhbAtcVUmLmnVH4RnfWslRHZyTgTudPTG7Vi8AsanZt
 mPMTHCZ1hRTs0Aw78V+Nnf5MQH9DeliaYEQj6eNWCs2pI+S6tiBr8RWyFKBPiI6f/qr+yP2Tr7W
 lB1+Z3qkMpqyUXnonJqqKqBv6fRASJ+2ZQEcsBNo9678McNfT+XMg1uQYH/bgoEdqRX6XUTKQoW
 p7xhfulTfXL/75WQVFzS+sTdzsImJI9irTjyhWfBtVHVZJtUasGEJafVWY84yXyL7Dkxfnzz8b+
 bTvIiLHbnhHRqwqWqSe/wInK1fmRM44xZ05WMe+XsyUjWXaltrOD73169g5z8Ho/iB0u4KxuSqn
 RQAGbFVR/fP1fNnmV4brcXECJbeS7M7F4SbxZIzZ0fjj0lIUjikFsF+l4GfkxOG4C82//FVUSwR
 9G/fjx7SoWVAvlKnbYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290115
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31334-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 19239B2602
X-Rspamd-Action: no action



On 1/29/2026 1:50 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Add support for making UHR connections and accepting AP
> stations with UHR support.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v5:
>   - parse UHR capa as from AP
> v4:
>   - fix NPCA validation
> v3:
>   - use uhr_oper instead of removed uhr_capa
>   - fix indentation (Jeff Johnson)
> ---
>   include/net/mac80211.h     |  35 ++++++++++-
>   net/mac80211/Makefile      |   2 +-
>   net/mac80211/cfg.c         |  16 ++++-
>   net/mac80211/ieee80211_i.h |  19 +++++-
>   net/mac80211/main.c        |  15 ++++-
>   net/mac80211/mlme.c        | 117 ++++++++++++++++++++++++++++++++++---
>   net/mac80211/parse.c       |  22 ++++++-
>   net/mac80211/rx.c          |  26 +++++++++
>   net/mac80211/sta_info.c    |  13 ++++-
>   net/mac80211/sta_info.h    |  80 ++++++++++++++++++-------
>   net/mac80211/uhr.c         |  29 +++++++++
>   net/mac80211/util.c        |  36 +++++++++++-
>   12 files changed, 370 insertions(+), 40 deletions(-)
>   create mode 100644 net/mac80211/uhr.c
> 
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 36ae7fe9ddf3..7a55762f9af8 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -7,7 +7,7 @@
>    * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
>    * Copyright 2013-2014  Intel Mobile Communications GmbH
>    * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
> - * Copyright (C) 2018 - 2025 Intel Corporation
> + * Copyright (C) 2018 - 2026 Intel Corporation
>    */
>   
>   #ifndef MAC80211_H
> @@ -706,6 +706,7 @@ struct ieee80211_parsed_tpe {
>    * @pwr_reduction: power constraint of BSS.
>    * @eht_support: does this BSS support EHT
>    * @epcs_support: does this BSS support EPCS
> + * @uhr_support: does this BSS support UHR
>    * @csa_active: marks whether a channel switch is going on.
>    * @mu_mimo_owner: indicates interface owns MU-MIMO capability
>    * @chanctx_conf: The channel context this interface is assigned to, or %NULL
> @@ -832,6 +833,8 @@ struct ieee80211_bss_conf {
>   	u8 pwr_reduction;
>   	bool eht_support;
>   	bool epcs_support;
> +	bool uhr_support;
> +
>   	bool csa_active;
>   
>   	bool mu_mimo_owner;
> @@ -1598,6 +1601,7 @@ enum mac80211_rx_encoding {
>   	RX_ENC_VHT,
>   	RX_ENC_HE,
>   	RX_ENC_EHT,
> +	RX_ENC_UHR,
>   };
>   
>   /**
> @@ -1631,7 +1635,7 @@ enum mac80211_rx_encoding {
>    * @antenna: antenna used
>    * @rate_idx: index of data rate into band's supported rates or MCS index if
>    *	HT or VHT is used (%RX_FLAG_HT/%RX_FLAG_VHT)
> - * @nss: number of streams (VHT, HE and EHT only)
> + * @nss: number of streams (VHT, HE, EHT and UHR only)
>    * @flag: %RX_FLAG_\*
>    * @encoding: &enum mac80211_rx_encoding
>    * @bw: &enum rate_info_bw
> @@ -1642,6 +1646,11 @@ enum mac80211_rx_encoding {
>    * @eht: EHT specific rate information
>    * @eht.ru: EHT RU, from &enum nl80211_eht_ru_alloc
>    * @eht.gi: EHT GI, from &enum nl80211_eht_gi
> + * @uhr: UHR specific rate information
> + * @uhr.ru: UHR RU, from &enum nl80211_eht_ru_alloc
> + * @uhr.gi: UHR GI, from &enum nl80211_eht_gi
> + * @uhr.elr: UHR ELR MCS was used
> + * @uhr.im: UHR interference mitigation was used
>    * @rx_flags: internal RX flags for mac80211
>    * @ampdu_reference: A-MPDU reference number, must be a different value for
>    *	each A-MPDU but the same for each subframe within one A-MPDU
> @@ -1673,6 +1682,12 @@ struct ieee80211_rx_status {
>   			u8 ru:4;
>   			u8 gi:2;
>   		} eht;
> +		struct {
> +			u8 ru:4;
> +			u8 gi:2;
> +			u8 elr:1;
> +			u8 im:1;
> +		} uhr;
>   	};
>   	u8 rate_idx;
>   	u8 nss;
> @@ -2434,6 +2449,7 @@ struct ieee80211_sta_aggregates {
>    * @he_cap: HE capabilities of this STA
>    * @he_6ghz_capa: on 6 GHz, holds the HE 6 GHz band capabilities
>    * @eht_cap: EHT capabilities of this STA
> + * @uhr_cap: UHR capabilities of this STA
>    * @s1g_cap: S1G capabilities of this STA
>    * @agg: per-link data for multi-link aggregation
>    * @bandwidth: current bandwidth the station can receive with
> @@ -2457,6 +2473,7 @@ struct ieee80211_link_sta {
>   	struct ieee80211_sta_he_cap he_cap;
>   	struct ieee80211_he_6ghz_capa he_6ghz_capa;
>   	struct ieee80211_sta_eht_cap eht_cap;
> +	struct ieee80211_sta_uhr_cap uhr_cap;
>   	struct ieee80211_sta_s1g_cap s1g_cap;
>   
>   	struct ieee80211_sta_aggregates agg;
> @@ -7289,6 +7306,20 @@ ieee80211_get_eht_iftype_cap_vif(const struct ieee80211_supported_band *sband,
>   	return ieee80211_get_eht_iftype_cap(sband, ieee80211_vif_type_p2p(vif));
>   }
>   
> +/**
> + * ieee80211_get_uhr_iftype_cap_vif - return UHR capabilities for sband/vif
> + * @sband: the sband to search for the iftype on
> + * @vif: the vif to get the iftype from
> + *
> + * Return: pointer to the struct ieee80211_sta_uhr_cap, or %NULL is none found
> + */
> +static inline const struct ieee80211_sta_uhr_cap *
> +ieee80211_get_uhr_iftype_cap_vif(const struct ieee80211_supported_band *sband,
> +				 struct ieee80211_vif *vif)
> +{
> +	return ieee80211_get_uhr_iftype_cap(sband, ieee80211_vif_type_p2p(vif));
> +}
> +
>   /**
>    * ieee80211_update_mu_groups - set the VHT MU-MIMO groud data
>    *
> diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
> index a33884967f21..b0e392eb7753 100644
> --- a/net/mac80211/Makefile
> +++ b/net/mac80211/Makefile
> @@ -36,7 +36,7 @@ mac80211-y := \
>   	tdls.o \
>   	ocb.o \
>   	airtime.o \
> -	eht.o
> +	eht.o uhr.o
>   
>   mac80211-$(CONFIG_MAC80211_LEDS) += led.o
>   mac80211-$(CONFIG_MAC80211_DEBUGFS) += \
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 964f440e31cd..f83dda0755a7 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -5,7 +5,7 @@
>    * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
>    * Copyright 2013-2015  Intel Mobile Communications GmbH
>    * Copyright (C) 2015-2017 Intel Deutschland GmbH
> - * Copyright (C) 2018-2025 Intel Corporation
> + * Copyright (C) 2018-2026 Intel Corporation
>    */
>   
>   #include <linux/ieee80211.h>
> @@ -1608,6 +1608,13 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
>   		link_conf->eht_mu_beamformer = false;
>   	}
>   
> +	if (params->uhr_oper) {
> +		if (!link_conf->eht_support)
> +			return -EOPNOTSUPP;
> +
> +		link_conf->uhr_support = true;
> +	}
> +
>   	if (sdata->vif.type == NL80211_IFTYPE_AP &&
>   	    params->mbssid_config.tx_wdev) {
>   		err = ieee80211_set_ap_mbssid_options(sdata,
> @@ -2085,6 +2092,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
>   		       params->vht_capa ||
>   		       params->he_capa ||
>   		       params->eht_capa ||
> +		       params->uhr_capa ||
>   		       params->s1g_capa ||
>   		       params->opmode_notif_used;
>   
> @@ -2163,6 +2171,12 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
>   						    params->eht_capa_len,
>   						    link_sta);
>   
> +	if (params->uhr_capa)
> +		ieee80211_uhr_cap_ie_to_sta_uhr_cap(sdata, sband,
> +						    params->uhr_capa,
> +						    params->uhr_capa_len,
> +						    link_sta);
> +
>   	if (params->s1g_capa)
>   		ieee80211_s1g_cap_to_sta_s1g_cap(sdata, params->s1g_capa,
>   						 link_sta);
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index dc757cb32974..b5e774ea6b07 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -5,7 +5,7 @@
>    * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
>    * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
>    * Copyright 2013-2015  Intel Mobile Communications GmbH
> - * Copyright (C) 2018-2025 Intel Corporation
> + * Copyright (C) 2018-2026 Intel Corporation
>    */
>   
>   #ifndef IEEE80211_I_H
> @@ -394,9 +394,10 @@ enum ieee80211_conn_mode {
>   	IEEE80211_CONN_MODE_VHT,
>   	IEEE80211_CONN_MODE_HE,
>   	IEEE80211_CONN_MODE_EHT,
> +	IEEE80211_CONN_MODE_UHR,
>   };
>   
> -#define IEEE80211_CONN_MODE_HIGHEST	IEEE80211_CONN_MODE_EHT
> +#define IEEE80211_CONN_MODE_HIGHEST	IEEE80211_CONN_MODE_UHR
>   
>   enum ieee80211_conn_bw_limit {
>   	IEEE80211_CONN_BW_LIMIT_20,
> @@ -1826,6 +1827,8 @@ struct ieee802_11_elems {
>   	const struct ieee80211_multi_link_elem *ml_epcs;
>   	const struct ieee80211_bandwidth_indication *bandwidth_indication;
>   	const struct ieee80211_ttlm_elem *ttlm[IEEE80211_TTLM_MAX_CNT];
> +	const struct ieee80211_uhr_capa *uhr_capa;
> +	const struct ieee80211_uhr_oper *uhr_oper;
>   
>   	/* not the order in the psd values is per element, not per chandef */
>   	struct ieee80211_parsed_tpe tpe;
> @@ -1850,6 +1853,8 @@ struct ieee802_11_elems {
>   	u8 country_elem_len;
>   	u8 bssid_index_len;
>   	u8 eht_cap_len;
> +	u8 uhr_capa_len;
> +	u8 uhr_oper_len;
>   
>   	/* mult-link element can be de-fragmented and thus u8 is not sufficient */
>   	size_t ml_basic_len;
> @@ -2693,6 +2698,9 @@ int ieee80211_put_eht_cap(struct sk_buff *skb,
>   			  struct ieee80211_sub_if_data *sdata,
>   			  const struct ieee80211_supported_band *sband,
>   			  const struct ieee80211_conn_settings *conn);
> +int ieee80211_put_uhr_cap(struct sk_buff *skb,
> +			  struct ieee80211_sub_if_data *sdata,
> +			  const struct ieee80211_supported_band *sband);
>   int ieee80211_put_reg_conn(struct sk_buff *skb,
>   			   enum ieee80211_channel_flags flags);
>   
> @@ -2868,6 +2876,13 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
>   				      struct ieee80211_mgmt *mgmt, size_t len);
>   void ieee80211_stop_mbssid(struct ieee80211_sub_if_data *sdata);
>   
> +void
> +ieee80211_uhr_cap_ie_to_sta_uhr_cap(struct ieee80211_sub_if_data *sdata,
> +				    struct ieee80211_supported_band *sband,
> +				    const struct ieee80211_uhr_capa *uhr_capa,
> +				    u8 uhr_capa_len,
> +				    struct link_sta_info *link_sta);
> +
>   #if IS_ENABLED(CONFIG_MAC80211_KUNIT_TEST)
>   #define EXPORT_SYMBOL_IF_MAC80211_KUNIT(sym) EXPORT_SYMBOL_IF_KUNIT(sym)
>   #define VISIBLE_IF_MAC80211_KUNIT
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index b05e313c7f17..486a0bf3c0de 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -5,7 +5,7 @@
>    * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
>    * Copyright 2013-2014  Intel Mobile Communications GmbH
>    * Copyright (C) 2017     Intel Deutschland GmbH
> - * Copyright (C) 2018-2025 Intel Corporation
> + * Copyright (C) 2018-2026 Intel Corporation
>    */
>   
>   #include <net/mac80211.h>
> @@ -1123,7 +1123,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>   	int result, i;
>   	enum nl80211_band band;
>   	int channels, max_bitrates;
> -	bool supp_ht, supp_vht, supp_he, supp_eht, supp_s1g;
> +	bool supp_ht, supp_vht, supp_he, supp_eht, supp_s1g, supp_uhr;
>   	struct cfg80211_chan_def dflt_chandef = {};
>   
>   	if (ieee80211_hw_check(hw, QUEUE_CONTROL) &&
> @@ -1237,6 +1237,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>   	supp_he = false;
>   	supp_eht = false;
>   	supp_s1g = false;
> +	supp_uhr = false;
>   	for (band = 0; band < NUM_NL80211_BANDS; band++) {
>   		const struct ieee80211_sband_iftype_data *iftd;
>   		struct ieee80211_supported_band *sband;
> @@ -1293,6 +1294,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>   
>   			supp_he = supp_he || iftd->he_cap.has_he;
>   			supp_eht = supp_eht || iftd->eht_cap.has_eht;
> +			supp_uhr = supp_uhr || iftd->uhr_cap.has_uhr;
>   
>   			if (band == NL80211_BAND_2GHZ)
>   				he_40_mhz_cap =
> @@ -1325,6 +1327,10 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>   		if (WARN_ON(supp_eht && !supp_he))
>   			return -EINVAL;
>   
> +		/* UHR requires EHT support */
> +		if (WARN_ON(supp_uhr && !supp_eht))
> +			return -EINVAL;
> +
>   		if (!sband->ht_cap.ht_supported)
>   			continue;
>   
> @@ -1437,6 +1443,11 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>   				IEEE80211_EHT_PPE_THRES_MAX_LEN;
>   	}
>   
> +	if (supp_uhr)
> +		local->scan_ies_len +=
> +			3 + sizeof(struct ieee80211_uhr_capa) +
> +			sizeof(struct ieee80211_uhr_capa_phy);
> +
>   	if (!local->ops->hw_scan) {
>   		/* For hw_scan, driver needs to set these up. */
>   		local->hw.wiphy->max_scan_ssids = 4;
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 6e468c4fcda2..df170556825f 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -8,7 +8,7 @@
>    * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
>    * Copyright 2013-2014  Intel Mobile Communications GmbH
>    * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
> - * Copyright (C) 2018 - 2025 Intel Corporation
> + * Copyright (C) 2018 - 2026 Intel Corporation
>    */
>   
>   #include <linux/delay.h>
> @@ -162,6 +162,7 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
>   	const struct ieee80211_vht_operation *vht_oper = elems->vht_operation;
>   	const struct ieee80211_he_operation *he_oper = elems->he_operation;
>   	const struct ieee80211_eht_operation *eht_oper = elems->eht_operation;
> +	const struct ieee80211_uhr_oper *uhr_oper = elems->uhr_oper;
>   	struct ieee80211_supported_band *sband =
>   		sdata->local->hw.wiphy->bands[channel->band];
>   	struct cfg80211_chan_def vht_chandef;
> @@ -192,7 +193,7 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
>   
>   	/* get special 6 GHz case out of the way */
>   	if (sband->band == NL80211_BAND_6GHZ) {
> -		enum ieee80211_conn_mode mode = IEEE80211_CONN_MODE_EHT;
> +		enum ieee80211_conn_mode mode = IEEE80211_CONN_MODE_HIGHEST;
>   
>   		/* this is an error */
>   		if (conn->mode < IEEE80211_CONN_MODE_HE)
> @@ -215,7 +216,9 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
>   			return IEEE80211_CONN_MODE_LEGACY;
>   		}
>   
> -		return mode;
> +		if (mode <= IEEE80211_CONN_MODE_EHT)
> +			return mode;
> +		goto check_uhr;
>   	}
>   
>   	/* now we have the progression HT, VHT, ... */
> @@ -340,7 +343,63 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
>   		*chandef = eht_chandef;
>   	}
>   
> -	return IEEE80211_CONN_MODE_EHT;
> +check_uhr:
> +	if (conn->mode < IEEE80211_CONN_MODE_UHR || !uhr_oper)
> +		return IEEE80211_CONN_MODE_EHT;
> +
> +	/*
> +	 * In beacons we don't have all the data - but we know the size was OK,
> +	 * so if the size is valid as a non-beacon case, we have more data and
> +	 * can validate the NPCA parameters.
> +	 */
> +	if (ieee80211_uhr_oper_size_ok((const void *)uhr_oper,
> +				       elems->uhr_oper_len,
> +				       false)) {
> +		struct cfg80211_chan_def npca_chandef = *chandef;
> +		const struct ieee80211_uhr_npca_info *npca;
> +		const __le16 *dis_subch_bmap;
> +		u16 punct = chandef->punctured, npca_punct;
> +
> +		npca = ieee80211_uhr_npca_info(uhr_oper);
> +		if (npca) {
> +			int width = cfg80211_chandef_get_width(chandef);
> +			u8 offs = le32_get_bits(npca->params,
> +						IEEE80211_UHR_NPCA_PARAMS_PRIMARY_CHAN_OFFS);
> +			u32 cf1 = chandef->center_freq1;
> +			bool pri_upper, npca_upper;
> +
> +			pri_upper = chandef->chan->center_freq > cf1;
> +			npca_upper = 20 * offs >= width / 2;
> +
> +			if (20 * offs >= cfg80211_chandef_get_width(chandef) ||
> +			    pri_upper == npca_upper) {
> +				sdata_info(sdata,
> +					   "AP UHR NPCA primary channel invalid, disabling UHR\n");
> +				return IEEE80211_CONN_MODE_EHT;
> +			}
> +		}
> +
> +		dis_subch_bmap = ieee80211_uhr_npca_dis_subch_bitmap(uhr_oper);
> +
> +		if (dis_subch_bmap) {
> +			npca_punct = get_unaligned_le16(dis_subch_bmap);
> +			npca_chandef.punctured = npca_punct;
> +		}
> +
> +		/*
> +		 * must be a valid puncturing pattern for this channel as
> +		 * well as puncturing all subchannels that are already in
> +		 * the disabled subchannel bitmap on the primary channel
> +		 */
> +		if (!cfg80211_chandef_valid(&npca_chandef) ||
> +		    ((punct & npca_punct) != punct)) {
> +			sdata_info(sdata,
> +				   "AP UHR NPCA disabled subchannel bitmap invalid, disabling UHR\n");
> +			return IEEE80211_CONN_MODE_EHT;
> +		}
> +	}
> +
> +	return IEEE80211_CONN_MODE_UHR;
>   }
>   
>   static bool
> @@ -1091,6 +1150,7 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
>   				       IEEE80211_CONN_BW_LIMIT_160);
>   		break;
>   	case IEEE80211_CONN_MODE_EHT:
> +	case IEEE80211_CONN_MODE_UHR:
>   		conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
>   				       conn->bw_limit,
>   				       IEEE80211_CONN_BW_LIMIT_320);
> @@ -1108,6 +1168,8 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
>   		set_bit(BSS_MEMBERSHIP_SELECTOR_HE_PHY, sta_selectors);
>   	if (conn->mode >= IEEE80211_CONN_MODE_EHT)
>   		set_bit(BSS_MEMBERSHIP_SELECTOR_EHT_PHY, sta_selectors);
> +	if (conn->mode >= IEEE80211_CONN_MODE_UHR)
> +		set_bit(BSS_MEMBERSHIP_SELECTOR_UHR_PHY, sta_selectors);
>   
>   	/*
>   	 * We do not support EPD or GLK so never add them.
> @@ -1155,6 +1217,11 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
>   				       IEEE80211_CONN_BW_LIMIT_160);
>   	}
>   
> +	if (conn->mode >= IEEE80211_CONN_MODE_UHR &&
> +	    !cfg80211_chandef_usable(sdata->wdev.wiphy, &chanreq->oper,
> +				     IEEE80211_CHAN_NO_UHR))
> +		conn->mode = IEEE80211_CONN_MODE_EHT;
> +
>   	if (chanreq->oper.width != ap_chandef->width || ap_mode != conn->mode)
>   		link_id_info(sdata, link_id,
>   			     "regulatory prevented using AP config, downgraded\n");
> @@ -1884,11 +1951,13 @@ ieee80211_add_link_elems(struct ieee80211_sub_if_data *sdata,
>   
>   	/*
>   	 * careful - need to know about all the present elems before
> -	 * calling ieee80211_assoc_add_ml_elem(), so add this one if
> -	 * we're going to put it after the ML element
> +	 * calling ieee80211_assoc_add_ml_elem(), so add these if
> +	 * we're going to put them after the ML element
>   	 */
>   	if (assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_EHT)
>   		ADD_PRESENT_EXT_ELEM(WLAN_EID_EXT_EHT_CAPABILITY);
> +	if (assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_UHR)
> +		ADD_PRESENT_EXT_ELEM(WLAN_EID_EXT_UHR_CAPA);
>   
>   	if (link_id == assoc_data->assoc_link_id)
>   		ieee80211_assoc_add_ml_elem(sdata, skb, orig_capab, ext_capa,
> @@ -1901,6 +1970,9 @@ ieee80211_add_link_elems(struct ieee80211_sub_if_data *sdata,
>   		ieee80211_put_eht_cap(skb, sdata, sband,
>   				      &assoc_data->link[link_id].conn);
>   
> +	if (assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_UHR)
> +		ieee80211_put_uhr_cap(skb, sdata, sband);
> +
>   	if (sband->band == NL80211_BAND_S1GHZ) {
>   		ieee80211_add_aid_request_ie(sdata, skb);
>   		ieee80211_add_s1g_capab_ie(sdata, &sband->s1g_cap, skb);
> @@ -2135,6 +2207,9 @@ ieee80211_link_common_elems_size(struct ieee80211_sub_if_data *sdata,
>   		sizeof(struct ieee80211_eht_mcs_nss_supp) +
>   		IEEE80211_EHT_PPE_THRES_MAX_LEN;
>   
> +	size += 2 + 1 + sizeof(struct ieee80211_uhr_capa) +
> +		sizeof(struct ieee80211_uhr_capa_phy);
> +
>   	return size;
>   }
>   
> @@ -5531,6 +5606,18 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
>   		bss_conf->epcs_support = false;
>   	}
>   
> +	if (elems->uhr_oper && elems->uhr_capa &&
> +	    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_UHR) {
> +		ieee80211_uhr_cap_ie_to_sta_uhr_cap(sdata, sband,
> +						    elems->uhr_capa,
> +						    elems->uhr_capa_len,
> +						    link_sta);
> +
> +		bss_conf->uhr_support = link_sta->pub->uhr_cap.has_uhr;
> +	} else {
> +		bss_conf->uhr_support = false;
> +	}
> +
>   	if (elems->s1g_oper &&
>   	    link->u.mgd.conn.mode == IEEE80211_CONN_MODE_S1G &&
>   	    elems->s1g_capab)
> @@ -5821,6 +5908,7 @@ ieee80211_determine_our_sta_mode(struct ieee80211_sub_if_data *sdata,
>   	bool is_6ghz = sband->band == NL80211_BAND_6GHZ;
>   	const struct ieee80211_sta_he_cap *he_cap;
>   	const struct ieee80211_sta_eht_cap *eht_cap;
> +	const struct ieee80211_sta_uhr_cap *uhr_cap;
>   	struct ieee80211_sta_vht_cap vht_cap;
>   
>   	if (sband->band == NL80211_BAND_S1GHZ) {
> @@ -5996,9 +6084,6 @@ ieee80211_determine_our_sta_mode(struct ieee80211_sub_if_data *sdata,
>   				 "no EHT support, limiting to HE\n");
>   		goto out;
>   	}
> -
> -	/* we have EHT */
> -
>   	conn->mode = IEEE80211_CONN_MODE_EHT;
>   
>   	/* check bandwidth */
> @@ -6009,6 +6094,20 @@ ieee80211_determine_our_sta_mode(struct ieee80211_sub_if_data *sdata,
>   		mlme_link_id_dbg(sdata, link_id,
>   				 "no EHT 320 MHz cap in 6 GHz, limiting to 160 MHz\n");
>   
> +	if (req && req->flags & ASSOC_REQ_DISABLE_UHR) {
> +		mlme_link_id_dbg(sdata, link_id,
> +				 "UHR disabled by flag, limiting to EHT\n");
> +		goto out;
> +	}
> +
> +	uhr_cap = ieee80211_get_uhr_iftype_cap_vif(sband, &sdata->vif);
> +	if (!uhr_cap) {
> +		mlme_link_id_dbg(sdata, link_id,
> +				 "no UHR support, limiting to EHT\n");
> +		goto out;
> +	}
> +	conn->mode = IEEE80211_CONN_MODE_UHR;
> +
>   out:
>   	mlme_link_id_dbg(sdata, link_id,
>   			 "determined local STA to be %s, BW limited to %d MHz\n",
> diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
> index 667021bc60c6..cb238600652a 100644
> --- a/net/mac80211/parse.c
> +++ b/net/mac80211/parse.c
> @@ -6,7 +6,7 @@
>    * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
>    * Copyright 2013-2014  Intel Mobile Communications GmbH
>    * Copyright (C) 2015-2017	Intel Deutschland GmbH
> - * Copyright (C) 2018-2025 Intel Corporation
> + * Copyright (C) 2018-2026 Intel Corporation
>    *
>    * element parsing for mac80211
>    */
> @@ -189,6 +189,26 @@ ieee80211_parse_extension_element(u32 *crc,
>   			elems->ttlm_num++;
>   		}
>   		break;
> +	case WLAN_EID_EXT_UHR_OPER:
> +		if (params->mode < IEEE80211_CONN_MODE_UHR)
> +			break;
> +		calc_crc = true;
> +		if (ieee80211_uhr_oper_size_ok(data, len,
> +					       params->type == (IEEE80211_FTYPE_MGMT |
> +								IEEE80211_STYPE_BEACON))) {
> +			elems->uhr_oper = data;
> +			elems->uhr_oper_len = len;
> +		}
> +		break;
> +	case WLAN_EID_EXT_UHR_CAPA:
> +		if (params->mode < IEEE80211_CONN_MODE_UHR)
> +			break;
> +		calc_crc = true;
> +		if (ieee80211_uhr_capa_size_ok(data, len, true)) {

here it should be false isn't it ? since here UHR cap processed for STA

> +			elems->uhr_capa = data;
> +			elems->uhr_capa_len = len;
> +		}
> +		break;
>   	}
>   
>   	if (crc && calc_crc)
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index 30b9b4d76357..69034d83a7b6 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -5518,6 +5518,32 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
>   				      status->rate_idx, status->nss, status->eht.gi))
>   				goto drop;
>   			break;
> +		case RX_ENC_UHR:
> +			if (WARN_ONCE(!(status->rate_idx <= 15 ||
> +					status->rate_idx == 17 ||
> +					status->rate_idx == 19 ||
> +					status->rate_idx == 20 ||
> +					status->rate_idx == 23) ||
> +				      !status->nss ||
> +				      status->nss > 8 ||
> +				      status->uhr.gi > NL80211_RATE_INFO_EHT_GI_3_2,
> +				      "Rate marked as a UHR rate but data is invalid: MCS:%d, NSS:%d, GI:%d\n",
> +				      status->rate_idx, status->nss, status->uhr.gi))
> +				goto drop;
> +			if (WARN_ONCE(status->uhr.elr &&
> +				      (status->nss != 1 || status->rate_idx > 1 ||
> +				       status->uhr.gi != NL80211_RATE_INFO_EHT_GI_1_6 ||
> +				       status->bw != RATE_INFO_BW_20 || status->uhr.im),
> +				      "bad UHR ELR MCS MCS:%d, NSS:%d, GI:%d, BW:%d, IM:%d\n",
> +				      status->rate_idx, status->nss, status->uhr.gi,
> +				      status->bw, status->uhr.im))
> +				goto drop;
> +			if (WARN_ONCE(status->uhr.im &&
> +				      (status->nss != 1 || status->rate_idx == 15),
> +				      "bad UHR IM MCS MCS:%d, NSS:%d\n",
> +				      status->rate_idx, status->nss))
> +				goto drop;
> +			break;
>   		default:
>   			WARN_ON_ONCE(1);
>   			fallthrough;
> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
> index 22e8561ad6fc..a79ebeb43585 100644
> --- a/net/mac80211/sta_info.c
> +++ b/net/mac80211/sta_info.c
> @@ -4,7 +4,7 @@
>    * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
>    * Copyright 2013-2014  Intel Mobile Communications GmbH
>    * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
> - * Copyright (C) 2018-2025 Intel Corporation
> + * Copyright (C) 2018-2026 Intel Corporation
>    */
>   
>   #include <linux/module.h>
> @@ -2567,6 +2567,17 @@ static void sta_stats_decode_rate(struct ieee80211_local *local, u32 rate,
>   		rinfo->eht_gi = STA_STATS_GET(EHT_GI, rate);
>   		rinfo->eht_ru_alloc = STA_STATS_GET(EHT_RU, rate);
>   		break;
> +	case STA_STATS_RATE_TYPE_UHR:
> +		rinfo->flags = RATE_INFO_FLAGS_UHR_MCS;
> +		rinfo->mcs = STA_STATS_GET(UHR_MCS, rate);
> +		rinfo->nss = STA_STATS_GET(UHR_NSS, rate);
> +		rinfo->eht_gi = STA_STATS_GET(UHR_GI, rate);
> +		rinfo->eht_ru_alloc = STA_STATS_GET(UHR_RU, rate);
> +		if (STA_STATS_GET(UHR_ELR, rate))
> +			rinfo->flags |= RATE_INFO_FLAGS_UHR_ELR_MCS;
> +		if (STA_STATS_GET(UHR_IM, rate))
> +			rinfo->flags |= RATE_INFO_FLAGS_UHR_IM;
> +		break;
>   	}
>   }
>   
> diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
> index b1edf8ed102f..2875ef7d7946 100644
> --- a/net/mac80211/sta_info.h
> +++ b/net/mac80211/sta_info.h
> @@ -3,7 +3,7 @@
>    * Copyright 2002-2005, Devicescape Software, Inc.
>    * Copyright 2013-2014  Intel Mobile Communications GmbH
>    * Copyright(c) 2015-2017 Intel Deutschland GmbH
> - * Copyright(c) 2020-2024 Intel Corporation
> + * Copyright(c) 2020-2026 Intel Corporation
>    */
>   
>   #ifndef STA_INFO_H
> @@ -1009,25 +1009,49 @@ enum sta_stats_type {
>   	STA_STATS_RATE_TYPE_HE,
>   	STA_STATS_RATE_TYPE_S1G,
>   	STA_STATS_RATE_TYPE_EHT,
> +	STA_STATS_RATE_TYPE_UHR,
>   };
>   
> -#define STA_STATS_FIELD_HT_MCS		GENMASK( 7,  0)
> -#define STA_STATS_FIELD_LEGACY_IDX	GENMASK( 3,  0)
> -#define STA_STATS_FIELD_LEGACY_BAND	GENMASK( 7,  4)
> -#define STA_STATS_FIELD_VHT_MCS		GENMASK( 3,  0)
> -#define STA_STATS_FIELD_VHT_NSS		GENMASK( 7,  4)
> -#define STA_STATS_FIELD_HE_MCS		GENMASK( 3,  0)
> -#define STA_STATS_FIELD_HE_NSS		GENMASK( 7,  4)
> -#define STA_STATS_FIELD_EHT_MCS		GENMASK( 3,  0)
> -#define STA_STATS_FIELD_EHT_NSS		GENMASK( 7,  4)
> -#define STA_STATS_FIELD_BW		GENMASK(12,  8)
> -#define STA_STATS_FIELD_SGI		GENMASK(13, 13)
> -#define STA_STATS_FIELD_TYPE		GENMASK(16, 14)
> -#define STA_STATS_FIELD_HE_RU		GENMASK(19, 17)
> -#define STA_STATS_FIELD_HE_GI		GENMASK(21, 20)
> -#define STA_STATS_FIELD_HE_DCM		GENMASK(22, 22)
> -#define STA_STATS_FIELD_EHT_RU		GENMASK(20, 17)
> -#define STA_STATS_FIELD_EHT_GI		GENMASK(22, 21)
> +/* common */
> +#define STA_STATS_FIELD_TYPE		0x0000000F
> +#define STA_STATS_FIELD_BW		0x000001F0
> +#define STA_STATS_FIELD_RESERVED	0x00000E00
> +
> +/* STA_STATS_RATE_TYPE_LEGACY */
> +#define STA_STATS_FIELD_LEGACY_IDX	0x0000F000
> +#define STA_STATS_FIELD_LEGACY_BAND	0x000F0000
> +
> +/* STA_STATS_RATE_TYPE_HT */
> +#define STA_STATS_FIELD_HT_MCS		0x000FF000
> +
> +/* STA_STATS_RATE_TYPE_VHT */
> +#define STA_STATS_FIELD_VHT_MCS		0x0000F000
> +#define STA_STATS_FIELD_VHT_NSS		0x000F0000
> +
> +/* HT & VHT */
> +#define STA_STATS_FIELD_SGI		0x00100000
> +
> +/* STA_STATS_RATE_TYPE_HE */
> +#define STA_STATS_FIELD_HE_MCS		0x0000F000
> +#define STA_STATS_FIELD_HE_NSS		0x000F0000
> +#define STA_STATS_FIELD_HE_RU		0x00700000
> +#define STA_STATS_FIELD_HE_GI		0x01800000
> +#define STA_STATS_FIELD_HE_DCM		0x02000000
> +
> +/* STA_STATS_RATE_TYPE_EHT */
> +#define STA_STATS_FIELD_EHT_MCS		0x0000F000
> +#define STA_STATS_FIELD_EHT_NSS		0x000F0000
> +#define STA_STATS_FIELD_EHT_RU		0x00F00000
> +#define STA_STATS_FIELD_EHT_GI		0x03000000
> +
> +/* STA_STATS_RATE_TYPE_UHR */
> +#define STA_STATS_FIELD_UHR_MCS		0x0001F000
> +#define STA_STATS_FIELD_UHR_NSS		0x001E0000
> +#define STA_STATS_FIELD_UHR_RU		0x01E00000
> +#define STA_STATS_FIELD_UHR_GI		0x06000000
> +#define STA_STATS_FIELD_UHR_ELR		0x08000000
> +#define STA_STATS_FIELD_UHR_IM		0x10000000
> +
>   
>   #define STA_STATS_FIELD(_n, _v)		FIELD_PREP(STA_STATS_FIELD_ ## _n, _v)
>   #define STA_STATS_GET(_n, _v)		FIELD_GET(STA_STATS_FIELD_ ## _n, _v)
> @@ -1040,8 +1064,15 @@ static inline u32 sta_stats_encode_rate(struct ieee80211_rx_status *s)
>   
>   	r = STA_STATS_FIELD(BW, s->bw);
>   
> -	if (s->enc_flags & RX_ENC_FLAG_SHORT_GI)
> -		r |= STA_STATS_FIELD(SGI, 1);
> +	switch (s->encoding) {
> +	case RX_ENC_HT:
> +	case RX_ENC_VHT:
> +		if (s->enc_flags & RX_ENC_FLAG_SHORT_GI)
> +			r |= STA_STATS_FIELD(SGI, 1);
> +		break;
> +	default:
> +		break;
> +	}
>   
>   	switch (s->encoding) {
>   	case RX_ENC_VHT:
> @@ -1073,6 +1104,15 @@ static inline u32 sta_stats_encode_rate(struct ieee80211_rx_status *s)
>   		r |= STA_STATS_FIELD(EHT_GI, s->eht.gi);
>   		r |= STA_STATS_FIELD(EHT_RU, s->eht.ru);
>   		break;
> +	case RX_ENC_UHR:
> +		r |= STA_STATS_FIELD(TYPE, STA_STATS_RATE_TYPE_UHR);
> +		r |= STA_STATS_FIELD(UHR_NSS, s->nss);
> +		r |= STA_STATS_FIELD(UHR_MCS, s->rate_idx);
> +		r |= STA_STATS_FIELD(UHR_GI, s->uhr.gi);
> +		r |= STA_STATS_FIELD(UHR_RU, s->uhr.ru);
> +		r |= STA_STATS_FIELD(UHR_ELR, s->uhr.elr);
> +		r |= STA_STATS_FIELD(UHR_IM, s->uhr.im);
> +		break;
>   	default:
>   		WARN_ON(1);
>   		return STA_STATS_RATE_INVALID;
> diff --git a/net/mac80211/uhr.c b/net/mac80211/uhr.c
> new file mode 100644
> index 000000000000..377218987632
> --- /dev/null
> +++ b/net/mac80211/uhr.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * UHR handling
> + *
> + * Copyright(c) 2025-2026 Intel Corporation
> + */
> +
> +#include "ieee80211_i.h"
> +
> +void
> +ieee80211_uhr_cap_ie_to_sta_uhr_cap(struct ieee80211_sub_if_data *sdata,
> +				    struct ieee80211_supported_band *sband,
> +				    const struct ieee80211_uhr_capa *uhr_capa,
> +				    u8 uhr_capa_len,
> +				    struct link_sta_info *link_sta)
> +{
> +	struct ieee80211_sta_uhr_cap *uhr_cap = &link_sta->pub->uhr_cap;
> +
> +	memset(uhr_cap, 0, sizeof(*uhr_cap));
> +
> +	if (!uhr_capa ||
> +	    !ieee80211_get_uhr_iftype_cap_vif(sband, &sdata->vif))
> +		return;
> +
> +	uhr_cap->has_uhr = true;
> +
> +	uhr_cap->mac = uhr_capa->mac;
> +	uhr_cap->phy = *ieee80211_uhr_phy_cap(uhr_capa);
> +}
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index 4d5680da7aa0..97433347c26d 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -6,7 +6,7 @@
>    * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
>    * Copyright 2013-2014  Intel Mobile Communications GmbH
>    * Copyright (C) 2015-2017	Intel Deutschland GmbH
> - * Copyright (C) 2018-2025 Intel Corporation
> + * Copyright (C) 2018-2026 Intel Corporation
>    *
>    * utilities for mac80211
>    */
> @@ -1421,6 +1421,13 @@ static int ieee80211_put_preq_ies_band(struct sk_buff *skb,
>   	if (err)
>   		return err;
>   
> +	if (cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
> +					 IEEE80211_CHAN_NO_UHR)) {
> +		err = ieee80211_put_uhr_cap(skb, sdata, sband);
> +		if (err)
> +			return err;
> +	}
> +
>   	/*
>   	 * If adding more here, adjust code in main.c
>   	 * that calculates local->scan_ies_len.
> @@ -4527,6 +4534,32 @@ int ieee80211_put_eht_cap(struct sk_buff *skb,
>   	return 0;
>   }
>   
> +int ieee80211_put_uhr_cap(struct sk_buff *skb,
> +			  struct ieee80211_sub_if_data *sdata,
> +			  const struct ieee80211_supported_band *sband)
> +{
> +	const struct ieee80211_sta_uhr_cap *uhr_cap =
> +		ieee80211_get_uhr_iftype_cap_vif(sband, &sdata->vif);
> +	int len;
> +
> +	if (!uhr_cap)
> +		return 0;
> +
> +	len = 2 + 1 + sizeof(struct ieee80211_uhr_capa) +
> +	      sizeof(struct ieee80211_uhr_capa_phy);
> +
> +	if (skb_tailroom(skb) < len)
> +		return -ENOBUFS;
> +
> +	skb_put_u8(skb, WLAN_EID_EXTENSION);
> +	skb_put_u8(skb, len - 2);
> +	skb_put_u8(skb, WLAN_EID_EXT_UHR_CAPA);
> +	skb_put_data(skb, &uhr_cap->mac, sizeof(uhr_cap->mac));
> +	skb_put_data(skb, &uhr_cap->phy, sizeof(uhr_cap->phy));
> +
> +	return 0;
> +}
> +
>   const char *ieee80211_conn_mode_str(enum ieee80211_conn_mode mode)
>   {
>   	static const char * const modes[] = {
> @@ -4536,6 +4569,7 @@ const char *ieee80211_conn_mode_str(enum ieee80211_conn_mode mode)
>   		[IEEE80211_CONN_MODE_VHT] = "VHT",
>   		[IEEE80211_CONN_MODE_HE] = "HE",
>   		[IEEE80211_CONN_MODE_EHT] = "EHT",
> +		[IEEE80211_CONN_MODE_UHR] = "UHR",
>   	};
>   
>   	if (WARN_ON(mode >= ARRAY_SIZE(modes)))

