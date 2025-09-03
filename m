Return-Path: <linux-wireless+bounces-26978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6ADB427B2
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 19:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E111B25061
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 17:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4283A3148BF;
	Wed,  3 Sep 2025 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Od6szjhS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911B030DED9
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919666; cv=none; b=FuwcHVQiWyQO3gVbimmRufMLXs14NMlmiOTQJ0sbEF/wdk6kR4DzUgfUKazYSPcpp+GeHBK/C0ORCK5sJSsIa29USsa7j5jBQtMotvKX0oBA1CqYAWX0+mCg57J2zbUpH2+IBd1ibyLTeOgVYODGjhInPlNLBAxETOfT1xVB+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919666; c=relaxed/simple;
	bh=Jfb1+trsOL0H9xVdnNXfcEly8IDCciGkJQSuiNChJks=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Upsv4AOEEKPJ6lSMnQiy5qmjzA3Lvw2Q/8Gl+tZXS3m+LDAWqvdnPX4XkbmMWuobv7Syqqv6OXPfdcg4xHY++9uMtpQskzVB92Y8wc3k2fX8wMd04EHUZTw6MOcgnsS8Q2UDRcF2wlbl9fNHiHGE5vKztKQgAEqD6nwQHt81PQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Od6szjhS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dwu94005269
	for <linux-wireless@vger.kernel.org>; Wed, 3 Sep 2025 17:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v75Fi62mxj8XNkVxvV6QLVkFyFtoZR6kYPM+nXYqV8w=; b=Od6szjhSznpqY1+n
	eNy5x0ccSdkjRujVv81Szew9tRda6eK2xn6UCfi93L6RmhKLXZe+fX9i4MPNTDLZ
	khOQWJkLPnnNsmhbegOweW0kYV8TASak7Yt8KPnjMIDjyUkPdfwYZUksNcK/L0tp
	WbMLnQsQZHSIAGZPNyxdRhoOcaUKcUwAeNy2SiAXsrqq3Kqzs9ecFwfeySKiqIN5
	FelYQagn5FSAt2zkgcT8RmtKZ7Ly67XgJDP7JQ5ZZlxFN+5w+L2pyXhdm3OWXAWR
	KATZaA3Uj7j7mZB9grx7zD2Fh7A0o+LkSPa6BSWqUjIWJBRMgmNIzDZIRrVaTd36
	4va8qw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjmhhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 03 Sep 2025 17:14:23 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47174b3427so30493a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 03 Sep 2025 10:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756919662; x=1757524462;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v75Fi62mxj8XNkVxvV6QLVkFyFtoZR6kYPM+nXYqV8w=;
        b=LjIDzVCakQvXRBMvp7sKU0C8u9oVqWbWA+9kssUWBWKr/GVrFY4YW7exwSJ8F6iZnY
         +N0qz640w/+l5ngbreJpAZHDzA+I7EjRdN03YykJR9Sp1y5TeuWJKMC7JquXNEYr+edI
         lUbRnvYEjslWrYX/gQC48J4/AO3DBOlOW/xTKByhSNE1q5IHswzuJGTPFobWtp/zVg9L
         ngW/NeLH08XZ5K6GBHQI9A6zEyz7DLh4FUUZhVePAm+I7JXrIpAPOrM5vxkAkaA4OZjI
         8VMj11aJN9W9QWxgZE1UpFn6veGvR1/d4vbdh2/DACV1Y7hrSAlFT5uv9d8/5vmF7e3s
         fXCw==
X-Gm-Message-State: AOJu0YzyIeug+wpxtOf8i5whkeaPQyqToEFFEG1oP3r7kV8an/eagyrm
	ltiFoTw/9WlnO7fEEnrHThI57olEVaf0jd5cgrz+e2QH3uGlbexZXi/MZcQ8+O1Kr54m5JazNDT
	h3O+ab3pz1IuH6Kh4pM1VAMo9pzJfSKjcueZlO9QsNEZY/1zC/JQNPuyzoqU3gzY/29DiY3eJKI
	IP0A==
X-Gm-Gg: ASbGncue+2ZpKS+ED8sz5CdWKFy5louoDGRvSX8UQZotzR66L8Xhtn0u74ZtHPJs19f
	q9OcnR1KHyni9BNVRKeAF6ebSfavbYleX3Iz4gkwofyQW90QjEagVsH8l7EoOoSSdPBapjCXX8L
	BIP5imT+HbkJRSIeznDRG5cfF01vvEU3dpnLlhHWblHpsD8FLdZT0FnCUlrYFVpLh4DLb8/N3+a
	RGoB4b/zjOKpVjBiDt46N0pcKlCSzKk6L7zfQdUrOX0OeEvWAtYDyJjXZEl11B/Qp5tb5IJFS8y
	OhyAKu0GdwWms8kRAMAkdMcqHy9yaY4Y/0NAQ/eULctia5DO6svBUAadrhtLVSDQm4xVuviZVQH
	/
X-Received: by 2002:a05:6a20:78a6:b0:24a:c995:e145 with SMTP id adf61e73a8af0-24ac995f03bmr30766637.19.1756919661735;
        Wed, 03 Sep 2025 10:14:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCCvEqrtzK/dfNfpYnHQ2d0iihclOP4R05ltVmeesS7FMCdTLdkH6CFKMRA9lyoiGNrk4JTg==
X-Received: by 2002:a05:6a20:78a6:b0:24a:c995:e145 with SMTP id adf61e73a8af0-24ac995f03bmr30730637.19.1756919661224;
        Wed, 03 Sep 2025 10:14:21 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725f0c4008sm8977063b3a.35.2025.09.03.10.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 10:14:20 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Ripan Deuri <quic_rdeuri@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
