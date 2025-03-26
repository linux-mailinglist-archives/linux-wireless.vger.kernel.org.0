Return-Path: <linux-wireless+bounces-20853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4495BA71B0C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 16:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D203F16F300
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 15:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950DA1E5218;
	Wed, 26 Mar 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ATWOLUve"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BEE4A29
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004170; cv=none; b=eW1KBbPm++hT4HiAWid3gil3Ts2+Z3ugaZuNLzAcZwyF0HmUNx8MDa46Y88SWvAlCOwSDAK4CFFLTvYZTjQBsj8cCfQufKY5YO/ixg2VTBZhX89vB5axu11fH4huVye3X1vxmMEI0nig/Hw+7s9fudFnCj43K/EqJc7D2S3OfLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004170; c=relaxed/simple;
	bh=ciiq+wa1JmR3N2lPnfaRsiXGiMxskH+bkoXftXUkjIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxNm0ik3IB6H8IQKXJMsUcGNF5zUTSkIUAHENfpCgy/m+zFCitiIhHkq789Z+cKt/gzfn48T46POrnDtC65woEnhj3YfJAM4deHh2BxXC2rtmfjLFmil4CH0ybmG0b6z8O+XRRgtrt5JJXQ58734irSblhPU2NQn+MZDxlE8hJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ATWOLUve; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QExAgZ024760
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 15:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ftx8bszKWuaDiRERb72/BG/+jeliiU1EiCgOEC0Exso=; b=ATWOLUve4ti6Ru/Y
	51iYr370PH/VcwpHclUe0+A6Bf0tWQnoqiajDFES3nJRIG7D6+fuTEBFe5YH+2t0
	yLJbv39hPre6bikhnMOm2WDTTGI2iW4zxwgmQvRr9LBECd4SaqVF8QSoNWWrkrFh
	8nXn3SDqYS0D9E0ZyXCiwdPea/9ZSne2UySIYTlHXxZ1K0cOhqImzq6IM2LQGsnQ
	HAc3pssdLa2DvhwZQajzDI/L062i3sVpYND1/NTQBs6hXwR/Tkgy0AuJqJEDvpc1
	OpwPdbiPUAWBldBy5Qs0WLUAn/E3O/TFQKopMiUy0ZtlTmz2In+9PDW4W/YJxOcO
	hnNQnw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmd35fbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 15:49:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2255ae39f8fso20586945ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 08:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743004167; x=1743608967;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftx8bszKWuaDiRERb72/BG/+jeliiU1EiCgOEC0Exso=;
        b=cKU8R4AafjH6o3YlIckRbm+P7kdUkXKxMsFwRpalhH6LZjvfici186xX4N4WV6JwbX
         pxmfoW8fDOkwK1zZ2TC7eAmAAhnL/qJMci+BDvgSOKULit/btOtxPLi5BkyjHQNIAQS3
         AP/z0Ka7/QiwZttboD3RnPViO5ErDzWOThnfENVEldx9muVNn+Pab39kBiCgPKaY7hk0
         xLmO+PQpwQrDl9HH4O1d0fRVHzVQpJIfw3qOYiNQNKWQPnIFIzj9AIes04gIDzKcdqDE
         K5z987QRIouwJJY5McmWsAtsr/uIrT0/cimUtHUOuLVagovnQqEB/LyP4oXctSgr1vpc
         IY9g==
X-Forwarded-Encrypted: i=1; AJvYcCXx4qkQfznzBPvF01i5b6dVBP7/zowAyO4h0SdsgTn9w+5g870SxeOFb7sZeH/3iNT2ZKTq79IwsvRGCyi5lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGBIM7w4hGbkEVIw/M6aMvsFBUwrNwEvtrVwYzMBWzBiGQvMEy
	yqmMSEK9EJHpopo11rS4KNrDI93oiR0H6iZsaYRoeA6nkNDXj1QEgY6tzyee7T9n+F4dvyz7T9h
	2JO544OOANAdcMH3me7DuQff/kgE80vqqQWRkX95tVwkdz0XaknOJES59LQtKbApOFg==
X-Gm-Gg: ASbGncsOWWRQk6clhk7oSRE2d+UNk9bTQbY4y/Y4vSRCvKF73shS97s8TuPpoHASiNg
	TJG3hbK+lXRoNaQbH3DXbD8hvyOnc+XC+PJDZEJg5/OjDVOVX0nrnvuTTHm8C9+7VCrwKFfRrgY
	ydw5k2ebS+daMzPRy4ATJk7UutukkYT3Mstbfn2UFvVwR7y09kARktygPIanQvr94HMZkmEt/SE
	uub+2jWirbFkoPKAYRnv9MafLplwMXzzY7etpDt7fl9XPKCA613Ndme0ePa3ntXizccl+iXTa9S
	at6HM9fh5lIOnwXh1U64bkytsdfjo/iXiFPNVGLJJWLVMbBZwymHocJC+TrCs7HT7RJADAg=
X-Received: by 2002:a05:6a21:700f:b0:1db:822f:36d8 with SMTP id adf61e73a8af0-1fea2d40a9fmr578586637.3.1743004167037;
        Wed, 26 Mar 2025 08:49:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8UTuqi7t5OuVGMa3PVeLVOGHZ+xFGRPs4+dMj0HCpFPMCjin77lPwftmniocTdk7sjC8Ohg==
X-Received: by 2002:a05:6a21:700f:b0:1db:822f:36d8 with SMTP id adf61e73a8af0-1fea2d40a9fmr578529637.3.1743004166497;
        Wed, 26 Mar 2025 08:49:26 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a4e5d5sm11192070a12.67.2025.03.26.08.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 08:49:26 -0700 (PDT)
Message-ID: <085bfa6c-cad5-43cf-9432-811b744da506@oss.qualcomm.com>
Date: Wed, 26 Mar 2025 08:49:25 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless v2] wifi: rework MAINTAINERS entries a bit
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
        Johan Hovold <johan+linaro@kernel.org>
References: <20250306092831.f7fdfe7df7b2.I7c86da443038af32e9bcbaa5f53b1e4128a0d1f9@changeid>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250306092831.f7fdfe7df7b2.I7c86da443038af32e9bcbaa5f53b1e4128a0d1f9@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1hN22MKnGoxN2dr_n7_NpUQ4gLh21wzo
X-Proofpoint-ORIG-GUID: 1hN22MKnGoxN2dr_n7_NpUQ4gLh21wzo
X-Authority-Analysis: v=2.4 cv=P646hjAu c=1 sm=1 tr=0 ts=67e42208 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=CBsQNda_XNR4200eS9IA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_07,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxlogscore=601 priorityscore=1501 bulkscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260096

On 3/6/2025 12:28 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Since I really don't want to be CC'ed on every patch
> add X: entries for all the drivers that are otherwise
> covered. In some cases, add a bit more to drivers that
> have other entries, mostly for the vendor directories,
> but for libertas also add libertas_tf.
> 
> While at it, also add all nl80211-related (vendor)
> UAPI header files to the nl80211 entry.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Johannes,

This patch has the unfortunate side-effect that get_maintainer.pl (and b4) no
longer add linux-wireless to ath* patches, and hence they no longer show up in
https://patchwork.kernel.org/project/linux-wireless/list/.

Thoughts on how to handle this?

/jeff

