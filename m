Return-Path: <linux-wireless+bounces-19496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24017A4691A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 19:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D103173D4E
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 18:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7CA2376EA;
	Wed, 26 Feb 2025 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cKy6Ledy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A9523718D;
	Wed, 26 Feb 2025 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593435; cv=none; b=ZzSeK8UZ1rWj9dBbJ62bY6pLVZNlng8rBZCPBVa/uFqT2CGBrrXl00soAZwp/+g54cTk7Ad9y94SrwJlpVLmZZSBvasM7FgvC+CgamCqxWphoz1Glu2TcURlEgryGWOYxJPQhUJr9y12eIz0jUa28n0hG7zfh+NOfIXWNI22qrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593435; c=relaxed/simple;
	bh=uJq+bu2Gsv/1YcZFXXCnCHftr5EM8VJZUuYq6kB50pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lg9QreFfdNws+z8PeViAFHvkvbprTrPcmtCChcUCBBOdbRX2sGAfmYnHAqZydkL+moR5XMmVVT4EEszb/uadn8F6R9fj6/io2cAH+UyV/s5NT++xax3oHnUsAeNcSlzb705MN9N50EfJ8+nDdNj2PSv4ohqb66MbV68j9SKCLkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cKy6Ledy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QABfer017692;
	Wed, 26 Feb 2025 18:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UK3OEtZglCgu0R7nEVLQN2ZciwLgMdqHWEcxO4yfvYk=; b=cKy6LedyUGC4b41E
	djkwQAkYxcEdDS1/Z6x2BAvo0dff7z5ppXWNNJ9FwbUhJ+kZIRzmvA4obhJrN5gD
	zgWeR95pS5hMCqmYb1dlTDYiq/spPxXKkIdwlj+oDtn90RBzLux2G0+NwIrWzOVP
	moUMPQUZ0MpIGDVNrueQHQ/nMnfq+d7VQq0JW3kjcEFGF4aW+br+BbZFzFEgAsWP
	rOz9K/Ui1vrt8DSYyrObgiEUFQQUOoeOl2sfPwuuHingaEOr9DVGtx1RAhPruiVk
	k2knsVULYN9AhIQJkkxdFRaXHHMTTo0DFXGd6RVTGyITBdLCW93hquphsHiP3ibD
	V9P8AA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prn2wca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 18:10:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51QIAPdM011606
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 18:10:25 GMT
Received: from [10.216.2.27] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Feb
 2025 10:10:22 -0800
Message-ID: <cc3c73ac-409c-479f-8c51-11c6d60dd2f8@quicinc.com>
Date: Wed, 26 Feb 2025 23:40:19 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] wifi: ath12k: Enable IPQ5424 AHB WiFi device
To: Krzysztof Kozlowski <krzk@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250130051838.1924079-1-quic_rajkbhag@quicinc.com>
 <3db11710-8ad7-439b-8674-ce07fa221920@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <3db11710-8ad7-439b-8674-ce07fa221920@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Xp64ga6p3dXO-sWUO8H3PHQjjKvwwnXi
X-Proofpoint-GUID: Xp64ga6p3dXO-sWUO8H3PHQjjKvwwnXi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=618
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260143

On 1/30/2025 1:07 PM, Krzysztof Kozlowski wrote:
> On 30/01/2025 06:18, Raj Kumar Bhagat wrote:
>> Add support for the new ath12k AHB device IPQ5424, as currently, Ath12k
>> AHB only supports IPQ5332 WiFi devices.
>>
>> The IPQ5424 is an IEEE 802.11be 2 GHz WiFi device, supporting 4x4
>> configurations. To enable the IPQ5424 device:
>> - Add the necessary hardware parameters for IPQ5424.
>> - Modify the boot-up sequence for ath12k AHB to accommodate the
>>   requirements of the IPQ5424 device.
>>
>> Depends-On: [PATCH v5 00/13] wifi: ath12k: add Ath12k AHB driver support for IPQ5332
>> Link: https://lore.kernel.org/all/20250130043508.1885026-1-quic_rajkbhag@quicinc.com/
>>
> You marked this a RFC, so this is not ready, but nothing explains this
> here. What sort of comments are you looking for? What's incomplete with
> this work?
> 

Only the basic validation has been done hence marked as RFC. For the next version
v2, we will have complete validation and will change from RFC to normal patch.

