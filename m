Return-Path: <linux-wireless+bounces-19377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BA7A4273C
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 17:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98363164EC0
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F3B261561;
	Mon, 24 Feb 2025 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mYhjsrvx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661CC25B66A
	for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413034; cv=none; b=ABxAwjq54GhRBFBs4sADRx9cNuI4z92n3w2rdxSn1iKqGXnpaJI5Q9oYCCM1saT5IG9GCgs+eTK4VgtE+vfc0Nrf9n/HVUrGzUsA7yowsGUuRg/QMeyXP6OLpqrshbfKiVOpHp/GlU6NnghR2Mc/4OzJPliWQGGXH1nndAK5w6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413034; c=relaxed/simple;
	bh=ENgRVTZmEOr1DVHn94gfxDc0b7DjztY1OQKD/CTX0CI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mifJZVr140rX6U7vo/VOKPiQlvcye2nhuElTUmZKwF4XzGKgRxR+FZmisOo31Lt2hklxm3Je9hjK6QBWWJjA6QL+SOL7JYKWKzfdddKmt+14bYOYnyCv4Zs1WZfpSrFRaSsxiHKxxR+xTYoyP0KNmsQZBiEfc/tdtXQ+KDvXfmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mYhjsrvx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OE0xrY024625
	for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 16:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KihX8fWcq5dMXnYeD5x2k3Y6zz16EVIuv0fXLuyFB0A=; b=mYhjsrvx5HCPARus
	nU4McE4ETAtX0SJ+p3+xZ+J1CUUb6YCNBR8/wtsKZIXPtbq/CVWLMXr9pPDvSm2L
	FaHBO5pjjb9EBdOxYV/kpdm4lcm0618VDfFqVtegh3fVhtLgJ+oFpMDVD8k9of0r
	Rk6yEa1BP7/rGWLFmHHUR8CgEdjxWMIoAQpOObaI4K3seFzjkMl1JmuYy0trDAmn
	qtdcgjICJ4Khb34w6tvBabncPV7O+oioBwZZqmHhOeK4f8PwHGDnwQraap/9XuwW
	e833FqwEsUJSXtoS+NndNRisONqBkFppDVxkcECQfWlNXdZqSG5YpKYKJJyTEvfS
	+p2Qeg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 450m3d9sfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 16:03:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220c86b3ef3so112611635ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 08:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740413030; x=1741017830;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KihX8fWcq5dMXnYeD5x2k3Y6zz16EVIuv0fXLuyFB0A=;
        b=Vmi9lsOMSm4KlM6xG9RI57jGW691G0zMEGn+hs9do+tAJktuckt+gAhu4LwcYyXAYX
         Z7mVB7jwQdDznK5qTHme782VA/PAxJxd3a1kTLURnBAvN93oTyxMXsJiCe2vblZmmKsO
         7VNUTL4SVIvF2eVPMemlMli+Nvh7yJL5CVaXRP7JyZs7v9mW4nDhJQRSAB2P/bfI4d6m
         EO5Gs1TqYCwF1AEYu2wGBbi/xhJP9vvOoHOAL2XuefDCIw8PXfRMubToS2OD3xeeL0Bl
         UUB0c+CDw6/1FBKyo7KQ+w5nvu3K5W9JlwbCK9p1zq2yW1YNBvGNHxADWqbmY6UKPEKx
         /bbQ==
X-Gm-Message-State: AOJu0YxGfFWVVmBhIKVLqoZE2MOu0gmB6ePP25dLihQqbqUy9gWGF2O+
	DDKlROKiWiU2plUh55lsnLzLBy2NXY725KBbeWto1by+oj3+uOlj7kyGpAr+A9iTg7Cf8GZ0nfz
	6mDjP5j4vLWnIc3IAPGsGyWijPDUYGHf9rMFinSm6fvdqhpzyCvXz95OIRw0DZTnewg==
X-Gm-Gg: ASbGnct5yxhFUpUyUUweiXZ28c1kXYf5Qzb3qSgW+xvmyvpRFF4xVtBD0FP4s7YcDV2
	JBgJ6Ncv+JYs2xGmZqpzvpgcBqRq5NYSrk1KNBVF+8NQ/VKgQB6DArsqG4R/h1IlWur4tyX3iL/
	NCqoo+4XxSvY7sHT/r+JcyQH9l+8U3NLuNA1mfXqNcqrRdMBbOpMRyJgYTQC/Y+A9alI/ukI5Bb
	2Qsei3VHjxwhuToFZjrVSXr8icb94t0nLl+E8d+9ie8/w2/pypMV1jj25HJe6OS/YJHI78SnrBX
	9w25z2mJBGdxN9VMuD1QEieKrDZgym5KDiRf6kKBYqy5BkjfjUFU
X-Received: by 2002:a05:6a00:228b:b0:726:a820:921d with SMTP id d2e1a72fcca58-73425cecdfdmr26648080b3a.10.1740413030476;
        Mon, 24 Feb 2025 08:03:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAQcuYU29yB2OA7EOTXyr62KvF4Bwf4grfQff9Ffr4ql6Y66zQ/N2fX5qaEmA175P/28JFdA==
X-Received: by 2002:a05:6a00:228b:b0:726:a820:921d with SMTP id d2e1a72fcca58-73425cecdfdmr26648038b3a.10.1740413030080;
        Mon, 24 Feb 2025 08:03:50 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7328371e36esm14470744b3a.61.2025.02.24.08.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 08:03:49 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250221041250.769491-1-quic_rdevanat@quicinc.com>
References: <20250221041250.769491-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: Add NULL check to validate tpc_stats
Message-Id: <174041302955.2901106.8080221910773071155.b4-ty@oss.qualcomm.com>
Date: Mon, 24 Feb 2025 08:03:49 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: rwHhjwpjnC_upHQQz9feU6DQOzExMSOk
X-Proofpoint-ORIG-GUID: rwHhjwpjnC_upHQQz9feU6DQOzExMSOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_08,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=870
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240112


On Fri, 21 Feb 2025 09:42:50 +0530, Roopni Devanathan wrote:
> While processing TPC stats received from firmware, there are chances that
> the tpc_stats might not be filled and the data is not available. This can
> happen under two scenarios. First, when firmware sends a non-zero event
> count before event count 0. When this happens, tpc_stats will be checked
> for data before memory allocation and the tpc_stats will be unavailable.
> Second, when memory allocation failed when event count received is 0 and
> the firmware still sends a non-zero event. When this happens, memory will
> not be allocated for tpc_stats though event count is 0, so when non-zero
> event count is received, tpc_stats will be empty. There are checks to
> validate if tpc_stats variable is filled that are used in two subsequent
> places, but these are placed after tpc_stats is dereference without
> checking if it is NULL or has valid data.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Add NULL check to validate tpc_stats
      commit: e180a01bf2c4a67db13d70d2d91410a8c6f74be3

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


