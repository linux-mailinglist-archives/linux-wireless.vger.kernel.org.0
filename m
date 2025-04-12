Return-Path: <linux-wireless+bounces-21468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AB8A86ACD
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 06:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2494C1B8444D
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 04:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A062419992E;
	Sat, 12 Apr 2025 04:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HVOt5lCI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED675194A73
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744431860; cv=none; b=R5agOTgUfuO9ZyeTTozVEHTDs1xua3FaEO0ofWfWgJACF7v0u8H6WZkCezx6RPJwZrgdA+yT9lTrWkXOw4p2S5WZAMDMhj3V0FBUhH0qZq+QlS0ymhm/A5r+kykffl5wR9TIkKdCeKvTxXGMfT1xEOcNoJy2rQJgbUfIJmG/IVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744431860; c=relaxed/simple;
	bh=0MuirxOmbzHVRcW3wnxSEvjb9ckKJJ1wHa+aKwlrQR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fmNEDDDxgqIBxgPj+k8j2OU/KK2MFYdfmroce2WZe6uqDp3cwwb/pYgW0n87roI+Hoe+Qto24jWIxdg7lD/UaOrJgytNsJYV36Q9X2QSs0LOWrMZtsYrAaEIvLMOZs+t7i7my2cqLhqmTcpU27HYEAVYWZ0S+SIQirpNxm8+AtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HVOt5lCI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53C3jvLW022895
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eA63O+SGzPuj7ME2Ygbyh5CntFBF3jcXZzfIUfC/zHQ=; b=HVOt5lCI6tlgeu8f
	MRsU+yQALLqwN1r5h05juR+hycYsNxYm3XuvsNFS4+7R9I6moG/4p2MzGD1xz3t4
	A5RxDDsr8/Ay7W8uI0p4H7j5iUZFIO2H/KB4lwOYgrDIfRdNgi4e5zX1Zel4VbJc
	IA3E/qbEPpcsliBZGPSOzA6X2RkQdyZyCTAMIaGwG6yhoGMM40WxSLv7TG3UJ740
	/rJ/yzKrQ7qzytX79uRqOy7KtIyi0qmtZ0yyGAIxC1Om4+1oc0q59dHLClYh4rBX
	MTEZ0KIOvfFOtObFyObC+iF3C9zREyF4nT3lt8EPPEvrzk9DGK91oqoFQieycHkn
	u72cMw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfgj8473-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-afd3f1adff7so2725882a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 21:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744431856; x=1745036656;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eA63O+SGzPuj7ME2Ygbyh5CntFBF3jcXZzfIUfC/zHQ=;
        b=O++vFYwTLovOfPtrQkhU2qsXtbG+enRjPvP96deHc7VlcqU6OQ2w7evWMnBLswsMak
         5Zm1rHiDIdpqgiWnKbQiH6TJpwhUSHdOdEEVcpdfO5iJQFULHndj8A3vOI3mvl0cDBzj
         VkmvWta2D3XjCaIybqO4rBbkAWz2L4RXj8O/VpJrbB7ELcZGCZJ11xonyZnQPmsjE8Ir
         prsMB6AkORGmAUMRSKVl9y9xdzybt+7nzP6pVf96HTT8rFJjt5qPM7nd24uEKVkvf75n
         NaXe8AHEX873KJ59OwM9QAK+viroH6kYzKMVrccQLb1OcH6lvXRcBCOKUPjNZ25ShjSv
         OePg==
X-Gm-Message-State: AOJu0YwnFpKa4IoOMHaUpruZddwOllBxm18haQrY3TfcM8b7qQo0ybHq
	UJ2C5cfCGz4d3bpaBHir5g3tn6vVJ9NX/UgdWKNMZFMzH/mQQb2nQXEvCWiaFxOOZ40O0it3Vr/
	CdcdKQvxYwzMbi3xbVhtwzZgQB6GNrKEdLCm0ry21w/tnOXsCThYVP7/Wbk6FkUbfsA==
X-Gm-Gg: ASbGncu9qeOqji3ywIDO3fiT0zfUlthe44P8JW8PVFclJ/aGKRmjgoI5HXl7xsa2fDm
	57Mxf74/FpFB1XODvPP8aNglifdOKvELkXvMh78gr6UJ5rlP1SAApDfM+9rCSCSqJ7LBm9VGZjY
	fvevKNt4vqKEVPXOeb1cNmshKAJNaMz8x99pUMX/zNdTNjTmIXdJMwwReHKaYXZ2vwEnkrsYn1z
	YjxVhTLxnRjG1EO/4PqOzFYyrHEMD1FKTf+tBBmyQtO1gqldlUIRnhgErImvjEPT3K1TnIrme2I
	KC6+3LeMn0uRkkS/NoRdAgXT6ZoEttMuqP97P6+W+ZeijWeB
