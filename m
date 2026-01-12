Return-Path: <linux-wireless+bounces-30707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A79D14051
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 17:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4171A307CD26
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 16:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEAA363C78;
	Mon, 12 Jan 2026 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hTxg1/IG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L4ifgDa4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9D62D8DD4
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235291; cv=none; b=rb+Lm5iTgRqi9LgeqmWMqfxVe3m125o6uYc1nyTTnw0fcsPrUtTP/Wdu95I37FbxUvaj453sEFKhqrNMIuxlHwcXdL7xUbkWp7Bw8bpSHW3mZPJqcGUWv+7Fe4eIWuLQRw/8p6GzvuKTiv5OzoR/HoAyUoSAxBYZM8isc+Fp9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235291; c=relaxed/simple;
	bh=1UmdfWn55I5f/jcYVR06AjnGNav6PDiGVpP1RkPLK0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ce/903dmNrEbZuU92Gs9Z5nYIgKNlIYxbc0cgR7QOl6aiaW7NP5RQe/nXQ58vmbhiyCef82b96O/dKJu0pU7Q/V9whM1yaY9FFpj8U6hsqGOY4xMFM/UbEC4GtAePX3z5fBvnsWL3ZaX7QUoG6WAaQx8bnYnOzBPgl/T3yjFiJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hTxg1/IG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L4ifgDa4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CEs3ko1049566
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 16:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BX0BHtmRDW6rztCGXnRYg6OAfxVv/bQjD6tj8Wxww+k=; b=hTxg1/IGiLhOH1MO
	e4NuZjLAEYcuk8/TCLfZNhKC3ZdoJ/V8NyBgWB25TylHSRfoqRmarSG4Vg2/14UA
	3PrK+aeyqYfUd3sqKtgtzr9orIrNSEVEX2fgHmdiyDKVNKIXqSdd85a2MeQGTbAs
	w2qeIQaNqD8VLymUzHUU8cNOn4AM33tPMB0epsD3k+691/KajKYhbwqc/wF8r7nH
	in8Q8Uulj6zYMwMRT0xjGSCGLEgmG5lqJo6IjCOq2Dx5Tc1NdjF4N6/BIEWhunEY
	oZN3kWz8RVeNMyy8INl/CU0XYqOHBWc6zA0sj4zrgAM3H8wNS4gPVH22lJDR79+X
	gcfinw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn34g8b0p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 16:28:09 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ae546fa935so8304618eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 08:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768235289; x=1768840089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BX0BHtmRDW6rztCGXnRYg6OAfxVv/bQjD6tj8Wxww+k=;
        b=L4ifgDa4MRLQuYI5wdD+p/gZYfmmAHNXT9n8qs3jd+X7Ac4saB95itK7EsdvCVhpf4
         9dNR+Y0HUbH5TZutvmQ0MSQipw6msGag04iR27UQAc6er1v0TGK4Fsx8ueMUpL2O8+xb
         37AsKcVa1aAASmA8PsBH2PiGMu7tnnc1W8/YfEwLBDq9+44eyn4nflmF9q3zorNP2JfA
         4RJgOuMOgYP52FAFIBWLu9Z8CwT9njxGCEnz6WZzJbOn9V2Q19/53CSXEzYfJqelQYcu
         fOx4yHIJckbX9bqjtxD4HWWYDE0L3sXekiKa1WCDljazf2+uWLgDchBoYuxVmI9sOZH5
         6q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768235289; x=1768840089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BX0BHtmRDW6rztCGXnRYg6OAfxVv/bQjD6tj8Wxww+k=;
        b=GbAxX1T1eFQImc8V480z0jG0cDX5eFThqVBpAt9mNGcpSjpvsoI6cPwMX4ncSYvC/g
         zZ8unRVHylsfh5HcgjDftam+rRYpEMgy+D+tF5yyrqvHQmAQMUYw8JQic5enqBMfijVg
         4j+VCm5gSX/vYPLxWW+n101OhQV8+6OheHx0E1NxwAkUVbI7L3moK7CPN3JxYJzQ9Eot
         IVwmmz3GI/0KMlPP/+FnQ4mhHwOt3ZyrO9bpXraJkLGhT1sHa8gR5zLQYTVUUYiB9L0f
         PDrydnZxQJSYrgyFV5wvon/AQxQBQGl7Cbhl8l0zkCtzRj4IBFjytnmsgbD0Zzn6DXVS
         DVAw==
X-Gm-Message-State: AOJu0Yxt91gZ7tyKMdqcUoBULrIKj6jlmAP2O/S74KpkgxXNMh26IVvo
	l4h3uuFJSgBC+YDGPw3cHCh7Me1No9PBhnEBZzzxUIv3fh1o6NsjocP+OLLoI9QFKMNWia2FeNq
	L8pAEjxEQ5eGLRenB25JcFlEZ0xYhq4khq6zGZ02XGhh6aHOJb5G8xc4h2JJuCQsIpVt/IA==
