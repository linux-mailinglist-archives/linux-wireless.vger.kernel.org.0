Return-Path: <linux-wireless+bounces-7850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F718CA45B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 00:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407CC1F2195A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 22:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4722E859;
	Mon, 20 May 2024 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D8GlTTbR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A61CD3B
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716243102; cv=none; b=qxfLEkEr+oSX5RADpU7vvb9lW9VuNg5MPBPbKILGzOvz3F4oak9b/+I2A8/ikBQhpb3d2kn1Y4IuCXgK3OgkLPA/spOjtxAiDKOPRMA4PtD+FEsxENhTZSRN3GVRHzk2sLcU7BVgLQGyH9FDh2icHRjX73rgJRvyA0WhhEC7m2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716243102; c=relaxed/simple;
	bh=zQPInjNj+eV4HUQ3sSdlpJB5oYIlPvgZgXFLhQu7NFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gmzIpST8azRi2CmsXeariRI32Yy6rSlwDC4YIPsK6b+0m78TkSEtm3BHHznkxxGcMbtpIk7FptHhwh8IBkMm2gRPwQgy+MBi9yg2Xa4Hm/lRPnoYacfYaUPraLLJFE7EyxNH7ooqm3U+9s9DZ545LJ4xaw5Fi5J5UEA9Kvf7TfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D8GlTTbR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KKS5jE028232;
	Mon, 20 May 2024 22:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VXw3opE0WCOujUsthmWT0LxdYflSLXqrgOu9efTkPr4=; b=D8
	GlTTbRgaUy3nyJ521bPteEufmBOn3WxyjJWPGXhxZHNlhuw1EdMQ6x3QeBw7vXGw
	BGPHXdFEj1fvVbWSmZ5vZYyLXsZum0p4DQdbJqDXsmkifoxlYl8nxr3bLPfWN6rX
	pcHuIWAj4ZIZugjEbHXhY0oYxaH1xM3GMzJCFcJDbE1wZUCtN5VF68hMoH8NTIsN
	JohpgVogPWuy/+8k6M+ySUn1pqUXFUiPPn3m/z6kJz22pvLOfLM4cAE8hn+2S+fB
	lmj017d5dLsYdsmxRLP5d5J3PfgZ/UXTBpo/2d99VW3B062jX80cZUgV9jXcqQVM
	/hKix16G/4BMy24tecDw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n3tcvkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 22:11:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44KMBWE2001690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 22:11:32 GMT
Received: from [10.110.17.44] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 May
 2024 15:11:32 -0700
Message-ID: <473a0363-fd91-4d60-97eb-2b07abd56700@quicinc.com>
Date: Mon, 20 May 2024 15:11:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath11k: refactor setting country code logic
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240520024148.5472-1-quic_bqiang@quicinc.com>
 <20240520024148.5472-2-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240520024148.5472-2-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ET4QfBTG5ETnPkXBOpAHLx3JuXKZhbcI
X-Proofpoint-ORIG-GUID: ET4QfBTG5ETnPkXBOpAHLx3JuXKZhbcI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_11,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=819
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200176

On 5/19/2024 7:41 PM, Baochen Qiang wrote:
> ath11k_wmi_send_set_current_country_cmd() is called in several places
> and all of them are just simply repeating the same logic.
> 
> Refactor to make code clean.
> 
> Compile tested only.
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


