Return-Path: <linux-wireless+bounces-17380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE50DA0A7AB
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 09:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D518B7A2E2B
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 08:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC90D158D80;
	Sun, 12 Jan 2025 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l2kg7KRW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BBF79E1
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669680; cv=none; b=DeH/eYhfaTzat/MRWHoMpadcxttAL72Vvm0QymAYzWSK3+uO/I+LfGWZJuUvhgpC8ObYRW1RTRlRCgT+48UeigTRMcI0EEo+R0bKoy2bx4K+WVeH/+HJKFYWZ+O67849EquVbmQTEm5XMdKL24Z1rMGH2T8QCgpX+oWdiY6Zcr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669680; c=relaxed/simple;
	bh=vmBEodcuSGh8gLL3u78YuDW0wXgWfztIOTHIIysDTAU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=HcwMVe7syyC8q/GmzpeiZD6/r8/M4MejVeDp2lEuaqfuveTlmO7apL9qkCuZ9Jzs19hGoH0yChsTJEapzP7ULEEE2nvHIb9Fw7FgPNDNUlu4Ay1eUtBtj1LlQu30Nnk3TeZDAy1H9mhfOrCRjFASU0lcYuSgJMICv+aX+tWJ87I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l2kg7KRW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50C8AZAW001023;
	Sun, 12 Jan 2025 08:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n7UGFydfrkQlXtwvz3+HTDSBea/Xa1qAZpv0dk4t8fQ=; b=l2kg7KRW8bEGmY8N
	7nYsmmph4OdBNugOE6sjegm0FvOym6rs3RYTuo3HYVsw4vEMukxF6KwvYMYCDIBL
	qAqoQDrCpIJyWQ63IYVXTEf7MKigwWHCSW94rhMZiVo4iXbds6Q2iTnMNUBHQq96
	i2Nxr3edxSr8GtLRsOwOGppszyhiBK/u1VaHjA7DN2VSW7pcxCSbktWFM21ct38L
	V2WCIikKQbkwRybrVvI75SBsq/7c9+YVtGnEp9SKGMXiipv/P4CIHacSeDVD2j31
	J2WHGqPHNFvDdTjTEfGbb0twE71+QjUjvQGJOjGKIhwif6I/AYVMU7bEWsVfZ4NK
	sLsSTw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44484x84cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 08:14:32 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50C8EVTj012770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 08:14:31 GMT
Received: from [10.50.34.183] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 12 Jan
 2025 00:14:30 -0800
Message-ID: <f4189b7f-f549-4cc3-8f2e-1dd16f5db0ad@quicinc.com>
Date: Sun, 12 Jan 2025 13:44:26 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sarika Sharma <quic_sarishar@quicinc.com>
Subject: Re: [PATCH RFC 3/7] wifi: cfg80211: extend statistics for link level
 in sinfo
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
 <20250110042449.1158789-4-quic_sarishar@quicinc.com>
 <2728f8c0527d47a8a02852815326508909a17b70.camel@sipsolutions.net>
Content-Language: en-US
In-Reply-To: <2728f8c0527d47a8a02852815326508909a17b70.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VA5r-EBC9AE13s5i0_wv3RrGWZwxLELa
X-Proofpoint-GUID: VA5r-EBC9AE13s5i0_wv3RrGWZwxLELa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=930 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501120069

On 1/10/2025 2:51 PM, Johannes Berg wrote:
> On Fri, 2025-01-10 at 09:54 +0530, Sarika Sharma wrote:
>>
>> The statistics could be embedded into NL message as below:
>> For MLO:
>> cmd ->
>> 	NL80211_ATTR_IFINDEX
>> 	NL80211_ATTR_MAC
>> 	NL80211_ATTR_GENERATION
>> 	.......etc
>> 	NL80211_ATTR_STA_INFO | nest flag
>> 		NL80211_STA_INFO_CONNECTED_TIME,
>> 		NL80211_STA_INFO_STA_FLAGS,
>> 		........etc
>> 	NL80211_ATTR_MLO_LINK_ID,
>> 	NL80211_ATTR_MLD_ADDR,
>> 	NL80211_ATTR_MLO_LINKS | nested
>> 		link_id-1 | nested
>> 		NL80211_ATTR_MLO_LINK_ID,
>> 		NL80211_ATTR_MLD_ADDR,
> 
> Using the MLD_ADDR attribute here seems really odd?

Oops! looks here I keep it as MLD_ADDR by mistake, it is 
NL80211_ATTR_MAC attribute that is filled in code.
Thankyou for pointing out, will correct it here.

> 
> Also I think you got the indentation wrong.
> 
>> 			NL80211_ATTR_STA_INFO | nest flag
>> 				NL80211_STA_INFO_RX_BYTES,
>> 				NL80211_STA_INFO_TX_BYTES,
>> 				..........etc.
> 
> johannes


