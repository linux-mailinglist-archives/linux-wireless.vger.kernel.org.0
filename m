Return-Path: <linux-wireless+bounces-25770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 377C9B0CCBA
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 23:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BE51C22A6E
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 21:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2C9242D71;
	Mon, 21 Jul 2025 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CkpBAkug"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12E9241CA3
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133824; cv=none; b=bG9mCHpar5cUoXCZIupqTV2aDB0V7HJ0cu4984GnNK8ilo9deQwWXP2n24MvzYTAnn4yrQ8lyNhW1wcUunUjaEoYG71hhfgysT8cnom0IXBgHxpB/b/pckT1BqfmnRBOqBcyamt4kwibLBdEhK4GTwTCyjP1L4XS9n70dXLG+oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133824; c=relaxed/simple;
	bh=pVYM2yyID1q0xIkylfHgS2f4H9eBnukEG0m3CcSdyo4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DXgX5w7uXFJLwkqO3LI7ShHl/4MOKmUzVNh5zO7s3eVnUeApngxyQZIsWBNVjk+YtQr2IndfasAPqXMA0f8DR6Nwbv/Mu1QLj0FUCX60bpRbcr3CYCkJgkoVFeKedxvFiufGWisZyGzkmMOUbnpM/Brfeb9GDjGfXQdWRwQU2Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CkpBAkug; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LGxVl7001178
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 21:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r63NxAvu5OQlg+2S4aOi2Tv2QOJTatjH1p+X5yIH4Xk=; b=CkpBAkugkBWBtaMd
	JbN4yui3KjUwp9bZc+j08xEy11zB6Py4ClmKHcg6Vgk6UjIVJUGOgE5oFOmPHLBh
	KzYEmPzFSWXo56X2TfCchlM0lXvx615tbjCF4GYthe8+amK8IhUsI8Uv1+cP8VvX
	Z4PN0ocaIp4QAgwYKdxQZow3Mb8L3XMyRxot7dPzHOBQsDWbnenc+UNo1Ujjf3XC
	a4kJjSqXdDnyds65grAIalfVQhVeld/Th6LVQT85ZE14mmyL9Nt0RZAeHBEK0ctV
	c1QlgZofQ5HxsQohNPr8D/WzQ0HDqmvgZz2eQ02og8G9PDXLewcqmMie1DKPnNLF
	Y42Zaw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044df5e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 21:37:00 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74928291bc3so3467405b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 14:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753133819; x=1753738619;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r63NxAvu5OQlg+2S4aOi2Tv2QOJTatjH1p+X5yIH4Xk=;
        b=Flf6YhG7d6X5k70Rv32jov1MhgKYBHVsY9/cDduwOY75GwweZ32oD1rUxs/GbWDJhJ
         sOfa+lg6x8DF7+slWtGqXpbbPd09l6vsKxeltObsJpVg41m+s/sErb7eBk9AMjEuDgF6
         6/ch0ZSh0sUZmUXe0bFP5Rf8WUK+RMWiCXmvDaY+iWAlGlho64gpFs7POP7Q9sZW/nXM
         plReNq6fiw4xmuVP6zw36vMziYAg7VgjqoDC5eFi2WRkz/4/WGN1U1lh0bf6nncT5i4u
         X+spa6STiPChpUbGCZDYSFQTNEeiZui8SIk1x6d3SG55/H034EVzPcDTQpUbwlcfY7/1
         3D7A==
X-Gm-Message-State: AOJu0Yw/IXq24ZdGEMiLKfqmbTGakTCa58YrDUBmHYf1U38j+FbGyTQB
	CJZUv9NGdKsBl5VjRss2Zaq2awvRUfj6oWn2TsNrmj1AACzx6Xwb0W3UI/QZrL0aY8K8bp9cEuh
	yLu4XMw3d2rhSAMREBXgnRwVXwdHt2MWzTyiojY9++aDSqdEdEH8JwhZCZ/rCQejFZwxYWA==
