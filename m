Return-Path: <linux-wireless+bounces-10315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9408D934338
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 22:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515351F215A3
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 20:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5DA1EA71;
	Wed, 17 Jul 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GBsuSi1+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0042C181B8E
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721248177; cv=none; b=K9O6M6zdx6QR9/hTBhR8v3gXYqtsRC/W3O65GrfT7Puh/50WlP1o7KauuzPVJcev5o3jjX7/s5p53TtmZ4rVYlMmWhSlZ6vNoH3h7gxzdaryOaDAY7KQoS3hGo+4f8BF2sbnkTKFPU29zHfP9i2L7iLh6aLCs7+GxaFGHE+9/rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721248177; c=relaxed/simple;
	bh=Umz+iIL546odVY0kgI0cl2Key896mKOXlbty/jmuyYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lLSj8BdZ2DvBgkCWqD8vF7+8Y2Ftl5NyC9J/FIZAbH/KjT5v7cTIX8lb6XJBZW+2Y26emtKHNPQodDLJ+/CqYSjA46IbQPk2iwLYMGlxPwspkq3maP1XHXghW6cK2xES9jEstb6h9pNxu53K9mkHtulPJS+NcoeX11XbM0K5xmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GBsuSi1+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HFq1rK028343;
	Wed, 17 Jul 2024 20:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BvMOdXxPx7FQVfR+b1ORo9g1/OmWkFB/985dirZ0xhw=; b=GBsuSi1+USXJT3fI
	eQOQkWFVvvrwzJg+Iqi6pi0uCToyYJYHe2VDVW3qcxSQFqkdL//NljIPlBezh30j
	N2+5EKQeuGZi/sWFQz/8l8NnU6teSsdZJJ1IDXoO3tkwPCjuP+FF/RpmtZ3D/70k
	6lkDuh46v6KLQTi7cLAK1NOvzWJtXnj70qt/lwN9WTQ113sAfYheV6IPv+4PRs6s
	hxgwYf0t7R8jAb5eQvbvVzKtleC+Wo30UfnXDJZJiH4s+Ngi6qsXgDNb171Cbqhq
	hFRE5HYRitUyrY5CGqh9DaiiZPEadVCwdKRsTf2SDuIPdvFLHdbhyu1ZU+VOmciC
	O4ZikQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfpkn33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 20:29:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46HKTSiJ022091
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 20:29:28 GMT
Received: from [10.48.247.102] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 13:29:27 -0700
Message-ID: <89c39516-38b5-4085-9aa0-42b9dd0c0d89@quicinc.com>
Date: Wed, 17 Jul 2024 13:29:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: Add firmware coredump collection support
Content-Language: en-US
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, Kalle Valo <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240605034639.3942219-1-quic_miaoqing@quicinc.com>
 <874j8xb4m5.fsf@kernel.org>
 <870d1749-6f6c-4ca9-b852-7a511e70103e@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <870d1749-6f6c-4ca9-b852-7a511e70103e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l993qM9sCa9qbK9el2OnnVlutYhDjVTW
X-Proofpoint-GUID: l993qM9sCa9qbK9el2OnnVlutYhDjVTW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=963
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170154

On 7/12/2024 2:38 AM, Miaoqing Pan wrote:
> On 7/11/2024 12:20 AM, Kalle Valo wrote:
>> Miaoqing Pan <quic_miaoqing@quicinc.com> writes:
>> I feel that the QMI changes should be in a separat patch and explaining
>> in detail what they are about. Didn't review those now as there's no
>> explanation.
> 
> Minor changes for updating 'iaddr' definition. IMO, don't need a 
> separate patch.
> struct target_mem_chunk {
>          u32 prev_size;
>          u32 prev_type;
>          dma_addr_t paddr;
> -       u32 *vaddr;
> -       void __iomem *iaddr;
> +       union {
> +               u32 *vaddr;
> +               void __iomem *iaddr;
> +       } v;
>   };

Putting something into a union isn't minor.
You should justify the reason for doing it and defend why it is safe to do it.

And note that if you make it an anonymous union then most, if not all, of the
code changes are unnecessary.

/jeff


