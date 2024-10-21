Return-Path: <linux-wireless+bounces-14266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910BA9A658B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 12:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B669D1C22212
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 10:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D4D1E8854;
	Mon, 21 Oct 2024 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HEnR1k+1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BBF1E3DF3
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507999; cv=none; b=tSz/g7syEAPoYJOag/s8a3jjEnW24kA/ozITI1rAUMcp9Wde4XfeiqC88KUX7LO3t7FaVLqySfwspBj69hAGH0cyJvxlDvtrYJdTA5ScpMX7H8waii0ugaeGwTKmU3kOL8TxYQ0MGkz2/JMyUWzjO6TPPQiDlGxMlH6jX8TkXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507999; c=relaxed/simple;
	bh=o4HE72VDk5TcpF4ElIXp5hvDiMc9diokGy3nngicnpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jIXKfVwXp+iepZ89iYmECE4uVDqB5yVV+EwgFTwb5mOYjTZOvHVJc9Oxxo2B516ZONnERTX7GE0/DL8BkqixSCbvArn66jyF3xJiywXQoO7+PTHPz841ZWPEy+a7mZvUgT30rvDQYKchrieF6u8XH/zGSGZ9/UR9g79/Hpzg1Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HEnR1k+1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L8JrRb009629;
	Mon, 21 Oct 2024 10:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zu67IWAfDY0YvM/SMeEb38yFEGjw2HTAchPbX5ibZgE=; b=HEnR1k+1asllo7sI
	zdaebBw1/zYlNbbNA8ArzJwN5AhN5dvN+nFFlNn7o2uygTvcEdSslQb5a4f9220h
	23vYtGi9n6Y6q0YZP9uIxDqctljIHPnKrjacKaXc36obKck+tAoOkDwkbNuQ7MR4
	UPHhHg3kziqP9NK/TTopOBxHiKee97fSzClICVl8BXV12tvCqxwtCIRqRk3bJaZs
	wFrQG7h1WkLmYxcfp09tFUpXvkdKiYPNmibk7acyh87TvGwQgZRUxSDb3V5Ary03
	CcdraJ6xQ/S9rBhMgdeX2ceOC02uIYuGvvhJduz9HUf/CoTuLVxP9lI8KMmNmZS8
	iD+Fnw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dkbt0jy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 10:53:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LArCbu025936
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 10:53:12 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 03:53:11 -0700
Message-ID: <aa0a6194-e998-45ca-9566-89bbe3e87c51@quicinc.com>
Date: Mon, 21 Oct 2024 18:53:09 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwlwifi GTK rekey is not working with WPA3 SAE encryption
To: Johannes Berg <johannes@sipsolutions.net>
CC: linux-wireless <linux-wireless@vger.kernel.org>
References: <9840f652-7d4a-4693-90da-844174dc30f5@quicinc.com>
 <ee5e7f5020bc874f477def3b1ea79339f0812b40.camel@sipsolutions.net>
 <a45e6c7a-7348-45a1-9ce6-7a5425b21a36@quicinc.com>
 <e96a1d4b63388e8d7e8a9fadfce31f408ae83ab2.camel@sipsolutions.net>
 <96a7a24b-61e2-45cc-9c76-15552107976d@quicinc.com>
 <1606121bda73a1295f934cff07b1ab52fcebaf94.camel@sipsolutions.net>
 <ca085fd4-fc22-4c91-a571-7a55ac4f32d5@quicinc.com>
 <bdfc2fb8d2d2d9cab7d53034b9f1a68d9e17d1f9.camel@sipsolutions.net>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <bdfc2fb8d2d2d9cab7d53034b9f1a68d9e17d1f9.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Fg3efY2QVwQOz5nQ5TcBpPKC5DnZ06gT
X-Proofpoint-GUID: Fg3efY2QVwQOz5nQ5TcBpPKC5DnZ06gT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=485 clxscore=1015 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410210077



On 10/21/2024 6:50 PM, Johannes Berg wrote:
> On Mon, 2024-10-21 at 18:48 +0800, Baochen Qiang wrote:
>>
>> 802.1X Authentication
>>
>>     WPA Key Data Length: 64
>>     WPA Key Data: ac3e43897dfc934f8f84d58e6fa5bd6c26ae666a29892de0a30d43c7dc7a063ac6b5884718d8945274c0df6559e48c861efec804b5be920bd5550c43b0889ea0
> 
> Yeah, OK, never mind, we'd need to decrypt that with the KEK.
> 
> Not sure how to debug this. I'd think we have tests for this, but I
> guess I'd have to check if they run on this device/fw.
Ah, great Johannes. thanks for looking into this.

> 
> johannes


