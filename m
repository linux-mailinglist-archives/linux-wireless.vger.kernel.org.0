Return-Path: <linux-wireless+bounces-23825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 536FDAD0E04
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 16:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805961891944
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E153B1F37C5;
	Sat,  7 Jun 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kgy1IkXr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A2B1DC9B0
	for <linux-wireless@vger.kernel.org>; Sat,  7 Jun 2025 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749307448; cv=none; b=n97kPVjNPOi075oKS995tOg1twXww86Y1RzZF6hXWtb62m+OikO63lBw6/Nyc/mIl1BCQKg3slCJPivzM6kf13TIByXj0xj5ygfeztXmukLNJyOwW2zZEfj6RTA+QQdmArbXkt5h9y0oGS03kANYKH5QvDJ3LhKMHTidyzlIhhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749307448; c=relaxed/simple;
	bh=LnaHXraGbIP/xhceE8DNIMIvDlTzfiBhctvEU2EuEOw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Py6/hAM4oeksvdaUtWIHADZgW/Mxvvoy01tf2SLrAlTcEDHjoqjGXWIn0+3Q1W524zQuNAvmxFbCp3yTcW8BjpfPiJGPK/PnjC+TSHokhHuNROV4QBfw2yAGyb070R6BbqDIzsL2QgKG8jVSo2tUw9TC/HSUhNonxWNKidkkGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kgy1IkXr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 557EVH6p020534
	for <linux-wireless@vger.kernel.org>; Sat, 7 Jun 2025 14:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AKP57LtvpN0o4j8981kkmloCcGjwLJ5jDT4OhefdPHE=; b=Kgy1IkXrftGxepmr
	uc0UArS5i4wrtrf5FZ3Sm/GsO5qk+5F09LCIaCgGbzM1ItDk12kBbnbVOOl/aoG9
	7492EBodHH5H9qU72eshDI7rYFh8C1oOMCzXBS7Hfko9C6NdD+mJGn8SchsiPyAQ
	hwdsQdW+VLrFkbdWX5sa3lGMsZBmlMNjvpfxcvvYTng3PTJB5dr9AWeyC+UkYBVz
	BzBE9kWKBg9CaF+i2OBtDDm9ExgWxzE/jEUW/E/kSyhM3QipAVUywAX0FToW33ZM
	q0QFLrep/xGkK9xm2yxMHC1r0Z7zeX/RWtMCrmj8loTI/03/F7Xy6Q7JSFMJP2m7
	4qAlPw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ekpgmtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 07 Jun 2025 14:44:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235196dfc50so26435105ad.1
        for <linux-wireless@vger.kernel.org>; Sat, 07 Jun 2025 07:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749307446; x=1749912246;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKP57LtvpN0o4j8981kkmloCcGjwLJ5jDT4OhefdPHE=;
        b=wqnEQi7uIC2ldpVa+hjxZxZQyZwrgIHm9MeMXDPbuQTvRnfLIgrHYTOcJhmMj0yW57
         8lL3xH0JoytrxXcmFxRQePzlOcyLlJcWmULu66Yic8L0TFKRopPVMeuweF/1PAGhqtVR
         g+mJN4X1u5rMm2UXnzmMDYaEgoutMCPeML9eAOKY3bagOgCUSOmKyT9YDsCHV/lwAhGM
         N26WmU9Ep6mNGFW/E2cXT/1C9vlrUWAVzAALXmr8K+Lj9ybK33M0tEvAmMq4jh2RDZId
         XIxINQoXCZL2Behl4EQFEzYcsDs+DvCuro7HEKP+NdFDIMysoXPY9YzFIXDlryYusTtu
         0a0g==
X-Forwarded-Encrypted: i=1; AJvYcCX7qZbzC8o+u0aiGQmsiu57j306FJc0v9Ie2dgIZqMpx37pV5eBOz1zFkg3aNX61opEoqYhYtLDNXE9IyqsvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzA9quNID7KZH05FR3XhVZxmeCFH5ckhIK61hwL6ZdL+zWrJ0e
	Us+/h0k1DmeUHuThNaQ7LizYiacRym8lvUtsoejs0e+uhZZjseMOhdzL+fChd2ImEfwd9Qn6fm9
	I/6Jxk2WQO70tIIZJwIGH3BL4SPaiLs/lnQxF09UPBxVYNSvaforYZDhV+xYEJPVbl7m3tA==
