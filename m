Return-Path: <linux-wireless+bounces-22117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7480AA9E7B8
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 07:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 304467A6431
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 05:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3141470810;
	Mon, 28 Apr 2025 05:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ckbr42Lt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E7211C
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 05:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745817742; cv=none; b=hjwpRDiTnqgH4WIpwpDY/P0hAsd8l2Xuo4nFXm77fSFaoft+lPk1PRGF4F3QPRQ+hg1DlPmZEG5ZDsQzHVGwngYEhKhm7ctZIwjpIwcwwbFii8fH0tA890QJf92/oTLiXuV3wuOos6d6enRh6NZclJR9N22TS/T8oWeG2tev+pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745817742; c=relaxed/simple;
	bh=3henUX4NKz6VVunjhiYZD/e5BzOE2SlnjxKtzVscJW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hl438f9e12eVUC4wo4UnC3UVwzE30bh5G1WXav+s9ktUT2eYdcQJBlsyJqegAWV8rjcKr1VwtXpWzB+ElcB6aYxYWenETbeF0hYj5jQkPjDjC3fF7K+axYk+5F/kwCuu4CxO5Rx0i40qDHo8vbnkQxaoRSwn1ZX5tlnShrYLsgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ckbr42Lt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S5HNWG001134;
	Mon, 28 Apr 2025 05:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8zB7i7FMPZ0SGmLIrM2JNVyuaPKRrTP/VwBZVg6Mdyk=; b=ckbr42LthmazG3Br
	gr5KEiLreAHwE/GXG2GmyVbdwq8oZAAEVQFCeIA9nOhuUAizt/7PpWQmXlpe4dwG
	nkAkfayHWl6PGlTqPuKxRY8cifhtgAY0ieC14lhHaVSwWEhPctd73qQudAfpEjOx
	DszOrTlbVkF270qk6KKZb1xF8hk4MVxLMW4MotHAZd79Tu7c8h8gUrm6L13H9Y2D
	b+JZiyPsX+Zma1FovOZBPN25OYQms9zPmNkWIjQ8ne62moGx4C84ucPKrCa27g3P
	tnD8rGDHiIcYUxqhvz+FQ3E50VPB+5RpceCuD5Nk8n5W+1tlb31gPcAQNz63e2+K
	zcxNJw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468qv9gndn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 05:22:12 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53S5MBOF020354
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 05:22:11 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 27 Apr
 2025 22:22:09 -0700
Message-ID: <07f6395a-8bc1-491d-a90b-3fc50b8478c7@quicinc.com>
Date: Mon, 28 Apr 2025 10:52:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 00/11] wifi: cfg80211/mac80211: add
 support to handle per link statistics of multi-link station
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
 <07c00e98-5280-4563-854f-5c7a457578d0@oss.qualcomm.com>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <07c00e98-5280-4563-854f-5c7a457578d0@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=AO34vM+d c=1 sm=1 tr=0 ts=680f1084 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=U7NY451wSba6gpr0_gcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _yeqWyqYQ8mIYGhFWMXwZluNN9-DvFbC
X-Proofpoint-ORIG-GUID: _yeqWyqYQ8mIYGhFWMXwZluNN9-DvFbC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA0MiBTYWx0ZWRfX8aYMZkd84o04 60gwVZeHKubkHbAQw8c6eQc2zff3WcIIihgtoYUbphjGjgxDtJP/+E32iZ4Oh2LZL3RLeQXvQS4 QCm8JcktkYDs1Piic8agNs3bkJh4jep6aBybtsFB+zab2qeFl1KTcdbkP4Btbd+4eNHLYeGXH03
 EHfaDaP+ptB1TICfyX1efOrYMAD1Ew1561rdnpCbbEzypMNcu6ejzce0wB3e2qYRzfOCAghKOz+ i9hBGgT3tctq1peW30ZHFI2JFdrTSdBuF6tI2k9reGjgmJxtJThqX/CNS6za+2C4mVNcBvSBYGY /sVVxjgU/VxCzMqrwSYyVanerttO3sErnj8+hhVnqXXjrX+Dhm9PcPx4XKtqQ5PlduKVLKHgf+z
 AA2N9VsbQ7TyQqWTWFa73NtLJbEHcAJa4JsLux5A+HtUMfunldAiq0+YJXY04BdPnV3Ln3pd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 mlxlogscore=619 mlxscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280042

On 4/25/2025 9:16 PM, Jeff Johnson wrote:
> Just a couple of generic points:
> 
> The last ath/ath-next pull request was processed. You need to rebase since
> this series no longer applies cleanly to wireless-next/main.
> 
> When you post v7, please include all parties affected by this series, either
> by using scripts/get_maintainer.pl or by using b4. There are a multitude of
> driver-specific lists and maintainers have not been directly notified of this
> series.
> 
> Since ath/ath-next matches wireless-next/main, and since this series has
> co-dependent changes, I am freezing ath/ath-next. I'll continue to accumulate
> patches in ath/pending.
> 
> My hope is that all of the issues in this series can be resolved, and that
> Johannes will be able to apply the entire series to wireless-next/main. After
> that, I'll fast-forward ath/ath-next to pick up the changes, and then I'll
> start applying the accumulated ath/pending patches.
> 
> But I'll only hold off for a couple of weeks since I want to issue another
> pull request in time for the v6.16 merge window.
> 
> /jeff

Sure Jeff, let me sent new version with rebase and include all parties 
affected by this series.

