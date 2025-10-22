Return-Path: <linux-wireless+bounces-28178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E01BFCE80
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 17:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA9294E6CC0
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 15:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3A4274669;
	Wed, 22 Oct 2025 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lrf6gYQH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A792749C4
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147214; cv=none; b=e6DhUsM+b45prybuMTvru5GwPWuTvxMpQFPDPXAxiajuQqNk0Zs7+m4P8m9lq9uMLpGBVWx1q27MvV7M51ZqhBgahlM2YkR36sLFZvaBDEKtRHhb/YsBIWaa8E6+FLQ04lFCM7dUMbnBGTIUKrtcgTLqeQgQqnQ1O5V9jBYuB8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147214; c=relaxed/simple;
	bh=fIJT2UPCKDwxnFopxZyo86T9qyxmEYhbqtZ574iEZ9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FEG1Cmpe5FFh5TZ/LM0vBhlZEYqzBsGd/G8NpcnrR/wURM2AxwkwE+5r2ATxFp4OHPJqaPc85xce75ms8WLaUK35WFsCEp9etXBcW1Hi5nAkKrNINjwiEhVMr6Y93mpPJYYAqlTnco17fceKjU1wlOIhTT8OId0RFk2Yj+VJWhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lrf6gYQH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MBwVKd030208
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 15:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uPO+5ZAHamuKpqqW2/tdbIcyYFMs/w8rT5Hidhv6oKM=; b=lrf6gYQHCQAi2BID
	JmDEh0qwu1jcWu3t3pikSpPehuxsF+0lUsqCzhmtWHzr/KPQJhBcKzGzQeBGHO6f
	J1fOLGrVk9kwhZ0unCUK8NfBmj27mRcbUOjH4dzfFzL5Nff9L2ziFL6bFDBV1AXV
	CYHzbMoJyEEsV+apH/LZSe1ZZsfauZqg07afAxsKlJIRKMnZhElHmmAGqUKUppCS
	T2JaIXcCyJt2L0wmA3u1oF1DTy2AC3p9PwyAwhYNURc08InaDOkMikq5ysHDKz7t
	ZEPZyhlAnEOei5PNa7CHiiCRj8osASL/Ump8w/VaqiOysI1loOJGNKgRnxRqghXU
	4WJnTg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge557a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 15:33:31 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-798920399a6so1067356b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 08:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761147210; x=1761752010;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPO+5ZAHamuKpqqW2/tdbIcyYFMs/w8rT5Hidhv6oKM=;
        b=xSyoU5w/JYGlUshyKlewCrTH7gbjF5u/gnxjWIC+34b/qY4clYiG+7tAj85gsMiKVX
         lTpV3kgIVcIFtnVOb/D30x6+gC8ygJzkdv+BeunGUUNVi4qtU/ecSDJp7Ry0VcHcj8Pd
         3GGUprkPS7JJ7nHKhL+3m+EzMKp3mUntTLStl3eTLTQaojMIMwbmMYah5UxBzWfVbGLJ
         J0dAu988pYdCVEDrHv7IcSanp30PDBRCWTsCDLryHun+BEIYiEu50wT3MmHiPRbdHs6l
         8AYzJwyS1GEKSFWZP28K2VJH4kPf7Ian2WFQRTBgMLVjmWrgoOpRcUc+jb5VsXNnY3E1
         5RNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU8O/KuHpbHVBLzCRY+H99kweBQHa+ZJC/DcvnKRSGMGpFsxnXpSOFBgRq8qi7/jgw85NY0cS/nwK2f7JBmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2npZJplAZDIO4mWx5Oi6Ya9GrSo1cggha7UmwwuRjDpMIP7VE
	QpB6pW4RyLbOXq2RvRUc9GKeu/hjCtO7RRfINGX0+EIl7sviex9xhXkJZDRXhqyo6E514+Xxdhi
	NP41Pzhk1XPIxJxaT7TUPQDptaKv4qBe3Lh7dWiigMPsw+xmJC5x9HDhY67AY2zOWhq+paJcwqx
	mgtg==
