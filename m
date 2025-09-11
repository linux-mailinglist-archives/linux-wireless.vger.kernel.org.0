Return-Path: <linux-wireless+bounces-27235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B616B52754
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 05:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08B887BCC74
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 03:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB4E231830;
	Thu, 11 Sep 2025 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nLuZjxG/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8D62376FC
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 03:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562199; cv=none; b=Ap5GSNE0Ip6soJh7/CyuwbOHko6/V0byTXJzZnwVCtI5YAafSVk9L04lneVlKmV7jaBWjKh757wZ8ajOesu6ViY3Wpj69BLHPXrB/1J/RrZMr1WR3JsJjqhSYx09yBFIGWzycnu30rw0yJAYo6rPyVQoWKVpYYlX5pE+Yvt2Drs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562199; c=relaxed/simple;
	bh=ngU7VQf8+g3DiCBCTuhxe5mu1iW+R/TLmOiLpgZYJaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxdTk3b84jDMXx+G2682HQJWXZdYro8NSNNFbN8jdBP9FTM82VFxZQTkWWEXRwzIBiGh6mtitQHGGItT4cTFC3haa+NZLflCQgepV9VvueN/Zh+zWyP3WgShO3pBVbSL76YIoOhSEoEd9sMhDA85VPB94dVCKVIu+CFFfXSecJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nLuZjxG/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2Ioh3006957
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 03:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+9R+iVaTiIoWbj/VWEXbxWnh0hqwQQZCdTzJNbtwrUc=; b=nLuZjxG/fu6BcwLj
	KYfK4JCAgrOQxBViHMb2nLg4l6SrPYJf2cHGOHHfhAPgg8mNNDvGc2ddkL6md88h
	EJZ4Rco1Un1k/3Srpo4lxerAl/SU0CY0pezkDlbastH4yD2XC4VY9fPiLZ4WhUxX
	se2NPOdZr8tidDRmXw2mNfVXapDibQVCCCjNgqz4HZSanuVfYCN1ZVQMe9QLBHuM
	ueDj+zMCb2IjxUfEN5HJht+boLUfzlsY7w6n8CYgpBJ+0g7M+wqJSqQfih5YwUeG
	UkEGFe16OozZLTb032WxUCiPtSJITXWHl/DTejUGIDyE4nUs1YMxATAZOn35xRSH
	x79ATA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8ae3m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 03:43:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-252afdfafe1so3056585ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 20:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757562196; x=1758166996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9R+iVaTiIoWbj/VWEXbxWnh0hqwQQZCdTzJNbtwrUc=;
        b=TrorxTIjAUqqpX7PmgxUcXcaBVcM1GBJSZCrb/0sxvrHF+4azKIif3ajtRSulp7E2m
         r8PPJtok7DsjDDxyTVuoNHqqWpVFP6HFokdbdEw+TkbAQfeWh6AIdjzJVHhw1/e+VwdK
         pRlubhNdUqF6M0Wq9eYskrnYTtRxynUGY2p9/JqNbhYqldDymjlSKMSuxmxIeEVwEDSg
         wVsgNCwhpoowAD9nbBg/u5U2uh9t67o1ExK4GjhoqhgaDRy2D1cAHPwXlde7jEwdzrXP
         8l6RKlaxkc4qIgW9YUbm3ui+3vRZ95rhGHZ1BHzUB+pYroK1JHIS8L+N3A+KE6PeguTn
         5HsQ==
X-Gm-Message-State: AOJu0YwZYbouplVu3xTFD/yNX2AshTSqmUY3yhQUf8/wPpbTCfv3Yfif
	axuCdYCfmAGS1Ercjl3O0DS+M2ElbjBw6d7qSdHo11l8G2zVf2MRAua1Ts7r3FnSWn7T+GzVWWC
	t7ks/cruaKCTmt4wSiAHRt/NJbt49sqJXVdtalNj9sRh9D3hG559WpMxOYvvG1gpXUbhVzqzdn/
	wwyQ==
X-Gm-Gg: ASbGncua8Kz6qFvV7F5lJR3z92OG94bxgB6VVVvVYxt/trHTFOYGc8J21mGHf5EUvED
	eUQYYPO55/pZV4eGSDzEeNwyBnGKi+NkkR1XVpWl85M2It4EynnaqEXVaUq4OjxoRWsdWT2uqpk
	XmDecfQqH2jqUX+pQj90tbqBbsKnWPpxMdlsQKcTABkgBQh3zIGuwEdpWrPw/LXwFNEjKXx/xTR
	2ulS2ga0C0cr1qutc8R9I6Duraf8ddRzs22v8NhvdEk+WiLFUEZol6dx2zPJY2fCQ4Ia8QxVJRt
	HZK8fEfZJUnH14CZI4PvfgTHop2HBSC+4J5BJyUgJzmfQTGXiPAkffKAsNmqcsnUatQKMamQtoo
	XkRV+Xw==
X-Received: by 2002:a17:903:3d0e:b0:24e:8118:cc1e with SMTP id d9443c01a7336-25172483d47mr258421285ad.45.1757562195697;
        Wed, 10 Sep 2025 20:43:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVQRs3ibxOwoAiwmu6gZL6Gl3YffwQrSmQLb85j3TEkiuKeqOreHsGB6ocbzV5kysvQklbXA==
