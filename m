Return-Path: <linux-wireless+bounces-30911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC300D3326E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 16:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2307301EA15
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 15:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB533191CE;
	Fri, 16 Jan 2026 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cVJjBioS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gRwka4On"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A42EBB8D
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768576735; cv=none; b=XgsYcrfyJdDTxIrt41JjEmZZq+twQEG23yXneveESIsUOiw2kZxml3o0iy51/lD/IyR68mqGGfFVuCNgyNa7XcJPoEzpe9vy16s7NBKJIniSPQEp3aByG8W2gO6Z8T5/2wa6aadxBwmkc7p5d6ojp/5dvnJMkMEv2fbAUIUqKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768576735; c=relaxed/simple;
	bh=q/2i4QMctXHF+dDhlqSpXa8ULXx0wN8PBam97iLzyx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/umnNNlyYzHxlNgPxxruJisWGVS5NCqtKAbtxRDRgy7yaL7pRsyMcD3zybhHVLJIQTsefhvH//HrX/+FNp8HATulmOsj0RDAjeAZJVCqu0Mo1NuUjbvFnlsAyhwkkY2ATBsFJ4MupTtDnNU7l4Mc670M+7EygNcCTutOEReLSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cVJjBioS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gRwka4On; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GDWVrf1300780
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 15:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XRcRwBypFQShmuN0jEyzBJtIwf6t2aDrIBCTyHNhTLs=; b=cVJjBioSxB1YM+YY
	RD/27+OD87cRm4c4XZ/ogHSNFlOO8viEL7BYEuV7xyqP8RUVuydBEEiazoWosaUe
	9Abv8bYRdOhVrWCtF2SAgUfncEMV50B+RqA/TYTk7TPa2nncozkQjPgWi8bsgHWK
	GA/kB4+nGUz9VhuXS5IMarQHEA9f122rrrTy15vq4f/B1+/bF4zzDmwil/je60Gq
	Y2+HNvObXdlUfEpGAE3gA/TMANX1D/GWoQZ3pc5xOXrBgtUID1NGIp5GmV8CjGrE
	XvjYFnBZikD5fE4uSa11axV1i05KIGI6xwQCtNXpddTFis2V4APEtLy+qNe0opXt
	1+j1oA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bqp9x89wt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 15:18:53 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-123308e5e6aso3940982c88.1
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 07:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768576733; x=1769181533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XRcRwBypFQShmuN0jEyzBJtIwf6t2aDrIBCTyHNhTLs=;
        b=gRwka4OnfqkmCqwHfOo322XVwx4GjXUdUVOU5HggIn4ohOLEDj7kRQNwZDEOEnCBcu
         OcXOsnBMCHyAhbiODgMJhrl4wFdJmBaJwStfV/74t7k+nfSkeXUZIhXteDFloqR9P6wR
         +WMQCpLxdvarlKqWW0Ol7Nerg9cYdkrQSMgDpmel77XpJsFRY5iulYHg+UrHS3TojyyR
         clPwkqzb+Hf5euA/H9dNGv3CfhytMbi+pFTKEHdL1M6IwyD+ybL0hWpB08t3e3gUy4I9
         9JkydzcTBirXZiEDRJKfeCyMH6H9GulHlgTEreTiJYRwDUxBSfAzxiqagONyBeTSl74S
         otQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768576733; x=1769181533;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRcRwBypFQShmuN0jEyzBJtIwf6t2aDrIBCTyHNhTLs=;
        b=OXHRt73nEWmUl/HPVC4f1Y786zF03dhiizWBU8w4jYlK7DZSit/ZLPKu8UNX3EQpRo
         34ZzCFcE5TV6sYblZFNJOR4w1eJ34u/wEsjMAl2PBQZljSkuUri7vHo3zMXCaGX6eIMh
         d9JcTT2y9GAp7B7BiiQJtf1r5Fo4tXg7pxxLJoFzJPs+6COCUs7ebgTIVNt8/OIL26Ge
         2FJr1RONExXX12J74hJTN1mbFWUpzCrSfpXDn+/8jFkwcvBA7yr3gcn1/BhMcbe5rUq1
         QG6YnhCAO5Xu6pzLLTDtv4fZEQfuKLDFhUKPA7Dn882s6N/X6hhdXsh6zfRHT6tIlpn5
         lkYg==
X-Forwarded-Encrypted: i=1; AJvYcCVqUIZZGuW9d0rmE8URohxrmPvmkqQQhI+UuLKZ2oJ0KZXho8XY9PaLidhuZikW6ak+QEkXS8OfS3PS4uWeRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YykTDxzvuG4VLB9RI15iv4Q5+bm2wNyJoQ/B/lQAXAYtM557Kjh
	rp02Lo7fpILxn6VccSjqlgK7AspXKJ3aKXdeLWw5bgAT+cySCByBBGAqy1EKm/xCX6mzealWH/O
	pmWiVFCHw5QgzY35e2xoK0mdkaIuOBmeDl+fhfVdUxLKFneTyYYME7KWV3NcLW0d+gW/uMw==
