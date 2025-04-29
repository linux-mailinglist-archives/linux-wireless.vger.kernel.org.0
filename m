Return-Path: <linux-wireless+bounces-22182-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C3EAA01B2
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 07:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1DB1758E6
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 05:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464E786338;
	Tue, 29 Apr 2025 05:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HOzI8GWv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696D1BC5C
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 05:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745903957; cv=none; b=CbQ5lDbRnOMt2Xovdv6Pd8OYEkKA1c61gSjMnvJ0Hxq2197P/czJQgMsNwd8oretOc8lGIEOGEr60LYnyohwScJ9LqHTGFCpW+2tx0jgwSkpmgb/bp7F0jZJDV0sbpBG5w4e/1E+Be2p9AFAY+1A75ALMnSKKUGA0jpnW+ujTnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745903957; c=relaxed/simple;
	bh=Ky2a9FuI2Pc1ZRgarYRAu5u5cP4fmIOzsPRIVPGL3ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJepGlCRl0UoEy1/iVebgee+/0bTzdfmgfSabytnyztJchwjQKCzpfmMe3AZgxQSaWKGNnYp3/kCiORNIg2r0jGuuOWTbeFWXPjTZEDoLybKOHvipPkfj9njRkK03Rk+4RLkOtv2nS46IC4YI6KHgpGlhdfbo64R3bQBm/qyEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HOzI8GWv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNqKqI012626
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 05:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VD1Uf9B/Vj3KD2/QaWyCjcbmkH4OAe3VRoSlYJ5UkVQ=; b=HOzI8GWv1sdih/d0
	92rtF8A//oAl2e01ESBuNxHVqFiGyHncDfk0TaWHxOJp8nvn2H5W58wHyUmaP2Sd
	lhBC0dT9WeTe+NxbYKk0J4sGhdl0XqbSpo+2TrGzwe6uD/T0KVSbKkwAPcPpoVvZ
	IYC+u/HOe5Ym3HoJpSsgg1mdN1XKjUACsuLDmuF5Q0TctOXN/SccYRRkAojGm7aB
	uQVpDJAyw1Ucf4XyU30vA1nPsPMUWpmVIFl4MV+5BLpGlxgjHW6DP6LK8ABAsIyi
	8cuviKSBtoZBlz9MH5ni8RnfdeW0KewM6tXbh0KTrwJIElEBn+994j3N0dqSfNtO
	y2pOvg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468q3239fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 05:19:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3032f4ea8cfso5371395a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 22:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745903952; x=1746508752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VD1Uf9B/Vj3KD2/QaWyCjcbmkH4OAe3VRoSlYJ5UkVQ=;
        b=nX64dOR7MoxBajB78zjyEyy0ZOsoT1HFJX2wq4x86ksYPahCWxMLy+XTTs7AUtES0x
         bKdddcJVXlviBEcXMdGiDhl1WO7xIdQA5+v1WlkkaY6jMIOBng/QnWlQtgerY9cMkTfc
         Bepja6O2Hw527IsF0eLEjKh1Lf+rgNxkvv89+1kd0mWhOtHKYhmZKHq0dtcMEgnQUx/t
         10GKBIbZWmI1+tzPGo8YLmEpEToHjNh+YiOqSHZNxKID7dXpto8aa5eOp41d0aPl6MuK
         C20olA015ThxP0UXuI9XTKKTHsZLAdSH5N+wk+d32kGfgYM1/4veKNJ2o+EVu80VHkuB
         ww+g==
X-Gm-Message-State: AOJu0YwAmsv4jsERU/qnG6FHgpIzvEI0aWytNvOhmHghYIWf1casa1/k
	v7/8rGRVCEwisNFtFT0pTv6JWIrMOapjeZ2VvzGLlMnUnFzS79C8qsL8w02eZg2Nw9nnCMycVjl
	rY4A8ZlD9YWVEk0VfUYh9tR3u/We6u8lM+ztfDuUn699DxHXpfA0nlddcy/FHqWy4pg==
