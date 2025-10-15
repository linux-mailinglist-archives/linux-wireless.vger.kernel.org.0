Return-Path: <linux-wireless+bounces-27982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95948BDFCF8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 19:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 541C84E2973
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B7B1E2834;
	Wed, 15 Oct 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="URUdFlNd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1A1494D9
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760548058; cv=none; b=N2sXy7+iDEy9IwoZu8UJl1J8lY9zVOHUf2cAJ/WKKBPb+mCGnpwOkOgkvfk9uuTRXza8UvRQ75nmYKPsmsBZ+JC2fXDyppNj49tOjMeJDWbip/b0l9J0Wf/lL/P1zP4FkIDMc0pjICmpmW4ztIULc9ER0WWiDhD7bFsUYkGjsAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760548058; c=relaxed/simple;
	bh=4gIQ8MY2q/NHG00P05QMOffvknJPKdXyO7lLbZ6QsDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpWpq5N8xikdMiDwKpBFgQjC8QsJy2tj6UEZWUOEEGykTTsAkoPiUUX4OEOKckGeOjapx7+/MuYOI7S5RB4e22gEIvpofF6Xq3YNYQLZycPfzwS86CCwxB9IoD/P99/Pn4hz5OaYom9ZtrcOdDzjJOF59D3JlvXr8fsaHN2rjD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=URUdFlNd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAsAcw004012
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 17:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ER6YjiFcA/feKYSmRBazTonHCxX76/YneCj8QGblsHY=; b=URUdFlNdJxsZyKXc
	UWhSzSq2sisC4t4NDpbZjt+g2VWWdn873bD3T0sfaE6sMy3M6IRARO+aRMwJF21a
	6eFdUbbt+4XW8D6CKDPFWqxzSD6HscBP+MWfEALRlddaPcnCmgOBpT5lTDGx9o3n
	yGZIj14eWf8iaUnYD1c+KqgCt4YEw+I+H2dtO7am33Ze1BDSYoXEiZDLQVgouht3
	bI8i8Sf3pCflaX+J/3QPvvasl3nJXSrL8m4oE610VKw41q518G1KfEyzYqgfUdn9
	HFw9hEZGHHyex5/mBnN2x7Fic8Yd9PkK2zl7TJr1toVNlogTo3Rlmr7MCTXYxY5Y
	R8qbKQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdg565q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 17:07:35 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2908ce6ae6fso8320685ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 10:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760548055; x=1761152855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ER6YjiFcA/feKYSmRBazTonHCxX76/YneCj8QGblsHY=;
        b=w4pOO42Ef88JAVPM13UettfY6TF7alGUjY0GDyccYwC3XG0V9hDk5v0MGbo/U5Pfyi
         IjZPuiKi5jEKdomS8nymoAxDh/0efG6tawtj5Wgsfam+g97jxhhkiCoKqEzCoD0zVDbC
         AC8fBk1Pgm3qP34iTquuDz6/gHMQEEl65iswCkDbkIOJgwZC0nZfan0Y//k3ENh7xaz3
         GHmQrir0qfd3EGrHCLE+1P0o9vGxC4nBKVSMpRmpMa2gtTMX2DiULKJgG4WoC1CAFCt2
         5+kBWOdjiOBN3k7w6V1QSsmRbYGKlsiETrEZVmpQzFOw7FPwgdsEIjHioSnVCMg7IIrF
         h5pw==
X-Gm-Message-State: AOJu0YxDtMD57PK9izMbhpXYJqg/KWOO51FkyGGmpl7NXcEOpypkUtha
	cAZ5OhMEqRQqHIrKdW+W/90dr7O+Ap+Shno/rjxIfZjoboT8JvW9yRbXXWjY8pE42XymUSg49FY
	4T5R5x563RHltoYOyp0azbKI9zD0A2C4M6yxj8rFrkTI6IL17ZRC+zT4Ed2FWyZaLtBcvAg==
