Return-Path: <linux-wireless+bounces-2748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B418418A4
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 02:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F416F1F21231
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 01:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB6D1E4B0;
	Tue, 30 Jan 2024 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AQ+/lIrx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AE036119
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706579356; cv=none; b=ROzNVoUrTzehgdvrYsb9tofs2YXFeWiAgRtUZDdT5sSg0gvi08j9hbWG8IZkBnqdD5cS0K5rf0a8LVjQB/EOXXHwnNhxnDt+m1ZRHjmBJIrxMc8OIbhKtPkWBehfs7vTkQmv83/sXFXtIOZxUEwrTc/bUawka6ozj7QahxnxHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706579356; c=relaxed/simple;
	bh=Xl2U2EeACBcnZyyi89UE34Ju5ohuhiGjEUdMm0HxsDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=unzQIni+8k60atz4QVplebBx65MtHkRJvvINHWeMrFz4DCY7ToSfFC2jF+GhrpWCCg21B3WUMbI5HSLeMgET+ETaSQmYjjrK09qwt6oGva4bRFavnDNHph5SCKIQO0UhMNbc3aY1mn9jsi6fW5yrvxpRTUOf723uEiB3N4flo88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AQ+/lIrx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40TNAE10013714;
	Tue, 30 Jan 2024 01:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ZIdSsPyhkL103JZ551O2S+rutGWu/k6ZpMZ33V3N5xc=; b=AQ
	+/lIrxTJcOVYx1iPFOxCPirT/utDC2AJKEKfMAXbblkdI9igMLZH8+wm7P82MCD7
	liKi4x6SOL8C8opPRqcObc0WOUzpmVeVTDvkFopPHIy6B4b1nPTjRVFlUOY1K10N
	jladczimLwflo92MkAoEY+KO6yqg4b4Mc7lioNH8CCMJp/kClfLmfVA+KCEHbXI0
	KQ9E0skVDTkVy8hspreaet/FpXyrxYAAcWx30j6JcAjBq2HMBJQjTNUgs8m7J6ZB
	o5HJu5NfDyKjQGib2alA4ZuUC0zxlvsf6dJ0FK0Y/uTj8EHZGO61WWWm3FgPKj06
	aIo6lQGnR7fTcX+CGykg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxdwf9968-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:49:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U1nCEL007239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:49:12 GMT
Received: from [10.253.12.70] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 17:49:10 -0800
Message-ID: <39093756-0374-4abc-980a-51a3b8b33b43@quicinc.com>
Date: Tue, 30 Jan 2024 09:49:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/11] wifi: ath12k: fix broken structure
 wmi_vdev_create_cmd
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240129101453.368494-1-quic_kangyang@quicinc.com>
 <20240129101453.368494-8-quic_kangyang@quicinc.com>
 <c48df22b-e04f-4c51-bb7d-36eb9b2282af@quicinc.com>
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <c48df22b-e04f-4c51-bb7d-36eb9b2282af@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mPJoGOWHaG3uWS2ryKQ3oTFTtRRws-g_
X-Proofpoint-ORIG-GUID: mPJoGOWHaG3uWS2ryKQ3oTFTtRRws-g_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0
 phishscore=0 mlxlogscore=840 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300011



On 1/30/2024 9:39 AM, Jeff Johnson wrote:
> On 1/29/2024 2:14 AM, Kang Yang wrote:
>> Current structure wmi_vdev_create_cmd is not matched to the firmware
>> definition. So update it.
>>
>> And update vdev_stats_id_valid for vdev_stats_id.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> FYI IMO this and the 08/11 patch should go first since they are fixing
> pre-existing code independent of the P2P feature (the P2P code just
> exposed the flaws) -- hence why I'm ack'ing these first


OK, i will move them to the 1st and 2nd, then update config file to send v6.

Do you have any other comments on other patches?




> 

