Return-Path: <linux-wireless+bounces-27991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28681BE10C7
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 01:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F91A19A31A2
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 23:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABF7316905;
	Wed, 15 Oct 2025 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RO4EPSdU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F7B31A07F
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571635; cv=none; b=dXuwkC0lWIlQeru+VXEV4Xa/y0GFKKNkgVpRDJEmdyScucgdIXE5qoksAe+2wdFW1xveZDwE/UW6GGXXlWtP9lhAY5tZRSuq6kzLRPQKU5lr6XPpaiDtWdDfhCj2Tpy4cVzkjoX+ts5k35OvU2/a/Zx1N1z2c9emKaTgLewvNRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571635; c=relaxed/simple;
	bh=OHE9Rg2xrPg8RAMj5Q9ktGjm1pZgfFAXzKoS+mnms78=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uapxO2Auv3sGutsxI2WFDpe7e1omhTs4293ivMAUyPGo01d3/+SdlJv/8i4YlcPDfPHVhj7hKWVH8+mOrcQKpzr453v2YuoHWcai9BT0X11FMUtF5kGhVlM9sO8c8nJTOEKvONKGG+Vo7eCMvkn7zJgR4qYHFPDKBpxmiWSZxZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RO4EPSdU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FKoIrY014715
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iSE2K1a4SBjYDOYBslaV3vSVYb8UkzKK2A+Dox9Xje4=; b=RO4EPSdUDMqvf7qc
	/Y4Qsy5Mf5HQmWzDsMmYR77ovgMxBt5TfjqvurYYMDCNhzzYZanoCRTvOnAsXIZl
	U2SktDlqib6c4yiIbQl1KBhIGG4u/kCRBu6zRKMoYlUTvsY734D4Qni0L+Hhekk+
	Ac6RL0EiktwXKW9xTzEjrEOTRo9aYIThPvBRwEiel8p8Zge1y4l2h9TfIvLhgaFO
	EpDTW7hYiGL/ykc+jkSNWvELMRc0RgOKAQ0I7Ioo8Js1Tz7zpRy8KMZ0cS3g9s3Y
	7HCjZRveWzneM1blv41cj5KP/sbrurNOax1BKUiVoXv0JY7c33xyms+ii3EsioRO
	rW00QQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbj69by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27eed7bdff0so920725ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 16:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760571631; x=1761176431;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSE2K1a4SBjYDOYBslaV3vSVYb8UkzKK2A+Dox9Xje4=;
        b=IveVl99sOr1FT1WuK4z8Zx8/lM+M9zpqiA3P7IAP02o3QeSuO1bLPwTeb8Agn18Msu
         qi1IwyKWMn93ZdtxBRe+Wy7kds6BDN1XwOiR5UUAWpypc7LmagqNhCNJNWx8M7MIfn++
         qE9zG7Hn2MiE5tBfqJ/OXtsFUZlU9CpqmY0xppnk0ZbU24HlaktdDHnIGxuMYMkmvrpU
         3qjwlS+4S2fZX1KyX+DmOZt7lvEzW7Ti0fbrADB1lfiwYE9/aBMdky2WH1cbDX7uvxUS
         V+VuGBuDu5M7uWlPzF8wJlqGBJWoSSWH+IbNeyytB86QlEHjTQIUDEuHkVL40oxkU+zd
         mYlA==
X-Gm-Message-State: AOJu0YzIfObbEBJGoMOk5uMlR8qRSaSIrVQay3vu/mkQRZRPcTCXCxDL
	E3phjL34xNtseDMcJETuMB+AuXpEbuwuJ8tyV9oI5t379lRkVu1BQd7MxQc4AYjBiymv4fMYUvH
	ObzoCH7VcpRLxmLlf/92rvitO/LcsNZpxhaRxRASr7YD2RyEOk7tc7vaL/hm9TSrmfmUwJoPbjQ
	BxIg==
