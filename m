Return-Path: <linux-wireless+bounces-20803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0520A7045E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 15:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50C83AA2CA
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 14:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABE925B681;
	Tue, 25 Mar 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ReNQKVdu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AF825A631
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914628; cv=none; b=rjY+/hts4kA31X0SxLmn6CuIREcaAGdOJ+gc67ScJio0Bb4Fser0XtXdMYKsdThrS5W/fLZB3iG+XkNOGZyoy66cJRXzL+owcztDAHRcrT72A2tgF2BibnSybAQ98V8cS90kt9+kQddV5Ta7Q0C0Uc7U64p/ZBuRKag1vejXrCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914628; c=relaxed/simple;
	bh=EqMHws/gJIm5pVARMKymR3sSEres33GBEqhPYnNv//c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J3Uasf/uWohinZAQeX3iOS0/r5YsGPfgVeDdMAcyuH37+LiGSDNk3nOF+Vlnj0sEjVWhIzU9c+9NXDkh0Ree+R1q1bWBsRqLk0vS72+ctsWPLPo7t0Ee7dH7Vvhx9aF3BALQv4gKS+dnDR5TNxbun4sCbaHcSIsT5Z291EgphM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ReNQKVdu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PDGF6S018746
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 14:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sccn61YffIOVf72k4v7cFNWsntpRWvOgplQHMkBT7eM=; b=ReNQKVduuIUpZqLx
	tIM1mdfFCPIkc+uPYpJylxYNUpfvedxkEyeVXODjtpRqqYT9DpIoQmg6zUgfIvDq
	2YJvsoqhnFwtwh8q20wbWKvzdRx02VxSgWBI7z3NPzlXQKwQdXUGkmfAzxz0VdmB
	T/GhVNmu/jeecuDNgskQk3AV4dhdxaH5+zAF6D+h3D/G3NStdljouh+7H4zUEwVr
	5wGOB31/m068MseWzpv8qP/FSEgVHsiTBuzSdClfscomGv6d/l/bR7rncTWIZ8n5
	185LmyxTH8q2bpU2YkxF6cpCr/9fL3R3S3YyyEy7KnJrZ92fJvnHivKLr8Zf3o69
	h+uyWg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hjjnrgf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 14:57:05 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so15157442a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 07:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742914623; x=1743519423;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sccn61YffIOVf72k4v7cFNWsntpRWvOgplQHMkBT7eM=;
        b=PoBcwwYB05sAmJ7+TeGTcllM0VbsWGZKXmGRgvFrJUqmFYlDW8usENjL//jaSP0pNp
         jdazMnUeWS31sEX3ROPUy/ReJo0AI9K2QdX2o5SQjnJRZh9hEjrSVf7UhasXvG5LMLfk
         CkZ8IAicCL/u026VUNUPSUiDKpl1ZgQ/egulyZvbAXe11Cl++1NaXCU964qdPDz2u3Wz
         w/jBWbXuMm8+iWQ9SyEGKtaQkUUyQq4CG/eVce2k7X7ueUVh58bszaqb8J1J6c4eF0al
         giIaY6W3XMRVkkF9LsdLLtIuCJx7mu6pGMpQsEOkkGORqKMOhTCglBfb79EhCDw0CDfT
         Rt/w==
X-Gm-Message-State: AOJu0YyC229KfW8vuUcclf+b9okEh3kmjfcKOgzB8G0lH1iLQjR6Dgui
	c32DH+E7+HF4dZbZ4SB5e0KyuuTAojQqy1/8gKzetnGfFBfDxS+oUQOOctDbWRMtsS7tILwVTDv
	7yPjy+n7sxHGTT/CL3notqbi5xXJ0a42dYdmyaiCVG2O2oj5uAh9gNSZ4daxr8t9szg==
X-Gm-Gg: ASbGncvvU9fI9Lcxkt8x1x3gBTUOZK9ownjlNvnkc046eaPxHxQ6fexPEg0QAGH88fX
	MD2GK9nxwtuO21r+s4AnZzPJtS2gOHElT8bjTt2GCwKHpEMNZy6ZKc8Fo8ibbcg9aG4Ysqkfxin
	U7PeDy2RMC/McmltrDZ7eGDF2aFluZRSx0VxiUaq91th0Pn/Z51Ru+wtw6e4DWy2hC0SvcEAJdQ
	1tP6go6Rjy3GvlLqir5XOUvKRUrLeI2M+uudj58oaKy4V6VSGPfAHySnc0w8NekoPYTuXif9/30
	TkVCHkOdtjSHzE2prlyq477qaHxePF7HcFNDGJ/cVKnlY/n+tg00
