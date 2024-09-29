Return-Path: <linux-wireless+bounces-13278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7191098929E
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2024 04:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BD41C2081D
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2024 02:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE4FB667;
	Sun, 29 Sep 2024 02:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BjR/JnhK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D7E566A
	for <linux-wireless@vger.kernel.org>; Sun, 29 Sep 2024 02:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727576202; cv=none; b=YLdKpRipqngukLf6D5NJ4ZKWxksDLIafBLNz8Av3BMtBdXUrxMv5ItGOp0zjAsd+gydtuWAwq9Q4Xb3S52DmuGGAAVhJEVvvJi7xxAGosjmssShhn+2Gl2lZPtNImvXEb2miaZDA3H6WCJPCEvOSAOX0hpXiry0c73zxkeTBnRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727576202; c=relaxed/simple;
	bh=Ir11AGJoid5+uNs5v5hNSDm/Twok410BnGelvXqLaJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Axw+PnmFqd3pd9/fjqSvvjqvUKW7upbtoOBV1BQK33QkKcVeP113MYtQZ2Z0XuOhkHdKQyMtCFUOBaA0P5F7IF5rBSEX7s463wM0XeufkeArCr5fLZJxywvQlyrw7ONC9Ji9xLbgIFnfxtGTeMv1SBQy3RunRwwXDbNS6q/bmtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BjR/JnhK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48T0PruE023357;
	Sun, 29 Sep 2024 02:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ir11AGJoid5+uNs5v5hNSDm/Twok410BnGelvXqLaJg=; b=BjR/JnhKDHfq1Dfi
	ZefheZ7p4TubooEZzCR4sRUk2fsOgyRk2avCqxktG4L4XqgaSKMkCNxF62WcB/yp
	MyS1dXAr3f/cPSZRNNe54SynAmkp307SOPtGbhLyJuULRh97CJ4CbbisCQXEJb8Z
	+pmBAKgfn7tCGuT0eWLeSR4d+B//yA2WZrhudrpLVvZiJv1rnvTpm+AHZ5ErzE9a
	oyuLsCQs6aWGvlGpDdN8ZWWH5hYkKD55ySwUeeCETY4zpTSXtsnkItYwERGY09wB
	sol6jKKELHw86XlHjKRG9VxHQXwzlS4PyiB0g042w7QN2ESX9TWMy6BtWTkgik1a
	iddXow==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xb38sfb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Sep 2024 02:16:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48T2GbT6032389
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Sep 2024 02:16:37 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 28 Sep
 2024 19:16:36 -0700
Message-ID: <564bb38f-aef1-4981-b706-926eef5c6776@quicinc.com>
Date: Sun, 29 Sep 2024 10:16:34 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k/WCN6855 neighbor report request made immediately after
 connection gets no response (with MFP)
To: James Prestwood <prestwoj@gmail.com>,
        "open list:MEDIATEK MT76 WIRELESS
 LAN DRIVER" <linux-wireless@vger.kernel.org>
CC: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <eb41d8ec-c4f1-474e-a938-099f27aa94e3@gmail.com>
 <fd90d471-503b-4f58-ae11-bae2afab08c7@quicinc.com>
 <0d1dab88-66a0-48c1-bdbe-777d07c3132e@gmail.com>
 <70567137-dfb9-4896-9e6c-6c02a97228cb@quicinc.com>
 <15c909da-f01e-43ee-b486-f9b6d5bcc29c@gmail.com>
 <26302980-4cd8-466a-8de1-4be10a42536a@quicinc.com>
 <f65b609c-0813-414b-885d-24257e76e6d0@gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <f65b609c-0813-414b-885d-24257e76e6d0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ry-qjHDJ7evn4IHLt4rTu0KxrQvjFwvA
X-Proofpoint-ORIG-GUID: Ry-qjHDJ7evn4IHLt4rTu0KxrQvjFwvA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0
 mlxlogscore=778 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409290016



On 9/27/2024 7:53 PM, James Prestwood wrote:
>> here is the sequence I saw in sniffer:
>> #1 AP send M3
>> #2 station send 'neighbor report request' without encryption, though 'protected' flag is set
>> #3 station send out M4
>>
>> is this the same with what you saw?
> When I was able to capture the neighbor report request (rarely) it was after M4, not before. If you're seeing it prior to M4 that seems strange, unless the kernel/ath11k is doing some odd queuing?
yeah... firmware has some odd assumption on the sequence of key install, causing such behavior.


