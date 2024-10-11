Return-Path: <linux-wireless+bounces-13891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BF299A68D
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 16:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3599E1C224A4
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 14:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266C619343E;
	Fri, 11 Oct 2024 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dA6mUYDj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8915E194089
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657580; cv=none; b=hfkH6Cqr2aGPWj2kI+QYtLfdXCkko4NKdwYOrgGnCiBJf2whd5WzCNIviYtLFSRb/gR5UfYo7GSR5vyd7qACykfrZTML36GkY7hCnnzQCRoxN6ov6kMMbiIpjHea2cDwlvGDriogsjLyRILaM9PQvwA4JGyu+S0cBnwbZapKdv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657580; c=relaxed/simple;
	bh=BO1kynJDPcqPWTr/9QgfUXnTD4SS6oCLrQUNsyCR3zw=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=No/01OhduLLGmOf4+aj6a07YxInZYVuJjx82bp8Fn2Mgg0xFxEdBT6pOGgGpiZuFaqmrDvvQTq6TskVJwY3S1nkKBKfiV+zhZVglGr562RHD1U4FaIMqCcP3QMU+Ba7d6SavKaextqBI/mo0Hm+8VxQHSGhGVjLMgBZD3oUn3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dA6mUYDj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B6oUtY023952;
	Fri, 11 Oct 2024 14:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zcazVMZ8OwB4kJ2Zj2Fmagt/F4yGLV2Qz/rwCahr/wU=; b=dA6mUYDjlj9LWmkw
	pn4HbAO2XPWvznGssPf62DsyH6riQhCkMPOhjhgse0NjYb6Y3qshAoP6z32ALlCz
	IU5Gq/10k/ewfVdX4eW8LdNRMj9pn+M3gddpRPCm23kHFLdInHR/ZhQR7YAiI6KR
	g/vMq9i6S87R4CdU6j636Qdssw69jkm0mkVqXts71CfzSN9Z4TWCQ1ccBagNASSF
	J1hXplvmOvSzysfCUBgZWQNw6EgG7gv+s+fG91d8BIYxYlmmRGPcQpYNZKW/Zq5L
	Cg3El+MIaLQapSPxgNI0ys9jwNPTEVGqMzRmAn9Xk2iZUOKwBfJkzkx1m/oAwRWd
	sC2gjg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426y3vsd00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 14:39:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49BEdY1H015880
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 14:39:34 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 11 Oct
 2024 07:39:33 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k@lists.infradead.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
In-Reply-To: <20241005104206.3327143-1-quic_rdevanat@quicinc.com>
References: <20241005104206.3327143-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH v2] wifi: ath12k: Support Pdev OBSS Stats
Message-ID: <172865757370.243911.11996944263110029562.b4-ty@quicinc.com>
Date: Fri, 11 Oct 2024 07:39:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8X8sMm1CsJP-rz0GpM_qRQaAPw5IcXIc
X-Proofpoint-GUID: 8X8sMm1CsJP-rz0GpM_qRQaAPw5IcXIc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0
 mlxlogscore=787 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110101


On Sat, 5 Oct 2024 16:12:06 +0530, Roopni Devanathan wrote:
> Add support to request pdev OBSS stats from firmware through stats
> type 23. These stats give information about PPDUs transmitted or
> tried to be transmitted in Spatial Reuse Groups(SRG), Parameterized
> Spatial Reuse(PSR) and non-PSR groups.
> 
> Sample output:
> -------------
> echo 23 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_PDEV_OBSS_PD_STATS_TLV:
> num_spatial_reuse_tx = 0
> num_spatial_reuse_opportunities = 0
> num_non_srg_opportunities = 0
> num_non_srg_ppdu_tried = 0
> .....
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Support Pdev OBSS Stats
      commit: 15d91424ea822ddfb28ed18564343b3ff9d382fe

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


