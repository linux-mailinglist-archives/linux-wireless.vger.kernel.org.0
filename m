Return-Path: <linux-wireless+bounces-22151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68953A9F646
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 18:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C4D460675
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA151FDA9E;
	Mon, 28 Apr 2025 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g8xmjBUA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C225E44F
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859187; cv=none; b=pHK47ZfgnHD+nAwJoQxyUk0nlEZTWOKpVVFFuHDq6bjdJlPVUbJOAC7UxWgR/wk5FWDqeu6PyBWDmMJO3xecijovrV03e33XI93RJu6NKEZFnEODdG9wBKJjENw5o0mtNuvH4wi/9Mx/fJClWjw8+n7SiKFONhNsQpgjvMMzU70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859187; c=relaxed/simple;
	bh=5S07gAMXDU2yGYCkwzVu+t5A7mp/U+b+7HVwoWcWL3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2DcJDemkbNcB1WU2gpT0iMveXbJRPOCXzomtKMxf92870Cc1d0t9cG4XGgKqmpewA0B6Ny6A2PMfXazxcO8FdLeZG4xac4cywFDYdac0arvOQyliD6tweHq/yLZBy86ePzAOUf1gwA3lQyHWWURZ3WnA/jXAShXAQnTLNVNbRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g8xmjBUA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SAD5o0028467
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 16:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pr+d6CwD8HQZBx/B4m+j0zeceAIo24NP3c7VO2pv9BY=; b=g8xmjBUABdUIIN76
	b9U2jDsI3u0RhU2IQqm1h8WdK5e2wllL38zToodCihhBHtp698U9SZxDKVyVNjIZ
	cH1MmT/CUI8CMHMk/Dh5KveXBeOeQ+AgWA1St9hfsdxBolfkTmm5ysz4Q5suP7fD
	9QYlYFxgvaQGbRp1p+rhJb7JjLwkL6znnJXUpJB8WPVH78kwD4PCxh3B9bKtgHbc
	6BOZORDDwPnnsb6lsg81FlViVUK+7Q/deziIkheREVIC3AsyZVbuc+SEjGwRpudq
	j+WSxzh+KFy83Ro9HWIMLV9KQ52jEInxbwiMOfyXjOquJu1776rfDeGdZzkZyLXG
	txvJyg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468qjwssh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 16:53:04 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b115383fcecso2905164a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 09:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745859183; x=1746463983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr+d6CwD8HQZBx/B4m+j0zeceAIo24NP3c7VO2pv9BY=;
        b=LJQ1ALn/hviS7NoohDutiOdJv3Eh386p6f+EJX8Z8qg737Gl8MrJw5k32/r5ewOwZn
         Eg2HQJJvEHUtz3hs6KKbAXTmQ+4E4+Qj5vaTXrXtNDU0Zoj2Mf+LJL0uVGUtjEosA3ph
         xOiqB9kdxPsW7aFOKGdZGLn4Fkg81PCvy2XkBkKKz/Y1EDHfuqGPLiUgZBBCOIyL2eZA
         Lc0+BHrGVZSkebDUCPC1boVU+u6gptOA02Bm1FdN9SkIXGZYjLMXpHlJDSJkUibhRdVe
         EIXFHaL/bhqyv/8IS4XUBiD9MhDb2WPDYdNYvb/KawlPb2SvQ8xxUhCQBW35JUM8gaVe
         eNqw==
X-Gm-Message-State: AOJu0YzhzI4jWmUst/sdIRAzwtPWrIRB8fHVBddAnKytg+6vNqCQvsF7
	qvaRjC+aPrqQNj0bHAHLypze/4bTRfO2RIZqmurd2j0A7VvkntkqvoDP+Pbj9eePMzty07v3o+6
	8ThFBwcDulCet1xBo0eU+i31a387LCGDiV7eEj2ts94s7DN4Z83ahkKaaL+9ZxGx+1Q==
X-Gm-Gg: ASbGncvyT0a3/yK9M99i9fl+S3st+mPqex4GBXIiKHAI2yG3eG010NUQA1uyslUEvdW
	rumrPjA5/OZiK791QIAgFJHqHIii1HqnkHfKtvODMgQ1+oyXxIDfASeHJD5FPhUZs8srR9605Bd
	Rh+CyeIiz969ZO2REZXhXJOlg+c/urFMcRT+vADdTiy6rgCASXLEAYbdQ1qj3E9WgDyS69Kxv5X
	94AkF1dkysAB0tPLwCCBWWRgKRh6dd5Qo/n0NJcME+juXH8KyaJjNFTzZeV5RUBGciU7aJa/spC
	rak3OXDKgbDQNFiOoJpGnGV016M4Eoh/YvD0yu7H47ObdZDCSffwpJjoWB35
X-Received: by 2002:a17:90b:38d0:b0:2fa:157e:c78e with SMTP id 98e67ed59e1d1-30a220b36c9mr48809a91.7.1745859183079;
        Mon, 28 Apr 2025 09:53:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH++KIcOD1fN+XXpeIyd81eig/UfWeeBlwthCVUH+4tnndpjeSWe1VcTub7CddBvPYhJk1XoA==
