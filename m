Return-Path: <linux-wireless+bounces-25490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DD4B06444
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 18:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E818500F51
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF30279347;
	Tue, 15 Jul 2025 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="chQQ3B37"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D656277CBD
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596648; cv=none; b=NZ/TySLuGcjl/Xurl4LW6s5Xnse22fcSD7waWrpv/0Mh+w6EQhVrPd5CNigWOLKm7KslEHiavcUD5+WVwbzqUDtqgsrcMhyyyLiPK+40ceaihI8hG0aLfvMDXuVbXaOP7CUY/ZK7D8Y+deO1dCSDzvLdsPl0+0NYbnCQhwcEXqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596648; c=relaxed/simple;
	bh=4VKCcnfosEU63B5qz88k7GT2UWk+RI72cT33k6+8f7o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZpQSl6NpUsiT7pltpVVb3ZeqsNppHeJcDUVz/YIdiIa6660GoMXBf9ul64Fhyro8NywFJeQp7ZWdRn4kGDBw38X///1TxptJiCS29eBDU+1e5bWXodghQrkTbsHpAcfbREslp4ULQSqJkikILcNXS3xKpH3rDKMOFu3VW+KDswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=chQQ3B37; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDD0H022756
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 16:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x0uOv3IPmfU+7O9dZzGnl8dA25eiSk1URc2ZFMz6+6g=; b=chQQ3B37Kh3aCBhq
	X47SthyUloDWUl1KzC6m0Fnm4vr9JrpaE4BJEpRRGm4u8nZS6dZ+wVdGoNe4F65q
	XvlGtKlVQrxBE5vLn8LM0mbZSz0r/cPjKjTTr55ajSOYWiV9Z4tc+oIRmSO4c9It
	FDSfUrcay8FeMwtKBbzvjnCZ+9V4o2jYRAX9O0tir0cfdEpRssu2wqqcW+3ILikf
	IqV600P0cC8ecCxWsUr1UbJ/UevHgoo30T7lpRwBw8jvl6u7ItfS4mTEG9QEY5LL
	NAH/g9MsgM8Nxv1xMlVeiXxIu8alhxjYFvp8Ml/pSw4WCGkH5NiObCiueAqfqJAH
	kc0Lqg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wkruhjrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 16:24:06 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso8889019b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 09:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752596645; x=1753201445;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0uOv3IPmfU+7O9dZzGnl8dA25eiSk1URc2ZFMz6+6g=;
        b=Sh/AcuSUpCA9aAZuL8tQqfa43kePltmooMbF6ooBJGrPxlsBaxgblRHJI0AyuGrXBy
         t8Ln34Gndi40F5rz+jjf2HRo7IeJMx413n1VJW4tdH9kdfw5Zz612RO1ZDzSSurYyXw6
         FhxcMnO5H5BhVzIXWozANMaCpQU3+n6f3eB0ADxb+cQvttXKmnsm3gs4flQA6oIkdBca
         nPUrJsGz7A7cgyFvKyss1amb4VpoUz4wPE9O7wj4mYxroK0WLYIuAVJrCB2upHiruTwB
         /+WNt4MH9UZpnMXJj47SoSudPIstwcVBWa2zk0Z0DvPBuqHuRRpGN4Z8FcpzChyCbU6l
         /8xw==
X-Gm-Message-State: AOJu0YxeS3TPW2NXDVEGH5npO0V12cK3ayOn1i5AU4uLBaeKl00/GiBg
	cyu0mcJtLUGk2OR02xg2cJOmkogcep+jQaRhuGvxBxX5IFRXreUsxS40qKjyHA/Ngy3BQ5advy3
	oas/em01KFDTOIN9mIs3MBro3o5UpkMxErK9OciWcWUa4FfAzRLqR6QTd0rkwwboDxAKbXwlb5l
	2a4g==
