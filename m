Return-Path: <linux-wireless+bounces-17971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2711A1CD79
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 19:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055411883458
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 18:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A6917BEC6;
	Sun, 26 Jan 2025 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nS9lXP/d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3616EB42
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737917105; cv=none; b=akNC7UWOslt9O/+0xAxKibQWk4/MfiCwZe8VQFNgrx1GHzX7D1j86zhLAEf+KX1Wo/Yh9TDHXazbZYH2V0RH47Zz1YWYmVGdXDHz7LPwwksRYt/aGK3V4mOrMIJqF8i9RlJIAootEzORFbPLJT/8io/8jged/XjnKac3CyFsxwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737917105; c=relaxed/simple;
	bh=zz3xS+43zOTRrOffRrxNuilzIRpHDRXi335WHuZCFgg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CHovomIiIjgUQG9GBbXBwfsQ4dOmwCxFYDTizc8dnBsov/gyt5dAg/1trm6YG2nrDNZVV7fMloYG57TP+CIX52qG9t2TJUmgu7xOW8mMIp2RxCY2pT3kwSrqIowQOYBBvXK/23wsBTx2ga+pncWt4/zGW1Zlloep/Fm6+FC8nyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nS9lXP/d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50QHeM31025426
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WIMAOucDnoD6b7e/gEVK/KtBPqhW1iRWKSqKeR63TcM=; b=nS9lXP/dMLlV84Yb
	4TuxMPiePRfnwjTJJ3a/CDCsaBTaLnAz6JgDHU+ZCZ7MxLkG7AYOWY1gnwnJDXs8
	JpqU3P+ZRpbSpWRsxolneGkerQvpIXGlcQYdOy9YAUUyQuK956n8eFxl8TMKT/jm
	jcWi/XuWHlfDgT6ZqCqD9ZJYkaHrCmYCH5EaHQcXV7JxX/CgIjGD41U8GgmSCM/Z
	OnrhKybFYuEVIyCi9vpNWniBt4KG/h6rR6TRk3tYLRFZAcHxFsqcuLIv/nBBvaTx
	FsU1/TnTG3waQVZsCI0j+yfb2WYabhFSx8u2pE9mH14NgvdubivtDcsSGswiInFn
	mjLzgQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cs2hj5cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef8c7ef51dso7287932a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 10:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737917101; x=1738521901;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIMAOucDnoD6b7e/gEVK/KtBPqhW1iRWKSqKeR63TcM=;
        b=Xf+wBet4vdJL4fxewoGrC8DNZARk7HtpuoKQ/ufiDsm7OhS05FXEtYV3H3ETqA74fo
         Ln2BEemHZb4MaIWPcVFeAKzk5cunl11FVIMUIJJArJ+OUVdLKJ0cCYqacJ8RM+69RDjE
         dklyoNmASTxZ69Blps0z3K5hX6Hl4jzatvc/GaStrlSaKc3Vho39q2ADE5OZGdgpzm/S
         iy82wonh/I6S7TNyeTLjfU4/zwuCx7VBB5XyHE4ccafBPTCQKPsAfrFWQgVTCKfQoWVi
         4LdKN2Ai6kPRJlp7CoakU10c51p4KpZrOhhj0HQRtIe5xk4v1F7Qp4aKsgOg6TxU3Lct
         JBOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV1FQS4C6LzJN28uGox62f1Vl7NgYez6A3PAQ/MymkEN+2Us1nNItAhPTl57DUGN3pvAQPvzQbCrx7Fu6w4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXrxLCq4/Eqh4uoioE2xTjI/5I3dpi2brKyfL4AJ17rQ7iLoMY
	5jpo5GjQPzuOhZ6zqd4u0UDnhJ4M0Kh4mNaOsTyto/tX1oJbm3fX/dkX/eNzbWLd9TUZcJNIZck
	fvX2vmyVXdSjcZzL1R3aluTqjgLHq2f0+OLyaLWOy9NoDOe9Ugq0kCs8QFErkeLDmSbEkX6ORRw
	==
X-Gm-Gg: ASbGncvAJUDWM3F4Pe6MRlnr9A8wD31tGzqU2yQ6NXeKzEFMswqh7SCVPsrMFpTD/Ef
	usBtDc4Acz+s+8ki9ZNmMthMTAKy1lZ6QIdAn6hiT/PzPHPBj9j2pK2RggdZrZy4563gqeJyqH2
	6uW1qpH2BVpUfPbpU3yPf+f98JqDVpve+EMB3WV7g5aT+uTIewLZgfTXKxKnZ/EBcVEQnkYj3KC
	ua+dtkQkd8k8f1Fs95GBnPwC8SPBMGoSGDj0D/NmS7ml9MjfoFHjYIG0+lkzdogOQEAxOaDTYp0
	7EFJOyE1xzKebw+mS++X07rpN6T/xJBs2vU6spEutw==
X-Received: by 2002:a17:90b:234d:b0:2ee:7504:bb3d with SMTP id 98e67ed59e1d1-2f7f15dfba9mr24210908a91.0.1737917101183;
        Sun, 26 Jan 2025 10:45:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG26oKJjuEA21yrG/PkVI7/SoF6CjcurwEG2SoTEXHxrB1yqeM6UeMNbOvXp+g5ZqT/kJ8Ozw==
X-Received: by 2002:a17:90b:234d:b0:2ee:7504:bb3d with SMTP id 98e67ed59e1d1-2f7f15dfba9mr24210874a91.0.1737917100811;
        Sun, 26 Jan 2025 10:45:00 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa44cb8sm5414795a91.6.2025.01.26.10.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 10:45:00 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: kvalo@kernel.org, quic_jjohnson@quicinc.com,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
In-Reply-To: <20250123084948.1124357-1-quic_miaoqing@quicinc.com>
References: <20250123084948.1124357-1-quic_miaoqing@quicinc.com>
Subject: Re: [PATCH v2] wifi: ath11k: fix memory leak in
 ath11k_xxx_remove()
Message-Id: <173791710012.2935553.8848464110597031122.b4-ty@oss.qualcomm.com>
Date: Sun, 26 Jan 2025 10:45:00 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: Ru3OT4Q92E1HOIlABuFR_yQKbZcWvV6-
X-Proofpoint-GUID: Ru3OT4Q92E1HOIlABuFR_yQKbZcWvV6-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=683 lowpriorityscore=0 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501260152


On Thu, 23 Jan 2025 16:49:48 +0800, Miaoqing Pan wrote:
> The firmware memory was allocated in ath11k_pci_probe() or
> ath11k_ahb_probe(), but not freed in ath11k_xxx_remove() in case
> ATH11K_FLAG_QMI_FAIL bit is set. So call ath11k_fw_destroy() to
> free the memory.
> 
> Found while fixing the same problem in ath12k:
> https://lore.kernel.org/linux-wireless/20240314012746.2729101-1-quic_miaoqing@quicinc.com
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: fix memory leak in ath11k_xxx_remove()
      commit: efb24b1f0d29537714dd3cc46fb335ac27855251

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


