Return-Path: <linux-wireless+bounces-12180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5593962DC6
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 18:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047871C23AB3
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 16:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CB0188013;
	Wed, 28 Aug 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LE1J+azY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFA636130
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862979; cv=none; b=E2PVqXnQj3inYefADqVuXz3/ksVuYb2mJrc04eEVTFMRWTLB6V6qcfWCKionGU+LERHTOjG/8UdEr9VSJKcRPyMjHeuwH+xfCRxIECy4i9Gll/oqfLvvuTnqPifCH3WrN5PE81lOJ/NOZIRAJx8zkC22ysSev8iOukyLnL7VKBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862979; c=relaxed/simple;
	bh=q7RaXZ16aHLDqfQZDVRUhUn0sXAihHUZPux1PfDhWZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rQJgMRfv9v7dNVAXAeYTN/iGfuayTYRwfWE+rd3MuFxzz0taFZCAksNWkPa6emjm9gT43XcxvzuF7jtF1f0cHUSLU+Nm94bdc9IUlo9AcvXPuOMNt7ZQNWCO4EZBlBFPrONxsTc9QO9bYpxSXKXwDj9gh801dIryB9Km3P+BLa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LE1J+azY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SEoq4n001275;
	Wed, 28 Aug 2024 16:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DWA/HLixg5ryBCOzyQuhklkYEJdaRdl3VpzFHgnYiLA=; b=LE1J+azYKPDGeEIf
	1zvW6WkmfzL7le75SyNZonJD1lNMi/p1TLdrSc40V/Y8GU/r/RvPZpNEQ5GaNEN8
	HkGtLew4sCZjE0ZNA+7AU85Mw5bproD8pqpX5re++njYJZPZzy0W76osH8jG9ET0
	pAq2yx4My/vZYQnCkKB6rl2+aI0EslIjmbLuw+9ouiSzjSebTT89vGjQYdauujLf
	A2gro7X3Q0VFKfiwGASH36JCTECIYOSq55SFOltu4D0/5OiOBVQGK9MPNm/W9ekw
	EiHj4Wiupjhxh2eD9/pctmCgX5zr7EvcGf16QJueinCYux4dkdm4XC2PXc1Huk/k
	YGACVQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41a612gbfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 16:36:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47SGaC8j011797
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 16:36:12 GMT
Received: from [10.50.38.254] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 28 Aug
 2024 09:36:11 -0700
Message-ID: <6da5c9fe-4479-3f02-6dc4-2e1a3cd7e0a0@quicinc.com>
Date: Wed, 28 Aug 2024 22:06:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] wifi: cfg80211: check radio iface combination for
 multi radio per wiphy
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240813055917.2320582-1-quic_periyasa@quicinc.com>
 <d2ca7bdd57bb4d90e4b76846afb75dbc3bb9bd59.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <d2ca7bdd57bb4d90e4b76846afb75dbc3bb9bd59.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B_qMc6jPFSQpIhPdJr1GHJYWAsBu0abo
X-Proofpoint-ORIG-GUID: B_qMc6jPFSQpIhPdJr1GHJYWAsBu0abo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_07,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=854 adultscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408280119



On 8/28/2024 4:19 PM, Johannes Berg wrote:
> Hi,
> 
> So ... I don't think this is correct, for multiple reasons.
> 
> One, you're completely removing *any* validation of the (global)
> interface combinations in case per-radio interface combinations are
> present. This is clearly not desirable. You're arguing the DFS vs.
> multi-channel check shouldn't be done, but that doesn't imply removing
> all checks entirely.
> 

In case of per-radio interface combinations, two global interface 
combinations advertised.

1. NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS (new global - supported 
interface combinations for all radios combined)

nl80211.h

@NL80211_ATTR_WIPHY_RADIOS: Nested attribute describing physical radios
      belonging to this wiphy. See &enum nl80211_wiphy_radio_attrs.

@NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS: Nested attribute listing the
      supported interface combinations for all radios combined. In each
      nested item, it contains attributes defined in
      &enum nl80211_if_combination_attrs.


2. NL80211_ATTR_INTERFACE_COMBINATIONS (exist global - supported 
interface combination of zeroth radio )

since new global is combined of all radios, so it fails most of the 
check in wiphy_verify_combinations() like DFS only works on one channel, 
Only a single P2P_DEVICE can be allowed.

> Secondly, I'm not convinced that the DFS vs. multi-channel check should
> actually be removed, though I'll admit that this may be a bit
> questionable. My argument would be something like this: The global
> interface combinations exist to let existing software (that isn't aware
> of multi-radio yet) continue functioning as-is. Since it is not radio-
> aware, multi-channel can mean many different things to it, including the
> ability to use say two 2.4 GHz channels at the same time, by time-
> sharing. This is e.g. used to support concurrent P2P-GO and (BSS) client
> today. But DFS capability on this is broken, since you're not on the
> correct channel all the time, hence the check.
> 

Exist global interface combination is advertise the zeroth radio iface 
combination. So it is validated as part of per-radio interface 
combination check.


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

