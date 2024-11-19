Return-Path: <linux-wireless+bounces-15496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699789D1FE4
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 07:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7B64B22CA9
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 06:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E50153835;
	Tue, 19 Nov 2024 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A9NRl0ME"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE31C2B9A6
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996241; cv=none; b=ivPwoQWwxrfcgQZVUqW9bRhkUqOKvjYKK80fUQd5Y3mUi4wuiKfQMtlOUKjy+HO52X8oWe4W9izOHlit+hzVp6CAKt7NS9pcqfyHf9+UQNIL4PRYrcBBeWZaeGRoWOobbIhqAdKoSyCNE1ivnw2cfpQT66bJzA5VOCjTn8JjMUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996241; c=relaxed/simple;
	bh=X2uMrDm/ZaKJAQGIe+VVQLEmqnTGn3PaNrOESR1x2WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fWZIp8HPbHidu28oMfnIKuDW3bg2GpUfH4nVpUVu7fm619ZveccC+J9EDSuW5DMduoPh326EFUC8U02ArtjjzwPs03XPb5+9ObFQcZtG3EZ54NFASf4ZTs99L9DITtce8K3HFu25OK6mwcZCRTSkS+LWLfF14zPDBtileU1TXI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A9NRl0ME; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGHJwM028646;
	Tue, 19 Nov 2024 06:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	02HxydhBRHmUHEDePO1OYsimindC+DrKNg1lGE0mEOA=; b=A9NRl0MEnUphS9fC
	+D9aGy0TNST6+/uIaRNnkX2I1UKC8CutUblz+xMyYBK906ZY5EBizaCBk1tfVQ9M
	tsOO3yr9jPSF+Hh/QJqfAZwRLaL5cOM5wpr5Kt9hZHEngJQheQq6yE8a5Nw96pIw
	ySQaW/d5+y816sy2qI9V0EOpf+lW6u8Pulzn5KmzdiHDzBp4+Ga6lGivuIAGIytV
	uSsqLS/aOUP6CIYhVZQP3B7/Rsi4OCm408Amp717fUeoRKSe8KtXc0moJ90Twspd
	aQGPoZ9vw1WqNwYXQYgYLzFQKIQ2HwGniaCUtGKosRYYFhzj9gBgU/BBtCloq0MG
	IUJ4hQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y6sk9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 06:03:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ63vtC010206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 06:03:57 GMT
Received: from [10.111.176.82] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 18 Nov
 2024 22:03:56 -0800
Message-ID: <bef46f08-b2a8-4197-91e0-aa9727194fad@quicinc.com>
Date: Mon, 18 Nov 2024 22:03:56 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] wifi: ath12k: Change the Tx monitor SRNG ring ID
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241119003248.1579567-1-quic_periyasa@quicinc.com>
 <20241119003248.1579567-8-quic_periyasa@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20241119003248.1579567-8-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zkHgpS6Cgrq-rt-rxZl3PUIOcv2nkKEY
X-Proofpoint-GUID: zkHgpS6Cgrq-rt-rxZl3PUIOcv2nkKEY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=814
 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190044

On 11/18/2024 4:32 PM, Karthikeyan Periyasamy wrote:
> The Tx monitor SRNG ring ID does not align with the ath12k 802.11be
> hardware architecture. Currently, there is no issue since the Tx monitor
> is not enabled. However, in the future, the Tx monitor will be enabled.
> Therefore, change the HAL_SRNG_RING_ID_WMAC1_SW2TXMON_BUF0 SRNG ID and
> assign the correct start ring ID for the ring type HAL_TX_MONITOR_BUF.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


