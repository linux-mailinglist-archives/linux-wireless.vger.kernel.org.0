Return-Path: <linux-wireless+bounces-14607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DE19B3385
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 15:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40201C21BF5
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E5F18C93D;
	Mon, 28 Oct 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MI6hQssP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BA7187352
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125836; cv=none; b=RX0RBRlgrjcoAsN9XYhqYK1nKRYSTgVADKWuzqkxnn8iZjA+QaMuDtTLhFg9BH/QWdJiIH7p3cbGGvC5moONm2aFAG8Pu36ZMyQR5pj5yWppJMV+tAmfTzNwKhwiekpC1/t9UPxPrMR0cnbVIT2EVzF9MHDu2yRe+wpAvYokd8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125836; c=relaxed/simple;
	bh=5OmZhbWJAajCQzptvz0GKCseCIhs2O+0f/Y3ORxmM5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KFwCgLJpIev1utFPWi5eupTwh3rDzCgCR3Va2Cbu++XpcXP1Vg87BTMPrnnwuHPj0TTFOdOadqbjLt7gUfc8ctDVMYi3RjiVCCKipq6h71JMgQXas1NFkFcMKiGWOG8urON4K6b6gEn204yUBYh/FJ6x/Wy2e/oaC1cIy+eJ5N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MI6hQssP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SB0oqS008480;
	Mon, 28 Oct 2024 14:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NkgN6yHum3km5DKM98053u7B7jwLeEKzV9U+VnqB+JM=; b=MI6hQssPOZvmxHKT
	bdqHpZ+6NDCebKnNiGFbUIQxEYVJvnLA/vEsb1QbiBZnjVhFM3lolWIqYlw5ox36
	C5oybBH4GcGjBYu3v1Sxqynps0jYBRJw8wa7NaScRt7LGd2oK1ffFEgC4kTb8cNa
	XxgIMhRSDiauFC7E7NVJKCyKKjrtDNRs4qFJAzWIkx28lPCUPIR8mlO+xWimu0JL
	WyBie4t/tWltOoua4qMYz/dVsCvZ/6uWqGCxR2PsSqGEaXkjw+qyY40aPjzOoyZA
	ZMWWs21GaOAZ3PnY3Ixq+BWCPuJmfRUtOU/WfGA32mgS1j8eFuPImWovJMzaX5pe
	9pUvUg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gqrgn8k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 14:30:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49SEUHmw032369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 14:30:17 GMT
Received: from [10.48.242.156] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Oct
 2024 07:30:17 -0700
Message-ID: <ff8c3443-3651-480e-956e-81c7d592099d@quicinc.com>
Date: Mon, 28 Oct 2024 07:30:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ath11k: remove error checking for
 debugfs_create_file()
To: Kalle Valo <kvalo@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>
CC: Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
References: <20241025064235.382-1-thunder.leizhen@huawei.com>
 <87v7xcgwb0.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <87v7xcgwb0.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PVzzkdQOpIUoQHp8BqQ53taOHAqwAPY4
X-Proofpoint-GUID: PVzzkdQOpIUoQHp8BqQ53taOHAqwAPY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=920 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410280116

On 10/28/2024 7:02 AM, Kalle Valo wrote:
> Zhen Lei <thunder.leizhen@huawei.com> writes:
> 
>> Driver ath11k can work fine even if the debugfs files fail to be created.
>> Therefore, the return value check of debugfs_create_file() should be
>> ignored, as it says.
>>
>> Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Are you just guessing or did you confirm on a real device that ath11k
> spectral really works without debugfs?

The debugfs_create_file() documentation tells us:
 * NOTE: it's expected that most callers should _ignore_ the errors returned
 * by this function. Other debugfs functions handle the fact that the "dentry"
 * passed to them could be an error and they don't crash in that case.
 * Drivers should generally work fine even if debugfs fails to init anyway.

The caveat is that any driver functionality that relies upon debugfs obviously
won't work if the underlying file isn't created. Hence the language that the
driver "should generally work fine" since all functionality that isn't tied to
debugfs will still be available.

Since the relayfs functionality that spectral scan uses is dependent upon
debugfs, this functionality won't work if the debugfs operation fails. So the
question is, if that fails, do you continue running the driver that generally
works fine supporting all other wifi operations, or do you return an error,
and as part of the error handling, not init the driver and hence have no wifi
operation?

The one thing I didn't check is that although the documentation tells us that
debugfs functions handle an "error" dentry, I didn't check if relayfs handles it.

/jeff

