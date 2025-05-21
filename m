Return-Path: <linux-wireless+bounces-23192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B29FDABE8D9
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 03:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF03A1B674BA
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 01:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4087614EC62;
	Wed, 21 May 2025 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ckI00LhO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898D41465A1
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 01:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747789770; cv=none; b=DxYYH2zGUVxtMsDeomHwGqRuxTCupQTiptJ79hnAszNkMcBk5VhFqvzLF82HOKm0dIQpYWX2V0LxOOO2jX10wNUhdR0jC1N1qNvo0t3qVQXqSCprDB+juK2hv1rBpkvFUiy7848z72zcQFp4Ag5U2FxnPJrkmYZPvWYA0eJ8a3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747789770; c=relaxed/simple;
	bh=zUWMZScYZgnjFEWt4KViJJAB8wGyHYX6Mr08Dvp2Iow=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q0qTSXbN5NH1B16Q7NzQlpTluzI0R4Ien+qXr8w2msjTybum4DOXldFeH0VrwUJHXikiAqf90eBR8GK/owmlhqAQDzOkBa1M1WL0wC2Mvk/3LDZfyUanv6j7Y4K/5WIpWg9zo+0wj0v8xB/joqX6FOr5NLczLd9wuTpBlDdbHTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ckI00LhO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KGe0sB000744
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 01:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uaT6xZyO950kgkaXNXF52TNliKhXmdLc9rkjyu3RYts=; b=ckI00LhOX0cK3dY9
	b4FNeKjWtd9xvm+T7WU1YVh6oDFt3NR0n2WKk3I8p8CboZC2sjmi2Ezv1YfjbKdz
	cNjzObGMj/q4yLZTIcyJg7zBIgK6XSH+sFY9DhadgcP8ZbhKJxLLkF68OVZPHn6C
	RmAfXHgNQniHcR84g6dguuS7Xpzl4LqJ4ZIyO9otdR2ymkgrpdJmg9Q5US9iuJy7
	iY7o/53G6fOzGxafv577iUzLhEqagW50oTVeie1ijoPonAfYusVpOX/b06O7Hewe
	C+aYqx3Yl2sZBHWCQ4YeJ3DGQ8s6ppGb0zWeQVZkF6QRS6hyIJfwKuWGCOalshHc
	xZbcQg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf4s17u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 01:09:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-30e7f19c8cfso6525612a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 18:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747789766; x=1748394566;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaT6xZyO950kgkaXNXF52TNliKhXmdLc9rkjyu3RYts=;
        b=wbwXnPQOOB/y8t6+q5lOR9qT2fidLQjO1RBZCiUVSzCFtay4dcOVMz03POV0shsl8E
         sMrnadWJRh3YzxJG8Rudwy6M+jFwyoc0rDqlQsU8V73bzp6yU9SWk2i2xPV/+BKLJCxq
         thJidERDBJFNnZOq+96YTqsOE0uN4LKDFZUkosWYnRrvnRCfAT6kv9Dw3o0iR6wRGZbs
         x0/MrnZNsUSrjtg/FI9UaYbAcfgZWfH3MDxJ4Oca6BjqeiLuxrJ5Beaf3Pzv7HGSrqs2
         VL92uyGxlGD0Mx65V17Ncg1PeeOFxn/jSy9w7QuvT0q3tXsFD4M0tl7JTt4nbJmKZLlI
         d27A==
X-Gm-Message-State: AOJu0YxDiOR28rXeQKH5ZILEngffYlIKQjBMZHnRt+8hTU4Plq4mhY75
	fsaMg+FqncSk53HH9zfEN9OVXqXLBfw+5VtDeEuMbsb+YyFZBummoopMI8AfmdmnZUa99k0uh63
	2UOMbUnVgbB1qu8yv9reZ2chSEB4Hx2Y12zwSfOwuG10s+MF74JReQNhzRuqY6+VzK0w/5g==
