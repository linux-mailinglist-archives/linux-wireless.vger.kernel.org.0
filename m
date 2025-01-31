Return-Path: <linux-wireless+bounces-18238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A59AA2391E
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 05:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E504B1886CCA
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 04:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD8A25760;
	Fri, 31 Jan 2025 04:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SmztI7gQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF5620EB
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 04:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738297013; cv=none; b=kw6Q+ny/NHO7qjZbmTzsXN+XJQ9MsYst8f/cyfzDFMRgN8sArQWv5psvgOYiN9tjFyZaLa8mOeMRo/2prWBU8GM73iImnJVLpk00f+EEi7KEhATOsQVztDhZmjod1shThupwcgTE2jYeOnXX14BMi/6vEbzL+oGtGYDVedQ+cnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738297013; c=relaxed/simple;
	bh=4Vx/nbkN33iuvf7ekssxUFy143X+r5lHn9dZjzlCJco=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WT6JiGKJQ6xxxGJUReOmOGYBBjbRpErwENzFGkDFAj8g00yTvfuuZWCBOirivvNItdIvH7IYNr1gMEZrAvvstzyBEd1WV2LRKqJcJcq6rCXVTHNqYQ5SQ8iCAANJkA4y6CrBvDoBJFYl+EZzW8SJud5OZcjmA7dgMg+z+yN9z0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SmztI7gQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJ1oi9003754;
	Fri, 31 Jan 2025 04:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4BFaSoKZoPTfpeYhhCeO+VxxOxOPyhcf1ByIJUCOaD8=; b=SmztI7gQmwAvKpbP
	1GEB3y/bHxmKyhkhoiYG1YeG1zp1CfIoxmuTqqsu6iNfCs4Vfy97s24DgX4J9mOa
	UxYzbDcxYVdwaFdFqFH2Yb2gke/528Uv8Dxvsn5cs6vbcTGf2ZhICPhxRkKuobSD
	OxgGp1KRAshhN3EP8C9b1leoMAs51pm39xrGbTB68zLfMifS7/lRLPoA6cKN+HF+
	ijBsEgiu3pMmvtZwZRDK81YgN9XXvUlF0V7PgbDXBtjiZvAuuHTEs37eRvu0YGxw
	bPX1irhV2D7bJtbu0h5pTd95IRWAENwHgQaedoJdOupXxqssyYIyeoKpDyP0jO2+
	jPYJFA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gf7m8vyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 04:16:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50V4Gk4o029606
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 04:16:46 GMT
Received: from [10.216.32.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 Jan
 2025 20:16:44 -0800
Message-ID: <de5b442b-200f-dc4c-e8a1-43e2f56f70b7@quicinc.com>
Date: Fri, 31 Jan 2025 09:46:39 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath11k: add support for MU EDCA
Content-Language: en-US
To: "Yu Zhang(Yuriy)" <quic_yuzha@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250124061343.2263467-1-quic_yuzha@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250124061343.2263467-1-quic_yuzha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: s4CLS3cRc_XWeerhje1D92bAQN0qGAYe
X-Proofpoint-ORIG-GUID: s4CLS3cRc_XWeerhje1D92bAQN0qGAYe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_01,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 clxscore=1015 mlxlogscore=770 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310027



On 1/24/2025 11:43 AM, Yu Zhang(Yuriy) wrote:
> The current code does not have the MU EDCA feature, so it cannot support
> the use of EDCA by STA in specific UL MU HE TB PPDU transmissions. Refer
> to IEEE Std 802.11ax-2021 "9.4.2.251 MU EDCA Parameter Set element",
> "26.2.7 EDCA operation using MU EDCA parameters".
> 
> Add ath11k_mac_op_conf_tx_mu_edca() to construct the MU EDCA parameters
> received from mac80211 into WMI WMM parameters，and send to the firmware
> according to the different WMM type flags.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04523-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Signed-off-by: Yu Zhang(Yuriy) <quic_yuzha@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

