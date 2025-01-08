Return-Path: <linux-wireless+bounces-17174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C3DA04E25
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 01:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46AAD16547D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 00:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D698C147;
	Wed,  8 Jan 2025 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YFNewAcx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00AE6AAD
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736296353; cv=none; b=MPe3i3c3/d2EFsati/lidolvSEXIGMKtKMWobwo2jxFDr1qwhbpQ1drvO5PtlFCx7X3BLaAgoMIPTJgRJPVFJgPVRDML1sRknkC7JUqYudFMSzpptbIMMYAGztkgfn7zaveM1rJc9KmmZP1Y/YGd7hGNTyG96mXiDlb3e0mRyms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736296353; c=relaxed/simple;
	bh=nScOTy4e0IiYUEonBpvRAMNGyhswXvSSG3YXpam3Z+s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZJM29bUX4r57SQW+ycyxKqabdG+SPEIpj7RHUdxXiSxp4XZWNoTu5C6UzB2hkL8aKJXgpkyf0ug6fylK8tEYtcXNVIGlHQQPXK1X4bQCjNit3qjvztM9EOwz67NPUzO3+HshXXvKAc2HHSCKH7+C5Ce8JC6bwf7ID7CK2M6ON7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YFNewAcx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507Fbf70031391
	for <linux-wireless@vger.kernel.org>; Wed, 8 Jan 2025 00:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UadlYwA0sL9sUyzLA9rXcfvb4uS4MmSlAwuQeewV2gU=; b=YFNewAcx8jIQmDl1
	OZ/Xd16UtQuOpmHHH0gs8CE+67c4/mbyZ/bo3M57GeAlftzKyiCybR0zcsN6bXOp
	FPsEHQE2dNp/Xhsfd/dlFQv+kfk9slwgHpzLAXYSKmHNgZLZN+XeSJaaLEn3/hLO
	PwvdIW/Ys8iAfHGc/86eWg0347EMfE7zh6a5mRgc7a8EO20BvJw9rxvuCsVTanbL
	lXezwvikkiWgdNymXp1XpT5tWb7om2alzwrR5IrJdaL4KVcFBZGYDPVKzBK90H1H
	GMBSkAkIP0Qie4ABejq3KeRX3+4aaapPqPZkSXZ2m0vMVohbMiTRPHyR8vdl389q
	+kOVLg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44172xs47n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Jan 2025 00:32:30 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef6ef9ba3fso24061086a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 16:32:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736296349; x=1736901149;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UadlYwA0sL9sUyzLA9rXcfvb4uS4MmSlAwuQeewV2gU=;
        b=Z0PsWVPCt0qenhYPMwtiaBOFCR1WOiCtSt3RtWnMPCS66FG+SfwG6wcDh+/G5WLRWg
         t7q0jz/H2LyDmEySqGaKmGB3oUOe1uJ+hgJzJa5Mg5aITmAjlvx0yNc7DKDVOf2hopUt
         tcCS+ctdg1GKCT/4ZfRnLQe2/r8YouZ2eiIh67Slm6Cv71k4eh6dibv4F9MRyUDuFtfa
         hLoELXBE6q27Qf7qTJ6bIaSYOnIP+Apc9Wowy5WhPu/J9734b9l8NzyGX39SXNAYphWX
         cSVn7VYI18DSoeHGSZEUUxxMxPFYMa+TzSFmdB632/X8kpYaq7FR4nhwZPkPcB5u2vCj
         3qxQ==
X-Gm-Message-State: AOJu0Yz4NYbm6fdDWfYV4U2t3A8nnAJbgxPUeC2/PqQbHXoYtF1zp4uv
	hMvanADTK3pT/GFBODyqgkPpkfUCC0T+hg3H4fu/anCPRtm5GmQrphQFazQFEu/6V0mNfJ4Oqdd
	Poi2/FVWnpq5wwGUw4GDahidgC0DFy5Gtch2kogj4TCdka0lVlEmTTlvS36olTtXYjVtOfMHlQg
	==
X-Gm-Gg: ASbGncuFkpcpH0E1jGdECUUZlYKYmmOixUqCdXRiQxGid/ZjklDJCVxrmnhcjgGYj8P
	mtu6Q0R2a6Jt/s2k1NbeV+vNFx4rlzdTaal21bAq4EXdH917lnDS2qYrgCRLac9gMO3SqmKUgua
	LqKLq6/8B4abJVFTzqcJ+Xa892WinLBmKBN7ICqsygLGrim0ShobIcAJxMnSw+hPgC4pk86QqFW
	XF0ckV1ItzXfTJeZ0ubo+1PFiNc8DSLIQi7Va23EX53nhyt9CbLXNgfGB7a6eodaJXQHRwVEGCe
	oHp4QjHp+ZdJhWV7Rw==
X-Received: by 2002:a05:6a00:884:b0:725:8c0f:6fa3 with SMTP id d2e1a72fcca58-72d21feaa9emr1379263b3a.22.1736296349068;
        Tue, 07 Jan 2025 16:32:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvyWQdk6FPRYvA5K948NruwDsqWhJPnsVBRzTmF4BXeD/fy2984BhbwQfxLL0TRLokUtS5Gg==
X-Received: by 2002:a05:6a00:884:b0:725:8c0f:6fa3 with SMTP id d2e1a72fcca58-72d21feaa9emr1379231b3a.22.1736296348631;
        Tue, 07 Jan 2025 16:32:28 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dba83sm34041162b3a.116.2025.01.07.16.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 16:32:27 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Santhosh Ramesh <quic_santrame@quicinc.com>
Cc: linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>
In-Reply-To: <20240909073049.3423035-1-quic_santrame@quicinc.com>
References: <20240909073049.3423035-1-quic_santrame@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: fix tx power, max reg power update to
 firmware
Message-Id: <173629634735.3079396.2749776336139001746.b4-ty@oss.qualcomm.com>
Date: Tue, 07 Jan 2025 16:32:27 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: Us4V0kiVCagdQAsP77SnN5IjbEARZtL8
X-Proofpoint-ORIG-GUID: Us4V0kiVCagdQAsP77SnN5IjbEARZtL8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080002


On Mon, 09 Sep 2024 13:00:49 +0530, Santhosh Ramesh wrote:
> Currently, when the vdev start WMI cmd is sent from host, vdev related
> parameters such as max_reg_power, max_power, and max_antenna_gain are
> multiplied by 2 before being sent to the firmware. This is incorrect
> because the firmware uses 1 dBm steps for power calculations.
> 
> This leads to incorrect power values being used in the firmware and
> radio, potentially causing incorrect behavior.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix tx power, max reg power update to firmware
      commit: 3540bba855b4b422e8b977d11aa8173ccb4f089d

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


