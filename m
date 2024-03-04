Return-Path: <linux-wireless+bounces-4352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF85C870B4D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 21:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F3D1C21B0C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 20:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB4F7A14D;
	Mon,  4 Mar 2024 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nIN/C1ML"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54AC7A729
	for <linux-wireless@vger.kernel.org>; Mon,  4 Mar 2024 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583426; cv=none; b=kIXoVkOzTB+euVfDdzqbT+LLs8XufPe0lEP1fZg9DjmJgidw9KVohgmrZbFhxEz7f0ZUU4h2I7QqkNVDUPkcZtWq0RaNyTyTKTDD9ME7PA7b01tfSN6HX/8I01T7//i7PDV9vz2BUcNeZ1SO7x9yk/unm/VMhlcBT7iIc5BG5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583426; c=relaxed/simple;
	bh=4fTObNgy2rU3X7sZ/U5nOkFNtPrZFcF5bGvbGMkzyHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sOQYTnpg6lAaeYYiCHq3PfhqbNiCWPjW0rv97YWxtULtabdNh2MSocAjOPo3g3yh93K2aWv3byAn0zF78THkQGeaDHu/ZAn0O2aVRBMUUiAjGmhERKT1s0/mYaf6cQOLMex3cTvAhHqPQx6MPrG8evlOzWKhrWxAbV9QVM3NoM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nIN/C1ML; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 424Jrk0E030102;
	Mon, 4 Mar 2024 20:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XtVuoYwuYdmgwXmiYHl7VAaDJsY4eQIbDW2zj3F2JRI=; b=nI
	N/C1MLFnXHZlanGsrNNlMaMmsWwtxWO5g7duVp7b24H8Atdrf1EmGbpaDqm4ZkmB
	NK13dtPY0clt8hiIJIujAeDvQQSig79/+r5oz+yzcPEdQJy538xTWmwF1SV9stDj
	We9xsVXPflZL1U2iupm0qa/cVjBuKXc0FnVjg9AMWSKXMwNS7u/NhqVHtlp6hUo9
	70ZVGkABRg6Gdt4Wr/MkU8jSDaptSMuZsdz6G1nus3qIPz4b6kXvWfRubhKMqhQy
	nvuDc1ng7r0Xm55Ovn0kPpuc5ioauJcmAXnwkYOUs6orjyQ4FA/IzqwC3W7RXocF
	NsJd8PieRaMd+vtGSA2A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnfx30ux0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 20:16:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 424KGqrY027190
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 20:16:52 GMT
Received: from [10.110.86.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Mar
 2024 12:16:51 -0800
Message-ID: <b2e33f0d-e13c-4bc0-befd-dd6a0412cb60@quicinc.com>
Date: Mon, 4 Mar 2024 12:16:50 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iw: Add JSON output options to 'iw' for scan results
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Isaev Ruslan
	<legale.legale@gmail.com>,
        <linux-wireless@vger.kernel.org>
References: <CACDmYyeipzNzeBoXQEtsXRu9uHUuteZ1ymJZZ-GsM=zhT19trg@mail.gmail.com>
 <4370a021c6870c58fb15718ee9e4ce8d675b3e3a.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <4370a021c6870c58fb15718ee9e4ce8d675b3e3a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dW9NS4haC-OZVX_fcH1HCsFMCKVtFeW2
X-Proofpoint-GUID: dW9NS4haC-OZVX_fcH1HCsFMCKVtFeW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_16,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=884 clxscore=1011
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403040156

On 3/4/2024 11:00 AM, Johannes Berg wrote:
>>
>> If these changes prove valuable, I am prepared to continue working on
>> extending JSON output support throughout the tool.
>> Feedback is welcome and appreciated.
>>
> 
> I'd prefer to look at it unmangled - can you resend it with whitespace
> preserving tools please?

And version your submissions as well.


