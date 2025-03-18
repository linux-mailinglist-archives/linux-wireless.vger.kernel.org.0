Return-Path: <linux-wireless+bounces-20508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7205EA67C46
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 19:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE043B6857
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 18:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F89420F073;
	Tue, 18 Mar 2025 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MlkrNYcy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4CD1DD88D
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324005; cv=none; b=Cnnc4iYQXDWlbgmOOALpo9kLa3sEft+j3KrAw4EJYSTOCvDNgcblV1pX0b9Pt5YkKG++prEdp5yH8wtXDl6nwyI7AXaGminh40upkGby/in757uHyAOZoEvNxv0FbDBd8XkOmbAokT2BfkvVDLFnXxAdcJNJwsT8/uvlOyx8c2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324005; c=relaxed/simple;
	bh=wAcLtNQ9o/zh9L9fmBOLmPpVjd28dTosIHtkS8e7msk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfqvJ5vo7zrw+IWA7mmRfIrt3vZqwDoCBvzL0z0Ipu3oRcsjB+B+bsqXOhdef4GljUBSJtHlQzs0umW3vDwFHehx1LigQbG5emwHz7uK/Hhv1xJ5tYfKqUsX7uSpll3sa1UQqOm8ul35iXYejfldd2HGkxx2cOM8gjBurPetiog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MlkrNYcy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IAluld010487
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 18:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FzUJl3WHjhcEBJ0bAL4awWr4SphxOz4pTp92LYZRfvY=; b=MlkrNYcyX6P+NZu7
	S/IjSNcNXHDT1ZgF9dfbIUM7ZscfiVHKGBdlEEubNoQWMRqQbG4VGEAb8z4EPQGo
	TvYsEAJv251E0GKevM+62pMfPGk3rlJlidDoLJ0R/VLNATL94Y5BP94b7XNGeKK5
	oDSG19Qc1Q9NeBnGxdYMTWAaZT0hAxtVhMqxq1h1MYe6/6ln9x5s/AX6oxifMfSt
	+TNyNuxexf1kpW1/GCqngTiA6qqL022eG5dp4FzJYFbUWNBlwO+wInTcKn6iSuVJ
	FVYqDbPxrPqeezT3bu6ph7hT+2uqP87aDPjzMl0oZ1pzqhEdKHnkNiVkd8/jxo4b
	wpxN9Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exx32xep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 18:53:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2235a1f8aadso92522475ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 11:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742324002; x=1742928802;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FzUJl3WHjhcEBJ0bAL4awWr4SphxOz4pTp92LYZRfvY=;
        b=Z7HpW0w8D+TU8geh8209L9+9SJeRDgwVIuuCH34MgfkpnYkdPKlEmE0+wqI5oGVti4
         3+Kd/IbBAK5N9nvhDD+d9zF99EwzGLtwul5E5kk3rHP4sMs7WsxPPel9Phrv1yBo3+1t
         5ZlLrPlHnfhAxhvoVM1FTlPQycmXqgId7dEycZWWI+E9VNvErp5eFujUqt96H0cKjdj8
         uFf/YFHXU5V5qXugHfTkxcRD5s+qAMoPE8QOX1wJYeteXcMEPV1AD9fiYz2TUrJ22hSy
         Z7lvioFYEY1XT8iSU07GbCs+CmgDnmN2X0TF1xdH281QcZfgDBIIEJL5cY5cw3VQhjEg
         tDBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjvk5zz6nvtQNdN2xo1FUbbwVXEuOKOsFmVehzqg7E8rjvGWGNup37cD6anEA58NkzypbTPlev8NAocsKqEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAVYnuPWjvI9otf5PZykrMhq7BMduDAbe0xOHDSj20r5G4Mfk3
	gaxBa/31ZP+5jn8w3xIn2FDVw+/g6JLqHkDLlSIkZ3vPtzVdcZp5SHZOvKasU5Bc48YXyusTokx
	fbEmQlBMNHlp9NDcTwvLqwZ4qBtTtzNVT6Sf56+IBaShk2uZwOhJHFJ24W6wwPtgZKw==
