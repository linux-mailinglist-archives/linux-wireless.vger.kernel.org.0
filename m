Return-Path: <linux-wireless+bounces-26177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A19B1C794
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 16:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCA23AA6E3
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 14:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AAD823DD;
	Wed,  6 Aug 2025 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wd6ICaGb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82F4224D7
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490239; cv=none; b=N6MSD+B6NECroECN/K5lwMyy+Ri7fp2lC29kCVSrJqnWmEPrf6ucDxTt6kyHYDqk3jpf+OFhATDFBIBhP4X+vA8NEkkeKcu+Rl2Jgp8kdLw9jcrBawm4rqb8FFAAvULWbRa+ewUZpkkdHmLsvoEtMVq8TWSLCgSisZZHPPDugCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490239; c=relaxed/simple;
	bh=Vjt63AnxMkd3MhQNWcQS7lTtdPYzxf/QKm7JiCdAcKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxlyvxvofYei7dITwFl/w9DnN8FvscH/7pB0Za5nDRFeyWf2mdH/C1Fc7a85UYpf/3nhpWZNB7lZJ1kD7gejo6xOxvtQbi6Z5semwEGCCk0+ToLfoW2Om6YwqAymNNin3xkTSQSCyZnnPO3pq0Msq2f366iosgc5PAWn1rrqtRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wd6ICaGb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576C6Hfb025397
	for <linux-wireless@vger.kernel.org>; Wed, 6 Aug 2025 14:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uaPV/AZfNgwCFIWFD6wxN7pO1VLtWRJoYaxtb6nyD8A=; b=Wd6ICaGbjqFSkgZW
	UvGOTFboPSqVVAJyEzmx8AmjApiOBZieY6GyDDQlCKHt4xWblakSCwfuOVXLj+38
	oLue6Lz3tz434yMG8NEcZpNfCM5S4hny88PivQvojrnmaz7r0Gn0J3Qw49qMzjfI
	RH0v7Ns+cjqihP1J/0efGp0EkgUyuFfCkCN3hjBD4XA9/AswFB2mezjBuRFFcYjZ
	PTMUtWlkdpkf3/SaN23UB3VIKzbbU9jPq92Zep6Q0LEe+D8w1v0cYe4/5MSKc4l2
	V7BKyPIKCO0wEYsfgGp7v61Fk3vFC1D6EPtEHcX1bxOGa3b687HLH2i+cJtoi3J4
	IekmAQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpvyu2yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 14:23:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23ffd934201so42280765ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 07:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754490235; x=1755095035;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaPV/AZfNgwCFIWFD6wxN7pO1VLtWRJoYaxtb6nyD8A=;
        b=n/CHhe/bcyp1vFcz428iVMP3pSTqdTudJm6zJSA28h2r/yNo0jeS9aB30f2MPSCeA4
         di4xlZLOr8uz0SLS3FmxVHyM44eKpyqtWl8Pp9AckMC1PkksYe3WnBG+vG8YSa4bbOYW
         WVrFqXR0jsGZxUoKLtHnTXU2jKiKOvzv0RBnX8bmoAv1ysvdq++QXFxuyhbrjcn/kNG0
         jIc6BpKY9bi5v2fla/M5ORhiMZIDuIXNLdvfm1PaBc4+b6QWY7kyaVzQyDLwE6ZAby2H
         TG1VuY/LoSc5JUf0bUELqaFhF3TfXvrMzPYqsysPzxSmjYgylxBFSh5sPmM31M+GDbvI
         iAXg==
X-Gm-Message-State: AOJu0Yxx9+PUDypHQpFn6VL7dT1aiNtU4mY1/pJhmYvZjuPm98mUTbxp
	v55vMUJ+5f+CBmQ0ieBF3sTxisOH3K8BiktCwYsGf30DjnHqzwXAOmAky58ey940LZJx0OlUSTQ
	4IIDD6UyPa1pPZ7n8PP4BR/7hv3QS0Cpdvd0hh0ta84VYwn+sgYdbjUguQCAqOF24vZ9sutC6hE
	o6uw==
