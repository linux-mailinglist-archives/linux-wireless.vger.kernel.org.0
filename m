Return-Path: <linux-wireless+bounces-27754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAAABAE074
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 18:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F9B1701C3
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 16:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA41D1C68F;
	Tue, 30 Sep 2025 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kkkKtKiH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7CA2B9B9
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248925; cv=none; b=kqCR7qIQSEfN6fC6hxUD5ZAuRxIv3imjV6g74xw+nd6oD8rT6Q2TSAclsXcMM0hDcaD+BVK4cvNIVwEzRz4Tb1Qjvj2U/Exzsu3YKv9mQgrfy185gP3JBw7B+7vlafSX8s05JfffZvp5ML/drzm2bI/yxqCIZ8SBlcE5h+2lhQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248925; c=relaxed/simple;
	bh=vFBIkPrPfjP4PwaKGfzB+EOpCkV2nze8o7s86a3G3I8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YZ2oAxEDhrxrnFhb1CEPjhrG37KOnjIfclQ5Frq9D+C05HE/uOV81GuMmMBqbkeNSHXvfeqTjS8rFnG2w3EMd2MmBXfBNDVN1WG14xSwGDMI8PHI7jVW3KUQcLk+h2EdLzOySN6ggdYqa3rgLhzZcMhdm2SSLMfuQd5khPoL8eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kkkKtKiH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UB6iQD019050
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 16:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nUY4YONPgcK6eZeiCt9e1QSImJTa3obP9OtEgCFMl7o=; b=kkkKtKiH1G1UE6Rx
	7SnS+Q9y3zuE0sYNIabIHoPj6yDx4/U1ArIcn3lL+jycxhdOU6/LBjsClc0k4k2B
	MsGWY84iBm2rbSw0Xl/2flCyJ/hMf9YiZP0Dz1xuQOxWyPxnr5YEhLDb0VY22v/t
	ndonNjwzbayFyDZQh1c3f/mKTH7BfSrpJtUntNyJRsy1Z2QYKDSksvjIKFzYUtYR
	m6aWoc0Jtc8bON2hGh9RhdyjpxH7e/gFBeH4dcIGs9pdXfytYPWtTVmTMMVYmvSJ
	dmLNscMtt74luLWS7fHJU6GfuUuaBiywULOmfSO9eX3S0l+P211OQcT1K8jcsuLS
	I56fNw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tsray-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 16:15:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so9658223a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 09:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759248921; x=1759853721;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUY4YONPgcK6eZeiCt9e1QSImJTa3obP9OtEgCFMl7o=;
        b=kyS7+J3PInk2OB3ZAqJ6icD1zo1+rpIvSpl2dtmd6K/NmNIM55JlsqNVZa9ORqwapi
         /ivyojQtapdQKm9cvIZ77jY7I9iCAEq5/mSDGS1Uh7nvP+m6IWHnbY4Ht3pZbpkFQvmt
         r3Y0INFLHgYBAhASeJHHSBl0mYhTvAd2GA0zu+C65JqqP6c5YTe/4HBBT7HrxiK9e7YP
         ZJ7Qkv6sl6Sck447FeSaefmYTu+pW7bVOBEAy5qPKiPxMDvi19o1oyXO8huOPQrZzx0l
         mKo3qSFrDcWsvA4Ok5xOX9QobfkMQEB/xQpBjJIBdxENLVlGsfSF3r/cQA5aEXoxDdXU
         nwoA==
X-Gm-Message-State: AOJu0YzJSUZumAoAJi+Q3zGNsTmqerBBxQ4I1dTDZUqOp0X3C+o0q0ke
	/w3DvdkglrYtFx6qWHvoYgqWKCm8aRJnNVrdk70GHCh7hMlSBzpsZhU7SnujmJWd2DbHOp9wRLb
	r31MroSXsXn96Fg35a/Ve/4qsYa+2XpzGhAdYurg0BDqsAQGDMInw33RhbI65cRbyip3k+w==
X-Gm-Gg: ASbGncvR+fCN576Fmo0p+LSGbioHq4kTaLCsXtMa8o8HpMdQEuPpQcIDWlUs7KJhJ1S
	iSXH3jMAUviFjObh7cPVaiBLLfQT7aI9tft6lBJA+82VZ3Oxx8P5QowiupBNs1iYVXBTZ3KZ5Ra
	1RR42jOJ3xSu93eGzbuM3acJsm5C7EFffwYnGFDKoWnpPiqnlVRPgvfKBE5GFCF+zMCI+QJXCBs
	rHyipisYAZ29N2cQnNUaUFIN/EP+7iM4Zd38D/iNm+ykiyBd5R97l047Ml+aM+PoLJuKweYxNcY
	B5ShGwGo22/yaREONWhQWZZQW3vL403Z8EcMahhjYruP1fYwAj/eRdcuV4zbEw16oCnq7GNxFQw
	OEsk4ng==
