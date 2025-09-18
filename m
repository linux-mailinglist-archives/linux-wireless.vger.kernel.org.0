Return-Path: <linux-wireless+bounces-27499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108A9B8767F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 01:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDADB171B54
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 23:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E854D2F99A5;
	Thu, 18 Sep 2025 23:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EJ01flzC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7204B2F3C37
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239249; cv=none; b=AxTpV/B60BfXsPsL8Wi9CvRuI2/6ntG3Up2usQet5cwCUx5zUD1Q6oho9p3uUqW9R4zwtzel3YQFhO8SgC0GyEgoa+lbKxCguqNbBTrpwM4vbPJbt4oRFPn7YCIUhuOd16MGEtymaYyEbsWaf5I5Mu1AS5d/Ac/XiISlFIv+qPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239249; c=relaxed/simple;
	bh=ZtBQlEYE2IpLPBeAXjIankcZ9vAoUAI2Fx4glxQeQrg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S/eXuvtcX9FQ5fY43qs5ssl+MZ7KAfsWXzOhy8u98tZ3AS8M94onwMXM8s7tmXF0/JnJb/GYrQqxdUV8xl+op23tQW9c1fh1nj1s++3OVXgQKiGUZ1aS6U4CgPHdYZ6UnG91agjhM07Kht2yTDCVeQM9o/BHSekq8JoS0RnxTCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EJ01flzC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFA2CU007297
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DWQsi9VmAY5hiqVKebmic+3ASrWfi4KXkGubaITn6fM=; b=EJ01flzCwkFtMRZK
	T/RYwcGfQh7mf8XXddL0Ui0VcOZz2A6flttG5M7XQbCwjYNGmdBMK63qKLAvnowG
	AYDOSC4X8F+SnZBDp8eL1GBkozGVZqG1UzVQoe/U5YKYE0CMHYDxkSYP2mWPCife
	0lQv5Gjv7kVzbyV9gy2kxQywJd0GQu432WTzTPrMBWdTZS28FI0Y9EVbJgq3rFQL
	lL00fHz6EZuDpLilei9elg++fCHtsyykO2niHyB1kXtvkGe3oXahPU+wQiWOBHYP
	A8UC62HJEnJCthXzU5wRLl5cbKyET4MD8aE5PwbU+0T17BfzBSjWMq3OWM/19PTe
	KqdWZg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498ebetwfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-268141f759aso15257815ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239247; x=1758844047;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWQsi9VmAY5hiqVKebmic+3ASrWfi4KXkGubaITn6fM=;
        b=joy3ntY5MB6ilHcgMobBDTxS+eH2mjJyUhGB5c8yBEC1DmbB663JQ125stxta8uHpH
         BbSc0FdYh/fEuIsCeWuL1c77tspIlkuZlSIuuMvzWE78W1XPM2iY/NoLnkwuCreGMCBU
         KRalsfmhlLXPBGuo4mo4nhO94+5JmGH3WCp2F7Lf8aOCMtTjVWwPh0agO8/AyQJVklzK
         FfnNUIS+f052grtvSNghcDjHttxKRdFCjWxem9zxPYrghE30R532bYpADf7YAeG89izO
         Ed+NRvMDWo9Him+wnV/3VJC6SZqLl0G+2YekRVWehLXrlULKubBoITIvmvXjqEPakRuw
         MFKg==
X-Forwarded-Encrypted: i=1; AJvYcCVYPNGxsypsW75AszRcdKrWFhxVI0wbMLQTZ0S45l3cEdtw2Z4xaXDuXzMPRRbX0cpSs3f8/v9GybAcO2gIIA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/C1MKzGVsYAQUnJQdOVBsUQdXLHkyAJU9Yg50zMlhMnFTCm/W
	BmKrP2eqHlwzbXZ0JrZYl4jZhUcNp1YfFFrB56zY88nL59zx5n+FMrXl6OaNr7AJpB5ayJgCj3b
	z9XSLxKhe6Pvxc+Iynsq1JtciYZ6q4hivazFU2FamU3lw7mlN08NviNKjioW/LhzQuWRCyg==
