Return-Path: <linux-wireless+bounces-16757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A499D9FBC67
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 11:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9E4188679E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 10:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D4E1B4F0A;
	Tue, 24 Dec 2024 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="huiOGkTX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B91B18FDCE
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735035612; cv=none; b=nPD73ygi9dSdSTtY7ag/K4tl9InnR8ow0g7wS48GIU7U5mEvi2h0pDZdzIhNRaE2jtxbTIPasECrHH5YPjqoW4sIi2y4/+RvFm65DfhCk1X3L7O9brGEsnBiX8LDwjIYW/eQ1+kVjbPSgp/Head1PQy0FORuj0H6nxaRwjYHV9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735035612; c=relaxed/simple;
	bh=ZCbS9EAuMcCptrR3eGFo3aJ5p6JyXCVQKzMJQMi4VBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R9CyrNy46q1MWEB1lL5Z0XiV02fxch6qXR3pt7JASxhw/BxoLPbjEaCIyaL1sBA28B7UdBS51jc1lS1LAcW4mXkMV8QWQNaG79ZqgM/CL6P+AeHxxpcUn1ln/B1+/EBAsx6Ng1eknSp5/3Ei+5/dwStlt0KMW64MnwfSt+Z1OS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=huiOGkTX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO6HjUZ003231;
	Tue, 24 Dec 2024 10:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7Stx8O2lgbohE1wXcrHRFXRZBfFx2YRl1Mu1H9t4soM=; b=huiOGkTXhUOLKtCC
	2BjHC3OXYr0JnWslQG1CRcDUoJJ4y2RFYrKZ8Xuq6hJ0xmH7q/ScDSGQijObNlh7
	r1Xc+fSCRhJQATFYPtKIGCt8R1kXfdJvO4YPWZ5oVPn+Rq5QwjuqRTcLL4q0cISQ
	UtXCWcb9oPLdXRGzWb55s1qBzjJPG84GWfq7Zhu6tkOf35Istjnj1GajP00Lnr17
	YylBetPVB+3mnmhzkdwQPz5sj72qKAxXIiViWa+5/A55pF+8qCGIxjL0DK/j82zw
	mXD2ImPqJT+6fi5YHIA/xMM4RMpg7UJ5wl8maEhkOzF5k8a7qIN3FuPmbhQ7Ex7B
	tzYJUA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qqjh174s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 10:20:07 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BOAK6Fv018784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 10:20:06 GMT
Received: from [10.152.206.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Dec
 2024 02:20:04 -0800
Message-ID: <088e894b-5e73-4a0e-ad68-f32b8f21aab7@quicinc.com>
Date: Tue, 24 Dec 2024 15:50:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] wifi: ath12k: Support Received FSE Stats
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Dinesh
 Karthikeyan <quic_dinek@quicinc.com>
References: <20241217095216.1543923-1-quic_rdevanat@quicinc.com>
 <20241217095216.1543923-7-quic_rdevanat@quicinc.com>
 <87r063hkpt.fsf@kernel.org>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <87r063hkpt.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KShU2J7Px6tVXWImYopgDh2FSHlDYMvZ
X-Proofpoint-ORIG-GUID: KShU2J7Px6tVXWImYopgDh2FSHlDYMvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=820
 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412240087



On 12/19/2024 6:51 PM, Kalle Valo wrote:
> Roopni Devanathan <quic_rdevanat@quicinc.com> writes:
> 
>> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
>>
>> Add support to request received FSE stats from firmware through
>> HTT stats type 28. These stats give software and hardware FSE
>> stats such as cache entry count, full cache count, current and
>> peak occupancy count, pending search counts, etc.
> 
> What does FSE mean? It would be nice to spell that out.

I'll modify the commit message in next version.

> 
> Acked-by: Kalle Valo <kvalo@kernel.org>
> 