X-Received: by 2002:a17:90b:38d0:b0:2fa:157e:c78e with SMTP id 98e67ed59e1d1-30a220b36c9mr48773a91.7.1745859182628;
        Mon, 28 Apr 2025 09:53:02 -0700 (PDT)
Received: from [192.168.225.142] ([157.51.192.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f77641eesm7423164a91.25.2025.04.28.09.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 09:53:02 -0700 (PDT)
Message-ID: <cd38bb89-7d17-4bf0-8b88-459be675d758@oss.qualcomm.com>
Date: Mon, 28 Apr 2025 22:22:59 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 00/13] wifi: ath12k: add monitor mode support for
 WCN7850
Content-Language: en-US
To: Kang Yang <kang.yang@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YYJjoT_cpwBtbABlvVWPvGPlz2EeBJxk
X-Proofpoint-GUID: YYJjoT_cpwBtbABlvVWPvGPlz2EeBJxk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEzNyBTYWx0ZWRfX88PIC93YzOVN bQm0nl4dqI7aZozCoO+cDlrLmiy6B7DhyjErTRHgeTE03/eJgU4gVkaUlZE1moMvjE4KyhfH8JB GKwIBTw5LCCN/tbLH0Xt+DHiLm7c0AqORWtLnLemjBw40w7ktvW3+dfb+EaSv6OGeyGai05fjQW
 BIah+LfM6ND93I0JGqskSLjFOl+V391fBAn/2+mnvl2/VQNvp3IlalhrO3Oo2MuqL/RvvS//vWz wxFVVztVOfHBJfzQTpAltV7kk000azQbisBHspXvHqov1frXEiM6QavWm6oJ3PWYxUU6nMa5d8Z tE6v5PwWWfbIWHiKSwpNtw5j/hgQcnIfSJiHYbmJA4i6NLKtEZxKnQ502RPvyQirDlEFxJosMW8
 6U90rbpm5bGgP5oGdNbYsVAvE9LPa7Ajvo8aMCKvyJEb8EPuO+Z/gjfxbDL7vTxq0/Ik040c
X-Authority-Analysis: v=2.4 cv=c/urQQ9l c=1 sm=1 tr=0 ts=680fb270 cx=c_pps a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=XJI/iaC0GbrNbCf3OOiYRw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=P8mnIQ7AJwXJk1S5SOoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280137



On 4/21/2025 8:04 AM, Kang Yang wrote:
> Currently, monitor mode is not support on WCN7850. Thus add ring
> configuration, interrupt configuration and ring process function to
> support it.
> 
> Kang Yang (13):
>    wifi: ath12k: parse msdu_end tlv in
>      ath12k_dp_mon_rx_parse_status_tlv()
>    wifi: ath12k: avoid call ath12k_dp_mon_parse_rx_dest_tlv() for WCN7850
>    wifi: ath12k: add srng config template for mon status ring
>    wifi: ath12k: add ring config for monitor mode on WCN7850
>    wifi: ath12k: add interrupt configuration for mon status ring
>    wifi: ath12k: add monitor mode handler by monitor status ring
>      interrupt
>    wifi: ath12k: add support to reap and process monitor status ring
>    wifi: ath12k: fix macro definition HAL_RX_MSDU_PKT_LENGTH_GET
>    wifi: ath12k: use ath12k_buffer_addr in
>      ath12k_dp_rx_link_desc_return()
>    wifi: ath12k: add support to reap and process mon dest ring
>    wifi: ath12k: init monitor parameters for WCN7850
>    wifi: ath12k: use different packet offset for WCN7850
>    wifi: ath12k: enable monitor mode for WCN7850
> 
>   drivers/net/wireless/ath/ath12k/dp.c       |  28 +-
>   drivers/net/wireless/ath/ath12k/dp.h       |  23 +
>   drivers/net/wireless/ath/ath12k/dp_mon.c   | 816 +++++++++++++++++++--
>   drivers/net/wireless/ath/ath12k/dp_mon.h   |   3 +
>   drivers/net/wireless/ath/ath12k/dp_rx.c    | 122 ++-
>   drivers/net/wireless/ath/ath12k/dp_rx.h    |  10 +-
>   drivers/net/wireless/ath/ath12k/dp_tx.c    |  38 +
>   drivers/net/wireless/ath/ath12k/hal.c      |  38 +-
>   drivers/net/wireless/ath/ath12k/hal.h      |   4 +
>   drivers/net/wireless/ath/ath12k/hal_desc.h |   2 +-
>   drivers/net/wireless/ath/ath12k/hal_rx.c   |  96 ++-
>   drivers/net/wireless/ath/ath12k/hal_rx.h   |  12 +-
>   drivers/net/wireless/ath/ath12k/hw.c       |  12 +-
>   drivers/net/wireless/ath/ath12k/hw.h       |   1 +
>   drivers/net/wireless/ath/ath12k/pci.c      |   3 +-
>   15 files changed, 1127 insertions(+), 81 deletions(-)
> 

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

