Return-Path: <linux-wireless+bounces-27987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A490FBE10B2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 01:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63FC19C263D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 23:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F343191CC;
	Wed, 15 Oct 2025 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="igZQw52Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66BC3176F4
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571631; cv=none; b=O8l/vRjflgJqEMzv/ulY126tIZP4JyN6IgaUZpi5UpcyllySeUJ47paZCdTqseNbpHOa7HYNQtxzj/wgmBVAyyJlNMnUpoRt4BVY/Lqy8Rp+LAfSlBNoEEeTuNI5l9SRv26VczG6fm11K+AxfI20QrjAfe8298aS/UGrZUmv3ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571631; c=relaxed/simple;
	bh=beQrxRG8Gap78fUZcgTM3HujSgKgDdV9r7B3c+djAlg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=blMJmvgsROZQ/cx/a//UH70nF6oSccR8hTiuMJs6CyKFwGMZtMohnvM0gBQXrx53yL/Ef94gbhne2YSsbutw3/0lxnCfcemQ5pFWvOAJxkQqBtK5OzzdjwfjRFqPuIIuIDXGmsMrbkzMW7o7Xcm9fBQPauySIjJWlUmc4G01pUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=igZQw52Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FJ0vUE003541
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3x0IYHbY4tjRVt2udhF3EIVJWGOX/Sl28P39SVnXZ4w=; b=igZQw52Q6CcA/xnU
	oaZbb8ct1lh+XSfgQDiC0bG2RNrlKV+gSDAtRyBF7bHBSliDsvaHamTzqtPVCSSf
	OZ5KEG7jlsLY8nUL3lJ+DTU4cWtyLsLDxhCf5+zZKZKILTA3yXnRdClcfxuaBkRX
	bHDb3PDfTDx/xjIQnEUBp4vIbUxYs53rrINBDhEONsqn5EwthUTci6lMgjHz1RA/
	4irwqgvQrZ3dW7wnaGRrV1qQhJRYUssyFd65tOLne1AfXrr2VANdS7F0upR5CCE8
	C9WCH97+H/Skcu3YfCSXiqufGR3LePWG8q27a0dwtujgVfLh09nW4fOWP1dBWcZa
	HIPSRA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8mwm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2904e9e0ef9so2246565ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 16:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760571627; x=1761176427;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3x0IYHbY4tjRVt2udhF3EIVJWGOX/Sl28P39SVnXZ4w=;
        b=L9S6mbSp9uL5EHID84AbqG0BS2e3PFfDuKHYEOKJbnnZJsJULMLCW/tgI7+357RPxh
         H7830K3/kb5jDy1xAcOIG2nFS9aTmVdWN+knXr5y++3oy+pW4g8FMoCIuJJdycwQ7/R9
         CRUrxelvKKd49rnR8gFJKTl1TaiHyGuuZ25bLejf7eoTlAvZDe0NrWm76QCbmKXCPyuu
         ZjwE/D5lhDc4Gu6trd+/ifJHLa30sDYA/aEEN98Go85FP0dAxCMod60pfcxd4andcfP6
         3sT5Xw3FU3NTtb8p9QPWmG6V588S1wJRHDO1zEt/7/750cUtBCVXwISMvrWahqBvjxxm
         x6Ag==
X-Gm-Message-State: AOJu0YwThT50m0T95Jl+EDR2yeL8m8wUJNNu/nf0bnVOOrmZhN1+ZEKs
	Karg7JcD99Pzfm6s69ZKR2TB2VmOOdRDp8SdMNBaG1xJW8jeI0tVBK2i/T9aRJM5NjuJZiVZsFn
	rZG+9k5MfpN6J8bzM9JNTwPoTHQ7Zn9BBdlDWvFE8QleLMHPDHIpJiT0sDkgoB2+Y+Uf3Jw==
X-Gm-Gg: ASbGnct1rmcgsIywdAz7eE/oVgT/KHW5/BkMZbjUtTtvtywBJFcXGyKFIJM/+mI7hgT
	/V5rWq1n1S4vEvAHDw0sGABi1U//9McmBWsYW2hqlLZu74Ee2ZPRBP4vC+P823Zotxp1S3/STXS
	t7kH/hj56MAqLmx6wPMtR3rz4v3Z+FMan5PEm39rSvMC+3uaHDwGKPvp0OiKn72vUfLCWgWSd0n
	WDVzjtT9ETVr6mfQ/T5+sjeSnCpuJgYtOXQqK6myK5QM62EYokPv5GDN2HFLzWBfu90n/xqFqaU
	qzFwAcTO2Q2RA3qJ+6fTYEyNZ02gkdi1Asq2EEYWGcx144U01+b+mfIbqZQgCpWOtjRJZuSeVj+
	d3lk4mWj6+svIYEBfhSptKPylf5aenrxZ/Mk=
X-Received: by 2002:a17:902:ce0d:b0:26b:da03:60db with SMTP id d9443c01a7336-29027373dabmr426102025ad.13.1760571627518;
        Wed, 15 Oct 2025 16:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH636KnbNowyw/e0DhBDEBumYhJ9OCqLiKg+5Bgl4ES8cb0ngFTq5Arz3CAFiEs69m79TPjWg==
X-Received: by 2002:a17:902:ce0d:b0:26b:da03:60db with SMTP id d9443c01a7336-29027373dabmr426101755ad.13.1760571627089;
        Wed, 15 Oct 2025 16:40:27 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7c255sm8055635ad.70.2025.10.15.16.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 16:40:26 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251010-ath12k-nuke-wmi_bcn_send_from_host_cmd-v1-1-6f1172b77848@oss.qualcomm.com>
References: <20251010-ath12k-nuke-wmi_bcn_send_from_host_cmd-v1-1-6f1172b77848@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Remove struct
 wmi_bcn_send_from_host_cmd
Message-Id: <176057162643.260563.1781488828218446991.b4-ty@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 16:40:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: vEE7iSa-YyZREwNe29wrtMMKL2MZsBOf
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68f030ec cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-EFR5erphFcivXFsqSgA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfX1+DaFWIGstzE
 7wmiMZ/uFhAL8vyesICqsK4sLTX4DfghO4ZxDzkpnN+Qi0I+FsTWIqk4/QNpWwv2nU93I0oSbI8
 6icbJeDwWHJuRyG9YRfA9ZTP1fIH7c+2D9gaT8JZTWbXfovRjwtSiga1PlkxMDXmGux8biCbM+P
 5uHCZcoHUcRLGIRU2A3Pnc+EWPnSpu9l0UCgH5OhbgtB4yqOlk6Addm/b4c2FKRe1Mn3GNQdQRd
 XNauu/coafHs8b8SlGfEKQuN50HnJiNAvt/fxnKVfLY7gb4+WV1TX40m34E1u43j805e5nfhQi+
 nIwtkPB6bD4P5wQauU4p25upVkX4eWWsW04u7oMrZ+mBaKbrDPcGdkfPXfUHsrjXJxfuQ/4uE3d
 rSZrNe0mJ3jkhErw/3qh/hzeO0rrAw==
X-Proofpoint-ORIG-GUID: vEE7iSa-YyZREwNe29wrtMMKL2MZsBOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134


On Fri, 10 Oct 2025 09:47:58 -0700, Jeff Johnson wrote:
> struct wmi_bcn_send_from_host_cmd is unused, so remove it.
> 
> Compile tested only.
> 
> 

Applied, thanks!

[1/1] wifi: ath12k: Remove struct wmi_bcn_send_from_host_cmd
      commit: d34a368be24d029544cc97feb87729a9f7984a78

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