X-Received: by 2002:a17:90b:388d:b0:335:5e84:6d37 with SMTP id 98e67ed59e1d1-339a6e90566mr61968a91.6.1759248921071;
        Tue, 30 Sep 2025 09:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA8UYnM12JxvjjDD1gn3e/aoSRjVXLHoJX2SG7jFct1nzIYATY62zI3lilxgdW76ZRPhqHKg==
X-Received: by 2002:a17:90b:388d:b0:335:5e84:6d37 with SMTP id 98e67ed59e1d1-339a6e90566mr61833a91.6.1759248919176;
        Tue, 30 Sep 2025 09:15:19 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be2353dsm20643545a91.21.2025.09.30.09.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 09:15:18 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Ripan Deuri <quic_rdeuri@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250930131005.2884253-1-quic_rdeuri@quicinc.com>
References: <20250930131005.2884253-1-quic_rdeuri@quicinc.com>
Subject: Re: [PATCH ath12k-ng v4 0/6] wifi: ath12k: Modularization of
 objects for Next Generation Driver
Message-Id: <175924891816.2990410.6891956881168623595.b4-ty@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 09:15:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX4WhyMHoNe0r/
 Yefu7TT1mHBWRGJ6rw6p5xKG3u6JN3+yEZcVEmqcq4eS3ppQ8/QQLPSkKTK4JCcQJNAO2A98W9V
 8vZz+wRRx/U2UZXNwbQCoBv3XyW31U+Frem1X/bGQNzLiG8PMtrb4kwVlDtMNu5eviU2KH/X3LO
 zmT0S3wE4WWi0EZ7qrBdPvt/3PRau06YN82VfNBOoSGbIYahlde/XHusUAqHC5gIs9jVYHEEprX
 OCK2kj3coZ1Vj9eGa1HdnEeH1gbBtr4rJyYTNI+4aqlQOYfl1FjZqHIs1a3nwnc9FOQXs2ZQGT8
 /IW6IeKVhd1KSgItq0zelXgm1AiO9b/tWQ5JAY3PC5tTe8BAH1aVtveasv2Hxu94Zq5VzLkYDR9
 sv3IqoB37OV5UWiSN9x0pdtmq0rlUQ==
X-Proofpoint-GUID: wFYOm8jfL7e0tt1WeA6fOgkHYVk3T_50
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68dc021a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=J40jnxQbjyWMeiFgDVIA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: wFYOm8jfL7e0tt1WeA6fOgkHYVk3T_50
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029


On Tue, 30 Sep 2025 18:39:59 +0530, Ripan Deuri wrote:
> The primary purpose of the patches in this series is modularization of
> object structures along with their allocation and initialization APIs.
> 
> Patches in this series are made to achieve the following:
> 1. Modularization of device object to have a separate DP object in order
>    to support chipsets of different hardware architectures
> 2. Refactor hardware group and vif structures to optimize data
>    path operations for future extensions
> 3. Add framework to support architecture specific interrupt handling and
>    ieee80211_ops registration
> 
> [...]

Applied, thanks!

[1/6] wifi: ath12k: Convert ath12k_dp member in ath12k_base to pointer
      commit: 3a52762b539f6eefa6f600ab58577ee09f26657a
[2/6] wifi: ath12k: Support arch-specific DP device allocation
      commit: 614c23e24ee84d5cc2c1648941ee7156b4fb173f
[3/6] wifi: ath12k: Rearrange DP fields in ath12k_hw_group struct
      commit: 8042e30acd1f48aa7d79a9be3b64b04376b0014c
[4/6] wifi: ath12k: Add framework for hardware specific ieee80211_ops registration
      commit: 914c890d3b905165afa17356bcf4e23352411486
[5/6] wifi: ath12k: Add framework for hardware specific DP interrupt handler
      commit: 39538dc8860aa523dde38ab68a333cac4a98d9f2
[6/6] wifi: ath12k: Refactor ath12k_vif structure
      commit: af66c7640cf94aa77314cf8d5e95141bdecbc1ee

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


