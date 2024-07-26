Return-Path: <linux-wireless+bounces-10534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321AA93CC01
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 02:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23BC281FC7
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 00:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57CCEC7;
	Fri, 26 Jul 2024 00:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XYyEO2Qs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AF9EC5
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2024 00:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721953079; cv=none; b=oQirOy/W0MmwIKxV9FgmqZJ+cXC9Lsw149iDYhwvJShLJQSP+zXVpsfE3BtCwGfldqDfxpezLLmEALzutDWoEsN2gENDH4/0JOZawReSp+bL98bE6KNVGWJjRfdAiGRdhuPLJFf6CnmnQeZGXlj0a9U0LdBUSCntXnsCtkrlBT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721953079; c=relaxed/simple;
	bh=WYhA4BTHiMBQ2HFTIIkKplKh+lRqXQkomwRqgo8tIVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y4XKBo5NPHyX1JlbGucah88VxRBduy8BTBTCMG5yFuXX9qvHo8K1pwkEocjaZVgT32qQiGbW6pNw4v0x9IQN+EfzpSx6YQeQvFlB0M9IeAQqYbUPVUdOMJZifN7wr256apos97ZZsoqLPDet0oLcbywwC9DDj6yRDJXSQ/J6W38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XYyEO2Qs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PMAcKY010673;
	Fri, 26 Jul 2024 00:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I6lsHdF3AwD26eYbzzZNUhaMjwpjs6pvX9XRdkk2b5g=; b=XYyEO2QsTdFRNYEx
	xraVdq+Kh2mM3j5GSxrhBUehEFdUaeLIdXewDLaSdiom/WTRPXl3sGhjq+qiFgsV
	4pLhmvnQSpcpSqtVh+lisuOQovPH8uXOdpZayLn4m5e9gO6Vcj1S4uRExaIqfSoM
	DbimAXRKIfqRLgCd2JedeyK2V95oZZeAsOzsUYvUzhJv+0KuQ6uaxxUISeUDHhAd
	yg3XKKYFyJhTNF8vj3/5KK+RxI1pB0WANqSRpXk7Q++WhfQDQ/qArxA1wCBs+Z+U
	cTWjC2bVsXVQorx0EFkbNUj2lEe3H4P5jkTRCbAk1TgOiy53b2S4FQbn7CqsU3At
	5s0s2w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g2xepnsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 00:17:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46Q0HsB4016830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 00:17:54 GMT
Received: from [10.111.176.158] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Jul
 2024 17:17:54 -0700
Message-ID: <fb12103f-e7b4-4628-aeaf-3b9f99e09717@quicinc.com>
Date: Thu, 25 Jul 2024 17:17:54 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] wifi: ath12k: fix struct hal_rx_mpdu_start
Content-Language: en-US
To: kangyang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
 <20240725120035.493-7-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240725120035.493-7-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x4D7YwnKz2iKn9p2XyJ13W73fuRgYfXl
X-Proofpoint-ORIG-GUID: x4D7YwnKz2iKn9p2XyJ13W73fuRgYfXl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_26,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=564 mlxscore=0 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407260000

On 7/25/2024 5:00 AM, kangyang wrote:
> From: Kang Yang <quic_kangyang@quicinc.com>
> 
> Current struct hal_rx_mpdu_start in hal_rx.h is not matched with
> hardware descriptor definition.
> 
> So update this structure and related code.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>



