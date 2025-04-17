Return-Path: <linux-wireless+bounces-21682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAFEA92D67
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 00:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9481B8A5E5B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 22:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A42C215079;
	Thu, 17 Apr 2025 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fld7lMpw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584B61D89E4
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930659; cv=none; b=B/pC2ualXec4/G7kfvTMDsYdclk8BHeCKogFdacIQeHf8Il7pb0Ob6Cz4mrNiLsLkLqNrXWtWAEIb2EjNuqpX5l2CdriAA4Jb4iKDod4H1qC5tKe7rvbg/YvSloPzNp/1vEtEwqTBpMkxfykrvIaysQe9A7GbA9PrfveD0t7vDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930659; c=relaxed/simple;
	bh=3G/7SgszBhPnssl1L4JDfQNwnnqO38JkqRq25sc1Mls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RZUOmg+u06l8ghiPiNkX67IQN2PwvA6I3f9cL4kW5igLyFPPjyjE0xVN0Lg+HaLeglZHIQ6DoAdS8UAyvAfRHcFKJbupVSgTkbs3AUj22fsmdArz6cJePWJdNjLHIaMiekg4t/TOaG6OzFLKDbA0V6SN2/kXXFOOj7z39FE7ykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fld7lMpw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClQq6029005
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XaqP8SFKdRxw9wI8vP2V3w7liQVVhNjnjDMQWJx/Nmk=; b=Fld7lMpwPppeRY64
	undIF+KYspbLS/XcZyDwM0iECfyXR7+qyIR/b5DbK0PtYseocH3ayYGj/kilpssc
	wzEFJ3TvnkdwsRrOpjqtuN7XH1bk46NgFHj7h8u6k14Tbay8KY5bFUw+vMkBHw2N
	9ZMo0EMbzEuFpWAmPqxqtDm+G0fb6tAZ9dIQjT1VoIAaZ4ZcQ/j7Vbyg9qcXJFN8
	EhTPXNXxXRsWMdDW9JRhPyD7M+Hg3mVKUSfxr2jyRT1EGLU2/gDjw+dqlz6LYJHG
	B8ZbiCtO4q4guOcy1/a88eSIrj8YSJ2rXHYxDBRnZ1yxog4iKgRlYMevgCMxxvFt
	iPYCVw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygj9gcs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:35 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7369c5ed395so1260191b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 15:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744930654; x=1745535454;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaqP8SFKdRxw9wI8vP2V3w7liQVVhNjnjDMQWJx/Nmk=;
        b=j8ob6jYQjAaObv4AvizDBk5VrHU2108mxexGxxxZeQom85ca/xjYKYdBKuvtvl/sCe
         r83DfY4Xdi99KUPxROxjn0DbRWTKILgRiYdh6mhX/X86lxCOaeWt+kWCbNLcK3c2+Ys0
         mEgYgHYNAWvJQCubc4Fe6PmDe5NuUMyJupmhVNiqkCuFpkcDUxP6lKCDji/S5Uhx2znk
         bJMFbFaYibDaexozQvUnF5/cCs2jw9OiZ6tnGife1ASJDduFpc13VRwnJMt0s0IFWiRR
         kKd+EUIk9KuzZMunfegdipVy1j5oN/MSUHwYpE8Mx4C4Dcps1vnLRR3xwv+0tkhQiMNp
         CUIA==
X-Gm-Message-State: AOJu0Ywhm1T0hNWXQXrh2WFVBo5RpXgHR7PL/VlapvHfll6xuS0OvE2y
	xHdY/cWSFreVVkVrqYgMCpn2PE7UwWM1pSzyhMGbWQecrN/gOlSVet1kKCtl8nn3MjmTQ15Wty8
	97fi8S5ILsjr/wKBrQIYuw2BtC3+VduKR8kuop4UzWiFZG9jN41EOGXVm/+YB3stIDg==
X-Gm-Gg: ASbGncstHmUyneoIYuRBXDkvTzEFsd9aJv/CmsTPUwnerTg3zpc3YpiISCLtmEf2EPF
	gv8yyW9X2SnJBZL+/0gt6THv/SzKHpNKFXpBEcp0WdoapmzHFbsENV7d4eGPFqDRn0a4i1J3i0D
	7+iDfSXf9yySheBBRcPHHAGklD+wJbKItkoV7ztUFxRHVxxdQUBT4cUkCswVSqTViGm3n0SqC13
	DSFbqBnkis6+LaPHCI7VX9OfG6LyWCI6jgdMkLswe+6HQnTC3pdSOlGmfkCE5qHu3BrDvAEXsLa
	pTdian4hTb6dLXreiJftSCvdr3kd8SGugrn1gIocw/KpgsRM
X-Received: by 2002:a05:6a00:10d2:b0:736:4cde:5c0e with SMTP id d2e1a72fcca58-73dc14abb4bmr616823b3a.10.1744930654559;
        Thu, 17 Apr 2025 15:57:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIsWiZtYwx5CeHZ9+d6X0zLI+TIHALQGncO5RbwLXgN7l1+Za5zl6Px5QoL7ZVPT5gFzMUuA==
X-Received: by 2002:a05:6a00:10d2:b0:736:4cde:5c0e with SMTP id d2e1a72fcca58-73dc14abb4bmr616804b3a.10.1744930654087;
        Thu, 17 Apr 2025 15:57:34 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf901187sm426468b3a.76.2025.04.17.15.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 15:57:33 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Rajat Soni <quic_rajson@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250408042128.720263-1-quic_rajson@quicinc.com>
References: <20250408042128.720263-1-quic_rajson@quicinc.com>
Subject: Re: [PATCH ath-next 0/3] wifi: ath12k: Properly update frequency
 range
Message-Id: <174493065331.1347382.2819170048553600986.b4-ty@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 15:57:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: 350S3JJ95luBQN8rpIYCwr9_WRO2CvWz
X-Authority-Analysis: v=2.4 cv=PruTbxM3 c=1 sm=1 tr=0 ts=68018760 cx=c_pps a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=hJ9QsYJt4PUDyDSkwUAA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 350S3JJ95luBQN8rpIYCwr9_WRO2CvWz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 mlxlogscore=885
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170169


On Tue, 08 Apr 2025 09:51:25 +0530, Rajat Soni wrote:
> This patch series ensures that frequency range is correctly updated
> compliance with regulatory rules.
> 
> Aditya Kumar Singh (2):
>   wifi: ath12k: Fix frequency range in driver
>   wifi: ath12k: Update frequency range if reg rules changes
> 
> [...]

Applied, thanks!

[1/3] wifi: ath12k: Add helper function ath12k_mac_update_freq_range()
      commit: b7544de8a2984e61b95c58c1c6c1e8ce659b1021
[2/3] wifi: ath12k: Fix frequency range in driver
      commit: 657b0c72c4ad688d424560af98e3258b3f875a4d
[3/3] wifi: ath12k: Update frequency range if reg rules changes
      commit: 13324cecbb2c390a11f1fbfe87f3a5e62d6e4591

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