X-Gm-Gg: ASbGnctNmUs0mIunlJHHcP3BDVjEcZwENcnhjcab74kap6NsO1U/9DufTVBLoqCezwT
	3kjVIUQ87t/L0za6EZq7CdjQT+UrA2yGfdtpHilk+qETA9nSB/JOoO8spinFmH1xtpj0iZbXgAL
	rbzE7IwbsZLFH4VJRPuHG0VyQmNDSYUAMSzRE4HV+ek3DH3G7Wq0aFGQ8nPtwYEdjfji9MNdgbD
	QqfdE0zGqTebcmKO5QkRzyuZcLheYYtjV0UQBVcP/fX3LiEnBSUFVDc/J10BtviwxDJnpxRsgYP
	+30m6pkf4qfAsO/ONIYPiHcgnKzgSaEPTCw1lOlIHRPfPkxMj7kH1Y/nFm/cwAMntc8E+Qw=
X-Received: by 2002:a17:902:d491:b0:21f:61a9:be7d with SMTP id d9443c01a7336-226483de49cmr1686305ad.49.1742324002096;
        Tue, 18 Mar 2025 11:53:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRFs/PZj/vX5LmwWSynJGPcDMBE/XufCjD2tu+h93eucTtabPbXuyusrAdyiZO2jXqnhWxsg==
X-Received: by 2002:a17:902:d491:b0:21f:61a9:be7d with SMTP id d9443c01a7336-226483de49cmr1685885ad.49.1742324001687;
        Tue, 18 Mar 2025 11:53:21 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd7bb4sm98124335ad.237.2025.03.18.11.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 11:53:21 -0700 (PDT)
Message-ID: <8e5b0ae1-ea1b-4dfa-84dc-c53edd2afc42@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 11:53:19 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v11 08/13] wifi: ath12k: add AHB driver support
 for IPQ5332
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balamurugan S <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250317204639.1864742-1-quic_rajkbhag@quicinc.com>
 <20250317204639.1864742-9-quic_rajkbhag@quicinc.com>
 <683b16dd-a3e9-4cc3-836a-95f3747d3c0a@oss.qualcomm.com>
 <0da16aae-2fa3-49a4-bdd3-f08a7655365f@kernel.org>
 <f35a6080-8dbd-45ca-8fb4-d6b01a5bb007@oss.qualcomm.com>
 <332db13c-81db-42ad-afcf-3a4262344bf2@kernel.org>
 <31b4ca9c-892a-4ba5-b006-95deed6deceb@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <31b4ca9c-892a-4ba5-b006-95deed6deceb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=b+uy4sGx c=1 sm=1 tr=0 ts=67d9c122 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=fXXGRLuD1ZcmTYMWEx4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: KbKvEuz_kAgBC6UkaWUSEXEnlrkdrdzh
X-Proofpoint-GUID: KbKvEuz_kAgBC6UkaWUSEXEnlrkdrdzh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180137

On 3/18/2025 11:19 AM, Krzysztof Kozlowski wrote:
> On 18/03/2025 19:16, Krzysztof Kozlowski wrote:
>> On 18/03/2025 18:55, Jeff Johnson wrote:
>>> On 3/18/2025 8:50 AM, Krzysztof Kozlowski wrote:
>>>> On 18/03/2025 16:44, Jeff Johnson wrote:
>>>>> On 3/17/2025 1:46 PM, Raj Kumar Bhagat wrote:
>>>>>> +	hw_rev = (enum ath12k_hw_rev)of_device_get_match_data(&pdev->dev);
>>>>>
>>>>> kernel test robot warns:
>>>>> cast to smaller integer type 'enum ath12k_hw_rev' from 'const void *'
>>>>>
>>>>> looks like others have fixed this by first casting to (uintptr_t)
>>>>> a few examples:
>>>>>
>>>> Cast via (kernel_ulong_t)
>>>>
>>>> But another point is that this patch at stage v11 should not have
>>>> compiler warnings and it's not our tools who should point it out. Except
>>>> W=1, all standard static analyzers (sparse, smatch and coccinelle) are
>>>> expected to be run.
>>>
>>> I ran what I thought was a reasonable cross-section of builds and did not see
>>> this issue. Seems this issue is only flagged with config: um-allmodconfig ??
>>>
>>> Guess I need to add that configuration to my builds...
>>
>> This should be visible on every build on 32 bit archs.

Yes, I'm seeing it now on my i386 builds

> Patchset does not apply neither on next nor on on mainline, so cannot
> verify... Probably another problem to solve here - some sort of dependency?

T:      git git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git

The series should apply cleanly on ath.git ath-next branch

/jeff

