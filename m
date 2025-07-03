Return-Path: <linux-wireless+bounces-24796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 404F8AF7CF0
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 17:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15BC1881679
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 15:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9762E221FC7;
	Thu,  3 Jul 2025 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nfZ3Vsip"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0228922173A
	for <linux-wireless@vger.kernel.org>; Thu,  3 Jul 2025 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558097; cv=none; b=RAagJ7tUW6Oo5pBWSSBEJiaFQz0u9FuaSL8ePdOjThpk+V0ETtjGqYLHVJlwlRKu8DTq4ulrrztK8+qKfvnbdpT/ogEOJ+QYbJJdZcscFjcFcMI3SK2mHfOBTrdNGjei98vFefZ221ENbFN0Y8/LWjCZ1P/aayGupA7Z+WF9l4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558097; c=relaxed/simple;
	bh=D75uDndTm89/LjoUOIo8PABuNHsIGX5xwyDFq8URPeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfIdCeBiqG5kLMtRcjAHpvz03v9GlNI+Ax6eHJCs7S6qUqfSkF/7TMN9KMDqH5fi2h+KLuxHPdvJ1TA52qaZx/4twSmtmmdwNbsgZgaQniLrwS1zfCF19uA7wT5kqpn+0kRmBzF0Wkv9Rcgz6MLUwcUg9gHm/+um5qS5+NjeUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nfZ3Vsip; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563DLS3h021104
	for <linux-wireless@vger.kernel.org>; Thu, 3 Jul 2025 15:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e66gJPAc2xxHrV57qPovzty1Bqs4Qv1z3TiDtg2p3rI=; b=nfZ3Vsip35cjxAb5
	JzAo3tUZeDQTIonX8+mC0Owgn2JWD7V0yTFXpmHkJcreN+dTQAW+Fq4BV8QiAcrb
	vWVpnzPtNjKm+AA0Vu+AfOCpybWX/g9PffjjxeGpG0R4M/B830zwU5fobltiNEkK
	+sJPDwk8nev7WgORZ+/NF5elH0VoU+D8TeHap24y5ypI4EUJnosO2oDWuVeVK2+m
	Tu9GCm3Zg2N4YpQbkD7cVco0OpQcWu5u89AK4L1ZO2vYBo9Wt0fNm0PoSSFRdqH1
	DeIC8Qov6epeZCy8XmC39A74YxjejBzAr5c2tq2Z0InXKSVf41Xk8OJiNIStcPpH
	F57iLw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47mhxn7pha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 03 Jul 2025 15:54:54 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b2c36d3f884so1877a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 03 Jul 2025 08:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751558093; x=1752162893;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e66gJPAc2xxHrV57qPovzty1Bqs4Qv1z3TiDtg2p3rI=;
        b=OKq9+txnNg9Rlg+klhX9HdnMLYmu1hPer5Ys3hzvsHlE/ijRg65TypljjEFSK2gMNj
         9nlXVB5pmMYCQUTSJCxvLUXNhD4xNSpWe4W7LzOhnKBH24wzXXJQNceeUJdKe/1BiWS9
         6NyECjWuNtgKec2jZyvGlPoKiB6/fWK5w33p1iptNcCWNwZDgde6+s92ZDjcahZwoHKv
         wGJLuV9K0iMcV0ajysbu3vNoF5rVOzaEH2Go/aRnru1sXEjHdd7PX2z7WUvC1ISyV79w
         vCcQBVzsUiFXQ7Sje6N9d0H6zaNnJkblBO267LOWotntOrv0PfjJGqEoQktUTb5NPQIf
         5uZQ==
X-Gm-Message-State: AOJu0Yzx9jnGv/+RbMfxO2EuHPHgLYU64mrh8OWUTRz8soQmeKo7EjZl
	NyEJQoAycJP2SDnoq75PQlhqEE8MaK5k66gF1r+xexk/j6Pd4DS0iv1vJvqb+FqumEAgoJyYfsb
	D07KxWHqd/UMKMLfAtzGxgCsN42Of/Bg+xaoUopn+lH0bf1Zq1P/iW5mV8ICXBKPC1e5l06rrR4
	G9ag==
X-Gm-Gg: ASbGncuPAr2q11q7/ktcHaOERFSeqjQRCtsNTOfMAclco0nwSE9Q4gR7PsFlpVEWqTo
	k6chtIiax1+/LR+PrDT1B/yTNnuHO+f9hW0yaHlIZhh3q3UC7gAyvuNqqi3BxJjZNqZndz5/EO2
	7X+kad9ZSZq0SW9WrWqZCnVaxy/TguceVsm+8+/Ugp3py7yP4vJhjylH1Pjw4hAWii5l00x+J+/
	1YXa0VIjr89p8vw5EhmYaR4xFB2olca0abHkLZxYY3f9vZyvwDXlpIONXjiPo8yp+r6dz1Gf3qy
	yNGmIHsyRWl2q87OCxNGRlMbp39k8+jN6t0ryj+1rdN84cky23/ciBTgizbNpWZSSxga8FpufD6
	oPw==
