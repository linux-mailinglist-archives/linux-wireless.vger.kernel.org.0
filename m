Return-Path: <linux-wireless+bounces-18394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DE7A26CB7
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 08:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38F73A1562
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 07:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4AB204C1D;
	Tue,  4 Feb 2025 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HENYCoN9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4767207A33
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738654611; cv=none; b=k/IdK/4N1vWiA0odFDe/tMN6uTXk0kg5pJ3+BCU3HdhL8ykTxOLhFMJR2T0V2AarFXdAywa1L2VyFq199+uh/UHnXvHzQX/PRbhX7yWTmsJIprwZTHB+t4umPMmr5Amf0CKfpzHTU86Qih8+/0uxP6ed+1HSG5J2bdtBwmwy568=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738654611; c=relaxed/simple;
	bh=4HmXnr3hLreo0CVBDNLXxhlbNI2Sa6ZqNHXn+D4bMyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrMN0OjeodAWmpEe490sg93TkqzQzvG9skEv1gyeAISUPIxNEV7ZI+U6W2dM7bh0ZNC5Hc3dqHwgwHME5vYbWdCATczBCj5yWgAK9PuKXoXEGn6VM4qNOSnhG/gijj0TifqE4Qghah7CyA/O7UcoNXbg8wz+i0D6VTTwhHQM/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HENYCoN9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5145flJd012753
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 07:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pbAWOdRveCbpzhH2pzN+O2kbwmqTXxZLpGezB7431Tg=; b=HENYCoN9VdwMXpqE
	LryL3nxGibOOFH4dHNkY7licAGv2YJWVDkumMahIr8EmnAX8PHvP2wA+1ElPeIPx
	jMFGh/B1jMZ5cxnv5zVwes3y4z38FJDuesj6yqLK3C5X8RHtaPJpeK1P7pO/1FxT
	lGmV6ppvCwnzoIBF/7yaM8nh4/84xazrz4A75W2SWe1JIuTELo0JnluXkSjGbSF5
	HI7pprvVrEzwp3GMQAg8Y8sH3OKkZGeDVMr+ReeznOwrHjudm+8Bbfl+YFw2b+hm
	FGNkUhF8XDu1n3+eAB/TBAVCI8xAOrYGSm/596K4tCgxnM2I6R2d1RandKxNIXg4
	ys/f9w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kcxm87b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 07:36:48 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef775ec883so9981127a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 23:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738654607; x=1739259407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbAWOdRveCbpzhH2pzN+O2kbwmqTXxZLpGezB7431Tg=;
        b=q6++3XKec6LnReslYDERDgQThOIj9NLDJmWRrKd4Y32Xopce7CPf8Kenne9TWKaHEK
         0PqunaY73tyYP2V7peRMfrDIEcNFVeg/33K0bS6Ap0oXzvL4uPbCCCCb8FTSz05S2fCU
         0PojIz+bgYShaFdwlprAiXo36wKA1IvKqTC+VEt2qiz6bS+JmvGQz67HX8RqQkmfm78b
         OA6q7RFQnfIRleAXw3gqNe4+Nr5Dq448gZ73+1lMmNwfZrVXqGNikmOnaeD/NPaa6Ed1
         387+n5Qe4I/Xoy5zSotjJ/64/rGIB/DPp8NzLC4EnJkOe0Hcs+Me37DZS9JKzkl89Ls3
         oy+Q==
X-Gm-Message-State: AOJu0Yzg0SPaN5q1USMF4N6wsItxR2F4fOwuPOiApgbaq1BjNI76Ma82
	dNGUWYOGUh5j+p96gcmWtCC3M1n0nUhtXeKIIGLHGOea98T1ZHYyE+4wT0O6E7K6PDcQK8tEQ5h
	Xh0ChmS0DZvqKJBT8t7Qp0AeevmbHKS8mcf9P/bY4Gz6E2y9BubKS1rvHUbwA7Ni0DQ==
X-Gm-Gg: ASbGncvtLmxE5qq51bFthhKsbtbnMaWLI8/nRTli0VUBVuaYsT0UEwOeJv3xrK/ndPA
	U+lPJscYmWy3FldPG7R2JI5kUiMF7EYZoe/bEjYyiP6ot0YFAUjg9w8eXpyuwpeSWspYgo+nc1N
	tOpYX/QbPx0YNfbf7zsd27/YNOfmTMk4eKkwXYDl339CFbScnGvmDocegvGkZN9XEjayEk/O0rN
	XB8Ce3dSpRCvzCF2gCIv8jnR0nnknAKE304vgHx9iaRIFtIb3iVV+5CoQP/adXoFvtb1xU00iP1
	zf5VcCNwxMIziunj5So2cQJguRKuNQX+1QuTd7cB9m3e1XM=
X-Received: by 2002:a17:90a:dfc7:b0:2ee:c6c8:d89f with SMTP id 98e67ed59e1d1-2f83abf3750mr41483081a91.14.1738654607378;
        Mon, 03 Feb 2025 23:36:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7Xutuk35lQ6hPLOJ5yqhph9zSp2c530B4uK44ZIzrRai7sqcKP/ZFgEZJfc3lJU+RJtITsw==
X-Received: by 2002:a17:90a:dfc7:b0:2ee:c6c8:d89f with SMTP id 98e67ed59e1d1-2f83abf3750mr41483035a91.14.1738654606986;
        Mon, 03 Feb 2025 23:36:46 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bccd590sm12752169a91.12.2025.02.03.23.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 23:36:46 -0800 (PST)
Message-ID: <c2169141-2449-16fb-55be-8145854ebf78@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 13:06:43 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 7/8] wifi: ath12k: allocate new links in
 change_vif_links()
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
 <20250204-unlink_link_arvif_from_chanctx-v1-7-675bd4cea339@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v1-7-675bd4cea339@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: S2Z5v1v3wWDXYbi2oLBgaeShk4yZaDpE
X-Proofpoint-ORIG-GUID: S2Z5v1v3wWDXYbi2oLBgaeShk4yZaDpE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040060



On 2/4/2025 9:53 AM, Aditya Kumar Singh wrote:
> Currently, links in an interface are allocated during channel assignment
> via assign_vif_chanctx(). Conversely, links are deleted during channel
> unassignment via unassign_vif_chanctx(). However, deleting links during
> channel unassignment does not comply with mac80211 link handling.
> Therefore, this process should be managed within change_vif_links(). To
> maintain symmetry, link addition should also be handled in
> change_vif_links().
> 
> Hence, add changes to allocate link arvif in change_vif_links(). Creating
> the link interface on firmware will still be done during channel
> assignment.
> 
> And since link will be created but channel might not be assigned, there is
> a need now to test is_created flag in ath12k_mac_mlo_get_vdev_args() before
> accessing link_conf or else link bring up will fail.
> 
> A subsequent change will handle link removal part.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

