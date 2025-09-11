Return-Path: <linux-wireless+bounces-27244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE54BB53552
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 16:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74C927A4045
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 14:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6533C20B7ED;
	Thu, 11 Sep 2025 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hMbJ+CfE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938771DF271
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601040; cv=none; b=sg3NmzTw/b1ZbFTy1K5xLglxQ9jpFejjSS0ULGYb++yf823jsrSXWByX/saXZCHe3DdRR+fEk+WOhtFLhFjkPVShyjpbxMKy2clZfAeb6wSZhCdqMxEn0SauGG0TWru+euCov03slDSGtX/9wygEhF/6hfvWvM41Jvlpr3uBLIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601040; c=relaxed/simple;
	bh=ALtThqhCHNK/VlhuJY+48d095zbLSSuGI9YVz8bRcxo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UBbj7AtILnhlvMSEXPcLUunKcqMF5dQXDdXO1q4qbdU1xCsH62zA1L9s9FGdAHpZiM9n448zABfifA5PWophSwcfdnNBG1bC7MWKV6uky1dBPqVg6FslI53W+wlZFVRGaJleJsU5LSU08s3tiaq/vYZTgfEz/AUofeuKh+9ATZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hMbJ+CfE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BBBdtE008248
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 14:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	917gDTnBHU88iGLp167tmwoiOYooMYFMtFjF2sGtBjA=; b=hMbJ+CfEQDEyxtbk
	vw3luaubDoRkwzVRT5XFrI12Y1ij1sTmrGJneE20DMuacPTWWx7IEn6vRnSy0OUb
	ZghRieUYu/oaRgpWl51gAYaKAeS2+PtoZS3pxcDId6DyXzyoG13+ce75EriXrDto
	229dguJOEhs8kGayZfCW5kdnmF//DlVt9cpunlZ+wJK3tBjOS58aDjnwDronznD0
	b5RgO/tFGDnhxfvFHOC+nKke94Ob14wwCfbikOEgBYBHrumLJh0/otCJPpqvM1zZ
	eF6Bag6bCnX85DUvidAuynLSkxxv66cuygbhVvnLXd2/uytY6tO99tF83xUpTBJr
	aUNzSQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aaprbju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 14:30:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-25c1dba8d26so9100595ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 07:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757601036; x=1758205836;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=917gDTnBHU88iGLp167tmwoiOYooMYFMtFjF2sGtBjA=;
        b=RKiSO7/SkkPrlHzkxsDBplB52OZ9TYKP/tjj3hwiAiAKrpod7v8Nn68Y0z9TXupG/I
         6Qwc/WKT/m2zQ26VKwSfyFaOdctiafS8VQmC3A9fChvAx5r+vHqy5zCAwzCA7GydPsSE
         UvtXRr9Gxa04SiLPXv9y0L8mdSCnxN/lkJQeYiTLII7hob4UxpvYRH6TxWQEsZqXPzsw
         jEqRsVqNQ773EouDE8wdVRh8uQ4X0E7/PUQjBVP4Qf2DX9q7tmhjSO3R/6n1CtUIGWPy
         zZDzaCgMg9Wjr1pZNon5i+qQ8uQvow6fNM3oZEHnDNt2oqfGznuG+X0tC6t3l8bIcvGa
         SEBw==
X-Gm-Message-State: AOJu0YxSpt+aZtct3dzpF3UjQ/8v6OlZYlBJIgx/W3wZf8z60QUQbf5R
	rhfrIrh2G+KV38Tbh6MzHhTN+RoK+upTHYG6Y8ltKSj1fG6hYiPKtflYz9xiLMSF6wiHTc70fyd
	wtrLNSrqqZZR0eLL1YY/sEf3Y4LxgNQbDSvIhx8da+zgvsGu1HR+nScuvurF1nCJlXNnuhg==
X-Gm-Gg: ASbGncsXB9bxu8KvWb+cF3TQcAdfsMAu7uHPsE5/TWfopOvQQdLe/oOOdI5lvDQBaXA
	X+rl39z9Y0Tm6Iqebev33lJvchrcbQtKtzNd1kmEssQgIERESMs8DLv6HVbY15YkwHgCfwKJbYK
	B0tBjP+40Tto4POpymh50SLUg/YIpIQPWm6cvJZNqPt34VjFvRFK5zKLyY2d1E5uHkmoTzLO58/
	k+2DmtDOJJWXMbr7ut6OYYrzKAfEwgb4lnksJVex1ria/Xiniu25vpl9EAtNGhDoXUlYR34XbRJ
	Q72q4BeZEkBpVtqzuUeLvUFla3uJi/USaTEbELc5MLBygPgbqTnE8qjY+z6P4OSeeS3xmWYi0ql
	U
