Return-Path: <linux-wireless+bounces-18773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 039E7A31005
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 16:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F631889415
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 15:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF10253B4D;
	Tue, 11 Feb 2025 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NnJt7UhX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB3253359
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288677; cv=none; b=QtwjMK7kCXYCsRODpdY1EdZTjjAwqavcTz4i5OBTO8tovW5AGJOIBz7uDmwHOvPaPrIQ+M8n3vMbR2XxDSxW1XBqQPTwK30vpqDrGCGABiWlja2lKmjCjD77wVXtvADv11kJxXmJDsaUcg4RA/XD08o1X439qF0+aKTLXlGmT2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288677; c=relaxed/simple;
	bh=qV5O2NGP3BWpNHPH8xbRrQP/DrvokATccqoStAn5w5M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZReVBKw0z4YATqBxrszorViMJ1//68rDpNLrJWmpyhN/Hi+AdhHAudGguKxcOnhdkYAHPEK+HvXrhh4VGWeEfUY5GE/fsnska0M8nG/CjLPIhUiVLPkCW3cZikScLGAlxflB9IIVJhnlBw16f8dwn1fZKg+GW49Hv5lPGDuaH/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NnJt7UhX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BBHjMr026076
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lD32Vez99AdokPW/YoVLXROqua1GtCDpnPCVoxnwEo8=; b=NnJt7UhXQpcAthVN
	FTjbyS7ajMw8Wq2CQ3RCpGKSdauNVmGPe4qHSY1zMFQpSmWgSrmg+uOpS1abLkmd
	dHmcyPmE7Joqd8llO/0wkH4qq2fhSg4JUSe5LaaossSsuFPPuUfixYLmmevHtN0H
	tp4vzYledVu7roOLjTr+7ki0DGgyrs6gmI7R8aiEzBxCHbc6A+7+iEDxopmn8Rlp
	qOBRYL2kUQ3AnJS2OMwZQ5PhzvK1hcsprIQGyE0SMPgGH8qQ3lezOaCf8TMjMS72
	kms1CTsBMaGJYxClZerYw9MloCHkTbC28o87FpVeud7CE8bisV4D1gaXH8mUvERk
	OlKIeA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44r5j58s35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21a7cbe3b56so82725525ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 07:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739288673; x=1739893473;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lD32Vez99AdokPW/YoVLXROqua1GtCDpnPCVoxnwEo8=;
        b=nlzUbQ0+p1tek0wiWUBcHkrQ2GnjAo1xyH+sPAiSASahs16JUdxXzENREvCGJdkx1m
         T5Fu8rClDS0OcBCoobuhLm52HJqjehEu8WS/rlpsnvdZHbdjCA3pnhtLxaSnUj/DWJ7r
         i55wmrpg+hHC/c0BtHcu8dpNfbk1DtLqS2n8Zhh2Jbq2EaRz2doC15DvD0I3VsNpczrO
         YHE0hgr/AqYxFFqWlxenc3H6yTistR90/3Wp4PLlvZRf++KOZK563sDrw5qH5sJ8A8Jy
         Gv7uKozAqHc2mJBv1wnQ7evHLJTsnYvnfe+hiwcao8Afm/VxcMq3oDbXxhLoJBWNFJs7
         L1iw==
X-Gm-Message-State: AOJu0Ywr4rGpQz6k6/noP21k3wOxWiZ5MEMFalxvVWn3xKjgIWm3qi/Y
	6xKpdY6rDLnv9tT00Ez1dv2I187S8hGQc79Bnl7+UAmoPnPCvWkDJGuV/DaldIC0CqQ8ahxfeBb
	S3OGngQ+b68VFp7xaNihiyG3kVPFh9vW+DTtEowPJ/18SXgY5zs7iiklnAuTgY1Pf+w==
X-Gm-Gg: ASbGncvM5K1NkTHH+9ZmV7huLTn5inkdEkQ9VoYjMOlr27eA9Nd74wED7Mlj5uJIils
	63Qf6W49Dn1eAy1ZhLoyvTH14AjBCXIXBLNZ/wvVL7a35VEulOBPdg0jy6cuj5S8JzkguVytLiA
	f5ZcubxwCfCuPMpsnBuijERnKSIFIWIDG0xZETKe6gzQ2QNsPfTmGH6+T5X5GDcy5h4CN87dF2E
	Y422U+Ev1FGKuKjGvItfs6A2l9MZ/U9hHvALBjjD7wgrlQqrvk2vQzJIBGl0OgYANRSDtsdlM1i
	Q+LLTzGgmS1qJK57z//VPDzntGdHhaaUQunjkRGyBg==