X-Gm-Gg: ASbGncvH/1wiaysLnC4dinpWkyCsdbyIKw3Ce6RWPSL9FPuUG7gRIZIlQzQuY+ruimR
	ek0FXyZny0uc28iPQFiTOIYis0NndEIAH9VG/B0y+/Mwn1xZjW9h1MHeaoM+MEmJ8Q2L83/lwj8
	TJ+BHuD6iG8EW/xeIujYSJl8zgYFMLhmTT617RFeR7+g/Nr461ITHIyXyscpWqgIU8zy/eKfg1w
	hdJSEja5mHCP+ZozkFkC23KFQ3FDCVIfsFDWf4jGRVHZ4mTfLZPIE8fjJr8iiQqzlUwxoklsXaQ
	POaVLqOqFpSRuFUPECYfuQJsEN5qS+S2M65FgcjFeeHN1D6b
X-Received: by 2002:a17:90b:3c8f:b0:309:f407:5ad1 with SMTP id 98e67ed59e1d1-30e7d52048amr31951846a91.14.1747789765876;
        Tue, 20 May 2025 18:09:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaFYN4qvdiell6xoFLx3FyM9ID3J/mSxWme5ysSundkz5Ss1pJh6M1JGbCKY2LzNGlWgsQJg==
X-Received: by 2002:a17:90b:3c8f:b0:309:f407:5ad1 with SMTP id 98e67ed59e1d1-30e7d52048amr31951799a91.14.1747789765458;
        Tue, 20 May 2025 18:09:25 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36368bb0sm2423125a91.10.2025.05.20.18.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 18:09:25 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Rajat Soni <quic_rajson@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250520-fix_freq_range_update-v1-1-e061fd147b87@oss.qualcomm.com>
References: <20250520-fix_freq_range_update-v1-1-e061fd147b87@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: fix mac pdev frequency range
 update
Message-Id: <174778976472.4010925.9446734669090977256.b4-ty@oss.qualcomm.com>
Date: Tue, 20 May 2025 18:09:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: qyIm12hvJ6YFwlx_3DlUvgocc_6oDGDy
X-Proofpoint-ORIG-GUID: qyIm12hvJ6YFwlx_3DlUvgocc_6oDGDy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDAxMCBTYWx0ZWRfXwsLbyNLXe/jy
 eEVqdcFSpCpgBPG2mIL5PtcRSJ8pWFZCWvA4/UCzGZv/aQ85Wme+MoN/YAu7NnVQ3q8f83b2zsK
 nwCRE73DD5UzJ1bGe1NjIRNbhmZghN77KvrqNg3eHkUe8/M2+W9huYyNx2okuXQtO3q07t7CBHY
 LcrB/mMI6pl7KgI9eCNgm1uPD9W4RvBfrInnl5G613e4mOoqJYUeNIfnfP/vQphR2HBdbVRcpuc
 B8rf50UDie4PwilgUXQT2i+KZoVP5F0fcschpMe3dTitmKRBcZbEcZpVcr1cKAhkMNmjt1Ly/+g
 rdoAF9CYS4Jrve9YvCsS3EhWE7aupXGlggcKVmUJlKl3mXkm2/dOqNq1PxG15iQZ4pKDh19hmP7
 NMXBI0KknhqvybGlO47NcpF49iOfylWQG/P47dkPsl5nvF4ROzbQ4DgBMaG+X1MD6xJwLopk
X-Authority-Analysis: v=2.4 cv=R7UDGcRX c=1 sm=1 tr=0 ts=682d27c7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=VeykXRrYc7WjYsKDlBgA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=ZXulRonScM0A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_10,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=883 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210010


On Tue, 20 May 2025 10:06:52 +0530, Aditya Kumar Singh wrote:
> The current implementation of per-pdev frequency range updates assumes that
> each pdev supports only a single band. As a result in ath12k_regd_update(),
> bands are handled using an if-else structure, which limits updates to only
> one of the band per pdev. This assumption does not hold for all chipsets.
> For example, the WCN7850 supports multiple bands within a single pdev.
> 
> Hence to accommodate such cases, update the logic to account for all band
> cases by handling each band in a separate if conditions instead of the
> previous if-else structure.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix mac pdev frequency range update
      commit: 0d777aa2ca77584b339ce195db86fe0ee7dda5d5

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