X-Received: by 2002:a17:902:d54a:b0:24f:b709:b672 with SMTP id d9443c01a7336-2516da06c7cmr283722335ad.19.1757601035805;
        Thu, 11 Sep 2025 07:30:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzbzBqCoOLdeU7wClgVCgXMwMsiKCXRcckprY9oDdGDKKA9FGzvR3OnY9fmZAmhbzB8iBZ6A==
X-Received: by 2002:a17:902:d54a:b0:24f:b709:b672 with SMTP id d9443c01a7336-2516da06c7cmr283721845ad.19.1757601035101;
        Thu, 11 Sep 2025 07:30:35 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a80asm21429295ad.90.2025.09.11.07.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 07:30:34 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Ripan Deuri <quic_rdeuri@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250910181414.2062280-1-quic_rdeuri@quicinc.com>
References: <20250910181414.2062280-1-quic_rdeuri@quicinc.com>
Subject: Re: [PATCH ath12k-ng v2 0/8] wifi: ath12k: Improve hal APIs usage
 in rx path
Message-Id: <175760103448.2463901.17905370001690741334.b4-ty@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 07:30:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68c2dd0d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=TeeMK1CGbMXA9tsS81oA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 0yAabyAI5MSC-OWJM64D1V3D8TJVaMvo
X-Proofpoint-ORIG-GUID: 0yAabyAI5MSC-OWJM64D1V3D8TJVaMvo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX9Wou9EYsjXkT
 Qd+pkSis4qG9b3I03La2VIipEC3eTjlCbLCBdY2Itk03023ddGWsq5RDf4yzVDxuw1JW31lwg05
 REtj/jqHWQ3XntM4CexQsaQ6lxjcVTKw9dntRftq9kiaxDiSPt4290ZzsOmQBYFXjLmZLdIH4ej
 XqTz1s5MUeaMDS3Y0t2MOyCZTw1k0OO9uHDQ6O99fQ3r4g3aydOYCUbjR7367eLLeK5H/vTdLL0
 GhlCg3d6HnI+Eg6ptItE6K/07smiOMSBYeRFV9Tf2ABhE9xjgjX/FdUmVsW7wBFJRQW8qXR+2Li
 Aby8IdJ/gBbypgLVnrqyRFurPx5ckP8di9VbJHxxjZ14+jol+6z5sBpyyd9wHdu4/oXOxKOSMRF
 qMp3OKUb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000


On Wed, 10 Sep 2025 23:44:06 +0530, Ripan Deuri wrote:
> The existing usage of rx_ops to reach the hal_apis at multiple places uses
> function pointer indirections. In order to avoid such multiple function
> pointer indirection, extract the required hal parameters in the rx path
> right at the beginning and store them in a structure which is then
> leveraged by the rest of the rx path.
> 
> Move remaining rx_ops APIs to hal_ops to simplify hal API usage.
> 
> [...]

Applied, thanks!

[1/8] wifi: ath12k: Remove non-compact TLV support from QCN
      commit: 00139e4d7baf41e05b907846dbc53829421bb1fc
[2/8] wifi: ath12k: Move the hal APIs to hardware specific files
      commit: 4ae34800a70d2704ec3a55146c86c4355a4129f6
[3/8] wifi: ath12k: unify HAL ops naming across chips
      commit: dd33e179466e4c0c5f74ebd838eedd9212cd3964
[4/8] wifi: ath12k: Replace ops with direct calls for rxdma ring mask
      commit: 52537339693789f3dd4ef7931f417ad641ee864b
[5/8] wifi: ath12k: Move hal_rx_ops callbacks to hal_ops
      commit: 92541061a6fd4e6a0acd700e8544cb26f19570e8
[6/8] wifi: ath12k: Add new infra for the rx path
      commit: e8a1e49c63280e6266392cb4a9f879e22bad893a
[7/8] wifi: ath12k: Remove hal_rx_ops and merge into hal_ops
      commit: 0cdb09b19760f3464b3fbed782b59758124537c3
[8/8] wifi: ath12k: Change the API prefixes to ath12k_wifi7 in tx/rx
      commit: 972f34d54015a4a16aa9e6a081bafabb6f9bf95c

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