X-Received: by 2002:a05:6a20:9d91:b0:222:1802:2ddb with SMTP id adf61e73a8af0-224096f8886mr7277311637.8.1751558093147;
        Thu, 03 Jul 2025 08:54:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfovFLKP4ugccyq6pnPkpHs0glNAnh7iMFcqkw0GbaDtFTnQSzrA3bcHKulIzAv25RYx7aCA==
X-Received: by 2002:a05:6a20:9d91:b0:222:1802:2ddb with SMTP id adf61e73a8af0-224096f8886mr7277279637.8.1751558092718;
        Thu, 03 Jul 2025 08:54:52 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm16542311b3a.31.2025.07.03.08.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 08:54:52 -0700 (PDT)
Message-ID: <20e56c81-8327-49dd-8d5a-09df66a724e6@oss.qualcomm.com>
Date: Thu, 3 Jul 2025 08:54:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/3] wifi: ath12k: Add 802.11 encap/decap offload
 support
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250530180247.424349-1-nithyanantham.paramasivam@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250530180247.424349-1-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDEzMSBTYWx0ZWRfX+62cr5s59d/f
 1iaWeUBkkQQDs8Ol4qHjZ3nMr5057Oo5vNcyhZG5CpbBi8mpMnUIRYlSxv+hGMDREo6ov1qPMot
 RCe+XLF2NFRDVUbaG51/cFeHoQUg8dagiVsJ1inXDABYIH3WYv1OwoFx8tblgwnJbNJSci1tHiY
 q7hLQ6f0sCj72P9c1+BgPIlrhtQ4emR3AKkh3EDizH2jxBPlrBxPjmkMoTaNVqGVPndYTkzqSN8
 KOtGjbADU1jA2ctQRpbI22vW5jtNAio8BF0IIX6f68wpAeJisq+///+8y9l4I/HA827GFNYe9wz
 Ph8b0DMEbro1neiAOozKVrMp3mtVWx/LowJXX5uhPE6vIpo6JS8b4wtWrLVDtSbaIkQ3VfdDA7B
 wGaUs1h338hTr37AlRHkbtEYuT+AcgIM150QZjnUok0grVst6e2PRCyalkxnjeax2R9XJFhi
X-Authority-Analysis: v=2.4 cv=EbvIQOmC c=1 sm=1 tr=0 ts=6866a7ce cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=obG9VW9YuJGvX6oOf2IA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: tNZzyITsM0RzbMRwu4kLPaOdGlr87YQp
X-Proofpoint-GUID: tNZzyITsM0RzbMRwu4kLPaOdGlr87YQp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=988 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030131

On 5/30/2025 11:02 AM, Nithyanantham Paramasivam wrote:
> Currently, the mac80211 layer handles construction and parsing
> of 802.11 headers during packet transmission and reception.
> Offloading encapsulation and decapsulation to hardware can
> significantly enhance performance. This can be achieved by
> having the driver advertise hardware support to mac80211 to
> bypass 802.11 header processing
> 
> Nithyanantham Paramasivam (3):
>   wifi: ath12k: Fix the handling of TX packets in Ethernet mode
>   wifi: ath12k: Fix TX status reporting to mac80211 when offload is
>     enabled
>   wifi: ath12k: Advertise encapsulation/decapsulation offload support to
>     mac80211
> 
>  drivers/net/wireless/ath/ath12k/dp_tx.c | 101 +++++++++++++++++++++---
>  drivers/net/wireless/ath/ath12k/mac.c   |   3 +
>  2 files changed, 93 insertions(+), 11 deletions(-)
> 
> 
> base-commit: 3d933084a072fd5fb5da54c06a017abc0412c86f

I already privately reported this to the developer, but for public awareness
I've dropped this patch since my laptop fails to connect when the series is
applied:

wlo1: CTRL-EVENT-DISCONNECTED bssid=xx:xx:xx:xx:xx:xx reason=15
wlo1: WPA: 4-Way Handshake failed - pre-shared key may be incorrect
wlo1: CTRL-EVENT-SSID-TEMP-DISABLED id=0 ssid=""<my SSID>"" auth_failures=1 duration=10 reason=WRONG_KEY
<info>  [1750467721.8771] device (wlo1): supplicant interface state: 4way_handshake -> disconnected
<info>  [1750467721.8773] device (wlo1): Activation: (wifi) disconnected during association, asking for new key
<info>  [1750467721.8775] device (wlo1): state change: config -> need-auth (reason 'supplicant-disconnect', sys-iface-state: 'managed')
<info>  [1750467721.8778] device (p2p-dev-wlo1): supplicant management interface state: 4way_handshake -> disconnected
<warn>  [1750467721.8784] device (wlo1): no secrets: No agents were available for this request.
<info>  [1750467721.8785] device (wlo1): state change: need-auth -> failed (reason 'no-secrets', sys-iface-state: 'managed')
<warn>  [1750467721.8789] device (wlo1): Activation: failed for connection '<my SSID>'
<info>  [1750467721.8792] device (wlo1): state change: failed -> disconnected (reason 'none', sys-iface-state: 'managed')"

