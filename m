Return-Path: <linux-wireless+bounces-21464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A508A86ACE
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 06:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BEA9A6AF8
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 04:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ECA18B475;
	Sat, 12 Apr 2025 04:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c5DjmAeF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215B18893C
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744431855; cv=none; b=Sb4wyF8j6SrRksNE5wI0ZY9yXqSKdhFn4IsKGP3lCGCEACUXKx5Wj0qlyNckcunF97enIbBq25kut4Bp3Dy8WdZz++gycAaM6ZpywwXps858v3vrfeXVo4q9wpHBPuy6UqzhPmuZQupijyfneNw8Ei6Ccxadj0LJg18tapNz+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744431855; c=relaxed/simple;
	bh=U8Wp2i5OIuGig3Bhyw3peqAgBcca6US0SQ3+Es07o3A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nGP/FR2NWBNaXzlhQ2s6R0kuT4tPsSXOnc9AYl+rCgZ+X44KYpIJNZ/kynwB8W5gbxmvT19yyp7fUNPvKf22iMQBPnm1QLn1AAyYe4Q5zokr/XzflkvUtFr2G+ceQdGb5TZ8SJmZL+VrZnTtR4o2x+GViD8D7qulsn0x7MEr7PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c5DjmAeF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53C3lXx2019309
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qRll4vgMpvk7I3TeSShcenQajwuJaTA6uths+RbEhTc=; b=c5DjmAeFP/Qu0UO2
	Rss2ba0gM/VYJgDFZ7GHD7w4WgXDrRu2VQyttLwD6qgu3+COlqORG8A3Y9/4FbZS
	a2gFeMqqFw5xVGVpVmd2N9lxs+Wtjz7Xz2hZNwXwcWFDKNsCMqiWz/f6q/8pR/Eo
	R7kE4CX5MUF/fZ1/dA7YuhoqQTBTkMf94qRBPhXn1CFcxgBGtMKGE61i3rd4weEg
	rcVO30uttITL6TTVIWaSfkc59CovzVA3KVJlUiN4crjY4qxHd0WpICgIJc6MA6BA
	i3kD9/V1QfW9zOgBLI5ZS9BT8uwcVV12bn6tQY2+g2M8sHgBrbIen1H8XVFBLEXb
	mVgCEA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtbcd1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3032f4eca83so2317924a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 21:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744431852; x=1745036652;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRll4vgMpvk7I3TeSShcenQajwuJaTA6uths+RbEhTc=;
        b=N+o+GiljTZOy5dvt5O/LoQeWCX/CqYlXdUEvFgEqWnmkYhET2J8wLTPK1vRea2IZeP
         30a6ZO30e/YlwmGdsCbU5pcN5QrctMzXg+URIFOw2vFUG7LtI4Jk4T1ow2fpTOZzglOO
         TtYG3Us6A+2k7WgwXS2TqjIglHs16Vdo84ULLfLyQuLIc2C9jREmJIqUI1qN5XlySKYn
         9Cq3cwhmsxgF8HQI59E1MI6A/cBxr9HXO6JCVbVTm1iFzs3UhubJ/mLXXBv0tq9dW6R7
         Lwesj9oa9GOEn7jBieoOYeVEgM1PcMjpVoCg7aohV2LBPOoYbMkjPwVNB59mjZSzW0jo
         MxIA==
X-Gm-Message-State: AOJu0YwChD/s1I3oD6M6zJoKB9oRIGOPsq21rnKBQkpAo6i0nd02v7oU
	aazApf9A0ffX016cn0okHQTNdQ0HyOfaolV/2pihXH/lpex/6RlfbBujet5ItMhASWMcYFmaa5h
	t3nGzRnkuedgb7Kaw08a9vRC/KmYbHez/FztjHy2f9mZ/bK3tSJo8CV1qcsE+k5j5zA==
X-Gm-Gg: ASbGncu2Mhplm0AQch7+qK3R3wp9rsXKfVWt7Y14+3SBMm478BoaMXM43Z2AJwRVYMi
	m9VB5siZ9cMw8dfNVgqU1oeug0/UzEYXM5jArtbdJOYqoZk32xkGsQIWohmLk2/wWg3gFVdwFoL
	7dacWlLB6hWd26c0XXF/EkhYs1bU+mNXwdmOISZhstRagwZtYoR/2WtH4qtVd0dJoybVtryhlQR
	x85eUwnrmsFY7bjEgJ0kluhvtKbnHctc9HNdRbsl/+j3F7n3QmZ+FIjJQTb6pPHMZxKVe9NuB2b
	JOVC0KkL1cXcUsunnEmO+RWc+rv9oHe0nx/3KCCv76j4+S5+
X-Received: by 2002:a17:90b:5245:b0:2ff:796b:4d05 with SMTP id 98e67ed59e1d1-308236640a9mr8416820a91.11.1744431852288;
        Fri, 11 Apr 2025 21:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlSpSvsTEJSvQ+Eadls5Q0B78jABlWjDlfPnJuqO0/VtCI5W3IC4wRGCBymP8YzkaF5r4WjQ==
X-Received: by 2002:a17:90b:5245:b0:2ff:796b:4d05 with SMTP id 98e67ed59e1d1-308236640a9mr8416780a91.11.1744431851754;
        Fri, 11 Apr 2025 21:24:11 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd11e643sm6829912a91.12.2025.04.11.21.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 21:24:11 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250409152341.944628-1-ramya.gnanasekar@oss.qualcomm.com>
References: <20250409152341.944628-1-ramya.gnanasekar@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix WMI tag for EHT rate in
 peer assoc
Message-Id: <174443185117.2972989.1592486268717091653.b4-ty@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 21:24:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: eCVVQJihKqFFmfL0DEZvYPJR_r2_-8xv
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f9eaed cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: eCVVQJihKqFFmfL0DEZvYPJR_r2_-8xv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120029


On Wed, 09 Apr 2025 20:53:41 +0530, Ramya Gnanasekar wrote:
> Incorrect WMI tag is used for EHT rate update from host to firmware
> while encoding peer assoc WMI.
> 
> Correct the WMI tag used for EHT rate update from WMI_TAG_HE_RATE_SET
> to the proper tag. This ensures firmware does not mistakenly update HE rate during parsing.
> 
> Found during code review. Compile tested only.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix WMI tag for EHT rate in peer assoc
      commit: 1a0e65750b55d2cf5de4a9bf7d6d55718784bdb7

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


