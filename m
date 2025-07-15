Return-Path: <linux-wireless+bounces-25492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC279B06445
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 18:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF445015B0
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 16:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E596927A46E;
	Tue, 15 Jul 2025 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vt3ZOzzj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643AA27991C
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596651; cv=none; b=HVwXBVDGpcyXJa2jpbVVfG2qGVjD49PfeBLJB0LVpe8crw76JZf83o1N0v+ThmDvvBiI0ir946e87Y3eLVVlsMgDtpjrfuGtjcw3RzzjB/nhwEU6DCZ2cOBAzotGypNY9YUTSbFHqBTAYMF7EV0hxOmsljJt1/HNq8YPcc/JqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596651; c=relaxed/simple;
	bh=84Zhq5Fa8DZxPg54htCnAi1mVCakbKrde37JUedCE2U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eNBFZhYlCVt7/9QItOLU1I2kf/TKZkjvg2S1bamFqL16rbMWJrQaUL6dbAupvMEVW3ohjiJ2mnZrm6GfugIqnWmHNPhmRmfQOYCpbUJeGVv02a91g2e69mLJllKVeGq8IaW2STT1+okjbtCtdNqXazUdskqpvN7X1KfbcUyKAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vt3ZOzzj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDOgW014502
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 16:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mk/I29S/oFEoqtLU3bTKX52ZMG1AMTJAoA9iVUvagVw=; b=Vt3ZOzzjjI9YESZF
	9kwbCMW2PbIlu7UHN+CuiykqkVaIenmbMbM1OEMnEO92Z8+yJxCK4Eo9YFthFKqu
	oeULqdP8JstMaGvtMN5EaOE/m4Rzrj555UQ/YiLYhvFjXc6Q5azUOQt1+T/lQPTG
	DzqvmcuSlv1Mtw2vrkKD9bVV+8eIwgZJvNmXFwtfPyQ/6gksiwJUTm+HOXTPLqVl
	gP/BTTY6V9BJRUwuSZ5CYXw0RTq8UZ/2AkUs4VVwzMWWtjbi/CJ8MkkC2T2dgZea
	NF5X+xXCFtyEV5GXE6E+5uM1XgtmvppIIW+6cWLsQsX4o+L8UbSKSM/OlaDvKxne
	QvbolA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dyktad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 16:24:09 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74d15d90cdbso4741601b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 09:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752596648; x=1753201448;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mk/I29S/oFEoqtLU3bTKX52ZMG1AMTJAoA9iVUvagVw=;
        b=DRvTpQTKSZQmy1s/JZ8CbDNISsexUMMZosr3mAFUNU+dj/yetACFDA9YEgLrmaLutH
         Culs1LTr8c/0AFVGBtDZdaRWPE1Q8Ub02cgb2Ehhc9XbXoIan8R2iWGZe1DJG44nP40S
         gqB9XCCtNvujdNri66hTl2W3d+0p/xyz6epBOAe8yQY6TfCMGRw/iTY3pI43DFLLHi9u
         4dG7zMTHcwHVvyc5l6edVmgq8WCFVWP7F0uM74ZZWNjZTLty2yQ2eG+WicYlB/r0lf6v
         dkHi7XWFxLrykBP5uz5FfA/GTb2Qz+QPWzfJ3EwTg0KTjHnYg1VcuR5yRf4PrjZ8ll3n
         nqLg==
X-Gm-Message-State: AOJu0YztWkXkWKiaWEm0i5ECkfKMiOaemHMQ2ZJuh7xXvnKCWir7d200
	B+NyuHVRIGL1lywVdxm43OE47uUpFvlasjFN/ooQgb5rLHGKw7gAdbSIn3hbklA+gvUVHjMMmgJ
	OIUbIKSATVUvxXYTzuuZcN6+oaz4KMvwcPJmnyWZgESrSAzUu/UcNnVy+0YAWPah2++IQpQ==
