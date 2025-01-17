Return-Path: <linux-wireless+bounces-17618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64910A148FF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 05:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB143A8A1E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 04:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3D61F63D7;
	Fri, 17 Jan 2025 04:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hrDj/UsN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F4425A638
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 04:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737089810; cv=none; b=XknCbQeajRqXzZCoAARZCI6CMUwxkNuEQg5i48cpOuyV3lk53TUDwJn6mUmA6N3a4CfmWJg4ztAhu8IiiVAp3X4PGnX0YvLszuRAZbIiUVi/9S3+Ke035Cri0j1I7VnZ9Bq3L8YTSAjrbhDv6dN5FpSJqV+A6f2L6NV3BJxJyTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737089810; c=relaxed/simple;
	bh=xb8Fd2a3dl2ASmgXhpwrPlvpVHigZOGL/eDGgYYEw80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFN6LxGO6KYuDoMD9itlLfz9L2ZD7oFiXJoy8xZv0iT4VDIK9FqKHOcCRPjzxEVxU8x5HlCnGrRrIwwmeXqEAR3y3F+8U06xU9Nb6XjMiBxM1kxOmmk0+bFMim0BqrypgsWtFMyPUQ4kGU1Q6Ce2dUv9InPpVJJBfG5HkNLL1dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hrDj/UsN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H4sqWH022912
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 04:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sxaRXxeIHO8SkgGsDXsoKBu29tdLwj0/TNSSZgBk8ww=; b=hrDj/UsNHogRKdz8
	xBq0ra9g2zjTeW2Jx5mXCjuIRsuHFGoz8SWfRSr/6HEWAyFLeOP/QfFgJp5ucxAK
	Trhxh5ab7lglCBqT4NC4sl0W++ESeAX+d3Y+6wp+9nqN98ZwteOCHl8UBe1aVHyT
	H/OJ3DwZum3PYMy68eD8Pg5FX7uz9Z24hYoaXbQ+TDItCaPUGGRxrzvt8mlShOfh
	IQC07oFSmRlNs3bgiyyycDwt0SIzGmKYImlz09KUqZQZQydJXNH9/3zAgcVhFyq9
	RpbF/YyR/NK6nugFqrGDbwk5D926NskJzfPaBy54yiM1l8gxEWjZUszOjek7hO1X
	zhGFBA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447gkfr046-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 04:56:48 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-216387ddda8so36614045ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 20:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737089807; x=1737694607;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxaRXxeIHO8SkgGsDXsoKBu29tdLwj0/TNSSZgBk8ww=;
        b=amWEcDpUe3NmPEBLr/8sN89SmaMsnMfJuR4lm06LV0ZNdFsiBi+QUMBDkeIj4TOnB2
         Q6VWsUmiEOoOhbb3quh06GTOqZwS+PNZBi/unO9ik8kD5GEzmqtgxCUR+mkBMygW9i4v
         gcVfYNx5+Ir4RzIExLLppG569vq1BgUzsTE4B45AzwZfZlkFE5vmIOP4GtbjRSN5QIx6
         0B2y8lZ01ZDvWQppI629jEeHMTd9PVGzwywrMyrtmQGtPzu/cj1rUToOsjhdmQPJFTu6
         Hn4Fr1zIppgHp1Fmcd59slyKp7jqMORq4oakFumvvzJllmlh99WkNEIQBY4BXZY85TPq
         qokg==
X-Gm-Message-State: AOJu0YxUHsDu2rdSPD7TOwTXQb1xEMcUG/aYz/2+OhCreoU3CTeZkfSV
	Xy/1GVXLR733I1BlJkl+VPPil8niyFZX8zrtUmqlBHF6Ggh/NZ1HSdHsjOEPZcbaBMLJrFn9aYu
	W4iUycyHXheXSbQik9+34gBpvHyfFQ8uInw++4on/K+Tj/u+lrgxTVhdUvR+HwOgH7Q==
X-Gm-Gg: ASbGncvTeMFUVvA1MEWWy3DWTlY3MEaXvdDH08h004JHn9gsRW4ttIv/lKgp5FB/67v
	He6zNjtJ+f/N/EbStgSXdHc81F+8OwRtMqI1SlKC14+8Up14mOnY25zponz5M7z0fCLllkvD4Yr
	7kRWAS4sWDPYhIutspm6izVZqCDGc3W0KlDi7IuMItKIiTj2VFz8UUvupA+t5P2aPRbMRJUS1C9
	apvsK4DI2wL9M/YhxpxrBuPVSlAkw1e+78EDXHsC3h63YPv5/kqNrRlRUshN6qo5JyjIC28zS3g
	WsZFfXuxcMi+c7CsZGjIF30pRvvnCiCmBvg+rLs0Cpm9z1opIg==
X-Received: by 2002:a05:6a00:4c0a:b0:725:e015:9082 with SMTP id d2e1a72fcca58-72daf92bee2mr2102360b3a.5.1737089807146;
        Thu, 16 Jan 2025 20:56:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHL4kEFQFsXoCftFrcEX8DW+BrJxNJl0VNZVaUvekaRED7s38qRRoXCaA6YqJurwEhACtlKug==
X-Received: by 2002:a05:6a00:4c0a:b0:725:e015:9082 with SMTP id d2e1a72fcca58-72daf92bee2mr2102332b3a.5.1737089806621;
        Thu, 16 Jan 2025 20:56:46 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabac5a46sm891484b3a.177.2025.01.16.20.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 20:56:45 -0800 (PST)
Message-ID: <7e4d32e8-c623-4954-bad7-c1671413828f@oss.qualcomm.com>
Date: Thu, 16 Jan 2025 20:56:44 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] wifi: mac80211: Add support for management frames
 stats
To: Muna Sinada <quic_msinada@quicinc.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
References: <20241220231611.1870613-1-quic_msinada@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241220231611.1870613-1-quic_msinada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oWs00Uck5P62CfcQDLmpY4cdSyls9TLL
X-Proofpoint-ORIG-GUID: oWs00Uck5P62CfcQDLmpY4cdSyls9TLL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_01,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170035

On 12/20/2024 3:16 PM, Muna Sinada wrote:
> From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> 
> Currently there aren't statistics in mac80211 that keep track of the
> management frames that are processed in both Tx and Rx. This type of
> statistics is useful in tracking if management frames are successfully
> transmitted or are dropped. These statistics are also needed to
> provide information regarding how many management frames are received.
> 
> Add support to track number of management frames that are processed
> in mac80211 driver and maintain counters for management Tx completion
> status. These statistics are to be included as part of "Extra
> statistics for TX/RX debugging". In order to enable them,
> CONFIG_MAC80211_DEBUG_COUNTERS needs to be enabled in kernel
> configuration.
> 
> This stat is a per phy device stat. It can be dumped using the below
> command:
> 
> cat /sys/kernel/debug/ieee80211/phyX/statistics/mgmt_frame
> 
> When executing this command, dump management stats for all the virtual
> interfaces of that particular phy device.

Just pinging the community to see if there are any comments on this RFC.
Should we post a [PATCH]?

/jeff

