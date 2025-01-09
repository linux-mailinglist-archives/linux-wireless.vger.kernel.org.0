Return-Path: <linux-wireless+bounces-17204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C00A06A48
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 02:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3CE418816DC
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 01:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04644134D4;
	Thu,  9 Jan 2025 01:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EMySMDgV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECE78472
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 01:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736386181; cv=none; b=L/aTyXkxxkzq3Sjzf3W8OaKquvRBxFZc5KRfltI6cYFFkJRTsWDjL5S+wojpnbAY5/5jin8mPlBFDjZtdlBe4NoqHOVaut4aZS6F/Up0W8dejW4eVqWbztXWUux3Ji6tkvhHi5ZW8iP3mrsBJiJZ6tWHfQdONRPZzh0I8+F0c+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736386181; c=relaxed/simple;
	bh=OclaKN8k3v6UDwAD+YxoCC6JsDAhKjIcLnvTIf0WU9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aJMjFHx6sYPLotp8HPwxOYsrMAfpl5LD/tGAy17oZSrgJa2kBi9OGZV2MkKtwYgvT43yfWrYmUIy/+KJWHoyVhAMB+n2jopiw0CPkUfy47uN2uAr1DOh1r1Zj5PmVG84iXqP4An6LF/FH2AjyhOk7rhksp3TMgZGH1tDH3JFLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EMySMDgV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508LWKdJ010928;
	Thu, 9 Jan 2025 01:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qtEv//FL5uwqH9jZP2aaYiicyByEmNKMp7pxXrZBX4s=; b=EMySMDgVNAR6Jvwm
	En/YzBHCJda0ZtjxJ7bGC078TEoCri/kclx/NT0bmjnyKzt6Giqw+QdIdutl4P7A
	opfTZvkKcPhLf5NO1b819u6SUDocPY+kVJn2MNzpHOyRrIVSYgo0T6SlzwaLsO1/
	C7f1I1ZMntDa2QdR9Sj3VFrUfiviQrvM7spZjVSQEQPM1SAULQggOmXMxc/phDsW
	/g2ynWR9G8FB0hAN12qVTd4DubIcpYTAUiJ9rdX46teyaJPjndvpSntY+oh9QWw+
	HewKa3ME+w0p3Qj2/2hNu9AmRbr8OiU0L5vxTfIp1ipvR/X0heCZNF0UnbMnqH0r
	fgaE3A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441uefscgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 01:29:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5091TVCT022938
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 01:29:31 GMT
Received: from [10.50.27.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 8 Jan 2025
 17:29:29 -0800
Message-ID: <f53a354d-2b63-f9d6-494a-f0003529fbee@quicinc.com>
Date: Thu, 9 Jan 2025 06:59:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/3] wifi: ath12k: Refactor monitor Rx handler
Content-Language: en-US
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241224143613.164921-1-quic_periyasa@quicinc.com>
 <b86a2af5-2276-4875-9b53-c3f43392eb5e@oss.qualcomm.com>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <b86a2af5-2276-4875-9b53-c3f43392eb5e@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2iB5Zvn8GQ-CYsrh76mLAXZhumvVll71
X-Proofpoint-GUID: 2iB5Zvn8GQ-CYsrh76mLAXZhumvVll71
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 suspectscore=0 mlxlogscore=555
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090009



On 1/8/2025 9:25 PM, Jeff Johnson wrote:
> On 12/24/2024 6:36 AM, Karthikeyan Periyasamy wrote:
>> Currently, monitor support is not added. However, in the future, the
>> monitor will be enabled. Therefore, refactor the monitor handler, which
>> help to add monitor support in the future.
>>
>> v3:
>>   - Remove the Acked-by tag
> 
> Why?
> 
> If you did not significantly modify the v1 patches, you should have propagated
> the Acked-by given by Kalle.
> 

I updated the code change due to rebase conflicts. So removed it.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

