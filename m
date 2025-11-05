Return-Path: <linux-wireless+bounces-28629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1314EC369CA
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 17:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87CD626CAD
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DC825783C;
	Wed,  5 Nov 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lv+gGyPA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LTLtS08J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D90D33291B
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358434; cv=none; b=WzhZnwTavZ1Lrxq/wAc4JssqFDamTwlIOyKXBSQUusKkES2LUdAWGpmIs1dBtuIt364yBuHhK4Tb/K4HEECIyuFfKunq7b83RYx6b9lN97aK3y9clPYTcB+979aTURR8Pr183hTPnJIxPSJH5nFNcZwLF0TOI7HtWmpEMpjOebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358434; c=relaxed/simple;
	bh=O1QFbmqlTrpV2tuNxAX/oZtJ1FU8wYnx6d7p72BxEJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CErhxSr42qQ2ePpJ+525a3oSUEw9hGMzoTZhr95bTzWB90yDvIHjuP554YD8YqR0drf9RpNVCsxJIUL4fxI8cPGeZKYNrKBak5poStmB+CCMn7/MdE/LZ5LUZpUCmQ33eojJ8mjA/LdO8rhMDPZU533c9d+8nHumap4d3A1gHkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lv+gGyPA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LTLtS08J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5E890O876477
	for <linux-wireless@vger.kernel.org>; Wed, 5 Nov 2025 16:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HIpJpCtpdy9AxFK+L7eD7KjKFSrIIyf34Fuzo5T+UM8=; b=lv+gGyPADvz8Wa0H
	BKRSb20ZEDhz+3Wf+jM306pg445FwfeyPDofwL0CiLKvWOMMKBR7iFwVR0hcJZp0
	fBAqnM4qNAFfdKy2TlCVCdrmwBtv5QG94Br5fAwbgKN18b04EiBcGv/GJki6IEKB
	IIa/O60deNy9AVEhkZn8bhoUqsQ0xtvB7j1MW4q4LWmWajK0oni0RMJ39cSkM/Ds
	qizfvXKqGsIfND1XD8ZbwBjPHJR9hk4UEH1ayFEpFveaAhXEAk6Ull6RuO3cVs89
	oifC7VVAOxL/79lmQtHSYnJEJd0xs1Ztew2PDYNJ3D5ymzwouELTAj2qFlHF4vg1
	6HceaQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a88318bkf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 05 Nov 2025 16:00:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed69f9ce96so63736541cf.3
        for <linux-wireless@vger.kernel.org>; Wed, 05 Nov 2025 08:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762358431; x=1762963231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIpJpCtpdy9AxFK+L7eD7KjKFSrIIyf34Fuzo5T+UM8=;
        b=LTLtS08JErSVfsnXjIsp5jjHt1k6fn5iZwwG4afU/QT7VgOxb8wm9q0ccD2yiRgIpj
         MDdx64BCIn0Q01o3z5D1t6LpOUPVBGGfdT2X+LaN1ySAwHK4gM1ARhtxnGHey+GhAsfh
         U7xIeS/T8k2u4a5AbLx4n63CWQzbOsU4XI4ZlMOxQu68dDBhRgaz+QSqIXHwf0701QEQ
         B4JoT9UZug5N/tvR4A5c06laJcYYxHRBJv4zkrFpMrLMnioweIn12xQojptwXp2Tsy1f
         j5XLlfX3hdQl4f9k3/1lILTT+gMD9EvfMTTFMbawurTU7Ui5LONTOO9n7ZtTxO66x377
         i2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358431; x=1762963231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIpJpCtpdy9AxFK+L7eD7KjKFSrIIyf34Fuzo5T+UM8=;
        b=ww5Wzol7wvN+h90vuW4klcIWxWXWL4p8D+MKzDdWg7Qqzb6Ne2Gb8MKMzgkcLYKn8y
         ClmTwOKQTi5U3T2AKt+cy9ToGruDSZRh+L5m798mxt3cC0QL8uQ0BwlGR8f0xwtVkahl
         +KOjYsX8tkln1Cmahbisoo/ZQObI5xylTpgclDcRqykOYvzqe9OIY1BzPQtWIKFMQqKH
         noKMCEcAGIa4hYJFdSi2P0TUBHFreJOAZLwjJ4UhFSU7eed11F+B48OSisdqDIGQM1fF
         nZ4GPT20q/NascQbYXldE/v64/dEZp1mmXO4QMK3E0hXEHpueopBtP9wIITiJ/GDrMSc
         yR1w==
X-Gm-Message-State: AOJu0Yz9a7Aco4rbSNtT1K8QJYrAaIaaHFN64p2r4tLNzqLnMiZyeE/5
	we3Auz5nv5dKlvIvj2lDawK0yTxjHJxeGWTzdYkyRaZ9QDNNZC+9kiTQoiDzMCMoT2k+IPggFb4
	eQbwuQxUKtQ1bVZb7niQrd3SK6Ghdd8/kdW3uAaunzG5l+7kzt0jOT5OYi9fM3YfbMbOPS+W9hP
	wudA==
