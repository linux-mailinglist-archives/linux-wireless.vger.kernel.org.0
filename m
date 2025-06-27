Return-Path: <linux-wireless+bounces-24603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF835AEAE7E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 07:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96EC97A4DDB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 05:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E0918E750;
	Fri, 27 Jun 2025 05:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N+xn0yDw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B84A0C
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 05:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751002755; cv=none; b=uQ+TkjZpAzfVzN3OgvX5Wm7xAm8AT3nInRQBQoPKCM4TB/T6Bn6I3q6/ZVzvFsTPz8EwXpfX2XN+2YNF0JCs0DYypkUI/I+fIuu29AkuS9BYXQizIqyQ+M3NlbBvvr/62jMBrKAwF3loT+40Y2e15I52CJl3wVs7/+kDcDEgk/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751002755; c=relaxed/simple;
	bh=9lq7yrINizoQwYV3ol5GwiZhoGIgWxMEtODvCYRhoik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REDWL/ApztgJLir14RWgAph1iiqcw01ZhidGZEjPU//901PHFIyXoOnQXH+GA7CdEJi7tQtFaquwEI4y+9u82Vpv0dYikuwRplPJ9ceEEnWaqiox2q32534cYIJso3KiIYsox1ESYEt9MSApz1ER9UrljqlCf202eb8zwE7Nisw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N+xn0yDw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R4D8uf032657
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 05:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oxTpg++xQo/Kx2N25g5VpBf60MBGualJNHTFqUV2XeE=; b=N+xn0yDwZVR2MZss
	MUe+jtNxU4bz3McjadRTik1fjTCK1ttWOEJMTPT5tU+pUwa4l7MSYT7ZaQyRhCGq
	2yUK1f8yPT1EnAErMuTeUoUlhgtpgKRuSh7hEuhsZrF1VCZOCi8AHwLlhmgnUiCk
	+lLEkNuJCqV48yFLUCCod35ZARTYg/riYubiKS2+BC5Kne4A9YsghJ6UVjCsW6Gw
	ICuRIT9NGCm4JDBek7HLQwAFKaa0ySNY1lRcOonQ8bFJp/4O2PGquf8Wpof6ZOsM
	qfxr2npfANPjvOrNTMExcqOL8eGVBmmQwXOXAOIxiasLNIqgfjJadraviFexlvBc
	8FQSrw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g7tdfj41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 05:39:13 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b2fcbd76b61so2158263a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 22:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751002752; x=1751607552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxTpg++xQo/Kx2N25g5VpBf60MBGualJNHTFqUV2XeE=;
        b=qnHCqL/4DjIPq4C6McvzRESa0xZacts0v6COXpp2n/Orynx9J5+aLLiGs/e5kk3y2h
         OLux3bNCpwlxwiSAgkc0BRp6F9p+/EnbEZh7jvepjy8Mjb1ik0Za8JXgxo9dTzFjtXbe
         Q/hfQkFWMP7GFKLuQKbdn6NmNJ62VtOCoI/NhrqWN2fGFQ6WRyt3Gl0LHmrHfHir2I3c
         xZycgthcrkylt9tX5di7Z4rNvG5WuXgw1HAKmScTQ2ZjZ6Ji6/fyXBQm2ZjvppSUyoGj
         iICYo9IVUZsfHmrUwTagdI1e+Guou4M8mdrH3kfoiS+owToMS+7TsUo0h6ClOj6hyZBC
         4Mkg==
X-Gm-Message-State: AOJu0YywwpfnMEYyPnxo9n/xJLh/IHLduHG9WyqHvkBZYZv5a96ikOvl
	pijUKq2J5feDV+iXwvaqm/6gwiMSdo7TZdbjL6+Dzu/IQBOf4QHFrfuriSVtl03evKkLW1tE3jy
	pu7ey9Kw50vj7REvv3I9Q6T7cyl7ROIEtpb1Snn9ureTyAf3pYBPA5cidXQ7m/RHNxTVhxw==
X-Gm-Gg: ASbGnctv3IXMU1TmHilSYotWgMHoaj8iETOOY2pMx5xyy88k23zgMZGYuLCq9yp0R1r
	n1I3sMMXvOtozpskVHsfcufQA3pp4Pwsih6EbjIbNHpy7ux8EPUBBCH7EqmjnnDaY3RFOi//97j
	HMUctXGF6GabI88Ko+KKkEZeSXlGHs2hN5A70ePUPbTut55vTQ1cWcydBKpfrRZhv88mUpTP29w
	vEqx/rDsFXRr45a1tFFl1m64cZ5W+7i0CLdywItKL4PBnhOiDDeCAkLifaw7maEzWrUN0gyH6F3
	LL2LsMpf3ObT14o98ZU9E6wTcOBxFamb3RN7QB/pmmOfK4P5yW5dUW2BBCv5NUtOz/4WMEfPSXz
	oovlsCauCZWhHRA==
