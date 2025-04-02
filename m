Return-Path: <linux-wireless+bounces-21068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94726A78CD4
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 13:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1D116EE4D
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 11:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D85214A94;
	Wed,  2 Apr 2025 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T8HAu1TC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F372F221DB2
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743591809; cv=none; b=DgnCnfeC+GVABmxijoWj7L2w4PvbntLXS672lZFOydy8Hs87y07RgFz4qbdWtgeUO0G4zAocqOAKzj/QR98xggXa0mtg/xfF+nFtMxPVxP6iIzZlaLX60eZmTTQBkZ9BA9uIo7J+hNsrJvunpdaa73eNjvakm1Fp4t/VCewvnlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743591809; c=relaxed/simple;
	bh=sfLjcIAfiBg1XrpzxsNxPKtDbK2WqcZh8PChSW7IXcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvmgjOsXznihsoNAdRSnQGhfQT21n0VZwXJf2CnLBQya1iVzDVgnYoZYC6lPkQcW3+J+sOpHY6a7Zaqj0VJgK85JsluJtZ52YWL+wnNB1/WPlyFQZIpCzVfFV3wuo748R5m/ofAvPGFbo8/3gWFB4KX3lZkVfNSCuXmkMcUbv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T8HAu1TC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5324OWI1024528
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 11:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	37YSkgzf76vapHfjEFdF6GlVCevcX9xaV9hoD7LO3j8=; b=T8HAu1TCsM1KAlgZ
	BGedrvrwx8ywMr7GPSHXhvLGgW20fD85+lVKftWSAz/gJkPKtcoVSfNJAHII5x39
	oljFTaUyqvNiYpHUAXX2s4lyEoU3k6lFHp+e/QkS9F8iAK4c40GWKjF0il7obeoz
	PWzZ9d/4QGBq4V67Ln7PLoCCYpuLYPh/SbliUxG6XGJrRPv3d1to3wxuKSG9QSJl
	WyTbL8zNE8+LHMgBP3vu4QwP+dHIGhWqqT/H62KMSGrhk7V05ypbYIm5DeEBpkNW
	XbkhsMlgCh4Bh5X5A7UPd2v2STCgAnik57cXRdmNCbcjRQc8CBihClsX6HHXPUyH
	mwMy6g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rbpyv77j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 11:03:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-224192ff68bso116692925ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 04:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743591806; x=1744196606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37YSkgzf76vapHfjEFdF6GlVCevcX9xaV9hoD7LO3j8=;
        b=P5mKi58f+RL735+bNhNsk8dhiEJLCD+TtcjG1W0jGWD0wP5FVy84vAwH6NGO3xnbPL
         aXgbFWNxiUQlZ4SONiufgk9EWkcGuIuwrFrKsNls/mcpDQfPMm4OrjII84cCG6DahEkR
         quzMsBtLff030HWRojguZMTJ1R69QIRlQ62HN6vRTqF0KD7xDfOo2KXsP72lYdzltsWG
         5i6G9SeBqGkSwUDdEX6NO7cKc9Cf+nsN4tBSqsj2cGAp+aoB8xviDH12+wn3RErmhaF5
         k5/Uxu2nFEMa92AYqr7EmJe9ydR0mAJRMHNoX+hWR3OVmJV3Enetcg1XCrK2riqon+zF
         /PSQ==
X-Gm-Message-State: AOJu0YyL8zbFxlfSDjhIsguBSOM6P4Yo4/tQl4xoAuHpicT3N0aEwWOg
	Pz/nv+VAH1fUg5BN9yPdldAH5tUz6KQEf39V8tuuOvvJE+PqDcNyfJaQOmJJVQhcc/JBTxbl9xO
	nwZ8qpY45uKcFjyXbdFSJ1HUfX6V/kwlv43PeoRKb8bic7JQfpbxtK2FFsADZ09jU7gUEeFtBJg
	==
