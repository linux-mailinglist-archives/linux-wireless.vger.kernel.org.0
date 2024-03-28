Return-Path: <linux-wireless+bounces-5448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6844088FCC2
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 11:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AFC41F28E58
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 10:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E6828383;
	Thu, 28 Mar 2024 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mys3obwD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38742250EC
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621098; cv=none; b=J/eXB7F/5z5e8VckSe2hcQds8BKVblTPVWsUC9Gx4Zid3SH1WbelAYZY/5ChPsFyYNX7VdJTGr/vw/EZDnU0jiVWhCd1LCLRfuZzW28PMH8mhoUmQ1+07BMnD/exhL+x3QwcoADiFSCkLMMzABoCgtDaU6qkRmxPK8U3GD3ipVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621098; c=relaxed/simple;
	bh=QSAse9W5PkeRYi3uYEbKjhd80led6k5gduWXLMe4AVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IgCpP2S1eLsK8I2oaWY0tcSZJuwRsrpjFf1jqorwN519GGmfOiuZNQxnhzRdqpW0xSPjR+n0FLFSXDenDbUBr+UCUgAsHOWvMWkV7+wr6xvwQ+6DAoi/SwFnNmR4xt3356c8SvMSxZ4spyLOl51WySZcs+I5LTndb2nmAjLLcAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mys3obwD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SAA29D009447;
	Thu, 28 Mar 2024 10:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=cZByaWQeIkVQvOslxzQROCbMlvuJnPM5R+cAjqRX9N0=; b=My
	s3obwDJxqNnaOMEfEK6qGN6dpSspeVbmFle9C9rd0zfuU2CpRz430LIGRI3vtZo5
	7VMRQ4teIQshkaPDQxbYVqArFK8aaNvk7UtGzUFBpyQsoqgcSsxjvzjrW5tUi+Xb
	zheHU5jX+RJV9a25siikZsuzuDKHmMk7H3ydCOp+uv2vYSn8V6OjxqWltpcf+jr8
	vIluLWcZMIv8yYnxgC/xlE/6/DwH5/9BhphfPK7x8V1fThLbrXNnppjxHlKlmre8
	DjTxARERBqaYiVKEgrCDX9ZM9ooZhN/oGU4obnxQJkDv6HiiIBOXHngeSUcscED8
	VPDFUsY0JCvo7hpieAmA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1wtvvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 10:18:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SAI9tQ027123
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 10:18:09 GMT
Received: from [10.201.201.124] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 03:18:07 -0700
Message-ID: <9d5c2f9f-19b5-af4d-8018-1eb97fac10d6@quicinc.com>
Date: Thu, 28 Mar 2024 15:48:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 02/13] wifi: nl80211: send underlying multi-hardware
 channel capabilities to user space
To: Johannes Berg <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-3-quic_periyasa@quicinc.com>
 <6d92d0ba4a8764cd91cc20c4bd35613bcc41dfcd.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <6d92d0ba4a8764cd91cc20c4bd35613bcc41dfcd.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LLfTP08jjiV0rIY0uP6W59zScFke5kZk
X-Proofpoint-GUID: LLfTP08jjiV0rIY0uP6W59zScFke5kZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_10,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280069


On 3/28/2024 1:19 PM, Johannes Berg wrote:
> On Thu, 2024-03-28 at 12:59 +0530, Karthikeyan Periyasamy wrote:
>> +/**
>> + * nl80211_multi_hw_attrs - multi-hw attributes
>> + *
>> + * @NL80211_MULTI_HW_ATTR_INVALID: invalid
>> + * @NL80211_MULTI_HW_ATTR_IDX: (u8) multi-HW index to refer the underlying HW
>> + *	for which the supported channel list is advertised. Internally refer
>> + *	the index of the wiphy's @hw_chans array.
> Is there a good reason to expose this? Seems pretty internal to me, and
> not sure what userspace would do with it?

Hostapd use this hw index for the channel switch cmd.

The hw index used as a sanity check to identify whether the user 
requested channel fall under the different hw or not.

In split-phy hardware, 5GHz band supported by two physical hardware's. 
First supports 5GHz Low band and second supports 5GHz High band.

In this case, user space cannot use band vise check here to identify 
given channel or freq supported in the given hardware.


>> +	for (i = 0; i < wiphy->num_hw; i++) {
>> +		hw_mac = nla_nest_start(msg, i + 1);
> And you kind of even have it here already ...

Then user and kernel have to make an assumption that implicit index used 
in the life cycle.


>
>> @@ -3001,6 +3042,12 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
>>   				rdev->wiphy.hw_timestamp_max_peers))
>>   			goto nla_put_failure;
>>   
>> +		state->split_start++;
>> +		break;
>> +	case 17:
>> +		if (nl80211_put_multi_hw_support(&rdev->wiphy, msg))
>> +			goto nla_put_failure;
>>
> This could be (or get) pretty big, are you sure it's not needed to push
> the splitting down into it?

ok, can do the advertise for split.


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி


