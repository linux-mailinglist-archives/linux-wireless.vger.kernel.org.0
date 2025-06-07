Return-Path: <linux-wireless+bounces-23819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0D5AD0DFC
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 16:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4671890B18
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24491B040B;
	Sat,  7 Jun 2025 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VJrUmaie"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F11C1F05
	for <linux-wireless@vger.kernel.org>; Sat,  7 Jun 2025 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749307442; cv=none; b=GDXtqj4+iZvpAOLBSPJL5Q0cXxPv6zSR0nrmzmDeRzHXD7AMWLeueenRIvMChlMxmobW5G50mAoFMLcZzfGfOmeA8W81E6vioF+RuP2CI4I3YFed2PHatejGK21gmtF/orggBasDIHXK4/zg23h8K7AWgPagFmFOQ3+tgla8SWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749307442; c=relaxed/simple;
	bh=fYLwTg8MsTD0Tp8ChYcrewS5p6Sd8cd2QewOug2E/Fc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HiV0oatbZDi0FgXYYb4nj6CLSLNuV7wfD7KUJXngb9djqVM2a/LN2SdgNtP3HFmHogXZM0t6vo9QJAdptVy+nJYnni6Y4xwBFeTdC0Bx342LMJ8QfNy9wMl63Rw8Bxmf/balXNB4odcp9zpIDaL4X6tclmn18WCQo9QZuFLaBTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VJrUmaie; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55743t6d018292
	for <linux-wireless@vger.kernel.org>; Sat, 7 Jun 2025 14:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kIznSFFa/P4iZ1LmmERUAZJS7v+GKDZ+faVfPh56hlg=; b=VJrUmaieKFYW6vGr
	6p0oRKIkQpEkZTRL5e8VMMYuVh/pTQypCsaC9fIB8Dr4wV8jn4O9jEyYxwKRbgiI
	nOZVoCI6iN/WBc8TkdwHzu2uAhIpwSgpJtxgnpntlD+IES9f4trtxRdLqvIdxYjW
	CObBe9yXFaoP2EIuKXLtKBd7jpjfpYFi4mkKAPXLkGgJ/cIGso7upsmNyh08U4dw
	KwgM337cchFn5irtMK1A1WaVZH5k7YB95WcAXrXnW+wx8XVLkHdTm4kk8lf7pW+j
	N3PxbDA3Hx7JEtVz/2z/4Byo/lR+245vT2+gJzlGaPejPsWaHSKVDzxx3Uy68Kip
	xrUnbQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474asrgwgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 07 Jun 2025 14:43:58 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b115fb801bcso3401368a12.3
        for <linux-wireless@vger.kernel.org>; Sat, 07 Jun 2025 07:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749307438; x=1749912238;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIznSFFa/P4iZ1LmmERUAZJS7v+GKDZ+faVfPh56hlg=;
        b=SUWTRanemrukjz+i+YZ3zD/YgfbtlUBHALjSyK+iaNpLlyS2vmlwtJIuFHHbG7jBzJ
         9HUIXDickY9uRo3lndAodaPHmdKT3Yub3Rx3TrcZnlhTwMKPJ9ZgGinCRyj+xoIimaEn
         NhoAA2GkiKEWJZmBFjpj06oBN91i7vYoc68TCoStdOFsAramIMRY7O8FejyskrCjrJDL
         ASCxMldEcJ/PfwrboHJcRpyU41MpRTrqn8JnmS2/AELmPP994Flx7WX7FUmaAvqWOHXB
         TeyhewtzkZBJZujqsCoyq6adiVLN2jtSF2mNeoSrBK/48FYdALWEmoD7oYowXTq0hd2P
         fGhw==
X-Gm-Message-State: AOJu0YxZAMEFWkd/bnMq5HnSxQxcBHWQhMqhIZ2et/Rb1JVxu9vT+t6i
	JqpfAXet+cq1cL/fH7PGM9y3QCki8cYnpdUTiyC3NNTl+cADePrYgHrD3nnKfi0lnJIR2y4ZT74
	2zqlogscWIGpvSbYPMJo566rioTK1RUGnbTxuZUSDq8Vq4R6TmXOJ4w7HDvtHVuVyu5Az+w==
