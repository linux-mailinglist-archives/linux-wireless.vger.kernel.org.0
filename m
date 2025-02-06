Return-Path: <linux-wireless+bounces-18603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21303A2B348
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 21:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 482437A0858
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 20:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6935F1CF5CE;
	Thu,  6 Feb 2025 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cqj6QO1H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11791D5AB7
	for <linux-wireless@vger.kernel.org>; Thu,  6 Feb 2025 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738873215; cv=none; b=HZFMtrdTefX78FXxAf9/9NzfCd2/48BrIMRkllN/NdoTMjOlMHLgTN9fgURLHxnCWp5DpxU3l3Bcul6ZkpNANtuD4lPc0Oq8gzanwJA+Ghlv59lgP1YeSoRDdxypTIu862qwalc179dquwqy06Z6Gd+qjqUqeiLS9Zheqm0NrTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738873215; c=relaxed/simple;
	bh=R907X0gfXj8PsrQJ02ZgnNI0Qbk93x7osFTrqEy0AkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOEYAwTkOp8n96+HKlH0srAQ600F1Iu+WoNQoLOX8R025SirZv0JV1lncQm5pBTl6wyP6rnkQjrreC8Goaa7kpcX7LkgzU3gnWX+iM8yNamJqrM/KNs251cFZjmuWjdK/8fCVpJAi1JPzf1d7t8LXhlGkTiEwqOCUXd/hxA5kzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cqj6QO1H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516HrTeo017626
	for <linux-wireless@vger.kernel.org>; Thu, 6 Feb 2025 20:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s/YWPeioWos28sbTecZUcxdXc63PtoRhPc/xKOoRZm4=; b=cqj6QO1H4I8l6PE+
	gFRlfgwzFwkbTuKnpfeB3U8qQGFBCP3Yg3Ixr1uzo7esQDbNbHcdvmnjKZy1HMzm
	KVdPpbWc2Le43673Qd5QqbB08buiE+qQ/SmbrvDLYUytLe6c0oUrcmBdSDBrz58F
	FF5G3fAPT/6eH3Qsup4bIBhsxzlN1CHH2hkhKZIfEilQpoKHMPoBNZ+QtW3BQxlQ
	fsIbUnOpdQpf5VDMvtxI0kZ8r1Qr5jq22IvoYIJaUQ5Qx3TWWgRX4xTW2ZP8Kpli
	7umqVf3ZzIJBMe3TgrN+1wTabohAS/hOoxF2CqwYXe6omPhLbt8vU9dgN2Xjcci0
	mgUbmA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44n1vngbe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 06 Feb 2025 20:20:12 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fa228b4151so306609a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 06 Feb 2025 12:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738873211; x=1739478011;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/YWPeioWos28sbTecZUcxdXc63PtoRhPc/xKOoRZm4=;
        b=uDN9GTD23y8CqUUW2zODvzNZRTwtngzg4UT9C7xZHALi6OWqevmQOjEez1OIpguVu1
         bA9nVx5d3adb29PXJw+ed6AfKwudvTvxWhG6ebu2LFFZkf4KxxSt8IXNmxuRbeUievCX
         Pra/A6KF1/j2TAAW98Rt+P1sTY+S655NQ8Vkn0mlaPRXvExctcM+s8OYqXKTFt00xJfh
         um20cIRYuzK2wus5clXHDLdn/yaXXBe+4Vmvyu3H2iFFcWAEwEGK0FMUa3bArEsYXsCL
         NBr0//RcVFaxgY3OaxUkrlXD4CRK30CkqLi/8TJAjEIV0Kak5U//h5sdBepYYClN9FTD
         eSig==
X-Forwarded-Encrypted: i=1; AJvYcCVhFKyK8aUbkUjmDgWy/IedJ4hg5ecMeGLONI4rf6QH7SoSxK/B/MKJxHCNy4vF3smo/siXTN0MAR1CAZ5ssg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY0hBRxa9M4ywLPp3bXb+DY5AhmK+N/BPNIhXnUfcuaHLhIlfA
	wdQ7CcXjqKEvrawZTBruBEETikUFls2ZuO0mwR56L/rZLn6sR1qZ74CnqCcgUY3YdVYCoAWzhdA
	LZQAv0E1ZtoyqKcTmXAwLWLUjNpziZ9IU7lnaZCzjBqw2xNzDCRA6SyC0j2xGknCFFg==
X-Gm-Gg: ASbGncu8ysdt2bhhy5rgsPju/qTvWpFZ0/PdqkxAR2A/VnPaEfV3kl/K86wWko+FqYX
	iHfQt3uSIlJVwJqNwODbniJepLfsvSrtCi0ThOLaZJa85XpznEfveNZ7yol8vvqAuhpvVBeM8i3
	QG4n9LTiZ1pVPEivDS7997dv4nSwt1w2tNfFMDvQbzJXJnRkLhohkzfpMlvOj5JiJJY+Ssyzv3i
	LdYWvOo4Ceg3FbUJwiJg3xdT6+iGABp51pMOZdallzkS2Pg6q4NZfLxVnm+1F67ORpiD0hwTbDs
	v3gw+AdClCBK5+CVZDmjMQFvCDS76Lc6Wl+I3S4QutOv4TsglUyHpQoTrBGRZ6Ft84lgmbTrqA=
	=
X-Received: by 2002:a17:90b:4b8c:b0:2fa:f8d:65e7 with SMTP id 98e67ed59e1d1-2fa23f43a0emr611799a91.2.1738873211199;
        Thu, 06 Feb 2025 12:20:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElSAHcGf626LkkVoIHzh4kNyUtTtCOoY7OWplVqiZDIBb5g4fjnG6p3Sp4zx4Gg9+YhyO26Q==
X-Received: by 2002:a17:90b:4b8c:b0:2fa:f8d:65e7 with SMTP id 98e67ed59e1d1-2fa23f43a0emr611761a91.2.1738873210809;
        Thu, 06 Feb 2025 12:20:10 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09b5ad4esm1828174a91.41.2025.02.06.12.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 12:20:10 -0800 (PST)
Message-ID: <2b52714a-0fe2-4c85-95bc-4a6c0a8a0b60@oss.qualcomm.com>
Date: Thu, 6 Feb 2025 12:20:09 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations
 are supported
To: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
Cc: ath11k@lists.infradead.org, jjohnson@kernel.org, kvalo@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <d410576f-2fc7-4de1-af51-29fbe8b14948@quicinc.com>
 <20250115130359.138890-1-jtornosm@redhat.com>
 <748a5a75-1385-4691-85c1-e9cc5eb4ffc2@oss.qualcomm.com>
 <e1c9b030-8a6c-4aba-8bdd-853113bef396@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e1c9b030-8a6c-4aba-8bdd-853113bef396@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: U1eWtQxr24BECX5bv6RDkYobW2CgoNUK
X-Proofpoint-GUID: U1eWtQxr24BECX5bv6RDkYobW2CgoNUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 mlxlogscore=619 malwarescore=0 bulkscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060161

On 2/5/2025 11:46 PM, Yu Zhang (Yuriy) wrote:
> 
> 
> On 1/16/2025 8:31 AM, Jeff Johnson wrote:
> 
>> Kalle, can you review? You currently have this deferred in patchwork:
>> https://patchwork.kernel.org/project/linux-wireless/patch/20240829064420.3074140-1-quic_yuzha@quicinc.com/
>>
>> /jeff
>>
> Jeff, can you help with this because Kallo has stepped down?
> 
> 
> /Yuriy

We should avoid having new module parameters
Is there a solution that doesn't require that?


