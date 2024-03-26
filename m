Return-Path: <linux-wireless+bounces-5290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83D388CB1C
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 18:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EACF32516C
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 17:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279331C69C;
	Tue, 26 Mar 2024 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IQHfckXK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811820DFC
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474713; cv=none; b=MJ234QNhJye9/6S03td+A1AuvpQto3QN3Z//Lac098RXTVyfBgvLnPT8JJvp1VIkG89lb1W+szSzKSUqSUzF2CloWEbRi8CB5KI1W3oaRIr09cbPesub1zvRsbwCtDuiumd3wukUQ1WDjwtQs6f5dZLWtGhyGPQUyenDu1hf8+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474713; c=relaxed/simple;
	bh=rRJG7xbGyMOgVnfTsEo4GEEC1FQwB4W5eJsiVm+rVME=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jUmOokXfFCTR9cRQ93wXZD6YHpXAZZg11FNcZ9PMNn35rM98fcyTjGNh8/ThfK/Hsd+Hi9W5so7hUWiVAxbRkAa+CKgK9PzvfzvBeNsdgYGfWC+FJpRqnCkAM2SW1yjrJtOavuRbltvLh3RxnR3eI056Owho2awlABirDlstBIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IQHfckXK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QEP0QT008627;
	Tue, 26 Mar 2024 17:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XFuU1K+XvNLbuPk2yCfh5GkJriqD5LZzYPybxHBIV4I=; b=IQ
	HfckXK104MzSf9cU1q3ov/Ws1n8ZvmJMmEZhmDvwaNW4MuttkiW3e11t4+yI2sYl
	NnekuyKIXpCDnxpmyOqCQGcrGcTPdw2GkcwnSH7dg54WiGc6PRBOfcMYnKrv2lFf
	x6h4LuxN9F7BW9GXsmWV7Ow7XMmvdbzu70v6U9dwI/b1PAsm6HWio0wpMXBy/zXU
	fxeT0VK6r13tI7l5tNgVAO3mSGUTvSXSUIbkrnF8c53bSnTQ3pblYoO8M9/wdMto
	Bt1xjuBODudrk/svGtvKkmwqtwTVEAo4+19zhTQD+L+LP/gq38bXQr28ZjQFtLtB
	evs1vBlBUtbNim2KzESA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x403q0jm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 17:38:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QHcOuH026027
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 17:38:24 GMT
Received: from [10.110.10.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 10:38:23 -0700
Message-ID: <4abad8ae-56be-494a-8fcd-97610f069191@quicinc.com>
Date: Tue, 26 Mar 2024 10:38:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] bug fixes and enhancements to 6 GHz band support
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240325212304.28241-1-quic_pradeepc@quicinc.com>
 <877chp81ac.fsf@kernel.org>
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <877chp81ac.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7LtH7F2iCwtCUDEFiwttudm75mkM56wt
X-Proofpoint-GUID: 7LtH7F2iCwtCUDEFiwttudm75mkM56wt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260125



On 3/26/2024 8:23 AM, Kalle Valo wrote:
> Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com> writes:
> 
>> In 6 GHz band, add support for
>> 1. channel 2.
>> 2. Fix packet drop issues.
>> 3. AMPDU aggregation
>> 4. SMPS configuration
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Baochen already commented on patch 6 but in general I don't see any
> analysis how this patches affects (or works) with WCN7850. I should not
> be asking about this for every patch, the analysis should be in the
> commit message by default.
> 
Sure Kalle..
Will address this in next revision.

