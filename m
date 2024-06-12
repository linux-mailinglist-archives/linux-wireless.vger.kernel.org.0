Return-Path: <linux-wireless+bounces-8849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C096905033
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E574D281337
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 10:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD73916E876;
	Wed, 12 Jun 2024 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BzHWPfh8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E72576F;
	Wed, 12 Jun 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718187191; cv=none; b=ZzLKFtlO+Q1hZ39wMBhvCqChXwxtWV00j/qsiCdF3hoOy1uHijz+LkhU4df6+Vy1eIkZCTgWjJ11YBT7eNzB6WGZ77IhF33MMfK93dvoeuq34yM/jvS3Sh06dcq66GWtogAvbNcKQJQlI7+1lJBKNHcXDvUMlszsgmBIzcMDZkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718187191; c=relaxed/simple;
	bh=xI1nz6+05116BJ68aHUKThL+jHGqGfEX+iU8gbTQFVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Uwxs5VsyTUDvkyy4Ct/tyvBCvfRQUMejWA770DdQSdkQyL1NKYmwdeYNwlKJTvdgQXQbxwA8fdVf3luupXcZujUn+xGwuv7MW77z+Kv0c18h61ECQNlxj/AbkkFgubueJGCk+5iY+r2qqlUgsHnuFPNpIbBhbEykjPT3WDIBS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BzHWPfh8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C8Dq2T018413;
	Wed, 12 Jun 2024 10:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n2+XhoB7ytlT0opA81Q8hkToIeSshpdybOZcZGjTlvU=; b=BzHWPfh8hN8iIPeU
	y0+tu/k6rgKAyP1Q0H0zhzYsj70whOsn6A1Pcc+exJXYxsRy9KZWc+2AsBsqDqXf
	YzOsB2YWEtEfpaFnjLIue/qUXjbF9SK5qFsDBC8IoPH/OOA4ils3n9Y7n68K7//h
	uex0jiWr0w7BwmF/ID7+YkVM1+jwovXW+mYFON8jGZENOEGUMPAw7fdA3NpzEaFO
	/7mPjNv9qTR0jwTJ0JumEUKXE6mie4/lxUU8DDeK/fEmNU4T0BrAZ4hQkMQNA6ps
	OjuZKnXlcsjgtbAwWCOEG5Lv+vdykvFhtKMqgza9fhMcbLNN+A8fWzEvOQvZ0hHg
	Yx6hHQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ypm6bb65v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 10:12:51 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45CAComO005561
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 10:12:50 GMT
Received: from [10.253.72.168] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 03:12:48 -0700
Message-ID: <9ab68c04-b33f-4f76-a563-2bc9d6c01401@quicinc.com>
Date: Wed, 12 Jun 2024 18:12:45 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] net: rfkill: Fix a wrongly handling error case
To: Johannes Berg <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <emmanuel.grumbach@intel.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>
References: <1717771212-30723-1-git-send-email-quic_zijuhu@quicinc.com>
 <1717771212-30723-2-git-send-email-quic_zijuhu@quicinc.com>
 <5d901b213389c38eb5bd1df37cb8a1c3d82ebba5.camel@sipsolutions.net>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <5d901b213389c38eb5bd1df37cb8a1c3d82ebba5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wBoQalJrJoc70T3E_ZE6chj00Goq5dzE
X-Proofpoint-GUID: wBoQalJrJoc70T3E_ZE6chj00Goq5dzE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120073

On 6/12/2024 4:15 PM, Johannes Berg wrote:
>>
>> use pr_err() instead of WARN()
>> for this error case handling.
> 
> I don't see anything wrong with the WARN here, it's the user/driver
> calling it completely incorrectly.
> 
the function is a kernel API and it is handing invalid user input.
below comments for WARN() seems say that pr_err() is better than WARN()
for this case.

include/asm-generic/bug.h:
/*
 * WARN(), WARN_ON(), WARN_ON_ONCE(), and so on can be used to report
 * significant kernel issues that need prompt attention if they should ever
 * appear at runtime.
 *
 * Do not use these macros when checking for invalid external inputs
 * (e.g. invalid system call arguments, or invalid data coming from
 * network/devices), and on transient conditions like ENOMEM or EAGAIN.
 * These macros should be used for recoverable kernel issues only.
 * For invalid external inputs, transient conditions, etc use
 * pr_err[_once/_ratelimited]() followed by dump_stack(), if necessary.
 * Do not include "BUG"/"WARNING" in format strings manually to make these
 * conditions distinguishable from kernel issues.
 *
 * Use the versions with printk format strings to provide better
diagnostics.
 */

> I also don't really think this is a *fix*, if you used the API
> incorrectly you can't necessarily expect a correct return value, I
> guess, but anyway it shouldn't happen in the first place.
> 
okay, will remove term fix and fix tag. the API returns type bool for
block state, the type bool can't cover case for invalid user input.

> I'm happy to take the return value change (only) as a cleanup, if you
> wish to resend that.
> 
i am pleasure to resend it after code review done.
>> Fixed by
> 
> Please also read
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> 
okay, thank you
> johannes


