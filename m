Return-Path: <linux-wireless+bounces-13858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D2E998B23
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 17:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632E11F21E62
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D4C1BC9EE;
	Thu, 10 Oct 2024 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S4w8Xdfg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9A238396
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573294; cv=none; b=rL/qCIplV0ByoPsr+UyCFIgwPQ3E6b60D9aYJo1W+XQuAp6dAdmlFH/RGHm+muwAwLqD8hvA/BUV6ADCU3UELPZqqOKCR5whq7g73//D+5NLbFk0TkrNverKzFqm4AvjEnYJ0OVU7FvIX6NQ8Nt98fMy6bwEbmxo/tDSd1JKLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573294; c=relaxed/simple;
	bh=l5VQhnBtW7QMnifPB3/AxUuqvzgU3ISagUCklCcoX7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=otTEoY8+dasbCFoqu2uJhWcXf5CK7Fv0Ln8CKplVpfaH/Nayijzwz/1G9W+LdZS1qA9eYmImEvZU95F/Xjgp5nHNTdZgAVsolY50/uVhMmIzfAV3ubzDMWICUActeVzMfimZfKKWYFrx3MW9z0TwDNvuANw1xYATqYDVahed7c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S4w8Xdfg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ACVM0G023563;
	Thu, 10 Oct 2024 15:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QNtt0dPjgL23uhZec85vU9AyZs85zoV1xd56rwQcLFk=; b=S4w8Xdfg84XmZZSy
	zZcWFcDWerXr+oeNXrNVca+H5I7jEcmdVCvdMo9i5z0IYrmW4CEIZPqz2jAZxK37
	7/IcK0RH2to4t9D1I97Yk88ynIDBB4R/RZWaCtUITSvVzL9P60HFh3+Ob6TUhoBR
	2GdpIt8uoqrg0xUO3UFDzv8CI8GXggNgXOfQF2pZwZcQsbkdCmwE9sefTQ7rxGz9
	HVd2fmV+V2nRl1kypjUwsxg+6jBhWfZkvjKSs9KpMohXbR8nRFfka7MHmXNNOrgG
	AfToWBrVW65OKj+rQY7QXYh2N20SUWbLj1dO4OOU/XFfET0OFHoBxWFhVFc4diWn
	1kCBVw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424ndyhvey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 15:14:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49AFEkfI010122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 15:14:46 GMT
Received: from [10.48.240.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 10 Oct
 2024 08:14:45 -0700
Message-ID: <f77bfa26-8625-4f64-b644-aacd4f299d48@quicinc.com>
Date: Thu, 10 Oct 2024 08:14:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] wifi: ath12k: switch to using wiphy_lock() and
 remove ar->conf_mutex
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241007165932.78081-1-kvalo@kernel.org>
 <20241007165932.78081-4-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241007165932.78081-4-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IS8xv6_gE_4Pm6lf5ZRHJbvOveUQnUK0
X-Proofpoint-ORIG-GUID: IS8xv6_gE_4Pm6lf5ZRHJbvOveUQnUK0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=789 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100101

On 10/7/2024 9:59 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
...
>  drivers/net/wireless/ath/ath12k/peer.c        |   6 +-

This file is missing the Qualcomm Innovation Center 2024 copyright
I'll add that in pending


