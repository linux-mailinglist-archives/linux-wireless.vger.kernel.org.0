Return-Path: <linux-wireless+bounces-29294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEF6C81FAD
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 18:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 403034E22F1
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 17:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AB92C1596;
	Mon, 24 Nov 2025 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V8vWw6/P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Co0NBmvq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF22BD5BB
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006756; cv=none; b=NR7v+fDgTKXalpxoh6MIiYJ3z9V9wJzq9yrYbGwfMtVpAMMCv92LhCj7syf5KI8ME1iScJu1YrKxDJ7Mowg0adWokWN3sNMaOsInMzMr7Ptrb3QBnBB9wm09DWePExq6kSZFGFcxDGXyIrRfOkRdbKweVB+brWoHHVbzUaMWqrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006756; c=relaxed/simple;
	bh=+tapReMjkMlUVqzSD+zMjILD2zdUyH8Ozt6HLiX1QPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wy7xEVZwne+b/x4mH2sKrN/z4M4iSPfD7ApG5SlPwaM3i7kTVyC/bDXd/PRPldV7ZmonsDzICeJDdENAO/AoH6Z7saea2qHXBOlKbYDbKGAxgaPWR4vGrgbXdm0Tgk6gNKIJy9GGMZONoXP3U/Q81idAQN0I8lpx0sav/pi/qk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V8vWw6/P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Co0NBmvq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AOFuhlq365038
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 17:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QsDuJa9ZtMxVxivv2d+LEQsUL/Om6d9KUJOluWnMn2w=; b=V8vWw6/Pkd0VO5ll
	mOF7MYY7QusorKEx2sWPWO1/68rqPx8VrX+4zXEpXveu6XS+WOTW56hT/VjtFojV
	jWl0X+VVKXYI/6xZ26PyfNroeesoBhh6duQHBGb6NbexL9ygydI/sK0OYiCVnD2Y
	vGAHgldhs6QXWZAPNSNEHKrpXKyqXefM1rdkkXqy9Py46VtqLSi1hurqGfvBJG7j
	GVp7gMTlCQicZooxBTlbd+NJp0IEnmPiJmCcL6npSm1zJD+IvVgXb2Wu0DFMFmRH
	L0rL1yM9eeQ54vqAi4BCCO+gITdux5sG3Zbg/K0xI9FrQR4KUchiR5TOxcTLZEI3
	BveCVw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amteb8dh6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 17:52:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297f3710070so110981475ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 09:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764006754; x=1764611554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QsDuJa9ZtMxVxivv2d+LEQsUL/Om6d9KUJOluWnMn2w=;
        b=Co0NBmvqZWUYmpmgW2o+o5f715K1KxHSSEuQekNb+SB0nx6PaAw9Tp07MIPtSHCIcg
         GcolaWkAHYgj14FBVHd4vRykkoIuk4Ep8A5a85aBH8BTZ4Wy56mhWBagLpzq8gxv+S+5
         dyoWZR7miNoyH5a+Lr9jx3OExqu1JHkecWTw4z8Mik0yL+7DO2oQFeMSA3OiBqi5NvIB
         GlLMedObiMeyADqJtqVYWxhgjNLePO6SA5BUaXnGTqjpxAodrptRtNx26jS4Qh74p3Gc
         ZemJzwRIYAJGq10PHuxtutP409lQAyxlfclTLRs8rpl6BlUAcdPxMqGb2orR9qc/CYs9
         Rtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764006754; x=1764611554;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsDuJa9ZtMxVxivv2d+LEQsUL/Om6d9KUJOluWnMn2w=;
        b=SesEaszfi5yU7cPIuI2SA8jULV9Ky9Ywvfpu4a6p7TCGGXVxRcnMZjvxYCdqq9ROcK
         GrgSLERKPdigNNfW5n1hq6VqKl1FU4dS1J41k5cwW3BeORziL/LCMcOu+jDH7LcPsQhF
         V2WTIttVxVAh6OgJsyj/kAs6ZkLtCCZdYgJ1KCwSPGZD0ZRQpJTvhje+7qGC0Y+F2sfW
         AWwYunRyCZJAMzJziENvlyE4O6oRo1ykqm9vGxNmfqLTb33EMWnojM9VS2wwZXCd0Y0E
         f6FF862++XdvSRkNIKbULnjWinJ9tsi6QfEJmmKIS13qK6RvqGXwmrCF7oOpRe2UEZ81
         L67A==
X-Gm-Message-State: AOJu0YxGAlHW+TPsur1tDpTc5KwTxNOHuo1UXRDew+xepGLa26BrA2rp
	+IcQhw/Tj2hfUEzN6DI7VXg2Eh55CB0soZo5P2m8UdOuCIZxVtq/tZOfz5xStRmnm8c5MDjU4BF
	loB/r0XgfoQKK8MZ41MUTSzo2mTncpLLszEJi3qaXY67SD52gfFi/Uhvp3HrYYUnJ/1GrTIK38w
	OK0w==
X-Gm-Gg: ASbGncuJs5IAjz5ir5lecn9WiIlZkdnkZDxeqMevyGvFzJAmxhTzdLiLN8+SXHNjcPV
	rwIwEiyKbnQlF4i0WMBwTKEMBLkjUosNP7CJS4YVDQSrDDAs3cxsGyekKABbM/i6DaBx1VOub7M
	09knUvctYFu/WKBiRnqjoWiD8ccookdThGr1FoW0h8agn1+7qKMPwDy2e3h7489VO/ZWWPXUOYm
	rwpnaYr7ZXcpB9WHJeTts8nvXX7NIsSv6ZWcmVYzCJF66VajP7U92BRhNDse/fFf9k1iecle6RV
	1NooUcp3cZOlgmdExh3qtRlcYCOVcjW8DmyGZBO7GDeOcHFqlL5sH76Dva0PR04SyVTcURJmICY
	l5VMXRuJ5SpP/Xa7/3gyl6kwUIr2RIzqQlVJpls+E2PR4i85xjKGr/QYh+2GPbBliGgXwH6Bg8i
	PJ
