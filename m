Return-Path: <linux-wireless+bounces-12571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6861E96E669
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 01:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E2D1C2323E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 23:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9AF1B4C2E;
	Thu,  5 Sep 2024 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pCd2DdyJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA7B1B9842
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725579568; cv=none; b=KN47HpnHhWFbTvFuSCRHN0YuJjWe1I6R96WROoG6gKYrhWXuh5XdM/KP/DROdmJiwQ6JX9WvfGXQG/JdWchCRvsgXfeuIHYOoIJRljxrZlOjIPnyRDgs3ou3UzZ0MkOL9aCPgjc11sWXc0RQ/Kx2YjKjcEKfCEtp1TlPL0EyNUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725579568; c=relaxed/simple;
	bh=kK8gHhJVRkc5E+HOzEcQUteF+VUpsbtCOdaQBE+EjdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GerKWcliDQVJ9TUd3XvhMkZs7VW7KZgnZKSxcZMUGrqqCS8fMSXS174Slhmrzb7Ddo6pllUeePX9lHgE/zcioJ+TB4cUEy/IIdlUDoJ+KR3ePTyGo+t7VvENc+M1D8aVFkWqMCONuCe2o5eox/ZP4ZlMHii/ehzSEgK9yVk7CZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pCd2DdyJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485LuDSG018213;
	Thu, 5 Sep 2024 23:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fSgMPN1c02raEzlgzGBazhQOzmSp38Je+Fm2RQX34uA=; b=pCd2DdyJMs54SWKv
	xRpodZ1jx5h5XAnlGib6y/ZKcb9Du9X0XDy7momFX9fDWVOXqEe3i0h80xGx8WVM
	vn6SU9ctXP5C15hWQKATgq2N8jf8TquGNUSVFgKBq/ZdfScETIsvCLO9Rn+aEM3k
	x4mbI+SNXpLMcOyapwy5dMD3XNZIfkm/C5qFblRL1AcRmKba0LZv6SS6uCH26BHc
	QOfG0ITz46Mni2mOTn6TDTtD5sEdrP7cdZFSdSiYory9EfEOseZHTrbNaS2pczmS
	HNu3qACiA2CIJsnzX9UHrHqJX+UFe4ybw64S55nDqle/Fe+KAIVZlHiWMbEVZWoA
	wrgYhQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fj09rhbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 23:39:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 485NdMQr018741
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 23:39:22 GMT
Received: from [10.111.181.108] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 16:39:22 -0700
Message-ID: <4343b13f-e549-487b-86f8-b2e72db663a9@quicinc.com>
Date: Thu, 5 Sep 2024 16:39:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] wifi: ath12k: store and send country code to
 firmware after recovery
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240905023511.362-1-quic_kangyang@quicinc.com>
 <20240905023511.362-5-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240905023511.362-5-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F9sZbwTFB4BYwe9F3AghPjVPM1x8H9Nv
X-Proofpoint-ORIG-GUID: F9sZbwTFB4BYwe9F3AghPjVPM1x8H9Nv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=876
 impostorscore=0 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409050177

On 9/4/2024 7:35 PM, Kang Yang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> Currently ath12k does not send the country code to firmware after device
> recovery. As a result the country code will be the default one which
> is reported from firmware. Country code is important, so ath12k also
> need to restore it to the value which was used before recovery.
> 
> This is only needed for platforms which support the current_cc_support
> hardware parameter.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



