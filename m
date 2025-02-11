Return-Path: <linux-wireless+bounces-18778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 653B1A3100D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 16:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887723A959B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948D7253B4C;
	Tue, 11 Feb 2025 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h96JWBLn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0951D25334D
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288684; cv=none; b=qS/IvtznX1OyrEqg477wsP9c9BX9DiZA19o2U/fnn1S8raYieqVu5JYDUYqOMjSak3tOtEJsmPFrYo6rHojWSGiUXU0YZeiEuthT2n4w2dOUsVA/S8X7d5FJ7q30zZW97UavIcwiFsAXd6H11hXNO6wHybVE+Ly0Cj34uR5pBzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288684; c=relaxed/simple;
	bh=TfmX9vBE/nWv4t0eV+LL5WfqNs5010+z59adPaTio+o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t0uAdVcQ/pufgJBOFW+q+rZqAHW2A+2XSxyE5uGG3Cx9Vx2xHMJINRiz7uyFkNx4Y+1cJeF2e+BKBQxxUP4ojujGn/uP66qAhShA4C7crrbAB9RABQjt7iRzFaleSvIYF31E2CCdTCb88axrpwT5kOPgYJuSQlmm/DsaWSQSbN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h96JWBLn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B71F0u006138
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZHyyLdb/N+h3VnNaZZ6izwJyUd6M8qZ1jcd25f6MXT0=; b=h96JWBLn0wOR12g4
	MpRx6TtzARJVodn5iqzXycjRC9iapIQxZWrpXu2uzg0yxH1snNzuFt89fBN4+Zun
	FlyXdq6GVwfTFbHhlQi/y+NNIR92tPIuG8oRLy9RvLfwDCh1NWaM9OC33xuYNM83
	PjQiOl9bvFyRlq/+UdRBIT147hF/MjBz9YeHk97K0plh5qv3+EujKM9VAg28QFOW
	MppYi49npDXCigQC9S8WmZ8wlcSqK2/Ietl+MYyRMOAC6za3xKWElHkBrm2c7LcH
	xKhi0PPIelouuGxot4B5hwKZrzaVmehuUwlRwfAPdylMbLml/ajkq8g5Duu+GLYd
	1eRPfA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qe5mvkf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21f37eaef03so96509145ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 07:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739288680; x=1739893480;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHyyLdb/N+h3VnNaZZ6izwJyUd6M8qZ1jcd25f6MXT0=;
        b=Xecvqqa9E7bMce6wve/qhamBMU3bjKjgQR+jKvaGgvKpl18RwOycgXqtukbpZGQAtB
         EjxJE6Mg1VtZej8gY5eQ+4BxcQQLUffBbH1/frSHomcPjp7tepHxGsStWWNraJi+wCQR
         +V9f9LlFTT2PxTrcRYgjor+wuJSh4kdX6quIHqRfTM1Lw38KW55edXa2U+7zQ0zPL4RJ
         uaZ4hmOCPoSHQhZy+uwr+hDZF20NuDgsuU4DpaEddTWsQrLgEQ8G5PJK811vHwCvO4Sl
         oMHiFyDhUrX5OHxTmnCzp0rta26aUIG2QoS9CFVG5bRSkY6cjoynO5qhx+BQJGINIgIg
         dt3A==
X-Gm-Message-State: AOJu0YxI9dW8CRtJ3ZgF9jFoQMh/rXMRbiw5zf5kkqwbksiX1ZkcFtUt
	zRCJhuFmbXoW+Wuk1wUJ5q+Lt0lR64QJ2B4HJYBss//zNxizSiITH3+2UGInlcArQkRzKOeVDw8
	xpG09PwXwtQFaDzXaEkT9PK+rJs0oW2hUcjU99P5C7rQtIrC5eEV9J6lA6pqYOqPexStkmF/IGQ
	==
X-Gm-Gg: ASbGncv4BQJVtMfjAF8G2XPBEY26ceyAyurpGOoQi1ebjS5l8BSX5rHlpbzGnzG6i96
	KXbaMIl0aCG+0nzhHQU+wYZu0LeaPqElxHKMEpIIyE64OP27InQTfT/P5f27JTpSNxHA4bjOpaT
	OAurHI8AxxX422QWXraEksuyxGUtZWsP3jAojfCBa9armAmVnC/RWwi5ULs5InmMBQrz7m0ywSO
	+jPGbmf4M11dE5X/LJIMF1e/7J3UeIcBHUljj5wgHvm5nPlgxsPi0mKqeLhAsFtku4zOyjopheo
	4o7CnX6A4FFQ/AHzSwnomVvW6DJHbU5PsAjtfJ8moA==
X-Received: by 2002:a17:902:e802:b0:215:b473:1dc9 with SMTP id d9443c01a7336-21f4e763a2fmr317952575ad.46.1739288680082;
        Tue, 11 Feb 2025 07:44:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjNNJEEkWVLklV9ZcGz/8GNqrUxr2g46yIAz5+svU1/6BMP7z+h+lR+FWrjXqSXOlZT3KLzQ==
X-Received: by 2002:a17:902:e802:b0:215:b473:1dc9 with SMTP id d9443c01a7336-21f4e763a2fmr317952255ad.46.1739288679707;
        Tue, 11 Feb 2025 07:44:39 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36510e34sm98399365ad.28.2025.02.11.07.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 07:44:39 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Aaradhana Sahu <quic_aarasahu@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250207050327.360987-1-quic_aarasahu@quicinc.com>
References: <20250207050327.360987-1-quic_aarasahu@quicinc.com>
Subject: Re: [PATCH 0/3] wifi: ath12k: MLO setup for single split-phy PCI
 device
Message-Id: <173928867882.1115150.740909223944281492.b4-ty@oss.qualcomm.com>
Date: Tue, 11 Feb 2025 07:44:38 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: VRbraMJPrGKCvZ6KJEM_zcuH1a8zvjrI
X-Proofpoint-ORIG-GUID: VRbraMJPrGKCvZ6KJEM_zcuH1a8zvjrI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=611 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502110104


On Fri, 07 Feb 2025 10:33:24 +0530, Aaradhana Sahu wrote:
> The single split-phy PCI device can establish multi-link operation(MLO)
> within its own radios.
> 
> Therefore, enables MLO for single split-phy PCI device.
> 
> Aaradhana Sahu (3):
>   wifi: ath12k: Enable MLO setup ready and teardown commands for single
>     split-phy device
>   wifi: ath12k: Remove dependency on single_chip_mlo_support for
>     mlo_capable flag
>   wifi: ath12k: Enable MLO for single split-phy PCI device
> 
> [...]

Applied, thanks!

[1/3] wifi: ath12k: Enable MLO setup ready and teardown commands for single split-phy device
      commit: 5cec2d86c7f4242fb30a696d8e6fd48109bf3e8f
[2/3] wifi: ath12k: Remove dependency on single_chip_mlo_support for mlo_capable flag
      commit: 16266b7ad6c011f760083851e8caa0d6b657f5e8
[3/3] wifi: ath12k: Enable MLO for single split-phy PCI device
      commit: 4f4bd1f8a5c2f7b1b24ecc553033b210de2a0513

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