X-Gm-Gg: ASbGnctDVPy6VG9v66FpuftwnwyO/Rly/XRPdgkDF/z2djzcOVRf5hNoNmHm6nXd5A7
	LuzC9SrMsiq9MXvm6E4vv+jt4gngIEbV8hz9fxVIccScIAIeGWSpCTVwWBGfuWk1WNRrS7n3uXd
	tf7RMAy4IwVH2rIhwY5GHV/LbpjtkKG4QHlqVhMyCqRYmQCyj2vhxyuzyVPF4iiDOFef1BHNWha
	EWJzhee/KbFTki0t5pvwtu4a3MZdW/NL0tBfu5HMt5wsqbEHITrM8FiuwrvyGk2MCFRtpqpw4K1
	L+XBdW/Z7vD9l4fejgOwrDqKdpQVzi8HhdddaUu8PzgwBQNgu4AjMisgrg==
X-Received: by 2002:a05:6a00:2343:b0:736:5544:7ad7 with SMTP id d2e1a72fcca58-739c78b2e5cmr2661773b3a.14.1743591805667;
        Wed, 02 Apr 2025 04:03:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1I8n+e4+gxAaSRGDNttbtMFZAYntRxi4phZburqh3fpAdPkmIXvurqT6A8VcMdH+Kqi0uuA==
X-Received: by 2002:a05:6a00:2343:b0:736:5544:7ad7 with SMTP id d2e1a72fcca58-739c78b2e5cmr2661736b3a.14.1743591805230;
        Wed, 02 Apr 2025 04:03:25 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af94d063c44sm7851775a12.25.2025.04.02.04.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 04:03:24 -0700 (PDT)
Message-ID: <b8787cb8-d86e-5ae2-a6f6-debea905aee3@oss.qualcomm.com>
Date: Wed, 2 Apr 2025 16:33:21 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v3 1/3] wifi: ath12k: Fix the enabling of REO
 queue lookup table feature
Content-Language: en-US
To: Nithyanantham Paramasivam <quic_nithp@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>
References: <20250315155159.2475885-1-quic_nithp@quicinc.com>
 <20250315155159.2475885-2-quic_nithp@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250315155159.2475885-2-quic_nithp@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: otYRStB3CorgBbZ5P0Iy7e6qAwBWY0iI
X-Proofpoint-ORIG-GUID: otYRStB3CorgBbZ5P0Iy7e6qAwBWY0iI
X-Authority-Analysis: v=2.4 cv=ZNLXmW7b c=1 sm=1 tr=0 ts=67ed197f cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=Bc5PXK_X3qR6rtLNObcA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_04,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=796
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020070



On 3/15/2025 9:21 PM, Nithyanantham Paramasivam wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> Instead of storing the REO queue address inside peer entries, REO
> hardware module prefers them to be stored in SRAM which could be
> directly accessed by REO using peer_ID/TID based lookup table
> mechanism.
> 
> Fix the enabling of the REO queue lookup table(LUT) feature by
> configuring the LUT address information in the REO hardware register
> and setting the host service flags.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>

Applying: wifi: ath12k: Fix the enabling of REO queue lookup table feature
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/dp.h
M       drivers/net/wireless/ath/ath12k/dp_rx.c
M       drivers/net/wireless/ath/ath12k/hal.h
M       drivers/net/wireless/ath/ath12k/hw.c
M       drivers/net/wireless/ath/ath12k/hw.h
M       drivers/net/wireless/ath/ath12k/wmi.c
M       drivers/net/wireless/ath/ath12k/wmi.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/wmi.h
Auto-merging drivers/net/wireless/ath/ath12k/wmi.c
Auto-merging drivers/net/wireless/ath/ath12k/hw.h
Auto-merging drivers/net/wireless/ath/ath12k/hw.c
Auto-merging drivers/net/wireless/ath/ath12k/hal.h
Auto-merging drivers/net/wireless/ath/ath12k/dp_rx.c
Auto-merging drivers/net/wireless/ath/ath12k/dp.h

Pls rebase the patch series.

Vasanth