X-Received: by 2002:a17:90b:4f8b:b0:2fe:b8b9:5aa6 with SMTP id 98e67ed59e1d1-30310021a17mr25929465a91.31.1742914623301;
        Tue, 25 Mar 2025 07:57:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuMFcW5Mc6PLB2e9P1WD+ArFqapEY7WYWu/v0VV2vjM3az7z7rxhMWP+snHjYJQ+Oca0tXQA==
X-Received: by 2002:a17:90b:4f8b:b0:2fe:b8b9:5aa6 with SMTP id 98e67ed59e1d1-30310021a17mr25929413a91.31.1742914622771;
        Tue, 25 Mar 2025 07:57:02 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61a73fsm14496467a91.36.2025.03.25.07.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:57:02 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Balamurugan S <quic_bselvara@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
In-Reply-To: <20250321-ath12k-ahb-v12-0-bb389ed76ae5@quicinc.com>
References: <20250321-ath12k-ahb-v12-0-bb389ed76ae5@quicinc.com>
Subject: Re: [PATCH ath-next v12 00/13] wifi: ath12k: add Ath12k AHB driver
 support for IPQ5332
Message-Id: <174291462168.1228728.13742084811292852249.b4-ty@oss.qualcomm.com>
Date: Tue, 25 Mar 2025 07:57:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=fNc53Yae c=1 sm=1 tr=0 ts=67e2c441 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=3RKYKuViV1jtgHVlbD4A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: TLAUEVbECKM0rXD2U10H7WPFGphjjT9f
X-Proofpoint-GUID: TLAUEVbECKM0rXD2U10H7WPFGphjjT9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxlogscore=912 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250105


On Fri, 21 Mar 2025 16:22:37 +0530, Raj Kumar Bhagat wrote:
> Currently, Ath12k driver only supports WiFi devices that are based on
> PCI bus. New Ath12k device IPQ5332 is based on AHB bus. Hence, add
> Ath12k AHB support for IPQ5332.
> 
> IPQ5332 is IEEE802.11be 2 GHz 2x2 Wifi device. To bring-up IPQ5332
> device:
> - Add hardware parameters for IPQ5332.
> - CE register address space in IPQ5332 is separate from WCSS register
>   space. Hence, add logic to remap CE register address.
> - Add support for fixed QMI firmware memory for IPQ5332.
> - Support userPD handling for WCSS secure PIL driver to enable ath12k
>   AHB support.
> 
> [...]

Applied, thanks!

[01/13] dt-bindings: net: wireless: describe the ath12k AHB module for IPQ5332
        commit: 94fcd39ca255758335ace05f70365f2126190ee0
[02/13] wifi: ath12k: fix incorrect CE addresses
        commit: 60031d9c3589c7983fd1deb4a4c0bebf0929890e
[03/13] wifi: ath12k: refactor ath12k_hw_regs structure
        commit: 5257324583e32fd5bd6bbb6c82b4f5880b842f99
[04/13] wifi: ath12k: add ath12k_hw_params for IPQ5332
        commit: 5fa2fab69f59da8eaf9cbb53fd89727c750b14cf
[05/13] wifi: ath12k: avoid m3 firmware download in AHB device IPQ5332
        commit: 11794f8540043c230ec4bf57ee1227e765ab52ab
[06/13] wifi: ath12k: Add hw_params to remap CE register space for IPQ5332
        commit: 12070392be0b39d5305a235401d3ff9f03fdba13
[07/13] wifi: ath12k: add support for fixed QMI firmware memory
        commit: 6757079c5890f7168a9bc111b2345209f05ae278
[08/13] wifi: ath12k: add AHB driver support for IPQ5332
        commit: 6cee30f0da751284662affaa0d7fc567cdd65f48
[09/13] wifi: ath12k: Power up root PD
        commit: 10a355ba6238e13d196be2f226a59f7886d7b5bd
[10/13] wifi: ath12k: Register various userPD interrupts and save SMEM entries
        commit: f73e089745a000b6eb99457f71b47dc862ab221a
[11/13] wifi: ath12k: Power up userPD
        commit: c01d5cc9b9fe2673885db738ec8d2e01de169b92
[12/13] wifi: ath12k: Power down userPD
        commit: 881edc164071c2da3504b72fdc08ca8f1b915fdb
[13/13] wifi: ath12k: enable ath12k AHB support
        commit: c0dd3f4f70918cbcdd8da611811036a91b7dce33

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


