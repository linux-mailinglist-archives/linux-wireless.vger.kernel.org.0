Return-Path: <linux-wireless+bounces-5581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B58528920FE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 16:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424CAB287C1
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 15:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC2D6A028;
	Fri, 29 Mar 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="np52ec7y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075F46A00F
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711721537; cv=none; b=dIpVLZpq0GdYCFfSX9zlTRQ4yAqO2Fff5/bKiFHGwWvjUJ/rnEBZ21rnuEBsp6hRvXFeLX6yDQKCrIGFsT6MFtXTOLmq/rZrGPztwLIAsh1G3z4EKwwhDDKtrVTO2c81ODiax+1uFVYRJ7u93VCXNxPdXf2RnwV4Q4aJSXdkeUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711721537; c=relaxed/simple;
	bh=gXj3jiy8P2wEhkksPDzjZSc+9eQ3/haQnLqNYHwQBBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aDIbVlWbcyFA3NE2WrNMRZaAwpjnPTQKJ3RM14N1nXLUvSM2bVgEsTSK2/5iiqHuDeGH+YznzwR+swzIT3xLnHH9euh9SNJ5XF8jZyRiISX6tbokGN9agFUh9xyj1aKDIpg+v9HbhvAiYGN14SnPhwSrxBP3ntpIZJIqocZVYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=np52ec7y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TCoRFK021671;
	Fri, 29 Mar 2024 14:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Q/GYAbMu31e6e4GTEAGMgR667lTxULcGk9iD21qUsUs=; b=np
	52ec7ye5bus7cDAdQHX5GfRNvcXwh1CNOofp0iMuXHlvnxUDhymlPCPbb2Q3gQCO
	EmVKTgEfWJhVadQnHDzz6iJ1Gwe+MV5bXfKXxlnLvEXVlTXCZ1rV17v1L/8gA9uj
	KrTJvY1GXu3pkJRf42Tatu79+5EJz8HAhJmpmT+vUm1GZKMhd4gExCXKBIF6+lb7
	v5yIqgW0QTkcgwrpE8Si6E/NZRBnSY/6/AF8Udnd4FhJtwGUe+ze/G1SxcBz365t
	DGubFjWaKI9baCBYmvPFhiXKrV82yMAIjmW5w++xDwdrtHteb9BmCh3n+5Uw2pNw
	TAUQYlQXiEcsj9mGZjpQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5ng9smdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 14:11:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TEBtg9027982
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 14:11:55 GMT
Received: from [10.216.7.62] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 07:11:52 -0700
Message-ID: <033185b0-f878-a50b-d0d9-57fa79439bdf@quicinc.com>
Date: Fri, 29 Mar 2024 19:41:47 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise multiple
 radio in one wiphy
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
 <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: buJA3IXeJZkBtz1PeN_Yrax5b0X5rbf0
X-Proofpoint-ORIG-GUID: buJA3IXeJZkBtz1PeN_Yrax5b0X5rbf0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=647 adultscore=0 impostorscore=0 clxscore=1011 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290125



On 3/28/2024 1:16 PM, Johannes Berg wrote:
> That's a big set, not sure I can review it all at once :)
> 
> 
>> +struct ieee80211_chans_per_hw {
>> +	u32 n_chans;
>> +	struct ieee80211_channel chans[];
> 
> That should probably use __counted_by() these days.
> 
>> + * @hw_chans: list of the channels supported by every constituent underlying
>> + *	hardware. Drivers abstracting multiple discrete hardware (radio) under
>> + *	one wiphy can advertise the list of channels supported by each physical
>> + *	hardware in this list. Underlying hardware specific channel list can be
>> + *	used while describing interface combination for each of them.
> 
> I'd expect there to be a limit on channels being within a single band on
> a single "hardware"?
> 

There are ath12k hardware supporting multiple band which need to be 
registered under one mac80211_hw/wiphy. This design is to support such 
hardware. I agree, it is adding complexities. I was thinking if this can 
be done in steps , first limiting to single band for a single hardware 
then extending it with multiple bands later but that may bring in 
different set of challenges...


Vasanth