X-Gm-Gg: ASbGncvMFv2T2lxXMwH6Rcjvd6w0aFaQxxQzfJUXmzQ+9WXVkxbGhVKIZqkB0yVXVyJ
	mGz7RJiYjhMdnsLLGVVDVJdlFQfh+raeAsv2jrJXVjKVf30tYLlH1BB2BGnhZGjArHIRhA14w4x
	PxXE1+7KGVAVEAJMW7q7d3qP4V4p0XFTQd4lqcRpjfng58YP9hUNNbdxGXziHvtsUuWjT8hqKMz
	Rz4ZVdZK3d0MFeRl4h73nGdpY0ttRGjM2nm0/HXlXkKHEIy3K37WTQnmH/LzqXCuflAPKmUilXb
	4pV4BQqcR4Q/YOHlEJRrjzWlxljvy+bMR0OEH0khqtyzN0lSWyQzFt6yVNRA0RmD61d+fExmXRl
	Z
X-Received: by 2002:a05:6a00:2d0f:b0:748:9d26:bb0a with SMTP id d2e1a72fcca58-74ee274ca3amr23360041b3a.18.1752596648475;
        Tue, 15 Jul 2025 09:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO5K/Ti2kibTcVezSPr/Btb6+QkxnAHpHBFdUk6OSkSLttpdbpfSEnYCz3S+XnOjsEPhkUyQ==
X-Received: by 2002:a05:6a00:2d0f:b0:748:9d26:bb0a with SMTP id d2e1a72fcca58-74ee274ca3amr23360011b3a.18.1752596647922;
        Tue, 15 Jul 2025 09:24:07 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b715sm12815373b3a.93.2025.07.15.09.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 09:24:06 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20250715-ath12k-unneed-semicolon-v1-1-9972fd4cef07@oss.qualcomm.com>
References: <20250715-ath12k-unneed-semicolon-v1-1-9972fd4cef07@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: remove unneeded semicolon in
 ath12k_mac_parse_tx_pwr_env()
Message-Id: <175259664635.3448282.2749790548342441986.b4-ty@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 09:24:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: c365DoldNJTafx3hegWj3PRPYwhGYXCx
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=687680a9 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=J17AwlqV-Ij9UdG5oKoA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1MCBTYWx0ZWRfXy9DfSEdMjLQ0
 y09Qpq1lFLV5HPXpmJaaH0WLfbqncb7dZ/bYHP6bKXgRIsOmSBAB3w3KoGsUVNZp5365W2j5MsR
 Vy+X0wgPVxq3wmgXB8niScAx4MJXkTsF1h2s+0IhJmEq0vdwEkL+7qLKdTRgvPEw19YCrMXDqp6
 YVQNITxToYHL+/93XmsnyAZewvJlXJw4u8l5jL784RmtC81yxNaodan5mNUcuv9SrCDSjsC0bsV
 p3l48hltVteUNWzh+JZMFYXrYHl/6fQOvEyMD/haNvXLoR0HYDppD2mUWKV6H2MKhIMQHecqRup
 mmyhvaZG32EXwwl1dsY6jE1LNLVi4BaCTUJebW8IDB/Lld+JUf/sYyN7OQ9hybla19bxhs7O2aJ
 WPQlj9dhxYEbTesf9+sY1UwDaSWGXU0w3+fzk33Bybx9eEli9PWWszSlyFNAdz320QEODD/1
X-Proofpoint-GUID: c365DoldNJTafx3hegWj3PRPYwhGYXCx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=854
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150150


On Tue, 15 Jul 2025 10:07:35 +0800, Baochen Qiang wrote:
> Kernel bot warns about this unneeded semicolon:
> 
> 	drivers/net/wireless/ath/ath12k/mac.c:9785:2-3: Unneeded semicolon
> 
> Remove it.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: remove unneeded semicolon in ath12k_mac_parse_tx_pwr_env()
      commit: 8ac2a383d4ce9e6229494c2a36df876800e6750e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


