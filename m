Return-Path: <linux-wireless+bounces-7070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9058B8004
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 20:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2511C21A23
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 18:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C382617F38A;
	Tue, 30 Apr 2024 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y0fQhpAk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8917F39A
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502671; cv=none; b=kZdh2ZFI8E/gJ9LKs0ged+yPtpSS2AxbiNK7vq9zmYdImYuVgohPo5gh8bANTMEHX+0AqJ9MbT+IQPTX37sRYDu0OpmVCsm7L5Ds84Tbn1IwJS74qM6SE8dtz4FZaMd9ilSb8V4IOdyNnBmiIENwj5Zd3D7thFRmjMptUwK+jgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502671; c=relaxed/simple;
	bh=r4nwO+DBZU5iE00DOhXkzFaAQp8dbFE4B4KdU8owi20=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NPhG4tndXHlQ1P9qJD3IdP3iiyj8aELyaGo8SZ+2L0xoJLisnzP11mmJxQMFUTYchrfr7kjElwS0THQowJ11JyTd9AGfjkv+CgYLrt07hflM9DN6Ivy29Huj3TF+BKCgvqDbpIcaE9aetXK2OG2i2Z2g6mnshvDWjubWpxeB23U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y0fQhpAk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UGHvdd011394;
	Tue, 30 Apr 2024 18:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=e26QQdGzOxHOVUFEQqXWnhRV6+agHMoM+Y7hToaUJsw=; b=Y0
	fQhpAk5pjqznj42MHdhzSYpsO/7XK9MOzlDdReBFvnalx0U0W/I5cyKe5iYifAbZ
	r2JGq5Cjqr61m+Zrt5QBT5WVShaQ0UgEo1y5Wf1bOu+1ALSgMgfnpAARHLNknwUU
	BkWKG2NoMRZqe6cpvqEyrfb353lNhDd/hxIfL9ioWugDTra5wv7SU797uE7nIcG/
	RL6T90N3YGl9n5FOeMYW4c2sxi6VYMUwYzP7fwKCfFanmSN7dqcCI2XvnLLN0qwR
	4FT6vlP4BJdmnADuejz3C7VWPo3MSd71qNmNtxKpxVktaeUpypBaMIy9oftvt96B
	KFIos1HUu1ta6LPRoRsQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtv1hsudb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 18:44:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UIiQgs019538
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 18:44:26 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 11:44:25 -0700
Message-ID: <c1f80f1d-235c-4fbe-beb8-168f7e969707@quicinc.com>
Date: Tue, 30 Apr 2024 11:44:25 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] wifi: ath12k: Introduce device index
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240430165811.1377182-1-quic_periyasa@quicinc.com>
 <20240430165811.1377182-4-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240430165811.1377182-4-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: P21_IheBpZJX0OZCpOvzSPfsBzfFmU3n
X-Proofpoint-ORIG-GUID: P21_IheBpZJX0OZCpOvzSPfsBzfFmU3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_12,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=848 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300135

On 4/30/2024 9:58 AM, Karthikeyan Periyasamy wrote:
> Introduce a device index parameter in the ath12k_base structure. This
> value is used as unique identifier for devices involved in Inter-device
> MLO. It is also used to configure the MLO parameter within the QMI host
> capability send request. While currently set to zero, future logic will
> be added for inter device support to populate this parameter with
> non-zero values.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


