Return-Path: <linux-wireless+bounces-15493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C129D1FE1
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 07:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F3E1F22700
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 06:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FCA2A1B2;
	Tue, 19 Nov 2024 06:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DxEFq4b5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3788AE571
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 06:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996230; cv=none; b=XSBkNxzKP0OpXgkN/ewAVviIfzJDv2f9RypvfYdKTm+l22jt3v1FbJzm1O7fXSC8P7VKTjr4R37SyVie5xwXtv5HszMPv3TTMkqYkPccN5kruJyRXPRIPAz8VCT77+9OjyMnBBrURyp1P639oREANynbt3YpfmzBSWvOuk4fwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996230; c=relaxed/simple;
	bh=N2C9/3kANGrAlY7y9Z1R6zu0jlOYdxv6CwC2Pauq6FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SKlHY+iIiVxMNx0SBvCuKrSmzdQY7HtNhTKJ3oi+AF9/46dBrvNwZgEovUa8w52o/tGS/EdMxfi+4wPOQrWZMTzD2DZ+tv1Z79SXB+Ec0aAvKGrQS2C1Oyo1BeJ2zH4E2v7KaJM58+8HJ41XRJET00ypLwrbM/y0iNPlQh0ZxE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DxEFq4b5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGH00n027076;
	Tue, 19 Nov 2024 06:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l3J7NgVxwDyt9e/DqzWT94OVe74l9OJVF7FftjHvVnY=; b=DxEFq4b5Y4Bxl7YT
	TVfd7QI/PjO9qliyviZiCvmCa9p0sgDckEjG7JfeamlTbKjwYz4T4UdM56cIUci+
	5caqFisf8OxiAPjO/zeMsE55kqeqfx8xV++EsN80fktDjUUxdrbOFc74vLf8cYoQ
	QR0GcdArnWAA3Y/yzbCmZ2fnrMKzV7h8jMmRLzQZH39TbQtA+sQkuX5MLPcyBWx2
	kclxTQpq6FubVJF8OrmrqT438jfni21eDwAD5LnEiV9qEt0kAxV2JmJkDrXAhaea
	zgr2jGizXj+dw7YF/01+scvZu+4r6YyTw3riJrK2iDmsMLwS1A0ccjU+PCVwAb9h
	vEOJ9w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y7skvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 06:03:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ63iUm006930
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 06:03:44 GMT
Received: from [10.111.176.82] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 18 Nov
 2024 22:03:44 -0800
Message-ID: <fff17b6a-4575-4a7a-82c0-793b9357770d@quicinc.com>
Date: Mon, 18 Nov 2024 22:03:44 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] wifi: ath12k: Fix the misspelled of hal TLV tag
 HAL_PHYRX_GENERICHT_SIG
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241119003248.1579567-1-quic_periyasa@quicinc.com>
 <20241119003248.1579567-5-quic_periyasa@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20241119003248.1579567-5-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Cg1rZ6ZL_ceblfR5M7DXeY0gxSr6JyDA
X-Proofpoint-GUID: Cg1rZ6ZL_ceblfR5M7DXeY0gxSr6JyDA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=758 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411190044

On 11/18/2024 4:32 PM, Karthikeyan Periyasamy wrote:
> There is "HAL_PHYRX_GENERICHT_SIG" misspelled as
> "HAL_PHYRX_GENERIC_EHT_SIG" in the comments. Fix the spelling.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


