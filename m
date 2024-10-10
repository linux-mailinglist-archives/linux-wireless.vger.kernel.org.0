Return-Path: <linux-wireless+bounces-13857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E7E998B07
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 17:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06401C2493B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 15:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806A21CC15D;
	Thu, 10 Oct 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="emmtN48e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24313D3B8
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572881; cv=none; b=Dz5ccktszhdCx3KtJI2pq5nykdwZOJw67G7kC0d8iuNYRCP7st4a2BElxqHDjlERuJi9ULriZdiXB9MPXGA5b3NUq6LgjyEpDgRu4opFaIUDNbiWJ+LCLh9OI9YFB14ke9YXnzbTBqrmyL+PIktkJV2mezlL5EZNCt+F3F4/PZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572881; c=relaxed/simple;
	bh=70xbYOc+b0OQ7ridozCIrF/Y5X2x4qlvXvbMc6djGBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BJJMeMTpi8NyDtxY2PVNTNkXQS13OLSWJjWCdmEI7eeTZhKtYN1Un7kCedp/CEutADmsPJPfkkTYIOZA9H/9/FoePajFLi9X0+khE/TEGXAO3bE6dEVewvUaOHZ2TrcQWU6NxK3xTfLI2YS58QhdBCb+kognRab2Qko2kfT04Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=emmtN48e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AD8kGb027034;
	Thu, 10 Oct 2024 15:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4uJIZ8FXxVwj+FxHBvJKLc+h/rcaPPZ02VemKCYj8ac=; b=emmtN48eyRmkb1Wx
	RF/POjvVW9AfvoJIDyeyORtsI/skyywDJlYVVCG5S8j8gfxvAVI1QWzGd3vaYtEi
	Ti2h+UMJ+nBy18O6N1RLnMu1/9zrBNDYhh38+9sT+EZfDoI8yiSQdqSV983KyrvU
	x0FbUWZSjOD1dT+UILpFdtp0XSX2hVLEYx1dF12r8wxp0WUQsORqckLm5teJtwVz
	+1RbK14HZVgHnxudfvvC7Do99XokQj3f7IBz/OYm5lPGxc4PRhfSz5KQDIf5uwYu
	ARCkSwCMNSmhLfNGNZfUDdA0gO/1v4ezlAh8NCXwhwrWoZkRf0WgVza0KkVTBOK9
	rGyKhQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426fj6rb5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 15:07:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49AF7l5L013643
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 15:07:47 GMT
Received: from [10.48.240.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 10 Oct
 2024 08:07:46 -0700
Message-ID: <588dba32-52b7-4b61-b208-87c6aff8cc51@quicinc.com>
Date: Thu, 10 Oct 2024 08:07:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] wifi: ath12k: ath12k_mac_set_key(): remove exit
 label
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241007165932.78081-1-kvalo@kernel.org>
 <20241007165932.78081-6-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241007165932.78081-6-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V8QPJgn8k6cGi2cS-4P-e2-hqG1PNMBi
X-Proofpoint-ORIG-GUID: V8QPJgn8k6cGi2cS-4P-e2-hqG1PNMBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=705
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410100101

On 10/7/2024 9:59 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> In ath12k_mac_set_key() removing the exit label was a bit more complex so do
> it in a separate patch. Remove the else branch and remove now the uncessary ret

 s/uncessary/unnecessary/

I'll fix this in 'pending'

> initialisation.

I'll leave the UK spelling -- don't have a need to enforce US spelling here :)


