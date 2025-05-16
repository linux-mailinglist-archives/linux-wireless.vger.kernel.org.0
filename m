Return-Path: <linux-wireless+bounces-23083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E747ABA1F7
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 19:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFC34A4EBE
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 17:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07302749CA;
	Fri, 16 May 2025 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JwxMplWZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39C26B098
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417248; cv=none; b=D/YbTpMW63V79eQ45Z+Fp29MB51pUP493qjJi8a1xsFELdVAXJj8FLLIqBx/9HkgH0Y1+0GbTPi5fz3Ig73HY6y7DyUzSG0Ku9q76sCUcFc2JpCirNV4T8ieA7rbU4nYyFihmES1MidegWQhpnarxyZMIC8uuTonujKB1MeFToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417248; c=relaxed/simple;
	bh=Tos35RepTwKsg6lRWVV0I0oCv2o0Gkr/UxlzX2JmnaY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IluIGjPLomg6f977MNobqiTJINRCVkU2OUkQbAEuUUqU7I63M93N2Jxav9vxEezJeRu3aNVF+aVeLGWv05aUa0y0xUNO0Ou7DZ8gA5GoagdPU/kBqt6/b14lO8dNChyY2gJULt1yzKGvK3ih2QcYv2bHwNjCjVbRiilmo8z/WWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JwxMplWZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GC6NU4020842
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 17:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jlubvvj+QDGnJHz9jHk3yA37ZHRIx4oKicrzEoPiFHI=; b=JwxMplWZArwNgHhG
	7YwqqaVar+OFSV9yZQ7GmB4TQbzkzFhxHkvUlxAukEX5ubywrM2W/zCUrDPiDBVZ
	ZQjURRXjGqLy2OA/woFn0hqMe5lkSGx/E4rFyOXVKDWAxDKakkXI6Ayudb+WHS4i
	CRxZGXU+V59+mnMp2KOKMcpA/KUWvqoXYgC99OmtE5p98gC/6U9/eiwpYtCzUaI7
	W30JH38KHtJuPNBbOe4dDK8pGt3qkC+UHwqGj03vjbGqgISAAa0CRR/L5hhaoYyp
	24R2kVECUe9DFNp9XGpAb8ici3m1UzerQ8A3Wjz7p9tbgRmnkWxKOc/Knx/TRyyP
	JQALAQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbewak3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 17:40:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-231d13ac4d4so19490795ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 10:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747417244; x=1748022044;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlubvvj+QDGnJHz9jHk3yA37ZHRIx4oKicrzEoPiFHI=;
        b=dDvKplQmR1u5dMNUD5g1p2HUB/xbk7RQyz36BSH/Y0uIXP9t/2OBb3GZlEG0ejgD/D
         wAC4l+y8UCFAAh3OeAAzn2Fn5GHcrHNr8WI0hsPnUJPhDGd7RAkLj3vzXx3xIUg2FQIu
         k/A1aCBS5l/1KS+GpzKNn87gG5YsWRD1s4kMTgNRd1CZBMwJII9n79l3yOnmpgh84YuF
         bNe/82e9H2vJpim4HQFriFtV5UBv7uYERG3rrwlIhbeoZ0q7qLx4JEfefOG96Oq7Ui7M
         59yGUXpvxL6jnufh60I16/rKTYR+ibwFlPEvomkpxspxbh9VR4xXJDcs+pTHMMklYHXQ
         zwmg==
X-Forwarded-Encrypted: i=1; AJvYcCWfFARZcxD1xrYfV8UVwbxfX2vzr8SdvaODpMtg+ROfKE2CLJmRMzp3c9iROk7pyjPgtQkE5PDptHlH05Knkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQvCaHZvomypKTNC5EFB1V0X6GKlDz+XsUPPWYvCcuu3BK/E/
	C3xPvB1K/BL6yDngxN92nrC+tfqvopUrL2EVggH7sTRu2TYLjOVl4LTvUO0oXBOCxFjYkwnfb1p
	Klnqm8fM9QKqTln0r4apJiGGKgfrGB6rwYN8b5/FLQHInZSkdJUCVcWkgbG1voq7Kq9OOHQ==
