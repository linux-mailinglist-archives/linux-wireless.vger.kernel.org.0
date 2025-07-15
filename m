Return-Path: <linux-wireless+bounces-25493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 318C9B0644D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 18:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3851AA09E2
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 16:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E712827FD6E;
	Tue, 15 Jul 2025 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OxC6Der0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33927C162
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596653; cv=none; b=HcOa7UeJH/tGnXyCVnJbQFTukrWSh66yect389rOwJS1Gu89/5KC8Rf9M4Sw25J+Bkzhiv9NjYMW63VrrxlIoHnqdmH2uTTVKFS6ISQPEph580X4CaX4/RPb5StpYOVjhAApNAlXm0T8uFAO48DuCHxuaZpsq7dvNLhl7BBcqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596653; c=relaxed/simple;
	bh=3BRrrCD1sfNXTBrrgpO73lYmUnWtjUBqxWg1ohTTyJk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LjKoKdSB9GcVAiU6s8KD6qlVn85R/YYMZ1PlOtiRK87VQfeofkNEkltfDEbWq9W1FAKMdhTfvJTA5nb/6ND2W7IabpMqPbelyUUUWQZMXb7pzB/AlzYCOz5rL4NRNkWaCxqY/dtWDXJLzBMwOeH8+Qr9u2IS+NmLqQfPLkFbNgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OxC6Der0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDFKv024588
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 16:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e4fSFHObIUj3YUKeRKs7ynYBdg6+3bGvb9S+7Q7qNEM=; b=OxC6Der0QTFQA2E0
	hDU5SdcIHXWjz9J1IxwPR7cozgiyTrxVc4MPBN1oW5QISypXZYhOWUK0jTDDE7ZE
	L+FxSkEkdcxQBb2CPcXnpy1U/xceVqh/+u0O1HEqKE+Y2vduPZ0fovxoQBJDP//y
	BCozYSDumwSnKMG6QpUXQWh2U9FZHrewSwye4l6hRw9/6YlcH8dw/S1OUXqEErE/
	Fe4fnc2IXChxEkOrWsDQ0caN8FW8k/aws4WZ4v5YZmrM+GrzC5I35M/8kGfcSnk5
	vgTqhHA11xychrQ5sWJvCiodSiE+k/FlRuFQ5EocKaPatUki/qOYvRGIvoIBoPkQ
	jnsKfw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpbu4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 16:24:11 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74b4d2f67d5so4683059b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 09:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752596650; x=1753201450;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4fSFHObIUj3YUKeRKs7ynYBdg6+3bGvb9S+7Q7qNEM=;
        b=Z+R1OMNiL7TwEOa2yZVnjV8pMNGL8UJXi8QpKw1SDtx24D3Wvv1YcWvHW2NsJjcGFS
         R0xSqCNnRTqgw2G1wuURRR/Ye+d+TkFQRyVNMTteyq38xTaIkM28UIq7R4ccvVC40UYE
         +b9DExJOfFuCtMZTY+F1ePb66kEAroj/PmyTFLi+M22yLD5Ou6BBUlwaCh3FfMerAfnd
         JWyHTSH/wmzv2zWwfYoR2K/ECrxIRHVuzPRNyAamQT4JhY3NqkLHf60CWwTs6z00z4ZC
         jbytvaBynmamxTRh0QPRF3TKG92Lknd/46KnIQDXJSuXUko5B4spa9kLeUROLnMK2xxk
         MGVw==
X-Forwarded-Encrypted: i=1; AJvYcCXF7H8W9BLTzdazhxyFx5jK7HqEFzT2M7T7bzafqLHupl3lAZSHUfkaHhVmp2NtcEiL8mWQgjvtdxtC8Kxa4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCxac80bLTfAYuIZTbhljxQAfnlpfYoXTL5QshFm0M0Pj8tjn9
	yv/zdvGNw2DEEBLryaTXCOwbzGGEdGShsjevC1ucRJI7dtl2f+zmivnnE7Xh7EwS++IElIxqDN1
	fUjNe5U2zL/W7y9YqusgKhjPdh2CR/SThVIe78AMKI2U+Sr+Mf/ySJB4PMQDTipC7M0U3fwCJTM
	jwyw==