X-Received: by 2002:a17:903:3d0e:b0:24e:8118:cc1e with SMTP id d9443c01a7336-25172483d47mr258421075ad.45.1757562195199;
        Wed, 10 Sep 2025 20:43:15 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ae293cdsm3057935ad.114.2025.09.10.20.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 20:43:14 -0700 (PDT)
Message-ID: <958e1af5-b528-a157-0314-f81e20209845@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 09:13:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath12k-ng v2 0/8] wifi: ath12k: Improve hal APIs usage in
 rx path
Content-Language: en-US
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250910181414.2062280-1-quic_rdeuri@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250910181414.2062280-1-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c24554 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=nnDDZHBImGbq5RFmGnAA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: IuoO08WwAJuZAWs7NQpLrfu505gRsS-J
X-Proofpoint-ORIG-GUID: IuoO08WwAJuZAWs7NQpLrfu505gRsS-J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfXx3j7Nw6M7xZP
 L+ZR4r6lZTZCuZDC6GD3ENOM+PjAa0dHZUgjnnkmxg4a9TC86RW+Ar9M28G0RaFIdN43mW3eeGS
 fvzy/xp89u8X2BJJlO9IBoU+r/02E0nsbtBey7JxH/0v7Esacy+zNZmKyGMGu9uTa06H5hSWHNZ
 xsb3kNMDX+szLK6x1fsaQGxyrfmegj84abpe6ocoA0oSgpF2/Eyk3Rp+nEOhm7TpbwUH3+K+AZj
 ndEMGRtDL6WoyDlRtMP8GoVO8jU2pc9XDJqLaPSa5oYnu6DGYwpGR2Fhb5i8waN96TEWNDQb9DS
 JsBou0I+040PPZgJj4J7qMOGUqC2TdP8w3ks3jrThp6v+OiogSoHqnnHCi2YxzQyCpsKKfZXyde
 SYC7iMXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039



On 9/10/2025 11:44 PM, Ripan Deuri wrote:
> The existing usage of rx_ops to reach the hal_apis at multiple places uses
> function pointer indirections. In order to avoid such multiple function
> pointer indirection, extract the required hal parameters in the rx path
> right at the beginning and store them in a structure which is then
> leveraged by the rest of the rx path.
> 
> Move remaining rx_ops APIs to hal_ops to simplify hal API usage.
> 
> Also, make compact tlvs as default mode and remove the non-compact tlvs
> as they are unused. Since there is no need to maintain multiple versions
> of tlv extraction APIs, move the rx_ops callbacks to hal_ops.
> 
> ----
> Changes in v2:
>       - Update commit messages in patch 1/8 and 7/8
> ----
> 
> Pavankumar Nandeshwar (5):
>    wifi: ath12k: Remove non-compact TLV support from QCN
>    wifi: ath12k: Replace ops with direct calls for rxdma ring mask
>    wifi: ath12k: Move hal_rx_ops callbacks to hal_ops
>    wifi: ath12k: Add new infra for the rx path
>    wifi: ath12k: Change the API prefixes to ath12k_wifi7 in tx/rx
> 
> Ripan Deuri (3):
>    wifi: ath12k: Move the hal APIs to hardware specific files
>    wifi: ath12k: unify HAL ops naming across chips
>    wifi: ath12k: Remove hal_rx_ops and merge into hal_ops
> 
>   drivers/net/wireless/ath/ath12k/Makefile      |    4 +-
>   drivers/net/wireless/ath/ath12k/ahb.c         |    2 +-
>   drivers/net/wireless/ath/ath12k/core.c        |    2 +-
>   drivers/net/wireless/ath/ath12k/core.h        |    2 -
>   drivers/net/wireless/ath/ath12k/dbring.c      |    5 +-
>   drivers/net/wireless/ath/ath12k/dp.c          |   31 +-
>   drivers/net/wireless/ath/ath12k/dp.h          |    1 -
>   drivers/net/wireless/ath/ath12k/dp_mon.c      |   36 +-
>   drivers/net/wireless/ath/ath12k/dp_rx.c       |  128 +-
>   drivers/net/wireless/ath/ath12k/dp_rx.h       |  204 +---
>   drivers/net/wireless/ath/ath12k/hal.c         | 1048 +----------------
>   drivers/net/wireless/ath/ath12k/hal.h         |  106 +-
>   drivers/net/wireless/ath/ath12k/mac.c         |    6 +-
>   drivers/net/wireless/ath/ath12k/pci.c         |    2 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp.c    |   19 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp.h    |    5 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  501 ++++----
>   drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   74 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |   49 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |    8 +-
>   .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  369 ++++++
>   .../wireless/ath/ath12k/wifi7/hal_qcn9274.h   |   35 +
>   .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |  161 +--
>   .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |   82 +-
>   .../wireless/ath/ath12k/wifi7/hal_rx_desc.h   |    7 -
>   .../net/wireless/ath/ath12k/wifi7/hal_tx.c    |   13 +-
>   .../net/wireless/ath/ath12k/wifi7/hal_tx.h    |   18 +-
>   .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  364 ++++++
>   .../wireless/ath/ath12k/wifi7/hal_wcn7850.h   |   32 +
>   drivers/net/wireless/ath/ath12k/wifi7/pci.c   |    2 -
>   30 files changed, 1452 insertions(+), 1864 deletions(-)
>   create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
>   create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
>   create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
>   create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
> 

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

