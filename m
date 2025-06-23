Return-Path: <linux-wireless+bounces-24336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2688AAE3496
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 07:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1F0188FD6A
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 05:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E2D17A31E;
	Mon, 23 Jun 2025 05:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C1oaQRNL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDEB151990
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750655182; cv=none; b=Tb9A6XHnLNk6DLvqYW35z8AhfXyXWQ6dWkVlFdvk3fN0tmHLS/KPX5EZt8Nl1fShJaiWhLPeIwCBNqHZ1VjBJ1cWLejXemzDYz53k2e8YBMe2BXEAhY8bY39kBLewOgu5gxDlFwnjX7N7KMMsM4FTdjHr4WYkktmD9ejsq/jkm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750655182; c=relaxed/simple;
	bh=XsQf+AygyVF9bs1aZrLMnjAGG5TP5RWpBAnOAaADhNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGz+xJCrf6RML6twIU/AHzvIwHCIX5Zl+RKy4lsAnJGFhWlkqhYn/vOQXDOk2kAh29Xz+xIUk+IcsTNAyM8bRsb6w/xR1Yagp0Rf1NSs5X2fX7SHaoZfGOmhJqjfA7GnbWj+vTVkNlJdsAxzUHmfPJQ1cGGFKm7jUVmBNq8Tj7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C1oaQRNL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MNqIsI028508
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HHHKEzD0T9H274180tE+Ev/54hv7g8GD5RyGX8mAz+s=; b=C1oaQRNLRMUbuf05
	hZnRYh721SNeWykQgYgy7my6PFBu4+C4lUFbESQjIytk1uSGktpAzK4ziOwR+LM2
	5NNlcTdfrgYpicieYEd1SBXXjjp+TcKa9/lO82ZhGpG9DPFF9CMr7mDQC916HIJC
	+ikpal5oBi2nOjW7zIVB1Yi8dFnwVvfwFwKCFuaK5VOBQ4JzbR6AjbmMxsy4Aa9t
	x52Jbs6rhl9SGKQ9cc9W9m9CYLoIu8cCAvgFBDAef9L9TKuUZMXUk1SIKrxj4APP
	MZ0GDrZ8jK04R5WblSgaYRuv6NO5M0gE4sQnVs8X/KJ2yzkusux0RMJqwS+Zoz4c
	e4FfWQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47eccdhfak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:06:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23507382e64so35304435ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jun 2025 22:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750655174; x=1751259974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHHKEzD0T9H274180tE+Ev/54hv7g8GD5RyGX8mAz+s=;
        b=OGHdzuBwzFBXdiPfjV2ZtMcQ7/LOZcJgF6kRH2HPOjJBdYpAncI/2KOfiD/U1BZByP
         Qmfa1yrYERT+uyiXQgOCbUoSZE7bGzMtsB8MAPCywamX8sTqyCjCEmIEl5H9dX/iwQ5f
         4g+9twPflxvCHqabjm8GwhHm4msETa/bi16+YAKErUy//3OXuOSI8z85zrnZfDBOrtpb
         ntm4AUplcxt7p7woSK/wzoosVX1vWuXvNkLAbQRBcjJhQMQM4I9kedV6Gtdp0CA7saEX
         lKgCuUg2WYDTWtmgOwmDJiQSeugvcNb2Kzt8F9s7B3LCoXO9+DNkd5aYWp05SV/j/AXz
         xHTg==
X-Gm-Message-State: AOJu0YwbWNEzjateYeDRa237abYeuD3oX66igh57n0CkkHc1ouNxaMok
	A94Q8LdHg+ELeV8A+b4a2wQqlwARNsWBIURdxWnfIQOAEnPmQl4osX9bvebgdtwL3Z2cwJ3eFVr
	sRqw9UnZvJX/ud85evwZAIqflGthlL+LSz6SOCW7ee9IqUpLhf0JjTWyuNekj/AaEea1FhrLjwL
	IfHw==
