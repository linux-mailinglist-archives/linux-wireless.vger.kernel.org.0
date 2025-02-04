Return-Path: <linux-wireless+bounces-18389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D71A26CAD
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 08:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846DB3A546D
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 07:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8782B205E3C;
	Tue,  4 Feb 2025 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="elhIx59F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D12063C8
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738654542; cv=none; b=mOokdahwkN/iih2Hl3UMvi4PXmezzysrIDEmF4RyF5p4tbbaN/0xG637ym2qxVldUgn6H9tsBv3uLkv7mC/8VCLFO6trZimOCpuV+Z3bBhauGWK3ApmFR0Dr2lEY3HWilMFW6XcM920bVFcXB/On8Jrtt6bumQZe0rXQc4n/Y+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738654542; c=relaxed/simple;
	bh=UVE6Ky0ozJFP73SEeYl+6tLR2vKwsp/lsx7Dhk3iQTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urVV8ESgi3hA1heOswD5YOQzW2UzECPUC8iv1h91WDSfekVgdk8hUiDyYKmwkCr/XcB4ovI6dTMHIGb+hulV1vHzMD731nVXkxhWZUW8ptbG3VM11tu8/fl5uaS6lcahiu5Lvc052204zTfXu/E+hQmsmyD7ZJweC/PTIkdrpp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=elhIx59F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513IpqBn006198
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 07:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s+Q7fwg4Y/Yig7iso6EaoY+cwSC1kIR0eqU/1fGE7Wg=; b=elhIx59FZmqV71uF
	qmxP2jQP5MKJxRMo3csLPIJmU4jL2lt0vwF5zG/WFYXJZ+rhwOsqfiNm1Gwtr08d
	Ik8xMMp2wvoF/8J8BGdgyFL45duoWVE80uuVjXX2NT8Iqfdb5ClyRbeBCV3YyqKw
	MQ6dpBZWoIbMj8Cdcs5CL9WhdTtDtHXVBg2RundF5MV9/iV4r70vL8ypm4usxBLX
	0ALh1yXUIgIbjemLXwjSBHf+UqUCX0xwsicWUPq10JTF029mgjtjM99zHZw9IHIW
	otfig6xd8Bw2wJAXXC0kZogFgR1kj2eDlaW2AtHTdF5ioIEOr6j3a0AD5dLGAufy
	ZvE1NA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k3ex1cfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 07:35:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef9e38b0cfso9805305a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 23:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738654538; x=1739259338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+Q7fwg4Y/Yig7iso6EaoY+cwSC1kIR0eqU/1fGE7Wg=;
        b=rGrBMs/BpsEUIunYFneo1r1Hw4DZjniwLiESdB5S6hFNvr+Zwcx1UD7OLmwUZyI37f
         2Lg1cnhAeEeAi5B2WaOFSKZZwGlWVOs3AOxdhvRM/7UlU35JAhKk+g6QjkOr/RSzFV91
         Y+HVMbz8IvknutFBJnkX9TUc9YWtEiHwOQYe303zFlhvekP4koPXUtlaOVynCL9nRxQw
         0WLGkBsI+04cMuuTUUmC8y+E7VdNtrQImneAHv/GDoyBQVwwQ+Z2a3kKtH49y15kKHzI
         8lvHqMFVWx4uETVZcZuW4YO9R3Sv5CAcKw9IlvLQlDdKRMnuVgqO6EX05CvnyMESuhyF
         zf5w==
X-Gm-Message-State: AOJu0YzLZdlzxmdmo+b9D1KU68JL4/4lmAV2mAXEqEyhAE16cbZQOYXu
	A5kiyaYc9mvKScu2pWsRRZecEb8hPwiZeRMylJ+S74M9wtmLzZcNG4aCQA1P/VylHousYfU/xUS
	gTDCeBO+pOPzoNZmQF80aMfOAl5NMFh8xDhMuEDhVG4Qut8FiOZT1v0ZKQ9W8vvYkaeKtxFePwg
	==
X-Gm-Gg: ASbGnct8+xIjSzGMJiztmbHNI0qVyUA6qtOLYqK9ba7uX0B4gVmKkSg6qVLP9DLzY3f
	t3T8qDqIx9SxXm7LtUVINKX+lpochB/QwIon9VUBYK0IX33kN5mS2V/m7/tDMsoBrbQiCHG4zhW
	ncfQXmwYoJE/nI6bYxOcNEXm3mAmgWSrQawImGxdzB03PtJ9xoO2+EOwl20y5334kgf8SfuuA5k
	5tC9CIV5boP1zDc2Id3ElF7Ty6/OQBA7/qSaUO8Vh5I+VolDifRGo6Vn7OnJR+bRhzP/1KYDzsR
	JDeUomxlbCydSDULZBNRMIfEt9iKAV/R2bCrcxijdD5gbuA=
X-Received: by 2002:a17:90b:4c0e:b0:2ea:4578:46d8 with SMTP id 98e67ed59e1d1-2f83abd8358mr38267860a91.9.1738654537397;
        Mon, 03 Feb 2025 23:35:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC0QmdALcPNaB5gn6f3dvnGZUrUa/CC1CIXJWYwdx/zV2uoomKS2WhrQZZyEKUdXB6ADRMaw==
X-Received: by 2002:a17:90b:4c0e:b0:2ea:4578:46d8 with SMTP id 98e67ed59e1d1-2f83abd8358mr38267750a91.9.1738654535578;
        Mon, 03 Feb 2025 23:35:35 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f03b76f67sm7507785ad.237.2025.02.03.23.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 23:35:35 -0800 (PST)
Message-ID: <ed89aec9-99ba-7b17-d50d-93fae9436498@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 13:05:32 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/8] wifi: ath12k: introduce ath12k_generic_dbg()
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
 <20250204-unlink_link_arvif_from_chanctx-v1-2-675bd4cea339@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v1-2-675bd4cea339@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QAQyYQhr0JEDuDhpzhJLh3qcbV1tOu_K
X-Proofpoint-GUID: QAQyYQhr0JEDuDhpzhJLh3qcbV1tOu_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=761
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502040060



On 2/4/2025 9:53 AM, Aditya Kumar Singh wrote:
> There might be instances where ath12k_dbg() is needed, but access to
> struct ath12k_base (ab) is not readily available. To address this, add
> support to print the debug message using printk() when ab is not present.
> 
> To avoid the need to explicitly pass NULL each time, introduce a new macro
> ath12k_generic_dbg() which resolves to ath12k_dbg() with ab set to NULL.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>


Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

