Return-Path: <linux-wireless+bounces-23723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2011AACE5D4
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 22:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5540F18980AB
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 20:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D521C54AF;
	Wed,  4 Jun 2025 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fYxY/wj+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E961FFC74
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749069507; cv=none; b=N6AirWUCnLjXRtRzPCpE+6e+5KobySzb4d6FcSj/4hyRqidYXrH9d18mnNMppEGxyIEgbaCsFczi3HHsW8cfehjjkvtTF0Xc1zanBSeWniEXAExqIW/6BKaBrMDJRPKHvfJPfw0cuFn3cGcGBJt7aKwKS7IT9MU8WMTfGcs8p/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749069507; c=relaxed/simple;
	bh=NSM+EVrvaZIZQIEIK6rkZ8NkSy1kb1wnmAcVQ14NSy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebXzCE6KqlC4fWpXLyttxPXje0tQl/Y0HplwEo2nlJ3Ki+dExmzDaVxvjUcIb63IidOy8idi73J8g1P3jBfXwbtmcbfhvo7ti+xau/0akq/o5mBbKI+CaPP4Ew9tVQJJfce0RV398Xx+5NFRixQ/gvkDweJY9Vt0oDsRNO7jZBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fYxY/wj+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554H1gT7032409
	for <linux-wireless@vger.kernel.org>; Wed, 4 Jun 2025 20:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nmUblAt7jBdusrwHcLRMAC8WvRtKpCI2QWkSiESjaHk=; b=fYxY/wj+5Q9e6dTl
	ld1DZnLCRw8+yM1tr9YdbgRH7dBfhczwF6X2mm3wD9xwbNgCYUFnVJQL/G8riv83
	MlPxrhF/7rfoonJCCeY+Fi+sobacXJPvUDdYc008qFd0nQCnreWWNmekboDLpBWs
	hYWTmfgIr0BiEo+vq4g8z5mD8zV/n7PVftYLuHXH/qlvRbfuMM53NNG6nHZI6IeA
	PLGKVSpPExBJKWukqsZRZdXe8vq6BwGepIEGDLvsgCaFeYddHPGCd80M+t1dP0pn
	2nahCsJRx9zrMMp4usEI62nbEEXz0n1N+OGj2xHYtDwMoF2llfFk0Z/sGRMmkOhk
	SusFog==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471sfux3yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 20:38:23 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22aa75e6653so1624855ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 13:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749069502; x=1749674302;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmUblAt7jBdusrwHcLRMAC8WvRtKpCI2QWkSiESjaHk=;
        b=Dn25/y4nbNWLw+t0mCHkI1HSYeG3DKJRpcfilQ8sqirFuTT92xOGdjIg3IRPBepFpm
         7Du883PBTmSqPvAu4yjfRPCzx6zKWZli1SRI0ostAzqop976DnsJN0PxRapBjccBmG5X
         XF2GMP6kbYsdaFip1efqMolyarbh6UwdypSwIyqoKdn0o8mA7rVY8WtSLCaz1AlO97z2
         9W9KedMYwjVYwU5uLyvBxscx4kpjMr4UVXxKE7p3CUjZc7oUclKgtu5as6ypc6mF9zho
         K2yPk4FlOl0/pyXML2um3l2s4LaoXzkzG7LxRy/AQ2hujWMmh8NuaAt6F6fWRKxshcCJ
         HJNg==
X-Gm-Message-State: AOJu0YyAb3tYRIjQYhlX6XXg0/g40gDktLT9w22XTkGguoBr27UxE0ad
	LOaSyBDoerRBtkqUaAqUuDA56IARgS5LR7nBLTr250Ravk45obXnWli424k+NE0nYa9WCJvbH4g
	UY8FESpWIHoxPGbd2hglsnSu6uWU/dH9JEFPZH6a6qxKH5+MapA0B5M1UtBSjga/BIOAfx8eGeH
	YSiA==