X-Received: by 2002:a05:6a21:3394:b0:203:bb3b:5f1d with SMTP id adf61e73a8af0-220a113ca4dmr2981998637.6.1751002752137;
        Thu, 26 Jun 2025 22:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6SJ90oL14ce7W8awMAVolaiw2uwi0whL5nP8wepFa/D1DEk94f0Oa6WqT/XC4xbcrBTqKlQ==
X-Received: by 2002:a05:6a21:3394:b0:203:bb3b:5f1d with SMTP id adf61e73a8af0-220a113ca4dmr2981969637.6.1751002751716;
        Thu, 26 Jun 2025 22:39:11 -0700 (PDT)
Received: from [10.133.33.95] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31d85b4sm697467a12.56.2025.06.26.22.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 22:39:11 -0700 (PDT)
Message-ID: <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 13:39:07 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k_pci errors and loss of connectivity in 6.12.y branch
To: Matt Mower <mowerm@gmail.com>, Jeff Johnson <jjohnson@kernel.org>,
        will@kernel.org, joro@8bytes.org, Robin Murphy <robin.murphy@arm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        1107521@bugs.debian.org, iommu@lists.linux.dev
References: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CPYqXQrD c=1 sm=1 tr=0 ts=685e2e81 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=xNf9USuDAAAA:8 a=1nlNwiK_QeuRR0xryQcA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA0MyBTYWx0ZWRfX7wVKZlXCwlEt
 8WH0vTsU8slv4kaU2Hm/tIofhH4m37E6Yedi+kqLwolWf6pW9CW+o0cuID5tXZZYvIclUOED7km
 uNEisjz97tcMLKR1jjt/UcEzMMpbicG+zVevfY8RvP/sjI0LbzHsKQRE42QRtQBWgG8iuWGqw+k
 qa+SM3FOpFB2p9H25RXZ6z7uIG5aIEoR7BksCqD1kD5WssT2PYjiXI7kgbkUvFtwUzLXOWE6jMB
 z1JGWj+fjRKXXF8VVIrspNFaMyFDmyk/f+ZO0mP+3dvFWv+0AXnsCX6e+PuS0mL61cJLb999/Ec
 YZf6bLeurjqxDMhJtgfuHXRPjuTdx5f2x3ouKAIMhzA+lAI8jaw6Fu4PI2McU2MiER8DvzaS55u
 fBme2zGz6gquPwyfhgq1bwtwrkkssAaN5AZa08RARG6KapVYTQVXpdr98HUOUUGUyTA2ustf
X-Proofpoint-GUID: 1h1_yT8ysvIo4nr4nVNH9CHjZ8rv3-VC
X-Proofpoint-ORIG-GUID: 1h1_yT8ysvIo4nr4nVNH9CHjZ8rv3-VC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_01,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270043

[+ IOMMU list]

On 6/27/2025 12:21 AM, Matt Mower wrote:
> Dear maintainer,
> 
> I have been experiencing lost network connection with the ath12k_pci driver
> in the linux-6.12.y kernel branch. Often, when the issue occurs, the
> network does not recover until I reboot the computer. A full report of the
> errors I encounter, the symptoms that arise, and several dmesg attachments
> are in https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1107521 . I have
> attached a dmesg from 6.12.34 for convenience. The short summary is:
> 
> 1. I started noticing log lines like the following soon after boot when I
> updated from 6.12.22 to 6.12.27. After these events occur, the network goes
> down and often does not come back up.
>    ath12k_pci 0000:c2:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
> domain=0x0010 address=0xfea00000 flags=0x0020]
> 2. I was able to reproduce this issue very rarely in 6.12.12 and 6.12.22.
> The issue always occurs soon after boot in 6.12.27, 6.12.30, 6.12.33, and
> 6.12.34.
> 3. I have not reproduced the issue in 6.15.2 or 6.15.3.
> 4. In some cases, when shutting down the computer, a kernel bug caused my
> computer to hang. I haven't determined whether this is related to the issue
> above or an independent issue. Search the bug report
> for PXL_20250611_140820085.jpg to see a picture of the kernel bug on my
> laptop screen.
> 5. I have tested two firmware versions:
>    a. fw_version 0x1108811c fw_build_timestamp 2025-05-17 00:21 fw_build_id
> QC_IMAGE_VERSION_STRING=WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>    b. fw_version 0x100301e1 fw_build_timestamp 2023-12-06 04:05 fw_build_id
> QC_IMAGE_VERSION_STRING=WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Thanks,
> Matt
> 

I had a quick test with 6.12.27 kernel on both my Intel desktop and AMD RD but didn't hit
the issue. And I am using WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3.

As mentioned in the Debian bug report, since reverting ath12k patches does not fix this
issue, maybe it comes from the IOMMU subsystem?


