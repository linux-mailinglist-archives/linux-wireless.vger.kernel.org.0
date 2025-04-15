Return-Path: <linux-wireless+bounces-21559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE96A8A5DD
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 19:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CA744373A
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 17:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F9C21E0BD;
	Tue, 15 Apr 2025 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pq4YL8EA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493A12192E3
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738934; cv=none; b=RraIEWEMhzcJAB9Jjl15K04hR08Or4HHxEM7AdzLS2OsDFVwRip67TQ3REe3K9daR15PY8vvNZ3YzFpbWnIRSVzHZzCfME5H/s7Qo7Dx0+3dI+ZJsbTiCR38QzIV+NTaTayglqy0UzxtvNiXgb0qK+jpO5DSx2Iw82g882ND9/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738934; c=relaxed/simple;
	bh=baUxTknSi+OT+xyxY4Iz1IFgEtLJEaH0TXENzKMge1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHK04/zvr+ldwua9ADaHpMOMd15QuvdpmKYx9tvefPv7t+Bce95ScE+1nQcSLcoc7hhGNzZ+DHLxznosu642JUYFoJYLGWORwBGkecqaqytA+b0FXIp4Dl5Q5tSGRAp6ZhAmQLGGyvfwk2ZkcSh/w1TCVopAiR5fMmvZ+jMHJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pq4YL8EA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tI3r024998
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 17:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+l2W10y/QDYItzPC6zPbHSlvs3nstb66aVexkh8d8Vs=; b=Pq4YL8EALfw2uEzt
	wQAQe8an5esLGDdKqSLTxs2xVTmOL0VJ0cRtLDGAm5nNQk1g+zHjF96f4jOBZmJu
	nTbTwRIfMst1yz8AC+6a3I7xmEt9ivvW6f+WHUUWfo17yYsbr6bJo9Qbsd1TadU3
	qzpqB1GL/i7lTMn+xq5+SPIaj3RqZgOs0peXiHj43W0Yv8Via14igsEfLmXnsvis
	vCyLXD+fsnSeD9X5vqc9br38I0/cBONKO9SjUoyQNn8HutozzuNrpIKUdssPWaUP
	BD3cclKC2I9jVVloV+HsAzDdNdh/mgFQjkRSfOtbNM6tFl4pWbLGDmrviojF2OiS
	pLITFQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf69s0cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 17:42:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so5694385a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 10:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744738929; x=1745343729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+l2W10y/QDYItzPC6zPbHSlvs3nstb66aVexkh8d8Vs=;
        b=mHIG5QBU9fuSERGvSnForng/q3Dg5iakD4ZIfW+IFFLyr0laQUFwXVdzf9kyL4Ywtt
         nC6ALCQJlOhtypdzfMwOXA2RiYQnqHNpXW4WVAxAnGvc7859DxKR45rvJe1pceC0OoVN
         l2QG4hmWLSLoR5E349vN6EX4VjPKVe5/80T03hya11OUMav6RH4eUtLAvjKQau2WTcUe
         fbqUw0Wa9GIWV5WMLqZte34JXXLJqMfC1NG4AcTlX6EjajwOY7F8kQTkFMw9FOblrGiJ
         QOZhiRWFF+R8g5jiJQz+3B7UBLWplOKvxmASL1fGc7/4nu45ysxTavi+IkAH+AlgBI5C
         fW8A==
X-Forwarded-Encrypted: i=1; AJvYcCU4EAEvohXa9wAcOnK4pl1oTBnF9Q3UMzYuiVQ8u4zhWUDlBtf0NReu7alv8viLEajMxwvjYvOCJvx1ICvhUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+F//r8IOGhQDueOwWDvyLdsqMnZTWla8dgOP05462qm8Oj0pr
	HgrQhbr9zNsyNiEqZxUVc1gweUwbQ8fhtmh4p3ZvGRQKh0Gy60E+2OjCOUUH/g/ymqqufkVhTkS
	EtCNBWExi4MWNDuERxP2uKnzY9jCY4US/g0h8bLXMjG91B/KoKInE8DeJ124TjzZjHw==
