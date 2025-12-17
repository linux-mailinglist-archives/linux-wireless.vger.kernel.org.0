Return-Path: <linux-wireless+bounces-29835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EE6CC7B45
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 13:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 301E2301B2F3
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 12:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4B21E7C19;
	Wed, 17 Dec 2025 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CmAqRMKg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bKpRdKeg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD351A9FAC
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976085; cv=none; b=GYas2U05/nXPqYgtKTE7cggoY7Y0G2Rhn7HeWuVZQ5ZxlDwj5N6DxoljA8V+VS44uPH2GL5OmVmohHWJC1iw2YvOyMssrdRgAVL7SvVruwjt6jqh8HUZfIpn3sEhdudQnLXwCcQWaXQYlJIO5ZE2bm0kRoXXJXW53/PQE41Ymvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976085; c=relaxed/simple;
	bh=PaGqI9FvOlsU09fY8ARt5ZujKz+jBdIcHQHa1xdip8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnePBpG62XGAzLH6EPYUExWJy1c9YSGQ1qa7o8r0dD1NlZ/FLa5cvdybTpoX+LvSbs49rl9rF+lxsHyAMStWBlf9s7MP3arytNRiZQsh5danNJYULGTKCalzRXBCtstEt89BGaeLaubitAsuWZzIbH6eeuDT/406fbP5mCgxp+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CmAqRMKg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bKpRdKeg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCL3sp2502985
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 12:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FrobNy0wBzngpKKvR24/1b/uxWjjT6E944nMmTpUfA8=; b=CmAqRMKgKCrXf/nS
	BvpxwdtVMeBgSqOQPIUEpezlywuKWoFb8UZLnuVt6vzCgIHoI9r26idEM9iV1B1+
	rdxIDH2/QeZlin+SYjMNYyEcpNbGpQnQHDDnfxFwTilzCrnlDk8BbxQXA76io6Ie
	BC8G2/BoT4gT3+eubn+n9SOVUfG3kUUMaUDISk+xyKZ9gMQ3XgBYOmpX/FpResPy
	gIIfy5dcIAtgbvB8ODQ5Nmzn+mlH2lWdixgyWF2RF3vGFh8JnirOM1oWrNWtSfUV
	EM6hqHCTUgeUHqAn7HY2uph3b8Nr0IXhlb9miq/vkvs8ZjfKVebBeLiUecgTs9Hm
	CwHYqw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3rqa8vyn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 12:54:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-bf222e5b54dso419721a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 04:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765976082; x=1766580882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FrobNy0wBzngpKKvR24/1b/uxWjjT6E944nMmTpUfA8=;
        b=bKpRdKegcrqOEGaOxqNUZw1xbwbZze1xB2jQeqnZq9Mb9fve0KSgtSE3/mImL0YfJF
         8MZ7fALZAIK4ob38bN5qySYMPJ7FZnVGnhi5wmBaGDe82v0R8NlQisv1rvSMgYenayk1
         pX8PUfictL2VVDrbBbctuRL4/6f9up/zMXteqcFT4l6yI5CCquVlMXI0uBROqm5pPnwp
         YyxVL60PkGv/6gJEZ7d3zpguaWNYg5JBtupaRsZSKsqQcbOf8eRY4QDfvBl/XJBHFPJK
         Oof3J3Nwoq7cg82A775G/c4N3AHxmLfQDZ3bggGojFdBvAQoVMKU88jNzMu8EUOn8UsC
         We/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765976082; x=1766580882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrobNy0wBzngpKKvR24/1b/uxWjjT6E944nMmTpUfA8=;
        b=HpnrSo5F6j3JStNrJXTrCzfJVbtQogLu0/ohTN20ptb/O6CsE++Y3wy2WvokWuWPFs
         hWhHhYNn5Qme7kLbV2fJrHELruzXHAM9r+p1PBSKo/0Ulp8ouscpudl53CXG0OZ9imS6
         E5vQpfzO1oJidX2FVO3588NuhCOfx90C2S4JYuSRUlkjswXbRXslh/K548tZ9t/B24/3
         qGmsYL77vfnNpbUKzKQXfzFYC2HPeErCEPaon6IHk4D7LJ44TZMt2JwSynsK/9vEzCvk
         zkltapA3ECr8pRcRPCEP0BgiFtlMQpNaiXuDaygYjJSZw+s2xzt8uWOndjElfOC0cxuI
         R01g==
X-Gm-Message-State: AOJu0YyUsmrz2rz7ouhlgVS0KnGCwSbbVwAa62LoqA8H4n/xu+bHGACj
	262Z/rxPVkdUi0OSA47lR9UI0OecEJKOHIo6ZXZEz/WqD/Ryxmw3z+WHNV8Ry8o3obYkh1d2Svl
	GpUWdB7baov3hpVcwblOvfUf1m22owprsw9GXQ6z/eUVIdXlSvNB986dC5gkAoUgjTIc1Yxtb37
	+zxw==
