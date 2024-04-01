Return-Path: <linux-wireless+bounces-5736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A6F894584
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 21:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C34B2163F
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 19:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EDA53360;
	Mon,  1 Apr 2024 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HE/cSjQo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE7D47A76
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000067; cv=none; b=t4I0zU3TnpUTiK0+earpLKaSlW2pduXBu5UL24W9C5Nq6zDsyLYty6JaX3d0ph2rPcGRVdz64HN/O0XRlc1dQGJeCO/4EhQs3pk6KSMXWlA4Q6+wsB61xH8XcNcH6GNJanz87f1Qy+gMhVyAw8bXQ5827oH5F3CR/gO3e7FUMbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000067; c=relaxed/simple;
	bh=IUQ+YGU7mNFD9wWw/B5QT5wAF1gnliAwokHB4CX03SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c93nykPxU+3EeNSFChJcVupl2uSB/nazjQXhnkkWhKkD1XLqL+h2al8kBakgB9STr/ZVO/sxREAsaGx+mXNKvQ2oSfWzLt88dswzm21kCriP788mX6cXbp8k1TrSOAyHAlRCmZKD8zi//ppn5bTunmnKy0tS6RxsRyvQOtbwMyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HE/cSjQo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431JRmBM007500;
	Mon, 1 Apr 2024 19:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HYe3zQKCXScnIQM1IEFH34Fj4R55r2F6P+Qqcd6GyXI=; b=HE
	/cSjQokW2rEeAiM2+F95J1gpZ1wxKDbWbyw2VnFqNx1s7nvV6I3khzOceGxcmHba
	YmopeSYjvapttNrxQ/aQ2HBJr0mxHT5shVl9i0RJKCdQG2xP0+kA3/advDaZDk/U
	o+n2dOBXPICSeNThIafOXL95K8yMfgS1QGy6N7Q3eqHvcGl4hvH9ezf4EWYFTHx0
	gaNVDdPFP+jgjIx9Y8M2dYGzvCcJfgbx3MUadqWjAByBAj/ZYiB5tIbr4wI+t4Y1
	NDECdg1R/XpgNkv1rJ9zeNJhrY63IM0Q9ioAS5xnM4/A/MId8iSpzxPeHOrEoElv
	VsLETIk7wF53mxa9cn8w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7ucfh6rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:34:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431JYL1N005286
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 19:34:21 GMT
Received: from [10.110.126.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Apr
 2024 12:34:21 -0700
Message-ID: <0d1058eb-aced-4e81-9f61-e4b5a08c04a2@quicinc.com>
Date: Mon, 1 Apr 2024 12:34:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/12] wifi: ath12k: Add single wiphy suppor
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240401190409.2461819-1-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240401190409.2461819-1-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YnkGIfMD9bAHjb2X_Vh2-DpOhOVAOBe6
X-Proofpoint-ORIG-GUID: YnkGIfMD9bAHjb2X_Vh2-DpOhOVAOBe6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxlogscore=932 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010137

On 4/1/2024 12:03 PM, Rameshkumar Sundaram wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> With the introduction of Multi Link Operation (MLO) support in
> IEEE802.11be, each EHT AP/non AP interface is capable of
> operating with multiple radio links.
> 
> cfg80211/mac80211 expects drivers to abstract the communication
> between such Multi Link HW and mac80211/cfg80211 since it depends
> on different driver/HW implementation. Hence the single wiphy
> abstraction with changes in datastructures were introduced in
> "wifi: ath12k: Introduce hw abstraction"
> 
> This patchset extends the implementation to allow combination
> of multiple underlying radios into a single composite hw/wiphy
> for registration. Since now multiple radios are represented by
> a single wiphy, changes are required in various mac ops that the
> driver supports since the driver now needs to learn on how to tunnel
> various mac ops properly to a specific radio.
> 
> This patchset covers the basic mac80211 ops for an interface bring up
> and operation.
> 
> Note:
> Monitor and hw reconfig support for Single Wiphy will be done in future
> patchsets.

thinking about this series in the context of some other patches I've been
reviewing recently, I don't think this series should be talking about
supporting multiple radios with a single wiphy, but instead about supporting
multiple devices with a single wiphy. After all, the existing logic already
supports a single device with multiple radios, so it isn't the multitude of
radios that is the issue, it is the multitude of devices.

this would have ramifications on many of the commit messages in this series.


