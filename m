Return-Path: <linux-wireless+bounces-17449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE04A0C4D0
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 23:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8049164E94
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 22:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8A41F9A9F;
	Mon, 13 Jan 2025 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QpY1mpFL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64951D0E28
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736807860; cv=none; b=IXOgdv8GnBgsy784KyZrJr3NPz+a5kXMJEk4HkKMfuuyUKoW/WaSpzdhdEPKu8iQ+uPZRee+YJdOW3K9TKloAZuWhTPjV7jDOPjWXUw3/3WqEzKMXBjrUqnSpSfBqSKwM4YW6c5cQ4OHCFfeluEQAiuQ3AfOGkcvReJHq0cLz9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736807860; c=relaxed/simple;
	bh=vo5kD/3TtWWMtQ9UxhjPa1OZpHn6ZT9NUt+k2msEz7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pixoTmTKFKC1C0/NEfPvGRF1E+C9H44vjS64+jkXWxoeSm5ig+YMa/IiMkzNggtdELLd+lkbKCaDpMFdEphAUUyVwlShphdgeE8O0fZ7MkQu8Gz+mmmwmOxHzSlGhvMVA9to1cVv40BVKeb+lF1d4cQrYRGomHuJwbORzq+kB6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QpY1mpFL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DKYfR9024132
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 22:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cVfW5l6eIEIR+q6qj/PoX42WlbginBeQXhVPPpkf0BE=; b=QpY1mpFLF0Tq9+lV
	PX9YEixhiyou3xrMJC2S8MXnpRB6t240NFZAjlXFueeFG1ntR1kM7RQikXMgCWZL
	RN7Rw9+ZxPoLjIDfR4EvYeIW9wgveW2t44EbnLs9q6TiN3m5jn8Jchy7nXqKv0oc
	frN5TeSIlqyPmFOzWZizG0OeZ1zmVZHSH5qjq5pXW3kGiZJqjF17md/pcahQzR33
	GJjeZ+HtGcYGOxjeLSWna1oPnS/io3Xe69cKGOAdnEX3CLEdWgHDzPBoJsJceqiV
	xg9moS2IUopyOI/nw00b1ptY6zCFy8Wd8Ykb2vz9cUvMfMaEZ3FkjiUfHh3utQPI
	4MnjSQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445a06g79r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 22:37:37 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef9da03117so12545698a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 14:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736807856; x=1737412656;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVfW5l6eIEIR+q6qj/PoX42WlbginBeQXhVPPpkf0BE=;
        b=gG54OyWiZuPy0bdXkptVGGZt64NgwgUZ0IjJV8NDYUdWo/c2OQ6PLJmxjinzAWfcrB
         kC3f6IaBdDXmBdLw0kanq0Quw2UHcaKhMP8a92UKzxVykIzds8zDXks0zkN+hxWg90Sf
         vJCuxeA2x392KX30uXLw2PW6s9bHFXJmomjy97UxBV7a41WAmD4bK2QljS8kJhIMh2SY
         Z4IWcUO59AHoGeFX/HVtUbRzdgG+r6rse2qO8cvkq+kPH871aMYMiWU1bolxZR1v3+8l
         87TuV/3e+sIj9SU03behqkvxn0HpXM2ZfzCASnVdiT74p5oRgI4Rt8dsZDroUeDvr/1J
         utkg==
X-Gm-Message-State: AOJu0YzHh5zNFZentd6ejl04C2RlvCsbNNiOaMGswuAURmQKcnmozrJO
	Bh7IrIsckqrJhU24+LmkCws+ii5i9BA/uuLj7VeRTgAxTGWRMasRlBUMat0WkXGT7ap0qvWM27n
	+n+RT1xWyEahqedpYqdVHZq/KBQfj+/VGjCG2zONyQVPo0OUPaZ3UadB1c/ZKpRKTww==
X-Gm-Gg: ASbGncsJ5YmYvW+b5rj+jtNWHuYKCmHdUoOucUmfjruq8UmSNtN6+sS6wpthP4gb+zV
	v0uTnl+ZXx1omqEwPCQ8Ult/KxGiZtJFGbC/kXKxX2ZlNFjRkYlWay5ifRGD1USmb/oYUkRPiuW
	sAxrs/FaG/vdJ579nYDIARlESNN3AR9FB/nAc3ICqy8rFBY90A86zthSrNx0ovVcexXEcjn49m2
	kTLPA7F7dbZ52zDOtv9Q7amTznusuBBEiQRReTtVbPuVSWTVfluNL6T3F2Hb9UjYB1CK6H/5Ntb
	moEn5JbQMFgGAPsPn85Mpmr9cLfvyywJAgTmkT8zcthvmGMM2w==
X-Received: by 2002:a17:90a:c2c8:b0:2ee:70cb:a500 with SMTP id 98e67ed59e1d1-2f548e9a4c9mr29194578a91.1.1736807856310;
        Mon, 13 Jan 2025 14:37:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqAOpkaJHOGMK7Kxzat6ZhU8cB+zRyhJB14tfQHECRCtWKIGg2E9cdpicxH8fVAYXwhfbDKA==
X-Received: by 2002:a17:90a:c2c8:b0:2ee:70cb:a500 with SMTP id 98e67ed59e1d1-2f548e9a4c9mr29194550a91.1.1736807855929;
        Mon, 13 Jan 2025 14:37:35 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f25c927sm58256305ad.228.2025.01.13.14.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 14:37:35 -0800 (PST)
Message-ID: <dbccf6de-55b5-49e5-abd8-a507206b6668@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 14:37:34 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: handle
 ath12k_mac_ieee80211_sta_bw_to_wmi() for link sta
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250110-fix_link_sta_bandwidth_update-v1-0-61b6f3ef2ea3@quicinc.com>
 <20250110-fix_link_sta_bandwidth_update-v1-2-61b6f3ef2ea3@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250110-fix_link_sta_bandwidth_update-v1-2-61b6f3ef2ea3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UahTgPYOD7ReKclHV6ji1LXB5MznwM5Z
X-Proofpoint-ORIG-GUID: UahTgPYOD7ReKclHV6ji1LXB5MznwM5Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=990
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501130178

On 1/9/2025 10:43 AM, Aditya Kumar Singh wrote:
> Currently ath12k_mac_ieee80211_sta_bw_to_wmi() handles the bandwidth from
> sta's deflink member. This works only for non-ML station. Now that MLO
> support is there, extend this function to use link sta instead of deflink.
> 
> Additionally, in ath12k_mac_handle_link_sta_state(), the link sta structure
> is not accessible, making it difficult to fetch the bandwidth there.
> However, ath12k_mac_station_assoc() does reference the link sta structure.
> Therefore, move the initial assignment of the arsta bandwidth member to
> ath12k_mac_station_assoc().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