X-Gm-Gg: AY/fxX4NTcPgFfjbg4LJlaGQXR0w5JeHxMBYe1xPzbqTvTWEPSosJhd4aSo1vnLu0IC
	QzYM3LnbeO7Z1y3aGjZqvlM+CiSxT0VlPzrmo6+dxps/60piO04nKgRVfcu6Hryxv8NIjG8Z1Wb
	F28DB52EjbSHzkjOI9RGMDGkFDCtiKCFGlUysHtWdldom5nrvWJ6rXlGN/43FzqfijwaZ55Y/8C
	wWMljvP/kEYCj3Bayfe8n8Feg9PT4XWw95soYZI5FhfeXNtgoJ8ngU7epDcxpNcgTSVWy76KS/c
	IeclqgLC8wnzqyvZenZ0Vfpf8Wd+S7tgFu9syApUU6btsILgpgVjWa5VhNTEHozP5kjL6r53TFD
	mA9S3kaCjzv0icWXKOQ/EzCFftEhxjlJGur11Otv7dl39xXgcklRbcr33jHo2JbqPURjsYA==
X-Received: by 2002:a05:7300:7f95:b0:2a4:3593:645b with SMTP id 5a478bee46e88-2b17d240ademr13189301eec.11.1768235288664;
        Mon, 12 Jan 2026 08:28:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfcGESqLNsZnOeosBVtptLRCe98PHkvfgJ884r3P6qPgQRtxkDjAcEG2KkohFTH8/AkAnuRg==
X-Received: by 2002:a05:7300:7f95:b0:2a4:3593:645b with SMTP id 5a478bee46e88-2b17d240ademr13189289eec.11.1768235288046;
        Mon, 12 Jan 2026 08:28:08 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170675076sm16565972eec.2.2026.01.12.08.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 08:28:07 -0800 (PST)
Message-ID: <557ad1cc-b939-4a7f-99ea-336acc1bc893@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 08:28:06 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: cancel scan only on active scan
 vdev
To: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260107-scan_vdev-v1-1-b600aedc645a@qti.qualcomm.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20260107-scan_vdev-v1-1-b600aedc645a@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fbKgCkQF c=1 sm=1 tr=0 ts=69652119 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=iFBeAqSSch97oa6bARUA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDEzNCBTYWx0ZWRfXyfxs3pdbcS/u
 hK/IoRa/MPqLQCMTV8QytBu8BgPnFccnt3EyAelIADpP8t406YTsAQP6joQnWVkJat9gzuUtqrP
 vdWEw9T6HapIpCXZfbKQeDeXddAm1kV26TjwbZrDZOb3dq0QUN+IJmJWl5XC2/URxD7x+6d1cYV
 gMiWIxXitqE9ur9KRUYU3/ffTalfSz/5inXxJcH/w9B+O4WbslQFH+vNMzDZi3vM/fe0/XjYZgJ
 rXLZQjVbjpkIiTWNs87IPd7Uio4cXtxjRUDLZcS84vZS/z3iEyoR4CRYA6bIT41rYMHr4RahMwn
 O4xj5wSTvnXCOxOoXy17c53zDgNSGsaPHwfqOXS5MM3ni5TVeIIHjoGPUxdGwEGWjk1uTs1j8YC
 Nu9KNk4x4e9nGTKlHrnWIvCbU3ExTZUrG6joaDriWLZdEhrm1xnO5XHLdQm2uu12OV10pz+yC7F
 sneuYC3YM9MFoyiGeAA==
X-Proofpoint-ORIG-GUID: Nh4bl4w1kJ4h50huFeAwx9WscmowGv1_
X-Proofpoint-GUID: Nh4bl4w1kJ4h50huFeAwx9WscmowGv1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_05,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120134

On 1/6/2026 10:02 PM, Manish Dharanenthiran wrote:
> Cancel the scheduled scan request only on the vdev that has an active
> scan running. Currently, ahvif->links_map is used to obtain the links,
> but this includes links for which no scan is scheduled. In failure cases
> where the scan fails due to an invalid channel definition, other links
> which are not yet brought up (vdev not created) may also be accessed,
> leading to the following trace:
> 
> Unable to handle kernel paging request at virtual address 0000000000004c8c
> pc : _raw_spin_lock_bh+0x1c/0x54
> lr : ath12k_scan_abort+0x20/0xc8 [ath12k]
> 
> Call trace:
>  _raw_spin_lock_bh+0x1c/0x54 (P)
>  ath12k_mac_op_cancel_hw_scan+0xac/0xc4 [ath12k]
>  ieee80211_scan_cancel+0xcc/0x12c [mac80211]
>  ieee80211_do_stop+0x6c4/0x7a8 [mac80211]
>  ieee80211_stop+0x60/0xd8 [mac80211]
> 
> Skip links that are not created or are not the current scan vdev. This
> ensures only the scan for the matching links is aborted and avoids
> aborting unrelated links during cancellation, thus aligning with how
> start/cleanup manage ar->scan.arvif.
> 
> Also, remove the redundant arvif->is_started check from
> ath12k_mac_op_cancel_hw_scan() that was introduced in commit 3863f014ad23
> ("wifi: ath12k: symmetrize scan vdev creation and deletion during HW
> scan") to avoid deleting the scan interface if the scan is triggered on
> the existing AP vdev as this use case is already handled in
> ath12k_scan_vdev_clean_work().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Fixes: feed05f1526e ("wifi: ath12k: Split scan request for split band device")
> Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>

Since this fixes an issue in released kernels I'm taking this through the
ath-current branch.

/jeff