X-Gm-Gg: ASbGnctkJQcx2pxYKFkdVly+VF8l8WcCgz3nC3JWfjhJRm+1RJ3y1t5sN7ctWR4thMO
	ZHhrtg++LLly31wX4hwuQpTBRX6l87W1ve/P5eHSOdN7RPk+7PhbTlSk5+CfG5peBDa/7fOo2Hz
	EQBgd9MyVmQnTN50D3R96CQe3jdq6AFf/4aZbhgmD0JXLoaDwmoHt4lx5uuIGaEnXWAcstqfl6Q
	s4YALSrblXlnKG0OOCOaA+/VRy0XzBWmPDkuIamoBOjo28YPfP4b1B9d33/Xl+Yhrdo/8xauUIq
	wihsxgRiHcdMsh1KvwxDXkf7TwqkRJCYeJXU3+IMaRYjqsF3gdoSIoQFLKK4Wvevkp8fRJDbZgT
	cWp7HsRRVKwrAu4LyCHTQ4hA15PrmaHCBCGrt/hZc8jpYSxbzpg==
X-Received: by 2002:ac8:5f8e:0:b0:4ed:6ae8:9c9b with SMTP id d75a77b69052e-4ed723a6d44mr43762181cf.20.1762358430455;
        Wed, 05 Nov 2025 08:00:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWPTswD6bwS0ACbO78o+tMMejsGRrbYXAludinRJViWKSX0msrPt64dxhMaeeZ02LRMI4OQA==
X-Received: by 2002:a05:6a21:6d93:b0:341:fd8d:f7ff with SMTP id adf61e73a8af0-34f839e0a80mr4883551637.3.1762358025284;
        Wed, 05 Nov 2025 07:53:45 -0800 (PST)
Received: from [192.168.225.142] ([157.49.197.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6a15af3sm6746391b3a.69.2025.11.05.07.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:53:45 -0800 (PST)
Message-ID: <3393053a-7f6f-c7f8-51c2-60b9a4577808@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 21:23:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath-next] wifi: ath11k: zero init info->status in
 wmi_process_mgmt_tx_comp()
To: Nicolas Escande <nico.escande@gmail.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251104083957.717825-1-nico.escande@gmail.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251104083957.717825-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CJOScZC4d9pR6Px9k6PR2Dps7i_N3j7M
X-Proofpoint-GUID: CJOScZC4d9pR6Px9k6PR2Dps7i_N3j7M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEyMiBTYWx0ZWRfX8RHX15SkRpo6
 WTnbUsF4KJ2glFU5GLPKh2rhO3mfxFvnlUjBMuRc8DmzzA02mXzUOpRlAmXqae4jyO00WkPmNNb
 eLVBhbhZ25DKWyNQ+4zmMcEkk+BrdVRUlOyyJHLHyYY10+uBGpClfu2rSSA1he7w+9Ikw0+xFzU
 NbKqBj5icaWYxaF2VCrLs4RVGB5DKEJtMPdsYuBxvLCYPxgqQFncybdRIkHmu6TqOztDCmjfi6a
 dSFCiW8B7DQwsrwuL/xxwdV4K7t32/2JQAZQdpeAi443sIMjVE67aVrmHMuIF4Da+g+7lYmCDpJ
 zQ+GYD0KKt5JrXKvNUTO4TA8NvAX3y78Ga++3m5gbn8JOZuRNHH52LAEEmPmo507MlfkfbVms6c
 EmK5PZAlAt04dVVryDueuLkX4Eg/lQ==
X-Authority-Analysis: v=2.4 cv=Mdhhep/f c=1 sm=1 tr=0 ts=690b74a0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=eKmoxwADn/1RPUtIdbDR2Q==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=WOUW82yGRNmFkX8bwEgA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050122



On 11/4/2025 2:09 PM, Nicolas Escande wrote:
> When reporting tx completion using ieee80211_tx_status_xxx() familly of

nit: s/familly/family

> functions, the status part of the struct ieee80211_tx_info nested in the
> skb is used to report things like transmit rates & retry count to mac80211
> 
> On the TX data path, this is correctly memset to 0 before calling
> ieee80211_tx_status_ext(), but on the tx mgmt path this was not done.
> 
> This leads to mac80211 treating garbage values as valid transmit counters
> (like tx retries for example) and accounting them as real statistics that
> makes their way to userland via station dump.
> 
> The same issue was resolved in ath12k by commit 9903c0986f78 ("wifi:
> ath12k: Add memset and update default rate value in wmi tx completion")
> 
> Tested-on: QCN9074 PCI WLAN.HK.2.9.0.1-01977-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