X-Gm-Gg: ASbGncuWPIBhFPLIajX7kjgu6/FGCtKCny76+tYxbhk9rnJSO2sipz4F6XPun0M0MiY
	xmblJ6vr1dCd/D+GUJGKB2t1K6B8SyfQtNpUddngsosMeDGqMClFnKNpdP55QU7q7b705O7CSR1
	NMh1FhUv1uaDh4lBF8jbuqMN+E3Hkw/Ie+8LBG43gAx1R5KByMUyDIvW990lqR/R8VxgmJH11qW
	izCbs47hLUrgz9L4kpA/qc/cTPvXZRNxg2JoXtiZ2eGEVrvz6RWrhpzuGxcYw9OMTG7Y5v8xK3T
	C684Nod2b2+8KpeUJgNHSWCaX5JLRwMNmOEfyVedemZbfntMFwZeadchpKUMxRRc
X-Received: by 2002:a17:903:2352:b0:234:8a4a:adac with SMTP id d9443c01a7336-237d9917e65mr175914725ad.20.1750655174386;
        Sun, 22 Jun 2025 22:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzfCzPkULBvTu5UVkzfKO8ULI2opQNw6M9UtFT2I6KagHFiNF6gmspvSk4m3deWwoomCzOWw==
X-Received: by 2002:a17:903:2352:b0:234:8a4a:adac with SMTP id d9443c01a7336-237d9917e65mr175914445ad.20.1750655173942;
        Sun, 22 Jun 2025 22:06:13 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8610ac2sm74285735ad.135.2025.06.22.22.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jun 2025 22:06:13 -0700 (PDT)
Message-ID: <ae7eaaf5-cde4-4676-b28f-61e43cd3e757@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 10:36:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: remove monitor handling from
 ath12k_dp_rx_deliver_msdu()
Content-Language: en-US
To: P Praneesh <praneesh.p@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250605054438.1855365-1-praneesh.p@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250605054438.1855365-1-praneesh.p@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LOVmQIW9 c=1 sm=1 tr=0 ts=6858e0c7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=NwdkJL6YhdxGdXyF1vkA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 5S7baGN44EL5wyX0B592WRyn9KqmgcKa
X-Proofpoint-ORIG-GUID: 5S7baGN44EL5wyX0B592WRyn9KqmgcKa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAyOCBTYWx0ZWRfX6OC7qAfSEGWF
 nlugd5wGTEUa97+fwMd//4HDA4LQJOi6LoMMSSaOVTzMMFQebgaUnb3fsjcOAB3Ogm84VRmqq9N
 0FFqwb+B1TLU9mnsGoaw4tPr1H8PiuS7/XO5pNhWydaCtWuK76w2GYf1bIB21qBw0xmz/eVjzcW
 2UxEiEMKVGv+Q1f3+xVR8p70EZWBNXDQC6DU8cZdG3NsGhiiMX3xGYNGmxGsC64131nU5WBi7+k
 RucE3hBHjDwW4YhnU9eEveiE0FD4zUcvaGzXh5kQtE6b1kaYMZw4nFBW5D2Qzu0zvOH38DwDPHO
 m4pCs+4C1a//ta1yGPOuUuDEmOFKd2snj4/mUT7kGxdcwnlvgKrEJm9bmQ6nNQ9D+9dAamLd+ln
 qkiLl/UCDIIg6o499x/EAHaQT4yBY3Mo1Ot8DDWAArKKdvPezewUprjjtRGhusZ5CX03ymZN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_01,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 mlxlogscore=753 phishscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506230028



On 6/5/2025 11:14 AM, P Praneesh wrote:
> ath12k_dp_rx_deliver_msdu() currently includes logic related to
> monitor mode handling. This code was inherited from the ath11k driver,
> where a single rx handler was used for both regular and monitor mode
> packets. In ath12k, however, monitor mode packets are handled separately
> via ath12k_dp_mon_rx_deliver_msdu(), which contains all the necessary
> monitor-specific logic. Therefore, monitor-related checks and operations
> in ath12k_dp_rx_deliver_msdu() are no longer needed. Remove this dead code
> to simplify the rx path and avoid unnecessary per-packet checks.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

