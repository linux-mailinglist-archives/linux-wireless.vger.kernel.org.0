Return-Path: <linux-wireless+bounces-26289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0598DB21E94
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 08:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E913A2479
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 06:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382BC1A9F9F;
	Tue, 12 Aug 2025 06:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NPGYHzwL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3917B50F
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981221; cv=none; b=oicXT78w+8F7GHYFD7i5r14/RTpVg/Z4xy03/p+wC24gEKIChtrZC9IJZUgRiV3Iz5hbKnUHjXV9i6nGohSXfwMElKgVEJKKceNBiiOiQOHgkOqIUBDdD6gQlwGZyd9p4bUhKgm8ZOk+xt/GPF/Gkvs4o+IYnQIkz+sBBEqjV6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981221; c=relaxed/simple;
	bh=B9IyK44r5BjhcIopbQd4E6z6Z7KyBlbprsNTCUxw/Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXOPFn2ahaPzVXmi+/um8S3VQOxYZy19ldC08GyPeRSABxXdgWBiS/Uoztjy/bChoNzVFKwDeRGUpY9dOrIz0YvoZ1PQ/lLO8Vs/G6ZTr65KgMFzGhPIJ05h8DqDUn9WfbR4+9qeyjeVcY6rXh3qSPl+IXe5Nd3S46FXl6GEb/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NPGYHzwL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5Y0qc028829
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 06:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6Kr2pRIbKGhXrisn4aRMRXaQcZyrn4ULlwl6JekrU08=; b=NPGYHzwLfItB4bry
	jnkwP5yvKt9JKyf61jsGQCdS98ow4ygKjvLkHNFhOucOcZX4/v4tXlC4Pufa9zA5
	fjaN2jbJA5RxiQnpIbBlck9dFhgr/H1hfylxC1WxlYe/yZ0JYpI3p3RboOXAdRFG
	H617ryZXGHCddcVXA6bE5Te1NgHSygVWxdFqYZ/CD88RWa5R2Zlqb2SQrdXFaVHr
	jyOo3C+hpzUJc7yJ3FyCkZW1Ja1m+2iyxo/7pwtN7vIaXFMeY1FPMLn0w2Jrfh7D
	wLaVliBkGPJUfr3huaHVUVOG6bttkTjx20tLndDxNlPfmzB2l6NxMG1XCqX7gDyI
	5EmN3g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9sq978-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 06:46:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-243013cd91bso3346545ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 23:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754981218; x=1755586018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Kr2pRIbKGhXrisn4aRMRXaQcZyrn4ULlwl6JekrU08=;
        b=cck8Qb7Ee0FG3Djwrnpku+3PyBvocB5FpMTc97tdBtfBgM4kXmstlRzmaADsJpKcKB
         ByZnrQY6+g/tA8+fQPom/722AenXBScKNtbb5eNng4/lvhmXwNzNsN2Pyul2rF3YJ8Qw
         EDIhBjLkIwHAm5PmnrAdzRSadEmj8iC2kIO8j6klb21riTLN1GHKq4+MvYzpY9SfcWm3
         ybjKn1V73GN4roy4N8FLOlQ+Bn5OeFRITG2q+JlyBpOufEGgBN0hIRvI4BiwBWVW0myw
         shjVwQQRJLynY/YqswoeStlZnbcngANSZ2dVvcLkyQnEI0mxBpPLOzLKZZBJHQdi1l8+
         VwYw==
X-Gm-Message-State: AOJu0YwZNvcAQQ0hgctQVAJpuBfX2byxmaBKh3qu3XnXQt72GAKrFVeC
	9nrKvLtILd6aTdif5MWtkoIrL0Pbb51eZTZv5/RhLPLb7CMLG3DsGlyZB9C0ZVV0qKcLyjM3jiS
	Xf5bsc4aR+lIKd9N0vnlhAfiL8qQ7dg+rRHcfn3D/3cpJJSrmkibgmBNGlnaw4rYU90pHnA==
X-Gm-Gg: ASbGnctVGuREEYXEMwY4RSsbxyqbYA4gMra9jbBisJMlgiL1AO54zLzcddOYdVLJeGf
	4tfoHXB7bSvUvMG14Fm/zExcEdPgu4M14p4ExpeVaKIkiU38tXEFZpYwjrrUoBpwYV4nMLp+ll7
	SaeW1qrt5N5KN6/2JAGb/rl+00OR5sBB5m1Bl1+BW7t+dt6rPBlie/MWjX5nVy/yihHhxoMQ/tr
	PKVE5GRhqn/Tjtxm4suJcD7Tboev9qlJ7kjsGk7dg5GUh9jYTOBf/Y77A4J0kXFSkBjrgY35AOk
	rqK5fotzUiW1PveCR4NaK1b77vm1pjNUF2XiulkaAftf+SfavFXUitUL5sAj9u0yxiu08CyOVRp
	7jzTUYw==
