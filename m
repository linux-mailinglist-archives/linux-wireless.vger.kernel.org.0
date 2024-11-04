Return-Path: <linux-wireless+bounces-14889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AC29BBB28
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 18:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8D32815AD
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 17:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A201C4A0E;
	Mon,  4 Nov 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m6ETnrZK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA81C3050;
	Mon,  4 Nov 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740230; cv=none; b=EKx9VHs3LkElWn0Bd2gXYseFjcNk/l2G0xCzfD9JyMhDxBG2ZO0Tb3lRIUQVQEZIYrRsiIP9FVEh+S520tTeKMUJ/VApRqMD1udUYgEGo2l+DDXT4PhX56KPr2ulH+PZ/GRs728NKKbH3OMDKjzdZtXFhvXg8tgobK/uFYqvzPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740230; c=relaxed/simple;
	bh=8aE22jD2zj868N6K9zVEFfxqA+xT3sAy+ttF/AmRf0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jXMbZTN84dlZw2Cd4vRNOc1yXmw+rxlbsT+w4cmJLUxNiVhPODwAATZzP9sHY4Y2eR1z5+ovx50tIU7mM3P+W8a7JxNgWuHaSEQIUHylgz89P0Yfdu3XjKeWWxOcx00oPCpExbKpRKK+Aeza3KVtIozBbA581CTDkSnnDbEMl0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m6ETnrZK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BjXiO019793;
	Mon, 4 Nov 2024 17:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TyghnXIE18c8wijoofD4Laj+7h/5SjT/PZcxSv2h4/M=; b=m6ETnrZKTMrZQSvP
	erHeBglLW9JfO6hAehdKweB1zj1cPCdn/HxgEBa1iNrQzDOk619jLE7SZ6xwo8Lb
	AuMJF2DL50SkzUGVwkRiMhkh5cY3LAlVL7eSXfun4jfey7tIgtHIbJcjoGXM1Wlo
	mZZbLjkwXsBctmE9hB4Im01YsYN1E2fhdu3UV4vTbKc7GpKvlQwo9OLHS7ltU2Z/
	7M6A8rD2RNiQFZTwjAeiFhi4so49btXYE6QyKR0iMXRGFPdJSYnho+p0CP9sWkMA
	kwOdU3TPhMznh5TeTgAJG3i2U32ACd2UEkhQxPXJDkfqTThUzVfxHx7lDMa5OBJn
	mRtRlg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd11vxu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 17:10:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A4HAHwj009963
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 17:10:17 GMT
Received: from [10.48.242.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 4 Nov 2024
 09:10:16 -0800
Message-ID: <83ba4f8e-44bb-4cc4-bf59-3e4051a67a9e@quicinc.com>
Date: Mon, 4 Nov 2024 09:10:15 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: nl80211: fix bounds checker error in
 nl80211_parse_sched_scan
To: Aleksei Vetrov <vvvvvv@google.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R.
 Silva" <gustavoars@kernel.org>,
        Dmitry Antipov <dmantipov@yandex.ru>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <stable@vger.kernel.org>
References: <20241029-nl80211_parse_sched_scan-bounds-checker-fix-v2-1-c804b787341f@google.com>
 <ZyjyEl4kzFXz7tTB@google.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <ZyjyEl4kzFXz7tTB@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fyhtL_-tYGJTNx9hReCnTpgY3Jl5KNo2
X-Proofpoint-ORIG-GUID: fyhtL_-tYGJTNx9hReCnTpgY3Jl5KNo2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040143

On 11/4/2024 8:10 AM, Aleksei Vetrov wrote:
> Hello everyone,
> 
> On Tue, Oct 29, 2024 at 01:22:11PM +0000, Aleksei Vetrov wrote:
>> The channels array in the cfg80211_scan_request has a __counted_by
>> attribute attached to it, which points to the n_channels variable. This
>> attribute is used in bounds checking, and if it is not set before the
>> array is filled, then the bounds sanitizer will issue a warning or a
>> kernel panic if CONFIG_UBSAN_TRAP is set.
>>
>> This patch sets the size of allocated memory as the initial value for
>> n_channels. It is updated with the actual number of added elements after
>> the array is filled.
>>
>> Fixes: aa4ec06c455d ("wifi: cfg80211: use __counted_by where appropriate")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Aleksei Vetrov <vvvvvv@google.com>
>> ---
>> Changes in v2:
>> - Added Fixes tag and added stable to CC
>> - Link to v1: https://lore.kernel.org/r/20241028-nl80211_parse_sched_scan-bounds-checker-fix-v1-1-bb640be0ebb7@google.com
> 
> I would really appreciate it if someone take a look at this single line
> patch. It looks like v2 of this patch has slipped through the cracks...

It has not slipped through the cracks, it is being tracked in patchwork:
https://patchwork.kernel.org/project/linux-wireless/patch/20241029-nl80211_parse_sched_scan-bounds-checker-fix-v2-1-c804b787341f@google.com/

The wireless maintainers have a lot of work and it can take weeks to process
new patches.

Have patience,
/jeff


