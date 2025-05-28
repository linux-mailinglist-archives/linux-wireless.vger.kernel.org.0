Return-Path: <linux-wireless+bounces-23478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F85BAC70BE
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 20:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D6A3ACB9B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 18:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797B11482F5;
	Wed, 28 May 2025 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="moAIu0rM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6517B50A
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748455920; cv=none; b=bGVVpDqSLqxYdXnnJQWF1tXbiDEmbbb97mqCosuBc3HYSNH15w20ObUu2iBFL+4HSWfygYdQ5kjJHALoVKoTUUOntBVT/5l3KDZC1hLc+F17KbDMXIMmet2jhgP9eaxUK6AVkbrUhihsmF5s6H2w7nPQmeodqvhjC00v+GOA8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748455920; c=relaxed/simple;
	bh=J2JIA872BopqXgH4QG6jgFGk1pirUQDWhGTHDA1Vd0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhlLqTTnKDfQKMmhOJtADxvJ1NQRpDZjMx2qChCziwBp10/CXek/makLpzM5Q99tD+RSLG+PmxsJvC9YfZ44gOKcUKu8OTi7OeKxSYmMFgLoHDdj5wGqLXJdE/ClSVisPU4Hn4nYU8AGXNfGcdAqWe5QUEzY+cgSK1GefvBNRmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=moAIu0rM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCl78H026623
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 18:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wVv8q5mx0sfQ3TjnBNxsWpySTORKqFLrmAy5io83Neo=; b=moAIu0rM75mAs2o+
	kFlJfExDyo5rxaYWHSE507DUsZeNrMRKhfIgyek6ogW5MGwipAtnidfv/uyEA7Wv
	4PrLIeHVjReYPgMnpCz9pE6UryE4ByLX7NE1wi6p4UsVy8nhzrPxDJ/1Jqutwc0c
	GuzUe+JCGU0h4FJCFIQAYM8s3gfBxxqDt/U/X5RZz/rIaUGaHeajNe6WVN0teW8h
	KFQ3xQaSWc/e06bX9CHOt6AUupp3vPJ6zchse8v4LhEQ36F+knUAgx04mowp+dg1
	dxOZC2Jzl7JeD/ABw4tbebw2MCnzvrKZuybipcc/NUSzC62vkEBGw32+5DVyQLzO
	769o9A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u5ek3154-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 18:11:57 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2341e468d02so888825ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 11:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748455916; x=1749060716;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVv8q5mx0sfQ3TjnBNxsWpySTORKqFLrmAy5io83Neo=;
        b=g00ALC5LgVJ48eDbP5JPhUFc5bhLM+NPouh3aWeSahq/rPE6+V3g0dJZOCZmJxwSL8
         Agql2sPH0LS8DjQcngnFbtZBdhzThD+E3L5fcc2ejkYgGdAMq8V1RmQqzxTwO+WhOOxY
         v/bLgSHQWeivOTv6FLqsvWbL8GUmexvvhCeTPwwyjy32+agj3rmiXaJ1YeIvPaiqLLx8
         a8o4AFgF30o5b+hqqPkQ2IqTZmic0CQjfsgJM6eQn3EvceCq3A6nr6N+q8s5E0Njhqqd
         dq+bV9ArXe+hE0fuVz2L0raP3+tHSzSSzQbzdMzLrxQdgKrWMcaJ0etXV//sIbGgcTE+
         fsgg==
X-Gm-Message-State: AOJu0YziWScN7wSavahkT/qyviNq8iKZKmUDHtwwq6AgC6Qm/pamj3LI
	3suut+58vaFO5QP4P1ylTj5SCQ5qNKnRS/Bh9sNYnRw6v0Gt5rxfIuJVnmDLlqS+2Emc6A8WXPV
	1ysrfs9IJQsO84VXQZ05JF7HChB0OBJPbODC0loeo/u/LNdrBWbbI5+RT8tGgEPCbmBjDrTUcFv
	FsTQ==
X-Gm-Gg: ASbGncs0cuIq7i3noNDHWbQYazdv+eV0EEuGqJtx1ocNByo6T6zGxKaNGjYepYI3vgN
	XYpj9samC77rdho0tg1vSHo4EP7sU0Me4uGsWTmzgRfqqxtSA8oJ42ijVELmb+QH/67xQjbSjSL
	eH6/icJcfxm4E/AuYoyqhdRv39rNs8JwEk7kKkSILjic1e6MaSXTNh5yiwDKUAvNGpyUUpSkT+K
	x3rpDX96lBvr2oPoui6OFZDUPBdR1aMt7MHcuGyWevkhRAby/O5pl1mL9Gnasr8qVmr4BIyX7+f
	Yu0QMleG4+gUTYokn9hev/y/F8KIFvHfGfXiSYViO4bb7fGJIuXRJRWF72Pp0rc0Elg=
X-Received: by 2002:a17:903:3ba3:b0:234:9fee:af99 with SMTP id d9443c01a7336-2349feeb249mr116183945ad.35.1748455915909;
        Wed, 28 May 2025 11:11:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkhHvyEP4DPmhTNvuxEVtDMk6KMvD6rV7Gps9gwcF5cfbBhSs6JQyPyPB9wNy0jPyGlJRDXw==
X-Received: by 2002:a17:903:3ba3:b0:234:9fee:af99 with SMTP id d9443c01a7336-2349feeb249mr116183655ad.35.1748455915510;
        Wed, 28 May 2025 11:11:55 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d2fd2264sm14946285ad.29.2025.05.28.11.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 11:11:55 -0700 (PDT)
