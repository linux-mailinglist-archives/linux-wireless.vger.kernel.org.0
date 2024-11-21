Return-Path: <linux-wireless+bounces-15567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B77C29D5089
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 17:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5200D1F23D4E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 16:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D7C1A4F02;
	Thu, 21 Nov 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pp6jU/SO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8661A0715;
	Thu, 21 Nov 2024 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732205569; cv=none; b=NEaZm7OJqP3i8/9FJ8ozKtK7zjeqGhCLrQXykwwSzAJeoD7MDXk8v3YteeBTLgAK+3kFIlF+SCILyLnMR3Y8vmk9YBhdUT8MY5QiJZ/27imZkVnZPYjPmMMiT5om9F3v4mWfDjFom1uZtCA9KmCfEFbmUgLI8aAvanIU00dzLeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732205569; c=relaxed/simple;
	bh=xGSa1gGFLBdroj+AKeGEIl1KuuND/hnJgvXwHQyZrYA=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=uupKsd0FMWk+xTzcv29FJfplIcyV5aj54iyemio9aegbafqg6/n+8jCkD3QbMDTWCBnuBzCtDOYTDrDl3L1C7I/G3+XTfV1kSiUelL7GeHZA4iJZBt/GWA4/GBYMzd+CGPT/9z0YnxGyOo5QR9atLGC7dDox/HaF5IRGE6lA+l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pp6jU/SO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL96fwe025897;
	Thu, 21 Nov 2024 16:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RQcNQzxRMHqJhXiKoNaqdBad76VRY8am9jD3KnNGyMM=; b=pp6jU/SOFeIr3O/2
	tQfU9A2mDR/A/nRUdxzUDTGfifkFGr74Fgmof0DiwJ3bAoAATTyL6NAYt1/vFBS3
	fvDc2PaitVZZLhqk7Pzd+rELCWBrOAkXr5ztHfpwk2A5Ujb6uTaz7dtAC7K3dnzs
	HMFnjdpHCW1K8fEE+uaJWtYurXASsGJXoSD3INn1jB39lSd5qhKw9n0N7mKofWcI
	MPHtOgVVU4S0jDfhrYDVWol5Chj/LE6L90qQvpMtNbopOdUdgGgdFLxz31/qV/oc
	Yph47oKZlxQQcOwQ9mwwMzYMO64sFj0aYTeizBFPFW3LzWta6xpVn2LItZjpXFfa
	MgFxpA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431byjmpt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 16:12:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALGCdHt032482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 16:12:39 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 08:12:39 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Loic Poulain <loic.poulain@linaro.org>, Kalle Valo <kvalo@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
CC: Kalle Valo <quic_kvalo@quicinc.com>, <wcn36xx@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20241104-wcn36xx-memory-allocation-v1-1-5ec901cf37b6@mainlining.org>
References: <20241104-wcn36xx-memory-allocation-v1-1-5ec901cf37b6@mainlining.org>
Subject: Re: [PATCH] wifi: wcn36xx: fix channel survey memory allocation
 size
Message-ID: <173220555907.3016923.16789393852476367069.b4-ty@quicinc.com>
Date: Thu, 21 Nov 2024 08:12:39 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _Ze8Vo4KNyKQQYYX6tVSU8kWDE3913NC
X-Proofpoint-ORIG-GUID: _Ze8Vo4KNyKQQYYX6tVSU8kWDE3913NC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=655
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210124


On Mon, 04 Nov 2024 21:00:35 +0100, Barnabás Czémán wrote:
> KASAN reported a memory allocation issue in wcn->chan_survey
> due to incorrect size calculation.
> This commit uses kcalloc to allocate memory for wcn->chan_survey,
> ensuring proper initialization and preventing the use of uninitialized
> values when there are no frames on the channel.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: wcn36xx: fix channel survey memory allocation size
      commit: 6200d947f050efdba4090dfefd8a01981363d954

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


