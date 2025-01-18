Return-Path: <linux-wireless+bounces-17676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02812A15C5F
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jan 2025 11:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8141888445
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jan 2025 10:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED12175D5D;
	Sat, 18 Jan 2025 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GOVzrLw5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C4916D9DF
	for <linux-wireless@vger.kernel.org>; Sat, 18 Jan 2025 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737196188; cv=none; b=lL6vt+Fcf4ki5XsOeTMKNaQrD3UgznOVMdCLzoaQBbLtCq8HuCpDnAlX8f69aQLthSqGyHpUttZyhkEH8kbhmFKx4Cky4wrMCINbuOzDrhyCjO2s5IgEoE0g+JylO/zCQkcBxdOxFpKondRVpddgxgHGOpASVfvLzSIOEdJC9aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737196188; c=relaxed/simple;
	bh=Znfyvr9O8BB8CzY0Mi117nKujKm/llHtD6339D3YkiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=am1ugb1JfxXgYPntcoiiLKBZdxWZVDlmdl8WXEvXm0eA5ctpXSalCQ0l6w6mO0zmqdIWyB9fgmAVMPL+HMiAmmI6pUmhgubdsFAXIFuU7E1HLxpYVlRd4rUxUkdQPe+WQ5RosAPyXREPs+67VlmXUCT5bozLbgoBJfUA74oyj1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GOVzrLw5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50I33GVc016772;
	Sat, 18 Jan 2025 10:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mke5AJzDyr2LS0CcFgm6BfOCAPPezOVDYVQFwn1RjOs=; b=GOVzrLw5OeBwEM9r
	c7SBkpcNIKs4XXvcjPvRiIimvKtYW4QtwwoeprVFQAvLvlPIXxNnPHQ/+QqlqPbW
	PktG12ZhsQqRR3l/8O7Rq9AxVTD51quT9cC964nRnJtk3dMjmuqx1sPQErPvhFVF
	d0baZCd/eXp0XGHZP75AZqWjNnQomsc6IUMYl/+xKmyY6miy9NNgf31CfiKXYcPz
	w4lJCT+sl0oW2sYkj43aQhCuLHYRVnMoAJmBQclgugLgJ5MSw9t9RB0ejAgMLm/c
	/fE8CFXK5l52GlNySDWdNCcpT/JYdrSlxpkiTp3SCcvkDafPeTcY+q9YGgBxIZvM
	OkZcmQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4483a60jhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Jan 2025 10:29:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50IATViN024452
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Jan 2025 10:29:31 GMT
Received: from [10.216.41.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 18 Jan
 2025 02:29:28 -0800
Message-ID: <20e0a239-3d23-473b-5bc8-41bc25a64088@quicinc.com>
Date: Sat, 18 Jan 2025 15:59:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Revert "ath11k: clear the keys properly via DISABLE_KEY"
To: Nicolas Escande <nico.escande@gmail.com>, <ath11k@lists.infradead.org>,
        Sven Eckelmann <se@simonwunderlich.de>
CC: <linux-wireless@vger.kernel.org>, Steffen Moser <lists@steffen-moser.de>
References: <20250117191455.3395145-1-nico.escande@gmail.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250117191455.3395145-1-nico.escande@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jC-Ar-GjEnRJO1decWX4a_QZDseqzk8i
X-Proofpoint-ORIG-GUID: jC-Ar-GjEnRJO1decWX4a_QZDseqzk8i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-18_03,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=531 malwarescore=0 phishscore=0
 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501180083

Hi Nicolas,

On 1/18/2025 12:44 AM, Nicolas Escande wrote:
> This reverts commit 436a4e88659842a7cf634d7cc088c8f2cc94ebf5.
> 
> This as been reported by multiple people [0] that with this commit,
> broadcast packets were not being delivered after GTK exchange.
> Qualcomm seems to have a similar patch [1] confirming the issue.
> 

This will re-open https://www.spinics.net/lists/hostap/msg08921.html
reported by Sven. The recommended ath firmware ABI during GTK re-keying
is SET_KEY instead of current DEL_KEY followed by SET_KEY. We are looking
at other options like some marking by mac80211 for the driver to be able
to identify if the received DEL_KEY is for re-keying. Also I'm curious
if roaming between secure and non-secure mode is a critical use case.
If not, we can probably go ahead with this revert as temporary WAR,
@Sven?

Vasanth

