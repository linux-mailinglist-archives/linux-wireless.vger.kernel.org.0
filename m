Return-Path: <linux-wireless+bounces-15928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F09E597A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 16:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182C1282C49
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A0021CA00;
	Thu,  5 Dec 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lQCcA6Db"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D1621CA0E;
	Thu,  5 Dec 2024 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411604; cv=none; b=owk3O2sRCXAsc4w6Ho7loBtIe+iDnu2Z82GKjVOs57OAz2AL6w8tLl56QjYuVW+4ieoUdmVEmIeZV007otD8TMp5X1nAm3QEMzWwa6IRLCucHl1OxUSC9xN8GxzIPKrtWieyo2yCcVS9zJ2wcywcY8aTC7DXhAtEE2agPcWEcp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411604; c=relaxed/simple;
	bh=nLqM/2FAJjfFFrg/yHjLLNcZ/ZIaSQmp/beWl+HJpOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jPMSH/Ol2JJmI65LYKT84rxvT1o2KgLdeFyOhjKtptueDj9ZxDx09SWfxFE91cfkzh0zrkYxwulgTZ4KqDpA+pB5+HJTsSC7+oKrs7qTRB7aOLImPhrS64c7mw1ktK0rt6yP+95dKa8MnHgZwpjKC9lwrXHeeKchVJVbZSxqIXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lQCcA6Db; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5EZCM2032016;
	Thu, 5 Dec 2024 15:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l6igxJtbS3C8tUYy85Cyut0FtQNqzJL16V3clM1kHF0=; b=lQCcA6Dbi+QzCh0q
	aDL+rKF3oRoI+vtROR0a/PoPwzYyjlM+viRWJe6CePpBkc0Wo3lHgOIxEP3SPmc+
	kBEZwAZggmZD3cY0V8fid9t6FbzG9hjoaeeVvCiP5le0eeCk20neu3JnS0oTkTUG
	Q0/4Z20wlaN+V4JrhGJSbiFB8yFksiJhfZ1SSayTP+GzNGUwUMXfdclOHvaXd0nJ
	ZNs8xrHWgchYixTyfiZb9zoXMjdChCmknr7v7zBDs6QvHxbdkIUoY5Ca9tJ7Yons
	dFR+Ns0+fcFGTOo3YdQV+BTS7wZA0e295ccLv6o3vJQHIbLFltA/kBOr6cBW5xg7
	nBcDfQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43a3faxvwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 15:13:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B5FDHel020066
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 15:13:17 GMT
Received: from [10.216.3.193] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Dec 2024
 07:13:15 -0800
Message-ID: <a60eb1a7-9739-4dbc-a683-417ac6d47adc@quicinc.com>
Date: Thu, 5 Dec 2024 20:43:12 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: mac80211: re-order unassigning channel in
 activate links
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241205-unassign_activate_links-v2-1-ba3f0a2bb4a4@quicinc.com>
 <d0acd2178504d76770e9267ef6e7f5c04b50eab3.camel@sipsolutions.net>
 <d421f8067ea54bcfc38a9b021ebda13515145c45.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <d421f8067ea54bcfc38a9b021ebda13515145c45.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Tc-B0uTzX-mz0fGHCE0HxM8uZDIT58uY
X-Proofpoint-GUID: Tc-B0uTzX-mz0fGHCE0HxM8uZDIT58uY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=781
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050110

On 12/5/24 18:30, Johannes Berg wrote:
> On Thu, 2024-12-05 at 12:43 +0100, Johannes Berg wrote:
>>>
>>> Therefore, re-order the logic so that stations are handled first and then
>>> channel is unassigned.
>>>
>>
>> This causes memory leaks in my tests with iwlwifi.
>>
> 
> And also firmware crashes because the station is removed while it's
> still being used.
> 

So is this exposing some underlying issue with iwlwifi? Or this change 
will break drivers which does not group multiple hardware into single 
wiphy?

Also, how about non-ML scenario in iwlwifi? There, first station is 
removed and then the interface goes down right?

-- 
Aditya

