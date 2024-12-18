Return-Path: <linux-wireless+bounces-16547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971E69F6BFE
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 18:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77FD171D60
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 17:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2585E1FC0F2;
	Wed, 18 Dec 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jC6yJCHv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D11FC0E6
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541634; cv=none; b=fRDyqFtB01xE99WLlqVqGx3nW0LmSfl0D9OBVCHlDgCkrjZUuZ0//II2p2/nqef50VH0OfJ85IJ/2wvdUQrSCbA4YHqQbN5cROtgyevYdFw4enqfs7RTx5MBlNtyfye6KaBaIltfYF1ZAMYeXdRcqnqaYWGB29nZdKsIfrEVlq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541634; c=relaxed/simple;
	bh=SuuW3tVcMOJmBdlb+um6PeoMAYru60GAvWKIRwLajbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hHqEUfhtLsf+YAhCxWORUG6HkTHe5ZqypoL6ngKuxy89oGcWsrB0f5jfqRKD7Vuma326IHrjxddHHE1Yl2qBppjfjHPDlTaTR2ISHylAJr+zEAgOm0vEX0YGz2t+b+T/tQwQXde/VgQDOddIcaF218xNDOVdCluyKikbkWWf4QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jC6yJCHv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIGR0mN001514;
	Wed, 18 Dec 2024 17:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SuuW3tVcMOJmBdlb+um6PeoMAYru60GAvWKIRwLajbc=; b=jC6yJCHvlrrLKbIY
	zqP8CG9D94abIWcmN4U6L7G8Xcqemod1AOgVB6ZFhNEP3TG21ZOJ4VQxQpZwxTZh
	ZyFi2ctr2xA6QGCJfPGohLFr7pIbc7TWKZdC+DHoqPMjVB4tYWw7axx9z+FXJJme
	4JKGulsJWI+Ecth9qZBjIpnivYFZu+FG6P4Y6tDtGPDDOnytoyNF+edr95j0iQ+B
	TOsUzKm/Ebc4izxin9XTHiaA3YhbQo+1pnP68jfDhzObanyu3eK3PSUSw+3Kw+D6
	UPpcTNF7554HjuZ1ZlfE0+Qrz+kwBHlbz0rHBuGJ7PGvEiyQeXegNjnDH+wk/jNI
	xhe4gQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43kr1xstyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 17:07:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BIH73ep010589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 17:07:03 GMT
Received: from [10.50.9.84] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Dec
 2024 09:07:02 -0800
Message-ID: <f141f19a-0106-4eaa-ab08-ed92bd965c42@quicinc.com>
Date: Wed, 18 Dec 2024 22:36:59 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Add support for parsing 64-bit TLVs
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241204071238.948885-1-quic_ppranees@quicinc.com>
 <87o71bmwoe.fsf@kernel.org>
 <fda72aba-f878-426f-b410-a4cecf77d1c3@quicinc.com>
 <87ldweksqt.fsf@kernel.org>
Content-Language: en-US
From: Praneesh P <quic_ppranees@quicinc.com>
In-Reply-To: <87ldweksqt.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KkQpuwXxWrJ1nNBwzoxmxC3PXKvQdLcK
X-Proofpoint-ORIG-GUID: KkQpuwXxWrJ1nNBwzoxmxC3PXKvQdLcK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=702
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180134


On 12/18/2024 1:05 AM, Kalle Valo wrote:
> I am not exactly looking for a Tested-on tag. What I'm asking is that
> people take into account WCN7850 when designing and writing patches
> ath12k. For example, is the firmware interface same and similar
> functional differences between supported hardware families.
I'll make sure to keep this in mind for future patches.


