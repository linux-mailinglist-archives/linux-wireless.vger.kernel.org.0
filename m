Return-Path: <linux-wireless+bounces-10549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8561C93D744
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 19:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431DB2836E2
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75907494;
	Fri, 26 Jul 2024 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BRwFYJ6a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3845684
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2024 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722013467; cv=none; b=qdYMS71qLqvir9ge46xFwvdxMSBANEEXIuJHLXVhC8lh/Hzb0sa4qtYgzuH3fPwQt9P9az1tUoun4ba0jigB/g65gK1PTKdg5qirf2wieiN92SXBTtddrvd5tsKsRUG1OV0yN1H7ShuUmPaMYh0QtDsZGTYEndmPvboW7JtxTa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722013467; c=relaxed/simple;
	bh=jUDzrI6pdxHPJIsaWP8bT7QJJDjMLofDZ9BsvgOb+0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lQRemY4eMaEF0Hsn/CDfNSfBqqgR1tn1Sxhuk7ZzbOJjcmGoLrW7VzXoKM5PlpAWRIT9bH5pKrfKcPSrVVZpgJHYtPd9ZkBcu9mOI159BBUNCUVFkYhByrtA9JqjcGIeoE3NuMX39ArUQkhGTA1+W7fD02Tj9tNpyeFTwT4Ogv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BRwFYJ6a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QBsJKL023079;
	Fri, 26 Jul 2024 17:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BfklB0R9Y8l/WhmWGxJRvZsF0hUQx43qiR62ONI2yHc=; b=BRwFYJ6aTHCYt+2S
	LfkQGPyhudplo0y3JrICnQgZGcxKE0NbfIiUaRqrumw2vVPYVV83LOTE/d99YcYz
	VUcA8SnA9dAFgk5MZLppkrnnFhiFRfNOmFLCua6ZOzT6QLwvq8mtUSS8FIqc9emd
	uFlYaFz/GUuu/l3bkJiBoqCxjQp+egkNgMiOpquWFDflw47M0RRPihXTQdBfHDTf
	xAYQzjboMBASFlfrlZcETB2BtknUB6080zVV7OAbwGO1/NcQ2gZR4cE3jIgCFPHK
	OeIdDMG8wjwiYzeAOB7S+lHinUFkDqFYNkGMl4Et59LFJBri4kW7yzfs/2+lQXms
	aJKgcw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40m1sv214t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 17:04:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46QH4GYj001303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 17:04:16 GMT
Received: from [10.111.176.158] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 26 Jul
 2024 10:04:15 -0700
Message-ID: <43f5cb3a-e601-4a13-a1bf-c89dcc0cff7b@quicinc.com>
Date: Fri, 26 Jul 2024 10:04:15 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] wifi: ath12k: delete mon reap timer
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>, kangyang <quic_kangyang@quicinc.com>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
 <20240725120035.493-12-quic_kangyang@quicinc.com>
 <2a44b24b-f122-44de-a053-fee07753eb7e@quicinc.com>
 <52318022dbe745da8b18892c26d78bec@realtek.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <52318022dbe745da8b18892c26d78bec@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2xt1GbjVCk1gyFfAAOu25hA207K7jzWb
X-Proofpoint-GUID: 2xt1GbjVCk1gyFfAAOu25hA207K7jzWb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=485 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407260114

On 7/25/2024 6:57 PM, Ping-Ke Shih wrote:

> Not sure if you send out this mail incompletely. Lore [1] doesn't have complete
> message neither.
> 
> [1] https://lore.kernel.org/linux-wireless/2a44b24b-f122-44de-a053-fee07753eb7e@quicinc.com/T/#m1011a89113009a14c9d450dba31d8d11d36b5b6b

Thanks for catching this, now sent with my Acked-by properly added.


