Return-Path: <linux-wireless+bounces-25771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC83EB0CCBF
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 23:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B311C22AC8
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 21:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A7724467B;
	Mon, 21 Jul 2025 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k8WmnVEi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE2A24290D
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133824; cv=none; b=PrwRLOKPFAmvywrJGQeqjxKotg6Ix3jwqso8FU7YDIGwyrURXBKvu3gSbT8fXGSjETfDClyvdHH6HwHz0GvEzdiMKz47XmwxFqAZNGZlZ2360vBXklGOentMnHOZ+345DViwfEwuHW2CN9xjtTad6pqi6oMbdmnD53ZlEooeA5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133824; c=relaxed/simple;
	bh=6/8sh9FIRrN/onOMmrd57UvJNPhDQ5MWjmDf9Xwi6AE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mjgu7u3AybBAmKlXBvSARtpjbS8JJIryfOOn++p/kuhSWj69TZ24z/2UdZUY+wlFQYW9iEllyj8gCI6MKuxiUlmzN/TU/qFBOVkiT2GXLBJLRlW28LfvtutHaI2ZQjSg6Mh+yTIu+0vARkNdSl2A0FyjTS7huVgpvjnUI/pAxa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k8WmnVEi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LIfrJv008073
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 21:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lPcgGzbA0KUdErOP1JgC40238+925SiPcxECv0Z461I=; b=k8WmnVEi3w/vwsXW
	PwPEk9Ty1pJh8wC6vP4mGm9uNQ75iYArLUuF1I68umdLkyEEgzmEcFO+wLtSn8FV
	hbylqOYIabCi6xOU+s0M1z8Jdk1YoTNIkpAstVwmija5sjaOjtefEJDNAm5INhK7
	NNbdTkY3dQ4m2g73kRgy1dwqkE/G5IL8T4UDgWUmMhIisdHyFH7kVouUW4n3EUYF
	NTSUc0yGoAIS5PLSHzbxY6ggRUOxZuaF9iC7GIsob2EuCVW+/4eWxefUvJAcYHrc
	bBbJV34B0coeeFvaD6t/Hmad5xueBCevf4Bj7/cWE468cSVqO5yxe/6gd5ESXidT
	BnYZwA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045vwjy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 21:37:01 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b31f4a9f67cso5342210a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 14:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753133820; x=1753738620;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPcgGzbA0KUdErOP1JgC40238+925SiPcxECv0Z461I=;
        b=q6pBZF9qtrTuJCDUbu/9rivzl7qZfm+rDw0GjI/JEMVNExlDuO29l1pcYokmnt1TLo
         c0gm4mwZzgSViuC4/Zs7d1xfqWyM3XgYlOLR/o67DGUpxeCn/oVgh33AveFMlMYR6Yz9
         NvYZFALwSs9nGXAakKv6wjI6i55HiKdTHYbbUqxXbjP6Z0OYJ5fZ6/VJJsVXLPSYsyL4
         SGkRcThGrhwo/jlpuw/un0dKzA06Gt9r6iYy/OTwQXOm3WIha6Hcl1xAfie9LYJ+BYDi
         c20ZsGM5TeXUT10Y4tS0us0Iy3xzFevyYrihX7Dfhw/Li7+i7xzdsIvPFBEdslzOVqUS
         bJnA==
X-Gm-Message-State: AOJu0YylcrSR/3oYPEsC52mKz92huqQC5qGXmaxiVEXaY/Ulls/P+hVN
	EEV43Bo4pAetYgQnHSBBqEUvHRA0wp9tIvJVRlQ54LUBsaa/719uu/97921fcjohj4uxN2IhetF
	iFqokIsILFUPFBKhmQRb4JSkwFMC9jy8fLjbWIYm8jqRq/hk2HsYMYn9ZSGB68Y0BsmnwOw==
X-Gm-Gg: ASbGncuSfoObyfVcRNyDPi0ZiuUjl7/7jCJjAPYLZKMs7KRkqvLHZE8YS74XYCLG7eZ
	eM/MLKGY9VWW9QziUOwJeYIc2YSQt8K+IKkcBaPyf8glh/RZeTwBgyIueXJZioWz2ppg1BKiC2Y
	S+V8FPQNSco/jUDA85N8sSYU97Tu200KLIBjWRl9SgToItwJBoAbdPHv11rIZXRlpUhXUJ7c23M
	2Tk1QFHRxNKjwOBTSeLCwdTTit0IzZ8H6zesbIr66eof2I0b+EsEDTvbUdT0JT30x/N8WnhlrKx
	TC+wwNnvy/WWPeLtvLKKf1cUiIaPNzVVrlbyNtF9W7VMZTzntIC0fHzq3QGbrers0sKLkFl+hrp
	F
X-Received: by 2002:a05:6a20:9190:b0:235:d440:ae6d with SMTP id adf61e73a8af0-2381325b204mr32639339637.32.1753133820580;
        Mon, 21 Jul 2025 14:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELTqLiRg4xv5sYJl9vyevXPnhafiBzP9GM1aTX2FGfEeKB47zqZOfLEblRRt8Uo61FjlipPg==
X-Received: by 2002:a05:6a20:9190:b0:235:d440:ae6d with SMTP id adf61e73a8af0-2381325b204mr32639319637.32.1753133820183;
        Mon, 21 Jul 2025 14:37:00 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc68046sm6201934b3a.151.2025.07.21.14.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 14:36:59 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250720-ath12k-zero-brace-v1-1-d8c8ca9d40a8@oss.qualcomm.com>
References: <20250720-ath12k-zero-brace-v1-1-d8c8ca9d40a8@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Prefer {} to {0} in
 initializers
Message-Id: <175313381950.971667.2781590137376114302.b4-ty@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 14:36:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=687eb2fd cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ezxbitWhmWwidbw5SqwA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: vGEc_WFA2JKTEKVqalJD9uCxE7wO1gws
X-Proofpoint-ORIG-GUID: vGEc_WFA2JKTEKVqalJD9uCxE7wO1gws
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE5MiBTYWx0ZWRfX1URRizWTYmWa
 uS8f3+TQNPTOaHSJ6c89SgTZVrIBSNYGjPhFHzswZRinB45atuiUBaNzenaOCYRaKzo5sVs8tke
 mw/+KECsdsyU9P4sElu84AcIARPFR30t0pZgd8E64iiWOqCeSeIqWqvFAvoYKRgC8Z5H2u4AnYE
 wSRGC48C1yY5//0SMCxEtofEjh/XROPuBJF2xwWDlHR4rGHWF651lK05mHGSxvPF6NeYRWVe5/u
 cllCpp6bPmMNfwUXKOMP35rcMCutwWUYtg+PjbGKPDYvV85W4sAi3Ly3qDA55xpF5F9QMM9suMR
 n23CGgEfHiHbG6v+r63WBOM5DEWgSKz2zZWvnZvpPzXWoyJw765ybvOiL03VY4to/fMtR52F148
 vdlLAWP2fIb2IaScZCe7C4hWB9gBaBDtvfpv1WD+4iMz5ksURFi79tATTbvfH6mraD/1XX+w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=621 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210192


On Sun, 20 Jul 2025 08:24:14 -0700, Jeff Johnson wrote:
> Prefer {} to {0} in initializers since {} works even when the first
> member is not a scalar.
> 
> Generated using:
> sed -i 's/{[[:space:]]*0[[:space:]]*}/{}/g' drivers/net/wireless/ath/ath12k/*
> 
> Compile tested only.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Prefer {} to {0} in initializers
      commit: 306facc029ba8d217ef5a46e8cf4bd50c70603d0

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