X-Gm-Gg: ASbGnct/JeWDp9dy7TVaMNywpZ446mWzp7164k3ttLcS3BqCVABN97tGXRlITdn1XXR
	xla40usClb+kvA1aH4jXXElbEymHbEaAeRuiRlm2SZAa0AmVo0F0YhGaertZLaeGy/qc0O6htCT
	HGUYKpRGxeQRFZA/iENki1K/7ayrcZUgEBktN/1r9UxI2Iv/Vp/SXzHH3gIH26MZMnSmS5RVHYk
	69SdFqh79f5naV/A3nuBh1Jo3CeFbKj+OeuFKiX+c9oVgijyxhjohtA78lhP/YtQhE2Ue4Z2HEt
	o6atYPrLFaATwcXcflW2KU0U5g8i2NOOZMlPMdYLL3gLZ8Vd
X-Received: by 2002:a17:903:32c6:b0:234:8c3d:2912 with SMTP id d9443c01a7336-23601cf0adamr113731345ad.11.1749307437676;
        Sat, 07 Jun 2025 07:43:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrXtxzVdbJJ4WGnCJvbQe9rygqOb+uLB0Wg7iPjmNdoPIj8yeTrfEk17IDYHLY6gvLP4vMlA==
X-Received: by 2002:a17:903:32c6:b0:234:8c3d:2912 with SMTP id d9443c01a7336-23601cf0adamr113731135ad.11.1749307437304;
        Sat, 07 Jun 2025 07:43:57 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030969ebsm27626415ad.72.2025.06.07.07.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 07:43:56 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
In-Reply-To: <20250522131704.612206-1-loic.poulain@oss.qualcomm.com>
References: <20250522131704.612206-1-loic.poulain@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath10k: Avoid vdev delete timeout when
 firmware is already down
Message-Id: <174930743660.154748.6559672422960537797.b4-ty@oss.qualcomm.com>
Date: Sat, 07 Jun 2025 07:43:56 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: IEJ69moKV9wqJRuNVAa0sV8pd8Uax8kT
X-Proofpoint-GUID: IEJ69moKV9wqJRuNVAa0sV8pd8Uax8kT
X-Authority-Analysis: v=2.4 cv=AMUSjw+a c=1 sm=1 tr=0 ts=6844502e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=7I3S1EzipQkWTEvUIxgA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDEwNiBTYWx0ZWRfX1Pl2i6+NzkBx
 s8T0G1kMj0JqH3YgTSLOWGoK5II9MGfunuJHicLksQt8SB1qnOC2os/uZEiTdM/Xx1sn9UhlZIR
 2Xdf4tI68cR17+JvFUO4V0p5Vp3cRfVRy5BJIt7VwL7dkLp8UVQLo4OJD/yqrYy861Clq7c47VZ
 T3A/a7BqhqWJItPdBaRhBFwsFdc/GxMUwQTuWDX4Km2U1NUXNYw9HQp4nhEzlM5ge4S7DgP4DYO
 mejHwrhQxI+RUsVZ2Mj8dHwoOL1NXLkBtPd2hVWGD6G1dtP/YOOkDPgYmDiaUWhe6N/RuUXw583
 G3ry7mIyQyqnH2UoQmn9XyhibJWQ6flGp3i0MNNwSZXxnT9iVjvlhMOiHHPg/GKOpMlyOAG0tdq
 Do4OiTq9KOy1SopL0crm3XaU9gSc8vGCBDKTnUaw0KCgLFOsr+qlh0rtQplTv5GttfoYmQmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=779 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506070106


On Thu, 22 May 2025 15:17:04 +0200, Loic Poulain wrote:
> In some scenarios, the firmware may be stopped before the interface is
> removed, either due to a crash or because the remoteproc (e.g., MPSS)
> is shut down early during system reboot or shutdown.
> 
> This leads to a delay during interface teardown, as the driver waits for
> a vdev delete response that never arrives, eventually timing out.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: Avoid vdev delete timeout when firmware is already down
      commit: dc9c4252fe0d7a7f1ee904405ea91534277305bf

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


