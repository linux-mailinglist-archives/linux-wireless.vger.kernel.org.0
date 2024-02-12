Return-Path: <linux-wireless+bounces-3487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD80F851EF2
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 21:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0BE1F23731
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 20:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B02E4C606;
	Mon, 12 Feb 2024 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fBkNmUXj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597BB4C60B;
	Mon, 12 Feb 2024 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707771335; cv=none; b=eLgozy8cQe7xBV6hcUJFOW4q090f8TP+X2YExjBPHzpF1Kve7zH7RrcwUlI1KHTk8u0lL35zLRrv+3Jfbntg8JpUKUVP1jLBxjjJroy2qfxmUHNEXHdszp6zs00rBRPvzR7pDdTz1WAT+Yr6PUVwHi5sL/f3hPwUlsC+ZqdT1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707771335; c=relaxed/simple;
	bh=udLAq+saMaR2IQ15F+puQ3OPkAdrYlIAwaS55xxmXrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=svlVU2uMBCL/sX0CThYKpsjvx/8quA0KZ2zK+DrqzUjCE1NA2TRm19n/kAp0vvjo16vYtu/VS12fcuYLlDujQuJ8n7sCwMH62ik/kGKpTEB+N+Trqk4/3x7IdTSQ5kHXI1mE43pZSYyqPapDdsHmH8LMP4pCnKF8zvlqSOhYPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fBkNmUXj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C7uL7k002953;
	Mon, 12 Feb 2024 20:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=N1PUPiyBIlZSjD/hp9pIkB45FKKaRz7iaLkieyjcLns=; b=fB
	kNmUXjAzTlK3pFHsoSXPjUJYfKY6HLTF0l2UUnpm+W/qV/mrUIA+lJPPQgZ7SLk1
	HBoKrffYbIXYPmrAhUz5QSM93pFdgWxXhsRqXYcfVunbO+MT3JYnXNj3yHL7WxLI
	5teIM7pJY7qWf6tS2C0z1/Dr3/WZjUpJRi/1c5kSEnY8CYcBDWXATiP8Ei4NOKNZ
	L0IIFwLy/Ygx2riWNSbJADa/CwjUJ2WOsH1gcj8GDEwf98XbkLRubHKxWsQsyPdT
	tphRVlt0ofsn1c6Dw8ks8pEjDzPHEFfi8sPWKT+5YNOlE9SakTpATHWuDCKIGJ/2
	KTD4idOao8N2a+HaqLUw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62q2vcyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 20:55:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CKtNVS015036
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 20:55:23 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 12:55:22 -0800
Message-ID: <7768c61f-3f5d-4a2c-9b33-b585b3cf8dcc@quicinc.com>
Date: Mon, 12 Feb 2024 12:55:21 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] wifi: ath10k: fix board file loading for wcn3990
 devices
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalle Valo
	<kvalo@kernel.org>
CC: <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, Yongqin Liu <yongqin.liu@linaro.org>
References: <20240130-wcn3990-board-fw-v1-0-738f7c19a8c8@linaro.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240130-wcn3990-board-fw-v1-0-738f7c19a8c8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W9_w4qNM404UuunX2UT29pd0mqoEorCG
X-Proofpoint-GUID: W9_w4qNM404UuunX2UT29pd0mqoEorCG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=966 clxscore=1011
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120162

On 1/29/2024 10:47 PM, Dmitry Baryshkov wrote:
> The ath10k driver fails to properly handle fallback from board-2.bin to
> board.bin for WCN3990 cards. This happens because the
> ath10k_hw_params_list doesn't include .fw.board* parameters for the
> WCN3990 platform.
> 
> Add board data configuration for WCN3990. While we are at it, merge
> common pieces of BDF support: drop .board and .eboard names from struct
> ath10k_hw_params_fw and use the common name instead.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Dmitry Baryshkov (3):
>       wifi: ath10k: populate board data for WCN3990
>       wifi: ath10k: drop chip-specific board data file name
>       wifi: ath10k: drop fw.eboard file name
> 
>  drivers/net/wireless/ath/ath10k/core.c      | 32 ++++-------------------------
>  drivers/net/wireless/ath/ath10k/hw.h        | 14 ++-----------
>  drivers/net/wireless/ath/ath10k/pci.c       | 10 ++++-----
>  drivers/net/wireless/ath/ath10k/targaddrs.h |  3 +++
>  4 files changed, 14 insertions(+), 45 deletions(-)
> ---
> base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
> change-id: 20240129-wcn3990-board-fw-a2d97507a712
> 
> Best regards,

This series looks OK to me, but would like Kalle to review as well

