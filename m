Return-Path: <linux-wireless+bounces-15564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098949D5084
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 17:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E87282213
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BB119E992;
	Thu, 21 Nov 2024 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YGfd3XF3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9B3176AB9
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732205567; cv=none; b=BTsNk02W+JAEifEiRr6NZyZ3UpAGwe+RbJlTditvqoxN3WLQhUsY7pgFVeZZoojzTyZQeDC35E8yxlkHmNrcjVJiq2R9T0Tgi319ldtIhw1ODwpkpkH2+382/JSYGo1wtk2zy01sYcLPXbpTcsqrXSSUQKc/2ht2XyABuw/0mgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732205567; c=relaxed/simple;
	bh=+D5SYTVBXZFQsZ9uxgFphRagKaoP/7F98zh9hqCbj3w=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=O4/iucQ1drqpNM6t9Yhe9EiBCpAioy6t0CRhS/z904er1Lo+3+6+I00UcG/oY17iyfOAgB3VHKJyoawxgSE9AK+yh5wFNtLgdBgnOzHMjqgTrKQqKOKh7X7Eu510E5aiKG6NA3Z2lZK9tnrfb8pLbvUDiNfmV0WQmAeDa+ugLVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YGfd3XF3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL9DxjD007912;
	Thu, 21 Nov 2024 16:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bcr8jG3EWKgK+m2+WXWciXV+V1rZmvpvzddTtxw42X4=; b=YGfd3XF3LiPZaFpf
	pIwm97RGK85AFZX/cwvbI7FC/keJZNQDGXh1B+c46moY0zS1Fp9ktU5YjNCM2DT0
	cSut65ZfaYGUoPedqilMoBVSJ9MX5tFt5OUBwN8acUQYCuHRs/dM+brwMtK+BopS
	qbuBjaZXugnLS+kR+CepI4ybA4v1gwlikCmsTYLAPM2dReSgT1Hc7oIq+LrB+oSS
	Vq1m2aNogV72JfhTdtglX3dz235cD5sVcJVUvXXz+AIUjbU7xkb10rbBwQ2hpMjE
	4k29jiOUYGKzR831iqfRPIrkUabQjT59Rj9A7wOFM8PyDRVS8+dL/XUJFL7N25Y/
	JxLqOQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4318uvn4f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 16:12:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALGCdqD032501
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 16:12:39 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 08:12:39 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k@lists.infradead.org>, P Praneesh <quic_ppranees@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20241119164516.756478-1-quic_ppranees@quicinc.com>
References: <20241119164516.756478-1-quic_ppranees@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: Fix endianness issue in struct
 hal_tlv_64_hdr
Message-ID: <173220555940.3016923.419178704492681378.b4-ty@quicinc.com>
Date: Thu, 21 Nov 2024 08:12:39 -0800
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
X-Proofpoint-ORIG-GUID: 4iERozgS5OBPaMjMYkE7GadFmGIVyIhS
X-Proofpoint-GUID: 4iERozgS5OBPaMjMYkE7GadFmGIVyIhS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=814 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210124


On Tue, 19 Nov 2024 22:15:16 +0530, P Praneesh wrote:
> struct hal_tlv_64_hdr has a 64-bit member that should be in little-endian
> format, but the current definition uses host byte order. Fix this by
> changing the definition and updating the corresponding helper functions
> used for the byte order conversion.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix endianness issue in struct hal_tlv_64_hdr
      commit: 1cfa6d4e5bd9bfb15d165d8d843163363929ba1b

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


