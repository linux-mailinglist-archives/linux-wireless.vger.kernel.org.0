Return-Path: <linux-wireless+bounces-22363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AD4AA7B2B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 22:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658529C046A
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 20:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3191F470E;
	Fri,  2 May 2025 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wv9aG0wU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9051D90DF
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746219462; cv=none; b=qPohlui8KKdsKXv+klOrD07XK3xtYrOd01vZQpXqaZK+NZzftWUlGOP5IbY7RyehI1oqXbSu7Ou+VbQz5hXoYGK7n0l9cSH6qjTCC7G5DTZDr4R/qpfoYE+q7n0ZLU+7UpC6nzqiYfeBnfp+cN+zm4kGgd76oZjV6X+N9lz2CGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746219462; c=relaxed/simple;
	bh=IrB2ap3FjWRp5N5E2HAwbXoK5kI7Eyc+9ClSyQCJJNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9EVwnB0xJ0Blf99s52hIZbEUrvHyNx0GqvY9jIvn0RXSyVAZtpxBsr51391j23lGj4sNV9JRuoUnoMOCttnnw9lpVvKkUbIAlRZMPdm1wj4gEYt9MP0XNBv9pHAJk8L44N7ILolNEBu4/hW4pfnat505W2tArxisMciR609WX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wv9aG0wU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 542KB0pL011549
	for <linux-wireless@vger.kernel.org>; Fri, 2 May 2025 20:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ct+Wba5sxV6p65F8HhAc4pv+h6X6o76MrJsyzGL2Pl4=; b=Wv9aG0wUDF2ii6/Q
	3gn9G2hHz0YZVZDKEUbB94Sm9aVDQxzq1DcABhGNyyBmqs3nbgyq08v+7oCXSRwy
	G9IqQkYxZehrfgB/aogzwyBVG2n9dyOVjKLug2IpMBq5lE7ls1t50Ma8Bq0SZS2v
	2x0oVPt4rMJ8r4QuhCVKKuh1lCYWQlGNfGXJSixd6j34axPZDCB+1OR5+aq6dRQ6
	hrqxCPVJlH+OwoavIbGbL3H8eLUAjXCqEbWKyPOdHiTP5cBqRFmXqTWaE4932/fb
	nwfEeQfI9PsxxgwKY2sttvdTaioKt/aGOG/DWh6yomkyUZO1HWGzUicoHnjeTeAG
	cufngg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6ub1a8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 02 May 2025 20:57:39 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-afd1e7f52f7so1327470a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 May 2025 13:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746219458; x=1746824258;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ct+Wba5sxV6p65F8HhAc4pv+h6X6o76MrJsyzGL2Pl4=;
        b=kted7+idM2Rmm5CLoNupkTDfBfTya2KeQMANa79FmwkpRiIcmcOS3q9v26AFenTux0
         uYA/EzBdJTU8XeYR73VYafL6Xl1GtMRyboteiVIiTqoo+PpoJOL4m0I0ozjG+dFTQ6bg
         PUS9DE9lPDAVetZAhxsFD8EaqekGygRnee7zkC0f0ZjrZEIigKBNuki4CSh/pA/NILxM
         hJr5pShMaiMgG54EXOilCuXybPFH6K/5dHYFioSZgK4LY6X+iwRYZ6PJjHa2i7fBisAB
         O8+LHTmFiJI8U88B3PrVvStTWCnuy7sHIXZRdF83gcy9nVRMJBrbADhlj4zrPvSRBwJ4
         F5Gg==
X-Gm-Message-State: AOJu0Yw17e8JcLXXDH+oiwi+nRsEFvAbfBNFjKuB8L2R9FfNmuJGu4cl
	+2i/VToJ7RryeqhHzh6oWXmg5liBnEksGte532GryYBRRbg3tbOA44rmPXun6BV5XHFsf9BoLdL
	gZRRMPrmi1ETqU56P0gh2SddqXpLrJ96Znqfc9T7wKQftuOKgtlan455ctPh0sWoPVg==
X-Gm-Gg: ASbGnctewiTU5Y9GDv0aHudX7jDrfQCkaNI3ttC5/zQOmJysrUquF+H0PASPOmui+Wd
	QHacrdUhvf6rt69RHCjnQxgYwcpJWJZY+SGWwMcu4AlIiO9sUZE5ZGShj5qcrG5/DyUmGRq1neZ
	SSQdsPuctxuxOc/LqUhYwSnvNJVMwJdh69N5VL0jPQS8oq+jRhOrYk08i6la7Dxjc8+HUMXG1rF
	QZhpyzWeL4gt2/yCmyPvpqOZbl1IFOFteXc04mFs8GzuiT7huzzdle+ZMFGXJoiphFsUF/tR8X3
	TSZmC054effDY74t6doTp/5rACKG3wgfQGpq3pvtH07F29dONZs+Iegd96ujRpe2KwM3CuFv0x5
	v/iLX
