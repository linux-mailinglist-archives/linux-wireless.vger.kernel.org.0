Return-Path: <linux-wireless+bounces-4575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57191878735
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 19:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3772B20FC3
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 18:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33E4537FB;
	Mon, 11 Mar 2024 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="blvCPZ8j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150C405DB
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181459; cv=none; b=eYytt6HlBW23lUWNaVMar61y+A/w2z6l3qPQYx6E6nbdZtz9UOrNEBLCDcKcVhd3THKVfOvPmf5fuGC2+9x0tt+xgOv0Wb0z0VzjXw22zSdXqxz2pPrueHRF5mMX+gou0Khnci5sZ+3513szA31lRgzxwnz0obluf5+Fxe44Hgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181459; c=relaxed/simple;
	bh=U8E92IU9DtUQxBvBJ2whjQTdyZl1lE/b3qMTL9DJgf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SZATd3gG5PRPteQr2l2egvDwJPgHDS4ftVq2Z3SC/9axGnWTI71Mg0MtMUeySMK0dtzbhuNiYA69rbbLhaM17Ogi+sYFt24Pu6JUkQGk676BDM4T3wIOMmo+Dcac8e7Z3zZ5KeGb+qa27mKxgVaeD3mo3pr44NIrPjApcn5+svk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=blvCPZ8j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42BI6d5O015197;
	Mon, 11 Mar 2024 18:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3dbnZy9PMAwLUevb9cJ5wVzKNdfRDIk6OIje3IIgNk8=; b=bl
	vCPZ8jrHp3oOXP8ee9kkLZfuWgXXbiVHsyLtNOz2PVqd8RhdDSlS9xafRLxfCaIO
	JKjo9AnxwBqJxH6y/bD+EFWW/nOrQINYklTu71PyEGv5whGlHx8lUN9oEo7RgyK+
	vNroAi9JCfCBBxBSnJevGIxSJ4AZGyLuzYTxvaZg4kNc922wPzpF2xE7bWkQwQzi
	4/yhcHo5ndRKh7HxROSgDzvll/AcvnhePRGRu+uOkVQrY+Ej8Pmb1yOhjmyYVSFU
	CadBgWTBwCNszcBkITF0SH35FHeCx5n2cfaXYWa/bLWIVqMML4eU7+nOYHxsokHm
	34V0GTWtzy7XjyWqMuTw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wt6xr01f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 18:24:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42BIOC4q022319
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 18:24:12 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Mar
 2024 11:24:11 -0700
Message-ID: <65a0c600-ce42-4945-9a7f-6874cb98ad34@quicinc.com>
Date: Mon, 11 Mar 2024 11:24:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix desc address calculation in wbm tx
 completion
Content-Language: en-US
To: <quic_tmariyap@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240311180708.9334-1-quic_tmariyap@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240311180708.9334-1-quic_tmariyap@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C89pv61tODLIF4N8wEUVO88o-DYWsgAi
X-Proofpoint-ORIG-GUID: C89pv61tODLIF4N8wEUVO88o-DYWsgAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110136

On 3/11/2024 11:07 AM, quic_tmariyap@quicinc.com wrote:
> From: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
> 
> In tx completion, status desc is obtained from offsetting the address
> from wbm ring. Having HTT_TX_WBM_COMP_STATUS_OFFSET(8) and reserved 8
> bytes in status desc offsets the address twice and read the values
> from the incorrect address. Hence, remove the
> HTT_TX_WBM_COMP_STATUS_OFFSET from wbm completion address calculation.
> 
> Also this patch is applicable for WCN7850.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