X-Gm-Gg: ASbGncslltGI+NWzWQEhojWTqctoa1g1uX68fC6Jcm1qnYNIM/OKyTyRMFOppjI6HT6
	gKqhfvgTbwBQY1cjB6HwFdJ30eNBKVPgUDRHbSvk31sA9TMDxlGTTSbTNiVBFcfPJG5+zWdhWYA
	KBU1Cr6XwcxZMGky2oLZahKbuOahOi3kuhkIGa8CF5RLSW7BuVWB4HprPJbyltMfsMCk8ceHHdG
	t6PoB8TFRe9iEvn3sqeSGvstASA+o7XH3puHZ2G5EJ+umxqTGCtORqNLTjN1kac9dlX846SgUve
	KP0dnv8LsGbb3WbfYI/8rXr0VrPSz1109F/fsQU7yE1zAP2FyIx9N+sZjUtRXghwtlmQtGRKQxB
	P
X-Received: by 2002:a05:6a21:6da4:b0:21a:da01:e0cf with SMTP id adf61e73a8af0-23137e8e69bmr32380743637.22.1752596645038;
        Tue, 15 Jul 2025 09:24:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1197CjHD6W1MxKFmcbdIwLpLagBGJGF+LUg6mOqLqRXQY54/ZENvNcpJfhoz5D7J2N5TJEQ==
X-Received: by 2002:a05:6a21:6da4:b0:21a:da01:e0cf with SMTP id adf61e73a8af0-23137e8e69bmr32380704637.22.1752596644588;
        Tue, 15 Jul 2025 09:24:04 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b715sm12815373b3a.93.2025.07.15.09.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 09:24:03 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250711035420.1509029-1-aaradhana.sahu@oss.qualcomm.com>
References: <20250711035420.1509029-1-aaradhana.sahu@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Use HTT_TCL_METADATA_VER_V1 in
 FTM mode
Message-Id: <175259664363.3448282.4931008449514429763.b4-ty@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 09:24:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: VO_D_Y-tAi9NOVVRTnSro4gDaYHfVFWa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1MCBTYWx0ZWRfXz2DCsngktthj
 jjvVJyffLCN9NwyQR4eusE0ik7y6R9mtIjHz7wp/aMowlUYFgv4TAI2i7sURfgs3rkUkSLEquzQ
 SFydgUnAqnlr/2D0MsFj7wQnbH5S8dsC+7FqCHOo5q6HCRV50NUIL0lfTjKjSyQB9XOJMYsM6QL
 t/elWVpCKl32gaBJcmeQr0CtCAbTm9y/8T5VB51K1KiCWfB61QdCYS4mJTuW7cJcItqMiDAPJaf
 pHHMk1DQRKtHJwFz+CarIS6IxKeLrps9E8PtGJDx2QuzfODrnoZj2X6DTm3TGf5DI7D2VkdPEeO
 gEfPPqmsFhawxkrSJgF65MfZghXKd7rM4pgSP4/BTZ5mN37tLREa4QkIbt94a24GeFFdjRWQJum
 WEhBBr07Drcg8Ug998+Toxly/FAXSUZfpdL/6lIuYm5BFi1KziFkRrT3rMG9oWCoV90MZf7u
X-Authority-Analysis: v=2.4 cv=WqUrMcfv c=1 sm=1 tr=0 ts=687680a6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=5bc-JWag2cNjQzrUM98A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: VO_D_Y-tAi9NOVVRTnSro4gDaYHfVFWa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=848 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150150


On Fri, 11 Jul 2025 09:24:20 +0530, Aaradhana Sahu wrote:
> Currently host sends HTT_TCL_METADATA_VER_V2 to the firmware
> regardless of the operating mode (Mission or FTM).
> 
> Firmware expects additional software information (like peer ID, vdev
> ID, and link ID) in Tx packets when HTT_TCL_METADATA_VER_V2 is set.
> However, in FTM (Factory Test Mode) mode, no vdev is created on the
> host side (this is expected). As a result, the firmware fails to find
> the expected vdev during packet processing and ends up dropping
> packets.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Use HTT_TCL_METADATA_VER_V1 in FTM mode
      commit: 66b3ebc77d23d6574a965bdbfe41de8aeb7f384e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


