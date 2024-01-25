Return-Path: <linux-wireless+bounces-2483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EE183C300
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 14:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB7128E1D5
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 13:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7C84F203;
	Thu, 25 Jan 2024 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oRgmeo+7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54611374F5
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187772; cv=none; b=DjYvDjKR/OFPnQZIx7tCmNrf0nWKBg+INwBIwT0Yojt458oLEUmeCUE5ngjtuQ+fW723grkkNFdpGQjcjgZoRAResRN7M7wq0Jvx/tgJjOKAoZld3H/rG2Oa1MiBN3WYcPQKjdWtJJMwwJT+Uy1yVYjI3MBR76SuyW6J+xsbDas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187772; c=relaxed/simple;
	bh=DZtfXsJI4rC6jzJ5COaHBhjyBw/v3XQ0WnHfDH/0DJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B1bqs1axMcvQPTfXG6Y1JZcp+5lWDVsizWyoCS/menmLMWCQEsAmv60Kak3avytzbzjkHCeea/KftJBaUUpCISdCFMYMeFkP6dkIOuHQr5F+bQykyyklbMrSbQEU7o2C9iwgiRPpWHp/QaO7QTY/V3RAb3AE9xWknunFWkvc8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oRgmeo+7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PA80Wr029306;
	Thu, 25 Jan 2024 13:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3E7cHZ5ykAUaI/Y1bxwQMyhIeNYi7sZy5p+cc9oVvXk=; b=oR
	gmeo+7z23N374pzx6PH3ycEree0raIUrCcaFN9TqqYO8UHJHGsGvCAwg6dmCZ/vO
	fjlSQdHivxEpvtLkdlmMTIxmhQHchf1qmzKNBCXp4y2Y+g5T2hfSjs3Hkhwfjf/9
	5+uzlzYxeOTKyqJtaVxXDq5ePUgR1r7ZN4J7PddNKaZxlCkTaKDMDSrebiLCI8yQ
	9fVD46e/GF6hJjd8PVJgQ27viN+qwgGibSZYWRoZ3LYcYq055BGG2PGS1K2wOYqO
	wVG5/0bQrTEJ3yo20UMx9fxubSfCHPAS8mwHiOVABI5YPQG7VKDW2/jfHl1Ul5En
	0UKJbotDzpkqce6QZ0Iw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vumyngmfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 13:02:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PD2lO0021304
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 13:02:47 GMT
Received: from [10.216.10.29] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 05:02:45 -0800
Message-ID: <62fa8d29-d6d3-49f4-86ca-192d02d1efa4@quicinc.com>
Date: Thu, 25 Jan 2024 18:32:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] wifi: cfg80211/mac80211: add support to flush
 stations based on link ID
Content-Language: en-US
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240125125855.827619-1-quic_adisi@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <20240125125855.827619-1-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l1FhFMv5KD56NDUANnRe6vNihKaxbpO3
X-Proofpoint-ORIG-GUID: l1FhFMv5KD56NDUANnRe6vNihKaxbpO3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_08,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=341 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250090

Kindly ignore this series. Got clubbed with other series. Will send as 
separate one.

On 1/25/24 18:28, Aditya Kumar Singh wrote:
> Currently whenever sta_flush() function is called, it flushes all stations
> connected to the given interface. However in case of MLO, all the links
> would be using the same interface and hence at certain cases flushing all
> stations is not desireable.
> 
> There is a need to flush the stations based on link ID. This series aims
> to add support for the same.
> 
> Currently two cases are handled -
> 1. During NL80211_CMD_DEL_STATION command handling. If this is called
>     without any mac address, all stations present on that interfaces are
>     flushed. More details in the patch [1/3]
> 
> 2. During stopping link AP via ieee80211_stop_ap(). Again here, all
>     stations are flushed. More details in the patch [3/3]


