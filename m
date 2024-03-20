Return-Path: <linux-wireless+bounces-5001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE3788165D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 18:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359F61F253BE
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 17:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35AA6A031;
	Wed, 20 Mar 2024 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZFxZiFuP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DA665BDC
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710955101; cv=none; b=ZNkkXJulFYIgkWtnpoVDYylSwqN0g7AlI3IrshvP/tZT73Ga2WdCNAHbXV1URbKG2Fri6qngWp9Acnqay+SYrNP4KWsqKNsbt1OdbP+4gpRSTTqfpLnLf+cA3nZF/VGtR9bpT+A+3RnxoCuzDVzdDps1tT+gmhMEkJZQhGRnUAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710955101; c=relaxed/simple;
	bh=IAYmgb789u+UyqHAp7unDeZgPn6lR58RB3ZKLg15MeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lbtBfXnxPJA4gXiEioYzfAfh2OQkGI1T92Cvbt0xe512PDGBim/V5O0VB1ilcASiXM3sG3oenz62HP/3oOB5W94NzkZlrMbxbeEanHsIQS0458qKNtesZLhhRWp8Q7jWPBROKMm6yjJBvnPqahs2qPMity0pW8hd2EblSlOdSnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZFxZiFuP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KEjZ1Q008838;
	Wed, 20 Mar 2024 17:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DFCzwtCSg9E7/zcvdCpi/lvR69BooL2jQOwdFuuwWQI=; b=ZF
	xZiFuPxmn5vDt9M3giU2zCtRbpA4Mv3Ev3Occ9GoccQqTfdV1a8Az/3I1e0NFbI/
	jinhFrOApNpGA29l6+SzPZoN4pD+nSHPrZVwzLmB3xH0aui/r/CedZ3hvNWFa4tM
	KaR5U0jxp2W4/zYEPIfHNFyzD4QNpk7RIROf1TEStHZrnJ5aRIoFqY5xEdn5aUOb
	VRxmqnSF0o9zh/ic4g7qytIUU8sEiOURVqBGp+P9nUcRX63aAgnz5ycelKcIivYB
	j+fHKtVBbmwe7CTzaMm5yzrNLxWX1jzVWYGRXKQHobA105OlU3I/lUwCb5MBzxpH
	lp04arCJyF5w7Nn3RDCQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyyvdgr14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:17:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KHHjwS012121
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:17:45 GMT
Received: from [10.110.120.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 10:17:44 -0700
Message-ID: <0173fd46-4ad5-4859-be4d-5484e11756e0@quicinc.com>
Date: Wed, 20 Mar 2024 10:17:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git tree to manage Realtek WiFi drivers
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "fiona.klute@gmx.de"
	<fiona.klute@gmx.de>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>,
        "Larry.Finger@lwfinger.net"
	<Larry.Finger@lwfinger.net>,
        "martin.kaistra@linutronix.de"
	<martin.kaistra@linutronix.de>,
        "martin.blumenstingl@googlemail.com"
	<martin.blumenstingl@googlemail.com>,
        "brianwitte@mailfence.com"
	<brianwitte@mailfence.com>
References: <503a9152324a817c251193ee486e1bbcb48d2fa8.camel@realtek.com>
 <87edc5b7oc.fsf@kernel.org> <94c25902ef33433dbb582fc1c503704c@realtek.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <94c25902ef33433dbb582fc1c503704c@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D97n5K8Dh9_Zi5ZAT9sucyzfCmobWWxD
X-Proofpoint-ORIG-GUID: D97n5K8Dh9_Zi5ZAT9sucyzfCmobWWxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=466 clxscore=1011 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200138

On 3/20/2024 2:34 AM, Ping-Ke Shih wrote:
> 
>> Ping-Ke, a big thank you for starting to maintain the rtw tree! Not only
>> that it helps me, I suspect Realtek driver development will be faster as
>> I'm not the bottleneck anymore.
> 
> I feel probably registers of Realtek WiFi residing in driver eat lots of your
> bandwidth. Now I can take that part myself, so you can get your time back.
> Again, your review is always helpful to our drivers!

I also thank you for stepping up! Now I can have more of Kalle's time for
mentorship :)

/jeff


