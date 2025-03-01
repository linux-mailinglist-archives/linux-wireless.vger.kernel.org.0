Return-Path: <linux-wireless+bounces-19635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB56EA4A8C6
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 06:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051B41889867
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 05:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8584D1A841F;
	Sat,  1 Mar 2025 05:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hYndMg9Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F92F22
	for <linux-wireless@vger.kernel.org>; Sat,  1 Mar 2025 05:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740806355; cv=none; b=K2iLm96yapzj1QYsBPesXdFIfpKutAsSEPd2ToM3SyjcCgDx4y4Qy129yq1VwMNZxNRb8yR5hmZ/1ejZorj98fU2c1+TVR/wpDrvmf/3uZ3/0L/2ouP2d3oCunuoQ1cO1npiOD2ZvuP52/WutL0BakXxSa8vGq7PziS3ekuaEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740806355; c=relaxed/simple;
	bh=tu6Sm0hCdUZksAy8vutcJzdANnD13tljjz4kIw1SKbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FenK0fQk6vXWclQ31ANQg5qdhQd7ok5eCY/ZuHmMXBclk6w+aMyqpdhBGD0noRNaT3GfRyefuGpykuc5YT1oWDhLJzAlaZqdqrEgEF9zgZHzWJbeacgvSiNqRlEecgR8VS/q/3/GdGlczkL6GpPIC24YkXYyIYRD4X46XSU7E7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hYndMg9Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214BpC4027122
	for <linux-wireless@vger.kernel.org>; Sat, 1 Mar 2025 05:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fItfMe60bL3KBr33oQ76T2mDSO4Mwd15Hpg9wQXBud0=; b=hYndMg9Ze+m08WSz
	4NKTdcptpWjT7ezxu4EUah+SHYRFgVxoVWUVCmFOfnvAqxVZJEzaTUZ5+EbRqBMe
	RUkYdiPkNIE1E49Ns5wapD4FTakrU/aeyomSAXz3EbngxkQZkJuJQqVYnmb2NqT7
	zbf2wGuwYEw6y+irXUJCStH5R7ecaAruOABJcpcqTDJ6GcdPMgunynAOXMIGzFQF
	tmYIfigeXN8QN0tMWlTJ8NSAy5kLqixp3WghnvawaHztdbwCce8h3v4Iki1Q5sWj
	eR0goC/TFYLs1hVYikzguN1rG0o+6ZOSFoYzS3MKvGQ3o2Th5fV0dvNoRo57KsY6
	ZdJTZg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453u0d02r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 01 Mar 2025 05:19:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2235a1f8aadso40478595ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 21:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740806352; x=1741411152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fItfMe60bL3KBr33oQ76T2mDSO4Mwd15Hpg9wQXBud0=;
        b=JIiWYo0QgpJ8sjwgnwW6LpubmxiCImA4HiD9KPTbv5i9d+4IFvjLgjVOETplk17gFj
         fQKQlefGg7oKPAUGZWqtuvncWC3WJba3X1iqj80VXj/aKTbvCE1MYoOWJGl0P/VO7qtO
         0G3r4Mb4mf09vp5z/FtH7tJFD4fNMi4a+iSfHkn2htFf4WUzanvptO74FBhQG05OMXrI
         8FYl+8tm5KY0LPd2vSA+9kk0vXczDM62RyEpdsLQLZS6DQ4iSlyXhiFjJcbklZyrul5q
         ead0ZgcP/FyAhS2gVs9+gD1H22LKG9bMnkHE0W+rYd+0j2mJe8hGEyJVbtyfUd7cRQ6F
         my1g==
X-Forwarded-Encrypted: i=1; AJvYcCU/2oTQMfUyF8BGqaU/lhOM1P49eagN2IfUnd92vzGIdPWrhEYK+c+7WYht02SkwCy/Chp6cokkhihHD2cRlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvgND/+haHf7tdBKPM57fR6O/6isqjtg5UsOKCm68FigjqjKYi
	SFgGZYoegSun9gQzDqEvRB4GhNnUZtLA04Vq/JsRbFlDXnBQtMvcd2ZJs6/e5N5xMxothvsyqce
	HoZywTnqRAtVwoYDdRr+yEITg3lm5jeEhcizNcnZhe2TAeqS3RRhVqHFCLWHaI03yhg==
X-Gm-Gg: ASbGncuE81WXz5ufYpERzROJkuBQXoE2iAQ/cayAUC5nZ/Rl1r84MwNoT4tIKf6kMFf
	bHugWHxEq1qIL7GVGoKnYOChEGEwFfqoZP2A8a5AvTXe/4hEaewBGW8AmW7Oelvmwt5Hal7jumw
	tCZVv5IX5Jp1hyzbWRSlT7D0Ur6kZ4ymINKIvCVsetRRgWaijBi/nTsVdXBHcL8xNXVrtjWUsaw
	nPzUwY7EBnxzJvNvddkpbMoOQrvzra7s9FFB2GekQ+aUZkcOGUj4QZwUxEDtaCPlc6nxGInkx0U
	joSvVNB+PbT61Ozf8XcrPGGjhxcdpbUnFr1g4dnsT+VbCjt00Rrl0RLTgmUJ52Y=
X-Received: by 2002:a05:6a00:2d8e:b0:732:5276:4ac9 with SMTP id d2e1a72fcca58-734ac35cce9mr9750328b3a.9.1740806352534;
        Fri, 28 Feb 2025 21:19:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEir5MRosoUYpbeb1u+Qi3ok691SR2Z4tKIzWpFn9/rNRTWboX60CDNLHbz04mtMwAbblyS+g==
X-Received: by 2002:a05:6a00:2d8e:b0:732:5276:4ac9 with SMTP id d2e1a72fcca58-734ac35cce9mr9750299b3a.9.1740806352169;
        Fri, 28 Feb 2025 21:19:12 -0800 (PST)
Received: from [192.168.225.142] ([157.51.160.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a00400absm4673454b3a.151.2025.02.28.21.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 21:19:11 -0800 (PST)
Message-ID: <fa72ddab-b2be-3481-8e33-e0dd30e3e8a7@oss.qualcomm.com>
Date: Sat, 1 Mar 2025 10:49:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 12/13] wifi: ath12k: Power down userPD
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
References: <20250228184214.337119-1-quic_rajkbhag@quicinc.com>
 <20250228184214.337119-13-quic_rajkbhag@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250228184214.337119-13-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rdHRojcCfYkjOeq2kg22FUjbWv_w7lS-
X-Proofpoint-GUID: rdHRojcCfYkjOeq2kg22FUjbWv_w7lS-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 mlxlogscore=737
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010038



On 3/1/2025 12:12 AM, Raj Kumar Bhagat wrote:
> From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> 
> Set the stop bit in SMEM to power down the userPD. Wait for stop-ack IRQ
> to indicate power down completion. Release the userPD firmware using its
> peripheral ID.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

