Return-Path: <linux-wireless+bounces-6183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7D28A185F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 17:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A93C1F24FD6
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 15:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CE41CFB6;
	Thu, 11 Apr 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GjhRA7Ii"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E911CF96
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848407; cv=none; b=p0F/HfqcO3caGWxuRWmlCfR8Ch7M2M2kJhVggMU0XwrCAx0lI9BfsUvabxXnxwx60uPwA9WP5YR5E9TFY3OeIShneyIirmTEuyxZGdQe+RrHEx4xhQ7rt3oUgiztR9tQB5tK6uaE9HduybiBIa1v+Q3knEc8Yf+BQGb1n8/6mqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848407; c=relaxed/simple;
	bh=Gez8td6y4UjFYIq/FhkDYRQxY39JKcU1CVJuQ+6vKrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NKch9W/4p2t64q0AvK5Ey6w/yp/E4xT50ZSueaW/3O5bwgXdZBYHc+NE6zFSVc2eciMOWhyFknw/eiO4RpurSjwLKKXw/0AECI7PGdN+7eV4zz/aWpC/0cipiC3dL0HYiZIyvf3HmxzhY0noqiRTTzzBf1lQeXAkxkbArLsrWNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GjhRA7Ii; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BCWmZj031539;
	Thu, 11 Apr 2024 15:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GBuE6eCNbDqZR1Pi7BGBtW/65ideVjIyYr55hOtH7Zk=; b=Gj
	hRA7IiTVvJtk6NI4Xe8uuvzXpLiNQe3IYJkvEdKEPXMDvYNx+WKZJBLJhryCV5qz
	/M+DR7SJV2cugzoNZxOWt2lzWmB7uZp6HiRjDtWOHJ5JD8e1wjM8EWph+gaIbJ8e
	lgfxSfMx9CDT/JfyFwEZmiHgS8A7uSKCGrXgx5LWCaL9LXmM3Xuqm3nrsHeeUMy6
	17TPYnuxfwq6ko3ICDmzSqmAxMqTB0J/qZpRMi5BQyebp0EaW8L8J5vwDfYmY+tI
	yG4QPO6D45hxendJa6Opj4oE8+bIBgR/5CMFf41sILYO5ptgfhg6G9Wl5oDG6sjn
	jjvzHNl4vNqYIG1F80bQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xec6dhfb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 15:13:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BFDFaA019157
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 15:13:15 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Apr
 2024 08:13:14 -0700
Message-ID: <260c6ca9-0d82-4e6e-bb17-9246578bcd1e@quicinc.com>
Date: Thu, 11 Apr 2024 08:13:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix mac id extraction when MSDU
 spillover in rx error path
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Nithyanantham P <quic_nithp@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
References: <20240329092432.873710-1-quic_nithp@quicinc.com>
 <87bk6gz1jc.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87bk6gz1jc.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l4nygddEqEQXdxTMIn7aZzHEdy5Cwipu
X-Proofpoint-ORIG-GUID: l4nygddEqEQXdxTMIn7aZzHEdy5Cwipu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=524 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404110111

On 4/11/2024 2:33 AM, Kalle Valo wrote:
[...]
> The else branch can be avoided with continue. I did that in the pending
> branch, please check my changes:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6c677d91adad4817e7f6ef65a85331f52f0237ee
> 
LGTM

