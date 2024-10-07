Return-Path: <linux-wireless+bounces-13648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3008993976
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 23:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D221C21519
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 21:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A4018C34C;
	Mon,  7 Oct 2024 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EGFblTP1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C0228EA
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728337398; cv=none; b=NdraIw0JohJRodeyAhNpOlNA2t1asIHemVjldIwZhAmMcHw4Nl9n/3k46VqMsA0dOmCplP/Yviwg9ZMl9Z3Yqf2aQq6HL89GFSE+S0uSK5lAV6riyA50KJGf+kieto+dU4xF7MXxve4dumW+cC8vuTvwIWoO4K7jGqmusj5prhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728337398; c=relaxed/simple;
	bh=qxTGZT0DcImnUFutrAhjaLiWrdFtdorGlzgMc2w2mFE=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=rSqD/1gvLt1bJawE2LagYgStVIQgHMIrKls4Uwk8aUZ6h/DDwxP6tMhK7ZKP6v8lICd3GwWn1FUTyCw6E1hBs65BSp4XlXemzQApLJbgWcyK00tjfuVjjJ4wkPcm5lSBbcPgsh0zN3y7znrsQFOnhtuG1RVTMY/NKziqmfuL2yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EGFblTP1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497F0qu5015082;
	Mon, 7 Oct 2024 21:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nN16czptbzzE5T0RkO5rLxyCaq820a6QscDHDunJlMo=; b=EGFblTP19Zvs3UkT
	+5UMHvNEIcOQBQjBRlPiMkTvzSpCna87UVlJ8iZbTGLERH7XbF3WC2vCF5JTXOp1
	S91tsV/bS6ejqCXCQv0XDeyu2UX7XuMWD7UKvU9/nyyfLnj5TKrzGupc8kH8f67t
	yfqbtC9KvDcigPvb+QYPb0JNZt+OXUWzvJ2pxCcOeaRqN1Df88+6MEjlQYlNC7JL
	d7pMCxID9SxfPNw7h8/M3dRaR4sv9TP+pXgGcZRydYr1TZiX2r6CZsaoRwJMDgVq
	hzwMIvaUH6a+uZEu3svhyFlxbYW1e9ugsCgQILHg3mkOTshDuehZl7U7FhDrD/QE
	hlX8nQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xs75cdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 21:43:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 497LhDfw002801
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 7 Oct 2024 21:43:13 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 7 Oct 2024
 14:43:13 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath11k@lists.infradead.org>,
        Balaji Pothunoori
	<quic_bpothuno@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20240927095825.22317-1-quic_bpothuno@quicinc.com>
References: <20240927095825.22317-1-quic_bpothuno@quicinc.com>
Subject: Re: [PATCH] wifi: ath11k: Fix CE offset address calculation for
 WCN6750 in SSR
Message-ID: <172833739320.2581613.1348010188927412742.b4-ty@quicinc.com>
Date: Mon, 7 Oct 2024 14:43:13 -0700
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
X-Proofpoint-ORIG-GUID: AEBVoYnSXSk_8J0rN1l4r-zaoBuzwWLH
X-Proofpoint-GUID: AEBVoYnSXSk_8J0rN1l4r-zaoBuzwWLH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=976
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070149


On Fri, 27 Sep 2024 15:28:25 +0530, Balaji Pothunoori wrote:
> Currently, mem_ce and mem iomem addresses are used to calculate the
> CE offset address. mem_ce is initialized with mem address, and for
> targets where ce_remap is needed, mem_ce is remapped to a new address
> space during AHB probe.
> 
> For targets such as WCN6750 in which CE address space is same as WCSS
> address space (i.e. "ce_remap" hw_param is set to false), mem_ce and
> mem iomem addresses are same. In the initial SRNG setup for such targets,
> the CE offset address and hence CE register base addresses are
> calculated correctly in ath11k_hal_srng_init() as both mem and mem_ce
> are initialized with same iomem address.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: Fix CE offset address calculation for WCN6750 in SSR
      commit: b037edd0c3304908bcddbb9765ba266b6b803ff9

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


