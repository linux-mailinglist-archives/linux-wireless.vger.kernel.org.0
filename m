Return-Path: <linux-wireless+bounces-21406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA33A84F90
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 00:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84639C1B92
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 22:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF7320E6E1;
	Thu, 10 Apr 2025 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fsCz9ImP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FF21DE2A8
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744323421; cv=none; b=co0wxtGgX6U9Bj0wFK3E8Zp+EpsRbuUTaETLAkhCLbMCkSouPbjIASqTjFOJP/xdE+wNuLgrWBmwdBnDO/Sb5AJFFfPHrWh7OjtkyFxCjdDhyxsFRKQh7E9pimivJ0q136EoPzV3TumExiNkMLrFZzSpZbk+Z1WJRMX2sr81RZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744323421; c=relaxed/simple;
	bh=HFP9qPj8dyOE3lqE3Pe0T3S7rWACXve/V2CTd1pqhCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzugVq2DHBhsaonZhLK1y3AmjkxhBeKWOX1j9I1ot/Qih9FnPq9IxL/0RtRMhKNnJ88b0qcPo0KmjcvoBsDOdWzcgSG/evrKBpw40rF1714WRmkdkKQYm9aWjPPeveQaUMMBa47vRIBqqYGGITurCj3U1beEP3VpowP7m2Nvl3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fsCz9ImP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AG7rfU016309
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 22:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SlD2Zoqck4pcF7VZMBOHU/52fauKubtGQptlE1KvI3Y=; b=fsCz9ImP98FsJt01
	ASFcaidgTI8xN0WzSjLgQk2ozYggU+2fa2BXmRSCgo3b9J67QXlm03nEChTMn6mK
	Bo3cpQIsU4gwA+Ls23trtcC0TGgdrDoQ0r1fC18gAqpfHejLjXu5l9LI0kpKX/di
	lxWxmnHK6r7PZrYLv5Ro6WZTZ7Pp1VddGk3CVqqG8w7L0380ZxgcJfclQlaadTRx
	guB/S+VXx5JlGHgUB8gjSjlPqPz7BKcgTAS/9rznOWIQMk+fFwKXXFN3moMrYKLd
	jyoJcrY3hHioBBLdDczXT8iPgMW2iFfM/qxB46DYQWU2yoXmPdZHt1MTe6LcnkeB
	sM5JnA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1r9kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 22:16:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-306e5d9c9a6so2248821a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 15:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744323415; x=1744928215;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SlD2Zoqck4pcF7VZMBOHU/52fauKubtGQptlE1KvI3Y=;
        b=lZrBV0y1XTu8uQg58jF33VoAo+JWNM8wTPAg6n7bWkiJJ7k444yk5ZfSWlkQmtdblp
         mzPgPE+0qZG+zMzch8thsSIuTvCZALjI3C776Sy6MQNNYH9SbcAF9bqR9YKG4pbvB84O
         8uI+OMae+v+fc921MLkD+iAknfxObTQ/SacYfMvqzy4rC49xMetqpT/k8Nm6FO71oS48
         fFL9c0mwn/hag3S/hJaOzjRoPIayR+dtyg3Ts6ptGX4fOGegatFakWyk+BVo0DnyzuYB
         d5ff45xGVExiwUzlGcRlUCgGf+UMFNL2FTFEi3/Nev/z3JwkULY5vQs0kkp0Bt9iL0rw
         O1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUXJy5kk2KGJFK+zzs5W3Tfz5GlabwPiyGye0Wr78Ik/xdyXkAKQudKzhPm8w0QLu9xdhYXB6hxxc0nCDAgNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo6wVhLGiOwbXL4rV9rsJFAl8/YnDekL4WvD5rjechzYNXWTGe
	PkpKzYn5A/xigYWrZI1Vi3Qu+L+oJrbHYpgaps4W8tZoC0r3/barITyHT/ipmwpKm6rkB8Gk5Kd
	n1nARXvnkOxMFYLXAg1mhJnUTnFhO5hpf+sD+Y33pLvUMFqdic/k2pjkc/9omd+FHnw==
X-Gm-Gg: ASbGncvcM8ozaB4IQ4vPiz8psCHbM4WMXRiWh6Tsfn3R3C7wBH3P5kGmSX8DS2waAMk
	bgt7M67/uatDQkiPumNoIgEeyyM/zmxY3fLfaCj6TPOhwAo6h2oKc/Goqj2nWcSVejgXZwEZ71i
	YljmmZXhrb/ApWduL3GAmf5M7ZU33FBq/mA9/kKALUnZnMgn2z8nOYH2b+7GKjGw2EW9vxS81HU
	JARLyhqtuQ1sZY3zqjQjlIiuf8zYPdrh/V+EfM8k5nqXHbgd+gODElEOBk06jjqD60bIJRQT830
	wzq7Tmccj1t0MR3avexr0BEPk5l/Co/VQqHEn87I/U2Ix6dka9Yd2atIwV1Wst6Chj38e8HHCZV
	MIrL/
X-Received: by 2002:a17:90b:2743:b0:2fe:b174:31fe with SMTP id 98e67ed59e1d1-30823624700mr846381a91.2.1744323415420;
        Thu, 10 Apr 2025 15:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3q3badw0zIeHRu251yR5zxmnm+DYdPJGS2wgnmZo8bCO06H0BLiRjTFsUKI1g39u/REbl2w==
X-Received: by 2002:a17:90b:2743:b0:2fe:b174:31fe with SMTP id 98e67ed59e1d1-30823624700mr846343a91.2.1744323414953;
        Thu, 10 Apr 2025 15:16:54 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd1859e9sm4265767a91.43.2025.04.10.15.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 15:16:54 -0700 (PDT)
Message-ID: <23e31f9f-4465-45c1-8919-c5d43034d33e@oss.qualcomm.com>
Date: Thu, 10 Apr 2025 15:16:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix buffer overflow in debugfs
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Dinesh Karthikeyan <quic_dinek@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <35daefbd-d493-41d9-b192-96177d521b40@stanley.mountain>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <35daefbd-d493-41d9-b192-96177d521b40@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: E1syZBN0fvXMiyNpPv1lsd1syy-su88g
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f84358 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=eavArjg6gjGuu_xFX0IA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: E1syZBN0fvXMiyNpPv1lsd1syy-su88g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=726 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100162

On 4/9/2025 4:01 AM, Dan Carpenter wrote:
> If the user tries to write more than 32 bytes then it results in memory
> corruption.  Fortunately, this is debugfs so it's limitted to root users.

I've fixed this in the 'pending' branch:
WARNING:TYPO_SPELLING: 'limitted' may be misspelled - perhaps 'limited'?

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=b49ee0380e07efa34bdc4b012df22842b7fe2825

/jeff

