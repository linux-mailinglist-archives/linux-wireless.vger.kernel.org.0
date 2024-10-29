Return-Path: <linux-wireless+bounces-14640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 452309B4C12
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 15:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B43B21978
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 14:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14367206E8D;
	Tue, 29 Oct 2024 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VKjAXvBM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3786120696B
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212159; cv=none; b=kICcWnciDpV6x5UmBthWRnq2vZbGJft+i+R4dFUy++LjCfzyPi3+n2aGUnkAkDwL/qA+kmX9/dCrhzsf27jPDZelXHdVIGI3JTjv1C6VqP8rYzuNfwJIIENmT6sOsm23w98D9hR/lb7dcwDub04qp6YY7wtwth1kT1wr0qpSSFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212159; c=relaxed/simple;
	bh=r5X5dxDkcLTVK99lKBzwCP4nJad61hFiqlBoAwTndk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l1mhWVRUSaAvjQrBUanbWWVVMlbnZ7AI4Bl+ZlopRTv/QkW+nVsxJVBrtHVs2xP7GkinzWw3EKLmm21SW/PSF/tuxfn2i5+fCiZpd72zorK7jnbRwoRmuOKILPVdFKrTVNFu/NzK3C7wK8Unym4KdIuz+1zDM6+SxmDu0Q1RAEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VKjAXvBM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T9jjD7014001;
	Tue, 29 Oct 2024 14:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pZmo/McqSpLcIptNy9yv9fDZlhygSzER86/5Nb6iaLY=; b=VKjAXvBM5cW0RWIy
	iFPTvVg5J6cO0+RgSovgLnYgDxqP8R4bXUUcl0AHF5EFXkYKb4eW1wXFKo2Ly6a0
	61HrnG9n1wzm4kvTKhuS6JS/ZvWKPAW+7BKQj9Ho50YqX4EbYPW61LbgsXKte3Ir
	HGMNmc1dTBoDfQ9ILOscleRejGznLxIE5c90VUd/QVSmP76eEm/ms5cxhGxSQN0z
	TK4XimSgGuOgPDvS1NK+JNiFUeIidulo7gCGewLVIFLcqvIjArGKKq9aRwp+IPWi
	1FSvOQtbFDnnTxrDr6bpUpsrcdh1l3bt+ngKALDiGWDo1KYhAD2944/azQ2j6HMl
	928s0Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gqe60kv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 14:27:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49TER1TI012647
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 14:27:01 GMT
Received: from [10.48.242.156] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 29 Oct
 2024 07:27:00 -0700
Message-ID: <24ca263a-e367-457a-94c4-f1204993cdfe@quicinc.com>
Date: Tue, 29 Oct 2024 07:27:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ath11k: remove error checking for
 debugfs_create_file()
To: Julian Calaby <julian.calaby@gmail.com>
CC: Kalle Valo <kvalo@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>,
        Jeff
 Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
References: <20241025064235.382-1-thunder.leizhen@huawei.com>
 <87v7xcgwb0.fsf@kernel.org>
 <ff8c3443-3651-480e-956e-81c7d592099d@quicinc.com>
 <CAGRGNgUmdKfWxOSPyj9Ofk8ULyPX0j61Qnrd_ckLAy-a0RhdKg@mail.gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <CAGRGNgUmdKfWxOSPyj9Ofk8ULyPX0j61Qnrd_ckLAy-a0RhdKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cPDzIlsYjN9XVCJaB3iIIPrzYTgp274X
X-Proofpoint-ORIG-GUID: cPDzIlsYjN9XVCJaB3iIIPrzYTgp274X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=778 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290110

On 10/28/2024 8:41 PM, Julian Calaby wrote:
> The big question for me is this:
> 
>> Since the relayfs functionality that spectral scan uses is dependent upon
>> debugfs
> 
> Why?
> 
> This seems to go against the general guidance that debugfs should
> essentially be "fire and forget" and return values shouldn't be
> checked.
> 
> IMHO it comes down to one of two outcomes here:
> 
> 1. Spectral scan isn't necessary for normal operation so we shouldn't
> initialise that functionality if we can't use debugfs, which violates
> the "don't check return values" guidance
> 2. We should break that dependency
> 
> I can envisage a lot of people making the sensible assumption that a
> non-debug kernel doesn't need debugfs and therefore disabling it on
> their thing, but also it seems to be enabled everywhere I have access
> to: Debian Stable, WSL and Bazzite. So I could be completely missing
> the point here.

https://docs.kernel.org/filesystems/relay.html

The relay interface needs a struct dentry * and debugfs provides that.
And as a result userspace expects the relay file to be there as well.

/jeff


