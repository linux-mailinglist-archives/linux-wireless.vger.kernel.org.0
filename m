Return-Path: <linux-wireless+bounces-2415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A06DF839A2A
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 21:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D359B1C225ED
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 20:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7719685C44;
	Tue, 23 Jan 2024 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SKoPL+HQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C980B82D99
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041155; cv=none; b=oSZbX3vrTaRp2kZJuuJn5gYvJAy36oA+tzLzlaC24PCZrILKumQCQti7CjOj1MqjeBOGDrs51VrWI5XBXKUURu7JYfnq3oKOlOJb52u+67oJ4/Xvah4/ESK5Ryg7fqbruF61v2yvoEtToy4JUqNI9F0FiX1GdDq0PbqMrSX3pGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041155; c=relaxed/simple;
	bh=Th8BPBOHrHd9oHrQANI9dqTLm1xtw9017eWbEBScLxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qomTZvrx7F7OMkHHVlHCxd/buF33uwHVgyNG9wKzIKgd0nGHP4fXWknxlx8OXYiwwKgKnc2QG+kkLEqyUea4L3tihJzlGmBZA/nUOoa4T5RCsi8VdFhRB2RydeUcsXFvDRkEIDHKuQJ2Jp3GTCX48MxzF4sBGnH5Z2KG1fP7ols=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SKoPL+HQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NBVJjc020636;
	Tue, 23 Jan 2024 20:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=FDjvyq2X40QjLJM/imXK1JmbkZyYpv8h7cnfj1OyjLM=; b=SK
	oPL+HQ+umMCq/gDGD2+E79qZxqMfIaKLgs3SGVNpD7hC4tHnsICfE4gZOAFgdGNK
	waMzEjfuCKuOJ2E2F7ZqHd7Himv94j7UK5xLzz3dK0Ei5wdYkDCr+D28/843OeY9
	6mgCddgsraSm6BCfPYmjf4L5JpOJLQwQC30cn4XeggE5xowejMd7msgEKIGVmxuR
	bk/U0lm5vZYHEzSe3q7emGhV5mvRnfO6kKAQowK0REGb+SVPHT8fZHsDJu/FTzaF
	sRpfE+2IAD/BWDbvehKW2/OTVEs8TSOzTqwuL68/RsAhwQWP8LCZRScDGUCfk5mZ
	pYs+8Gbzov7j8z8SSMFg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt3kuakqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 20:19:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NKJ6ZI027138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 20:19:06 GMT
Received: from [10.110.18.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 12:19:05 -0800
Message-ID: <9e41b70c-8db0-47d2-b3ec-76b596eab368@quicinc.com>
Date: Tue, 23 Jan 2024 12:19:05 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: add firmware-2.bin support
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240123122812.3811251-1-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240123122812.3811251-1-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ps1CrgqfGww8qAyAacdhj7r7JObeIZt9
X-Proofpoint-GUID: Ps1CrgqfGww8qAyAacdhj7r7JObeIZt9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_12,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401230150

On 1/23/2024 4:28 AM, Raj Kumar Bhagat wrote:
> Firmware IE containers can dynamically provide various information
> what firmware supports. Also it can embed more than one image so
> updating firmware is easy, user just needs to update one file in
> /lib/firmware/.
> 
> The firmware API 2 or higher will use the IE container format, the
> current API 1 will not use the new format but it still is supported
> for some time. Firmware API 2 files are named as firmware-2.bin
> (which contains both amss.bin and m3.bin images) and API 1 files are
> amss.bin and m3.bin.
> 
> Currently ath12k PCI driver provides firmware binary (amss.bin) path to
> MHI driver, MHI driver reads firmware from filesystem and boots it. Add
> provision to read firmware files from ath12k driver and provide the amss.bin
> firmware data and size to MHI using a pointer.
> 
> Currently enum ath12k_fw_features is empty, the patches adding features will
> add the flags.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


