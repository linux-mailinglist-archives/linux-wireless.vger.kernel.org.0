Return-Path: <linux-wireless+bounces-23158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0D7ABC5D1
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 19:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502DE7A19A6
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBF0285409;
	Mon, 19 May 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DC9eWWXE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C730D210F65
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747676890; cv=none; b=U5A7b4UXqaF5JDdlQ/W4inN0UoVkIKy0lKyWD8ZH78rvqTgNDUCdSm0aqpLjKxUczcET3K2iAfo/3o0kk4F498ZghjWyl8zkW9HdqUrz+U0xxHTTrboQHDeuOE8UVO5+PyYW+hlN1q09TNIO1QE4gdZLHGLBBfAX31Q+LiBh4xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747676890; c=relaxed/simple;
	bh=+ef3DR5aldnBsWOg5YzWvuHntmmv/dSUEllUpvY31gY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gjNjuau/xcWWfwq+iTJ7CGXvcM2PLBF4CfrnSMEYJKs1Z2qGRM59L1im9Iegsn9eOGVT8GR+IrX5vSytHeKb7YHKZxqBIBS2Iu76mDo/SXMIHzB/tyjCyEWz7wEHXaX3orIPfyss4Zk+NIPIszLvhBb4KJNMKMqDPbqwE9lj+uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DC9eWWXE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J9iuQ7022833
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rDC61yXbFM/Kb2g3L34VancVGNjjcyrYp+7WjIGLddg=; b=DC9eWWXE9qkNCrRG
	dPaz/20/I2kxs7WkDy+VnDLPGMFjxJdu3Sgc681cND3w5ybLzeQuY7PeRgHguoZI
	hKcMkjRlWzkHZlw3q6Qxyng1bEWJRDueuitGeOTpnJ1QaAXiLW+T/OxUzzdB6VNl
	K64yfADMuBF2F2fOp+Hd/1/SbGd10/REmb01Cz7WzbVucj3whsNvTNO6eY+LuyOE
	UmRLaG2n8SJUR9TZmGsYbHry1b85FICol4rjuarrvbeFTsA+QI1d3j8WGqTItpLt
	mgkU8UvsSJDV4nppMwr+ZklXKl5KmojRXqKV88meXS1/6HPpu+DNgb/k+Ny4yPBd
	rDeVOQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46r29d1a9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:07 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b26e120e300so4385391a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 10:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747676887; x=1748281687;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDC61yXbFM/Kb2g3L34VancVGNjjcyrYp+7WjIGLddg=;
        b=hMQt2eUkUN2xbo1ENTb5vQutXCdQMIzwBEjNYg7TAvAzgpXkZOh1syxRO0VtMGwWYY
         1pTO2o5cRKA/eUxDGvKYyRC9guaWdNAFaF/Fgq9Inje9gYU1yZWuTeStQgtNsJ36RcNx
         YFRtV/Vz8G+oKBjrOmFQhO9e6fzXO5as5mJ9p7aYP314HgXPpe3KQut9Qi4VWG/+8by0
         Yx/Kftk2tT5nvFcJjubc8t8aracrH4AGFUWeJt+dCFL2+expCiRSSmI+21+GCifLTrBX
         9RRqJ7zYe2IrFrXPaqqE9SNENRdk5drfNnbBlK1YsRUW5d6oFlaXdaHorMOtJIRqAqnd
         f5Lg==
X-Gm-Message-State: AOJu0YwyPHnBoTtbcsd4v3bHaEfSbSKxWqp63cKuBfVDNfugUkl1b9uJ
	VmKGB8JxBP2o9YZKx7mHI8LxRknZjx1kkDXbZVZUTv40MBGlZQXpSFEtkK0R0y3z26cMm7+7NJV
	23uFKvG0BrH2XI+G9hJs3iXgofsUnO3jzZH3xMXP+d4aMok30GSvqjJM4rQae8whGHrwspA==