X-Gm-Gg: ASbGncttX7VHLxV6nXHPAbBKEhe00os2Mv33kGAfXMKfxHeern6Wj8H11Rgl7WSE5eR
	94l4ej3A//dU3tlEFDTSFyYyERmkrQxnmRk2TcJF3mbbPnB6+SXuOYwEHRwAjxBVVdz839oKBzf
	vr1+M68lHuJo9t3s/GahUkZhXv/e3OplhpIkFEnCYfjGBET66fTrzWlrrndszlWhgpZcOUptGjc
	d4cjgM5ffXZloYPV0h4QPJ+fAPFxnwH0aRo6luig6dH3BannEU0mpLkn1iJB829wwk6eB3Cj1yU
	3TQYXpu6J7j+pUlqwrMl0ZHEw57EuESSymY15fcZSXQhQ3nYD+pErbiYE+MvoxyFDzufuuImZaF
	l
X-Received: by 2002:a05:6a00:b90:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-74ee2c51089mr27047198b3a.11.1752596650278;
        Tue, 15 Jul 2025 09:24:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEODAHKCVBUNHeifRvUwFCvNewJnsVyb7ieobPeB9FXo2Bsu8LjYS3fLHbakYwxdlvD59V3fA==
X-Received: by 2002:a05:6a00:b90:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-74ee2c51089mr27047153b3a.11.1752596649673;
        Tue, 15 Jul 2025 09:24:09 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b715sm12815373b3a.93.2025.07.15.09.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 09:24:08 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jiri Slaby <jirislaby@kernel.org>, Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250715121721.266713-3-rongqianfeng@vivo.com>
References: <20250715121721.266713-1-rongqianfeng@vivo.com>
 <20250715121721.266713-3-rongqianfeng@vivo.com>
Subject: Re: [PATCH v2 2/7] wifi: ath5k: Use max() to improve code
Message-Id: <175259664810.3448282.1721666863713781747.b4-ty@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 09:24:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1MCBTYWx0ZWRfX5AJQ9LIkbRnv
 Xp80LTxpNzuwx5f0JmvwQTYrxtmrH1Zi15bHa7KzFlYJI/p64V1ZmQK+CVclvrHq2TvirEdpBNj
 RcMxZbPa4BuJPHLMkuyebxy2EqSsi93HK+rEeUoHMp7ppnMfLzv59JX6JXrTik0GG31//qcvNJO
 n0NS/g89X4kAVGnjwrEZZGdtJtwMUY/LmiR4pYvN+s5CYG03cni2ggY5usahK2lLm8btAMstX4p
 SwJm/o4A1402uXxHvJddxi0UzQIyQ8YgjfqXAUHeSl6JNYDqhdAwHc5SF6fQuDzAYQRl131hhGq
 /3AvrlpCq3LtyuRLUBjr6V9ogfQMJj2IOKqgAS7/4ctp7b0HyhcxeU3UoByO4YyJnqH2CWpcjR7
 Lj/W6E0dYtzJdb7leee84aiRMmrh2Xq50qTM6wORZy9J/xV07LnBu/cMRBZzrq9uA3jvVJhu
X-Proofpoint-GUID: NTxJzLLcJ0qWaRkC0RTCVKQc1jdjoa-t
X-Proofpoint-ORIG-GUID: NTxJzLLcJ0qWaRkC0RTCVKQc1jdjoa-t
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=687680ab cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=798 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150150


On Tue, 15 Jul 2025 20:16:48 +0800, Qianfeng Rong wrote:
> Use max() to reduce the code and improve its readability.
> 
> 

Applied, thanks!

[2/7] wifi: ath5k: Use max() to improve code
      commit: 5dceb7dc745c755d61e01ae4d214a800025044fd

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


