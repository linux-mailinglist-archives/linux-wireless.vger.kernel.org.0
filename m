Return-Path: <linux-wireless+bounces-15990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 401C59E7A34
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 21:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11190188704C
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 20:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC8D215174;
	Fri,  6 Dec 2024 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S0jLFYXG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFA9215165
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733518140; cv=none; b=h+l2y06S32cgn9EXIQq6QAc4pm05x7or/fpczXxnfLBEr86H28nY8bOGA4xs5UcssjnINc8Ayo+TP7B43ODro0UFwP1fgXZLBDr79fi6PaHD/wjM8jEdsa4XEIQ011QlpZF6jCJRgUIb6L363J+20X8xWWy7Fkvdc7mtdlGpOyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733518140; c=relaxed/simple;
	bh=WWq50jNBhWTyCw6G14xMFGbsy91hVkRpaZKOWm/8tlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iOy+srFzy3BmW7Y1IGGY/Q29X95UgZLi6XfeBIKT4sPlMn08V94hI79c1IVOLg8IUnxrqxDHJRd4LQsR8N7qrY06Qai1pwNhQmpZWyxOrfHTM7RXREdvu4j3NxpPqsjldv/7bDgtSGogq8vTYRl+0zZeXSAEx3uvyocnxh3c2cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S0jLFYXG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6CF4it003155;
	Fri, 6 Dec 2024 20:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0P9ucAuLFxtv4Nv+7uevs2CJjzDeKgIkyHJHTH274yo=; b=S0jLFYXGMAZo/p10
	2gTwh4/dHKXQi3S/GRpmKPLyDUOh8cr6/lgvEhEIJQJiPRnN3eTnp4RfM4Jgv+YN
	QfsF36d+aYl4EzvlYB4wXe+jZUkLliQS1MICy+bhuo/odzwF3KuBRe2RYxHW1P/H
	opDjfoBQ7QwMHTKy+7w1vZMjzsS8N92h+UG40pNjAczIAh5G53e4Q1vlUKkO1ih0
	uEPBqM0rzgs2FncQuWYt7UpGX/FJTGx/QThVclM2U1hBJClXAycvc/NDqeb+eQCd
	1CX0W8RkPb1WfLGSzjFtCcfydTQnMwVCDyq0J82cF6vIzpclpJM08DPkeNvr5eRC
	fp7pGw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43brgp2qyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 20:48:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B6KmrMs004444
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 20:48:53 GMT
Received: from [10.111.177.171] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 6 Dec 2024
 12:48:53 -0800
Message-ID: <c7c66d91-c862-41e8-b8e4-fa661cc8e2f7@quicinc.com>
Date: Fri, 6 Dec 2024 12:48:52 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix leaking michael_mic for non-primary
 links
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241206054552.177424-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241206054552.177424-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kQ_zv5HUKXhZ2KK91wxVe3lGHSdoNeGS
X-Proofpoint-ORIG-GUID: kQ_zv5HUKXhZ2KK91wxVe3lGHSdoNeGS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060156

On 12/5/2024 9:45 PM, Baochen Qiang wrote:
> In ath12k_dp_rx_peer_frag_setup(), commit ea4192553850 ("wifi: ath12k: add primary
> link for data path operations") checks whether a link is the primary link, and
> returns directly if it isn't. In ML scenario where we have non-primary links created,
> this results in leaking the michael_mic info since it is allocated by default but
> could never be freed for a non-primary link.
> 
> Note that we can not move the might-sleep allocation after primary link check since
> there we are in atomic context (due to spin lock). So keep the default allocation,
> and then free it before return to fix this issue.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Fixes: ea4192553850 ("wifi: ath12k: add primary link for data path operations")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