X-Gm-Gg: ASbGncvqExkzMXnsZa1Kowt9Jj+fM3SjDRbGE6a8QFF4DAUMOzv4tJrAvHuGeH9eqQ6
	1AhIQhml4ILZU5cMe6X9bgtwPsyop1l68sr0ZiM/30mHKBg3a0aClS5depAY7Xkfvi62Lr+zp25
	vFa9IjsXiDHrWF+6A6WZiwwbsddbWCmwQDqtwGlXVUF+BFk7vGSZdleW1Q5raN2mDwZdFVeP/bN
	gOaLRstjNLoZXnOIufjOOJZi0R/oBRcewUM4Y9LqgGyf7ksGl/2sZZNtCSqCXHWd5ezXeQYh4VB
	pQ9S8o6g6B6Sh6ExPaojrEPFyFWN0vHSOmEbqz6FrDRlHIpEaXMgpHAWJ9SIsl5HlPXEDBrgY3C
	/
X-Received: by 2002:a05:6a20:914c:b0:239:f85:b885 with SMTP id adf61e73a8af0-2390f85bf1bmr24817654637.17.1753133818957;
        Mon, 21 Jul 2025 14:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXX5Z6w7xxmYlkuSGuDhtVuyY901rFA/aeyB2IgnGsJVaNpVrBJt7tGe9mzLX4Y3pJUc2T8A==
X-Received: by 2002:a05:6a20:914c:b0:239:f85:b885 with SMTP id adf61e73a8af0-2390f85bf1bmr24817630637.17.1753133818557;
        Mon, 21 Jul 2025 14:36:58 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc68046sm6201934b3a.151.2025.07.21.14.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 14:36:58 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250720-ath10k-zero-brace-v1-1-c1ee818d6238@oss.qualcomm.com>
References: <20250720-ath10k-zero-brace-v1-1-c1ee818d6238@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath10k: Prefer {} to {0} in
 initializers
Message-Id: <175313381786.971667.1205072057690654219.b4-ty@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 14:36:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687eb2fc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=AJeZmiUk7byJ5J677osA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: IXfBFSydzVKH9ZVCzXZm6XYQpVDeHR_o
X-Proofpoint-ORIG-GUID: IXfBFSydzVKH9ZVCzXZm6XYQpVDeHR_o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE5MiBTYWx0ZWRfX1+xBf2pEW2Bz
 YhfHelBmX4Adal08SujSB3bCULI2QeH24Fk8TbIehVpjHNEWch1JG9m++Q+gt8SVYAQb7RULBhQ
 RI24MbHatming9uy4qC0m86uapVI4tAvrlalrUxXLD9NlzyCf4dAoLhO1KpLGhhn5NXlidzrghO
 Y7Kow1ymBngWwA5RGauYhYgInqRXP8IEa2HRCWzUg9fK2evFe7YNaVabT6c8IKPqM9RVFbVDP6T
 LDRQqAvLa+4VI3dib9C9SNY0id3U0DNUuwl3LqeGNfyGYylG3nophmGTskOKIIOX7/gMz5HUKWK
 8SPZ2EXOtgetYgZxQhnw1oSlILEKUEUMUI8FR2HfdQ7GuXBzpWQ1bYwTxcEwMLItcaqes6UGIUM
 4Yq4FBR7Lj8a+rVb/4trdwSsLSV829JNoxRpQ+M7DbWRcp+pOAS06siDIThnFlWKkqoEL0D/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=621 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210192


On Sun, 20 Jul 2025 07:46:15 -0700, Jeff Johnson wrote:
> Prefer {} to {0} in initializers since {} works even when the first
> member is not a scalar.
> 
> Generated using:
> sed -i 's/{[[:space:]]*0[[:space:]]*}/{}/g' drivers/net/wireless/ath/ath10k/*
> 
> Compile tested only.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: Prefer {} to {0} in initializers
      commit: f0b72d15265e877a02427e0062a72ade70ee6f86

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


