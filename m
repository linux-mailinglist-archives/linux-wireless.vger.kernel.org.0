Return-Path: <linux-wireless+bounces-6692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DFF8AD420
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 20:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565081C20D35
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 18:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6A915443B;
	Mon, 22 Apr 2024 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wk5zgIqz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D421474D3
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811304; cv=none; b=Rv8GzY/GRwKglYOumJKJH2CWyuwQUPrMKoiOPtekbAHqz62epAXe7hk+Q0uMmfE9tKh93XtSQYsIq24jlZ/GuggcVQIu40GVaLe2OC8fcSxaN1d/mLS3Jc/TXvMVamuGxrIpy2GeiNdeN7XOe37OKBA2iMEOaPZadtGHsScNioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811304; c=relaxed/simple;
	bh=jiMQhRomslRZjylFHP1O3cUYkMYrG1AP9l7oaFkcLVA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Mzi8GYV9O7cy0YXpKW8qgE2uaXQQ/F+ajcKa3NazwxOlb15iyFTDsOP8mDCNGeAn5RFJiC5JWDXwscLhta7My9e6W1/0fuLvZ/Sq4SykN0Af1nS9KAqmFd4IXJ8FhHIDVEOdb+smnkApNEFPrwe93lFFf5rRsCISx5K5knNVWxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wk5zgIqz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MI27U9008593;
	Mon, 22 Apr 2024 18:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jiMQhRomslRZjylFHP1O3cUYkMYrG1AP9l7oaFkcLVA=; b=Wk
	5zgIqzA4Xg3LsaCKMJLW6Y0G5xcrgYoLWWt3Hv8ruBK1mQWDYQzzdS/7TAaABwIx
	3DRECrPKQ1eO4WbQkWJuyh5rvGt8sFUykazed4XQZ75/ZBKtc3tiaSKVIVEWpRB9
	IS0T0CYmV2txZdNW1hJmU5NCTmJZiu5HeBNP4qlsu57bZTwZ7KS6ck28MQdxs3QM
	QI2ubXJGIpmCQbXiBKqaJ14cXNCqul8pZscRp6F/SwozNdwJ/hiAtxQGMJJ5xR1h
	y6CcZv/3mo1tpYAEVxRAefMvXrxxtHysmSnG9KEXsGlRaMQlwtDNA58uI/zCMMGO
	ytGxsOd3fyBjXlwXLsLA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnvtn82vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 18:41:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MIfYUG006704
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 18:41:34 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 11:41:33 -0700
Message-ID: <88a1ab50-3dea-406e-adcb-b02786ce7f30@quicinc.com>
Date: Mon, 22 Apr 2024 11:41:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix kernel crash during resume
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240419034034.2842-1-quic_bqiang@quicinc.com>
 <87cyqmhtoi.fsf@kernel.org> <87frvivufg.fsf@kernel.org>
 <87h6ftv8w6.fsf@kernel.org>
 <5f63982a-eba9-4c5d-8ac0-52970316f940@quicinc.com>
In-Reply-To: <5f63982a-eba9-4c5d-8ac0-52970316f940@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kQADo7uCE3EqRrf1o_8JqSuOR4WHr-mQ
X-Proofpoint-ORIG-GUID: kQADo7uCE3EqRrf1o_8JqSuOR4WHr-mQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_13,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=898 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404220079

On 4/22/2024 8:41 AM, Jeff Johnson wrote:
> On 4/22/2024 6:12 AM, Kalle Valo wrote:
>> To avoid breaking git bisect I now reshuffled the pending branch so that
>> 'wifi: ath12k: fix kernel crash during resume' is before the suspend
>> patchset and my plan is to commit the patches in same order. Does this
>> make sense for everyone?
>>
>> I had a simple conflict in ath12k_core_reset() in these commits:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=052a6a7c74ae4f20a31a632184f4439edcb0f40c
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6bc740619993535cb64c4dcebb83c66acd506763
>>
>> Please check my changes.
>>
> These look OK to me.
> I'll test the pending branch on my laptop

pending branch crashes on my laptop
let me bisect


