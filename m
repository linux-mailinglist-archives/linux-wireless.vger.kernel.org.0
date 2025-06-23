Return-Path: <linux-wireless+bounces-24340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB1BAE34B5
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 07:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5CD16FCB2
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 05:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EFE1A3145;
	Mon, 23 Jun 2025 05:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YxtkILJ2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678072AD0C
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750656169; cv=none; b=Vv4VeJvoB5Pm8BmyZb+9wTHJbFb+LeR4qHQJMzHdtdfuDoNK4TZo+04VGjHV2UJ+1AGiq4H9dfT3Xjb0m4XzJ8uKLr4jmYHAW0X9ZLUPdedQCIa44BRH91ITlm2VIf964NR7H/0OLd+mf8rp4pcK4eWAY2g1f0SH50Tkewc/BH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750656169; c=relaxed/simple;
	bh=+Kas6rw2gUuGcCXNxLZRLTxtV+rGsYFJHHqXLmHlZDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAffhqgXTDKJqBH98YftSlHMHfCN7BUAMr4PmbeXnN81nIlkdPO3OLu+D5G0QR0XHkK20zwLaT8z2jOkRfyf4qjOW/ladqP7rTSUJ9SS+vIh0xmZi7fIwCJBTDhHpBf1bcndNyfwB82+zrBd313QmQhcc6q1Z4qFervNp+Vp60Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YxtkILJ2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MEowOm007242
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hLTjHztutua3z5I4nsvOTKbG4m9yNPn0gh8iTJrQ/94=; b=YxtkILJ22j77Lvbt
	1AWZYgTxsA0nxvlFD65y0HkRFD4ThGDotDJVoAy22T7Z40KaYzNpqzVZ696K8SUq
	UYfogTeIyUmh/LRTP7QtaU1+oa5X1TFKBdLOHPbsVSDuJxaSfNHSbnQR8KLqajef
	3q3MrwocUgpRr/X7k1yp+YADnvhoBgRe1504WUcDPQve9nncTqMKwJdB7x/i7sJK
	ES6EE7ennAouWY0hRYWyrSarQj/5p3aW1EpKLm8jDgHi0YLtEa1Jlb+ZTlYAAyCy
	1SheVsZI8jd6PdsAnEAZM1pXrGg4Y15t0dJO0yZUw2kd1/TWt7vMHTRI//FmGa3E
	ogfi8Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ec261j2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:22:47 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b2fa1a84568so2586921a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jun 2025 22:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750656166; x=1751260966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLTjHztutua3z5I4nsvOTKbG4m9yNPn0gh8iTJrQ/94=;
        b=IAwqMcONyhlKIsXLRbc845A++5KQkzDuo1YmS1q3tFdY7kNN61y+ITSMOw53kR/09I
         ADoO11xO0Vh27akMv+5DNRFbe+ASiwgbSfsBTseOeM5Xg4NP3FzUyPz875FrdPRd5OQK
         sJzhS5YJvFccJFSEC52X2BALTa8bW2upZMHIt8ddARkG6X0+vAy81scal58QB+BUZefx
         J8UaijuDg0XfHVjZ0vWwmy0DzVuQOK7Js0+lnS75lvEit0L7ChjAsAaDjhJ3ROYUAM6c
         q/7Hr7zysJB9jfWIuIUEQbKVpeWm2KrYhufq7L1n3/HMnPL+Ylm9rOG4S/3IWkbalo0Y
         T7EA==
X-Gm-Message-State: AOJu0Yy5JhQ0L2KfcbNyruY12+NRlKNqb2lIhZJ3DAYYHr/MfOSBa9Jm
	0UrlP1UFUcdJWH354xU/j4g4ukz22fLXBjZlzb/6k+eADGEuc5BCm+Aqe5Vaa5Gt00I3x/0kRWi
	wPpU154+80wPqU7m2xD+1cIAmuXZuvhbKne2QfuvV071xPeBidtctgq5KeORMxqsycKH7SQnD+u
	ZRMg==
