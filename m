Return-Path: <linux-wireless+bounces-12856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CD1978BC0
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Sep 2024 01:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34678288ED0
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 23:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4308016F858;
	Fri, 13 Sep 2024 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NGss14ch"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93906762DF;
	Fri, 13 Sep 2024 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726269534; cv=none; b=XtW14lIOgCipiM5cSqmUOunwJmEpyavSASXNbL1jYcd31pMbQrmG1dNkmb89Y9TNCZZwJ9IZtC+wdJ8GsiuC0oidIqkuRYxhFTquBaGJSd/jHxS0LC+gEbk3lKquXpFuFOd4Jilol/h03ejonCFEwPk2KJzb92TK2nmXbC/M/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726269534; c=relaxed/simple;
	bh=h1qtDRbu5yoZIiGh5c2Kuk5E17UEPhcW2ztvozgmpzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NuB/ggD9bA1D3CWMWciuCEiUgwznFvl2FSHAcLe8jMHLAXpgSKzGb6RaxjukU/9zrI/+Aw/X6plpRLDh5AQC4W3IJbm3GHL794dO74I8dWLboFB7X9sVAL+lFmWzPk//sIMPJGU1ZHO65iz/au8ynHLW+4VlgSmuYRUNqXeceBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NGss14ch; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DAjut1017607;
	Fri, 13 Sep 2024 23:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OBvkUg5X9mhGHmFmGr0xVkAZBb8Krghfxg7slECJQp4=; b=NGss14chz1DUB3v9
	2uw+BXyC+qnpGs3OZahQle58SPKt6tt4NfQAbfpGsxgQqh/37y/shogEUvegGx3V
	ViWRhIUBvVwQhAV3USGpH0IAFt6K5oLor9Cm0fA8F8HQOFRRJe9x93gd6Y6ayPIZ
	4H2tT3V209NPM0fpI/WlF3zTicKUYqzVanDNoL3tUfcWkFlT9t6OJBrULU533YvH
	0RxoOpwiKL4ForZUOSDj1ZuZ5MbhvcZb3o8Nj2IL/vrad2wR7QkZ9LtExzehTsBP
	VR4FKbbFRpKueIyYiYgY65N0qu4t5/h6vIqZbVx+22hx6SJK0V6llWdhjTw22YLC
	2coZ4Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy5rt3xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 23:18:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48DNIbuo001933
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 23:18:37 GMT
Received: from [10.111.181.97] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Sep
 2024 16:18:36 -0700
Message-ID: <789e2e2f-2054-4804-b496-d1459cb89155@quicinc.com>
Date: Fri, 13 Sep 2024 16:18:35 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wcn36xx: fix a typo
To: Andrew Kreimer <algonell@gmail.com>,
        Loic Poulain
	<loic.poulain@linaro.org>, Kalle Valo <kvalo@kernel.org>
CC: <wcn36xx@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Matthew
 Wilcox <willy@infradead.org>
References: <20240913094319.13718-1-algonell@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240913094319.13718-1-algonell@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3MrkxYhmT7ljUZmg8TIsxff4pj93ebtk
X-Proofpoint-ORIG-GUID: 3MrkxYhmT7ljUZmg8TIsxff4pj93ebtk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1011 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=594 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409130165

On 9/13/2024 2:43 AM, Andrew Kreimer wrote:
> Fix a typo in comments.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


