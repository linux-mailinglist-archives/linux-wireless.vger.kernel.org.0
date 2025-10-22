Return-Path: <linux-wireless+bounces-28162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FE0BF9D36
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 05:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E4E19C6776
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 03:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7FF279331;
	Wed, 22 Oct 2025 03:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GUmJKvyo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E6D27703C
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 03:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761103536; cv=none; b=Y85WkE1aDsZaRKS6Xvoc+P5ZZ9oOi6h4lXF9xBf2Mh4l4123HV9QAidPKYFG+DWMVrLHmqX2NRO62DyGe3BHA3kNzRJoECA6smvMghU7R9c9BdMBO/TIFlWqh2QK0I99pRCnlgEkpJntTK6dFHi2UiPIsQNCj2gR3kUQwb9Pl1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761103536; c=relaxed/simple;
	bh=5AvDweL6Ij6AI/0bjUj8ghDmL/WhCz8Xq0xvwgQbGIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4ksMFZ1DiwZlHYGiSpZA7tPWLVJ2gpz848sfbALGLiCtXgM/q4N3TOIYGmfbE/5U77vDgeQumJEPme5lFSFvlOpFi5i+t35U2F2BmEquJRGj8dtzF/WvJxEDvAdTothFoFle7CvwX3o4HaAnxpnALhJ/JIz5PCSTbxc2nyaEKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GUmJKvyo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LKfMYD012401
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 03:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yjfw9msKx7xfOlkSa84c0dlqx1z7JGX+iCQNM8Ki9hA=; b=GUmJKvyoXB6CN479
	A4sYjHWtTIZK6m2EdL9JNWYZHSPWih0gdSUEy4mPU9QQyZGOJLHLgGg5nt2cA1uR
	OzM0Hu0O17N+mEx+3WyEvGmSDdIk10vOKYVWctOLHMfihoOlSZPZxT+wrdtIoao+
	QONYHWpjRyvbCyZaJJzvceIgLUdM3s9KygA81mPoPGY4/WJEa2nps0UZmOUbkr7w
	Y4uYcm9FonNRd7UaZhmY+2Y7lunOmdiO7to/dc66Fg2VC+BQZcb/Tr+lF5kWZPXh
	09FUDyARNQln8Z+cyUAbhDgvvFSCzSDq3RSZjcWmPd+uML0Qv+xkYTPabmvli4CK
	4t1Zxw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0gv9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 03:25:33 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b631ba3d31eso3999628a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 20:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761103533; x=1761708333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjfw9msKx7xfOlkSa84c0dlqx1z7JGX+iCQNM8Ki9hA=;
        b=WxJM0fqDxS6fHyv3bqtBsfmqTLJxx6DGtcrRM1qHctRLPT5otr3acZvIT0JjP8JgpY
         +CsLvJfWDD0qHleGE7iMzFqCOAES3d/0+SGgj0PWY7DCZuwYDQwVMABic3BL+wZn73/Y
         B6sNjjy8TT8z9ngjdf0GDkgF8oM0l4FKeAkwuB+ERluPp2kSC67wFfXYV8UObIeR8caZ
         2je9JQupqAa+WzeruxL04NXupoOQTV/a74wiBZhOoyKGDw6Wc6stFg1F/43QAqeIC66Q
         w85eALxmD8anP8AL3/VrsutMAdb/spaSzdRJA1WYY3xO8qIScre880S85KErvjAd8Ehq
         0gYg==
X-Gm-Message-State: AOJu0YyXIx+ALKk3leWJVv07kG+mTsIOulWg9kBlGCvaS9Y0TPsRWunR
	tnBC3vMNpqNWr6BURp4UbNO3WrTqF+Lz6rhR91Ji1ieqQPfsuaeiskxjilWbalqNYPEXIWf/LVB
	yG5P/ExoLJIitZnwHlpUaO1LFBU2/Xc/K3Vw8g50aphik10D/So3ssztHt3kP9ITkCeM3NQ==