X-Gm-Gg: AY/fxX4b7/PBzlOOqhpW6URGMAD/GvpGpi3G4GqGulOqQxs85KRXK5Df8jm/VtjRQFa
	GpE2N+a3lTH4N6895P57P1J7TjEPIi92e+l0vWOtFKiRSXj/G4zFsxiQ2nWOm787E34rC8rzTvy
	LH1ZQfoPlxmpURh4FavdBLVnSz4XlpVBSA81AwI8/V946J2ZC8AQeryEqCeGEvz4AIm+aYEWRDV
	Xroxu5MM9cayOrhN6zIAq1DlBiZrGkqzuFdtwDyYu4IESNkA56/qyGtMzcYDMVbPAVpjCDoEQsv
	EXEOTqcPhQQ3KdzdT1l36ew5uvikSdDrQun0GTT67jyIYdXsR+kV68WBYf7ZNaacVVdhDVsJqTU
	DVGPA1ykgZQaYvkCGLAbh+AMFtMqQlz1RVuL2vMIn7+/tOn+ZMrmdXmhdtpA458fQ3aBtPH6kTy
	sZ
X-Received: by 2002:a05:7022:4185:b0:119:e56b:98a4 with SMTP id a92af1059eb24-1244a6e070amr2977279c88.11.1768576732813;
        Fri, 16 Jan 2026 07:18:52 -0800 (PST)
X-Received: by 2002:a05:7022:4185:b0:119:e56b:98a4 with SMTP id a92af1059eb24-1244a6e070amr2977248c88.11.1768576732230;
        Fri, 16 Jan 2026 07:18:52 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac5842csm2773177c88.1.2026.01.16.07.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 07:18:51 -0800 (PST)
Message-ID: <132c34db-07c6-491b-bfda-f3c51462a184@oss.qualcomm.com>
Date: Fri, 16 Jan 2026 07:18:50 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] wifi: ath10k: snoc: support powering on the
 device via pwrseq
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
 <20260106-wcn3990-pwrctl-v2-4-0386204328be@oss.qualcomm.com>
 <52b2b799-09e6-40a4-bea8-c7e8bf21cf51@oss.qualcomm.com>
 <15470b51-d398-449d-9017-304df5ad7cef@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <15470b51-d398-449d-9017-304df5ad7cef@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rwo9m7sNTNYTBOM3G8u8id5CN7Lk3d-b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEwOSBTYWx0ZWRfX45pSjEbDSHvp
 O1GdGSwPlujj/wXzH6X+X+SxaPN3MeaBGOBxwH/RsT1WNLVu8sTLOUlfc96axJbPjd7cbQojcmi
 cDrwfhzC92TxsmF4RkA4upgdipycFf1CP55675t18WZy7bJAwLHvE0wk8hrFx93qcUwd0l6zkWq
 wxSj3GXzeEpNsjpX4o2QZfik38nrdak2jqvsBcP5I312KALu1YC3mVIUekydKXcq6QqFN5Z5tGk
 dn1NMbRmhaIlSPprXij76n9LJ5OdqNxilEhcvJqM7XRyrehFtc6Yx4/Gim353fh3b+b0P6hcJ8O
 XkJwprS0VHRFPzsFvO+ZpvlnPYg6Kc1Vi+DUTXuV9qpIw8IatIoCuOq1kUYmrWXKfq8pxMmRl7v
 YbHxM5wWY1jJgkyQJdUZnjlLUdEcva9yh4wCIWVYIhy7jHHkmAHxf+iPrMJLtzvcRGjM1RdVkEj
 O3xLtaX14wjHMd02fQg==
X-Proofpoint-ORIG-GUID: rwo9m7sNTNYTBOM3G8u8id5CN7Lk3d-b
X-Authority-Analysis: v=2.4 cv=bYpmkePB c=1 sm=1 tr=0 ts=696a56dd cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fl7gpmSGIpyIZsR_3woA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160109

On 1/15/2026 11:48 PM, Krzysztof Kozlowski wrote:
> On 15/01/2026 23:30, Jeff Johnson wrote:
>> On 1/5/2026 5:01 PM, Dmitry Baryshkov wrote:
>>> The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
>>> voltages over internal rails. Implement support for using powersequencer
>>> for this family of ATH10k devices in addition to using regulators.
>>>
>>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> ---
>>>  drivers/net/wireless/ath/ath10k/snoc.c | 54 ++++++++++++++++++++++++++++++++--
>>>  drivers/net/wireless/ath/ath10k/snoc.h |  2 ++
>>
>> My automation flagged:
>> * drivers/net/wireless/ath/ath10k/snoc.c has no QTI copyright
>> * drivers/net/wireless/ath/ath10k/snoc.h has no QTI copyright
>> * 2 copyright issues
>>
>> I'll add these manually in my 'pending' branch
>>
> 
> And why is this a problem? You are not here to impose Qualcomm rules, bu
> care about Linux kernel. You cannot add copyrights based on what exactly?

I am a maintainer that is paid by Qualcomm to perform that role, and hence I
have a duty to enforce the legal guidance from Qualcomm when it comes to
contributions from other Qualcomm employees.

/jeff

