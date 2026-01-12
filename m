Return-Path: <linux-wireless+bounces-30693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4618CD114AC
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 09:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C86E300A7B6
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D52342CAE;
	Mon, 12 Jan 2026 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a8Khh1qY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ViiLh6eA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569FD342CA2
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768207456; cv=none; b=ifE52XdJss7ZInJO9ffCyNjG6R3CW6h3uSEQyCev70v7P6wCuY1L/g/Kc6UglfcVVye4942IM1DuWvZrrOe4/okH99Mu25vZZj6zc4vDi5CvccKehjixTYVTkG6kte1mG9MubGe9KgOk66a8r6990rUf5o8t0L1ZUU1ajyzINIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768207456; c=relaxed/simple;
	bh=ADgbwHLMbKyA3yAPGRUsjyGrbI+w4ukIcFhY2JE6OjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L21lnIV/akt1Ixoc4b23kG9OeHLSF9mAaX4bfSxhM2O8HaoL2WhKPGyn/NSsqHWY909MwiQnwNnWUty5z+2SoniGw7C6+mzkWepE9QZZuEelZ4O0IJntCgRmaJPlPere+f9QU734DazfOFEvPWWaYp7O+tHf2mdrJ04X30+YKeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a8Khh1qY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ViiLh6eA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C82hH73923462
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 08:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LtuylQsGR2SHc1tC5K8cJ0nm8a9J5bKDyHrvDYl9Tno=; b=a8Khh1qYWW8HLxlH
	oxFCQuNlu0z2GrNyeqmnjBk6S5EMTmD7bsyhLapB2SJ2V30U+Vco5ARwx1+iz/Xc
	6WN1UjF3/wiLFaClaS6InISKXPtRuvwXF01q+Xr2rAfbHvI3aFMTo3Q/69r96IMd
	Yv6E2F3LVAuM/QXkYr4RXOO154UMT2bFoInKx7lGn3fwIW5uCQlw/7IeFAwSeHfh
	ztDYACUFYVhi85Zvi6F/NRxUL4dKMZnyPFDGJ4CUjQkopLzJFlGdYy1g5LoTTRNP
	Q2MXyE0yC4YSyItGdAC+ElZD24Dp2EtdxAHkPy3kSGQE+dFZxexxEV768amXPXQc
	H+lHgA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkfham729-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 08:44:13 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81f53036ac9so585726b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 00:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768207452; x=1768812252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LtuylQsGR2SHc1tC5K8cJ0nm8a9J5bKDyHrvDYl9Tno=;
        b=ViiLh6eAHgHSks/VtCYQz9kRMrnWq9J85cSKDj4Bo0uD5n2EEYkzr4jeRbYHN+uo5P
         kJpRZMXXKEob3Is1tVR5ShTGDvLnCAFa5F9HLnDhf4T33HSWAwt058sT1iiKUGBV6Sdw
         9FXkWUwyjnMmQF7zXna4frFCblYyBwqk3Fak1OlIIkxWmqgE9bSPzPSPW5/ItC5xT+Xv
         4KDcCQBk1bzMHmLrjKr6R68oLcTVU3ik+7fCq4QsFjCyLz4LcCDIlKfMsX6QpLXXUlG4
         9ehbku63YBCRpTT4uJIuMSJTwWzzN3HFhQm0ebkIfjPxrIrOlPMlBg6WEeObdEhiNS5C
         Y4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768207452; x=1768812252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LtuylQsGR2SHc1tC5K8cJ0nm8a9J5bKDyHrvDYl9Tno=;
        b=f/j0jrnToAfhS7GggFNWxcXT1JSDWdIteK30bGMGAk35no3NyIhBzwhZ3oi+klo0YW
         zLTo9Kpgs7214WEa5liYg0NCuQ306FzJFZMA9ZBzFrub3BWGpxcBwwE5UiCHYUQDwDMC
         4Kem4gy09/p/lop6YXHdbxwfAv+1wYZADoO+9D2X8lRo4q1v1VoYAUzC+iG7fgWA9/sX
         3a0BbL7vQrFcerw4RVj1sn7R9VIwK7+R72QTQ3i2esgng+v4a+bKRcFRgImdLDI5c2vy
         rdI8LVflcDApRKzq33iut7qr+DURo+Yz3fFwxw48KZ64VVDW/HuT5OMTqEjNl4gHmY+4
         ArOQ==
X-Gm-Message-State: AOJu0YzWfKnf3OUxrevuxfoLqwyejriW7T26YzFwhC/FvwiLPJTFtBVM
	fc39HjyQKDoFLld7aDFwNa8zOpFjqh0e4OWfqhC/ET04BCHtF0fk44a0+jKaoj8QhY7jK6gEGtW
	CFHo1PI/OkcQWxX1eD2K8tH3DzLet0QMKwL4XdZM+uHnALRctvdPjV0umzX8/2jKiHX3nF55wMc
	/MJQ==
