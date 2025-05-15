Return-Path: <linux-wireless+bounces-23019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAFAAB8CAD
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 18:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F4224189615B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 16:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6FD1C07C3;
	Thu, 15 May 2025 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OlTrrSnq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0799C1A23A0
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327278; cv=none; b=U9pQmbn2Ra69/o4Ud3lK60BH61XYFaBxSqgN+pJ2Zca7OSxjQEpcxNZ0vG+Rus3VE7P/3qXl568W3KwqRJR+UM56X266/KeqGd1BMedFi9KQ9yFGYkv4FxsCV10X4NLZABferQFeXFcvuoRhYaALh47Kj3Ci/2emFvguh37fgs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327278; c=relaxed/simple;
	bh=bhZWmKDfyg9Ryo0Bp80DfK9kZPVoSmKll17oE3Gc0LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gpUsl3DG4OrcZDpZZ+czDycEDEGqDoqo9LdzTWuMeOtwoD2zVg6EX+blWEcpQiREqHhpMKImblQmMVuj5v/ZacfQTlrO8hC9thUTRW2BHdbNcvCMbC1nK+H4UW27mgFzMvJlBk8mos23KpsdYvYwJSN3z/mEZfp0XvNQbui3+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OlTrrSnq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFUiK000685;
	Thu, 15 May 2025 16:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pXXulX1cImTRi+KRH8ZJcWD+sRFO42h4Im53/oqBv7w=; b=OlTrrSnqI5GwCKOU
	Pa3K9JN81mAmKWQCSI0ow737orkzsvvw3K7GDptZjZEmm89TtVo2HAkPCaH4zjGJ
	Ng9wF86uoKQBxsR3/RJxckFrxejklujbj9j2ZerbMCi+WAx+XKX/h0xHZPAsqngU
	Cr3EgZ0CIQJYyrTEIV4Euoe8VapqXUJyxF/Ii5yrZYWiIibWs9iB1yHq75xIrr3y
	E/TPzrri5a43koS1B7zw4r1xglt+XpohLsNPmQLJ+/+tRwKtZwv2X5DIDtWOBo4+
	WpWQpk7KvbzXFp/SS3uJhql6wK+gb79XjMTwW85E9NoomUb8d6tMQcpyVd4ovAls
	6lmqSA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcnxvgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 16:41:13 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54FGfCqt010110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 16:41:12 GMT
Received: from [10.50.45.88] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 May
 2025 09:41:10 -0700
Message-ID: <95ae2c94-a3b6-447c-ad1c-b81729db196b@quicinc.com>
Date: Thu, 15 May 2025 22:11:08 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 03/10] wifi: cfg80211: extend to embed
 link level statistics in NL message
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-4-quic_sarishar@quicinc.com>
 <b36a743e6d14d81c3d613fc1e6c413010405cf46.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <b36a743e6d14d81c3d613fc1e6c413010405cf46.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zxRX_9rEt3LW9McdFRgY-xu2CTJbh3NE
X-Proofpoint-ORIG-GUID: zxRX_9rEt3LW9McdFRgY-xu2CTJbh3NE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2NSBTYWx0ZWRfXwkPu9aPmXf1v
 9vOrZ0fNVZDCYpcuUuhnFoDxtfF/85W2ZbdRICNpSBQMeTAreoIodKqF3Ok1dF0Maq6FX2GtxhM
 yIfE+5ewCD4clp891nQ7TYbp4sy3E/Hfm8XjOT8x5/2IFeJ+YC+GTVinzT4Oq8WMWoPgqlYaI64
 MDkAdan2X4TzeN/rgONjpqOaRkF6iViefs4H33sPGYFEcAhI/2dy89PxGAkQ6q6NTBhxt1n+YBd
 4kI00fP0zW3W/jhNhHLKWRpY2It/2MpLP7eAa9u9CrzEacWBCoeGwkjB6P952Kr6WF7O+E9f/vZ
 ZWPhLOkA9yTi+87QRqywV7/yfeW3hpDUsy1QUWgJ4OOpI2AzkAUes3XocdvFy0VwpCEUUbvb6fT
 u7FpR4pQvJbAiEH9nVJJ0xPCsDW8d4XN22pIIVGlDcotskXoz/R0jVEEhUD9z/nMaUvsK0WF
X-Authority-Analysis: v=2.4 cv=Gp9C+l1C c=1 sm=1 tr=0 ts=68261929 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=q8w-13eTyESG-G8sRH0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=596 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150165

On 5/15/2025 4:55 PM, Johannes Berg wrote:
> On Thu, 2025-05-15 at 11:18 +0530, Sarika Sharma wrote:
>>
>> +		for_each_valid_link(sinfo, link_id) {
>> +			link_sinfo = sinfo->links[link_id];
>> +			link = nla_nest_start(msg, link_id + 1);
>> +			if (!link)
>> +				goto nla_put_failure;
>> +
>> +			if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
>> +				       link_id))
>> +				goto nla_put_failure;
>> +
>> +			if (link_sinfo &&
>> +			    !is_zero_ether_addr(link_sinfo->addr) &&
>> +			    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN,
>> +				    link_sinfo->addr))
>> +				goto nla_put_failure;
>> +
>> +			if (link_sinfo && nl80211_fill_link_station(msg, rdev,
>> +								    link_sinfo))
>> +				goto nla_put_failure;
>> +
>> +			nla_nest_end(msg, link);
> 
> This seems wrong, should be is_valid_ether_addr(), and
> WARN_ON(!link_sinfo), and that really shouldn't even be possible after
> iterating the bitmap. In all of those cases it also really shouldn't
> build the nested attribute at all. (I had made those changes.)

Sure, let me pull those patches.
Thankyou!

> 
> johannes


