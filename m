Return-Path: <linux-wireless+bounces-4574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5136F878722
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 19:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5A6280DCF
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 18:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2D4537EE;
	Mon, 11 Mar 2024 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VCWXC6Jr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED551C44
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181099; cv=none; b=uRPenruAdc/JzSP7IDLSiGCt8l6kpD02sHNppZV8esf0iQe55mQDAKwbbabe0wk/pFVV63sXxU7jfacSuKY0Fx6DNCmdfi+OGZRC8lHhOrRUZgwQAz4xIbSn/iG8rOQbJAjc/tF8iAQ/Ym0kjrwyksv7bSVAoIF3RyK4LbRxu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181099; c=relaxed/simple;
	bh=Tnre/ZUUW7fRvo9VAN8kManTUpfguF0nt6xrYXlkoz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LIHOWpNKasdDBX8SwoiaLV9YAyjd669bA539cjKZHaqTqtglersB81J7/LSBJtmK20lOG3GROrRVqUIBSuPwbfMZhnN7GIeV5Vxq/PIklSZNshq5GrZoPoHCruaKWTm4iqYtRbUu5wLVhBEZYSiXr87pf+AzJ9vDLZ+vc8j7oxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VCWXC6Jr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B9FgEi002666;
	Mon, 11 Mar 2024 18:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=KO5i3BqOOODm4cJPRuqRklfpmy5UHE9XMtoyG/3tn1M=; b=VC
	WXC6Jrvh+kKGz+f2Tv26fJq6gX6Kq+BVWLD+ozZxhWAse2jsMT00KjSJhOkoyZvW
	JxfXChwicq80BXP7MhhL0RCNgfbDBAK4Z3Ow+BcyHxVzTAwooVZkfQzbmVJlxguI
	ICvat2z2L0g7RrkaAiWWOxB1wew0yFZonEJIaSnKUH17kRFiWCXMQY4YsFGWYjwp
	C3AjMNa+7/3isvgXu85gMw7psSqMAp7+hb+QqPwRKnlmoGi4Zvz2oIyUQDe2dqpe
	Atc8kIOi4gjCN1G4lJ7zqU5rhDJVO9F12hgW1RfZarzkc7HzBuOulROAZszibFp1
	2Hvat6Duh4qq5ny7fLCg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wsxbvhmkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 18:18:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42BIIDD7017666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 18:18:13 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Mar
 2024 11:18:12 -0700
Message-ID: <08da3726-03a9-43d2-9c7a-4fd99d46d481@quicinc.com>
Date: Mon, 11 Mar 2024 11:18:12 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: modify the calculation of the average
 signal strength in station mode
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240309121129.5379-1-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240309121129.5379-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DQukOXw-SpuxcJvlGOLnW56vlVcFcxPU
X-Proofpoint-GUID: DQukOXw-SpuxcJvlGOLnW56vlVcFcxPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=897 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110136

On 3/9/2024 4:11 AM, Lingbo Kong wrote:
> Currently, the calculation of the average signal strength in station mode
> is incorrect.
> 
> This is because before calculating the average signal strength, ath11k need
> to determine whether the hardware and firmware support db2dbm, if the
> hardware and firmware support db2dbm, do not need to add noise floor,
> otherwise, need to add noise floor.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