X-Gm-Gg: ASbGncvx3ah0xrLvbEHbB92X4QXB7cp59eK8V54y501HWyb6Jm0yWA5FO3uqOOVmRU6
	WDAAs3frnfuAgVlJpnoM3vyw25d7W3XFJ5z1Xo0mosv2MAYhh3mjUNiPOIGOdR2Adn5QZUkbbZk
	ynaBJYgNZvr0ZQx0egDvTtDk5dsab9PigdI6jvLSeHDC6eLc3CY2T1rA/5u67hYZZpGAg0djqbz
	SCop7Gy0UVcwurpf4rz3TvR6wRzJb+aa7OuxUb7s/+t9Cu4nWPybQlscR3ZmCI4S8YkqYcwAWA4
	YsupN71St7NDQ+2sRFMnb1K1lna1yv2J6aM+uB3aDUCI5CuLxa3xZFD/Y8M1+J/i859JhjomHJz
	aYP6qmT4ROiMGRmN96nrpDdxOtK03QJnF/x4=
X-Received: by 2002:a17:902:e790:b0:26c:4280:4860 with SMTP id d9443c01a7336-290919dadb8mr21704895ad.8.1760571630786;
        Wed, 15 Oct 2025 16:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKUJkqHBAbpG/W8Gx8wfdk4WHiUXIjfdxpJ40TxEArZAiTZw1GndAYMwia8Tl83feSPzOBAw==
X-Received: by 2002:a17:902:e790:b0:26c:4280:4860 with SMTP id d9443c01a7336-290919dadb8mr21704685ad.8.1760571630325;
        Wed, 15 Oct 2025 16:40:30 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7c255sm8055635ad.70.2025.10.15.16.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 16:40:30 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20251007133332.1092178-1-thiraviyam.mariyappan@oss.qualcomm.com>
References: <20251007133332.1092178-1-thiraviyam.mariyappan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Fix NSS value update in
 ext_rx_stats
Message-Id: <176057162971.260563.16262257561104304006.b4-ty@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 16:40:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX56eB/Gu6mrWc
 l6gSzBaJZf0LpPqhe8/TiuHZ3ENPfHFCMgBIDwiBc1DTjyGQrO0KWoGQTigYrYTqcPV/EvCKCAQ
 22qmTQrnhWNOMGVGeLzl0BXT4ka0M7GuTCyESesbKfpE1hljGiDkyR87kjkcKXN2MVFWFj9T8wW
 fKLTGDNfA6fgtyipAMblso9wVYCncC3uWieC8Eq5tNXTrTWfGMPssO0kdh16tUqDvJYdUwrpgl1
 BUOx6k3IpDb3+8qPWwfHkDlP6cP+vLPeSgx6W1tdfdm/x6PbUjUV7okmt2OXenfgEzRwZAU0Wu8
 FIFIoPIT9ZvEkR25cL8Bs941ZqUF+eIZMtOXHNRDjWKrWEUrQchL/Vay3x+ieWCLQBgJqw4uhnr
 rcdXTigfymst5rmWII3ORlCk4c4N6Q==
X-Proofpoint-ORIG-GUID: l8wRn09pVr3_dMtvo3kjZ8r-aNcp1K8q
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68f030f0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Zs9DEkr-8YzyMXDGHikA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: l8wRn09pVr3_dMtvo3kjZ8r-aNcp1K8q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018


On Tue, 07 Oct 2025 19:03:32 +0530, Thiraviyam Mariyappan wrote:
> Currently, in ext_rx_stats, the NSS value is taken directly from
> the firmware, which results in incorrect mapping:
>         4x4, 3x3, 2x2, 1x1 SS are incorrectly updated as 3x3, 2x2,
> 1x1, 0x0 SS respectively.
> 
> Fix the issue by incrementing the NSS value by 1 while updating
> the PPDU info to ensure accurate spatial stream statistics.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix NSS value update in ext_rx_stats
      commit: b94f523cc5a19108ff4687a4bce9e5d484f0f9c5

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


