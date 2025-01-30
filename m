Return-Path: <linux-wireless+bounces-18234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48684A237D1
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 00:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F333A5AF3
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 23:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF071E32D4;
	Thu, 30 Jan 2025 23:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TtjzrEIu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B6C1AE01B
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738279788; cv=none; b=nXkDafz46A0epIT9GZl7Qu26ucESrT+47FCapb1lsdiY3rNZot11Ni/hhk5c2ozR2qq8UtWwPsrL5LmwMZEakpT0IBGfvgas8DuOGO2HMLEhFkTJeiN7xg1uogiplhjS/HhCRdKLUU5xRPRkyvMEib1ykPW/SDOZmXBmfSlgZRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738279788; c=relaxed/simple;
	bh=sTq9SiGCHKzIPYXogvdINblF1u0UG1CI4L1VPaB3tV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVZL4MB12Zd+GzRCCMUxlX7SRRA3Xf7x6tu3IHV4tTeCCXk3gR5zXVF4bK9rikARJb4tqMEwSIIbacDWuikLTmm4v7EgVjvOs7WMntyCUGleQDpgBuhxg/D00HnKpx8dojpI4Gtcto77XsOjwkz0+K3wUZUAO+F5FdOm8w425QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TtjzrEIu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJ1lhX011061
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 23:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PpMQVs4KcQMDKPMkb9LX0wpMvU/A30lXuqIs/wNVros=; b=TtjzrEIuXSMk0FSE
	ofSegcADmrf72Ha69LYwmUs6+GCsQhLHFoHabDVkXMFHUWn+3/Uz7RNgxdbBwcNO
	rj2I2wCje/cczO/O895lbQutXUP6GBeISH3P+cOJWNYP1uPUmfayJKIykwQPZBZC
	c7kuA7TgB6N8ekkGGIsw8VvOPvrzITJxEpdOMQP0JsQzOx7w9aUHcjbXC52E1eBH
	n/TqciEsTNS+DdPOVASRmGbPJa6CG1+n/a/DIUl8VqnM4nzFPA5bVP3QLeySGDkX
	2HYP8RVhlQ0DqtFhTJifY6TT30jaGCDomplVZxI+FziOK3Z109BW63YX0AZNZlPL
	daXPFw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gf7m8fpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 23:29:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2162259a5dcso43764235ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 15:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738279784; x=1738884584;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpMQVs4KcQMDKPMkb9LX0wpMvU/A30lXuqIs/wNVros=;
        b=R+nQtT9mqWLyuzffeTC6IyH4o+MRetgnrEoEpLDj3XUjNZmZpnuI471T36SesNDlBg
         fSHc/5ul8qmgyt7TQL1t079y8a16w9KBSokP7oH85SPzzHnvItGGxx4cSDjb3J0KhoIc
         Xg7zcq4KWpESbdJO36Cij/fQmIQeUP8Puswrg/fbeV7yp4BeLFMuAisahibSK1YyrO/3
         xqLeB5hBOnkBbq5yXSeHCysK9o7rNM+bsRsf1wA2pEaHgAqGNq0AQQkY5MzHy6DGrlOI
         tiBdzu1L3Jar0jPQxlddtrIgxzRB2+v6kW3YBB9RY9Wk9Clz/9c39kIj17zjBC0rNXhZ
         XEOQ==
X-Gm-Message-State: AOJu0Yycs9z/Y+ETAzVDQEI4Wq+F8dBkVO1d8RxKIr1M+uuhGaZUAr0c
	g0V9EhBWGWGDqZscKmAUdv0VdDGj/YoQRllBnesVosfEK39eLzSz21P8cyaSgv3Uvsk0Fb2OdBJ
	YiY1iY0MLKOWuJaAIGNEjryyZXnpKAWqGMPSziaZ7XXu5/CKwfKcRFUDmChUKekT0dQuib122pg
	==
X-Gm-Gg: ASbGncuv/kYvkksxRGoEDDNEOZAs6NrrOIwYDaPgn2CvKvYuDYnVBKKDPfLGS1IxQ/r
	AdlqoKzDWNze94MfUY01rb+hZRcz55PjBXgxPDoVrasKy6O3xFnde5P0nbfihQCHJ2tdOjW/UiR
	srkv6Wt/pI6m3wy2isr6uOv+OCf7LsNU7w6hE8UFWuW7CXIQZ5dh0MKYG7ZbHuiHKZOKdzaC8lX
	HAoGa63dmlO/mGtcTbaVxCFdnBZC22y/mbOrgiVi8o9y+VYjOktLDlWetgWNIxPUfGt4r0qoNT8
	lTEY8pxPbz8DCVpKnCwrFdeD1N33osTKzm+e5y/ejjCgCGvN5lKib86t7tLc4r4aEzhL8PQqzw=
	=
X-Received: by 2002:a17:902:d48f:b0:216:6be9:fd57 with SMTP id d9443c01a7336-21dd7d78943mr128304195ad.21.1738279783894;
        Thu, 30 Jan 2025 15:29:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFakuHqBiun6rQh7UKOFU1AcEATPAo4CvsaEViXwktWRFUvJgFZX9Y5IQeesn4fbUvLNxsxw==
X-Received: by 2002:a17:902:d48f:b0:216:6be9:fd57 with SMTP id d9443c01a7336-21dd7d78943mr128303935ad.21.1738279783508;
        Thu, 30 Jan 2025 15:29:43 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3308e32sm19268995ad.207.2025.01.30.15.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 15:29:43 -0800 (PST)
Message-ID: <90c00af8-b6bf-40a2-8f6c-89b5666095bd@oss.qualcomm.com>
Date: Thu, 30 Jan 2025 15:29:42 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix wrong overriding for VHT Beamformee STS
 Capability
To: "Yu Zhang(Yuriy)" <quic_yuzha@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250124075953.2282354-1-quic_yuzha@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250124075953.2282354-1-quic_yuzha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: au1_Eav_zjUaQULCLTl6no4FlDhpoeOl
X-Proofpoint-ORIG-GUID: au1_Eav_zjUaQULCLTl6no4FlDhpoeOl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_10,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 mlxlogscore=772 impostorscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501300182

On 1/23/2025 11:59 PM, Yu Zhang(Yuriy) wrote:
> Current code in ath11k_mac_set_txbf_conf overrides nsts, which is
> incorrect as it confuses nss and nsts. nss is Number of Spatial
> Streams，nsts is Number of Space-Time Streams.
> 
> As mentioned in Fixes: 55b5ee3357d7, the nss used when acting as a
> beamformee in VHT mode should be reported by the firmware and should not
> be greater than the number of receiving antennas - 1. The num_rx_chains
> related nss rather than nsts.
> 
> If STBC is enabled, nsts is greater than nss. About nss are mapped to
> nsts, refer to IEEE Std 802.11-2020: 19.3.11.9.2 Space-time block coding
> (STBC), Table 19-18—Constellation mapper output to spatial mapper input
> for STBC.
> 
> Remove wrong overriding for nsts of VHT Beamformee STS Capability,
> acting DL MU-MIMO in VHT mode is working properly.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04479-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Fixes: 55b5ee3357d7 ("wifi: ath11k: fix number of VHT beamformee spatial streams")
> Signed-off-by: Yu Zhang(Yuriy) <quic_yuzha@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/mac.c | 5 -----

* drivers/net/wireless/ath/ath11k/mac.c copyright missing 2025

I'll fix this in the pending branch if there are no other issues


