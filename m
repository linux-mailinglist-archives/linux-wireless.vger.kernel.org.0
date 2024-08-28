Return-Path: <linux-wireless+bounces-12163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7818B9626DF
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 14:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13139B215DB
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 12:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BD816BE11;
	Wed, 28 Aug 2024 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fx43Kbq5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90ED16A95E
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847812; cv=none; b=Z6jbbHhHutQI8hutQNn4coDBHE4ewvyiqN3FtsZPoTfzV5zrN/OeWB8/GReB/3hWC1z3C/92RZ1H3QHqa6vw3C39/8Ohyg7tDGEa3LK8MJcy17/pyFfxfYd6bN88eYFv/LZba2rtj5MnUaCn9iRhEFpf78LTCfe4ljaDyNuhF28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847812; c=relaxed/simple;
	bh=smfuvWRoR4CM9zRRKLcxUZ2MROs2NUzz3Y74QOm20Wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RFP7pKKMsvzKg3vFWZy+hmFdMzACBcEqj7dyMIQnjnmZtcMQdDHHj7rDbSOzrNEjPz5GTKf+hw/CVv22Dkz7M/33I+e8tiCQDGYCloon8q9X/O1TcMHUR96fDeqDfnPO7NAYPIRmO1O6of5/bbeMRJKz7DixDJrR64Is3PPxyQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fx43Kbq5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SB79xF007465;
	Wed, 28 Aug 2024 12:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lYMXULrTh/gWpQH960b7y2j1atf5HgV37Y2pvfk+q/o=; b=Fx43Kbq5opI378Tz
	oRw5YI6njPzVCGQ4NbT5kXPVC4D+CqvXYc4EVH/tLfTesBRjVPJmwj1az7yp4qvb
	kDPH8whw60S6cmLy9X2Ctq5nhzjYAlST5fFd5hXMprMGJ9kIUvWdPQvjobA0tiom
	taG33nKLmSYKgpJdHHlOCmnsn3lYz9DBK3opM49nBkdpDUcvyaN5+SC51uxL/k+Y
	KIETr0n6IgnSMuUZX1JCIIDrB9DBnPpjiCvo5JObQ001cE8LnU7MRgmfAjoNWzA3
	PrDMdv0SNeLNZfdoLQbO9O52DswpsZHskB91bKMko6hvNC2e9XZEBRW4mWmhT4Lq
	szE7Gw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419puw1qst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 12:23:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47SCNPhr029945
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 12:23:25 GMT
Received: from [10.216.37.253] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 28 Aug
 2024 05:23:23 -0700
Message-ID: <d3718c76-7589-4ec7-8521-83e63fec2c10@quicinc.com>
Date: Wed, 28 Aug 2024 17:53:20 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] wifi: mac80211: handle ieee80211_radar_detected()
 for MLO
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240711035147.1896538-1-quic_adisi@quicinc.com>
 <20240711035147.1896538-9-quic_adisi@quicinc.com>
 <f340bcec6b6a0cb4d970c8961cc6b21cf9e8691e.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <f340bcec6b6a0cb4d970c8961cc6b21cf9e8691e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Quh6k7nP9gHFG0tj03kFovWKnG1_TjP1
X-Proofpoint-GUID: Quh6k7nP9gHFG0tj03kFovWKnG1_TjP1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_05,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=584 suspectscore=0
 adultscore=0 spamscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408280089

On 8/28/24 17:36, Johannes Berg wrote:
> Btw,
> 
>> +{
>> +	struct ieee80211_chanctx *ctx =
>> +		container_of(chanctx_conf, struct ieee80211_chanctx,
>> +			     conf);
>> +	struct ieee80211_chanctx_conf *itr_data =
>> +		(struct ieee80211_chanctx_conf *)data;
>> +
>> +	if (ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER)
>> +		return;
>> +
>> +	if (itr_data) {
>> +		if (itr_data == chanctx_conf)
>> +			chanctx_conf->radar_detected = true;
>> +		return;
>> +	}
>> +
>> +	chanctx_conf->radar_detected = true;
> 
> It might be better to write the end of this function as
> 
>   if (itr_data && &ctx->conf != itr_data)
>      return;
> 
>   ctx->radar_detected = true;
> 
> 
> to avoid the double setting.

Got it. Thanks.

> 
> johannes
> 

-- 
Aditya


