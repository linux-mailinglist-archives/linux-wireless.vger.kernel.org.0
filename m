Return-Path: <linux-wireless+bounces-27099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4335B49486
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 17:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CF916771D
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD8A30F942;
	Mon,  8 Sep 2025 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D3ZeYQq9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D956330F93D
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346973; cv=none; b=QFJFNlit3FRMHSsX9fJJdJpE2bWZ3VSljwnua0jxg2Qjr71ewLXCdr0ES2kkPOZ+6Yx9Tk2+AuSybxCPrQeD9aDQOUFTHmcDCGsqhCXBaasRDEsDKwH6X4+XO0Cdh3JDvn6JDlJGK01LLS/3q0cCCCCvDmp8fqW8QpuEwKblErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346973; c=relaxed/simple;
	bh=YBGJpJYntt9Zv6bZxG35AOveW6CNOJcYMWnp1L2HuIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P43p5wlmk7KMee3oGBkXf+/pFLMxCXQIFDmjfmN0EB8Mdmn7qW94byrm+pIECZjczyp1l9rjUq8SJPwj1jJA0tKshRJCJaOBobTB1goz5Wk70nQQUwQNronDXJ+JATLS/q1b8d3lsVZxpP+dEEneNoxw1FCs2Y12zOQYrbNgxpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D3ZeYQq9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588DGdNl004820;
	Mon, 8 Sep 2025 15:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lxpfKEjS92+QJS4vHNDHsliX03fKedtJ0eKC4KlnlrU=; b=D3ZeYQq9CDR/zZG/
	9eLDKbacxEYEk/JuvShVd6DsZIsex/fE7Pm73cV4KfudKkOcgL5R+BJXflI7s6Bf
	FssRji6OC8Ec6HN9WAUa/O5zw8I56mqDTmA+IBwPay7at5Kikz5v3fI8utWJ0iLp
	OTxrd/2YhlNNFEPBFAo6VXNj6qcyIQuGXK1hlXEE2eCuDPsqZv8CS2YQ/iHoGfAd
	gVemQ71aZpMJwidvM45cWxud03Q+toTcs1huhKMDuwYyww1Fv0qsKhC5sDe9Yizj
	jFcV4aulvKHtDcyeuXTXu1ixfsrXkI4rwWBFMNfqnWbqfEonkztXX0Z+YzkFZ0sq
	OBLFAw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t37sk0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 15:56:06 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 588Fu5u5019456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Sep 2025 15:56:05 GMT
Received: from [10.50.31.164] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Mon, 8 Sep
 2025 08:56:03 -0700
Message-ID: <f220c991-f17b-498c-a0a6-68ead97b2e44@quicinc.com>
Date: Mon, 8 Sep 2025 21:25:50 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211: add tx_handlers_drop
 statistics to ethtool
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan
	<quic_haric@quicinc.com>
References: <20250822052110.513804-1-quic_sarishar@quicinc.com>
 <ce5f2bd899caa2de32f36ce554d9cada073979c0.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <ce5f2bd899caa2de32f36ce554d9cada073979c0.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MMLwuD15p_0QN8UsuDpkbOKOB7XJDG-9
X-Proofpoint-GUID: MMLwuD15p_0QN8UsuDpkbOKOB7XJDG-9
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68befc96 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=ImDLBaF-EJqdgGKenVwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfXzwIFRB1ROKyd
 GIAgda67cRvwQUem3ymfSoBViuf2eNKQAVOrXgMAtC0jpBunoIRwrcNCH2U86EW7EaLI5Writ/n
 UdAJE1v/MbJ05OAB7SnBVCBk7kVsRmq8k0IM07kR5IPZTKPUy/41ViRrdJG5Yufmvn8vVqOj1HT
 kQj/KSqNfhPsO18JbkTMYR5db4cg5G0mYVlghaxIVE20PeWrPkHy5lbegbg5zsH8bfaN2UFOR2l
 ndB/jys5K+gzyX9W1VK7d71QtTM3zvZ0y0I7x+J/SRYb1wSW6uzHYfOdmFY05rLIQW2SsbYgFqQ
 CeLs9ba9/IDCIB62Qr0uxbvB0JxwbeiNJYxntUg/zkE4nMW9N48htliUeyHy7yd3duR/Voa0PID
 NfANJpIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

On 9/4/2025 2:56 PM, Johannes Berg wrote:
> On Fri, 2025-08-22 at 10:51 +0530, Sarika Sharma wrote:
>> Currently tx_handlers_drop statistics are handled only for slow TX
>> path and only at radio level. This also requires
>> CONFIG_MAC80211_DEBUG_COUNTERS to be enabled to account the dropped
>> packets. There is no way to check these stats for fast TX,
>> at interface level and monitor without enabling the debug configuration.
>>
>> Hence, add a new counter at the sdata level to track packets dropped
>> with reason as TX_DROP during transmission for fast path, slow path
>> and other tx management packets. Expose this via ethtool statistics,
>> to improve visibility into transmission failures at interface level
>> and aid debugging and performance monitoring.
>>
>> Place the counter in ethtool with other available tx_* stats for
>> better readability and accurate tracking.
> 
> As much as I don't like ethtool for wifi, I guess you found a use where
> it's actually the right thing to use even in wifi ;-)
> 
> But why not remove the old debug statistic, you have a superset now?

I believe you're referring to removing TX_DROP_HANDLER from the 
DEBUG-enabled statistics as part of cleaning up the old debug entries.

If that's the case, I’ll go ahead and send a follow-up patch to remove it?

> 
> johannes