Message-ID: <e5c0fa7c-598f-40d8-b258-f935af069ff3@oss.qualcomm.com>
Date: Wed, 28 May 2025 11:11:54 -0700
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
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250522053326.4139256-4-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GIgIEvNK c=1 sm=1 tr=0 ts=683751ed cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=UtNDcfxNxXlkzu_Xu1AA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: B5sxB9Tr3vpQlTs62a6qgXT4oz2wu6ms
X-Proofpoint-GUID: B5sxB9Tr3vpQlTs62a6qgXT4oz2wu6ms
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE1OCBTYWx0ZWRfX5sEn3aIgtUGw
 vE/S3+2AOcW53SnMIzCow37Ld00tZXH9UG1gWOp9Iaz7yjeccOfvGZI4Tt6YVpMuZUMbyWvjY9K
 nsGcqqWmW6mz3G3xxjmRPb6SnRoMInsBaNmMtoDTPF/gYN8oEhPiw9Fl5uvT2R8nYMjqeXPMA8H
 NwAT5E5L1H3zRli61zY3mZqTmCM/roPLH6+hCAxC+J+DlvwtR1F3RR8DmOZzlAk9W9ZHtWw60GP
 i/Gl5pH1lHZMreYgXrLcojCuH3QgWfE6rU6p4tWQKsuOmc6mOCxXWTTVONb5Dq7oZ0V6YnmpoNQ
 Dm7oQPqHWbWInnSwiQIDxgY2/eNckW6MWFe8kU5Rm0aVAEJq4fMkdKSdu4YsL8+FHV/sL/Hgr6s
 4ZsBjnMFIx305/sFj9looC8rozEkXkOefhRryq1SXH32ZSWXoGea7G/OW2Uwqmez11EcyRB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_09,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280158

On 5/21/2025 10:33 PM, Roopni Devanathan wrote:
> Add support to get the radio for which RTS threshold needs to be changed
> from userspace. Pass on this radio index to underlying drivers as an
> additional argument.
> 
> A value of -1 indicates radio index is not mentioned and that the
> configuration applies to all radio(s) of the wiphy.
> 
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> ---
>  drivers/net/wireless/ath/ar5523/ar5523.c      |  3 ++-
>  drivers/net/wireless/ath/ath10k/mac.c         |  5 ++--
>  drivers/net/wireless/ath/ath11k/mac.c         |  4 +++-
>  drivers/net/wireless/ath/ath12k/mac.c         |  4 +++-
>  drivers/net/wireless/ath/ath9k/htc_drv_main.c |  3 ++-
>  drivers/net/wireless/ath/wcn36xx/main.c       |  3 ++-
>  .../net/wireless/intel/iwlwifi/mld/mac80211.c |  3 ++-
>  .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 ++-
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 ++-
>  drivers/net/wireless/marvell/mwl8k.c          |  3 ++-
>  .../net/wireless/mediatek/mt76/mt7615/main.c  |  3 ++-
>  drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 +-
>  .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
>  .../net/wireless/mediatek/mt76/mt7915/main.c  |  3 ++-
>  .../net/wireless/mediatek/mt76/mt7921/main.c  |  3 ++-
>  .../net/wireless/mediatek/mt76/mt7925/main.c  |  3 ++-
>  .../net/wireless/mediatek/mt76/mt7996/main.c  |  3 ++-
>  drivers/net/wireless/mediatek/mt7601u/main.c  |  3 ++-
>  drivers/net/wireless/purelifi/plfxlc/mac.c    |  3 ++-
>  .../net/wireless/ralink/rt2x00/rt2800lib.c    |  2 +-
>  .../net/wireless/ralink/rt2x00/rt2800lib.h    |  2 +-
>  drivers/net/wireless/realtek/rtl8xxxu/core.c  |  3 ++-
>  drivers/net/wireless/realtek/rtw88/mac80211.c |  3 ++-
>  drivers/net/wireless/realtek/rtw89/mac80211.c |  3 ++-
>  drivers/net/wireless/rsi/rsi_91x_mac80211.c   |  2 ++
>  drivers/net/wireless/silabs/wfx/sta.c         |  2 +-
>  drivers/net/wireless/silabs/wfx/sta.h         |  2 +-
>  drivers/net/wireless/st/cw1200/sta.c          |  2 +-
>  drivers/net/wireless/st/cw1200/sta.h          |  2 +-
>  drivers/net/wireless/ti/wl1251/main.c         |  3 ++-
>  drivers/net/wireless/ti/wlcore/main.c         |  3 ++-
>  drivers/net/wireless/virtual/mac80211_hwsim.c |  4 +++-

...

> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 82617579d910..553bcfebe8cc 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -4572,7 +4572,8 @@ struct ieee80211_ops {
>  			    struct ieee80211_key_conf *key,
>  			    struct ieee80211_key_seq *seq);
>  	int (*set_frag_threshold)(struct ieee80211_hw *hw, u32 value);
> -	int (*set_rts_threshold)(struct ieee80211_hw *hw, u32 value);
> +	int (*set_rts_threshold)(struct ieee80211_hw *hw, int radio_id,
> +				 u32 value);
>  	int (*sta_add)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>  		       struct ieee80211_sta *sta);
>  	int (*sta_remove)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,

rather than have one patch that modifies the get_rts_threshold API, another
that modifies the set_rts_threshold API, and future ones that will modify
others, should we put these interface changes that affect all drivers in a
single patch so that the individual driver maintainers only have to deal with
this disruption once rather than for each attribute?

that means enumerating all the attributes we want to maintain on a per-radio
basis up front. do we have that list?

/jeff

