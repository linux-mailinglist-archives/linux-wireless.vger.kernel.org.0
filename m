Return-Path: <linux-wireless+bounces-23160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F677ABC5D3
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 19:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAF17A53C7
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D608F288C19;
	Mon, 19 May 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B3lkiDGP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5485A284B40
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747676890; cv=none; b=omIe0R59/tt3CyjirMPJ8Mdp3+Ln9zJeArjzRF5DiFEy4RFagg4A1iye+K4J9MsMKZsah86hbtTbbpkgRzJuujpggX/szaCLV7CnRp/kvSWV/nnB/uUcuEtInqowvQPx6mVfi8lIIlAVbk61VWLGvJdm0XgBJmSjGWeoMlI5vd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747676890; c=relaxed/simple;
	bh=HUdfbQBbyvutcJYJSK5swz4JeD9qqM2JO+NUoxXdvzo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lpgxQ7IUBTlmG/QGjFejLX7R2z1uDYRqO336R4VNWNFFUzoXp0sPVEH47dWy3MmFkf4G7N13ujDglBBcj3WUjlawiEHa7nlZeIj+nQcyuprotiBSSz71xLDPAewyZ7uCEOFyb0eIO08RHq/jgRQyXwePZRXsjM0IvqXRHE7Lc/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B3lkiDGP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JDXqXA006269
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/e3e2z5AY3dvWJWjj8/0LGComyR7HNo8bLoVcERyAYQ=; b=B3lkiDGP0fJDjXVJ
	c6cgHNR+tCc8PPE2j62lIgp6zef5oychid87alC+9szNo5gxgNG8bnWhxZtQoetA
	h9g3TXKH/FVyt/Yyl+n4o4yNojaPtglpP0yUmv78seNfs21wyfRj1obF/J7Gc+04
	wtbqT9ET3cS0Cs9a3d7U0vgqY48ci1R9ezwkVQs/FCWJNEpK80yDf6CwjBdq/sLl
	tRrMCLIE25rxp0dzTsXpOQlQOTYwm34t1GiqwXeB0TpSFLIqym1Wr4V3mciWzP1m
	Yk4N8Guk7cPSNbII3d4hIld1PudwUt53M58pXPNj9spcV064KUro/BR9bqu15PSM
	VVQ+Yg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46qybkhw72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b26e4fe0c08so2525288a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 10:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747676887; x=1748281687;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/e3e2z5AY3dvWJWjj8/0LGComyR7HNo8bLoVcERyAYQ=;
        b=U5+3R6AsXVvw1x5gJQ9BGs0BZKSaT7UJxCM8Q5/VnEHgQ7lmksMREdkL6asBcY7H02
         Fnf9KVgcwpAHcRGsTum93Bdl7c7VuEzM4ewJHraJVj8y3iYZViTK7dsBS4oeVqNJ7oXw
         CxCO02uYAW/wYd4kMMdJ2yeWQvLPrRGntWu9gZ8pMv1XhBPNz0Q4AsJrnhDjr1yGxrTW
         5imhYPLCHUr/yvgbgIpQaTuMHbHw+mAFGcX6ZJd4/wCWtlAE6JU2CojsJ9/RPrOj+eTJ
         lJqsTxmYCE1W/FIh6A6OlAxfAI5touqiB9FB6ldpcbFN8IkuWOB012TfLnGdKU8dw4wX
         vPIg==
X-Gm-Message-State: AOJu0Yx7OXvDXMWjnQNz+QHuqcWb11osVDMmGvIMDQ05/H+ZaZ6r8h4b
	rPiwzTVJK+M2qeT7SpuxAKX1nd69JQu///HAUnj7EnGjaxZzdF6J0J36XetLE8RD7pA+Ze5bfUq
	er+dIJPsinzRJFdVxUdi+DXYlWUKyxgDJSFdHbNUBM7MqMRvSKAFlaeMizy33HX7HxDjukw==
