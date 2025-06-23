Return-Path: <linux-wireless+bounces-24360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34126AE4776
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 16:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08BD16D668
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 14:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1B426B75C;
	Mon, 23 Jun 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NDOmiEuj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54122749E9
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690132; cv=none; b=SmQA+ReI0okyMSAnb5cp0mcHIRX5LV6Q0jcGa8tQI4jRZKl94peF29wki1BBzUQ4/Lii60kxQ2WvYrCv0cwKNuJyP4nGS2bpI3HsFT4js2AzBMCi4ILIzlqf9fLiDYePQ+LrN4V3czUo3JA2MknqLwYNdbYjbnGJtkbTeAf88vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690132; c=relaxed/simple;
	bh=DDOc8uZ+ooRGzsrFT2yDNhClGhHSAD5q4wDekg6A4tk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=unVzn+9xvN48lr7T4eAtk1e/I8htK6IByYKpRL/qDlYS4YWYmvGQQkuet2MBPkTTfsqCTyuTXmEhONuDgnhDYn34bAFhMOUZv7ZgHRP4D+J6dUXrhPEYaIQdJjJcUflgSI/WG/E7GfXpwzVCz4POIin5vbELTIKt3LUfEROh+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NDOmiEuj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N8LaBO005770
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bZTvShEFC4b3+8jhq/pLhvEl1j+I4GJln1yh/jFqMd8=; b=NDOmiEujLEJlm+jV
	nPQLPkIh2FFlXdgYivocvH5oIbD50XVwpmwavq/6jNOo3EmMC8q2/b7JSLWRwTDo
	eoe7KIhtAiJpxRSjAnMB4mfYXXhGvHJAKoDZFpwbw2svzW7MZy6pqWFXejVClcV6
	y843WQdQ6K9ivDvbOpYjoGr4gyle3RRpDA2omBTNHnuGW8/owF328R5N2zuaYUY5
	Glv0hPPwJWb2QrskxcsV8SxqhY+94+EzKbbKtCXzIAzfKLAKRPPPx3UPccc6M0i0
	vFF3ILiP1YQaJ1kM9CQRCIUmCS81GS/gJKCiOiyXpQOz3dakDNfc+tBz8HXtic5Q
	1PMJbg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bg92xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:49 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b0f807421c9so2818949a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 07:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690128; x=1751294928;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZTvShEFC4b3+8jhq/pLhvEl1j+I4GJln1yh/jFqMd8=;
        b=uKb0z1cLyyc5yKPgu3+bTk3vSM6dRbD7VLOR6qZKBH4XgbPr8PepiyBLe8tdcAx0aJ
         trqFcc5OOg/QlSITPfPYVFBscb099z+zIU5kxvwcqgKMVDpO3ohNI/y13fmbyXo6/iC9
         L9oZGjCNpEy5oaZLMFdqA+d41x7hqNpigewXt62U0mHcKqVMuFUnJ/zK4ccN8pTOd9PZ
         J5bq669kyG06UJZLBVO/ltLN1JOBWNTHZ+TZjQO5iOjzf2w179tclIKQRra6Xlxesy1W
         gcGrClmN/30mKxT2L6Q1BQwkj5lnR/fxAbTaJYEJepmBMTTElUfJnM3X7LZRxT5eu5tM
         XPSQ==
X-Gm-Message-State: AOJu0YyZqFBdNbREojboyi/gUDbrdVAEIuTSuv7VDqAoUDA2jCkkn11+
	Zt2iehY4Jwq+Nn/GYgCTR9RpMN3K676zL3KSeXSDinVvcoArHNgpvHCkkYGU0mUqf43dIhuONFH
	xn4TDmRXscWXdxPh1I6X3KaRKfbGqpwPcJj7X1J7pZs6cvJqC9VpkDqNoZZEwy3wbpVkFgw==
