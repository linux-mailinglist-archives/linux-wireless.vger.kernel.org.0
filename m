Return-Path: <linux-wireless+bounces-18388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C70D0A26C9E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 08:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69BEC7A3E6B
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 07:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08242063E7;
	Tue,  4 Feb 2025 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HVe2M62G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18837204C1F
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738654518; cv=none; b=YopIMGAKfRXTto83HDoDX+fBsLf6PNfMHtVqG1GqAb/S/Sug25uPZlKdtChpqQz8ZD/uByzcPGTdy/2abO0RXYBgUUXhhn7X1PT5qhkrGWnwaQFj3DPNBnxiMmzyHzaWU6DS6wUmxas0DN2q4XXaRwiuNLD+amgOsU9iqllS5xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738654518; c=relaxed/simple;
	bh=xQAGdSbSIYSyiBdU3C21sOz/sN3QXi6wsOZNmif2uiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1kdcU4ZuujiwlFN++YCYacUdAw+JaOILEUTXUknsLSKCSngeBMWpC2VPoiony+7+YXqBr2phPHBsIAC0spE4TRgqDCSyb7v5eI6b+CZ169MO+XDDHeD/gYpC5NNzaUa4CISyYxQVHnxjKCZwu4+mA+Nk0RDgfTHAJrgQxCykmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HVe2M62G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513HfVnO017317
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 07:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C8CC3DNaNwstjCL5UYvX2ni2+zBNkZ7cSI4Dr0j1vnk=; b=HVe2M62Gi7FCp1Eg
	xkDyMnd0EX9PAyRkjey7X980MzYXFE3PsrG1XG56MRgZVPciPAOyl0ibTu6/CkiJ
	QtPYLck2Vg+Db+NOOC9qqW7JkpoExK9TbPjec8WC0DxKxq4eXb4iXWIMM0yvpKtk
	cnX3Ru1OHMfXK+s+icundJ7T3c/i8yl7rAO+42ioqeqdLVxHwNjzhZLjGJKKohmJ
	1W81NE2WLTuAcA5Cwzh/5KgeAyqcelsoMy3m+hY5x6mSpNlJ0BrWkoHf9CZMHqTd
	PoG/rY2Hbx+SIULiGjX+iRJ2nt1E6w7vJzZL9B0V/IH4CvRtowfQ5JqbQBpxyUjR
	Qf2kWg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k2e1hjk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 07:35:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2166e907b5eso97489845ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 23:35:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738654514; x=1739259314;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8CC3DNaNwstjCL5UYvX2ni2+zBNkZ7cSI4Dr0j1vnk=;
        b=P8UBr+oKXidW5NE8uBjKwV9QgLNT6QApVPSL52WLys6P8NxarLUdTdjM8OJn57Ej8R
         xgishlqhLaGV8BS7wvjZoQTX9T9ZAlOk4Dko9XYkJzyJcutwMVZhKiTuOXrWyr/XhUh3
         pTuFRsc09sAP//F/D2Z0inbXrvW+3AH8vNkdAmAdaGyQd/y60UHMRZUVOs4mOQXat7cJ
         i6bGVChQz50IMxoEffcTEKM3TAsoyITGMSnHkQAT1hHtwq+LIFqTzp6zxZjszaSV7AQD
         Fyb+OrDmy4ZMJMToFx9AigBk+RIVc4KlmvAzRISixb0B82vXvUW628GYzhuN8khBdpfO
         vh7g==
X-Gm-Message-State: AOJu0Yx+n/Z5UaLoaVEGQGUdthXFWRG1PjBGfuSYJVUBtMCkE7SrM+DG
	61DAdztZ0F27fb9ev/NPdXlXNasLXmaajy+IxAh86IU7Ijm4tE/IxQZY6hK2agmJd9yuIXGvD+o
	2OG+vGUjBiwynoCTwr9djBbZJUfp50PRJvjI3ZUSze2zZHkJtRhQssR/vPu24fTcSrnocw3xBMg
	==
X-Gm-Gg: ASbGncuv4yoWwD7APD6QX6cGY2SYVtZQUeRNjNkTiG5oDaLZmrMTxZAQeNYyo79ffN7
	/BTXHYXI+fiIrCQV6/3IjQdxS7GRuKqyGIZBnXfoL900ipXjxb+f+/DIwaUfRj9IyWrUwnn9xAe
	MGVPYkvc/tu3QWOoE2s2Su7O8CFqy2mR9DK6t/GZ9eoZx98qGNnNoLrNZ2MhOQu3D4QPjRHkMy/
	fFU6/Xpqe2h27I5OpVG4b1MCS/3sMW+6ICs8aa9EwFQp6RS27VxCqeL5sVgu7I40I14dvxbmo8L
	ct36B9c93gSVlmVUEcKRLOPIJ58TKEt3D9me3qi60hwKIR4=
X-Received: by 2002:a17:902:d4d1:b0:21c:1140:136c with SMTP id d9443c01a7336-21dd7c3558cmr363849575ad.3.1738654514270;
        Mon, 03 Feb 2025 23:35:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4gw5bm/pgvM7hItOIb2mRVVbANXJ5lA/uYMkezaugLu7QXPhkzFwO5gbkOyIlpplWZcOdgQ==
X-Received: by 2002:a17:902:d4d1:b0:21c:1140:136c with SMTP id d9443c01a7336-21dd7c3558cmr363849335ad.3.1738654513798;
        Mon, 03 Feb 2025 23:35:13 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de33032absm88861265ad.187.2025.02.03.23.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 23:35:13 -0800 (PST)
Message-ID: <18856414-c05b-a737-5567-e8669b2349a0@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 13:05:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/8] wifi: ath12k: eliminate redundant debug mask check in
 ath12k_dbg()
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
 <20250204-unlink_link_arvif_from_chanctx-v1-1-675bd4cea339@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v1-1-675bd4cea339@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: z8uyTA5_TmgunsBDoebFxo5hMhxLvA2e
X-Proofpoint-ORIG-GUID: z8uyTA5_TmgunsBDoebFxo5hMhxLvA2e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=688 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040059



On 2/4/2025 9:53 AM, Aditya Kumar Singh wrote:
> The current implementation includes a debug mask check both in the macro
> expansion and in the function __ath12k_dbg(), which is unnecessary.
> 
> Simplify the code by removing the redundant check from the helper function
> __ath12k_dbg().
> 
> While at this, rename the first argument in macro from ar to ab since the
> first argument name in the function __ath12k_dbg() is ab.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>


Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

