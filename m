Return-Path: <linux-wireless+bounces-25183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C653B00562
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3860D7B5BF1
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 14:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE89273D83;
	Thu, 10 Jul 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GWhUMruB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8270C17B421
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158180; cv=none; b=QYAF/V9wIFv8TBxl8/ecuLBDqX8n+l+DEN3j+iYkUR+qVce6m5p/7Jg5NDg2eH3H4Ldy6ZLmK5x43/i8PqZLxd4kXgeuR4tQ7beq3NEbI3UFOB54bKGzZbA91AGVp9+XAMnxGw/adP/Gy/1ZfKK5GQBp0qXUo/wOXePI//JdNpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158180; c=relaxed/simple;
	bh=QbQgxUyT0CJ1R0cK+Y4rS/dlu7c6+epGj1ajeBAIdbs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qhp4Y9Sg//N2TdAmDfSQvGft2nxitWLC83RMzMEA/Z1jTaU7ds3ej7T7yXvrE3sx1ctcyW9E87kcNK9wAiiy2tFXKkzBABYSlMFC8dzq+odTtBsf/7MWxuAC3CzlHr0FC/swlIhx6cOBVFYmR3VxMi/ydSas2wDlBhvRtXhSwCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GWhUMruB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9RGZP016195
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 14:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nO9/J2g6MEXYXBGRQgoDLyZy3d95jgA0xWAndv6yaRc=; b=GWhUMruBiDabRrcV
	4vNvWAzfTjX1Vod/RSFK/rX+bFIFbMaW8KwC7nvr4pXyydJVP/0zTYs4n3Qz7lV0
	5t8Q4pWOjHCU1X9+lfBYY5hEgA2exH7XQ50tvWk/4NGJP7mr0svYhDFO6ZulfJKK
	wm/qjvyy0+03qCz8qGO2uoQ4F3LAU5QlaKtIUgkdyEQ3BhPIkJK/3HU9uGCR7W7c
	acb8Uzb8HSW1tmJ1liBBRXR65TViTSdxPZRvCRPtuG0MeAgxQNlaibzGkaA2d8YA
	oH0z4VRuj1EgzfwrcrE/m42YltI78V1bPzvoKhk6vVg99BZCr6l2p70NoXwL6FaB
	nrok+Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvefrraa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 14:36:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-234b133b428so8769795ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 07:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752158176; x=1752762976;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nO9/J2g6MEXYXBGRQgoDLyZy3d95jgA0xWAndv6yaRc=;
        b=X5aC7BM8odDyJMSvqfX/Lr+zWHRw3Qcnh+eOC6AZdGuUpV/ZcNpBEAWkvMppfG75ai
         XPhiAIqIuJ8t3CnqmQIrvLJ82Jkd77qR/R4ZfAU8cGraoAKo4FctncSUqin1s6hanQ5i
         Te2uhtG0F/ynpMVvLPehHFp+XRMKWxs4cEW/q4XjKyWbNbkPzIDzYCKUBH93TXVhqiOl
         Q/HGw5kFM7BddTkXN5V2e+CDs9yru8jw5ds52YaVTgJkGw76P4xsl56N4S1da0A5W0Jj
         BUGUqwwQ3pbTjIctGjY7wGnPMkqbjJPpjaZHp4nZLHpppQXbQSHLotbcSr2k6jaYV3/3
         w7LQ==
X-Gm-Message-State: AOJu0Yz0bie+v50+EutZCC13S+Y+puKKD5HDuJWNF1UusKNnev95VV0X
	JJ5zzndO5ugWFuRwHINViZMPfNIi7iSE2wWzj4qzRrIxOC8494R90jSfBvHSFUWW6eBb97dvSza
	WcwpAHvGUu4YCyRplPBcN5+rJQ+52wmr25/5yIE3QwZo8eBO8m0bc6LfSDqzcrMs7ZNYFcg==
