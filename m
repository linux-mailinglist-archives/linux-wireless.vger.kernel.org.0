Return-Path: <linux-wireless+bounces-4358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07E7870CCF
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 22:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F1A1F25E68
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F08200A9;
	Mon,  4 Mar 2024 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nYK/CWmD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7671EB5A
	for <linux-wireless@vger.kernel.org>; Mon,  4 Mar 2024 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587736; cv=none; b=PJ89fnAkArheNXXZR/thXUZYS8O0nfR4ho6IX+SWT28FMth1Av8I/0KBNsU1HYKuKMrEu/vRKvCYLansM8xNu5YM0na6IaeRafqYCSzKF4it5da5FWwhDykd4TNaQhhVQ7jw3u4z5kiFnWA6av6H9fTyia085hPwRJjHxakhbZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587736; c=relaxed/simple;
	bh=3HH54GOGYWpmYkQRlCVBqk0/H2cZ8Xdgxpy+A31X4MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AiPujDYhrmwGp1eNLma6iECDGA8KSKcRWSJL8sdKKazGnMHdbITp2A9sMlvnrPsW2u920xB9GaF2Ncv5RTQF2cQY564CXN2V5AB2dBvmBCqPr6PfY2KPnVH+lgbfs2XbjutjM9nZ7a11LpWVCyTGqUACHEC47hN81yAvNYr10Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nYK/CWmD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 424Ks6Ns023379;
	Mon, 4 Mar 2024 21:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+IARBE/EvMWWgCZuAmqq/YDfg7jlJ9qON1QOo/XTooE=; b=nY
	K/CWmD0iqhJqIhV2fqkWDIiQMNdKRYucYYlQiGidf6Zd/cwRG++pHmnneQ8OhTT6
	0Cp1U8FydupquQgcAbTFkF7Bl19bMu7NdTgTognDdGHz4uQnrN/ASfCUH5i0+gJ/
	oZLf+VqFLycUDbYLEpuAScAMRl0egjs06BV8M3bKEt/UXHH6/JTVxHPOKFQGlLfo
	csBk00QT2OahFShEF5dovCMWNuEYPlwVezMBf3GneMB0k1h0oRDrYnQatYFuTEJD
	XFO/aBWg/xHXUKa55W6nC+OibdPmi3j4S+SGJ92surivFnWj+ycmS/FDTAjYBTi3
	vqRRbtuDuvFQL0BgmnwQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wn96esun1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 21:28:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 424LSmUx001743
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 21:28:48 GMT
Received: from [10.110.86.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Mar
 2024 13:28:48 -0800
Message-ID: <574de3b9-3328-470b-a998-761e1d5fb8a9@quicinc.com>
Date: Mon, 4 Mar 2024 13:28:47 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iw: Add JSON output options to 'iw' for scan results
Content-Language: en-US
To: Isaev Ruslan <legale.legale@gmail.com>,
        Johannes Berg
	<johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <CACDmYyeipzNzeBoXQEtsXRu9uHUuteZ1ymJZZ-GsM=zhT19trg@mail.gmail.com>
 <4370a021c6870c58fb15718ee9e4ce8d675b3e3a.camel@sipsolutions.net>
 <CACDmYydF7ZDSGh-9XQ5bvyAcXt1m8JE-EXMTd8mDbGcegO1gfA@mail.gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CACDmYydF7ZDSGh-9XQ5bvyAcXt1m8JE-EXMTd8mDbGcegO1gfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rSqoPTKggGjSMuvwko2nXYOmQqzujjQq
X-Proofpoint-GUID: rSqoPTKggGjSMuvwko2nXYOmQqzujjQq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_17,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 clxscore=1015 mlxlogscore=662
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040166

On 3/4/2024 12:23 PM, Isaev Ruslan wrote:
> On Mon, 4 Mar 2024 at 22:00, Johannes Berg <johannes@sipsolutions.net> wrote:
>>
>>>
>>> If these changes prove valuable, I am prepared to continue working on
>>> extending JSON output support throughout the tool.
>>> Feedback is welcome and appreciated.
>>>
>>
>> I'd prefer to look at it unmangled - can you resend it with whitespace
>> preserving tools please?
> 
> If I understood you correctly, you wanted to see the patch without whitespaces.
> I have sent the patch v2 in a separate email.

no, we want patches with correct whitespace/indentation

all of the patches you've sent so far have multiple places where correct
code indentation is not present.

for example:
+ if (argc > 0 && strcmp(*argv, "-j") == 0) {
+ iw_json = 1;
+ new_json_obj(1, 0); //pretty print disabled
+ argc--;
+ argv++;
+ }

Not sure how you are posting, but note that many e-mail clients mangle
patches.

Please refer to:
<https://docs.kernel.org/process/email-clients.html>