X-Received: by 2002:a17:903:3c44:b0:240:2145:e51f with SMTP id d9443c01a7336-242fc29a2dfmr35904195ad.3.1754981217755;
        Mon, 11 Aug 2025 23:46:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGoTQo+EKaQpL1n0rOHNJ+qtlD3oFfHBOOnn1tIXAkifFBzULEIuQNJxlp+h46v3O7DQONYg==
X-Received: by 2002:a17:903:3c44:b0:240:2145:e51f with SMTP id d9443c01a7336-242fc29a2dfmr35903905ad.3.1754981217280;
        Mon, 11 Aug 2025 23:46:57 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63ee49ebsm32588248a91.19.2025.08.11.23.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 23:46:56 -0700 (PDT)
Message-ID: <ca805b87-c733-9397-c21d-36e4094d3b30@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 12:16:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-current v4] wifi: ath11k: fix group data packet drops
 during rekey
Content-Language: en-US
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Steffen Moser <lists@steffen-moser.de>
References: <20250810170018.1124014-1-rameshkumar.sundaram@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250810170018.1124014-1-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689ae362 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=TyE3K8orULLnhOBPg4wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: Cedo9ALCoSofd-NaW5C_tH8e4xO57rlv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfXylvYJKgipAsq
 V9aNuehlP53gp9svuqveW0dRf9Ft/1+DNttgneVoMFK7xCuHZHgYxCzj5PqyH9pNvU1sCH8Sslw
 tSQGB3qrYxN3jRjwhiSQeywv+7z8Fp588xRI45J1C6v1lyuwCA10Zwp0tvrqmuSZIGk/iU0s3lt
 jQoBVNH+euaPa8Kmfqh4EPa8hxGRzcMft+2hVQm7nMvzFLg1UUoE27GXwx/ZyWBvXwBVqmtHnT8
 s5o8a+AY1ysDop3gGPYJ7dwzkMSCjL+I0871BVuN7qkfRQfURQ1yZFpkWINKzrVzB/LaFHZjP45
 p13wBwZ5LWrPjtmDBoCYtZ39jdBCbXooUC18yEsLNN7lOgnyXBsYLiA96vk9c3CYH20EQJtlPBB
 HYQDJNyU
X-Proofpoint-GUID: Cedo9ALCoSofd-NaW5C_tH8e4xO57rlv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015



On 8/10/2025 10:30 PM, Rameshkumar Sundaram wrote:
> During GTK rekey, mac80211 issues a clear key (if the old key exists)
> followed by an install key operation in the same context. This causes
> ath11k to send two WMI commands in quick succession: one to clear the
> old key and another to install the new key in the same slot.
> 
> Under certain conditions—especially under high load or time sensitive
> scenarios, firmware may process these commands asynchronously in a way
> that firmware assumes the key is cleared whereas hardware has a valid key.
> This inconsistency between hardware and firmware leads to group addressed
> packet drops. Only setting the same key again can restore a valid key in
> firmware and allow packets to be transmitted.
> 
> This issue remained latent because the host's clear key commands were
> not effective in firmware until commit 436a4e886598 ("ath11k: clear the
> keys properly via DISABLE_KEY"). That commit enabled the host to
> explicitly clear group keys, which inadvertently exposed the race.
> 
> To mitigate this, restrict group key clearing across all modes (AP, STA,
> MESH). During rekey, the new key can simply be set on top of the previous
> one, avoiding the need for a clear followed by a set.
> 
> However, in AP mode specifically, permit group key clearing when no
> stations are associated. This exception supports transitions from secure
> modes (e.g., WPA2/WPA3) to open mode, during which all associated peers
> are removed and the group key is cleared as part of the transition.
> 
> Add a per-BSS station counter to track the presence of stations during
> set key operations. Also add a reset_group_keys flag to track the key
> re-installation state and avoid repeated installation of the same key
> when the number of connected stations transitions to non-zero within a
> rekey period.
> 
> Additionally, for AP and Mesh modes, when the first station associates,
> reinstall the same group key that was last set. This ensures that the
> firmware recovers from any race that may have occurred during a previous
> key clear when no stations were associated.
> 
> This change ensures that key clearing is permitted only when no clients
> are connected, avoiding packet loss while enabling dynamic security mode
> transitions.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Reported-by: Steffen Moser <lists@steffen-moser.de>
> Closes: https://lore.kernel.org/linux-wireless/c6366409-9928-4dd7-bf7b-ba7fcf20eabf@steffen-moser.de
> Fixes: 436a4e886598 ("ath11k: clear the keys properly via DISABLE_KEY")
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

