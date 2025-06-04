Return-Path: <linux-wireless+bounces-23722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45059ACE3A8
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 19:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DF91894B6B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467C281AC8;
	Wed,  4 Jun 2025 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D6Z8updl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB54204E
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749058246; cv=none; b=a4gFV+LhatDC/hQbYesoekb69Q3C6h29SQWgPzseCxwxG4nIOKFAzR0a1yZS8MlLDpUyIwfBwfELTbEkyPcwvi0x/cHojM4WTp83Duf3LmTIJDl5iQ9be0vt3vLhF+tNOhWR/H7b+a8geylzCUqYv57qOEn4iA2hIHCw9GAUFQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749058246; c=relaxed/simple;
	bh=z8NRxewUDGs7o/rXUeuF0Hqsks4v2Q0Sai6hSjbuXv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxgqDA1mqv5btHa34v0Um6hd3x3Rdv22mNzxNavdT1/3gaTSHHJajtQwoUpl0Y4SSKPjRVX2dZX+bkB/i8WCP+1PopVxQRPDcQi0XWNsKQ9oxuzaDkO9BdOxr8PsR//dvqqm/xTx7BqPZGzilV2LpSyFAZzdS/1coHvtmgIxfJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D6Z8updl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554HTcwc013521
	for <linux-wireless@vger.kernel.org>; Wed, 4 Jun 2025 17:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M6QfFKXaIaqfEd/FkWiKq/aVwS4rH4eHPaNClleRyo8=; b=D6Z8updlxsb3HFG4
	WKtQaDqfNAr6yC+zBMcBaJ1ar3YR65j+cK9scRCzzB6oYefJ0IyDOVzZX5Lrq1vb
	gn2uxS6JiejrUgFhklNQkszz3VQLNFNtV+bknXNvAZShAeI0jcMAbJPTUcqoZxkv
	bQmMzCoLdrqxPvrrecaqCJpdNdcTLXBxq5j08WY2+jN4YkcAsRbuAXBGDWXPRX+X
	qxVcKCZoaHOYxy9XaLunQGvUVaNQtqwcMSJg3s4bc0Ru4YwlD1DQH7Et9Vk8UAAI
	gJ4OgtXnJFMxFE6iq2TrZnVccQgDaVOZQeNU1oZrOQG6BIPnCreFhTHpkrr4dj0w
	8tr68Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8npuqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 17:30:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b115fb801bcso21658a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 10:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749058242; x=1749663042;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6QfFKXaIaqfEd/FkWiKq/aVwS4rH4eHPaNClleRyo8=;
        b=TINFTOdNfBjq/SrPWtPvl1TODfPPPNP26bqMBoHKr73ocKPvHPaikGa47Rb+eYtrQk
         0AoTLK0GkN9q5HnbpXbrWckFuO8RfVA+6O5xMSj3m3YqQ0ETc38Qxd64xK03r7oL528Z
         5AZhIvxibYuOccZ9TRAVeTQQRuSqXJkn8TcFXWZFFGubigUyiw87n5h+S0s3m5Vmreqo
         2mO/psQUc9y6n5xWc62i1k62R5kUdSEdCa5YoYCmwm/WwgZEsAr7o6rU8+xI6wl2TQ+I
         ehHHKCWcvAFNG+7+NQW16Ay+VfEHIzK/FHRbaeyDAE8ABIfTtLOV6Na628N4MOA7V26Z
         fpfw==
X-Gm-Message-State: AOJu0YyvWMJAoqQKRorLbjdU9/5VtdBsS0C5q8f8icn6p+ulI7sN5cSk
	dyx2a9pveW1VhnSFxV2zdOiBqtuYilisj8YdGARxc5l0t2LvDtK7NlYyva6j+TxFQI4bPlBYTkd
	id5VECN3hheZV5KGUUFBR0NpioN9kdMRa4L+LtDnuAKOhjV1fNsndoDHYoNPdQMkrd6n0ig==
