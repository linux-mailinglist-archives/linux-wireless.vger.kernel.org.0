Return-Path: <linux-wireless+bounces-21691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB51A92D71
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 00:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11243B329C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 22:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE18221736;
	Thu, 17 Apr 2025 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O0Tn/v1u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706DE22170F
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930664; cv=none; b=N5jiZJymLf4zOCaV/CMzPP0zzAfJXlTmmSq8K0n3STWhzotjpYtep9Laa/ARRlBPfwixsZ3SSIga8I9P0azR7k9Xwmkja2P5d5uSaXg0fI8e3ADbtaxrOKaxzTRAquBW6wjnX8u4Nl7MgdjSFg9reSjgZ2A1pL7e/qCWnNCNv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930664; c=relaxed/simple;
	bh=2OIM2jKJw3mCwSApKIMON0MCA7J0E/xcp/AUTsgJIWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ITuMb1zGRpMfXbTzWt5dkAAh/aXpG+ZVBRn3ycdrecjFHweiHbn/LnUuEf4j1mcYID/fVnHhUWGznuQjg1WFtwY3k/hxR46/VzT5baONuBu7D7AgIEBQrOLYALxq7HPpMnpBsvNpMAGli4qnH2z0F0kG2tl1CuR/+TNOJRiTuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O0Tn/v1u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClc9L023466
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fBe5yEeGf+UuSjj5OBmJ9qH9KWNCGycPW9ZT9dXwavY=; b=O0Tn/v1ukeWnbqID
	aHLce+/pPhSAjUAQtfmDZeDuGiJDTTUltgRTqUYx5u0gooEFbj95kB52XiLhx2FD
	WLWKdVVFSa9aYAvbQoXnLHzApqSIe8gDcHXt5b67B4ew4e0yGs2k2tLQkhkvx5PU
	mAqfriwIhL6Qrw7eWaE/JTTJvBaoGY5ZuFw60w3mxMNvHC8eZqpIqvNycTfdRYTz
	cYmbtGGMitTA3AZWTdQQZCzdlnW/XOd4Upx2ekLN+N0SWA9uAH6SyCj0kXzIB02U
	IS9DTC4hTpqcaNhjylUyDDvC//WzaKbjLVCBu0K1s/gxSI/YufKNdypgXsPgLzht
	o2PHYg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhbq05th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2240a960f9cso12512015ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 15:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744930661; x=1745535461;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBe5yEeGf+UuSjj5OBmJ9qH9KWNCGycPW9ZT9dXwavY=;
        b=lxpWPOkEYriBCQCT9lTNwnK/FYaZGp5LabF2g3V0znu41/o7qTdyX009lrFJq9E+rX
         tLsktp3iSVOkdAbmuVP9CT7P+1ou5m+WCN6I0VQ7GDtIMUopjOpB9USCiAfAMe2KpvFn
         TES3qXJ/pzp1UxF+jBQpWm+g0nDHcBqzX8MNc0NgWlMxgXTIqXrGfXZw1UPGAVQ2d7lV
         k2nMY7CcmxTgL8kSntv1OtYEmfc4PGBWwmhvo8o5/X8VJ67JZfsUd4KnNpHQYVfkdSR5
         nOgy/1CSpa25R96jm7rg+Fedba2Vb9sjJ07xGTyouP4xv/0q7S35fv1LjNx3YkUTEgmf
         y8jQ==
X-Gm-Message-State: AOJu0Yx+IlCy0QJRY0HrI9GR88PJyKLKSmGty9vjHGACVpSunN/YdAMp
	aliSQTHAGmUQeZi0VrFRbG18IexPt9c+gg7qEL9IWn5iAShimxmiSGchv6KHTWfZFM4OcfY3J9M
	yP2Ihbd+M72SXC/ZEBY7EcRDOix9CgRJz+9ilpkcE/RC1/1J0dTssUe/OFB1zMC/NVdYzroAlIw
	==
X-Gm-Gg: ASbGncvUvEb+Nec0MBPqrtKS976/sQa4eRf+XW572TFRa5oVI/iV/Z3o9846Xh63nck
	p+lb3sA6ZsjcNQXXANK6B+C3LGStylG0l+7C/mhOqd0d+YSNRtfMBnUvVBWRHcILwU4A299k8rg
	s8Sdv4g/khPTekahe5Juk+5lwkWB+ihU1GWYU2brmHppynngvEuQEcaWSghpvzOOVL9RvxMVExm
	vDZGPswCsKVniChlLvM/HsfmfKdXN18kKY/n+k5tAQG3ToFVlNo5JQXmEacdtlV2JWjOTL4CZkN
	tLC2E1gGkai6V2zqiwffNZJjR9m72p5b920OVLxYa4i564FP
X-Received: by 2002:a17:902:ec84:b0:223:47e4:d288 with SMTP id d9443c01a7336-22c5362cf5amr5903985ad.47.1744930661482;
        Thu, 17 Apr 2025 15:57:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvEvmG9Yot8QP2JW0HLw1g6AvEehxxNNjsIE2nxnEb9Xh2JFG5Tuu3+SrVEmcw46Pkw38BHw==
X-Received: by 2002:a17:902:ec84:b0:223:47e4:d288 with SMTP id d9443c01a7336-22c5362cf5amr5903905ad.47.1744930661065;
        Thu, 17 Apr 2025 15:57:41 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf901187sm426468b3a.76.2025.04.17.15.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 15:57:40 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250416021724.2162519-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250416021724.2162519-1-maharaja.kennadyrajan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: fix node corruption in
 ar->arvifs list
Message-Id: <174493066051.1347382.4930327219533874514.b4-ty@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 15:57:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: BYkI2GOeHx8U7dUBsEB_hdeGhYI2WyW1
X-Proofpoint-GUID: BYkI2GOeHx8U7dUBsEB_hdeGhYI2WyW1
X-Authority-Analysis: v=2.4 cv=I+plRMgg c=1 sm=1 tr=0 ts=68018766 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=lD_GjUJNI_ZMVj4dkXcA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=774 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170169


On Wed, 16 Apr 2025 07:47:24 +0530, Maharaja Kennadyrajan wrote:
> In current WLAN recovery code flow, ath12k_core_halt() only reinitializes
> the "arvifs" list head. This will cause the list node immediately following
> the list head to become an invalid list node. Because the prev of that node
> still points to the list head "arvifs", but the next of the list head
> "arvifs" no longer points to that list node.
> 
> When a WLAN recovery occurs during the execution of a vif removal, and it
> happens before the spin_lock_bh(&ar->data_lock) in
> ath12k_mac_vdev_delete(), list_del() will detect the previously mentioned
> situation, thereby triggering a kernel panic.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix node corruption in ar->arvifs list
      commit: 823435bd23108d6f8be89ea2d025c0e2e3769c51

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