X-Gm-Gg: ASbGncuy3tHHOS9oJLbQhFNxv38Tfvm72qJc0SZ0Ff98uQRd2STCUDS2Jl3vqRkK/p8
	/9+9QhMkLkcUuGeBZqxgkbcp3U3yMj2Y7omMZT7GlVAmIrB3oX3O6CQQYeHCxsGYzM+IhLbSAWg
	JngWXaBx3c0KDPo3mh4ePDxZ3Y8EjQgdktJ9hJhQUI1jVH7fAsvwLE8tDGDgcA3M1E7zBYSB+SN
	6D/CDzArdorAwt25koIoC2ptCPLggMgVjV7afu0+NU3jbIIrp3DuXklIQfD/BMOTLlw2PuCYubI
	8ULhwfXYcvAU4c3/vks4lR3SL3eKHuUNvsQxDMUj5B8F2orGEUy0fDOh2uTMCv6cJi04w8R/Q9s
	LB899YgrOQqTegYpRPA4=
X-Received: by 2002:a17:902:d4c9:b0:23f:dc56:66e2 with SMTP id d9443c01a7336-242a0b60289mr37054235ad.38.1754490235132;
        Wed, 06 Aug 2025 07:23:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq/swoMhIdNOjXdIXnOXzyW6K59WDzzzrR4ReGp34jAMiAKMy+WZB/S/0f/j3QY0gpdGOqjw==
X-Received: by 2002:a17:902:d4c9:b0:23f:dc56:66e2 with SMTP id d9443c01a7336-242a0b60289mr37053735ad.38.1754490234627;
        Wed, 06 Aug 2025 07:23:54 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef8204sm160476135ad.34.2025.08.06.07.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 07:23:54 -0700 (PDT)
Message-ID: <29ef8aab-06a3-48e2-a370-86b1b2107143@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 07:23:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] wifi: ath10k: support flush_sta method
To: Zhi-Jun You <hujy652@gmail.com>, jjohnson@kernel.org,
        Remi Pommarel <repk@triplefau.lt>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
References: <20250806070005.1429-1-hujy652@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250806070005.1429-1-hujy652@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8hKRnc1bV4iWswIrEGlnwX976NSP0Z0R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX7mt25NRW5DQc
 yauMm8m0pj+kavzU4JB6owHW/Uh9zJQY3MTvgGj/6KwiUlWHVdipQGF+tBkNYQs4XEqA0ZfpgCH
 LvybZ93ieabQi8kymAtcRFB9yebYZR+ZRo7X/AxzrqIzzNXyjSHNEVNcvbAOFURcyvloRrW4sz8
 oZeM95DBYu9suSBDk2sKkM2ks7jM6h1jhbM9hI0o35F7mmt+sixi461uK3ifGt1iV1BME24lmNx
 cYTJbfFaiGyMIpDVnm/LyDe2TDvLYHfGAK6M/PDJzJNbLIsBjlJQ7vCOT3DZgQCFzjrWl8grmjR
 sLYmkTQ9xlC1ebHUV3il3qlGFVJTdsMj84p129lCYqI8mjHpRXctTKltFBgVHWIk2zZ4Erqe2gG
 pQbwv5q0
X-Proofpoint-ORIG-GUID: 8hKRnc1bV4iWswIrEGlnwX976NSP0Z0R
X-Authority-Analysis: v=2.4 cv=NsLRc9dJ c=1 sm=1 tr=0 ts=6893657c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=00e0whw43lWyotVrT1oA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On 8/6/2025 12:00 AM, Zhi-Jun You wrote:
> When a STA is marked as no longer authorized, if the driver doesn't
> implement flush_sta(), mac80211 calls ieee80211_flush_queues() to
> flush hardware queues to avoid sending unencrypted frames.
> 
> This has became a problem for ath10k because ieee80211_flush_queues()
> will stop all traffic and call ath10k_flush, which waits until the
> whole HW queue is empty. In a busy environment this will trigger a
> timeout warning and stalls other STAs.
> 
> Fix this by implementing flush_sta method using WMI command to flush
> frames of a specific STA.
> Flushed frames will be marked as discard in tx complete indication.
> 
> ops->flush_sta will be set to NULL if htt.disable_tx_comp is set to
> true.
> 
> Tested-on: QCA9984 hw1.0 PCI 10.4-3.9.0.2-00157
> 
> Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
> ---

There is already a patch from Remi pending for this, see:
https://msgid.link/cover.1732293922.git.repk@triplefau.lt

Please see if that series addresses your needs.

First Kalle, and then I, held this back due to lack of internal validation
across supported platforms, but it is actually still on my TODO list:
https://patchwork.kernel.org/project/linux-wireless/list/?series=911851

Let me make one more validation request internally since I know there is at
least one ath10k-based project with active development.

/jeff