X-Gm-Gg: ASbGncuhVe63aHsETk6WTYiUWWxh253eOOh/PRsTK1aliRPuMPdukSw2yggKfDq2gnq
	aR05IY3fDNeS7HIvYY01x6y+T+xD7GHzMAVdvZfngUYorh4IG+rICeDj0EA83RJsKZtcP12ZDwK
	6WMY07B8bfy0+Si3bFhOjVizm1eonqVJNvhX9jU3loapMVr1QkMR+2+0kYS993FY5A7NAvtzkiU
	hpt38j21sOcoVvKcTRgu6Dc0lbaiOBb8Iw/R2z/sJ+1FuJT1k5rPCHR5/5N+39gO4sjF3PjFbNA
	Ht3AcotjrAh/stZVZ2BqSpS23c69X5EIiXMqq3/R84MPAttrGnvmkDwlOi1F3UGm3qc=
X-Received: by 2002:a05:6a21:648f:b0:21c:fa68:b457 with SMTP id adf61e73a8af0-21d22c6d975mr5964063637.22.1749058242172;
        Wed, 04 Jun 2025 10:30:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE912qLDr9L5IkdgKjb517k46WEvSgY7TJ2XqRQ5es0xea+pGkbn1tThWjp+5oOBCAedAJytg==
X-Received: by 2002:a05:6a21:648f:b0:21c:fa68:b457 with SMTP id adf61e73a8af0-21d22c6d975mr5964014637.22.1749058241756;
        Wed, 04 Jun 2025 10:30:41 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7480375b520sm3006149b3a.107.2025.06.04.10.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 10:30:41 -0700 (PDT)
Message-ID: <ae1215c7-5ea6-447c-8c07-5667e13dae89@oss.qualcomm.com>
Date: Wed, 4 Jun 2025 10:30:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k: big endian bringup
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <aD8HK4Iagc99skN5@FUE-ALEWI-WINX>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aD8HK4Iagc99skN5@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: joij88dvVnmZJ7YbkdI0PoVVwHz-GGDO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEzNSBTYWx0ZWRfX0mICLySNW68F
 KebIy+oj75atJfU2iP5FOZYs93pY/haznmSr7b0dlP+jISgtvPesRFCXKvr9tTjBG9/MTPf/d33
 rFitm44rjqLNcvfO9+0hD4Ac84hi3iaRgsZ9+L4skUN4M0xfnjgIzu6kRQHQ96Y1FyJZDn3Bc+a
 cryH+ZZOkSIkSgv2ii1ETsck0ChiRoJ+4iFS8iTdZz2r8et1x1J/n/F1YoyMYmY5twqTfPwgCZD
 Z9euIOG3LtYR4iSaxxwc9djIqv0a5cQrV60Y9okdLLk4EdEpCXidbu9+u2POd5P29BPpogsR+tb
 z76Fzn7Gl+r71DJyDsb54/ZJ97vKLK0m0bqERsVWFXl7lT1eyX/BZny34KAevnz34iu1iSgELaO
 JfoEnuYpi+Jb+UHo961ZWWl17kA/nbQ7DgGHkqiLuSyoXTHsy9r4vucZHNE58FgtLGLhLtwk
X-Proofpoint-ORIG-GUID: joij88dvVnmZJ7YbkdI0PoVVwHz-GGDO
X-Authority-Analysis: v=2.4 cv=UphjN/wB c=1 sm=1 tr=0 ts=684082c3 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=CLgnCW3GpZf6G4-LuiIA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040135

On 6/3/2025 7:31 AM, Alexander Wilhelm wrote:
> Hello devs,
> 
> I need help to bring up the QCN9274 with ath12k driver on big endian PowerPC
> platform. I've already found some issues and fixed the MHI start procedure [1]
> and QMI conversion [2]. Furthermore I added some endianness fixes on 'qmi.c'
> file and could successfully transfer the firmware and boardfile to the wireless
> module. But the firmware does not start properly.
> 
> I'm trying to analyze the error and don't fully understand what is happening.
> While 'ath12k_htc_connect_service' I expect a successful response from
> 'ath12k_htc_send', but the connection then is timeout. It seems that I should
> receive a message with length of 20 and at least I get one. But then the driver
> remains endless in the 'ath12k_ce_recv_process_cb' and I always get a message of
> length 0 from the 'ath12k_hal_ce_dst_status_get_length' until RCU stall happens.
> 
> More interesting is the 'CE_ATTR_BYTE_SWAP_DATA' from ath11k, that is still used
> in ath12k code, but HAL structures now are swapped in driver itself at the same
> time. Is that correct?

That does NOT sound correct.
What happens if you unconditionally keep the BYTE_SWAP flag disabled?

Note that to date the ath12k driver has not been tested internally on a big
endian host. But your message at least has folks talking about it now...

/jeff


