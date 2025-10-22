Return-Path: <linux-wireless+bounces-28159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E46C1BF9A8F
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 03:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC9954E24B5
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 01:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0188B288D2;
	Wed, 22 Oct 2025 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GVYzx2WR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF01ACEDF
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 01:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761098351; cv=none; b=URJlfytUrqveZS4fYX06xeK/nQY52dhQ/3DSGbhgnOvR8SbqczPdL/DUHVt1T+3fDhYG9eucGkTKKaA70ZoXNxS2AuzMJz6UObAV0zMd5wZFezW83ercSkQYjwe5JQ7js8m7StjNZ8rN5W8sioB98CQlPgFwqFwBmrYeKv3Ieuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761098351; c=relaxed/simple;
	bh=GH7P2Z816MXeFIc54lW8I7MJ97fWpsE6LLus6ueQncY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tcaX7pMuy16ANgw9Tox4/mcd+mv0aSGhk8gKbdFvF/tNx+1HWO7XGZvlfGTKjFu+0B+cRrY9ZbRNHBfqYpx6GqnNpik1UUuj/UuEO6ZXmUcT9/sgM9tfopTKl0QhzxsWeYwXm41R5M9l3hVy/Zc7lI+1RU/LzpZjEdNsipf0bzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GVYzx2WR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LFieLD026555
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 01:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z1IeuNaDea5YK2zKyUZ4RwziKcJaa7Qo6G4eoyjFFNw=; b=GVYzx2WR4WyJJwD2
	j08SKgeMjohK+ia+qVEvEGSgh1+r3gWz0I1hB+Ot5oBtr3SHPnKwaxK6FBHAkBPY
	h2moINtIaiuxUYE2DG9w758qCUNEx16nZozEu/B2ghk8XnhpXDMJRPu0Zrwkf/8R
	Z/VihAX9fk8JJRuaxYgpnCjNSywl1P8mDUwMKpsC8ah/qdt1GEDxDmlNO4wD4WQw
	oZnySejonWzq8iAGonT/YaH23uVbELdBeUxBlwgTkfW4sbZRjSoBq9CqWdJ5Q/Dv
	LXUFY7+BDOcPrRH/o4lqTvyVpO1DmsMZ2mQx7QXFWkNoCP71FqpUGFIWCqlA1UHt
	1t/s1g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j2u14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 01:59:09 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso5274014b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 18:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761098348; x=1761703148;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1IeuNaDea5YK2zKyUZ4RwziKcJaa7Qo6G4eoyjFFNw=;
        b=p5vF8YZhSmwLw5LvAP21EkndkXETdURJAQBf/FtTHHjBsYWkejS4LHuTtrj2A/rPNt
         FIAeK/NFnhOOrfx9x+BB12zbFBbKgJaQsAwg4WQy4PpuFxjuYak01tiJLcmDUUUZz6Te
         Y/Taz3EfRy+At1Es1ylS3pXq74ye2cJXMz7VCsZfn80vEZBz/EvESZlyC3AmCvRklw6h
         8JrPWYriFwy0IiEyLVKZc50I7106OuEThQWJB3BpDkmtMvQrZeiTyzzku4gNR70hVdKM
         F7TVAwxB2Gzm/VDitlRm/Jxsk2G/XgD9u9ux3GbfGBLN3DbY4aA+cc0b8rRCtu5wssad
         KTzA==
X-Gm-Message-State: AOJu0YwT8ESVAaB1oKfyR7GC1qiakYrtFuSuE8dPaiBARQKpnNRgCCc0
	SrTFrhhebWDiSQFrP3J6lhW2Mgn/nce87f2X4PkegMUv4IL8ABEdz+oGohdts9wx+9lVqMjmY/W
	A10n2QJQTlvGloz6kySiRenK9ce+6icYcwtmOESP3pzINA7KoHIUdAt96ZsO/HLcXn1MoSA==
X-Gm-Gg: ASbGncs0JlxmGpVP6iRCT3Fz4fjxx9BlQhYkXo429CO8Tjnv7tu0N/op1tySBF6igEq
	aJo5rXmSTC+bwBW6CxML9xwNVesgf4/vN22lPBTICCiaj8TjMzhmCWfvMSaGwCF+Cf+bbXWSxze
	LyjyMmyNbxD+XSMd459KAbVoZFjykE1Qh0Hwg3kRqxZOnlg0X316RGV3RmesjEpIkNtF4liNIcM
	FEqNLCdlguYwyMVfYpkh/pEcbiTFsR16v4ckSLUqijfSsqOqHS2fE0fk4t3Q936fIzoLKzLS5Cx
	yZAGFKq+ew4oLnWwlomyAuXZdcCsTokcBEtUEByrW1YKYv3O9mZKeQMyhFvrscNwaD/K9c+O0ZZ
	ZrekMyBVoumsMpwOVPL5K5WHwpZXqlw2Un+vL+Igzh5xXpRIRtaEHl/BN8OxWxyZacHd0+jS2
