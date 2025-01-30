Return-Path: <linux-wireless+bounces-18222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FAFA23251
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 17:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC4B18854F7
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 16:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F266413FEE;
	Thu, 30 Jan 2025 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IcKySbEh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF135968
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738256083; cv=none; b=fwX5smZF8uPeJXf4fi0bZedQ2u98/Q0cCjsd/b6+nrKF9wV1l69ZNLXUFa3bQqvix7j0sxueIxK0NXBb0IwMIqkPJfuae798pGNM+IzlitESyuebzcF/WDD3FPDUott8qpaGTRS0dRVhGBV/MZjlhA8RTOo5JV3ia9VcSYEshAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738256083; c=relaxed/simple;
	bh=tG18MtUn9mluG9fmcNm59PZm8ut0oNmlSHAN6J4XL8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twissaCOHu39ivWBr18uah5hP+6r0U8A57GxftfiF7MCu1kGVXHNWGD+/Krahs8JGlCCWV4CCRHZs40xPaP+0gQ9+l+F1HpvJFgiogAjgWNB8R/wc8W9E8tsD0p6CpSFxtcHlppJ1j/jtwO84OnYuYmejWgPXJb2Kpg2NfqzVko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IcKySbEh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UE3VLr031776
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 16:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DnBnh8T7Kvj357Hv/Lsj7BVV/t4Dy5jgErNn1Lw3hmk=; b=IcKySbEhdjzK8lhL
	CSiJ6FzfBlkJR7xgpGA5oaAciLY285pBjTB95bf44BiZT6B7/vPe5+qBS44DdAcW
	4nnY9MlVRdjkqJBrk5QAhk3ZLNFSrhAKjjZBGxr24QpJUIUD/oiPrCTDPvIcdTjl
	PViKLn4tqGWslAa1cYSsDCPm96yISG+RnW63i0pUSEojq5iO4pXfhIGm/GqEGO0f
	3/+x13Jxptn9bI6siasEyGfwgt2VpX2B00+gKH4nhthO8FULJhazl7syVqPoDCLP
	IUuShty08hEZSW840+1dIIHl2w2iqmzSS5aJNxXt0BMHFSvAwIA3SqDRJivgssr1
	DuYfrA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gauurdem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 16:54:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21632eacb31so14718455ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 08:54:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738256079; x=1738860879;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnBnh8T7Kvj357Hv/Lsj7BVV/t4Dy5jgErNn1Lw3hmk=;
        b=QdbeRNS8uRMgawSyydTrq0UrGRVtHOR/Ut3cgHNLsocA5eqHdYSpy8IDiMwYhlX2wV
         x0JvX4zPW5+Kc2SgK72yRPepAdXGzIEHDTSHXpdWwwX2elPxykAEX4/OGkFEjSbraLBe
         IZhMExOY3owVG9g9bv5SJ+Nu32kbXMpntNgyT06J6JTooWXR0VQcCduHdRpuZtTKmGol
         J8EBVd96nLhcfPBa8En1rnBtdEHwDRUKGNuuoqhg7juX6SpvSTNIDVspq1gHLmsxVJaL
         rj2A0FCmQNkfnv0aPE6ipJoAmjXyYvD/E7lAqJbZKYbcznEcIXS8VG6vRiwX6PURNDLM
         r+Fw==
X-Gm-Message-State: AOJu0Yzpk2AzdxWyFTtxH2Lr8okEN2dQxR8IK3d5K12DXNvdNUmxoGOk
	ApFKRkMbQ8XkRa9CVrJyAzuev5647j2Q/9XfeNENkOCQIDoGg6al4v2awY38oIlNEcy3iQLuFdZ
	DSCaKbUuhIq86MqyRRh09042W7M6F+eWFdW+Wew+Z63cPFTFAxM1c8OFxpb5YXRHfSg==
X-Gm-Gg: ASbGncsP6zeqDGKvy5CR7rDtCtCfgA7j0mGchQnFjWNFIsVEZR7TJ6a9EawRzwTQwyk
	11k5BbxXPhfTosVbK9PuKvMxqQu0n3kBKnECUa3MFV0BLU1X26iwUEuErvQcObowzruW62jwCbD
	0nKLwYqi1HuHciO7latPb/eBxbX1mhZtw8I4gitBCKNyK38x2olaP+EG+SrOI4dDH953eXbd6Zt
	KorR2KlBUqSdW3/TWeeYKTfyCzDIZjggd4TtnSEMlfkGXatq6pIHKR3DtsvIcPZ/EG4gF5UmU41
	ZL/QhmFJvyyZ5RF978533NYqjl7jtT0tRDNeA0ZqQg==
X-Received: by 2002:a17:902:ce09:b0:218:a43c:571e with SMTP id d9443c01a7336-21dd7c67eb1mr139210265ad.28.1738256079471;
        Thu, 30 Jan 2025 08:54:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3LBhjxvlcwe4lPSze32TiaSAtUucAXpsHRstoSfjnqvgHnk1hjloWbNQmvR5W07cMl9+KHA==
X-Received: by 2002:a17:902:ce09:b0:218:a43c:571e with SMTP id d9443c01a7336-21dd7c67eb1mr139209965ad.28.1738256079068;
        Thu, 30 Jan 2025 08:54:39 -0800 (PST)
Received: from [192.168.29.221] ([49.37.208.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebe8566d5sm1382820a12.35.2025.01.30.08.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 08:54:38 -0800 (PST)
Message-ID: <a307e8f3-e171-40ec-ba50-da9ab90cb824@oss.qualcomm.com>
Date: Thu, 30 Jan 2025 22:24:34 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] wifi: ath12k: Avoid napi_sync before napi_enable
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Avula Sri Charan <quic_asrichar@quicinc.com>
References: <20250124090058.3194299-1-quic_tamizhr@quicinc.com>
 <dd37c366-21f5-470b-9d4c-24ae2808c4bd@oss.qualcomm.com>
 <b155f782-feea-4b99-8edd-e499e313294e@oss.qualcomm.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b155f782-feea-4b99-8edd-e499e313294e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: m-psaRyIDnLk4ialsNms1DCNGX0P_3v5
X-Proofpoint-ORIG-GUID: m-psaRyIDnLk4ialsNms1DCNGX0P_3v5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_08,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 mlxlogscore=920 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300127

On 1/30/25 20:35, Jeff Johnson wrote:
> On 1/24/2025 8:55 PM, Aditya Kumar Singh wrote:
>> On 1/24/25 14:30, Tamizh Chelvam Raja wrote:
>>> From: Avula Sri Charan<quic_asrichar@quicinc.com>
>>>
>>> In case of MHI error a reset work will be queued
>>> which will try napi_disable after napi_synchronize.
>> nit: always better to refer function name with () at end. I guess Jeff
>> can fix in pending?
> I fixed this, as well as did some other grammar & formatting fixes.
> 
> Please check:
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/? 
> h=pending&id=a644c8784220b7d5dd0a10a45c5e6779605778a5

Looks good, thanks.

-- 
Aditya