X-Gm-Gg: ASbGncuGjHrJthgMu5st84VSwbf881KGpr64ePJXARIJVTT0OsfB7l9++mQIHnRq518
	gro2OCR9cwxZcDn546bUa4YZ/tGtS8J+aopaFqqinsLpETD/w85ud9WxJl8G6V9GB9y9Q/Uw7yN
	F9R+ih7jKKMbhHAxknjxuOCGfUpusP8Nv6r3IApdULOXs5uJ/j/v2zySQzEwwNlPK+53Xnlex6J
	helWTpKj9OL+4W8zauAFhe+NR/o5kDcOcIK1cTDhNAWZVw2smYCw3x1EcX/Lc1cS7Gos/i/bxql
	8ShnA1P+kwcH2CeHOWC99M6qJUf9JQ4nD04Wx/lqhGI/E1kW7UgmPug9wQgdeCK21X90+z9WtyH
	CEqicYqzgm90/Adgw6WHeTVV68vTqLNYFNTgYWsg+XR6833ZNUg==
X-Received: by 2002:a17:902:d50a:b0:27d:339c:4b0 with SMTP id d9443c01a7336-290cba4efb1mr250800335ad.35.1761103532710;
        Tue, 21 Oct 2025 20:25:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH7Ukk1PJxZsGOLz5xP4zkZ3wO3/M0rmRDWi2+HGPc13CHW4ETBLyTqSQW9AahAE6bQZMKGQ==
X-Received: by 2002:a17:902:d50a:b0:27d:339c:4b0 with SMTP id d9443c01a7336-290cba4efb1mr250800045ad.35.1761103532255;
        Tue, 21 Oct 2025 20:25:32 -0700 (PDT)
Received: from [192.168.225.142] ([157.48.122.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cdafadb8dsm1179405a12.1.2025.10.21.20.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 20:25:31 -0700 (PDT)
Message-ID: <6507afe8-02d6-96ec-21b8-651fbd9b3319@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 08:55:28 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath-next 0/4] wifi: ath11k: add support for Tx Power
 insertion
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX8+wMbWOjWXYc
 L3jV6oqkit/zFmFbzthCJEQahB/bQwEVJaFKiFNv/4NBZAFW/kqbHIvSBAR6EUVDnGrozo2eWZO
 DLg6UZdOPTcaPqx6G11em3jeMb3pZi6hQIGRlrvvlz7JynBY/M05t5IIhnLQ9pK7xMIgFkKvtuR
 n6GccZPed+w0RgdVKChN9NhYmJekr8Z1JDgQ4TtFSJUrJa5phhjFbczJI3w/fUMGkceoWC/aEYi
 I1vlN+zVAFWWPXKaTp+8zEF5ZRJV6RJO36ZSrVNq2VH0eEjmxzTqvsxUk0XwJbCZ3SWVDyX3+G6
 62QPAvy3NBhTpf9JS7yzVYVcj6OjdRWO6pnxJBVc0ztIjAQm+ANW/hzYzmunYwmunlCps2UmTLD
 AEtSY/4efc8l1p5Zg93tySHp1eM4PA==
X-Proofpoint-ORIG-GUID: Sv6SE7arcepsTt7FF9w4s3bpgKirHcwQ
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f84eae cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=MVWiM3nRykcdLg9H6cDE8w==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9jhMNZ7qWXdoG8tHMgQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: Sv6SE7arcepsTt7FF9w4s3bpgKirHcwQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167



On 10/17/2025 9:37 AM, Aditya Kumar Singh wrote:
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
>        wifi: ath11k: relocate some Tx power related functions in mac.c
>        wifi: ath11k: wrap ath11k_mac_op_get_txpower() with lock-aware internal helper
>        wifi: ath11k: add support for Tx Power insertion in RRM action frame
>        wifi: ath11k: advertise NL80211_FEATURE_TX_POWER_INSERTION
> 
>   drivers/net/wireless/ath/ath11k/mac.c | 447 ++++++++++++++++++++++++----------
>   1 file changed, 312 insertions(+), 135 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

