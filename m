Return-Path: <linux-wireless+bounces-32346-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCvXCK5ypWlsBQYAu9opvQ
	(envelope-from <linux-wireless+bounces-32346-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 12:21:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E00E1D75EF
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 12:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFB7D3051452
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 11:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9D1345731;
	Mon,  2 Mar 2026 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NVD770rw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f7aPUqP6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B3A36166B
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450395; cv=none; b=Cwo84zWCvVLoEeCTMCOSLLE+Ta70MOT4eBA/kIWf4pSQgyBdmgtd53VGev9WNxs8N8hCky36ApZNOxG1SRYlwrLz7UeaZd0BOAf5mcbeUlkEkWYQxy13WpupJkOYI/O7q3kbEVVveb4NZ7Uzio6pGnQxQeDYCWMrqoPRLAPxP6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450395; c=relaxed/simple;
	bh=mwdKK8Li2PhbEu9LQrkeBE5zeJItXOqwr/dGqzecllI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2Tjzm3onuPF++7X3uQdCzda1A3h+6Bwb9iEicqxZGK7FKnf/KwhO5xjnEl+dUQ513oBx1qTzWLIg1iMrsZaL8kKo63lo/VaNEuW7VSvhw1XOlLBknd7VVWPPpiiMshWs6ZL3ommiYxiJuc1Gpo4mG9Pl3oalf5db97DGkYFy48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NVD770rw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f7aPUqP6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6229K5dE782876
	for <linux-wireless@vger.kernel.org>; Mon, 2 Mar 2026 11:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	85tAm8hhBC6vY4ZhaA5ddoVW9bVjRl+sUKNYU4RRO7k=; b=NVD770rwKYD9VwJ5
	kRpb5NgdGs6ujJSsMNw2zYbLw3SREJx50AMmhHB3p8o32L3RI1/HMGpJGsKnlF4q
	wpKdP5ZJK9nr6urLHNlYParF0Vfzn77rKQIPQHMLmz91Mg18zS+mpBV2yC8DBZQm
	SA7Bk2arnmrA5NZ452R5PbYYB+DlIIH1y3X0TjGx+Dt3UkneETobT5W66WpdFcmr
	c9k6zbSg+DaFE+/E8tp5cNiqcamH8ad0FeCm9Hxc9nhVoD72t6cw1/zN7zLEdJ1X
	ZMBzsr6lyXrNtf2Fs3prgFBvVS9zzwGYZZolkTuPy+J226hX7JqYKUHuPCBZPHj5
	ZdV5hg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7u00dmt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 11:19:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb50fb0abdso439957685a.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 03:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772450392; x=1773055192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85tAm8hhBC6vY4ZhaA5ddoVW9bVjRl+sUKNYU4RRO7k=;
        b=f7aPUqP6KMBAKu/iA6iPtsgnFc30PcZyBJBSDvG2J9rEO8S1EgDfLti/li8LW99mnR
         YLLDdO6YMEDYGzaRA1ZNLDulNiqXpPc2Yk5Z9BYHq8aCmiLgLzihRK667iM4ec/Y0x09
         uxcOneaYcAdcATS/Yh05Rz2zZ1ND/IK/8VjCoNHHsNJ7WeLNdPguQ2sseieoEYp0YiKU
         WMkqxlTPNVDt7V1ZIjAJAQNSsMNq72Acm02GaUkcmSJfO6Vy93GUV9+QYXwex8/eUiCN
         QR0dft4K4PQuVsUrpFjRMsKRuZsICRFUWwn41QdwOaVfPZU+R3YOaqv/lcS0buM59SvQ
         lW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450392; x=1773055192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85tAm8hhBC6vY4ZhaA5ddoVW9bVjRl+sUKNYU4RRO7k=;
        b=Q8GggZNB3QqY77Hjj62pRqa/jdfOJhzEitpx5OPWYHrO/re/oJbNy7Sunpaz/0GZzt
         lpRdUaETyJVg8nPtqAIZmomIwfGs41VTgadVBX1EjBNYrNc8La6Vob2lWEy5zE4H4szZ
         OWuNjv59z53lUpVXwG/1Uisn9+FUVHaXyJOv3OYt8kKe7AolboVCKyKjV1TV/gSdkKaI
         ixlqrYXq102hWrNd401o4ZsoBU7uA39Onnbof+BN8hyfLz+0+UnNiFV0i3lnMFRFCpZ5
         FClXWKYHKEr5ewfAufdIADMBxXur9tdY7DPxmpmmkJW6UZq0UHbF57natMN6QjanPqFq
         AiYA==
X-Gm-Message-State: AOJu0YxZwHhV3w+Gp+ILmuYuWBhnx2qyUJtBSBEu01O0VzRkLvb9CikM
	UdhZ+/nG0ZRLbzsXhFVoLDOMsglsi9RbJ68lfPzxFpfYKGr6+ln5lhAU/lRK/62IUs1cYIQfXgP
	cP1Fp2b+jxcKNrkI2009YQYyQmDYUPA4kMDBV7cwZ8ywjpMGIo9EG1Csy2/IOlMw4c/u/8A==
X-Gm-Gg: ATEYQzzSNro0/CpA0Ra6xycpsgGuf17Se6k9JogWaYt1cLyqLd0kyBRbJQdAwyNhsTU
	xP0IrmD8scPzeFM9T4TDV6RAhgbKF39lOGdG4QJ3ozjyuK9ZCvGcQEe9Hf5U9B66mduRqcGRPzR
	obwdjcEDukxUvFVluvFezyHvVlMs2vxwl6XM/UfghrK1kvirhKdUVJIr17NwYZfMbJ8judezMuC
	RHd1Cs7W8TAZP2RoIu4FFJsE2mHklLMuTi9n4+Vk1EqRfGvpJfb73UyIvyXLqRGM3dUONOOSiUi
	Grp+M0tBwtZxUVbgXg/vFiu+Pyr9mYq5kkwE6PyDXY8WsaztG8Db0nBC5MPMLcnOTLOKvX/oPzk
	+UN3/8kOMZYWWot4RDzPKlgrbEcx5YVa3TswpGKECssxoRdf84hgRH5HCcw9xsqFCdJkZkm9uXw
	/TOrs=
X-Received: by 2002:a05:620a:190b:b0:8b2:6eba:c45d with SMTP id af79cd13be357-8cbc8daba6bmr1161591385a.2.1772450392476;
        Mon, 02 Mar 2026 03:19:52 -0800 (PST)
X-Received: by 2002:a05:620a:190b:b0:8b2:6eba:c45d with SMTP id af79cd13be357-8cbc8daba6bmr1161589285a.2.1772450392029;
        Mon, 02 Mar 2026 03:19:52 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66003d5ca55sm1927759a12.28.2026.03.02.03.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 03:19:51 -0800 (PST)
Message-ID: <05ff4122-1a8b-4728-81ac-33a7ca542461@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 12:19:50 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CMA allocation fails with default 128M on X1E80100 (Lenovo
 21N1CT01WW) for ath12k
To: =?UTF-8?B?UmVuw6kgTcOpcm91?= <eldeinformatica@pm.me>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <7pJkV7xouk-7S77gIvCwPj5EAAVe0JWdkD5Dc4Q7Y77_gPr5m7jMA2om7AyEN6RKBmEyFbIDJceHFstXFuzPJWPNhqafLXOu2O0uCDZEFcY=@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7pJkV7xouk-7S77gIvCwPj5EAAVe0JWdkD5Dc4Q7Y77_gPr5m7jMA2om7AyEN6RKBmEyFbIDJceHFstXFuzPJWPNhqafLXOu2O0uCDZEFcY=@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GMMF0+NK c=1 sm=1 tr=0 ts=69a57259 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=XaNSQNG2WT23jTI37ZAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5MyBTYWx0ZWRfXxVr4yZaL60vT
 jxQT9/41UGAZHXdRR1kr+XOpao8xCgDBQBmt2lqMhWNnd+WHpDXNxRVFxxfc1gSmnHjWNp6eYQ2
 +sPze1o/MkmdC8YT6nrjyd4u36105P1SegotWWWtBx/kL//Oa1fWpwNA7xqWWM13LB52RSpdAhq
 SXNCTX6QlAuu4CH239dWOXb1qOillR27LU6UTzX9QPjBtD63UqbN18mv4DjYAD17KrEYJhls+rs
 +rRAtEDVSB7RM4jLayHgumu0MpoJKtp/ZPqrEPyUxIlOHF9xZrsXIjoO+84JavVW32RsYqn22PB
 Cu4xiW3tFxVTgKIfwjmjeHAPnrpGW1tPyUcpHo8hQWDBZ9EFEca2GVXCUtU2r2ZJYcLZXwKuCT9
 WH7Zb45AD5D9FKeVBjzWNSV8FXn6WPn4DoQngvjyuhUu+sDKDGaHga7RFUueHszNZasVznEi6OJ
 q0NPpCIzFQhhRuRH7jQ==
X-Proofpoint-GUID: -7w3vpfMC3W2ID5M3sqE0mx5faTauZ0f
X-Proofpoint-ORIG-GUID: -7w3vpfMC3W2ID5M3sqE0mx5faTauZ0f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020093
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32346-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7E00E1D75EF
X-Rspamd-Action: no action

On 2/28/26 10:29 AM, René Mérou wrote:
> Hi,
> I'm experiencing CMA allocation failures with the ath12k WiFi driver on my new Lenovo 21N1CT01WW (Snapdragon X1E80100).
> 
> Error in dmesg
>   cma: __cma_alloc: reserved: alloc failed, req-size: 257 pages, ret: -16
>   cma: => 1042 free of 32768 total pages
> 
> System details
>     Kernel: 6.17.0-8-qcom-x1e (Ubuntu)
>     Default CMA size: 128M (set by the distribution for this hardware)
>     WiFi chip: ath12k_pci (Qualcomm WCN685x)
> 
> What I found
>     With the default 128M CMA, the allocation of 257 pages (~1MB) fails
>     After increasing CMA to 256M (by adding cma=256M to the kernel command line), the error disappears and WiFi works correctly
> 
> My questions
>     Is 128M expected to be sufficient for ath12k on this platform?
>     Could the driver be optimized to need less contiguous memory?
>     Should the default CMA size be increased to 256M for X1E80100 devices?

The default value in the arm64 defconfig is CONFIG_CMA_SIZE_MBYTES=32,
although most laptop DTs individually add a 128M zone under /reserved-memory

We should probably enlarge this value in either of those places, although I
don't know whether changing the defconfig is going to be welcomed..

Konrad


