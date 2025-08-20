Return-Path: <linux-wireless+bounces-26483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E24FB2E7AB
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 23:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8EE188DD40
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 21:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAC226AA83;
	Wed, 20 Aug 2025 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CMiIBZwV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753AF26E71E
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755726267; cv=none; b=BBRe+miob6eNk9UjqVoP/qZoZYI6Cum5PVtkU9cmY+GICCG6oxCbZf+mCHqtm3sWz9txK4jZ2G7hesYxFpX7mRyC7Vx6gmyKrACtUNP8HCmmveanenSdDqcr8OeLG24hA1e/vfMvICLtZLG4HDECarbkNolR349w8U51jQB2H0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755726267; c=relaxed/simple;
	bh=PrE7kLXKTY4oXU+I6kO2Z3IlLJl+5fphVziK+Nwxj+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gk9EiyVbNAM3P8sG/+Svuw5emQrCrIcz2yd66kIJn5TmpdkZvqDg1lduCLZnmuFLx/9f0BLK34Qfg5obEzUQX4/uXrVWB/9YCK6htWaa4CNmM8YlXUjPiajtLC2QZE3raJweJRoWgUP01qdfw5FI09apZPAFSxg4RqUMgwq+/Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CMiIBZwV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KJVTmP006060
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 21:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8NR+vh6LE4SGXIfYBSWW5OYZQI568bMwupWZLhXvq1Q=; b=CMiIBZwVc2MO6Xcr
	1UaK2w+/3YgrLTo17l1XmjI99twmQvVFcCOxNsa+8UC5B5TtE27gJJtW2D1DLb6l
	yOnCkNgna2bqSpm5LK4v7OclBqkJOND8Xr33WKkKq5VXpIXptsRYr4voLxggmd80
	r96FfyP3JjYZZWMAUn8gXTAF1luf+4THH2eAFz4cmEnQ2QCTqVNLtvY6B+59LnRV
	1l/5J/zIfRkA65RYinEAHFcsDSpK8XIhsF6oOEx0XPlZ9fdJBeymNG/irssSdTZE
	RUn8uU3WZ7iP2D9IQpluhc35Twl9JrLGCEhDvL6ZyIWcN0bJUqh9hhVjBRetCk/b
	MmEjfg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52ck6fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 21:44:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32326e1f439so350672a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 14:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755726263; x=1756331063;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NR+vh6LE4SGXIfYBSWW5OYZQI568bMwupWZLhXvq1Q=;
        b=VLKukO57lPqfysxr7jS+de2+f7EVVkxHTfducdR7zdDWL+BXnId5cOVBQvCPhyua9P
         6h9jdxC6So3G3FVzjcT3bYXkWBHsKoZyvr/vXi8Vr9BxWVjAHsFlmdAy4bdMSMtejhhj
         NpjvPEhwqciNVVsPJjnPY/6Rv2p5OcpYPIpKlsTbfwuKLANUjORJJvQ8VlrDaqMJV2Uw
         E1T9EKN5IGq6a34Rmi1AK4zi6vbqp0hHPyB9cWWek3lgmZ3OXKrzilnrnXGwmd+Q50x0
         jq76QC6bQHmYliAUou9grQQuKAU55FWOaEwFiABZ4awDvF2hNi/ZuaE+Iy3hpjyug/5i
         zzww==
X-Gm-Message-State: AOJu0YyH7lETKOMLQwiFijtr/q/IP/eR/lyHq3/INqwZvV5eKUA/vbeW
	FHwHZ8TaK+yRX2J2kBoSm3PqnstOdrKvDVY0keWom4Zdf2seekp4+RhOH1PMQ/jgZp2T2DBds2N
	1Mh6SwG6Gy4tgkEmLFTVlXwzPhyY59rULBpIkOq5NS7DTSHA5w7incejOWhlz0VwUIWz2mQ==
X-Gm-Gg: ASbGncv5jj2Hel1WPvKh24p6X2nbHSRLtV+yvlqlAMwDvCRMEzj6lsFidP9HBZiu/u6
	flzIsxIO+74LWGJNX7d7MKCphKTFCQTSvCils9YiWSKJLsMFW0oAaM3Q7jB1mHrJDeTX2aoJ7o7
	RgN+q6WBm7CyojDrSywTgTwRWHfTvz9TYzxcreCm2JzDKT9HiFp//CTjWyjA8OtkGtSPC3sFlUc
	GPS2Ia2slKVG+rJ+WDJc+fbkVjTsJE+UVNveG3WDWXB8L80dP87uD3geYMbpIp+gfOCn2t8MTv5
	Zp5claOcXcNVGEHfuMKhLADdI6QN0yJLBHWnf3f2GoExPDFrZ23FbkPk5jX/KXTtR0nbQb7TYTf
	J