X-Received: by 2002:a17:902:f54f:b0:220:ff82:1c60 with SMTP id d9443c01a7336-22b694abda1mr128293715ad.14.1744431856132;
        Fri, 11 Apr 2025 21:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEN6Mj6RXSGK2mkeAcX/+KDJ9rUyesfPv+0L4J1LE/cX9jrDBcP9xfm3Ns1S6lyYK8p5YElg==
X-Received: by 2002:a17:902:f54f:b0:220:ff82:1c60 with SMTP id d9443c01a7336-22b694abda1mr128293305ad.14.1744431855586;
        Fri, 11 Apr 2025 21:24:15 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd11e643sm6829912a91.12.2025.04.11.21.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 21:24:15 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, Harshitha Prem <quic_hprem@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250408-fix_reboot_issues_with_hw_grouping-v4-0-95e7bf048595@oss.qualcomm.com>
References: <20250408-fix_reboot_issues_with_hw_grouping-v4-0-95e7bf048595@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v4 0/9] wifi: ath12k: fixes for rmmod and
 recovery issues with hardware grouping
Message-Id: <174443185481.2972989.8690863777364308065.b4-ty@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 21:24:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: r4Xmnk6Nr9EtAB3lZJNBPzwPkJFLf0AJ
X-Proofpoint-ORIG-GUID: r4Xmnk6Nr9EtAB3lZJNBPzwPkJFLf0AJ
X-Authority-Analysis: v=2.4 cv=Cve/cm4D c=1 sm=1 tr=0 ts=67f9eaf1 cx=c_pps a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=ZRrjOVPENkOEQUbP29kA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120029


On Tue, 08 Apr 2025 11:36:28 +0530, Aditya Kumar Singh wrote:
> With hardware grouping, there is a kernel crash with signature -
> 
> $ rmmod ath12k.ko
> Unable to handle kernel paging request at virtual address 000000000000d1a8
> [...]
> Call trace:
>  ath12k_reg_free+0x14/0x74 [ath12k] (P)
>  ath12k_core_hw_group_destroy+0x7c/0xb4 [ath12k] (L)
>  ath12k_core_hw_group_destroy+0x7c/0xb4 [ath12k]
>  ath12k_core_deinit+0xd8/0x124 [ath12k]
>  ath12k_pci_remove+0x6c/0x130 [ath12k]
>  pci_device_remove+0x44/0xe8
>  device_remove+0x4c/0x80
>  device_release_driver_internal+0x1d0/0x22c
>  driver_detach+0x50/0x98
>  bus_remove_driver+0x70/0xf4
>  driver_unregister+0x30/0x60
>  pci_unregister_driver+0x24/0x9c
>  ath12k_pci_exit+0x18/0x24 [ath12k]
>  __arm64_sys_delete_module+0x1a0/0x2a8
>  invoke_syscall+0x48/0x110
>  el0_svc_common.constprop.0+0x40/0xe0
>  do_el0_svc+0x1c/0x28
>  el0_svc+0x30/0xd0
>  el0t_64_sync_handler+0x10c/0x138
>  el0t_64_sync+0x198/0x19c
> Code: a9bd7bfd 910003fd a9025bf5 91402015 (f968d6a1)
> ---[ end trace 0000000000000000 ]---
> Segmentation fault
> 
> [...]

Applied, thanks!

[1/9] wifi: ath12k: fix SLUB BUG - Object already free in ath12k_reg_free()
      commit: 6d019abc402f58b25a7cab30b2d9af2f3173e4df
[2/9] wifi: ath12k: add reference counting for core attachment to hardware group
      commit: 62f3878fa290cb21535459311fe1dc008cd381da
[3/9] wifi: ath12k: fix failed to set mhi state error during reboot with hardware grouping
      commit: dce7aec6b1f74b0a46b901ab8de1f7bd0515f733
[4/9] wifi: ath12k: fix ATH12K_FLAG_REGISTERED flag handling
      commit: 6af396942bf132a1a49523e8fe2f816dc1ebd913
[5/9] wifi: ath12k: fix firmware assert during reboot with hardware grouping
      commit: 1d55625bc2a1c2a8c68153b020e1e097ea27f1b0
[6/9] wifi: ath12k: fix ath12k_core_pre_reconfigure_recovery() with grouping
      commit: 718ead261feba32b00f8ef1d3dff7527106b9458
[7/9] wifi: ath12k: handle ath12k_core_restart() with hardware grouping
      commit: 3e1312f01b508d3f77147bec5286caef074e5d9e
[8/9] wifi: ath12k: handle ath12k_core_reset() with hardware grouping
      commit: 929069c1bdb70c6332c15f3978d4c8830bc43efd
[9/9] wifi: ath12k: reset MLO global memory during recovery
      commit: f5755c23ed8a4603194f6425828a2760f814e117

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


