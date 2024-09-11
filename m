Return-Path: <linux-wireless+bounces-12793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199A99756E6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 17:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82B31F224D9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 15:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF901ABEA4;
	Wed, 11 Sep 2024 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Byrg0yyC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F401AB53B
	for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068119; cv=none; b=IXzd1Gx7SbPEimqS6P38FZHvcTLl/CDkJ3U73pnFdETvkyPdxuK8tDVX1sHpm71TOHoQAov3W5erMS8Kuwxargb0H9GraEpRVVNme1KV4p03TQcpGXzp9I635NcYAW/QC0cWMyz3Qg6NbnVUfp2pFqyWhUw7XfAP9jBXs9PeHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068119; c=relaxed/simple;
	bh=VpCmlljYIPk1GyOQGEvRZuuk96qZwRsLrjKn4WOYjfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b907d63jQp4aK7fEmk3cY5q5ucGOXWCXYMswhkrfDIIikNbOJ90ctHeAUq0eV/akScg46igfXc/UsJ5Xo/MgYfIkBsySc563aRLtLnDBE76yUoaoX+pjwTEXd5dCaUWms5/tJ1gRJx+j1z//wg75PrTOj1pz1jt7DwAGs2GRF2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Byrg0yyC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BElvDm018987;
	Wed, 11 Sep 2024 15:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aNgCEFdEQv5wcGLm58rsK9V9tmXJvEdt6aYLtn6AwzI=; b=Byrg0yyCGT5Mn4ZE
	Drq5l5TR7+XCzRPP9yZq4WziTqs7nDbGI3QVe89uzkbqNIiKP67n4oPTjRuMf4ot
	EyNaBWXxUIJZ3XWp3BLlms3BOnlO/lEP23+iftZJRpCt3/V/8cE4w8rNGkEEr35S
	SbhVi6bKEYLMgEz8VcyScdh/MDcJhYHZ9+Cj+AjQFjpdSCSfQZ89jenohQU1lriX
	dlxJIeOd3BBH4lCMs0Md+U+ABXdrZazgn3qZgzOzgnRzQiIO3F71tMJAY5z8RDCk
	rYhsSOMXA/Lf2j7eNDf2MXhzVQ1UXMbSCIh9P0bgEcalxPBeDRzigPKqKNX7NbRp
	yynNxA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy5nt4eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 15:21:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48BFLpsR023420
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 15:21:51 GMT
Received: from [10.50.37.116] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Sep
 2024 08:21:49 -0700
Message-ID: <a588beba-ddeb-445a-abff-cfb3f6a41a63@quicinc.com>
Date: Wed, 11 Sep 2024 20:51:46 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] wifi: cfg80211: check radio iface combination for
 multi radio per wiphy
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>
CC: <linux-wireless@vger.kernel.org>
References: <20240904112928.2924508-1-quic_periyasa@quicinc.com>
 <e77b379d48db796d199030ce904f8ed44ed679e5.camel@sipsolutions.net>
 <b7769f15-b0ef-fb61-8622-fc8bdc7339cc@quicinc.com>
 <dfd252e8c553c5501eb97042325d9009be14faed.camel@sipsolutions.net>
 <0d800949-d43a-2172-6aa7-5d0069d3b88a@quicinc.com>
 <36d111a1118349a86946bfdbc55e8fcbf3720fbc.camel@sipsolutions.net>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <36d111a1118349a86946bfdbc55e8fcbf3720fbc.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SK8Gtt8_duCFtFNBtrPCEES8Zu-dEYIx
X-Proofpoint-ORIG-GUID: SK8Gtt8_duCFtFNBtrPCEES8Zu-dEYIx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=835 bulkscore=0 clxscore=1011 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409110116



On 9/11/2024 7:10 PM, Johannes Berg wrote:
> On Wed, 2024-09-11 at 18:45 +0530, Karthikeyan Periyasamy wrote:
>>> I guess it depends on how you interpret "combined". It must be something
>>> that can actually be done *regardless* of radio assignment, to be
>>> compatible with older userspace.
>>>
>>> So if you think "combined" == "superset of all radios" then your
>>> understanding is incorrect. You need to think "combined" == "what the
>>> device can do without caring about radio assignment".
>>>
>> The current implementation of radio specific advertisement global iface
>> combination (NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS) expects the
>> superset of all radios, wherever the radio idx is -1 from caller of
>> cfg80211_iter_combinations().
> 
> How so?
> 

ieee80211_link_reserve_chanctx() calls 
ieee80211_can_create_new_chanctx() with radio_idx (-1) to calculate the 
max channel (ieee80211_max_num_channels) after the iface combination 
check (cfg80211_iter_combinations) passed for the global iface 
combination. Here the expectation is number of channel context is less 
than the number of different channel. So in multi-radio advertisement, 
each radio support atleast one channel, so totally multiple different 
channels advertised in the global iface combination to pass this 
ieee80211_max_num_channels().

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