X-Gm-Gg: ASbGncva3r8XIyAXSKhvPnF0NkfalwBlvijsrp/PyKs5GoPy7HdQ7+R7cdPjdLq8pnA
	VIVXejR1GEX9iz5wbnqI4GwN4kEJQoVratnLYR5ILpXP4c7BG2QVMRzf/17g4T6EA8xmoWrbBeR
	yRBnuoKB8IIxMnG0y6nFCWgGzxCkeVXK5qWJ+551xptoscVMLssUjWT6XA15fOrmRPePxFY1N9w
	w8DqgI1VeNCegM0iz0hfT0cUchX+wPmssNruvG9bpVEinKxp5WVzs251+cYzWreMh0cYFL4H14e
	GzX4SJ69uD/DRAKqooH7TON0lwNf/+Q5V10PWoEor7JEB3Js
X-Received: by 2002:a17:902:f603:b0:223:f408:c3dc with SMTP id d9443c01a7336-231d43db55emr185691245ad.9.1747676886894;
        Mon, 19 May 2025 10:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmqx5MzabeHoF3LGXt/LugmjXrWNVUiYh2DZ9pB6eQ1UXVutlvjRUGQgbSrOAuL3nugYe88A==
X-Received: by 2002:a17:902:f603:b0:223:f408:c3dc with SMTP id d9443c01a7336-231d43db55emr185691005ad.9.1747676886531;
        Mon, 19 May 2025 10:48:06 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4afe8b0sm62651425ad.89.2025.05.19.10.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:48:06 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250425012802.698914-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250425012802.698914-1-nithyanantham.paramasivam@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/3] wifi: ath12k: Add device dp stats support
Message-Id: <174767688597.2567051.10144712868434385694.b4-ty@oss.qualcomm.com>
Date: Mon, 19 May 2025 10:48:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE2NSBTYWx0ZWRfXxvyo6AnXfv8w
 f9FkU2y53d9WeJ8lnjDo5NUTCvQtelCLZuRiQvQZjCz9s+oObB2MzW5lkcYWqCmy5cDAxKcrXXI
 i1ydug2hcafmt+B1ouoyqvujze9v7bM8KGA1eGNSgQaLDp/XsoE4enDKJhfPU1v9K4BVC+l1tII
 7b+k9sAyOINU0kexkgCxPD2qyPWGmX4RLNVmVOpt5mCJpl3huFVuitRuPmd7PcmSiNy5LSkQ0Av
 9vvEwk5FA8Wn5YclTLbtu7R+hx60vtcUYG4JkFx32NQ2eIOMzPF7t1sXeyqpZMGHNEsAF49czcT
 3pvvKCvyGE89ViFGRC5UDh8kjHxrhFCKxL7zqhf8AThCDURkzLz2DEcM1LLT0wO/BjHENnm+UqF
 EbUEVuvqmMkhO7uNjVRz5JbU2JNvKh443Q6twpvwBbKeU5xeEjq0U1cSwfu9MFFaHKtJHyHW
X-Proofpoint-GUID: -TFzX11uC2xeiBk6us-IcsFnKlRBD1qU
X-Authority-Analysis: v=2.4 cv=KLdaDEFo c=1 sm=1 tr=0 ts=682b6ed7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=hEC-skTLgEnFcRQdyeEA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: -TFzX11uC2xeiBk6us-IcsFnKlRBD1qU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190165


On Fri, 25 Apr 2025 06:57:59 +0530, Nithyanantham Paramasivam wrote:
> Add support for data path related device specific stats. This
> information helps to debug connectivity and performance issues
> in AP, STA, and Mesh modes.
> 
> Depends-on:https://lore.kernel.org/all/20250417065237.2507613-1-maharaja.kennadyrajan@oss.qualcomm.com/
> 
> Vinith Kumar R (3):
>   wifi: ath12k: change soc name to device name
>   wifi: ath12k: Add device dp stats support
>   wifi: ath12k: print device dp stats in debugfs
> 
> [...]

Applied, thanks!

[1/3] wifi: ath12k: change soc name to device name
      commit: b602f1f2d6d4d4197aec137185875ad8b155747f
[2/3] wifi: ath12k: Add device dp stats support
      commit: c5c62287e6901c1dcac414e8e739bf9fdc72c505
[3/3] wifi: ath12k: print device dp stats in debugfs
      commit: 84873d542e95de3e00ac6e8c95ebeba9f29d6092

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