X-Gm-Gg: ASbGncv29I4zVQzhS0kZODkpDasst7Y2997M4DigIcoD1yWvzqsSPU6cmZ1BgoUMViV
	67k890uP44sa+TfLQSyblVw+sq/GPokn1Ui1e8A9fXkMmJAeoSEK8lstqGxiXUEbwPitNPjpelT
	In9OVhbOxfGoS19WUJVClam6xRiqM2QIO44UbZSma0gNU21qw8MzxSPPPJrIMq5IZDCEvumYvuk
	dIpAQ4TaIQjXLNN7HORALqj/6mpRhDTY5qUkMGFhG6matM4A55J1haQg0ZIpWa3ZuPBSZEiXCPY
	SkoNpTG+HsFlmyiqYq/2FH+1NQQDisfb0fg56suyRmcN6bZRFGNewUa5EJSu0IJwhKgWN63fLEI
	BYYrzckP8zChAlrjO
X-Received: by 2002:a17:903:2a87:b0:24a:d213:9e74 with SMTP id d9443c01a7336-290272dfbb7mr394959285ad.49.1760548054916;
        Wed, 15 Oct 2025 10:07:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgGw0sx4mATQvCFsp3O8qgC1svgO52zfnOuDR7jXODkOc9aPTnPuCr2kjWyVg7AaI2zq9rxA==
X-Received: by 2002:a17:903:2a87:b0:24a:d213:9e74 with SMTP id d9443c01a7336-290272dfbb7mr394958955ad.49.1760548054273;
        Wed, 15 Oct 2025 10:07:34 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.230.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909934fde5sm1903185ad.41.2025.10.15.10.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 10:07:33 -0700 (PDT)
Message-ID: <0d600a3a-4c7a-3637-380a-e23db8fe74d3@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 22:37:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Fix NSS value update in
 ext_rx_stats
Content-Language: en-US
To: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251007133332.1092178-1-thiraviyam.mariyappan@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251007133332.1092178-1-thiraviyam.mariyappan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfX2kFZHcPip687
 dBZxoMJNeGFiUKnGOwkZ83f0GHhFF0RLGAGvAG3CjXoyS+HKnoyAcKPR6x2QmxvoSS0nTYC/tfq
 K/fmIQB4hypw3bcKLutJ6/niVeD8wM5JQ9K83KJQOKA3r0nS7WrvQ7SAHc3+pYg9cjxAEbKVFnJ
 pER6OYSO1sxYbAx3LUMyZjIbxOh3ysTphZYofbrRhCeq103Obxu++0qoaJHJ6CbLwm6K6o0Zyft
 rSZdd9AJFvBh5bV57d4aSAF0cOJYRJxAIdKRuvdGZwPMQTLUFUvyTfryTAq/ydWL8SVqlTecxCY
 rnOsDqG1IMwMO9pxIIP+UszsvgAoF8b3kITAQuQsFxHjJNlGxxJqcDT5iBn89QVHks0yI/qIQAo
 hRoEpl7WPTESK7pUjC/X4Qdc41psWA==
X-Proofpoint-GUID: YWc4GO2B0MeZKdrqGHCe3Yn3gkfILy_2
X-Proofpoint-ORIG-GUID: YWc4GO2B0MeZKdrqGHCe3Yn3gkfILy_2
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68efd4d7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ywaSrutoL1r6B8MZccleLQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Zs9DEkr-8YzyMXDGHikA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025



On 10/7/2025 7:03 PM, Thiraviyam Mariyappan wrote:
> Currently, in ext_rx_stats, the NSS value is taken directly from
> the firmware, which results in incorrect mapping:
>          4x4, 3x3, 2x2, 1x1 SS are incorrectly updated as 3x3, 2x2,
> 1x1, 0x0 SS respectively.
> 
> Fix the issue by incrementing the NSS value by 1 while updating
> the PPDU info to ensure accurate spatial stream statistics.
> 
> Remove the redundant +1 increment in the radiotap header when monitor
> mode is enabled to prevent double counting.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

