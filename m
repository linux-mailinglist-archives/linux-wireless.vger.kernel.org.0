Return-Path: <linux-wireless+bounces-24631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CDCAEC111
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 22:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282A5563AA8
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 20:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB68922D780;
	Fri, 27 Jun 2025 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LlJgQf5o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D9E227563
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751056578; cv=none; b=R3TJYAUFBHjeOEeILA5TDZK837YbWo+2MxoYmPVJR2vwuhoBo+62oBlc8DxcF+C4yD8eGTklcwjbDwMvaGtFtkmdq4kzzJP+3FJK7PmBv1P8clHyPuPcYu8iO9zWlOhYrDALRjgns6pPDG1+UYBUbYQotmd0cFA/pCv2vfcShLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751056578; c=relaxed/simple;
	bh=wsoDeNMNkj+hLwQ1DwNHFKqpC6UssNz+leDyWs6Tw2M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n5z6zi08kKOr1gLNRdoAqY9hFL2ha2zHEsFCGfDJQgXwNtQr/qLfx+f3yIjhsOh24D7SW2r70BdQ87KsEqzVURt4LhQ3t59K/i6QJUcgqIuzWDm9tKLInYS17tLvWMqsElygrzGMddiyPFnPPeLme+onoPF4m+V6ZurW5ql9i/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LlJgQf5o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RCAv9Q014870
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 20:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dKmlYnBP9zOMxT8PZn1r52h16H/B0zHwpvwe0daHy0k=; b=LlJgQf5o0xsZZxNA
	RYCIxKueCv6zkmlNfPlFNVx+Q2Wdc6us2nG5NjDezr6G3fTqvFTGDbwy5GCVY1gp
	Z2d7w6LerftUaeJ4Jd8mwJEwlEw4w7cvjjGqyZz/igqRkfi6SZZIQd+NzhmTWwhd
	5L7g7yg0EHRV8tqPQv6hSOjjPk9t0Lfo4h9qPm6VfXmJISMXzoRqRptSsLAfmIyy
	dNbABuBECfU9jqU9xEcBX5nX6BKHi5b93F/SVOxpC81UOZPHE0d841JDTRjsDoWN
	O6tH+V3KMne2ALQ3e/XzA+jQ9sdWQ6JxjTHlyBZPgkRMm8NJcAIrfpxH+Jkiq5wA
	tOxCYg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47emcn1rb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 20:36:15 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748f13ef248so296897b3a.3
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 13:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751056575; x=1751661375;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKmlYnBP9zOMxT8PZn1r52h16H/B0zHwpvwe0daHy0k=;
        b=BYXlB0iHc7E1/x35BAk9yRl9tu4NYkTpn9wP7WZZYAJQQD+4Nt9hDKapAMcCM6m4wr
         M6SCMwFtXMZFrybclcRfjpMJg2xVY8ZbKA4LbSoDikd7m5lmpMWgOjBrk97COUZziTEJ
         vx5H2SUMzZEJwIiz+MQjxr6Kjr247RAXucOKE5agGMCcaUwwd0pC4H5yFZ90Au9YpLvN
         KkIf+O2Rve/GCEl6x8qnBWOLBmKCr7+spUV05l9YF9Qvttl7jNzckJPp7THb09Nwubfc
         BuPmGKISMBEuuvpoX7cO0UpOpyjM3dizTCwRY5qA5zobUPfTUiTDUTPBgc/LLvLZCu/9
         QTPg==
X-Gm-Message-State: AOJu0YzGSojNPoGZau0B0zsIfK9/i9pEmVl1cyT7M6HAz4e3Gz3lH+aS
	/Bj4lD/ElK9cfzhVysD3OMhJN1+UokL86PltHzKK8DTEauk2y2Ul5r5bhPYDEjqQQuUTJ/u71d9
	H1JUPT6ArrZjrsDKE+Vn8Ek7hCELq4SwIH2bR0+NpphRqTkJPELqq2oOJH+eDAKHAh1B28Q==
