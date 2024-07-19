Return-Path: <linux-wireless+bounces-10393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3419378FD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 16:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A151F22CD7
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 14:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7681442FB;
	Fri, 19 Jul 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bxwN9Sod"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B855313C9A9;
	Fri, 19 Jul 2024 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398244; cv=none; b=t1993Xvi50MPWZJDNEXuM/oa22agdUfIb/W9cq0HWgI7L2rXksiQFRr7ruBz3gDYEHxTBF4OcsyqFubFkJq1Ym3fJ4n23HfAFlhbsQ2S5RJVOfpywZDQpPo8dFoWR3d4k1f2IdJfgZMbgnooIBvv19cyYW6ghdSrwOdFqCc+EDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398244; c=relaxed/simple;
	bh=Ks0ZhbQi1yrk7EuHKFw5vN6rbvbZt1/k4HeR6o3+a8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iA/RcDaTwoTiA7/cOt/NPvw96MKxiZPTt1KMyPmB4TDzFGuFjNn6uG0JLThX9tBomFWcfiyYjAMG9K6wQSSc7kOqWj4TwEsAom1EZQLMYizgQieTlVvvKuM13yLOr/uwA06I82UB57ZFf8ZPfXBLQH2OFMUH01T12PVFy07Nhjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bxwN9Sod; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBGqTM010390;
	Fri, 19 Jul 2024 14:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dQH2jNQy0JqFB9jEU0yvzPfpjLt2So36InmB746BOG0=; b=bxwN9SodpQOaW8YR
	OP0xYkf9rZxZ3BfaToDc0EElO3KrEOOuw0kiEYFpr2cIySN7yalKWxpHdueW8vhj
	oZyeWGbDmXnD1Z2kcQMfpiIbWmMOmRTNKL+oxYsms6mW9XUy4h/DFLDJOc+XuC5M
	CJQatyT7NJmIRk4dUGmHe1LkBgReSNea3+mqNcUSnFmwG0sm5aa2Gbfw4C+CpCN1
	CxAUqS1evyaVV9Etwau8oUgzrLNi1/ue/uIX93s7JX0oW+DoARjBZSTbGXnmeVIn
	9nd+8PRTw0jAjMlKn9tlJjmZ81ZfS5tg0GOaYV0ZkN+q9LbnVnq96Jf7qyfOPjAa
	i1kLQw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40fe459p8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 14:10:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46JEAdkl014122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 14:10:39 GMT
Received: from [10.48.247.102] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Jul
 2024 07:10:36 -0700
Message-ID: <c26af1cb-747a-462d-8e13-af948bbb8171@quicinc.com>
Date: Fri, 19 Jul 2024 07:10:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: use 128 bytes aligned iova in transmit path
 for WCN7850
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <kernel@quicinc.com>,
        <netdev@vger.kernel.org>
References: <20240715023814.20242-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240715023814.20242-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T58X8atz_8Ey9GE3Oj7W9Tiif5DrwHLz
X-Proofpoint-GUID: T58X8atz_8Ey9GE3Oj7W9Tiif5DrwHLz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407190108

On 7/14/2024 7:38 PM, Baochen Qiang wrote:
> In transmit path, it is likely that the iova is not aligned to PCIe TLP
> max payload size, which is 128 for WCN7850. Normally in such cases hardware
> is expected to split the packet into several parts in a manner such that
> they, other than the first one, have aligned iova. However due to hardware
> limitations, WCN7850 does not behave like that properly with some specific
> unaligned iova in transmit path. This easily results in target hang in a
> KPI transmit test: packet send/receive failure, WMI command send timeout
> etc. Also fatal error seen in PCIe level:
> 
> 	...
> 	Capabilities: ...
> 		...
> 		DevSta: ... FatalErr+ ...
> 		...
> 	...
> 
> Work around this by manually moving/reallocating payload buffer such that
> we can map it to a 128 bytes aligned iova. The moving requires sufficient
> head room or tail room in skb: for the former we can do ourselves a favor
> by asking some extra bytes when registering with mac80211, while for the
> latter we can do nothing.
> 
> Moving/reallocating buffer consumes additional CPU cycles, but the good news
> is that an aligned iova increases PCIe efficiency. In my tests on some X86
> platforms the KPI results are almost consistent.
> 
> Since this is seen only with WCN7850, add a new hardware parameter to
> differentiate from others.

I asked for expert opinion on this patch and received the following response.
Baochen, can you take a look at this suggestion?

> Aligning headers is sometimes done, but it appears the driver
> doesn't support scatter gather? I think the author may want to advertise
> scatter and linearize manually in the driver, to a correct offset.
> Because now core is linearizing the skb in validate_xmit_skb()
> and then the driver moves it a second time..



