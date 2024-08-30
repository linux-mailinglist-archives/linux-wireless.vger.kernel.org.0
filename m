Return-Path: <linux-wireless+bounces-12265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 873B5966601
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 17:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2221C20D3C
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921C31B81A7;
	Fri, 30 Aug 2024 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YTox0qKS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED54B1B6552
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032819; cv=none; b=uxvGwZzAdSkZhSFROxUbX777/ahVyOC0usEY3cd7UZCtD1XLE/cYyElFEwmo9OxWd1uKzzPV2v/w436Tx667DlYp0Hhj2Qo0Y+FyMDatoo4fnzThgrGXAqAf/gCNqgajM+g9OTbK1HthBvaGm83iYV+khj/QngizRFhLjg+QVVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032819; c=relaxed/simple;
	bh=WY1/0XEZGTq7vVs7hzr45rTHW7XvoRA6Z2XEmFY9JQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bUD4AZ26pZA6C2YvoMi7u7KJVg7OHHm/JLNyEAYeWUebSdEpRZyXrIgimb6udwiOkpUu5bFK1VX9qMzUuNbD3oDkY1wwTnXjiQ/742nsrnV/EC78uhRritG6w30BcAANu+09WQLCxooqMec9FJm8AeEX6DIa029KyQJto3wu//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YTox0qKS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UFHHxI026726;
	Fri, 30 Aug 2024 15:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	baFyKabD15U73SdQO8S2i0WKyu6HhFQ9NuAcYFga/Nk=; b=YTox0qKSoLQgU35o
	nMQvPWULQ6Tb7q/0ht0zwXMcnneJCexsSIOmhPVfTTRRO6Z3pUMdBWDBp2bWs9qt
	9LRuzTSTZcAvNSnpJJDGMmsdNXfrfG2NP+4Vw8bv0l6CHoKNcQxsNjoulGhzHp5Y
	iHZ48yl04y0xj/dKfOjhcN41D8VRSac1zgtSqTa5l4XNsbhx1At0TynlCxAGhHSA
	HNqmuuQAFbPD4kXBP1XT8SE5IFSh0xK8GdSSE5Sz+iIE9Hi6KtwgjB6P9CiyFOsc
	sX3ck4p2PuEr7J9bN7rf0iDX78g1svt02RPd8jtHCqlwOCl6sW9d5aqthfZsnvho
	/AtHuw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41a612qapm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 15:46:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47UFkqHa025314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 15:46:52 GMT
Received: from [10.111.180.95] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 30 Aug
 2024 08:46:52 -0700
Message-ID: <891d2bc3-9ace-4fed-92e3-192d8126c5c6@quicinc.com>
Date: Fri, 30 Aug 2024 08:46:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current 2/2] Revert "wifi: ath11k: support
 hibernation"
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240830073420.5790-1-quic_bqiang@quicinc.com>
 <20240830073420.5790-3-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240830073420.5790-3-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: P3z8TrqwlLK-NQgyQjZBRrbb26rY6VI-
X-Proofpoint-ORIG-GUID: P3z8TrqwlLK-NQgyQjZBRrbb26rY6VI-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=489 adultscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300120

On 8/30/2024 12:34 AM, Baochen Qiang wrote:
> This reverts commit 166a490f59ac10340ee5330e51c15188ce2a7f8f.
> 
> We get report [1][2] that this commit breaks system suspend on some specific

since we have Closes tags I don't think we need these separate references.
Just start with "There are several reports that this commit..."

> Lenovo platforms. Since there is no fix available, for now revert this commit
> to make suspend work again on those platforms.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=2301921
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219196
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2301921

I think we need to add
Fixes: 166a490f59ac ("wifi: ath11k: support hibernation")
Cc: stable@vger.kernel.org # 6.10.x: <hash>: Revert "wifi: ath11k: restore
country code during resume"

(Won't be able to add the hash until after Kalle commits that precursor patch)
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

I suspect Kalle can make these changes directly in his workspace when he is
staging this series for ath-current

> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

With those addressed,
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


