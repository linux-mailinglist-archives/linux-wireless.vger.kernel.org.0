Return-Path: <linux-wireless+bounces-11845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BBB95CDB7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 15:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB44281F03
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 13:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F66F185B46;
	Fri, 23 Aug 2024 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X6fFS97/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF17184532
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419516; cv=none; b=rf0PCMBWRsFdnGXCI078hgc36Tih0jKBrujbwOH/Vy3nw0b6v4y3HX2edOAiEZaDRbYo6IvPONNRsTyNL7bCqFVSRYGd4MIhlQsZ3W9id7F512JNJeVeHperg51NMlO5Eko14Aj0bj/Dm5RAj9/dJZ55jiAWObRB5ejQ883ULe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419516; c=relaxed/simple;
	bh=1n8QK8VhelFOaILv/wyu8uljuaCKQ/75Q+0P6zGLeAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tID+h/6Q61hJ+TCdNd/0L+ZZbSRt8iDjFbKKMGIqwsirSLJdO3oPPHTB8UaU/MObQTv7UOEIshf7B13LSlkHfhniiPHdMF0m0CUQP9TjDFfCp2/E1Ge1dR9B5C9rII6dvUWs0wR49bktyxpNOO0XVux+pSeA+kO38OIq5gHCN28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X6fFS97/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NAmgQx027060;
	Fri, 23 Aug 2024 13:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QYjZca/+KiX2vKaiRIE6T6qPv0sP32SVjmbRLqaPle8=; b=X6fFS97/oCZ88iAj
	KspUf98ubqY1+GGy795mK5pz6Y3v73IjMORDcUQKlu08HAJePStvQtIoFLLdmhDj
	HMqwab0Rlb3WKZPP2wF7YgzbhfvJ+xEBu92aecAm3BhMJeD1EteCykwwuEPrrnaU
	CAkHCTf92pV9Kg56PTpF/9ogPtQ+m3S+/CfZ4jAQCcMvsbw9rcEXpUKDOGVbd8hP
	wHQP3iOuCJSBAE898RyVI5LeXuEnO++teVACdwAjuAKNH41EN520njnRYKJo9fmJ
	L/CeS+XOeHIl5R0xrGX5AGJV06jLlI/3ct2qYih/c1CoMRrVYMSYIaCR2HwqIR5U
	Qpfzfg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 416s060cta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:25:09 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47NDP8OR011666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:25:08 GMT
Received: from [10.216.4.30] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 23 Aug
 2024 06:25:07 -0700
Message-ID: <c700b251-8300-4d58-be9d-7f78057d84ac@quicinc.com>
Date: Fri, 23 Aug 2024 18:55:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: override HE/EHT capabilities if NSS is
 zero
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240807041933.3196761-1-quic_ajithc@quicinc.com>
 <30ec97d6ecfc4bf83fbd1477c0dba255bce9e6fa.camel@sipsolutions.net>
Content-Language: en-US
From: Ajith C <quic_ajithc@quicinc.com>
In-Reply-To: <30ec97d6ecfc4bf83fbd1477c0dba255bce9e6fa.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dAWupLpwyxAtJlJptILvKBSvICQgvLP6
X-Proofpoint-ORIG-GUID: dAWupLpwyxAtJlJptILvKBSvICQgvLP6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1015
 mlxlogscore=750 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408230097



On 8/23/2024 4:07 PM, Johannes Berg wrote:
> On Wed, 2024-08-07 at 09:49 +0530, Ajith C wrote:
>> Currently, when some stations send association requests
>> with the "Support for 320 MHz in 6 GHz band" flag enabled
>> in the EHT PHY Capabilities Information, but the Supported
>> EHT-MCS And NSS Set for 320 MHz is filled with zeros, or
>> Support for 160MHz in the 5GHz / Support for 80+80MHz in
>> the 5GHz band flags enabled in HE PHY Capabilities
>> Information, but the Supported EHT-MCS And NSS Set for
>> 160 MHz is filled with zeros, Causes the
>> ieee80211_sta_cap_rx_bw() function to choose a bandwidth
>> which has Supported NSS value zero.
> 
> Not following here ... are you saying stations are sending bad
> association requests, hostapd/mac80211 accept them, and then we get 0
> NSS? Why are we accepting them?
> 
> Or are you saying we're sending them, but then that seems like a driver
> bug?
> 
> johannes

Hi Johannes,

I’ve noticed that stations are sending association requests with zeros
in the EHT-MCS and NSS fields. According to draft 6.0 (Table 9-417p),
a value of zero is allowed for NSS to indicate ‘Not supported.’
Therefore, I believe we shouldn’t consider these as invalid requests.

Additionally, since other lower bandwidths are supported, I thought
it would be more appropriate to select the next available bandwidth
rather than dropping the request.

Thanks,
Ajith C

