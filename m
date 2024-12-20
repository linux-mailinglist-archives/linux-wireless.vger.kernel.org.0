Return-Path: <linux-wireless+bounces-16659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DAC9F9AE5
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 21:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EE116A397
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE872210F8;
	Fri, 20 Dec 2024 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oGWLRAl5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F81121E092
	for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734725008; cv=none; b=FbLZdz0VCt3uHvPaWstTkFMPEWC5DeyAKHmxRmfd24iHk32q1IVZILjqnByZLISkUhiNbWvyUlieI1ZC5lzHAEZqvk2bAL0pnHblwqxiuidfNRsC8JJWwc8sv8N3ejTiiK4SGUOhiYZ4et+nnfEyAN5LkALD7Sd69PnbfZk0uxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734725008; c=relaxed/simple;
	bh=Zs4JlprWkRWYL9R6G/5v6VnIua89C6vTZlubdjcHDVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnN2wX2XFpFLpbUpFoCpAzTww5W3dnZvCW0fzGHTTC8qq/bs82HIIjbMypR5IzKuiFGnpn3kSd7JvioPkyrAU//7yeqyKfz2uSp9/OiqOBsDJtnolDPVCSxKNEuKnMU35VkXKl/e5EaMsxb+ohK6ZZieB77rmnz0kpSHSZ4MV7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oGWLRAl5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKBcIEE024466
	for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 20:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jjz4Sq36hjRrUju32Ul73yf+4eJ4TQw8j+POxAHkw6U=; b=oGWLRAl5+IHXStqi
	BuIYkO6QcmyJtbmJirgCxxb4AGmWJTSYFDq4KQx/ItAD00CgQbz0qv5OQbBdbwJ/
	YACVnW+5UhSxvf11eDzIq8Mo5sa0hvThJ1LQ5ZfenD8ynbmMSUWcUgM/kE7247nj
	/fn/em1aSY4IQTVzFxpNUraO/a21l10ZW9VVEz9vuupoKaszp43miFHvUtrDLA2c
	zYC6YIXLanddOZZ15+VzhAKwEJzUAMcG0JW7iSExoK/MEFb4e3djHpK4/ul7PZvZ
	je+OMzU3WdU4r6sIOVELA9HKSZ4r19PE+46qWH9Zi997E4mqH4IYWf6TKSRRBKG6
	cRa1og==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n7vg1aae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 20:03:26 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-467a0d7fb9fso5711991cf.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 12:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734725005; x=1735329805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjz4Sq36hjRrUju32Ul73yf+4eJ4TQw8j+POxAHkw6U=;
        b=IzzVEamf6juo3FA6cFb0OV5il6Qe3WvxGnm7S/wKP5U2nlxnysj8uSHocQAeKgYtKe
         tBapBgwezJwWt1SocJfjqb/4uWnD59Bdg3/ta520JGevceyUi026gahI2D5TYglzu84d
         tjFNQvqgmLP6Ul1+yXOu9UxsHatPHVGYVg9f3JdF1wYnhvvIxw6po7nbFxvq34sjJ57X
         T+0IZKJlQbUgzxgRgpHRcS1kNblHpHoHB+CX3ZU0tVGsVoRUiLxUKkRIPA2R70G3SwX3
         8qQCiuG5M2ZpKiwLOBZk3G/JfXHfqBV8EYXozeCZdmSRlGn5PhJcZuHf8udMdKQBxAvg
         2S2A==
X-Gm-Message-State: AOJu0YxvBDxc0NMqquGR/MHG6xds+hApr6+pBmQV9BtJqsJ6ysnVMgWS
	yZjbFOn7w9l+pAsff1y3tuoHDodbiM8PRtQYCC7VJb3AobbP/Z0m/fElwe1zCT8Z+AdFCD+ZXTY
	0ZDNLGLCClvHsHGaL5YeiP2w9bn5dGDDFWDZF96g8/oznyluz5CKcDuNp6362I1hHmA==
X-Gm-Gg: ASbGncs611VY3Pyj1wqZo8UiQAT2dwy1aGixJgMo/Acb9C2o/oQRlbVCxSIWnHG+eWS
	E5eacgHI0aoUBYtTN2nFLc0wXNlAD9DepVA9wvP7QLshVhT6c9HKeIOY6DiZvTIOIOVT48X/COZ
	59LpMFKEeueTQgfDETXoUqe3oD3pvybRIn5kMNhPv9m1KdXYU5FoS4enCXJYrfQAqmVrTzvk1UJ
	OMctM26GdxO+yr8l4JM4VtDWB2ySSkUlfmCloH9Ecj/+NhER3LBQZRBGeoN/arrodP2LUMEulU4
	cj14ytC51i3Rb5YL/5P3ueII2uRAZw9AEUs=
X-Received: by 2002:a05:620a:2496:b0:7b6:e61b:3e60 with SMTP id af79cd13be357-7b9ba742c0cmr237021585a.7.1734725005275;
        Fri, 20 Dec 2024 12:03:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGOU1M+QO2EF012zHKw00KoR9fn6Wc1NfhNg0vW4QRfK/giOH6H62ekNUf3K/h976xQT1AJw==
X-Received: by 2002:a05:620a:2496:b0:7b6:e61b:3e60 with SMTP id af79cd13be357-7b9ba742c0cmr237019085a.7.1734725004858;
        Fri, 20 Dec 2024 12:03:24 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e830b2dsm206705966b.8.2024.12.20.12.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 12:03:24 -0800 (PST)
Message-ID: <9cbdca90-e76c-4ebb-a236-a0edbd94a629@oss.qualcomm.com>
Date: Fri, 20 Dec 2024 21:03:21 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/5] dt-bindings: net: wireless: Describe ath12k
 PCI module with WSI
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241105180444.770951-1-quic_rajkbhag@quicinc.com>
 <20241105180444.770951-2-quic_rajkbhag@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241105180444.770951-2-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QZaSekK1HT8QyS_twFfxTqCh4rJtmi1h
X-Proofpoint-ORIG-GUID: QZaSekK1HT8QyS_twFfxTqCh4rJtmi1h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200161

On 5.11.2024 7:04 PM, Raj Kumar Bhagat wrote:
> The QCN9274 WiFi device supports WSI (WLAN Serial Interface). WSI is used
> to exchange specific control information across radios using a doorbell
> mechanism. This WSI connection is essential for exchanging control
> information among these devices. The WSI interface in the QCN9274 includes
> TX and RX ports, which are used to connect multiple WSI-supported devices
> together, forming a WSI group.
> 
> Describe QCN9274 PCI wifi device with WSI interface.
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---

I think this description is missing the key points:

* what is that control information (power, data, radio stuff?)
* what happens when the OS is unaware of all of this (i.e. what happens when
  we don't send any configuration)
* is this configurable, or does this describe a physical wiring topology
  (what/who decides which of the group configurations detailed below take
   effect)

And the ultimate question:
* can the devices not just talk among themselves and negotiate that?

Though AFAICU PCIe P2P communication is a shaky topic, so perhaps the answer
to the last question is 'no'

Konrad

