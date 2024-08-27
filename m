Return-Path: <linux-wireless+bounces-12094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B731961727
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 20:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371D1285457
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 18:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DD91D27A0;
	Tue, 27 Aug 2024 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gkYO+EM9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEED1D2796
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784259; cv=none; b=KV8Kt4nfuHFFvAECyvXtdC0UP8RSR0xJfnXMZ/BuQ8Pl7DXzKnQzyynNphfEdzc/BYEO1Cxzd0icPJ/cwLi+auU+U3+oBriEXzVdcPdQ7hBNEcDeqVU9hc2DQfYkfh7ujkEmKmIuE7IN8DemoajWd6XWcYvFKGsjmk1W902GByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784259; c=relaxed/simple;
	bh=viMrpIrdCoZPeXADjBPuwf3I41NoSHprJ4p8f6Qhw+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AP3QSe1B78MRegf2sN5vyifq+wW9YnACkpO/nkzBaRWe4ZpRHnBxTE1VIGmPkiHfymyitbQ7BauHLX/gNNiK0RU+dITSvv6JCop/2PbkaV78yVXgc1nMYNkhaJXD3qZKVbkObusXBAtTEvHDrDrYoOBQy4I7Szk8VpjClXZOMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gkYO+EM9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RIW049006778;
	Tue, 27 Aug 2024 18:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fC0jJDJtTRqUxjGP/7OaeumAAzb4kvo2TisV2+5BPgM=; b=gkYO+EM96s5C1s6e
	JVXMYU9ocf7ISjwJ2cQd6Kop3uvxPW2rldrCiyIAvh62guA70uD6wuhzTlebvvno
	tQYvKXPCwpVgeOhz2fmSbYYspmBKhxRBWBWYnqcPDJFf82jde1d6VnYC5z8s6bhn
	9TN9R/oU9hlGrdWjbONNqHy5CLAK+CRuApt2eFdeBzmsZ8q1TLuhn08GOERNw8u4
	8sKg3TZVKCHvYDnnaZkIfpiEFxFlR1CjWd/ePdN3TaM0OtGhOdlS7H4YZKJqO+wM
	uKCJxBkCM/Gg6lNDAS+sJXtQPqRxUi8xUboaj6ifDooc6H0fFiiAL+MGe1LPuHMq
	CuhHFg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41796kyvrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 18:44:13 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47RIiCJ7027156
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 18:44:12 GMT
Received: from [10.50.6.47] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 27 Aug
 2024 11:44:11 -0700
Message-ID: <8da37f46-4d3d-413c-a172-b6e18f2f26ef@quicinc.com>
Date: Wed, 28 Aug 2024 00:14:08 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 1/2] wifi: cfg80211/mac80211: Introduce nl80211
 commands to support MLD link removal offload
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
References: <20240807034521.2091751-1-quic_mdharane@quicinc.com>
 <20240807034521.2091751-2-quic_mdharane@quicinc.com>
 <f7b60c2f8239974431227029118b269988a300c5.camel@sipsolutions.net>
From: Manish Dharanenthiran <quic_mdharane@quicinc.com>
In-Reply-To: <f7b60c2f8239974431227029118b269988a300c5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -A75jQsuTTv5J7Uk3RujlROmJ_ynKVm_
X-Proofpoint-ORIG-GUID: -A75jQsuTTv5J7Uk3RujlROmJ_ynKVm_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=561
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 spamscore=0 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408270139



On 8/21/2024 2:31 PM, Johannes Berg wrote:
> 
>> +/**
>> + * cfg80211_update_link_reconfig_remove_update - Inform userspace about
>> + *	the removal status of link which is scheduled for removal
>> + * @dev: the device on which the operation is requested
>> + * @link_id: Link which is undergoing removal
>> + * @tbtt_count: Current tbtt_count to be updated.
>> + * @tsf: Beacon's timestamp value
>> + * @cmd: Inform started or completed action to userspace based on the value
> 
> Might be nicer here to wrap (some of) the many args into a struct?
> 
Sure, will group them into struct.

> I also don't see a need for a return value (and you didn't document it)
> 
> johannes
> 

I thought the return value will be useful in any error or unsupported 
cases, will rethink the approach and if return value is needed, will 
document that.

Regards
Manish Dharanenthiran

