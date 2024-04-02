Return-Path: <linux-wireless+bounces-5742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E397A894F8A
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 12:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112421C2292A
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 10:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CE75A4CF;
	Tue,  2 Apr 2024 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Df6mqRsC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B065A0E6
	for <linux-wireless@vger.kernel.org>; Tue,  2 Apr 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052435; cv=none; b=n//1DDwF03mVqo9T19hPKSievaomb9g7iGsRI0pIf73JLNgq5WlAWjVx5MsTil5pIU44jIMx7mSISdpjf3EvDxY1QtitqC6Ob58wdOLiH9n0iIGAMkJC5P8AxutDwgDrHMUzzj1c4BW2rin5d/shIJfW9KV15myefBw2cgpHznM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052435; c=relaxed/simple;
	bh=+FkciCNuv93zJKe8L1koFTjmq6kkqUmkMbus3uFaJLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kksAFetw0/RjCT/96NT/1PXHkAdJWrlX/15tLs5AUkPdZZRA4q8/vbNRP0SJoJjbAm9xou8QQdZkxTzZjBfD1gzp5KWWSTU1y0Z1EA0dmyJnZql4LzHu5VRsgxT5tZJ0xiuOo6bjE8GCnqp2e4olo5znz0u3rKLwSEQaH1noJGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Df6mqRsC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4325C2nk020109;
	Tue, 2 Apr 2024 10:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GG6zlfkuZOKoyJ0QWpgY1/n+3sUEEoQt88gTiZzmZas=; b=Df
	6mqRsC4T6PVVcfPFg/e/I5mU1FoC8txusdpF6CJ2DgnzlLuP5mzlY1qP2kK+DmKS
	NEVt1ImGus8fDv6rjy5TuqAaEiWEdtSlzCDMhSmH7BxMFL9RuQ3wa0Ydcl9spuNF
	zv7ZkxAYa1HJy4w6XmCoYi/3LnadUh5X4VGX2Dlrw9X3R+52BP+JY29xc3n4lniM
	ByV8kp9KUvn4GHfasK84dZ0Hqe8uAeoj04gCxWVTWhkFhHrThv6Es8b0FwOs1H/O
	FcJu6DxvtQ1I3f/g3ozLcny/Cj+BmzTFwwB6CrniSYeyzOyNhGxNMkd1lXaORahe
	+WO+S/uJ0Y1BE5GdqYMA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x88eh8ysc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 10:07:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432A72Cs004841
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 10:07:02 GMT
Received: from [10.216.58.160] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 2 Apr
 2024 03:07:00 -0700
Message-ID: <bdf7abad-3d13-4085-8e75-c0d5ff4b41db@quicinc.com>
Date: Tue, 2 Apr 2024 15:36:54 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/12] wifi: ath12k: Add single wiphy suppor
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240401190409.2461819-1-quic_ramess@quicinc.com>
 <0d1058eb-aced-4e81-9f61-e4b5a08c04a2@quicinc.com>
Content-Language: en-US
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <0d1058eb-aced-4e81-9f61-e4b5a08c04a2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9yprdxqvoRuf9kCGN2ydB0w2_oKosI5i
X-Proofpoint-ORIG-GUID: 9yprdxqvoRuf9kCGN2ydB0w2_oKosI5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_04,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020073



On 4/2/2024 1:04 AM, Jeff Johnson wrote:
> On 4/1/2024 12:03 PM, Rameshkumar Sundaram wrote:
>> From: Sriram R <quic_srirrama@quicinc.com>
>>
>> With the introduction of Multi Link Operation (MLO) support in
>> IEEE802.11be, each EHT AP/non AP interface is capable of
>> operating with multiple radio links.
>>
>> cfg80211/mac80211 expects drivers to abstract the communication
>> between such Multi Link HW and mac80211/cfg80211 since it depends
>> on different driver/HW implementation. Hence the single wiphy
>> abstraction with changes in datastructures were introduced in
>> "wifi: ath12k: Introduce hw abstraction"
>>
>> This patchset extends the implementation to allow combination
>> of multiple underlying radios into a single composite hw/wiphy
>> for registration. Since now multiple radios are represented by
>> a single wiphy, changes are required in various mac ops that the
>> driver supports since the driver now needs to learn on how to tunnel
>> various mac ops properly to a specific radio.
>>
>> This patchset covers the basic mac80211 ops for an interface bring up
>> and operation.
>>
>> Note:
>> Monitor and hw reconfig support for Single Wiphy will be done in future
>> patchsets.
> 
> thinking about this series in the context of some other patches I've been
> reviewing recently, I don't think this series should be talking about
> supporting multiple radios with a single wiphy, but instead about supporting
> multiple devices with a single wiphy. After all, the existing logic already
> supports a single device with multiple radios, so it isn't the multitude of
> radios that is the issue, it is the multitude of devices.
So far we are only combining radios of a device (ab) and registering it 
as single HW(ah) to mac80211. Currently ah will only contain radios of 
one device. Combining multiple devices into a single HW is different 
series (where ag will be introduced).

Having said that, even if multiple devices are combined with ag, at hw 
(ah) level there are only radios of multiple devices (ab) and hence 
these patches stay generic and call them as radios.
> 
> this would have ramifications on many of the commit messages in this series.
> 