X-Gm-Gg: ASbGncu5+Bt7NbOHzkzj/F5yvyIAgBf5HyMQ6IMCME+a0Rf54ed1TzJl2P9kyFXO2I/
	+TZeEHRHMCngXOJqe+fNWHJG7gFgivzB1WLt84cp1w94nikKNJiH7ISz3vHaoZgWM83ikWAb7WL
	SnWfP5JFfHUI4Su9UeXaixiQyfpJZMDGK7bETpSk++swb34d2VTbCz5GrkrCagZlyv3uf7bsO9I
	GwZGojD8scKzlF+Rj3yhOLorTl/UVqO95PEpSBRFoeC2O/eo0ViPaNE8CXoan4Feih3zCQRR6OQ
	TE1KqbWNzM33DQEX+m4m5pQ5vPJUoTr+luKpJR1+WeDCAvPg5KwDu77m2gc=
X-Received: by 2002:a17:903:2f8b:b0:234:a139:1210 with SMTP id d9443c01a7336-23ddb324c2bmr103419315ad.53.1752158176146;
        Thu, 10 Jul 2025 07:36:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1Zokh1fcL5c3QnWz/baL6/aPcJgSi60yGHw9IN+krJB3T51qEgd3aFnlsdF9pQ7bhT65Zxw==
X-Received: by 2002:a17:903:2f8b:b0:234:a139:1210 with SMTP id d9443c01a7336-23ddb324c2bmr103418695ad.53.1752158175401;
        Thu, 10 Jul 2025 07:36:15 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359a86sm23758055ad.210.2025.07.10.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:36:14 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250604101620.2948103-1-karthikeyan.kathirvel@oss.qualcomm.com>
References: <20250604101620.2948103-1-karthikeyan.kathirvel@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: allow beacon protection keys
 to be installed in hardware
Message-Id: <175215817445.507672.4103011704261170558.b4-ty@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 07:36:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEyNiBTYWx0ZWRfXxJqhO5dh45k0
 L5R7Ut8+GDTcU15bAAOp3rXUv/V02pggX5D9klk+ohC4yQZLqPemsrfHW73gZy3wcBWfnaF1yiZ
 +42Ik2PinEFawS/XUcNJXS6JcZOM4KH43OQxsz1cSL8mCPvoO3Q+VUhfUUoy74MCLibT7nDJcGO
 ElYnh6LQnnJkADF/GPpZsVklhyQX+YZMvfaHB4zlmVNod4zLpFtggjAxma2ErDfbIqTmTOUBQDI
 Y+TTvGjrHWswUXllb6T0KFEwyoTaZIoNlSyCAFmY7Y4WHLcKA67LJ749bIJFeOk8YMX7mKzYMmu
 zfmg9VCRid63Cx13VgLhzcVpe3ZJcrb8BA7uHMLWsYe4Rl00FaJNEDj/lBnmISWePL/Ks4Zj23J
 Z6rn3nmJTI93CxuyFUwlICZ8TZ2+FzXFUqOCU00Y2WHhXE5zyes1CI2xvb4TDSgxVjNczTBh
X-Authority-Analysis: v=2.4 cv=dciA3WXe c=1 sm=1 tr=0 ts=686fcfe1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=jPXFS5PPpB_IzyrbQoAA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 5ON2psbPp9-uB81vr7aMccie6pgGLkPc
X-Proofpoint-ORIG-GUID: 5ON2psbPp9-uB81vr7aMccie6pgGLkPc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=955 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100126


On Wed, 04 Jun 2025 15:46:20 +0530, Karthikeyan Kathirvel wrote:
> Install beacon protection keys in hardware for AP modes only if hardware
> supports it, as indicated by the WMI service bit
> WMI_TLV_SERVICE_BEACON_PROTECTION_SUPPORT. Allow keyidx up to 7, since
> beacon protection uses keyidx 6 and 7.
> 
> Control this feature by setting bit 0 of feature_enable_bitmap when sending
> the WMI_BCN_TMPL_CMDID command to firmware.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: allow beacon protection keys to be installed in hardware
      commit: 27ba973caaf85ff3a2a23eca33d6dc9b4fe405e8

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