X-Gm-Gg: AY/fxX66W3toPfMMHvuIVz0SBPVluzx0TFcSnnMLH4kYoA3Dg3zxE1QRJmngRkDNN3+
	F9oYUMlCeMiyxnCcUqWpapE6y77E6NHjWP3Wk5ScqlqF/wmSCn2l640LG1NDD4S2/WedNDF7esE
	aFhBBa3ep22wvVQCLiGtTLU1QpnuQjN/APi7/LZtT7bHiOK0A1xpDOK49Rr3Y+x1K8KnJgr77Cj
	K3xRyRYwydiuZheCXx7yH4wiubxgK6mCeZifVfgDDAhBMXN4nrDCiEPM6lmjeRbV+tMc2kNAJKO
	4N87Y86e7rzW2VdCH3Yojvbnd/L8TjpztlNLCqsVzd/BiVoEe+2A5gB4qPtcVt+f3ia1Q/eG/SW
	ve2HF60TR88qDAEepeZozgm+vv1ZmyMQfGFbVRWv1GMZt+tJ3mXGVwHQ=
X-Received: by 2002:a05:6a00:9086:b0:81f:f5d:e1a6 with SMTP id d2e1a72fcca58-81f0f5de6e3mr6521275b3a.58.1768207452539;
        Mon, 12 Jan 2026 00:44:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq7NFkE4v7sC7fUG2lzdAtaGT7wu2cdRhx8GoQ3pjyOCC1K1KcD3iCMGbL+8z+DJWRyOYSew==
X-Received: by 2002:a05:6a00:9086:b0:81f:f5d:e1a6 with SMTP id d2e1a72fcca58-81f0f5de6e3mr6521259b3a.58.1768207452013;
        Mon, 12 Jan 2026 00:44:12 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f106e9be7sm6620903b3a.47.2026.01.12.00.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 00:44:11 -0800 (PST)
Message-ID: <5a4acd79-ef1c-4fcc-896e-ac0d948a1722@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 14:14:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: cancel scan only on active scan
 vdev
To: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260107-scan_vdev-v1-1-b600aedc645a@qti.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260107-scan_vdev-v1-1-b600aedc645a@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gH_2wyNh5Yu2s_NKtlJv4T0Pdkd1MPpG
X-Authority-Analysis: v=2.4 cv=bOEb4f+Z c=1 sm=1 tr=0 ts=6964b45d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=iFBeAqSSch97oa6bARUA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: gH_2wyNh5Yu2s_NKtlJv4T0Pdkd1MPpG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA2NyBTYWx0ZWRfX4sbL6ki9Q+qS
 8Mu5AngLDNRgVc/GUcWZ9XcMCzYWKt5heOmGqO+q01T8twexYiCPoKUaplWSF1wvdRmwGGgOzwJ
 eldYdqak3RkrSokR43vddbw8t5ysmSgkCnW0YLIcGATGYsj0+BnwxAw1QHQYz7/ci83sxzDbEHI
 7ov6F9BkewMtdH27bpvZ1FBm9KAnjgZkWayEPhR89Yt90grRgkykST7X2a31I0PqG3eVpiVBQyI
 m21lHYuoErZAinrGHKDpKrzv4woFaQ4sZSNWg7IIw0vHWtDi8JmFbuJYDU4wtgXUewrT4fqn6PB
 it9LrzTU9N94KnFiya7s4QdyzGGVAeELOWJHpRumnU96+2ZLetKc7gqrssshzjrlrq0jEsgUbzo
 /xSvKCLxkVg3o7OZPbblOLWATFVsgmqezQg0h3ZyVNsFL2mAxxQNCKaqHo7itB45BelUpVM0KvM
 ZRZtAr2x4W5tdam2dxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601120067



On 1/7/2026 11:32 AM, Manish Dharanenthiran wrote:
> Cancel the scheduled scan request only on the vdev that has an active
> scan running. Currently, ahvif->links_map is used to obtain the links,
> but this includes links for which no scan is scheduled. In failure cases
> where the scan fails due to an invalid channel definition, other links
> which are not yet brought up (vdev not created) may also be accessed,
> leading to the following trace:
> 
> Unable to handle kernel paging request at virtual address 0000000000004c8c
> pc : _raw_spin_lock_bh+0x1c/0x54
> lr : ath12k_scan_abort+0x20/0xc8 [ath12k]
> 
> Call trace:
>   _raw_spin_lock_bh+0x1c/0x54 (P)
>   ath12k_mac_op_cancel_hw_scan+0xac/0xc4 [ath12k]
>   ieee80211_scan_cancel+0xcc/0x12c [mac80211]
>   ieee80211_do_stop+0x6c4/0x7a8 [mac80211]
>   ieee80211_stop+0x60/0xd8 [mac80211]
> 
> Skip links that are not created or are not the current scan vdev. This
> ensures only the scan for the matching links is aborted and avoids
> aborting unrelated links during cancellation, thus aligning with how
> start/cleanup manage ar->scan.arvif.
> 
> Also, remove the redundant arvif->is_started check from
> ath12k_mac_op_cancel_hw_scan() that was introduced in commit 3863f014ad23
> ("wifi: ath12k: symmetrize scan vdev creation and deletion during HW
> scan") to avoid deleting the scan interface if the scan is triggered on
> the existing AP vdev as this use case is already handled in
> ath12k_scan_vdev_clean_work().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Fixes: feed05f1526e ("wifi: ath12k: Split scan request for split band device")
> Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