X-Gm-Gg: ASbGncvsAvcT4DkRuNqBL3Ln8O/dG0PtQYeOGsrMnak9BGaj3rANYhQOHeV8C6xggAU
	ZSfRrlQ6uMwWHq9ve62qNITb4HUU618pc3Tnfq5efWhBJXOFwEL2AedUcziFQylhnxftLtMWV50
	JyDKqlgYp0v7LP2RVMxx84F88M+PGkkhmUjw0kmW1qWvjhJhHIp5Bha1vxz7jyl4yFOo10Vvnt3
	07ts4IJoGiNfvlC7IbOtxdj5MckU6jazgMxhVf4ceY1QNMyK7vPMaRMWtrNLlfJAM7AL/u8ZkwQ
	rAh+DMbnAzbEtFWmbgoTqMnLtAzV3L6ybg66F0ODj0tF1aka1Dp/PRKGWacitM+zq1kqhQ2Peam
	g/aHi
X-Received: by 2002:a17:902:ec92:b0:234:a734:4ab1 with SMTP id d9443c01a7336-235e1013722mr51561985ad.3.1749069502040;
        Wed, 04 Jun 2025 13:38:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDF90qbDcpBCXNvXly3ExJa0JarFpfxkiGQKVK03S6hsQAtFSRuw5EkNYITc2s7I4b9kPu2g==
X-Received: by 2002:a17:902:ec92:b0:234:a734:4ab1 with SMTP id d9443c01a7336-235e1013722mr51561745ad.3.1749069501670;
        Wed, 04 Jun 2025 13:38:21 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2ecebb6b5csm9148373a12.72.2025.06.04.13.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 13:38:21 -0700 (PDT)
Message-ID: <a949a8f5-1b08-4ba8-bd74-c2fd7fb754fc@oss.qualcomm.com>
Date: Wed, 4 Jun 2025 13:38:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: allow beacon protection keys to be
 installed in hardware
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>,
        Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250421114711.3660911-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <D9J8O65N947J.Y0LSNAOS0AYG@gmail.com>
 <57064b98-5950-4b9e-8d76-265e56127dd1@oss.qualcomm.com>
 <9605558d-e785-4eb8-a752-1f591eff393e@oss.qualcomm.com>
 <3249b83b-00e6-464a-a6ad-80e114ffd438@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3249b83b-00e6-464a-a6ad-80e114ffd438@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CY8I5Krl c=1 sm=1 tr=0 ts=6840aebf cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=QtnrFSZZ1VxgPVbhsvEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 2U1PC9TbEDj1XGEg9-O-6A_LAcfQb8pA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE2NSBTYWx0ZWRfXyCKeubGVXaZw
 O9plfTdMlX1RUEpQXho2pQNFkraASN46jhgcroPAyVlgih69G4NpakNQQEE364SwFDEkPBrPr1+
 2KuAdcFVYGj0/3umAs/dPUip2ZsfdwcgjpJ0kV74rg1iNIMH0mYLbiduucTCkiq0bmfq/oFikDv
 GXfeHbtWRCrReAkSI7wXSbsa5d5HzBoLWchQmQXuBsHrNUeTKEXJXTMvr6nnmrJ1wZ/bWU6P3dW
 Ld7tD7rguJ4FAAfHOGq6IGz8Xs7UNDUmpANGCHLHhGySnY1IOAhzVUF7Z+2uUJA05r7fBlLpV/W
 AalIV9GmLxhP7fO6IaJXu4amfoHa18GpBwdvJNZuLCihI1Z3V3/mJjXTtYPWkdSeskE+SxvcADy
 /Sf+ahBeXbWSGL4hHK0HmGX31Pr31TAQu1G3SwyFb8aXXEVVcMi8CLZl1v6hu6pS65oy6ctr
X-Proofpoint-GUID: 2U1PC9TbEDj1XGEg9-O-6A_LAcfQb8pA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 mlxlogscore=874 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040165

On 6/4/2025 1:59 AM, Karthikeyan Kathirvel wrote:
> On 5/9/2025 9:37 PM, Jeff Johnson wrote:
>> Will you be spinning a v2? Note the dependent mac80211 change has merged.
> Yes Jeff, we've identified and confirmed a firmware bug that gets 
> triggered during IGTK key installation, which leads to corruption of the 
> GTK keys in firmware. To work around this, I’ll send a new version where 
> IGTK uses software crypto. Once the firmware bug is resolved upstream, 
> we can re-enable hardware offload for IGTK.

Note that then means firmware must advertise that the correct support is
present so that the host knows whether or not it can enable the offload.

/jeff