X-Gm-Gg: ASbGncsULVoLQhQCpcT/QxA/j+g5/Njl8hscN2TJWO0rSKHc5D0YyFj3PhsFTfZyDrO
	G55gUXM2pxmiZt6LiEMITT/KxoAUKBulEprj6mXSCyD5lsEmIomiqM8du7VEJVqnNZyuwIhzlMN
	YVPFqkbags8s+pDIMpjQ0iPH5ASU6qZZ8cV6aNKRtc70kDOjnaeNRDNSlGWQSxsPApvfXYosgUx
	CHxzAkDOV61iYAsyaleRycTp1WM0c1gYOVNedZjLvpn6oFg6DfrvkBeuttYUSH9DrAk1DOBvf2q
	EsTvzpqhE15dZGy09uoYPgLR+Ktxg75rKai0ZtQw1HWwPJWy
X-Received: by 2002:a17:903:4b4b:b0:223:5e6a:57ab with SMTP id d9443c01a7336-231d45327d9mr198728845ad.39.1747676887600;
        Mon, 19 May 2025 10:48:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE7jAEDksz+o1nGDCYSWrXDzdLHDiReaAc6YlapevPWDBvK5hsB2mFgnITsqQrP0IAnnVcpQ==
X-Received: by 2002:a17:903:4b4b:b0:223:5e6a:57ab with SMTP id d9443c01a7336-231d45327d9mr198728555ad.39.1747676887243;
        Mon, 19 May 2025 10:48:07 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4afe8b0sm62651425ad.89.2025.05.19.10.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:48:06 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Yingying Tang <quic_yintang@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250423055650.16230-1-quic_yintang@quicinc.com>
References: <20250423055650.16230-1-quic_yintang@quicinc.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Fix asymmetry between
 ath12k_core_init() and ath12k_core_deinit()
Message-Id: <174767688667.2567051.15535558244008333035.b4-ty@oss.qualcomm.com>
Date: Mon, 19 May 2025 10:48:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: -sIgRgsBBKs4TIr89CvQ1F0vflGsRCnc
X-Proofpoint-ORIG-GUID: -sIgRgsBBKs4TIr89CvQ1F0vflGsRCnc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE2NSBTYWx0ZWRfX9oPNtf4WaBAm
 NiZ3yN7MmSFaRbZsWMX6/qeiMUvqSWEc8H1PdtiO1I50NdZvgr7BmZjh9r545p7fLFAPLtw+bpJ
 Po3PYepkDCDtO4lqGrFKAt7Rq1WkDucCwLfWKcGMMYipf09KAAdZfQ92Od/kQeziyq1r2YU33Z+
 GDj6MGzr3RyuXKgJaUXX9Fu/zw0Ix6ijILKynUo9fZdAACo/Gu8PPnAuhNKS7+AIAO1ExTZ2XFS
 gyTPwW3hiFjRBibyb6viblJxb2hKFeSeDKPIsJonX1tS8OnIFTlvE+5cL4EGFHy5T5N4DEdKQxu
 AzmcvwF+1HuIW+ApvRck+P7ISWkLYpLpuKauh9VaIPxaw3mnDOMDSHUw80tMerTGF/sp18bAgcD
 SLFO4wLahWPqWK1uUYOtYGTBlNxz/crBQ+JC+awzc3Vj0/HyLpGBD6KMgOvt0AnuBalw2YKe
X-Authority-Analysis: v=2.4 cv=RZeQC0tv c=1 sm=1 tr=0 ts=682b6ed8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=HYYPFgkb9UnnZKMoj5YA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=425 malwarescore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190165


On Wed, 23 Apr 2025 11:26:48 +0530, Yingying Tang wrote:
> There is asymmetry between ath12k_core_init and() ath12k_core_deinit().
> It will cause page fault in some case. Reorder and relocate the release of
> resources in ath12k_core_deinit() to avoid this asymmetry issue.
> 
> Yingying Tang (2):
>   wifi: ath12k: Reorder and relocate the release of resources in
>     ath12k_core_deinit()
>   wifi: ath12k: Adjust the process of resource release for ahb bus
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Reorder and relocate the release of resources in ath12k_core_deinit()
      commit: aabd3be90579ed088aa34f0584ab6836c735c76f
[2/2] wifi: ath12k: Adjust the process of resource release for ahb bus
      commit: 167e6fc7a4471db2c88bb8da32ac444734a41cea

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


