Return-Path: <linux-wireless+bounces-21686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85FBA92D6D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 00:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB0E3B7E37
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 22:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D48321E0AC;
	Thu, 17 Apr 2025 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YbuJoYjY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A2A21C177
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930662; cv=none; b=MEHSLLZE2ughJh/24KMZq1YjK+Ay18pNhqkKQEaa4/cyJCo2dZibZO3RDTVYXSNmNGr2QZCHU6Nv8gFclmzB13BsVh/A40UT/7XKZq4eSGs/dNDoh8M9cW/KrzQX20/mX/Umpp4Ee0QaBqxoIvYFiNn+h27iO1XZ+Pn9pv31jrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930662; c=relaxed/simple;
	bh=8WarnX+QAKJKzKf8pOcx7PZChgvWK0fznn68LAp4XVo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eY8Nw2IaiEXPE1sjO0+kPSZHWKY5LVDpGLKpVGfOXXNXk+F/FD3t/3AOmPE0sRPhkb2vX4PGOcZQZR87tGjt4Ok2V0lYzIxbCU4wPokA+clBP3hOdGR6aSK+XGLPIugBCNNAUBsoM0PK0yu1kFxga3AsMXCmxYSsuberVdQIc+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YbuJoYjY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClY0U012788
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6FrXdXfKn1pkQoWv2x4hW5hrWsqwmyyzobvs3cA0SnE=; b=YbuJoYjYSt49y15e
	L5+P8mjuE4nNYft6SMEMSVIlJWlgEXgFFvc6MYUCNdg+Pb/qRpCTGI5EW1NMnKYn
	ttvPl00UDgVC/OgJKPkesmCHxHXC2GtbNGu5A2aMoe8woPid07l85WWtxeQVCTST
	QkEkp4x4flmRmCcL9kvjCVYds0bpNFpqSGcA6xkq93kzVIc8yWFmDkgskuks6ZWr
	OoJvmgjebFFV+wKE5OMblr4DPRawDDLuCmQpre8J9sKXPmVqKkcvphhgRDBdJc4T
	N2szOFUtgJwl4HTf/X0hqLYggFblwTHJn6N/+oPH+scmfeFPi4HNb92/E+wM7d7x
	8LdwdA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf4vrj09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:39 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-73c205898aaso901569b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 15:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744930659; x=1745535459;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FrXdXfKn1pkQoWv2x4hW5hrWsqwmyyzobvs3cA0SnE=;
        b=J3Hz2o6WdapkgTkkw8GKgJkcUmIaFul0pRcwTE9uTdlz6jYh2sYtEICOkFgDIqY0KK
         RCOGxhn3mrPYfte1UqGuuidb8kp6eF529Dw5nGKNk3z6rF4ozL1Uh3uQVG9KSn+XKiz2
         k7sPBdSx5ECoHTfePhbvwuAhP0FxIoQWwFRLSNjrGowQ+wNGBeqeehtWT6PgL85FNrse
         PsH5qsSeKCCr107TJLvp0/miEOt5JO58jYffyHfSYAWzVvDcqdo8iyxz2MyyGRGfy8FK
         +1mY00Hp+lWrx7kytv+snLsrLpxfJhOozz0h+mx9o3qBGIS0rSGz/LfeivnlBq2dpVmR
         hHcQ==
X-Gm-Message-State: AOJu0YyDcisqKI5V4XA7Y5UGuwx/YcGkpuNcwXatbxvO/u1BShYCb+X4
	WzwwSRmVHoSFuzN4lcyD7ciOoh8E+/0dJkMuzdIUfeguZUYMgGoRT3D64+2l8yjjSkGrfuAU2ht
	8nw4+ymZnDZtx7w16xFwAZGE/KAAGo9I/7B5Zors+VqcazD7CNnLs6Ttmf/Z/T4GxnA3/pIwP4Q
	==
X-Gm-Gg: ASbGnctb19xm/TsokGja3mD5iMmCJmGnE/wmYVACpL4IeJ4ImAMUDoHJb14yk6VM1Jf
	GwEbSaVY6a2MLnZskoHNiJHbzVr5ITI3NJvL+fgqBfqkj+NL7fAU37xUwI5M4b+zl21qPVSPYO2
	7IfEGQz9D1xSN6Xd0EFOw6jzwwp3CBlJYsHA2Vj13B4FhjK7tWRMselms56VWSJSlG7en7RIQ10
	Av+Ys14cxUYohd5vnzyRfYgZMratzf7SZxnnZZ40OtSlX6h1eTquom/s3rTiG31b0iymexs9ZqO
	QddfNPkzlzWhw6VOAz+3ctawiJ9GvnZ8qj5wNCi9LDc8Rto9
X-Received: by 2002:a05:6a00:130d:b0:736:47a5:e268 with SMTP id d2e1a72fcca58-73dc147bc16mr699384b3a.1.1744930658548;
        Thu, 17 Apr 2025 15:57:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/FhH9xI7ejfEn1tmqvo8hWWXE0D8iyWG7md3JQuKWv6BGHRPFOKgaerSLMtuRhFWum7CQ4g==
X-Received: by 2002:a05:6a00:130d:b0:736:47a5:e268 with SMTP id d2e1a72fcca58-73dc147bc16mr699361b3a.1.1744930658071;
        Thu, 17 Apr 2025 15:57:38 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf901187sm426468b3a.76.2025.04.17.15.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 15:57:37 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, P Praneesh <praneesh.p@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250409052647.81955-1-praneesh.p@oss.qualcomm.com>
References: <20250409052647.81955-1-praneesh.p@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Avoid allocating rx_stats when
 ext_rx_stats is disabled
Message-Id: <174493065745.1347382.5634882723747962962.b4-ty@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 15:57:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: 963tFnqeT4DWLFYgJCdG73YQvjtvV5fZ
X-Authority-Analysis: v=2.4 cv=IZ6HWXqa c=1 sm=1 tr=0 ts=68018763 cx=c_pps a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=dYJopINmuo2x9Eb5Rh0A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 963tFnqeT4DWLFYgJCdG73YQvjtvV5fZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=680 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170169


On Wed, 09 Apr 2025 10:56:47 +0530, P Praneesh wrote:
> Currently, driver allocates the struct ath12k_rx_peer_stats for each
> station regardless of whether ext_rx_stats is enabled. This structure
> is populated by the monitor destination ring for both single-user and
> multi-user scenarios when ext_rx_stats is enabled. However, when
> ext_rx_stats is disabled, this allocation is unnecessary and results in
> additional memory consumption.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Avoid allocating rx_stats when ext_rx_stats is disabled
      commit: 25be5d1d1e050f45f4d52b2cf9c8e4b6382075cf

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