X-Received: by 2002:a05:6a20:1611:b0:334:98c0:9c3a with SMTP id adf61e73a8af0-334a8585723mr23162902637.24.1761098347819;
        Tue, 21 Oct 2025 18:59:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA3Ow01RmsRCtTan9tz/juMLr3gv7kE5ADQ1R9VputSABfYuzoLi42dtGfxiqZ1ISudZNqwg==
X-Received: by 2002:a05:6a20:1611:b0:334:98c0:9c3a with SMTP id adf61e73a8af0-334a8585723mr23162879637.24.1761098347339;
        Tue, 21 Oct 2025 18:59:07 -0700 (PDT)
Received: from [10.133.33.122] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76676a2esm11489091a12.15.2025.10.21.18.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 18:59:07 -0700 (PDT)
Message-ID: <1f49fc62-9416-4443-ac47-e67fb7836797@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 09:59:04 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/4] wifi: ath11k: add support for Tx Power
 insertion
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX3zqJxpIMoyFF
 7hCg64Uc0BxFOrSmeOK1gIUmqs/LsGqKNWJ7pFCVMlqVS8M3oP3cE0a8pLnGByU16nHhfkUiI/N
 I4/34wnrt95GB7N4M8c90sVJ8CBjlbSKrWTpQaB5wH5YHO5EKXThCDc55hrJC2sWfFSM8nYwYuI
 r1uqS1aK16ikNEOD2EvGEeIWlg5b5twwwuZ0Hwzb8i4doHGzKGZVHWHczILRc6FkvpbxYcZuHFL
 Z/V+aVUqUdAn6YMmYmPEiH6pp7xYygMMCyE+XqhDcKEgxXfGX5lHcRf5Xriy91UCGokgDJcS27i
 /0GU0/LknY9VqwOVnEHPZUb5hhqU/n9pvIyLHbFCjdN5IfZNaL9T3P5ORhxpFtJGbOAA3AufOVB
 7BPH8b3USpUeZSLoXz4DMo+uIsoAPw==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f83a6d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9jhMNZ7qWXdoG8tHMgQA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: HrsRJiezAWQqjyI88jH88mf0paIA6Lyr
X-Proofpoint-ORIG-GUID: HrsRJiezAWQqjyI88jH88mf0paIA6Lyr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018



On 10/17/2025 12:07 PM, Aditya Kumar Singh wrote:
> For certain action frames like the TPC Report IE in the spectrum management
> TPC Report action frame, and in the Radio Measurement Link Measurement
> Report action frame there is a requirement to fill in the current
> and max Tx power of the device in the packet.
> 
> Add support to populate these fields in the relevant packets. Advertise
> this capability from the driver using the feature flag
> NL80211_FEATURE_TX_POWER_INSERTION.
> 
> In software-encrypted cases such as PMF, skip insertion since the packets
> are already encrypted and cannot be modified.
> 
> Patch Overview:
> Patches 1 and 2 serve as preparatory groundwork.
> Patches 3 and 4 implement the core changes described.
> 
> For context, this ath11k implementation is adapted from prior ath12k work [1].
> 
> Reference:
> [1] https://lore.kernel.org/linux-wireless/20250630-support-for-tx-power-insertion-v1-0-77f45484d5bb@oss.qualcomm.com/
> 
> ---
> Aditya Kumar Singh (4):
>       wifi: ath11k: relocate some Tx power related functions in mac.c
>       wifi: ath11k: wrap ath11k_mac_op_get_txpower() with lock-aware internal helper
>       wifi: ath11k: add support for Tx Power insertion in RRM action frame
>       wifi: ath11k: advertise NL80211_FEATURE_TX_POWER_INSERTION
> 
>  drivers/net/wireless/ath/ath11k/mac.c | 447 ++++++++++++++++++++++++----------
>  1 file changed, 312 insertions(+), 135 deletions(-)
> ---
> base-commit: d5ce93f136fbee2b7afbe221f34ca881036f8de3
> change-id: 20251008-add_tx_power_insertion_support-e5225e924bfd
> 
> 

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


