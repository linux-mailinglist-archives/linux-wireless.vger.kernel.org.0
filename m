Return-Path: <linux-wireless+bounces-5170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0A988A103
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 14:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B2D2C6A10
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 13:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D286E13AD26;
	Mon, 25 Mar 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T1x4hAUj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E74171066
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 06:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711349522; cv=none; b=a7eKgTOFA17Pw9JX8ARcN+kqJbUq3AbExpH9LXCoKYQ0+vfCWI0rFHOViA2iB54TVGVE52Pdd9QxhPjN0QG4clPXDYVEJSf1doj1XiTW4Hr0oaCBrrSNFio7GpPlCMK4O4J3Bv8juMDB6JkHFobga88rkFROnDcflpgD/25Sw0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711349522; c=relaxed/simple;
	bh=gzVZwHaA3d10q/xGzJCaY0jJx9ZBySeO5VWypleChZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bh0fcscX2nS7WHy7x09An4Bz9A9zx0kJf2cXNne7Zcy8MqAkFS4jg9Wr4K3TKd2FN/VsVJ3LPUIJgonI1WifyINs+NL214YfO7iGuGKasjb9l5p5tWAA0pam9FkS3Yt6xAw5s/roctP2n9Ad+K8wPusTqwhmCW4emdSarIvO2AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T1x4hAUj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P6Xfbe014505;
	Mon, 25 Mar 2024 06:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EAT5SOgOHEHcbwCIMlnf6M9GXtINrjPFJq4zt5RzCZs=; b=T1
	x4hAUjE6A0mOJjTguoQhsls1iTQXPuZ+QAbPslkDaD5F4LMDm8yhwq4G5+Y68HyB
	hgin+tv200aOnWH+R1MjcvTccYtIkqge/fPQ5j6CTjE+eThqbh8coEvZqPMuRBtl
	BUKKerCJBRLajRkIg1hBFn0c8fkwKCgDMyQVmIYDk9qio07lFM+PbHtl21zFV+po
	nIyccXvrdAHlJgQjcFQvYx6Yk/epRMWmJFKfHetQM0lQ8szfJDvT94ZYRGIAkmKM
	jThXTal0rNgztr0MuXJbCCQu5NIsYA5nOp3OM3iIzk8+wAPG1d65lXt8xfa0o77p
	b3u7AAc1BHbLe3Kb5nAg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x1qa7xa4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 06:51:53 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42P6pq1c003627
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 06:51:52 GMT
Received: from [10.201.211.55] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 24 Mar
 2024 23:51:50 -0700
Message-ID: <f690a1f8-09f8-a27c-e1be-fc6c76ea3456@quicinc.com>
Date: Mon, 25 Mar 2024 12:21:47 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2]wifi: ath12k: Add firmware coredump collection support
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <20240322054231.467152-1-quic_ssreeela@quicinc.com>
 <bec0c3f9220c5084f163a39355499bcc7a32da36.camel@sipsolutions.net>
From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
In-Reply-To: <bec0c3f9220c5084f163a39355499bcc7a32da36.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e_WLJ4uLs8hu_pQupBOd_dxl035FJXW_
X-Proofpoint-ORIG-GUID: e_WLJ4uLs8hu_pQupBOd_dxl035FJXW_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250036

On 3/22/2024 9:32 PM, Johannes Berg wrote:
> On Fri, 2024-03-22 at 11:12 +0530, Sowmiya Sree Elavalagan wrote:
>>
>> +config ATH12K_COREDUMP
>> +	bool "ath12k coredump"
>> +	depends on ATH12K
>> +	select WANT_DEV_COREDUMP
>> +	help
>> +	  Enable ath12k coredump collection
>> +
>> +	  If unsure, say Y to make it easier to debug problems. But if
>> +	  you want optimal performance choose N.
> 
> Why would having the hooks to dump affect performance? Surely you don't
> expect to be doing it much?
> 
> Also I'm impressed - 55MB seems like a lot :)
> 
> johannes
> 

Hi Johannes,

As per the current design it shouldn't affect performance, here we collect the dump and queue the work of uploading using a work queue and trigger core restart. But according to earlier design we postpone the core restart until the dump has been uploaded.  I will remove the statement on performance impact in my next version.
 
Firmware team requires all the memory regions to be dumped for easier debugging. This holds 55 MB only in case of high memory profile ( >= 1 GB). We haven't enabled any other low memory profile in upstream.

Thanks,
Sowmiya Sree