X-Gm-Gg: AY/fxX4XRcTv8BP4xRZ7IWV2M7B5cJGYiEEX0D99Mlrw/y4aDtLj5XCuplk6VwhVLjS
	kYQZ2AiGx5CMF5T8eLjqCom/0JC/wyQfhcNYY28HpbrxWRo/VAF+Ho0ObBlsAp2EIiyev2Py5lR
	fDfWkfeIB8faeRghIYdsRR8jU3nGmnf2Dy6BGWvBufn2yEUshgt0TarysMSS5oPDuB3RMfxHTbl
	JWen2TshiB+1ZMQW4CFV7w4Ef88Rs4txccM0d3jPPgHmkfT1/RG8/ulHjBPhW96KbL8PH2sA9Hu
	b+WOq/BJEYjCTy6cy0fRX6hm2/HrX/dRXt/Tgr1vzXjLtsaTuBRk6f+Veyqamt25Yz7Dr0UXaxl
	AOPM5Q76UX8tdi2Ej9y7WnaaxT8AWXo0ScuuTzDux6/CmKTWNUno=
X-Received: by 2002:a05:6a20:9184:b0:366:14b0:4b15 with SMTP id adf61e73a8af0-369aa740adcmr19942171637.32.1765976082434;
        Wed, 17 Dec 2025 04:54:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc/FjO1IypZRwE0LzYxjSD3j9c75hIvX6WVz+dv4w44PhBAGoWXCW/SX5vV8ztCFJIgZZzEA==
X-Received: by 2002:a05:6a20:9184:b0:366:14b0:4b15 with SMTP id adf61e73a8af0-369aa740adcmr19942149637.32.1765976081890;
        Wed, 17 Dec 2025 04:54:41 -0800 (PST)
Received: from [10.151.41.188] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e163sm18119512a12.20.2025.12.17.04.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 04:54:41 -0800 (PST)
Message-ID: <3b58cd19-d522-4df3-880a-13fc26ebc642@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 18:24:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC wireless-next 02/13] wifi: ieee80211: Add UHR
 (802.11bn) definitions
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <20251216062656.1738022-3-karthikeyan.kathirvel@oss.qualcomm.com>
 <94411a1f601b3b4cbc09cb780c37df9013f3b6bb.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <94411a1f601b3b4cbc09cb780c37df9013f3b6bb.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VwGI-9eCDUK1uH7yE7FWKHLQIrM3a8Xd
X-Authority-Analysis: v=2.4 cv=ALq93nRn c=1 sm=1 tr=0 ts=6942a813 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ukZaru1ZBjZspbpd-10A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5OSBTYWx0ZWRfX/fKrauY/zpS2
 Km+Abx0IkBFfsPaXGHHA6/to1OH49NntMGnxrNdmEFInQMUEyMTbZtGi0gYrecvTfhw06ksAA29
 XBQedz5iuqqxn1bkTf2sJz2+wYsq2xEoPU9fXqyBzmfExeknmyHUOoGREEX1PROOY4ncWquI+b/
 Umjj1faN+sO2neaCWuRjrHfdmOHr7Uex2ngkqwACBHWZVs/zKQiQycxp4vBgra0Yf0Id0hlFz2r
 shER0Bdv+VYGh2mYilhn/GJ44d5iwwwvFEttAkNzPY3R+ZGlPEosKNhFZWbb56krls1MeZ3LoNl
 zOTlbhEIT/bCVa2YW4D4GceSYdI5yFfr3PZDzPbFG+1ftpDXx58GDX5+5UxYhBnFY3fnNTUEJ/S
 YP9wa/je7OJKlmfHbCxZq07vOI9oBQ==
X-Proofpoint-GUID: VwGI-9eCDUK1uH7yE7FWKHLQIrM3a8Xd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512170099



On 12/16/2025 2:38 PM, Johannes Berg wrote:
> On Tue, 2025-12-16 at 11:56 +0530, Karthikeyan Kathirvel wrote:
>>
>> +/**
>> + * struct ieee80211_uhr_mcs_nss_supp_20mhz_only - UHR 20 MHz only station max
>> + * supported NSS for per MCS.
> 
> I think I'd rename this? Due to
> 
>> + * As per spec P802.11bn_D1.0 38.3.11 - "UHR-MCS 0-15 are the same as
>> + * EHT-MCS 0-15"
> 
> it will only ever be used for basic UHR MCSes.
>
Noted.

>> +#define IEEE80211_UHR_DBE_CAP_MAX_BW			GENMASK(2, 0)
>> +#define IEEE80211_UHR_DBE_CAP_EHT_MCS_BW_160MHZ_PRES	BIT(3)
>> +#define IEEE80211_UHR_DBE_CAP_EHT_MCS_BW_320MHZ_PRES	BIT(4)
>> +#define IEEE80211_UHR_DBE_CAP_RESERVED			GENMASK(7, 5)
>> +#define IEEE80211_UHR_DBE_CAP_EHT_MCS_BW_160MHZ		GENMASK(31, 8)
>> +#define IEEE80211_UHR_DBE_CAP_EHT_MCS_BW_320MHZ		GENMASK(55, 32)
> 
> For the record, I'm not a huge fan of GENMASK(), I tend to think just
> hex is more readable :-)
> 
> Here, using GENMASK() is also wrong for the last one of those, and it's
> really not obvious.
> 
> 
Sure, I will change it to hex format. Last bit mask is fine right it is 
from B32 - B55, what is wrong here ?
>> +/**
>> + * struct ieee80211_uhr_operation_info - uhr operation information
> 
> nit: "UHR" (throughout)
> 
> johannes
Sure, will address it