X-Gm-Gg: ASbGncvWj530IVJ2uBYB0eExfRoH0O/dVCiQLt3EYiiPdlPXskq/y1nx5G1R/uWKjwv
	GkSDwIbgEsri1owarKZhm+SkwiHKxbbAJCkdCIEsH/HL90pNdT27I+PLxLUYYdhXKhB2u7US1f1
	ZPBQWb9uvlqkX0dLc4l4fgqmjwlad77bKXfJkExnmAzAtWq8ddY9P4ccfx93Df3PLByC3ebdOAn
	939GsfxwxA51nasscazIlJDumV0i38TuywQ/87gjAkDvRqRZN+lqqgG0CBwyi/rtK9Nx4pWcsnm
	rZqSb+kZM8W2TDHfeBDxkmsYbg/6VYNUniPc1SFycwLn2yiY
X-Received: by 2002:a17:902:e890:b0:233:fd7b:5e0d with SMTP id d9443c01a7336-2360204e078mr98779185ad.5.1749307445911;
        Sat, 07 Jun 2025 07:44:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXJtHzI0iZsOHPoQDPNghXFBlVaVQi0Q2yp3wgPLwZoHZhFseuzZTHToiow1f1iVUEDMUQng==
X-Received: by 2002:a17:902:e890:b0:233:fd7b:5e0d with SMTP id d9443c01a7336-2360204e078mr98778935ad.5.1749307445571;
        Sat, 07 Jun 2025 07:44:05 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030969ebsm27626415ad.72.2025.06.07.07.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 07:44:04 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250604055250.1228501-1-miaoqing.pan@oss.qualcomm.com>
References: <20250604055250.1228501-1-miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: fix uaf in ath12k_core_init()
Message-Id: <174930744425.154748.15678214019639234293.b4-ty@oss.qualcomm.com>
Date: Sat, 07 Jun 2025 07:44:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=JcO8rVKV c=1 sm=1 tr=0 ts=68445036 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=SO4j_8h2HUBQMcU2vEcA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDEwNiBTYWx0ZWRfX9ykgutXZnckc
 buJ7SU3UVU7vVC4pnNJ4Y9xZHAfVXuuuwGXGOlX3Ml9Di2nRA459WPi5/FIa8FQANu5wAriwj2y
 3Yjs51z5eXWJsaQyxkfG9gbJ2/Z2XQI+1wYmc4L/vSqNC7boI8gZGx3Wq6kdDsyO0NLUKm67UWg
 6qGlt9hCWKh6J9kieLVbhOMTA4mvJlg+Ds/7yuB40/0IYWsEmgRj2rEBT3QtsHFB64i17nZeOIE
 mM6oH8B92/Cfi56WqOb8UFRjVhWzNJde9ZICWqF0qPx5MBlfGqZVX97Shri/pIaRYzqfPxaWq4h
 xK3NThpsa928BY1WKpL0FyUYTgqOH+dq8eh4sG/i4pJuWXsXxthWXPYLFbM7U5HWO47ZjsHdFVZ
 pqnCmt38TfVir+akdJ8RweFwIi1SaktYnkttPHdU/bb7E56g4d2+hpSyX5JvmA2kcwuTrjDb
X-Proofpoint-GUID: CUxfnt1GJUC-m7z8Ocv3Tx38ZX2FCVoX
X-Proofpoint-ORIG-GUID: CUxfnt1GJUC-m7z8Ocv3Tx38ZX2FCVoX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506070106


On Wed, 04 Jun 2025 13:52:50 +0800, Miaoqing Pan wrote:
> When the execution of ath12k_core_hw_group_assign() or
> ath12k_core_hw_group_create() fails, the registered notifier chain is not
> unregistered properly. Its memory is freed after rmmod, which may trigger
> to a use-after-free (UAF) issue if there is a subsequent access to this
> notifier chain.
> 
> Fixes the issue by calling ath12k_core_panic_notifier_unregister() in
> failure cases.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix uaf in ath12k_core_init()
      commit: f3fe49dbddd73f0155a8935af47cb63693069dbe

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