X-Received: by 2002:a17:90b:314a:b0:2fa:157e:c790 with SMTP id 98e67ed59e1d1-324ed0cbdc1mr421940a91.5.1755726263463;
        Wed, 20 Aug 2025 14:44:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMfLg6vzZGGs3apKM7B2XpMgTzTKZhrWKOlH2IF2SvkzDTojyMDDWg2Ax8hTXpqaMPiAHs8w==
X-Received: by 2002:a17:90b:314a:b0:2fa:157e:c790 with SMTP id 98e67ed59e1d1-324ed0cbdc1mr421911a91.5.1755726262914;
        Wed, 20 Aug 2025 14:44:22 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324ec999bd4sm120736a91.4.2025.08.20.14.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 14:44:22 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Kiran Venkatappa <quic_kiranv@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
Subject: Re: [PATCH ath12k-ng 00/13] wifi: ath12k: Ath12k modularization
 changes
Message-Id: <175572626226.443390.11088672380590789485.b4-ty@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 14:44:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: p5aku95kMLK3W3ipk6WGoK-WSG-iFzCz
X-Proofpoint-ORIG-GUID: p5aku95kMLK3W3ipk6WGoK-WSG-iFzCz
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a641b8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Wa6gWqMl3lgHE3ZPCBYA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXyJZXebve1C/a
 X/vY1ghe1txs6mrht9a5RMxuIMriyWcIrgTDrO/p4O1ah/1Ei4Wf1JpkTzjPEiZKXpqeDwEvRpY
 f1u7OBET9S540LnrQQdW5Z0EZkOYQPtsU7RkbhCLJtjA2W15eNtGif+3btmoQ74SEmEVqwukl35
 UPRx4rQvCejxx96SgNtj2ekyJ0Ib02TRpg8ZG/8tS0fJFnnT/HT9dzPXcFRJRQYRsiXe3RbDIUZ
 i7n2NRmToe7rIomZhn6AolIFlqTlhAv56ouWRti7ukhhktL4qHbejHnP33M1tc9I3PKcjklGZzj
 qJgr0R5U/05WGDjwy1FhGB9/PqHh06OJXoavWBPTwmaL02P7z/ASIXjhsF02oW/hH021kXX3OmN
 ppqooYD6BxPmNo94NmSonknoN4KtQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013


On Tue, 12 Aug 2025 22:39:26 +0530, Kiran Venkatappa wrote:
> Current ath drivers have separate implementations for different
> classes of devices. For example, ath11k supports WiFi-6 devices,
> while ath12k supports Wi-Fi 7 devices. However, there is significant
> common functionality across these generations due to shared firmware
> and hardware architecture. In the existing driver code, this leverage
> is achieved through code duplication. As a result, when a new driver
> is introduced, many features are missed, and new additions require
> porting across different generation drivers.
> 
> [...]

Applied, thanks!

[01/13] wifi: ath12k: Restructure PCI code to common and Wi-Fi 7 specific logic
        commit: f844982696f57d72e45f94608278f678a0f67b26
[02/13] wifi: ath12k: Move Copy Engine configuration to Wi-Fi 7 specific file
        commit: 5e545696a398ae39f4c0c747a8ba0c7073037d1b
[03/13] wifi: ath12k: Move Wi-Fi 7 WMI configuration to dedicated file
        commit: d650b777858f38dbbd5bd2cb43c97eb261e95f9d
[04/13] wifi: ath12k: Move Wi-Fi 7 MHI configuration to dedicated file
        commit: 7f54938fc5253a89b962fc137ea725e3e3405757
[05/13] wifi: ath12k: Rename hw.c to Wi-Fi 7 specific implementation file
        commit: 3f8d0eb8037b199e84c41c6ba687104ccbf076f3
[06/13] wifi: ath12k: Rename ahb_hif_ops to reflect generic usage
        commit: bca2b24d9dd98c06b61f6e15789b652b98ff7c87
[07/13] wifi: ath12k: Restructure ahb.c into common and Wi-Fi 7 specific modules
        commit: db2929711d705ed244f0f5a41441a6103ecc785c
[08/13] wifi: ath12k: Move Wi-Fi 7 specific init routines to dedicated file
        commit: 387b587a861cf7864df93c99c123877d28100bb3
[09/13] wifi: ath12k: Move hw_init invocation to target-specific probe
        commit: 83cd89a9556a48d31d706f67854873cadbf80c0e
[10/13] wifi: ath12k: Modularize driver into common and Wi-Fi 7 specific components
        commit: a72027045263f8261b47fc28e7b6da7571d8cbb5
[11/13] wifi: ath12k: Rename ath12k_* symbols to ath12k_wifi7_* for clarity
        commit: bce3b73d1ca744fc1c9cb92eec37b0dd209ae9a1
[12/13] wifi: ath12k: Remove HAL defines from shared PCI code
        commit: 6cbd171805be7443bbfdb8ff0a646348180eee35
[13/13] wifi: ath12k: Remove HAL define dependencies from shared AHB code
        commit: 0e487f03c6e5d8dd5b076b8b061e50e736ab2196

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