X-Received: by 2002:a05:6a21:4a4c:b0:20a:bde0:beb9 with SMTP id adf61e73a8af0-20cde36e845mr6553334637.1.1746219458190;
        Fri, 02 May 2025 13:57:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvlJZ9uGwCEkvaPm72WzkhLbeBGM5R4mihblJ4XtBkX/gS8TsHEwYkhPWhlELHQghuk1PGFA==
X-Received: by 2002:a05:6a21:4a4c:b0:20a:bde0:beb9 with SMTP id adf61e73a8af0-20cde36e845mr6553307637.1.1746219457776;
        Fri, 02 May 2025 13:57:37 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7b1cdsm2077133b3a.25.2025.05.02.13.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 13:57:37 -0700 (PDT)
Message-ID: <b934485c-05b3-47fb-a3ad-b7e03706d0c8@oss.qualcomm.com>
Date: Fri, 2 May 2025 13:57:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: remove redundant regulatory rules
 intersection logic in host
To: Rajat Soni <quic_rajson@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Aishwarya R <quic_aisr@quicinc.com>
References: <20250430154211.669502-1-quic_rajson@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250430154211.669502-1-quic_rajson@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BbAgEyIt-x4MXYn79LHFiBShJq8Cnd9t
X-Authority-Analysis: v=2.4 cv=KtlN2XWN c=1 sm=1 tr=0 ts=681531c3 cx=c_pps a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=pHcMd5RsyzlK0E1VJJUA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: BbAgEyIt-x4MXYn79LHFiBShJq8Cnd9t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDE2OSBTYWx0ZWRfX2PjntoKmGsUY F0dshPYluXvLCCt5IJ4RziI0iXfDA8Vt4eV6oacRtXWztSRx6d+1zDaLESE/pu730ivaPp8ihr9 Y/lOJ78lz9vAVIYpsBva5R4qLKMCNFhHX5z70H0w3o3Zzd4RvvhNf+pv49Yq9uJUV9c/kYDj9OT
 kVj6QMNbdu14z9hZBaWaY5Opbrwugc1BqXejE1mAR56veMpe1KHhFF+t6XE3H72RigAkJwpS0DU 0iMb7B7brO5pu0wzAYbqRaM10O0T0ttNchBrKPcaaMZmTP48GL6L3d4ovlOEeU9DXyFD0Rztylx wYPtBNJDxjg8ZWcuYG1RMtgIyKiIobCwTvF/TCZFZBnQ5oUkK9Jifjw86LJTgVMMcjfq/JTXTf4
 wlse6cREJi7I8HUxmbeLpOzIpTzhc4WVXYduij76auiMfbakVWAieBaNwzL1tPVd8n34qPAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020169

On 4/30/2025 8:42 AM, Rajat Soni wrote:
> From: Aishwarya R <quic_aisr@quicinc.com>
> 
> Whenever there is a change in the country code settings from the
> user, driver does an intersection of the regulatory rules for this
> new country with the original regulatory rules which were reported
> during initialization time.
> 
> There is also similar logic running in firmware with a difference
> that the intersection in firmware is only done when the country code
> is configuration during boot up time (BDF/OTP). Firmware logic does
> not kick in when no country code is configured during device bring
> up time as the device is always expected to have the country code
> configured properly in the deployment.
> 
> There is a debug/test use case that requires absolute regulatory
> rules to be used for a user configured country code when the device
> is not configured with a particular country code during boot up time.
> 
> To support the above test use case, remove the redundant regulatory
> rules intersection logic in the host driver. Depend on the
> intersection logic in firmware when the device comes up with
> pre-configured country code.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Aishwarya R <quic_aisr@quicinc.com>
> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/reg.c | 164 ++------------------------
>  drivers/net/wireless/ath/ath12k/reg.h |   3 +-
>  drivers/net/wireless/ath/ath12k/wmi.c |  24 +---
>  3 files changed, 14 insertions(+), 177 deletions(-)

While this applies cleanly on top of ath-next, it does not apply cleanly on
the pending branch.

Can you please rebase on ath/main-pending, and post a v2 with ath-pending as
the destination branch tag? Don't worry if the patchwork bot ignores it due to
an unknown branch tag.

/jeff

