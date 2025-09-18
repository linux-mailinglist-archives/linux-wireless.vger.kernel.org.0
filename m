Return-Path: <linux-wireless+bounces-27456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6081CB83007
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 07:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298724A3F9E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 05:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10F929C325;
	Thu, 18 Sep 2025 05:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XXngzjTn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC72281375;
	Thu, 18 Sep 2025 05:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172970; cv=none; b=MxiQkKt9OAH0H3MgpuxZrt7adz1ZoPKYXQm/Xc/MPuFq/WuGmNm2PPhloMqarXrYa95vuGva7VYNhWKyEPw6WQI2qZKJYyf6TKUeNc+Uuku9Fc4q334Q4ybzgDImdrAJVRj5Q+JJdY5q0hlWGkGjYKSr9gW4wzVD5tjUn3q1Zbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172970; c=relaxed/simple;
	bh=cVAohRqBcycE1z4pnfbYj51eCcPb2X2a+BWjmIWaDTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P7HXklJhY/n06p8SUW43XyxkF9oyOGnTDw58Zrf5uVDiQnlbL0ZWoQC483XOQveSxSjHehOSxVwjKyJ18+sioKieay4TF/bQb8TxFr8I1henhjVu9UTX0ESIp68bctNZkZV4X6+ERLrBoT3NbMZELpGkuvwlTDwvfnAKdT0XXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XXngzjTn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3JV91021451;
	Thu, 18 Sep 2025 05:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QJ35t+1pjW/4wbYnYDIZpDR70LxcJQIn85tHpDFOe4s=; b=XXngzjTnUm3rxVeX
	1RRMofUdZwX5cs9wuvdBMWYDBG/2sTAHczuvtwj3+fz4J3mnHz/FXOQSyfKPrii+
	FPRp2ZIQi4VMsaehzdgNXS3qfRq8Nl0O/gFr9Xr/cL0tVX/5vaAvxtynX+mwFBpA
	3VbM8H6IMmOacE8eYT4n8vmlzR4nJTeeF0uDPoQDCBuN37wjOE0xZeiWYhfTUsCf
	lpudK4WiYXtz+aU7KfQHo2YxKG1JHRoLMDOF3Q0VIlFR5rc+rlo+zhMGXL8497HL
	4XfVpQUPH4dkSeE/jxiTiKqG6bqxH9lolqMqk6ddBIY4iheIiIbsklhIdbkr9nXt
	56sEww==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy5d1e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 05:22:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58I5MX0e000628
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 05:22:33 GMT
Received: from [10.152.204.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Wed, 17 Sep
 2025 22:22:30 -0700
Message-ID: <27c1274c-e021-ba69-175d-a1271c33498b@quicinc.com>
Date: Thu, 18 Sep 2025 10:52:26 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 16/21] ath10k: remove gpio number assignment
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        Jeff
 Johnson <jjohnson@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, <linux-wireless@vger.kernel.org>,
        <ath10k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250808151822.536879-1-arnd@kernel.org>
 <20250808151822.536879-17-arnd@kernel.org>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250808151822.536879-17-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ihiK4gcQ95ce_hOvehKA0L1xCcQFPCa6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX1MjYEFI6UPVg
 TGRKwW3RwOlq+D4cvpqH75a+82bBSlRQmcfwyYnOJgAJQj/hTYm59xch759Bo54H/M1KuysTfz9
 +4W1SYRRR72OVFB6sGnyquYkRFV8J1+K0aSLcF2IY7u4Ik0U0FtdpxrGIzf2sFe99l6KJH8GPLq
 2HeK0Y3Q9tKjznDMaLZ9HiYy/rm50GCdU7keV/lD3ey10Tm0S2dAuVd3J2Osmfjgpe+Imy6d6TC
 IynLFStqqJ76szafFk8fVTi4Fv/7yvNRAVyUAd5NlLGWIUkyqfNFtVcG5YtblXcODDS9zNAG8pN
 yqi2s3XUda8kxfWDh8RHTWCxG9yjj/SoPsSKwCddkWYEpIBgnVZAr7nbnvE7eVjGHy3ucbWYzSD
 Lij9qxGt
X-Authority-Analysis: v=2.4 cv=Y+f4sgeN c=1 sm=1 tr=0 ts=68cb971a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=0JjSHZ6I5lEitlysoQ8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ihiK4gcQ95ce_hOvehKA0L1xCcQFPCa6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1011 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202



On 8/8/2025 8:48 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The leds-gpio traditionally takes a global gpio number in its platform
> data, but the number assigned here is not actually such a number but
> only meant to be used internally to this driver.
> 
> As part of the kernel-wide cleanup of the old gpiolib interfaces, the
> 'gpio' number field is going away, so to keep ath10k building, move
> the assignment into a private structure instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/wireless/ath/ath10k/leds.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

wifi tag is missing in the patch title.

