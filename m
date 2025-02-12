Return-Path: <linux-wireless+bounces-18801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EEDA31D3D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 05:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E85B3A3D63
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 04:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5D42AD13;
	Wed, 12 Feb 2025 04:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iax63rTW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3323D271835
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 04:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739333227; cv=none; b=bwiEi2o+O0Hlr8VGLPoARRo/G969NpKilUVBekz0UvFRUVuL2hwgO/LKwdPnk7SQOdNIr6jXhFNHEVx4m6dJubMCU1KB/0xIk/0kMAQQq+u3kf0BVJz04o31XnNrsGwJM9TVdW1v/hfRHNzTC/V0iLWAXFKGGSDxkWNy9s9gX1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739333227; c=relaxed/simple;
	bh=y4ESE/Hcd+TuwI9/F6UTt78HbqRjs2UH6XqjoIJAcj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQfwKx0ulyu/RSxGAwVJNaWvCvuafzC9Y1LguOQF9gR/1VnOLhHLnIFZI7GbGvyZQAVVGwI5VUI/ah7tBwbK053vv6cOO57uOPCNAhXyoWhGIYZceL287fxyXUceugbnmnjWZIvSG3rLzkAKvrevQTD9s2X4Qxb2K/O8CKWnvFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iax63rTW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C0a7EU011665
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 04:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NuHUbmMvZ1JOoqy63EABj8zAskjeEZWCiTW+fw42xDg=; b=Iax63rTWU3D1u7qS
	KCw6kR5qAvoGcNTM9Hj/P+Sf+GH67nGno77Ucuso5ZqOiWBN2BT5WykQO4uTgdcs
	DWaP5/E90VmaSAAA9fP4uNdJx2/MoEJ6ICf+Tluu8AUlEND+vjcN5rQyrrqEUVq1
	Gyonv/SChB7GHxMdSQNpLUwjgq5MH3e6A+ho0cKxEtzRHEr3viSograz56cwr2xs
	Sra/2j7Dp/to7WGGJc7ueFfkO82xKLnEGAGNwbT2yoKZlb85b5cMbywEMjeu11hH
	TGB/Wd2bNq8cLkVlDscwt9MMplihjJ40Vpt2a0r4MZYwrRkb/dfgGuLKnSbsoO35
	bHo4SA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qxv3uj9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 04:07:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f46b7851fcso19006758a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 20:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739333224; x=1739938024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuHUbmMvZ1JOoqy63EABj8zAskjeEZWCiTW+fw42xDg=;
        b=I4+bRsRLDcFLSARcG4r9z62X/fxAVyMT2mSOUov/rJH1MJDcMoPXm7gSxiedbZTBOx
         wcqRZW3hrNJqCT/1Spg6a2Vwli1U5nxcKiM/FBbjRkzB93uoKM2cS5oML+Haqz8Ybobv
         pNtdWNtcYGuYOROjvzQwu7N5AMueUj1LOrQcHLLKvcVjpIo/gf2Ww+4h2/pbxhXW4OLJ
         Z4l0n6OcNqYPXfuHe2C6oWg5R3ao/Ulqme6TluVZti8eJHjuEVvn+OoQHmUpgcsx1Tfn
         yAeHphkAiIWAqu/sqnq61X98R5jyMwi4dAtKeWOTRdPrNxvXBM/OAmRaUO4Fxhw1F5He
         3sbQ==
X-Gm-Message-State: AOJu0YyC8z1Dza1bJIwOpJRhon9RGlCtIqAyQrMp2kF+5DWTW0XKm1UL
	OPxuMBxqrGOULyB9Dek3/1u4pSKT1plzm7jq5+DN5CYj8wNiJKApBilQTgeW4c8p+w0JrJt32us
	Sz02aBvMK2VD4bsxKKXSfLnWTHdjFwM5oIg4Wnnvw7cZpq0diHLi/8Vi5XVytrAjkY1tNrrx0xQ
	==
X-Gm-Gg: ASbGnctN2tQwa1x2ZXTsCP3JeoVGhP3RbJDkmhaaQcUWPfv+hGrJ2khPwAIJ00bXx2A
	k1jo/KnYpj9CtDElM5yw28mQ0ifb6IDfrsXn7ZHtwDgQ7ER/U9Z5sb+NaAkkrK+betXYRnzzu6c
	ortLxYO8RgR9W19EBXSOkWRGMKS87HURIN65i4DIlON91MyO5N8iYQf0ZQBRSMzCTmTxX3HNJ1y
	0M9wn4fe+98CowoqEWVCmisfl6XAXvETa2Dei4ya3b8cLze+A9+jZJLyBITGhyGJMvTUzA8a7l5
	owlPN9X0yMbXnUlYY05TKlnBkzhweGic3XeoRQOY9xQI6uI=
X-Received: by 2002:a05:6a20:258e:b0:1e0:d6ef:521a with SMTP id adf61e73a8af0-1ee5c732f01mr3192661637.1.1739333223982;
        Tue, 11 Feb 2025 20:07:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQBsz0NP1gFlIyij83Vi2OQvRjDyJYV0mhsemGVq9Z5Jf7wCrtMmGzbP0x4XLuCjCYV9hh6A==
X-Received: by 2002:a05:6a20:258e:b0:1e0:d6ef:521a with SMTP id adf61e73a8af0-1ee5c732f01mr3192628637.1.1739333223576;
        Tue, 11 Feb 2025 20:07:03 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad5434dc097sm6497494a12.7.2025.02.11.20.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 20:07:03 -0800 (PST)
Message-ID: <48cea2db-c6a7-63f1-5e3c-1db77a6fb84e@oss.qualcomm.com>
Date: Wed, 12 Feb 2025 09:37:00 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath12k: fbx: Add missing htt_metadata flag in
 ath12k_dp_tx()
Content-Language: en-US
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250124113331.93476-1-nico.escande@gmail.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250124113331.93476-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DBmfOYbJ7ZYiDxsNdtwQIZB9lxOo1FQb
X-Proofpoint-ORIG-GUID: DBmfOYbJ7ZYiDxsNdtwQIZB9lxOo1FQb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=777
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502120029



On 1/24/2025 5:03 PM, Nicolas Escande wrote:
> When AP-VLAN was added, we did not add HTT_TCL_META_DATA_VALID_HTT flag to
> the tx_info's meta_data_flags . Without this flag the firmware seems to
> reject all the broadcast (ap-vlan) frames. So lets add it same as ath11k
> did it in commit 5e8a373c8699 ("ath11k: Add support for dynamic vlan")
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 26dd8ccdba4d ("wifi: ath12k: dynamic VLAN support")
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>

Thanks for the this. Can you pls resend the patch without fbx in the
patch title? The rest looks good.

Vasanth

