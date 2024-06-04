Return-Path: <linux-wireless+bounces-8499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8538D8FBDAB
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 23:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68301C22F87
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 21:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3337314535D;
	Tue,  4 Jun 2024 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z/o1WKH2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24C314D294
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534817; cv=none; b=nJFAJg5pkzMW6rW/4nA31n0vldvF3O+N0ZA0N3OKaq2Ibc+ky7e7ejfyg4BFu3uiejSSKO+TSnCyMfH226yLnsU9oQ7p90A2bhk+HQREd+/dkXaaIUX+XtxwtI8grQnLjbTvsmZWs33TcHFlzPQANAjGiTB55nteyeWm1uHJ3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534817; c=relaxed/simple;
	bh=SqRrq8Jm30Zge5kQTEOxjjzV+BBzdhEjwp0z0YHVjY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LHynnBHlkzfJXG1GUNagQN5FOSK6fueQcA7Ku57sLgzE6ZwrI3D2yJs9UYbTkjEzim/fYVvoDOk+7W3Up9FC8VGjUS0uzaFbkjoJ4pkTAxJHnPrF+rW2eT9I1Lh5bNDyzJ3JR+vOLND/B3EAnDkCKQ4+rVjIr8v9iuI05Blmty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z/o1WKH2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454IHic6006279;
	Tue, 4 Jun 2024 21:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yH0QXQi5wQVge/0F9LMvZsIKi/BiNXFunMlptnG7OJ8=; b=Z/o1WKH2CRCnI+DW
	doKtGPAH+qpdpUQ48hLFLfKzqYWeCqw2f0s6dy5gm0lOW9xV36NiUEKcQWnKP90x
	L2EE8npZv5jJHBnhQTmtviggXlQK36jPuqMtRPqpTZ7NUb6+KtQvPDG2maZpADQC
	nYAjyicb/rc81GXgwMGNTgNraE5cn1fE6NVGeT35Ds9NaQSiLxI6jBYFk3IyHdSb
	qYHESB+LKqmVP8JW4AqZNEyw+A/VwVsFqmFeQ39bXb+/4Zrv8k+R3yHFtbWoPOAQ
	9n2datG9luDpnYqZngmm3CjiY5XIGOf041yb+/ABULYiMz3vAwTJKwGqpNdni4Ey
	z3y0Qg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yj8300ajt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 21:00:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 454KwBrM021122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 21:00:08 GMT
Received: from [10.48.241.109] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Jun 2024
 13:58:10 -0700
Message-ID: <78c93382-a3fb-435f-92ac-fa15b0730704@quicinc.com>
Date: Tue, 4 Jun 2024 13:58:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: avoid unnecessary MSDU drop in the Rx error
 process
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240604062641.2956288-1-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240604062641.2956288-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8BwMm5jMKmWfXIUFHA3bVtCA9gER554R
X-Proofpoint-ORIG-GUID: 8BwMm5jMKmWfXIUFHA3bVtCA9gER554R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=602 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406040169

On 6/3/2024 11:26 PM, Karthikeyan Periyasamy wrote:
> Currently, in the Rx error processing handler, once an MSDU drop is
> detected, the subsequent MSDUs get unintentionally dropped due to the
> previous drop flag being retained across all MSDU processing, leading
> to the discarding of valid MSDUs. To resolve this issue, the drop flag
> should be reset to false before processing each descriptor.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


