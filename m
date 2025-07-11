Return-Path: <linux-wireless+bounces-25274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314DFB01F49
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 16:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696003AFC39
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA231898E9;
	Fri, 11 Jul 2025 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VFdnqTh7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A02A8C1
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244594; cv=none; b=aWB52Hc52ZU/lrosACxnm2Z3JpzTRJjb3+aTknsQbR+l7jy+TJ/OTJ9ORxVPPzgN0XbUs0JmKZvcoS5nG04E/EL7a3rDWpwMwap5ZJGPWqDiS7yLMALm6grRd1hl+C/fyNE4g/eSCNntiJpf6dGDpaQfwCkTsaLvIRkL38pY9kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244594; c=relaxed/simple;
	bh=jc53zF6GfjPcGJRxAZlGbfHpA1Ll8jVRIqbW3lGKILQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GgIDghTIriUQYd9PMfN5E0Use8bESHZlc9ApqO4uDm1vDqnqYZojIQLs/YZduFOjspDp8cPtHOoW9S3p1ELvSzvQHIRtP7d72qOYOV41Ug57q03BwR0dqbrgTF3/yEytjldj5UnV9vPPx2ORt3VggkuXTT7/yTvtVGC4jBzydk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VFdnqTh7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAkHHc031119
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 14:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0yYJm1Xs6KWdBMs0DOSWRCH6qDdlMmJk+yMWDHUJv1E=; b=VFdnqTh7hyXjN0yQ
	L3mwFmn76+rshZV5c0Q4n8+lSzq49Oh0H/cMJv9B1rd0SvGtlxzuCE7YFlQyKLOq
	5q/T+Drd5EqzkPprOKXlS+rSe1wcruYk6CDVGDpf1uPT17T9ZHTndCrafjhq2lVB
	RBk8gWXOX7O51fLKMcM3Tw5/7Vr0Apmo8kbMgGCLBeNx5DBKwStiiLWeihtZwYVx
	AowcK4Q2B+yytfnDf3r9rHDc8owPi0rSsvFMGqs3NxYHRBqMx0h7ZHvWLjAjv39Q
	T/l5qxCm8zvDBv1ur3fUCz7Q+a6pijFYIuexUVl6xqUiaXAjl8BdGDd7md4gp6IZ
	/jTf4w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47u15arkj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 14:36:30 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b34abbcdcf3so1688925a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 07:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752244589; x=1752849389;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yYJm1Xs6KWdBMs0DOSWRCH6qDdlMmJk+yMWDHUJv1E=;
        b=Dv2/ifSbOfjAmdji4PSKU53s6bclRaMgq4POehYvwyNo/TsC7JTReMqxBFUQJmqtSP
         WqBT9ZUhPf8saZ8UB/uCDDBD2x4YyN2kiYag1XEdqDiuKWqhFWBtM5GaT7zWX6fY8AtU
         te3/Y02CPfyQd1hICfMyIp2FJxCzW+WclJwQ3tqdNDhRWQ7qwj7HNfIpNYwwoPcD/hl8
         +FgyflzpUb/dKdgUapRgni/d9E72usciCwJO1w0AtecUOfRctgb/WO3DxDR7gm9uNfMT
         QOWN8ns7E4hH4NZdPtM58b1zMH6rqv1SiauE7PCpcmhtr2mXlPZA8nJ5b6hv2cRqcghl
         RDtQ==
X-Gm-Message-State: AOJu0Yxjckj2BuKIqbJuVynaee4qCHJbwnzxgRhbrsP0hQGGCMJoVxeK
	qWapOEoOtnGQver5G9ks502kNJ86APFMwadnmIYs9B0V7mXUfUJZ/T6j/nvhyAVyFbcMrHVUvrc
	n+P59WLtLeSWOgJInTk2wmbDFEmmump5a9edIzV24+yfAiFPy527GShWMu6jmpG67xWFR/0OA5A
	4yiw==
