Return-Path: <linux-wireless+bounces-9565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 013ED91753F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 02:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786C5284345
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 00:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80812579;
	Wed, 26 Jun 2024 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g7OUPIdq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7D563C8
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719362208; cv=none; b=fX83bw+Ozprmu/i6xHzlr5DlNozIvGYHxvNFCAFgBuDFZXVzOYgO+fmsB8YHQBKmsvAkXcyHQdhQTGNzR+/i45Bqfq6NDBs0Bn970YKmWYmd1kHd3Meq6RV5wR6BjlGcHkKZ74BYd30lXwa/ZzbRbfF4PegM7atcbrzBGgDP0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719362208; c=relaxed/simple;
	bh=4PH8QzohIeYSi51Vo5BU0ogEcYZDxvVqUOMrivMg+7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ehxD+9F0RFf+yrE1rE8I2KfA/1WiPi2bsYm1FG0/GGfkp7tTgU+qQyDBkElzFvkAgLg20uFRyVfP0osgmENBjPZMWNUrArENio+/iSKrmo9jhFL062mDbQqb0nJ4Oh3qSsvjVRqHz5nHD5+T6752GTuew85kgsa4i8zO6R9Cb6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g7OUPIdq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PH4j7I018178;
	Wed, 26 Jun 2024 00:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TbdLEe27pad8QYvgFcmoFIfhy5+V7lkkbl31wZ/GXRI=; b=g7OUPIdq271QZX88
	pnrmryJ/yH6YpMj9da3Npyt/mTTkOzz1oy1z2NCaN4jIzY6+CIUCMvZW7TPDGKDl
	4+FUyxvVXxFIlnN6kcMV9A7/3JwaCrbV0ZNM8VM3QdXl6k1XNb0SKoXiqH6hzAt9
	P6PEjBzw+rhKby9kcBWaDqt9gHGsiZN622K9sQeQChdSnn6YZbob6WEYVgkxvbEe
	ftZ7BCgj7tij7jRwBBpFhldO+Go5kTGPIQYdUmueBANmKWDUUBmPYs9D6Af0HJnI
	3a2Bt70hUufpyP/doOsrEnTcZ5/zKnd19Fk98adYWcvKqvZfRT/sr3KymjrK/DU1
	8eKC2Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywkyn84mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 00:36:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45Q0adPb006280
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 00:36:39 GMT
Received: from [10.50.50.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Jun
 2024 17:36:37 -0700
Message-ID: <42e80698-5667-5cf9-f8e1-38c9816889c0@quicinc.com>
Date: Wed, 26 Jun 2024 06:06:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: ath12k: fix peer metadata parsing
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240624145418.2043461-1-quic_periyasa@quicinc.com>
 <87frt1hvc9.fsf@kernel.org>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <87frt1hvc9.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G28z-W2S3iTUR94GSMZTtVOFE6XPK73w
X-Proofpoint-GUID: G28z-W2S3iTUR94GSMZTtVOFE6XPK73w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_19,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260003



On 6/25/2024 9:23 PM, Kalle Valo wrote:
> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
> 
>> Currently, the Rx data path only supports parsing peer metadata of version
>> zero. However, the QCN9274 platform configures the peer metadata version
>> as V1B. When V1B peer metadata is parsed using the version zero logic,
>> invalid data is populated, causing valid packets to be dropped. To address
>> this issue, refactor the peer metadata version and add the version based
>> parsing to populate the data from peer metadata correctly.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Fixes: 287033810990 ("wifi: ath12k: add support for peer meta data version")
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> [...]
> 
>> +static u16 ath12k_dp_rx_get_peer_id(enum ath12k_peer_metadata_version ver,
>> +				    __le32 peer_metadata)
>> +{
>> +	switch (ver) {
>> +	default:
>> +		WARN_ON(1);
>> +		fallthrough;
> 
> I'm a bit wary of using WARN_ON() in data path, so in the pending branch
> I changed this to ath12k_warn():
> 
> 	default:
> 		ath12k_warn(ab, "Unknown peer metadata version: %d", ver);
> 		fallthrough;
> 
> The benefit is also that now we print the unknown value. Would this
> work?
> 
> Please check:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=0228ca402186a123e5c90187f952121de50bf64f
> 

Looks fine to me.

Thanks.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

