Return-Path: <linux-wireless+bounces-4764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BC387C225
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 18:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7898B20C7D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 17:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CB1745EF;
	Thu, 14 Mar 2024 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kxd60uLp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADD774297
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710437688; cv=none; b=Z72f/PR9GGst8ruc0wA+vDLAMGQF8q6l0CUBPnXsRri5c/9NuPgUTaWg3fdrs7LFMy6q2gzQVGibv0L14CVvO/a1qZ/W9NzAi7wOlZV5XKun7IlCHfvB6/WssPSjYz7ZADhUtiIXZIvKQ5M+tzB+21vhfvGH52BPPHLjpGoXVQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710437688; c=relaxed/simple;
	bh=P5RxM6PEl/IjlhcnU7Ipzc8shzhPZbseqd/gRZCwzvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=St0EIm9lzi32hZMcmd52gM2r69wK/x92UsD9b7CMlFd/hTzeYpyEeGssgpTgFbECcefsXshVlfPVw684r1CA80lMzfAf2V04rEI0iNMjTtyVuTP+6eJh5p1XEnhyyYQTCOkAyQe+JxeKgT11wHUyJLkAwmtjOkk7vf+ENRW5dVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kxd60uLp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42ECulQi001886;
	Thu, 14 Mar 2024 17:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pTtSjWKFKZP3xkIxwHYHegWCYf186jtawsiTSAEXtk4=; b=kx
	d60uLpfD0/6SlTBxCwDOCg77/MTd9YJk1PI6roJmIqyI5KqGM+FPicAfMP9hbQad
	QyPoLon4ABPRIO8rtEg/di3iwsGhcqBl7S0vZrsNGqDWdhvRhB2T9l8MytKJRgVM
	bQzV1P99pyAt5x8XV+nhCqrsPNV0DgDDil3h9pC97YLhlwrw+V8SBKOLx017Rj4r
	2IchYV66mBxBg8ZEP1HUwAZgHQhJQ1GSliUBcF9iY4UQc6n7YNUuQZhDV2yMiQ+M
	kL91oQdOk80ZYTzjFrUYCX2EArglSHFTL1+KzoCljMSjlehUT+WAjU/RznymMaRB
	mW+rPOHAXILYwqtrc16Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuruqswc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 17:34:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EHYgRq026118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 17:34:42 GMT
Received: from [10.110.27.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 10:34:41 -0700
Message-ID: <a5c0877d-90ca-4661-8080-12a528422772@quicinc.com>
Date: Thu, 14 Mar 2024 10:34:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: remove duplicate definitions in wmi.h
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240314021830.305021-1-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240314021830.305021-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0PZvvTJjI0rf1pbHB3UORvJT5VAYWO3g
X-Proofpoint-GUID: 0PZvvTJjI0rf1pbHB3UORvJT5VAYWO3g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=654 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140133

On 3/13/2024 7:18 PM, Kang Yang wrote:
> There are some duplicate definitions in wmi.h, remove them.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