X-Gm-Gg: ASbGncvVdWO2CzdWUGyd7xk9yKtCPKxtt1LADJml/vp/Ldaz2tqYs+X1OJOrhmeULAf
	dT+hT5q2MznpAnUGZSju6qd7fuCEavhRekBdoRoIdBLmdI93Q/2HEOFLepFiRDU3SvbE7DSUr+U
	DJEVs6Fz755XyHjbCSz5qyGAye0pR33yQG91pFjZmNZKf8SUT79xNkFW5mLoRkflQCA0dPoWJG2
	2KGbVSdNAIQzwY/M9KRSHHD6TQ+/PMZbAPOTBXZjW8me34aJOMIJaEQl850AQbWlkR4d3sSRIFR
	HJtm1tyU7GUAy4E/An96DI56zDi9DHki2ZDZ11Rgb1CVa02QoSF4Z01vmYk=
X-Received: by 2002:a05:6a20:728a:b0:21f:74b5:e8cf with SMTP id adf61e73a8af0-22026e47ac5mr20602351637.25.1750690128257;
        Mon, 23 Jun 2025 07:48:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHhT/7HTLqOoGddSf9WDDsTxORjqJ/SfHm0+ETtMJ1rsYsqMcKPrqpqZxFiopZf4JOj4k/SA==
X-Received: by 2002:a05:6a20:728a:b0:21f:74b5:e8cf with SMTP id adf61e73a8af0-22026e47ac5mr20602309637.25.1750690127859;
        Mon, 23 Jun 2025 07:48:47 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6d1eccsm8332894b3a.180.2025.06.23.07.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:48:47 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org
In-Reply-To: <20250611-ath-unused-export-v1-0-c36819df7e7b@oss.qualcomm.com>
References: <20250611-ath-unused-export-v1-0-c36819df7e7b@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/5] wifi: ath: Add missing includes of
 export.h
Message-Id: <175069012683.3758471.9698383719451711198.b4-ty@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 07:48:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: fumbWxWbJqoQw3OKV9iXeEZVBbaRsqJe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4OCBTYWx0ZWRfXxh3pLoiDGJYx
 L3FxuAQTTyg4s5fMNf6xXJVPRMblAWtvX48ZHhrS66UsvXozuDHOZp5aWZueTFXqMXGWAbF74Ig
 9lGbkLFDfsvDK1L64sqOhXQBD3FtN4pmzK/EKOqR/qKK/YEExP9MLYVhaeBJEgKWcNq6FKXvcfF
 Iuu48nPhQ/TxwdGUukN+0X0Hvpee/UhK2bjwrTxkAwgPIcoIiGfklrsN2amQ4J5N+OF7BOX+e6/
 LStbVl2eJutEWE1mO/pHAcYB3EpYR7H0fh3GGsa8kpLFHANK7SW7bWq4IcHECKmFHWQFi1IcW7Q
 bR5mva+yD8FDm+0+4f/Jhcfnnjhw8sbKH17RWnU14gww9xkeK6TxucAnDHPDEr8Wd/uyQBV1Etl
 L3T1rUm2ek96UVBLgvLvi27uMzvhDUqsWlQZHJXYVfRp8IGWH+8EQ+7XUQIZ4r5C3kV5Se6V
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=68596951 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=1ICI1GVrwY_GNP6_Nl0A:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: fumbWxWbJqoQw3OKV9iXeEZVBbaRsqJe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=657 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506230088


On Wed, 11 Jun 2025 09:13:53 -0700, Jeff Johnson wrote:
> commit a934a57a42f6 ("scripts/misc-check: check missing #include
> <linux/export.h> when W=1") added a check which is now generating
> warnings. Fix the ones in drivers/net/wireless/ath/...
> 

Applied, thanks!

[1/5] wifi: ath: Add missing include of export.h
      commit: 3abe2740e50f86401aa3518e9b69c6abefaa020a
[2/5] wifi: ath9k: Add missing include of export.h
      commit: e435827f6d0c4ace62cc9dfed5e337fa4549994a
[3/5] wifi: ath10k: Add missing include of export.h
      commit: 32c3a0f8894311c743b2a6a15b50b13d01411ce1
[4/5] wifi: ath11k: Add missing include of export.h
      commit: f204e0377efeb5f42c7c518febf82f4af32567f0
[5/5] wifi: ath12k: Add missing include of export.h
      commit: c19c24c3b9e2c4d656472738f67ffc68a9b85cb0

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