X-Gm-Gg: ASbGnctUQ9655yKf9TiMgkBTJq/ItaCUZ46uM2gBqTmVfclV2L4oC1G+WajeBR/FHR7
	AjQLgGKlu9fPv3rIWZWF0oz3BtrKaREv6oK5Z8TaFe0fwP8XsGwilkXaSjKJKLrC7794e5a1hmS
	MHH3AKf6KuhxA+MP5RjzzGGUbcCyzgSAqcz/tQhgq4Mt2N+3f6uZb1ypkiqsEh+AwYrVQlEuvhU
	x6l+8xUuadjtZZb5OfkSWfiLqij8pYdWJ3eeFgsjCvka3BlSueE3+uQwg2VeZ6RZku4L3/Ja8BE
	K+CXHPvK4F2jKmjL3weXadhl3t4esOvDt9LoYxHsh7lpl6AL
X-Received: by 2002:a17:903:2ec3:b0:231:d0dc:f2d4 with SMTP id d9443c01a7336-231d438b4efmr54555445ad.2.1747417244215;
        Fri, 16 May 2025 10:40:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnpX+C79lbNRgRAwyYYSWhQTaoTAtNOQBrn+O1L/WMYLap06IU/0tTdtq79z9bKxFd0l/g3w==
X-Received: by 2002:a17:903:2ec3:b0:231:d0dc:f2d4 with SMTP id d9443c01a7336-231d438b4efmr54555175ad.2.1747417243837;
        Fri, 16 May 2025 10:40:43 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ade573sm16994125ad.80.2025.05.16.10.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 10:40:42 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250417-fix_scan_vdev_handling-v3-0-9ec42513d26b@oss.qualcomm.com>
References: <20250417-fix_scan_vdev_handling-v3-0-9ec42513d26b@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v3 0/2] wifi: ath12k: handle scan vdev
 consistently
Message-Id: <174741724241.2935573.13251493111560682392.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 10:40:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: 691MctotuMZpsqZc3pm_pbVK03BUnpPX
X-Proofpoint-ORIG-GUID: 691MctotuMZpsqZc3pm_pbVK03BUnpPX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE3MiBTYWx0ZWRfX64MV5nJwjLOD
 894GrDB/5/v0rvcnx1x/l8ZYNdBkA21xLuclzJWMoNn4lLGA+jGeNBCBdPLD6lc51VAGu8aPFX8
 jdI1mKjjz5SCSEeQb2zbLqGAjrKKb9TgRa7lfg7a+8GGv9IRogMiWl8JQly/2SyE6MDuyqIlih4
 KGLgam8HGzaAVWYRINfdVLN33O2C70oYVzOgw6zPdtMQCbrGWvXDKrwiA+q/udUyu4YwDnkUF+v
 UdbEm8MdMp+7nSf8hKg15Ldb3ttqsi5IexVKq1abZ8JvL2N1qGyq6uI0MEA4onuTxu5b7HFE2kj
 9I+OjFREddbmrN88GaM2Oylsz+JItDQp0NpXvZPI5Zp7Y16KrefSEXKupIagha638rVifb7hgoj
 ih0eNtBq9WU9lVmg6vCz5tnZ2gFWmwv+ekbSSUkPYtlm/OqLed/zkqET+LWL52HUQTnSHE9k
X-Authority-Analysis: v=2.4 cv=LOFmQIW9 c=1 sm=1 tr=0 ts=6827789d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=VtwFg9zR_83gxYRZV04A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=865 impostorscore=0 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160172


On Thu, 17 Apr 2025 11:19:12 +0530, Aditya Kumar Singh wrote:
> This series of patches addresses the handling of scan links in the ath12k
> driver to improve consistency and functionality. The changes ensure that
> link ID 15 is correctly used for scan operations across both ML and non-ML
> interfaces. Additionally, the patches prevent scan failures by fetching
> link_conf only when the link ID is valid and setting appropriate default
> values for scan vdevs.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: handle scan link during vdev create
      commit: 8dc8340c197854bdd7aaa4a1b0f1a75646667596
[2/2] wifi: ath12k: Use scan link ID 15 for all scan operations
      commit: 88c3aaf46ce8878a8314b791b99b8d621f7badeb

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