X-Gm-Gg: ASbGncvIVyFd6IoBepthl9ICz1UwcU448J9lF6UcqhhNSK8TNbPjGZDz7p3tRK42LjP
	fwVKXLOrs+Df7zi1kbpCK+xzSx+2g3GRF2dNzAwQleKRkFflyBIAMi98FSgcUvGqmceFGgTilgr
	fx8OwO2eoOAIlPwPw+iNEm/6QLBCXVxh72jLXct5qNqAUaL95D8WK6AYtJXPTVG3T64RXjt+HPA
	949XBbN0LynugNfyL6eQOtnCwLtu1QduijOp0Q4YGP6qHcBvcI+b7aJ9lBEEPzc0m9IhMdEEYMk
	wSinVHV3U1J4CxLDtv5hMsNS8KA+5oqjSlOZb8N9oHefnnD/lx4fBr6wBIAFt3wC
X-Received: by 2002:a17:902:ea04:b0:22e:457d:3989 with SMTP id d9443c01a7336-237dad62e05mr157842755ad.0.1750656166368;
        Sun, 22 Jun 2025 22:22:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPbiH4zXPXU8XN3CMiJXdjzBJctNi2A9Anl0Doa38MkcwwcT6EaraSrDq/JY2/ygobpeCE6g==
X-Received: by 2002:a17:902:ea04:b0:22e:457d:3989 with SMTP id d9443c01a7336-237dad62e05mr157842595ad.0.1750656165996;
        Sun, 22 Jun 2025 22:22:45 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83940f0sm74662795ad.18.2025.06.22.22.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jun 2025 22:22:45 -0700 (PDT)
Message-ID: <b2415006-6176-8645-9ac1-47b8598dec17@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 10:52:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 5/5] wifi: ath12k: Add missing include of
 export.h
Content-Language: en-US
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org
References: <20250611-ath-unused-export-v1-0-c36819df7e7b@oss.qualcomm.com>
 <20250611-ath-unused-export-v1-5-c36819df7e7b@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250611-ath-unused-export-v1-5-c36819df7e7b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAyOSBTYWx0ZWRfXw7Fab1LX2noV
 cFEBX2SH7RlFtfxLPECBNowa/N14FegsnkmUfEBFBdEwF1jx7yexLL1c28k+SQlWox4cZiXnjNW
 PW4rukzKWBZAmSQBsFTt82cVVfvIDd6etKx0MSaWCNTocGkb2SEbHLiStCLXzPaG2k7oZ8JRFgl
 OzZdj8ZWcXrrR4x1trBr+X084cfHXWLeyUaPv9OqkVceuxloOyQiah2S0hX/TwWdYGOVpcMhM+W
 vD2Sb/iyiWRx/c8OW9DBPICdxsPLkLPKncXS7xEWVtlZ2koVWds3j0ytoK3/GAFyN7P5+HdVecv
 uZFINrY0F2fT8PNcbUVwqNFA3iiLcn7QOaRsyeoop1m8DSBzzq8oTH5/vkbdQuB2GS8Px0mBuWJ
 Td8Be69rb6dDcjmf23mfXmExE/hxvlsh3IGO1iZ8qzFG1BROCQoZACuIbGt3nQkZjBgyIpXF
X-Authority-Analysis: v=2.4 cv=XPQwSRhE c=1 sm=1 tr=0 ts=6858e4a7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=rPD8waAe7N7EK57NJTkA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: FBXQbDhIJ0eCwymSQt9qskl1WWcQaHC-
X-Proofpoint-ORIG-GUID: FBXQbDhIJ0eCwymSQt9qskl1WWcQaHC-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_01,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=940 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506230029



On 6/11/2025 9:43 PM, Jeff Johnson wrote:
> Commit a934a57a42f6 ("scripts/misc-check: check missing #include
> <linux/export.h> when W=1") introduced a new check that is producing
> the following warning:
> 
> drivers/net/wireless/ath/ath12k/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> 
> Add the missing #include to satisfy the check.
> 
> Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