X-Gm-Gg: ASbGnctho9lrcE8xp8+e5yt4gs48aGjFMUU/r1Ez5L6Iah7XhyF49CndWWoqWsKt7Ug
	Z2luKuJQxJ+GOFOUtFIfn2mfhxepj1aRjKryWNq/6ZekjiUUFbrjXkOXCRcXJbAM/lEJK4OWUP0
	T00jZpU8iMZrNWNPFhT9WSvsoQ7D6ItAU0TUH3c5uHHXTzJ0iFMNlEnogepsR6dUHnnd1eAAnjn
	tjSNbv5GVDs9heEmji1NbFxepiLAD16EjvnUjJiX6HwErDeWdpSxrXno9kIHRO57eKsVKL8SUX6
	nuhp88+aIdt8M4SGaGBQLBkt2UVTc4233E9d0PXLd6UbvZH+knA/tQ==
X-Received: by 2002:a17:90b:48d0:b0:301:cba1:7ada with SMTP id 98e67ed59e1d1-30a012ff0d0mr16008016a91.1.1745903952596;
        Mon, 28 Apr 2025 22:19:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkLLK2rcSD1sOQo7rJl7J1M/sQqeRIpUYSYgzfwJYY4CoujYCQLVRrDf/dIK3iguI/Zz6O1w==
X-Received: by 2002:a17:90b:48d0:b0:301:cba1:7ada with SMTP id 98e67ed59e1d1-30a012ff0d0mr16007994a91.1.1745903952277;
        Mon, 28 Apr 2025 22:19:12 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f7760d7fsm8292164a91.21.2025.04.28.22.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 22:19:12 -0700 (PDT)
Message-ID: <1b37ae38-c7d7-1ffe-c75f-1eff39fe56a8@oss.qualcomm.com>
Date: Tue, 29 Apr 2025 10:49:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Prevent multicast duplication
 for dynamic VLAN
Content-Language: en-US
To: Muna Sinada <muna.sinada@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250424221404.1262597-1-muna.sinada@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250424221404.1262597-1-muna.sinada@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M7xNKzws c=1 sm=1 tr=0 ts=68106151 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=_v-kllCiMXa8kfBWZKwA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: H7QpgMQweQMpq55DWlrlvX-5GJx6XQGZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAzOCBTYWx0ZWRfX3iA8QsIdnhkV juAIyuILmclZa18wg2LlcP1IF8XztnTiN7xmdcz/TfhLRPhi87gqq0LHOcaujCtl2NnYSifxrxK Ask+tBtmZkObGoNNOaf8ltoy5q5V2R5AgbxxpzXRYJB5zaDBrZpnj12p+GkOF16qDPfICP7Tp8O
 3GAOrhqhMsV8Kb2XYmFlrAkDnndDDZ0Q6AL3x7wcGKr18ugOHtKhT1QPIH6FnE20TXRCbjlS0Ym 8aJUzNpZbbQT2NDCDJrvTihywOBZqAMXi3hHy3n7dFwDm1hOjHIwoPj76xsyXMYlrNesIG1tL12 newgyYFfkK08M7/7RGkRZe3ArEuTJqEaIX9b6swx8PqrU/I0yriesVCcFRbrsa0zwtJR+z6jhvK
 VhimDJ21YCt9UQi9gTyeOI4XtB6SoYwiBBq0tLQvzerfIbz6ITOEXi01MqmNSX7fRE5tV087
X-Proofpoint-ORIG-GUID: H7QpgMQweQMpq55DWlrlvX-5GJx6XQGZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=464 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290038



On 4/25/2025 3:44 AM, Muna Sinada wrote:
> Since dynamic VLAN traffic is software encrypted and encapsulated,
> mac80211 handles the duplication on each link for MLO dynamic VLAN
> multicast.
> 
> Currently in ath12k_mac_op_tx(), all multicast frames are duplicated
> and are assigned a mcbc_gsn. This is causing dynamic VLAN multicast
> traffic to be dropped in hardware.
> 
> Prevent dynamic VLAN multicast traffic from being duplicated again in
> the driver. Check if incoming packet is a dynamic VLAN packet and
> avoid defaulting to multicast conditional.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