X-Gm-Gg: ASbGnctBsL8EqoJjUpuv+/35s7Z1J1WW+wFsILhOB+xw3i08gNzxibkDOu0P/y+4R0m
	j/6E9a8A4Fyf8bsxMEERjlgHqVct6dxTMDx1KJXnpY/QlcaXcMYSD+BziVpL/IdWJ3Lk0sN6Ksg
	OIzxi/LqgobNiW6c7Nmr0SF3GVQuuqU4zs1ISd5RbKUEbaVYKWUfKnxHFe/j2tkGBKZmfeN+Gpp
	8BOAKM+Jzt95L8516bmWH+kj/UiKAXV8TPRTaor3m9rSc/fsY8LHVPIK2O9NyIqs9zYjdHJK0VN
	X8403zbZDwfj5GfO9qmmLHsyZPRny2NV3oLh6G9vgf3K6ElyRwDKreTdJRc=
X-Received: by 2002:a05:6a20:7d8b:b0:218:17c4:248c with SMTP id adf61e73a8af0-220a1696400mr7154807637.22.1751056574730;
        Fri, 27 Jun 2025 13:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvRRER8EH+IDOvZPMZ8NqWYOV/aI1CaW87KVYa2720l/lwfwzGQgiN3cck/ApDlyzqHXs54w==
X-Received: by 2002:a05:6a20:7d8b:b0:218:17c4:248c with SMTP id adf61e73a8af0-220a1696400mr7154773637.22.1751056574326;
        Fri, 27 Jun 2025 13:36:14 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31bea0bsm2240472a12.41.2025.06.27.13.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 13:36:13 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kang Yang <kang.yang@oss.qualcomm.com>
In-Reply-To: <20250626-fix_timeout_during_interface_creation-v1-1-90a7fdc222d4@oss.qualcomm.com>
References: <20250626-fix_timeout_during_interface_creation-v1-1-90a7fdc222d4@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] wifi: ath12k: fix timeout while waiting
 for regulatory update during interface creation
Message-Id: <175105657343.1441396.2046714051243602990.b4-ty@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 13:36:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 9G0zSewSHCi8oX2j9kGJrEPqYWFwi5GU
X-Proofpoint-ORIG-GUID: 9G0zSewSHCi8oX2j9kGJrEPqYWFwi5GU
X-Authority-Analysis: v=2.4 cv=J+eq7BnS c=1 sm=1 tr=0 ts=685f00bf cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=xtsjAY5F9q7pcwWWpd4A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDE2NiBTYWx0ZWRfX/8/BW6cAXGGk
 yNCzQ4ZvU7qIkttwpl3TCqYko8ouLtjSGffPwXPTCFwcy9SCVXJ1dOXeveivxin9QeE3mFehMut
 bXntuQPLaPSw+VKFIZHzxwsukQP8hWesMluzykJ+S5zkISWYVA55RCfYE3zAnKi13s6wWBzd+TU
 xuTtXumcVKb9wBVbrMcTYJehfL6NPR0Gcfdlk16YG7nMSKN8/M2mB2xazPHIaBkGVe4vQlILckS
 uvuiUMEp8UFaEXBZXjfdVop0/uGzOTrDFq6AZXMDRo0FlL9/v87/21koJhtDNLVwDoOQrZkuy2B
 na1FfJA99R1PO8aBF0kykwCBPSCYQofKhAo1WdsnToIfFdFLPUU50zOoilhlUVpsl1wTqhuGIgr
 JRvh8TT0LhFHTH4HF8HUOt1y4/hQHVaBYYYuLVwPw3kxbwUHvwoJdq3FBeqZ0jrGL7WZDs2H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270166


On Thu, 26 Jun 2025 10:49:56 +0530, Aditya Kumar Singh wrote:
> During interface creation, following print is observed on the console -
> 
>   Timeout while waiting for regulatory update
> 
> This occurs due to commit 906619a00967 ("wifi: ath12k: handle regulatory
> hints during mac registration"), which introduced a completion mechanism to
> synchronize the regulatory update process. The intent behind this change is
> to coordinate the timing between when the firmware sends regulatory data to
> the driver and when the driver processes that data.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix timeout while waiting for regulatory update during interface creation
      commit: 6e17bbb5a86e6c68d65e38dfc850699e7a0706cb

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