X-Gm-Gg: ASbGnctu2Ja0PdMUpnLwdvwRO/kLbem4UsPUCAnSLs9Cmda9nakt75FByqQ3M2l6kWl
	BXuOoyNs1l4J9afk7bSgz64GYXCF0s1K9QDwS+J42YmRRJ6R6u4xp2FO4Ap5T1DJJ7WPy9t2gqN
	QciKohvgQcd35uf005wqevO53mVl1e2dj2gQSm3rjX2bil2uZuPEZrqbQ46nqUuRyDOYb1784kr
	EktLO9hGa1NZnRH4TE3qY2ZbSm8xdsi6LRJv3KWm+yhEECh78eYUPUho5TGMgmXiq9eHw6PHMWt
	/PtOFeMiWXGeGpJOFe6H91gLuxQMbF/PLL0lyLt6QQ8uKgE/lKkcEXtRssD2KsvVHLEnq2AaI29
	Z
X-Received: by 2002:a17:903:4b4c:b0:236:7333:f183 with SMTP id d9443c01a7336-23df0832a28mr33198805ad.19.1752244588777;
        Fri, 11 Jul 2025 07:36:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ2IGUji2MbmVaeROoj3x/5OstU+J0FYQfdfbwfgdC1ILup/VJnpyOopuqa8866YtgxtupZw==
X-Received: by 2002:a17:903:4b4c:b0:236:7333:f183 with SMTP id d9443c01a7336-23df0832a28mr33198345ad.19.1752244588286;
        Fri, 11 Jul 2025 07:36:28 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341e90sm48581615ad.177.2025.07.11.07.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 07:36:28 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, tanguy@squaremind.io
In-Reply-To: <20250710011754.559817-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250710011754.559817-1-nithyanantham.paramasivam@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix packets received in WBM
 error ring with REO LUT enabled
Message-Id: <175224458767.3666374.6744524220388570841.b4-ty@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 07:36:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: flv6Kg_MPxy3mIHCYFs-y2aMbYjb63x2
X-Proofpoint-ORIG-GUID: flv6Kg_MPxy3mIHCYFs-y2aMbYjb63x2
X-Authority-Analysis: v=2.4 cv=RtzFLDmK c=1 sm=1 tr=0 ts=6871216e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=p0o8ilPX4fJNFhDpVC0A:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEwNCBTYWx0ZWRfX2f4z1zhkg3S1
 vpZPOCaSGWyF/F1InSfZBVgvo9Wu1SEVORt6i9DenZpge/TBwRH8/EIRzQhCOQGRGjar44sRi/o
 4JYMg9UXs1YSoqHqlS5hpOarNqME/sT9nAMv3PLuzU1kuBmH5ClD8NUhIIILRF1uYp7N/BnNIRP
 0aRkC49jXg/VI5jGD16TVQTRWjPTsJH1lYsQsMm/0mt2F08WlOvn+7klU5T9t9BKNYZEkE9BRPx
 hdCPaXaeGvgF2IftK0ct2O6qgL1qfB3NzFAoLxFiZGY6Jmb+LTgeD5opW/c1hO55M606lDmKgEf
 p5g55LCJUqQPra7HBH8Hi9sTUeQqDqO9bYOdSeH8MNz8DrfU/Zg8PSJR9uyVi+ecwvfxUSRPR1e
 z1A51M8R86RxhlJE4FvVshFhC4QUHOpeyWVX/1iwjvNqlNxROSel+5rUHhm1XDW4wLnKAwkv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=835 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110104


On Thu, 10 Jul 2025 06:47:54 +0530, Nithyanantham Paramasivam wrote:
> Currently, packets are being received into the WBM error ring when
> REO queue lookup is enabled, resulting in degraded RX performance.
> The issue arises because the REO queue LUT TID memory reference is
> set to zero-it's being assigned before the memory is allocated.
> Fix this by assigning the REO queue TID memory reference in the LUT
> immediately after memory allocation to ensure correct packet
> processing.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix packets received in WBM error ring with REO LUT enabled
      commit: afcefc58fdfd687e3a9a9bef0be5846b96f710b7

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