References: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
Subject: Re: [PATCH ath12k-ng 00/20] wifi: ath12k: ath12k file
 re-organization
Message-Id: <175691966048.1226519.16179210162872545412.b4-ty@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 10:14:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b8776f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=ctgflo7pkZbJDB4sY20A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: W5DJ14W3lBu_XupvVXJUFP9Cz6Ti1OSc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfXyi60fIIteXVT
 SlwJSOBV6eD+oVqoEGHNC0OwHXLT1k7qr7LKJyGvUXvf2Q2C9xjSNKqAXZbDNmrkNlzhlncCJjU
 qhtak92O5VxEVluVoKOvF+J12WUGW+chVJMLFZMSpFDZtFVtkHP11vW1jiLyki5R63nIJu6j1Tp
 HBLELgyH3VaSX27bIucX7hWOSMqn5O22PQHX6JaVMF8QXbk4QMCsTTZd6PZ4fGs4kVUWpLuskDz
 XZNayusvdUWmmqFflRTJqz4Kyl8i0WqiYipESPYt1FzuD1C6c+J4m3egncdSTR8gjjacsG2z/HR
 Fxqg4FEITca+42jJRamEUdnYxnqkI1lF4tfZe/V/70YMLRIKzVyYjBvwAJ6ieSiZqVflM18dbiq
 GzbbxJ8P
X-Proofpoint-ORIG-GUID: W5DJ14W3lBu_XupvVXJUFP9Cz6Ti1OSc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024


On Thu, 28 Aug 2025 23:05:33 +0530, Ripan Deuri wrote:
> This patch series continues the modularization work described in the
> https://lore.kernel.org/linux-wireless/20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com
> ("wifi: ath12k: Ath12k modularization changes") series, which established
> the foundation for the Next Generation (NG) ath12k driver framework.
> That series introduced the foundational split of the original ath12k.ko
> into two distinct modules: a common module (ath12k.ko) and an architecture-
> specific module (ath12k_wifi7.ko) for Wi-Fi 7 devices as depicted below.
> 
> [...]

Applied, thanks!

[01/20] wifi: ath12k: Move hal_tx and hal_rx to wifi7 directory
        commit: dc722ea9ee13369b1d4687160206e6bde2e8c2e2
[02/20] wifi: ath12k: Move hal_tx.h file to wifi7 directory
        commit: 020225bbf4fb2fb23553ac9c65c8f50bb4d2fe74
[03/20] wifi: ath12k: Move hal_rx.h file to wifi7 directory
        commit: 4f57d71862a7edef67de6c2072127dc1c8960a24
[04/20] wifi: ath12k: Move HAL Rx wrapper APIs to dp_rx.h
        commit: 2ec00a7747cb78b0c310ba1c8bc9893e53101569
[05/20] wifi: ath12k: Move Rx error related functions to wifi7 directory
        commit: 1a6a4b6c9f0ea0740c86dda8b981b6d818433fe0
[06/20] wifi: ath12k: Move hal_desc.h file to wifi7 directory
        commit: 87a230ec2bfa15506b885e7ab958bf45b0036e8d
[07/20] wifi: ath12k: Move rx_desc.h file to wifi7 directory
        commit: 8658abc7139fc72d94959335becbabcd2b3c95a3
[08/20] wifi: ath12k: Move rxdma ring config functions to wifi7 directory
        commit: 8dc72a6f603e81050ebb3d8b4b2fc5fde0d9dd93
[09/20] wifi: ath12k: Move rx error and defrag functions to wifi7 directory
        commit: 6b4954d3f0000cc687f263a151ec2c7ad38e00a8
[10/20] wifi: ath12k: Move regular msdu processing functions to wifi7 directory
        commit: a7cfbb18d411b186ff67f62215e53e125ccc93d6
[11/20] wifi: ath12k: Move srng processing to wifi7 directory
        commit: 5d2df2aa84303a187b82ca048ae28709bef85f77
[12/20] wifi: ath12k: Separate arch specific part of RX APIs
        commit: eb2120ae6ab5790527f3b3066410543c1b7a5ab4
[13/20] wifi: ath12k: Move arch specific REO functions to wifi7 directory
        commit: 6c7ceff2bed9d69007d23883f12a1406e149a060
[14/20] wifi: ath12k: Move arch specific rx tid and related functions to wifi7 directory
        commit: 52c555680bae89a5169810f1f12a06241c93ecb7
[15/20] wifi: ath12k: Move arch specific tx APIs to wifi7 directory
        commit: 8527d81ee622f509df11e4444c7d0901ac542174
[16/20] wifi: ath12k: Move ath12k_dp_tx and related APIs to wifi7 directory
        commit: a45d0e81b2429c26db6b1ee0d43ff62b12d41d1f
[17/20] wifi: ath12k: Move HTT code in dp.h to newly introduced files
        commit: d3ade00eb6d27dda5ba0026f5602f03b99df5a96
[18/20] wifi: ath12k: Move HTT Rx specific code to newly introduced files
        commit: 71a3f92c512e1605a2ffdae94e4d4e3a6a63b90f
[19/20] wifi: ath12k: Move HTT Tx specific code to newly introduced files
        commit: 611297ee9faf6a28b1d553c41c4677052629cf6c
[20/20] wifi: ath12k: Move HTT specific code from dp.c to newly introduced files
        commit: d637c58a29475d646f8decfbbc1d27fae999a449

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


