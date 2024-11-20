Return-Path: <linux-wireless+bounces-15532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7699D3F4E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 16:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F061F21472
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1E185C5E;
	Wed, 20 Nov 2024 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ioFmYfDp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88145130AC8
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117545; cv=none; b=eup6L3i9c1GBacpV3S+PEpV0UCBf2Gvh9xzNrMYQ3GIa9dLWI+nXY46vB7S039tDjLVkIDoeriFRMDJxHjVNjgaSRf5qfXso5/1WLtDukdujqbbN57gakFH4Kd1KkaWo3T07IOV/ff6DXJIkAIASZfYBQVcCPrJyrMgX7CtMxBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117545; c=relaxed/simple;
	bh=8CRnXq3BWDq9g7p39rv+Xi6RJlccirlNQ9b6n26/Bq8=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=RUMGpKsNEsoOYNzXID0Gun+G6qHUZVmTYxE3otM9OYhys+F3GzYFr2gbix+ULSrRAqQWaTjTMCJGYUgb+oQlbc/n5QzcUg63TpndhkX95GF9QPT1ZkyAZ2gjGtiwGVvVzl5pJJ1kz8DYRnXTB0ioE0VY484t8tnrG/fgR7QoYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ioFmYfDp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK9GWCA025955;
	Wed, 20 Nov 2024 15:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4I9IAPmHbPMdgV0FRhO6QubwegIcwZ54FzVt8fiZ134=; b=ioFmYfDp7LiMfhVE
	NoCmJt2GLeYdtlEhfHpeUSrK+yfuOAC9U1ryw5dRTR2n/XIDfUZSSPsWgGB4R1qi
	oK1p4lg1UrdAHfacrwDpOM9TyMoH253aaTVNKVsxZ9A+57SJAx/Cc1VLd6F5W5Cw
	sqS996qixXKWbtC2l6auNKOP+6BOiGDCn6D2mpp3kWrv2GEnO3OeMHWg6v2/M7yC
	xna3XgCPLzW6p4kQ5yVHHOIcpfenuXi1iqpFZ3Blu2WD+XXFkt/2pNgLf4/YZ8aG
	rlA1PGw95pk8AcVzmu0Qxl/2fLmWsOQjFXxSiccC2Cqc5GMoMeZvKEgSH3J3PE+4
	mODNRA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431byjh6tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 15:45:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AKFjckx015825
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 15:45:38 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 20 Nov
 2024 07:45:38 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k@lists.infradead.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20241115062854.1919672-1-quic_rdevanat@quicinc.com>
References: <20241115062854.1919672-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH v6 0/4] wifi: ath12k: Support Pager, Counter, SoC,
 Transmit Rate Stats
Message-ID: <173211753819.1671164.11446246438526962981.b4-ty@quicinc.com>
Date: Wed, 20 Nov 2024 07:45:38 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b9p2iL4oStbprYruGPHX5kXisgr9ju2T
X-Proofpoint-ORIG-GUID: b9p2iL4oStbprYruGPHX5kXisgr9ju2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=963
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200106


On Fri, 15 Nov 2024 11:58:50 +0530, Roopni Devanathan wrote:
> Add support to request HTT stats type 36, 37, 38 and 40 from firmware.
> These stat types give downlink pager stats, counter and TPC stats, SoC
> common stats and Transmit PER rate stats, respectively.
> 
> v6:
>  - Removed unused variables.
>  - Used le32_get_bits() instead of u32_get_bits().
> v5:
>  - Addressed Kalle's comments pertaining to variable declaration order.
> v4:
>  - Addressed Jeff's comments pertaining to data type conversions.
> v3:
>  - Added macros to fix compilation issues.
> v2:
>  - Removed dependencies. No change in code.
> 
> [...]

Applied, thanks!

[1/4] wifi: ath12k: Support Downlink Pager Stats
      commit: a93d125ebfdd530ea1980a45b7ad2e9471b82c87
[2/4] wifi: ath12k: Support phy counter and TPC stats
      commit: c3527cdfcdf70dcd613c4582283e28e4f81df9ea
[3/4] wifi: ath12k: Support SoC Common Stats
      commit: 3a660e7fa44d556f41cbef6d2430f7227ef3f3ef
[4/4] wifi: ath12k: Support Transmit PER Rate Stats
      commit: c8f314703bcbade1bcef8dfee9ffc6a1d66b9d8f

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