X-Gm-Gg: ASbGncuryuzbndB+L6HDWz7mlDBdzXDKqo4ST2qBipaPvrMgS7RZxgFj3qB1ulTZUZA
	phZY/UO+CY8w1YkWFnz6HDyPYWrIU+ye1SLwkRSg6wIQzYoj/bqKh/n10j3VSqClIFDig3ig7kx
	K3OczDBfvGil3A695ibNL2z0fr0tFcTvlGKEhMR2DsmF0qTWrXGLBw3h8W37HIt4fxMTqFp5T9f
	zDw2Lg/7XVUzne2gJ1DJDMmD8OxdRLPgCMUZ3tmr0vZW1pLmCxAKOa8+ij1TTLHd5WUki4vAYth
	Vk4pITwy4JNH18AkPJesI8+JIAo6/r7GpNQx1g2GSsfDwSvsAmQGoeHZS2nF48o/36oSyf65WRb
	b+D7sYAyPmY2rF8a2LGYtryIAaGW50QsQibs=
X-Received: by 2002:a05:6a20:918c:b0:334:8dd2:8372 with SMTP id adf61e73a8af0-33b684d0d35mr2913257637.3.1761147210318;
        Wed, 22 Oct 2025 08:33:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhnUYXmpiGBzo98XdERRsQOMLcEtfJFyd6TXCoDRow6qZGinPXLkS3DXGRJAh4zEywkF2EGA==
X-Received: by 2002:a05:6a20:918c:b0:334:8dd2:8372 with SMTP id adf61e73a8af0-33b684d0d35mr2913203637.3.1761147209734;
        Wed, 22 Oct 2025 08:33:29 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf0443b2fsm571552a12.30.2025.10.22.08.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:33:29 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20251020153759.407516-1-loic.poulain@oss.qualcomm.com>
References: <20251020153759.407516-1-loic.poulain@oss.qualcomm.com>
Subject: Re: [PATCH v2] wifi: ath10k: Support for FTM TLV test commands
Message-Id: <176114720901.606027.2235262810066845660.b4-ty@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 08:33:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX+CPG3BV5Elg9
 rmZ3NrusMCZzUQ+jgRGIGcVagJYswPBRKOuIB5wMVukeADc1sCXJsfZUj/3jKO8CRmn2NRy9hby
 uSRub/CPCq4lwQ0qPIsV1cT63l/n/xQU6V7rws7GCsuLsQCKWJ64R5ITTTl7eVfM3FkGzO2YAgB
 XgL253SrlO+1r7/goyqKZcZ5XVO7L9Ogc/od3ahoya0S0671eD0BcBgPOZQtJ2hMZqXAiQqLE+t
 76wnRTbLTKak/pHDtad4bg1Q4Jp0zrmu9hAPkkNiZDXjZPZF5Jl51rahYniYzNSYtU9Q3g/SRK4
 z3f3U5zSBHg4oN4/ljaoWan7yYvXfOngwkNEO2yhHPidvPKE8urclYwdGpHirP5swySdG9n5X1E
 zDhZmB4pDh9P66qRiGBwiT4dA+KCPA==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f8f94b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=CvSNZa8qkPPy6F7HHe4A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: MkAIvtGy5yS3UmFj0UsSubsPDVzfsjeA
X-Proofpoint-ORIG-GUID: MkAIvtGy5yS3UmFj0UsSubsPDVzfsjeA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020


On Mon, 20 Oct 2025 17:37:59 +0200, Loic Poulain wrote:
> Existing tools like myftm use 'legacy' test command API. Similarly
> to ath11k and ath12k, we want to support raw TLV payload submitted
> from the test tool. This requires segmenting the TLV payload and
> encapsulating it within a WMI command. The opposite operation needs
> to be done upon corresponding event receiving.
> 
> Tested-on: WCN3990 hw1.0 WLAN.HL.3.3.7.c2-00931-QCAHLSWMTPLZ-1
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: Support for FTM TLV test commands
      commit: 54be197109762d2a3c2b23d44e960ce7a43a3798

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