X-Gm-Gg: ASbGncsO95SxKsALlBB97qsn6D6YX4VpGViVi1LNRNf1OBrQAzq1U2HzuPcSmjlGsm2
	xPDBNJUiaT9Xf94A2yUlfth9LBEE+iQTD7LgO6sUjuIv6HxSTyO0fbiZJX65A3TGHe9SEZGZd7s
	rMbOQaGHYLWPLpFK46hyfTHD1fE1Zbqr/fPCK+JnkdXWkbTkZ3PBs5tYfxlA7dBf6Se6SBWCuFs
	ArzPLenSiH8Li7f373Un6E3AzryQLifC+rg1PYZ/d7vCb0xKI3+rJglYAqvxwglJCdWbo6ruGjW
	aaD6NUy9gt6ElXCWVtkcvSEWAdnHUxWuxmtBTLwa2Gb00CdKvztk8WkD13oY+axYzuY=
X-Received: by 2002:a17:90b:5188:b0:2fe:80cb:ac05 with SMTP id 98e67ed59e1d1-3085ef076a0mr38630a91.9.1744738929386;
        Tue, 15 Apr 2025 10:42:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxjbyZltG3a17wFXsez/DYC3bIiRyst3wDQCr7ODZkdqhmIHOOPryE5s12rmU9eaY92ehfZQ==
X-Received: by 2002:a17:90b:5188:b0:2fe:80cb:ac05 with SMTP id 98e67ed59e1d1-3085ef076a0mr38588a91.9.1744738929015;
        Tue, 15 Apr 2025 10:42:09 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df08f826sm13443504a91.29.2025.04.15.10.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 10:42:08 -0700 (PDT)
Message-ID: <d25ca9c0-64cf-4edd-97f7-d82a71e32eb0@oss.qualcomm.com>
Date: Tue, 15 Apr 2025 10:42:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 0/2] wifi: ath12k: handle scan vdev
 consistently
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
References: <20250411-fix_scan_vdev_handling-v2-0-b6740896c144@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20250411-fix_scan_vdev_handling-v2-0-b6740896c144@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pHYmWrUY5ORVSzM3d5cbNnW_BMxPsDqm
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=67fe9a72 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=tjBKq9sULpQLctw1ybUA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: pHYmWrUY5ORVSzM3d5cbNnW_BMxPsDqm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150124

On 4/10/2025 8:16 PM, Aditya Kumar Singh wrote:
> This series of patches addresses the handling of scan links in the ath12k
> driver to improve consistency and functionality. The changes ensure that
> link ID 15 is correctly used for scan operations across both ML and non-ML
> interfaces. Additionally, the patches prevent scan failures by fetching
> link_conf only when the link ID is valid and setting appropriate default
> values for scan vdevs.
> 
> Currently, no issues have been observed; these changes are intended as a
> cleanup and to ensure proper handling. For split-mac these changes are
> pre-req change.
> 
> ---
> Changes in v2:
> - CCed linux-wireless list as well.
> - No other changes.
> 
> ---
> Aditya Kumar Singh (2):
>       wifi: ath12k: handle scan link during vdev create
>       wifi: ath12k: Use scan link ID 15 for all scan operations
> 
>  drivers/net/wireless/ath/ath12k/mac.c | 55 ++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 30 deletions(-)
> ---
> base-commit: 1a7000fb8348e04ab486513d6ebd4b6074a94be2
> change-id: 20250402-fix_scan_vdev_handling-ef5be452b949
> 

This now needs to be rebased...

Applying: wifi: ath12k: handle scan link during vdev create
Applying: wifi: ath12k: Use scan link ID 15 for all scan operations
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/mac.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/mac.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/mac.c
Recorded preimage for 'drivers/net/wireless/ath/ath12k/mac.c'
error: Failed to merge in the changes.
Patch failed at 0002 wifi: ath12k: Use scan link ID 15 for all scan operations


