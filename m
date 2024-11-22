Return-Path: <linux-wireless+bounces-15590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 459379D58F8
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 05:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C89D1B23CB8
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 04:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ACB176227;
	Fri, 22 Nov 2024 04:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bJ9mUlsz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE2170A3A
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 04:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732251137; cv=none; b=iYnt4xtVrdDviWShNvdMyhH7YETRnGTVopXqzM2wIEhr/iFs49U9G4FKP/wboK92J4pf769ZiVwKXYPjLAN9hV2ApmxuorbQy5v4x8UjQQqW6UuOm+3Xz5YsqmrzOcouwz6ZPk8E+p4LWr5ffzu8c4Ch53H6+fCT7xwZF1XA1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732251137; c=relaxed/simple;
	bh=r8rOIZGqit+19mrdKKBdfOX7arDFllhkk7Xr69kClbw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=rafkRahfIt2jP1cgnvGS1IxsCeBO9sNv7qdZpOb43Xw8HFX/3BR8z/jidOUp0+9TRsKcgDDm86YjL8AxVCI6DpZMFN+0L4UJBxcactj/YqHsmGhPOxTEwXjuFV9h6WtTLwifJY2D1lNAQFnLz8MAqo4THqYj0F4i/hak+HPv0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bJ9mUlsz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM4OjJw005050;
	Fri, 22 Nov 2024 04:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GpVVTzeziUmsjxNnNl5rWVqVbpCh33kQix0EfMqajZ0=; b=bJ9mUlszLgdx3L4x
	kr7iSPHpw0gI4XFEnmO/OugaHzRtbI0As+COadJ+vWNwTvwbLiwygjIE/HNOGPYX
	nfTMlp0Uk5nLpWbL/6FO6fgtkzhkSb47lLKB2lzETtUWFPd4gsw/9TkU839F9aUn
	8dYEk04FKPaWJVxln4oIIrcpJtaFKfnBQvB6JSDV1B4W+qeC9YKjRR8vXj+zvGZ9
	XEIf7Xqf7qeiPDToimHd6W17kTyePrGiHDuKHnCatu7tMK/w3g8a7kOxgGAyLjQy
	4U6cul082pCJfQ2/I2lwtW3+W93RtYoo69zFhIV1cJqVZDhd6ik2b1vUsztTAAMn
	Hi6J9A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4326cs9xq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 04:52:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AM4q8KO028282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 04:52:08 GMT
Received: from [10.111.176.168] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 20:52:07 -0800
Message-ID: <af6d174f-2990-46ed-b195-b5049e6765e2@quicinc.com>
Date: Thu, 21 Nov 2024 20:52:06 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: mac80211: use wiphy guard
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>
References: <20241121231136.4fede74dcb60.I610c9b14f36902e75e1d13f0db29f8bef2298804@changeid>
 <20241121231136.9e02d2b88f8e.I5b06810b7a71860fe3c2efa92ac09f2a13e30d7b@changeid>
 <4c8570c2-bafd-4072-81f2-b1d87c1f2b93@quicinc.com>
Content-Language: en-US
In-Reply-To: <4c8570c2-bafd-4072-81f2-b1d87c1f2b93@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6NVQjeIM6ZD0WnLHNeAY_7OD2SqXE030
X-Proofpoint-ORIG-GUID: 6NVQjeIM6ZD0WnLHNeAY_7OD2SqXE030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=688
 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411220039

On 11/21/2024 8:27 PM, Jeff Johnson wrote:
> On 11/21/2024 2:11 PM, Johannes Berg wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> The wiphy guard simplifies some code here, so use it.
>>
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> 
> Now we just need guard(rtnl) :)

wrote before I looked, it already exists...

DEFINE_LOCK_GUARD_0(rtnl, rtnl_lock(), rtnl_unlock())


