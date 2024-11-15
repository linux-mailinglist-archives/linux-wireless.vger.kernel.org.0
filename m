Return-Path: <linux-wireless+bounces-15360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABB59CF81F
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 22:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437221F23FF3
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 21:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB9E1865E2;
	Fri, 15 Nov 2024 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WrcP+U6j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5257118BC3D
	for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2024 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731705939; cv=none; b=DGlrITfiERD9Kh8eMjyGCXgDnfUwi/6Pgj2jWo/Hmescx99van9Dv/DO88GqDPUjCDg9Pbb4138kvVhbl7D7KtnHSuT5S1RGSIFpp6iaTIk5XPGq1qZfxmFyGI0Bq9teYbM/N04ErBdfki8+6e8j5xlaSqFmqNOTgxUBkHEPWQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731705939; c=relaxed/simple;
	bh=PV7pSbkTACOb2cB8hByvgY4QnPNqddZUos3wavf3/Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kVfPEyaSCVSYb153/ubHjh/egW5EmyUiiXJL/QC6YlOREGvjBA9SgiUNzZeL3ztG+VukQRRSbQunCQVy2Pb+Z0W0CgECsJalblumbkbrsSuyXw5fMt2Z4m/csjj+S0JqlC0of/2iioMPzZxB9xAMAANM6/nlOeICc8QmdfYHeGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WrcP+U6j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFJNKDg000936;
	Fri, 15 Nov 2024 21:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JHwcqEQZrWDUzKNdUwCZondeaEft/qWWI71OIhfldSY=; b=WrcP+U6jAwSWxAi9
	3Jfu3kkqjGTR0jowghQF09Avj5gTaY7Fv5yPJRUZjswubxndjrs2AmKMcMqbwzSb
	Ps0dODb1NA1+vsf0tOJOGIC7bcjlMAuji10UYvGmzic8BKrKHk7731M/aKduiK4N
	DuAuTF9ASFmTahneGkKafy91X16P0Od8OupCvGIOZoqXRuuQx3YqHxSCs438NH+V
	lNlBzy4OUeSiy2fUchS/xSwffV39idrHYafomsgspNcL/9+Odi+fkrjZtbeFiV4+
	MdMojOkerYudB9rw7Io9Q9erp88YAXsoF73J/fsyfPHtlOIQuFAkJTww1IcDJgFK
	iEZIzA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42w9sv76c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 21:25:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFLPYiw008098
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 21:25:34 GMT
Received: from [10.111.176.23] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 15 Nov
 2024 13:25:34 -0800
Message-ID: <2fe0374a-0d2a-40c4-bce7-1d8ab133b288@quicinc.com>
Date: Fri, 15 Nov 2024 13:25:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] wifi: ath12k: Support Pager, Counter, SoC,
 Transmit Rate Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241115062854.1919672-1-quic_rdevanat@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20241115062854.1919672-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XlgPHxnZHFVewmk_O95zOczzOpfxB1FK
X-Proofpoint-GUID: XlgPHxnZHFVewmk_O95zOczzOpfxB1FK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150179

On 11/14/2024 10:28 PM, Roopni Devanathan wrote:
> Add support to request HTT stats type 36, 37, 38 and 40 from firmware.
> These stat types give downlink pager stats, counter and TPC stats, SoC
> common stats and Transmit PER rate stats, respectively.
> 
> v6:
>  - Removed unused variables.
>  - Used le32_get_bits() instead of u32_get_bits().
> v5:
>  - Addressed Kalle's comments pertaining to variable declaration order.
> v4:
>  - Addressed Jeff's comments pertaining to data type conversions.
> v3:
>  - Added macros to fix compilation issues.
> v2:
>  - Removed dependencies. No change in code.
> 
> Dinesh Karthikeyan (4):
>   wifi: ath12k: Support Downlink Pager Stats
>   wifi: ath12k: Support phy counter and TPC stats
>   wifi: ath12k: Support SoC Common Stats
>   wifi: ath12k: Support Transmit PER Rate Stats
> 
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 627 +++++++++++++++++-
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   | 204 +++++-
>  2 files changed, 827 insertions(+), 4 deletions(-)
> 
> 
> base-commit: 0ea161de5e5afa1323e982adc8f59bf4af99a84b

I've acked this series, but since Kalle had reminded you in v5, you really
should have fixed the xmas tree issues when you posted v6.

/jeff