X-Received: by 2002:a17:902:ccce:b0:215:8847:435c with SMTP id d9443c01a7336-21fb641c3cfmr68159535ad.12.1739288673369;
        Tue, 11 Feb 2025 07:44:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0Rp33ZF73xQSbNXUiw0TVhhlTiStmftw3Y7UxoUwMIn50Icg+IhiWjlPkwoU1LVeJIBcd4g==
X-Received: by 2002:a17:902:ccce:b0:215:8847:435c with SMTP id d9443c01a7336-21fb641c3cfmr68159185ad.12.1739288672974;
        Tue, 11 Feb 2025 07:44:32 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36510e34sm98399365ad.28.2025.02.11.07.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 07:44:32 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250206013854.174765-1-quic_periyasa@quicinc.com>
References: <20250206013854.174765-1-quic_periyasa@quicinc.com>
Subject: Re: [PATCH v9 0/9] wifi: ath12k: Add peer extended Rx statistics
 debugfs support
Message-Id: <173928867196.1115150.379592814481494848.b4-ty@oss.qualcomm.com>
Date: Tue, 11 Feb 2025 07:44:31 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: 3DeNsTTpoGgwRA55gqyCjbBzn11s9Bd0
X-Proofpoint-GUID: 3DeNsTTpoGgwRA55gqyCjbBzn11s9Bd0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=932 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110104


On Thu, 06 Feb 2025 07:08:45 +0530, Karthikeyan Periyasamy wrote:
> Currently, peer extended Rx statistics are not supported. Peer extended Rx
> statistics are collected form the TLV data reported in the monitor status
> Rx path. Therefore, add support for TLV tag parser handling and debugfs
> to configure and dump the collected information. Additionally, this series
> does not impact the WCN7850.
> 
> v9:
>  - updated the s-o-b as a last tag
> v8:
>  - Resend due to missed patches
> v7:
>  - Rebased on ToT
> v6:
>  wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
>  wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
>  wifi: ath12k: Add HAL_RX_PPDU_START_USER_INFO TLV parsing support
>   - modified the return type as void
> v5:
>  Removed the patch "wifi: ath12k: Add EHT rate statistics support" since it
>  is already merged
> v4:
>  wifi: ath12k: Add peer extended Rx statistics debugfs support
>   - fixed the kernel test robot noticed build errors
> v3:
>  wifi: ath12k: Add peer extended Rx statistics debugfs support
>   - avoid ext_rx_stats filter overwrite in default filter setting
> v2:
>  wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
>  wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
>   - fixed the length calculation in the EHT radiotap procedure
> 
> [...]

Applied, thanks!

[1/9] wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
      commit: a5f3c2b89136f13f18ea64fc1144691ca771b98b
[2/9] wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
      commit: f756f878692f688640f6994a4dacd98665a2bc2f
[3/9] wifi: ath12k: Add HAL_RX_PPDU_START_USER_INFO TLV parsing support
      commit: e6fa62bada8796d13f04e2538297b81decc1e335
[4/9] wifi: ath12k: Add HAL_PHYRX_OTHER_RECEIVE_INFO TLV parsing support
      commit: d939919a36f4606fb8312c502a53c0ecfbd85b2d
[5/9] wifi: ath12k: Update the peer id in PPDU end user stats TLV
      commit: 0cded0e413468183a3b2dd445ab3bdc4d4375967
[6/9] wifi: ath12k: fix the ampdu id fetch in the HAL_RX_MPDU_START TLV
      commit: dff4f278ee1ef12d822b7ed2a1048d27037209bb
[7/9] wifi: ath12k: Add EHT MCS support in Extended Rx statistics
      commit: 03ac9e9144c59dcfaeb213f80e7e00974325045a
[8/9] wifi: ath12k: Refactor the format of peer rate table information
      commit: 98677080467c2a6529a3288f430acb8c44f583a0
[9/9] wifi: ath12k: Add peer extended Rx statistics debugfs support
      commit: a412547f2a8bfcf6337691b6d498536f29dbf4b5

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


