Return-Path: <linux-wireless+bounces-6979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321328B54DA
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 12:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E273B282C0A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 10:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CE42C84F;
	Mon, 29 Apr 2024 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kMZRxtTi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1673628398
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385810; cv=none; b=FLW2ishDuTy/P+zoaHxzOGHXl16P6xZK3ZBDn/jHZvit2/nekR4bJgUfQFyOlzgx8cOjyNrXl74gj0ylAQCortYlUAF4IRtJrkJz8SVpa/6TyYyw0WG8DTE7yx4ZOVgGFn8TU7RTY0sD41g1zwzQ8ZolkxCh+LOLHhTyoxqw8dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385810; c=relaxed/simple;
	bh=xSvJeZdiAUuOGBiTDr0RgZ/UmUcOTZXqOLjBdZwU1/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O4nZpwj3SL2mES4OAyd/Ei5nP7EuPe4Gj9zEJTb56ddhCFFKtiOx21NcNDqDvonjxuODxnYdXDYUz5jRyTjJRwLh8ZXZUYlcIuZ3JmP1XekLFk0s4dT7QBqJoPajAJJRuTLMw7J3m9YnPyxm1ZPT22l1XaXjjxEO57ZNr4Co5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kMZRxtTi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T8ZqEp017158;
	Mon, 29 Apr 2024 10:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jPlEP33CYg+upQYQFVTflX5bQM94xo05FV4pnt4rggg=; b=kM
	ZRxtTiCT4Yykw1bQTb03z5zrceCBQOgPQNI+//RMXE6GrXm2dUjGx4S3yT0zgdl5
	D8DUAWkp9DyW8pzNSpWVZLneCM9Rhapugdh7xz55KJpFMmFhD5YstS7CD9tKCQyw
	+kshwTX+Yd5Fk3wxD/9Ie10aeowUP6N2K1OO/DKO+epyoK+fOsnP8E/RKZ2AhXaf
	GNNbZ7NE1srjNp4F+vBm6SFMPpM6GXo75v3Xfbz/RzQBs0Ub+xLGYhD0SoHpJS4n
	AZbdHH2xmuj/wIerBmEYYZQn7QYKkIdt3sDDwD7EwpiEEWqu4FnPseCnMlkPZwqp
	zhhH0R2hbS6K/gZneCgA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xt85s86cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 10:16:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43TAGadm015491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 10:16:36 GMT
Received: from [10.152.206.169] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 03:16:34 -0700
Message-ID: <7848b9bc-e3db-f131-9329-3a2970370fda@quicinc.com>
Date: Mon, 29 Apr 2024 15:46:31 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] cfg80211: Allow pre-CAC for self-managed wiphy
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240429042723.2847389-1-quic_hprem@quicinc.com>
 <87mspcr57t.fsf@kernel.org>
Content-Language: en-US
From: Harshitha Prem <quic_hprem@quicinc.com>
In-Reply-To: <87mspcr57t.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qosp8iYXwrGtoDqR1AnZWXfrkZmawhnq
X-Proofpoint-ORIG-GUID: Qosp8iYXwrGtoDqR1AnZWXfrkZmawhnq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_07,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=596 adultscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290063



On 4/29/2024 1:05 PM, Kalle Valo wrote:
> Harshitha Prem <quic_hprem@quicinc.com> writes:
> 
>> Currently, to allow pre-CAC it requires both driver's regulatory domain
>> in wiphy and cfg80211 local regulatory domain to be same, along with the
>> region to be in ETSI.
>>
>> But, for self-managed driver, some countries have mismatch between these
>> two regulatory domains and it would not allow for a pre-CAC. For example,
>> in ath12k driver (self-managed), country Sri Lanka (LK) is classified as
>> FCC domain as per cfg80211 local regulatory database but as per ath12k
>> driver it falls under ETSI domain then because of this mismatch, the
>> driver might not be able to do a pre-CAC.
>>
>> Hence, add changes to allow pre-CAC based on wiphy's regulatory setting
>> if it is a self-managed wiphy.
>>
>> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> 
> "wifi:" missing from from title but I suspect no need to resend just
> because of this.
> 
sure, missed it. Thank you for pointing out, I will take note of it.

Regards,
Harshitha