X-Gm-Gg: ASbGncv8+W3aOEd86y9YSiUjxfQ0my3whwD9ZFNIbO7jWq5CdQmEmG4/QGO6WILyTAl
	FU8PKyTMM7b3MCxvk0EFZR6R3esOH4Ycqt8dEOfw+O6YbaAb4o0yCOW/7xxT6rtaoGm0I8TFJiA
	1euVCyx/J4mYZFZuKwdIqVyphdR6r7CqIspYdRMRpqcuY7/6jPC4c82u+uUL5bYjhrY8TEgUbWq
	IC1xFvGQlnJaG5SPjOTyt6a5puhpeHGXc6cSlISYb357mrZzsgxr+Vy1BCx/y21Sa/K9rGgheKd
	O8NqrZXhLOVeBtxAxs3+2uxIAl5Iu2Utt4T6fxRjjuNH5FBRQyaxRiz2YOFLBD+r9TflQXi9JLL
	i
X-Received: by 2002:a17:902:ccc9:b0:267:b2fc:8a2 with SMTP id d9443c01a7336-269ba46f141mr18837385ad.23.1758239246986;
        Thu, 18 Sep 2025 16:47:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGUIIqhflA5H84k2bWq7ZhzyXkWqR8j08pCl2uE7f7Dhq9Ex2ocDiHIw+vHMRY0ZZmX+EKrQ==
X-Received: by 2002:a17:902:ccc9:b0:267:b2fc:8a2 with SMTP id d9443c01a7336-269ba46f141mr18837115ad.23.1758239246537;
        Thu, 18 Sep 2025 16:47:26 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:25 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        Jeff Johnson <jjohnson@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250808151822.536879-17-arnd@kernel.org>
References: <20250808151822.536879-1-arnd@kernel.org>
 <20250808151822.536879-17-arnd@kernel.org>
Subject: Re: [PATCH 16/21] ath10k: remove gpio number assignment
Message-Id: <175823924545.3217488.14660135878915431565.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:25 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: ZE5bTndBUzsFinmWgkrT87b7R352eh3-
X-Authority-Analysis: v=2.4 cv=H6/bw/Yi c=1 sm=1 tr=0 ts=68cc9a0f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=0JjSHZ6I5lEitlysoQ8A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: ZE5bTndBUzsFinmWgkrT87b7R352eh3-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA3NCBTYWx0ZWRfX+b/SXm3jAnK4
 k3MwwnAVkjJxEHdwTgqDczZm0vjTF/T+lYsxX7pN5l/8apQ2GHpS++reTK11015m1vCnk+JB/TA
 3e54IwQybp6C0US2hS+IQy8eohOOhUXOuFfRyBiRNymjkEbdDJIwg8pmp1isRIyN9yxLANXibbX
 mD55XscCkpdk8fa5ZQhvoIEcApSZcMvJsOur16VLcqGgUQh5vfeH2xTbM7kwil44oqRHq6wbRor
 WJ+fAVegrDWavRSw1etkmfkgCGInaHhupIlqvKOno/KgrnrMpUPA3rPbM5VACvJj0381KRejcuC
 BFIt3M5J6NX5hRpclU+MSj/Gxs/2KCQBxPsMiZcsI4nmnxFhF07F9s0Y1GejIBJRbKFjLcGX1SP
 SyunFtVT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180074


On Fri, 08 Aug 2025 17:18:00 +0200, Arnd Bergmann wrote:
> The leds-gpio traditionally takes a global gpio number in its platform
> data, but the number assigned here is not actually such a number but
> only meant to be used internally to this driver.
> 
> As part of the kernel-wide cleanup of the old gpiolib interfaces, the
> 'gpio' number field is going away, so to keep ath10k building, move
> the assignment into a private structure instead.
> 
> [...]

Applied, thanks!

[16/21] ath10k: remove gpio number assignment
        commit: 5b345471752701ccfcfa6e86e15d2cebc6e17343

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