X-Received: by 2002:a17:903:234e:b0:293:e5f:85b7 with SMTP id d9443c01a7336-29b6c3dc272mr135468905ad.11.1764006753710;
        Mon, 24 Nov 2025 09:52:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYSl+aK5/OyU25uyo9ea5yjG1EbCcuuFq3vP1FCxXQN+5pDWtO2bL29kXGILaBR358InET9Q==
X-Received: by 2002:a17:903:234e:b0:293:e5f:85b7 with SMTP id d9443c01a7336-29b6c3dc272mr135468585ad.11.1764006753097;
        Mon, 24 Nov 2025 09:52:33 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd8c56691d1sm10313372a12.28.2025.11.24.09.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 09:52:32 -0800 (PST)
Message-ID: <29ebeb55-1528-42b0-a692-11f20097fca8@oss.qualcomm.com>
Date: Mon, 24 Nov 2025 09:52:31 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: mac80211: correct FILS status codes
To: Ria Thomas <ria.thomas@morsemicro.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, lachlan.hodges@morsemicro.com,
        pradeep.reddy@morsemicro.com, simon@morsemicro.com
References: <20251124061111.3627341-1-ria.thomas@morsemicro.com>
 <20251124125637.3936154-1-ria.thomas@morsemicro.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251124125637.3936154-1-ria.thomas@morsemicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: H55Nri4VvKIpl6W_L_hCH7NpK6YsWYla
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDE1NCBTYWx0ZWRfX9hBUWW9YwAzW
 mcYVWf9K6OnH1Jfr3/1AkN6E5hZVzJYawUxDNBqUVHTpQ3gKddoj2CcQT9RB7J6mG9qdZPtMPut
 6EpD5kZt6y+jDSjvpmuGjBN6Y0BCGglXIHaBCUX8aC1jYDsHbQpxaxLQMeWMVStKGxHSVh3uuXA
 qfKHi2No94sEb0+/6pXaushAFeKcctDKc+0zDh7CCaPt1Y6szF1RYC9GziEB5fiXgxLHv0GwQer
 2rlzJxx5BOEmhlTlt0uVOhC3AG+0tPbEDvR/G9YLcVh2XDF7MzSM5B04kpkmZ8EWXEKBMnPpA8a
 06i+wxZz6SdaqzyXEVWkSmJpdnM9j32h8a2byGCEKph9epHfEo3SnFmu+RVEef2FcDko1QzRJpf
 pnkUxNnSIqt3AH6l8ROwbiItudnneQ==
X-Proofpoint-ORIG-GUID: H55Nri4VvKIpl6W_L_hCH7NpK6YsWYla
X-Authority-Analysis: v=2.4 cv=d7f4CBjE c=1 sm=1 tr=0 ts=69249b62 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=YPXFKQCaAAAA:8 a=EUspDBNiAAAA:8
 a=V1ibmfsOfU_ph-u74SAA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=R5n2JtruLZ7-kf9guG-3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_06,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240154

On 11/24/2025 4:56 AM, Ria Thomas wrote:
> The FILS status codes are set to 108/109, but the IEEE 802.11-2020

Note that the current version is IEEE Std 802.11-2024, and it would be useful
to directly reference Table 9-80.

This issue was pointed out by IEEE in "Errata to IEEE Std 802.11ai-2016." In
addition to this issue, that errata also calls out renumbering the "Category
values" in what was then Table 9-47, now Table 9-81, for FILS from 22 to 26.
But the current enum ieee80211_category does not have an entry for FILS, so
that part of the errata does not need to be applied

But while researching this I see the current category 22 enum is incorrect:
	WLAN_CATEGORY_S1G = 22,

since IEEE Std 802.11-2024, Table 9-81 has:
	22 Unprotected S1G
	23 S1G

So that might also need to be addressed by someone.

> spec defines them as 112/113. Update the enum so it matches the
> specification and keeps mac80211 consistent with standard values.
> 
> Fixes: a3caf7440ded ("cfg80211: Add support for FILS shared key authentication offload")
> Signed-off-by: Ria Thomas <ria.thomas@morsemicro.com>
> ---
> v2:
>  - Correct the Fixes: tag to reference the right commit.
> ---
>  include/linux/ieee80211.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> index ddff9102f633..1f4679092e69 100644
> --- a/include/linux/ieee80211.h
> +++ b/include/linux/ieee80211.h
> @@ -3594,8 +3594,8 @@ enum ieee80211_statuscode {
>  	WLAN_STATUS_DENIED_WITH_SUGGESTED_BAND_AND_CHANNEL = 99,
>  	WLAN_STATUS_DENIED_DUE_TO_SPECTRUM_MANAGEMENT = 103,
>  	/* 802.11ai */
> -	WLAN_STATUS_FILS_AUTHENTICATION_FAILURE = 108,
> -	WLAN_STATUS_UNKNOWN_AUTHENTICATION_SERVER = 109,
> +	WLAN_STATUS_FILS_AUTHENTICATION_FAILURE = 112,
> +	WLAN_STATUS_UNKNOWN_AUTHENTICATION_SERVER = 113,
>  	WLAN_STATUS_SAE_HASH_TO_ELEMENT = 126,
>  	WLAN_STATUS_SAE_PK = 127,
>  	WLAN_STATUS_DENIED_TID_TO_LINK_MAPPING = 133,

actual code change...
Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


