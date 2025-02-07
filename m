Return-Path: <linux-wireless+bounces-18640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C82E6A2C9EE
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 18:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF23F18836F2
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 17:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C229E156F3A;
	Fri,  7 Feb 2025 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p0i1NofZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ABE33EC
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948574; cv=none; b=nvbySvP6zor5gr6JyrFQD7FIoNZ7Ok4crRqwt3jnTVCxSQFOcDnCXzKikeCcvWqWSEtE1MhEjuk3U6H6tBKx3yMwba5XjILFGzsSLwGou+jk4ZiGrCLS/vj35SsvDFqCAUEaENXTtHbUwyqa9gjm4pPsDyRXt8tVGlhyDyjhBxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948574; c=relaxed/simple;
	bh=vTY+lwuSHqD+h/l1dFSfkLwQEQu314mk0y0a6xYJ7K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hd0AjYAmXWWZ2RnUqqhpk66R0iDWOZ89B+5HJTRsTdirtJGAsrG7tmr2ewGvQBxzRcs+rRJO63x0Hq6gkXP1bwltwoInIv2JSlEzys82iJZH9kmvxnPtlWGVqAxRZ33shG0l4auxEt0vzoHAT9kruXSGymi66Hl7JX3hM0ldmd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p0i1NofZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517BNZrP032188
	for <linux-wireless@vger.kernel.org>; Fri, 7 Feb 2025 17:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ESceAsTExudZ77XUfniEGvmGfJT6Utl2V5clq/2RCOg=; b=p0i1NofZ2EawwZ1S
	VuacnV3/e6o1ztoXUHmrkLOUe8Q5RwzXSH70Y58tNs3g2QC3k98exPi48vWlehzb
	Uwmc23+G49QrrTwRunXQvdnEel5zxTRYmWa6S0rMG68xwEYGYpJ21SX6Issr5Chw
	VjLS03hdIKulezQt2rhJ5ICzdYAQ8AB7UcF4vTWG5O8Kiz1y9+GpFhIWc3gBEDfJ
	Y9jsAYWZEDamEsLqXeO0vEmhCLlk8tG3B1t1cmSUxJ88pgjQK1hptxhjn9H1yGTQ
	thGNMSKcSwNQ0jLGNEDVt4zJ59YiI8NJFS0c7tpK5YTL1qF6U313Sad93WAJp5zd
	OW96ag==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44nh8urv63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2025 17:16:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fa166cf656so3501550a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2025 09:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738948571; x=1739553371;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESceAsTExudZ77XUfniEGvmGfJT6Utl2V5clq/2RCOg=;
        b=oCoJYqQ0j4Rpq/eHybbEmip9mdLBzpnQBdDOT5KilucMEROjjglOt045fEjTWR6P4n
         H/g4HyY7Wxxv2lucpbUdyr2wBIdO12IshVIpjDuNCErHztrKh8H+6+J/GQGi2G0yJvYf
         CutkbDAGGjIL/GSXg5MWgSdOUcMXM+6pE9HFHYLM0BddMNPrYLnxwWHG0sVaQZNB10rm
         ClqN0NnwANdaWQG5rg/jEp6O37PAJLnPxoygnTO+mzS4nK7kwM1eWDwxczLTrMQZC0CO
         ZpHWQgAp7UPR5yVwMo9aWmDM7hBLYm1OWBoGN9J2MAlVchSzA+/2M2kpGJpY9o+JV/v6
         Q0Dw==
X-Gm-Message-State: AOJu0Yw6vbxxDApj43bycw0C8h70vHHaPAHF7tCowEsyro2QUB40NP9K
	GW7uFCnsQHbhGliBoc4jEu3xKX8IoVRXhXGRQwhiP6dgQLhPe/MwwqgDWZwPq8bc4wzKNR61IK0
	WSzuZccu4LvYEKUPeT9p1hB5rt4dVmPSxN654RrGcOqHhEd+ArryrhFQu+OVf/DYJdPNu989KvQ
	==
X-Gm-Gg: ASbGncveO9ra0p/mtfVSGVoNsfNFSoWgfWcbGxmsJ0oXHdYug5p01dSH51AFNJ85WMV
	bVvhuqV3qKNbVdAx4b7B38oLWTCFb8YnXS0mpP6sKqSjssQZr5OhRSkx9EhrvtYQQleNSRBq7Xd
	cpV2DToLK7D90n8iZ4VVGY1BVYGd1LjDQPXpiDpxRvKLpLFFux1eQJY9IH58xDNhNmncn9eJar4
	ETeDyJCQtjxJyMWFskQIQkOq9ELXcVJ8IX57YqWSaCuq84lbD+rv7ofzpj0xwKbLu4zUB6cZiLi
	lkUdDUDqr+mVKMvypemvaBdQrJermbs1iOKUess7M6M/Cg+9g71J0cisft1unCn9Gf/jKuWOLg=
	=
X-Received: by 2002:a17:90b:1e41:b0:2ee:a583:e616 with SMTP id 98e67ed59e1d1-2fa24064ed1mr6244360a91.9.1738948570915;
        Fri, 07 Feb 2025 09:16:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEC5gdVSnOo1ypRib+HlmiI4S2pQzXBdCb0LkjQhzhHuhLcbkgl0mCCCizqBBSy8508ItXkg==
X-Received: by 2002:a17:90b:1e41:b0:2ee:a583:e616 with SMTP id 98e67ed59e1d1-2fa24064ed1mr6244325a91.9.1738948570512;
        Fri, 07 Feb 2025 09:16:10 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa0942d30esm3622451a91.0.2025.02.07.09.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 09:16:10 -0800 (PST)
Message-ID: <5ffa4396-b6ff-4eea-9d44-fac5df2a47ac@oss.qualcomm.com>
Date: Fri, 7 Feb 2025 09:16:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] wifi: ath12k: handle change_vif_links() callback
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RjNMvROh1h1UssDqttcbs3SoiLf0s6Ea
X-Proofpoint-ORIG-GUID: RjNMvROh1h1UssDqttcbs3SoiLf0s6Ea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_08,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070129

On 2/4/2025 9:05 AM, Aditya Kumar Singh wrote:
> Currently, links in an interface are allocated during channel assignment
> via assign_vif_chanctx(). Conversely, links are deleted during channel
> unassignment via unassign_vif_chanctx(). However, deleting links during
> channel unassignment does not comply with mac80211 link handling.
> Therefore, this process should be managed within change_vif_links().
> 
> This series aims to add support to handle links in change_vif_links()
> callback.
> 
> Patches 1-2 are making debug infra to work without device info.
> 
> Patches 3-8 are the ones changing the code to handle as mentioned above.
> 
> NOTE:
> * A new ath12k-check warning comes which probably needs to be added to
> ignore list
> 
> drivers/net/wireless/ath/ath12k/debug.c:69: Prefer [subsystem eg: netdev]_dbg([subsystem]dev, ... then dev_dbg(dev, ... then pr_debug(...  to printk(KERN_DEBUG ...
> 
> This is because, since device info is not known can not use netdev_ or dev_
> dbg family. pr_debug() is an option but that will require DYNAMIC_DEBUG
> and then ath12k needs to be probed with dyndbg=+p which we don't want in
> ath. Hence, only option left is to use printk() directly.

A new version of ath12k-check has been pushed to
https://github.com/qca/qca-swiss-army-knife

Please update


