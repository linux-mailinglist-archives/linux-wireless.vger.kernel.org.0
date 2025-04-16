Return-Path: <linux-wireless+bounces-21605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B14F0A90853
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 18:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A37F19E06B2
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 16:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A008F191;
	Wed, 16 Apr 2025 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pcsntWIT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE97C1DA2E5
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819719; cv=none; b=JLh4Vf0nBk9WY+PXU6tlHEk5lMHBlbUaYkFskk1p4slgZE0R5eIhnqxInkLOm0mYBEZO9PH31pjaHu35ky8jiK9xOBYzTmAoORQfYk7g7D2IJrRCf6Rk9Oxfdv6cFyzUn9rVcFMuYRZDWbzwk42q7vAKg/IPKv0I4rINIn/WzXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819719; c=relaxed/simple;
	bh=PENEvEzcYAsXB6We2fjXtQye8Z8FpTDGUc7Z40/oOck=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=svciY2zpuVdFj+KqJhQFw5OWk5c7AqWbM2JPY0CM4E2dQfiv6k17z70n4rYjX+P1cNzRGPcFu0ENQpTcVlcs1lPL/PBrbLESh25SrGyqzyjVqiASXK+onV8stCR9WH5Aqucs+OaSnWRYwkN8bJy49zt0eu/XM1Rcbxrj11BBVsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pcsntWIT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G9mgRw022343;
	Wed, 16 Apr 2025 16:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l83jpIgWgbmM7T+Eo6No0DTf92PiLzgeTgePXXKMc/4=; b=pcsntWITGV0k6fvh
	NoLtP30aiiaVEcUrBdezjAuryEQJx0/0sZiBLG1kbCtvbTDVCsE0m11lfHB/qdUI
	HelSPdczhEXzK1Ncr0JWAYTNAhb9kzg8oEygOMyhEkWNU11k1Z0GuaQ82SgmtKwW
	eNiiC13+qoL2yYYVDy30KEFYRUodKJa1zq7o+10ZXaAJj5RYsXMM+Q/bV3lXB4QQ
	ESmOC7olDt/dkTWaVJQClHHCaaMGNvwKbY+zeAp2AHZkPHDNrBpNnuaoqiHAI+mP
	Dwprp9bQk6g7UvxjU5/YizpVNn5HrdzmJN1GIcBFNz6aMfRUH8mFvikUoZADlivr
	IPWOOQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygj9c2br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 16:08:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53GG8WRf026219
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 16:08:32 GMT
Received: from [10.216.43.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Apr
 2025 09:08:29 -0700
Message-ID: <cbfb1ba2-c025-07cf-ca2c-cb6357289fbc@quicinc.com>
Date: Wed, 16 Apr 2025 21:38:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 2/3] wifi: ath12k: Fix frequency range in driver
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Rajat Soni
	<quic_rajson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
References: <20250408042128.720263-1-quic_rajson@quicinc.com>
 <20250408042128.720263-3-quic_rajson@quicinc.com>
 <e789aa3d-ab12-ed19-0d58-012004e365d1@oss.qualcomm.com>
 <fa96e5b4-09b4-4f94-afd1-5e6eb850e8c9@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <fa96e5b4-09b4-4f94-afd1-5e6eb850e8c9@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GuV9i3VlBR3GuDKLHSqVEdp7O1QaqxLr
X-Authority-Analysis: v=2.4 cv=PruTbxM3 c=1 sm=1 tr=0 ts=67ffd601 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=svNGIkkX7FCknuvVeM8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GuV9i3VlBR3GuDKLHSqVEdp7O1QaqxLr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 mlxlogscore=727
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160132



On 4/16/2025 8:12 PM, Jeff Johnson wrote:
> On 4/15/2025 9:09 PM, Vasanthakumar Thiagarajan wrote:
>> You may need to rebase the series
>>
>> Applying: wifi: ath12k: Add helper function ath12k_mac_update_freq_range()
>> Applying: wifi: ath12k: Fix frequency range in driver
>> error: patch failed: drivers/net/wireless/ath/ath12k/core.h:1122
>> error: drivers/net/wireless/ath/ath12k/core.h: patch does not apply
>> Patch failed at 0002 wifi: ath12k: Fix frequency range in driver
> 
> It applied to my 'pending' branch with:
> b4 am --prep-3way ...
> git am -3 ...
> 

Ok. I was trying them on main branch. I'll use pending branch for such checks. Thanks.

