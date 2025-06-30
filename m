Return-Path: <linux-wireless+bounces-24659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B5BAED663
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 09:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F314E18997F0
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 07:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8552222D8;
	Mon, 30 Jun 2025 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gq15H9V5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C3E23A9AA
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270301; cv=none; b=b1IUIsuI6Yn6YtEjrQYEcqKy++A7eTzr4jA+TgDkeOXa6T5edrDRfe2TLp+PhcyeNm6jQsJY/hAo4SDRiYy9o5agj3W7YkCM9+VDt3MLWRUyDgxWjFhXIRUeIHQh7+GErT8chJIJWkaROJIJBE9dptzel5uiZhCRK8RYzFJ2CKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270301; c=relaxed/simple;
	bh=4FyQ+4gOds6e/SlVYsta5Z6eEf9rqVtUoMjL8JG5lU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUolwjMgKnWdAaI0PjZaiCDRQIFtcFnFm16/bqv0Wr17czMClfchQOYqmTxYMtxEuKckW4zsFXZtyE8ngd0MuNKGSGuKL5o9U1oWRseW97KpGQa/lQQQh62Ju2iExW4/K0faHGzVzu6xWJcjr6EDP00Dc5RvB6nDqVNY99AdR8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gq15H9V5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U4pEaO014851
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 07:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bE23Ae+/8EzCG86+Lm/cowAvxhFQMSYP8M/1txLwQKc=; b=Gq15H9V5LmtRRLEp
	y+fE9lHPva2w9uSZToVfnyjaDgL4naoRWb6E/1H/iTjrqn+3mHhozpiFrzYb3hoT
	G7ZVse92LVQDfoRUPOUGHukhHPGCtXZLnLI8QTyaDaqqyovx6CkVAffcvf/SIXn9
	PDqnsQIAMX+LuJNACcW4wcEuPOmXhETLF3LNKk1/90TtARs3zDN/dPf1OQ0D77pq
	OyF1wAHIuYpi6eb3vpDolxmeoRlK0AkH11n2yHa3a7QF1BI5exzXvCvqVbqP7qRE
	k2758n4nx8vM3Tr1z+J+shadB4SFGb3cQx/zvgguBIX3JMHxNYP4qQtJw6qa87P+
	1cT8Og==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kkwrre8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 07:58:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a762876813so70948981cf.2
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 00:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751270297; x=1751875097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bE23Ae+/8EzCG86+Lm/cowAvxhFQMSYP8M/1txLwQKc=;
        b=OVjClOjAKPwRi+QB3ToyL+fu6VOEMnGT6/kv7LphNwcmG7VavFELdv3VRNXfmkv4Mv
         7jP8ymZw/nRhL5WX7h3s5afDnXsf0EiPMZobMowKM+/gCFdkJLon49CveLcGCjI9Iftf
         XcwbwbjV1cvwyqfwYW/NUmfbBhUz5P0evLKc2ezQeUSplDxpW6fNIFH73DSg+iBZV4c2
         C1ZEl8O2CjNwNowQo6IGx37EK0ITZHpwYxr4YfA64To1SW3ob+rZC5564PQV9ex3HRhu
         cqHfwruV8ijefsspySpvhDOekLQO14ipgeOtQlMwlkFyudy7tZnDrkp0G6pQrVQ9DsHl
         EA2w==
X-Forwarded-Encrypted: i=1; AJvYcCXYrMblBego/GG0eCLK2UrJ4s0djBL3nwyFw9DxpAcSIYd8jiEEw7H0eazSfTqIZsUFNytrPvBbb9pbHbwSVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFMINOD65XWWKVErTJ2LwFwlJ7srvuCDNXsSiagS6btJL9tFU2
	w0juVE5ziZCkQAqLPL2c+Rf3BqrC10o+BZi0Z3PA5m4QNri2lNjiW3espvSe1dFWMdmGymnfHnG
	2R3reYXguvWtUescpGSsDg0x7L7Sxk7Nh49gQWiffexawp00uTCyX0hvmPHnY3YjTt/A+YBaVlp
	dICnl2xbDCjM93/DJT1QDw6r/UW5oJGXqlW1YsyOV8+hbGgENMyHXL+eOo9A==
X-Gm-Gg: ASbGncuCb1DhaGknp2shvFcdYuOfqZ0SFAx1T6kRgCFPuQJIkow2J26PaqjaSEi0Yvq
	s3jGhmu1VFrZp8FN0qaVuQWJPD2Fz9ozPvluRYe5gdaBwDXrqo9lBmP9no5KTZoB5/UkGAEh/DC
	tvzuJW
X-Received: by 2002:a05:622a:494:b0:4a7:e3b:6d9e with SMTP id d75a77b69052e-4a7fc9d42b4mr157205531cf.9.1751270297223;
        Mon, 30 Jun 2025 00:58:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqrB2Pyp7iqU1FufTj7/z0ecuMNsxRPSq93+C6myVBFyHvWexyv/uthgNVpyXmmnzPE1k21rF9pUwTVQ+pwzU=
X-Received: by 2002:a05:622a:494:b0:4a7:e3b:6d9e with SMTP id
 d75a77b69052e-4a7fc9d42b4mr157205411cf.9.1751270296802; Mon, 30 Jun 2025
 00:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623022731.509-1-kang.yang@oss.qualcomm.com>
In-Reply-To: <20250623022731.509-1-kang.yang@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 30 Jun 2025 09:58:05 +0200
X-Gm-Features: Ac12FXxpkvzRSMs0AptSVojDd-PiVMNFRB4OEp7LhNdOem9PyCCYBuzGh5t7dOc
Message-ID: <CAFEp6-0GN+j0-z=pu8VyCa76K8HS=gHOUxNjnAt_OSCmj+XrXA@mail.gmail.com>
Subject: Re: [PATCH ath-next v2] wifi: ath10k: shutdown driver when hardware
 is unreliable
To: Kang Yang <kang.yang@oss.qualcomm.com>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=XeCJzJ55 c=1 sm=1 tr=0 ts=6862439a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=EUspDBNiAAAA:8 a=Tk1VEMF_3BOPV1PWIZcA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA2NSBTYWx0ZWRfXwevcdPBt6/Ts
 GkocrQfM1Ka+9DMsbRmIRbyl4KV2ZQUnH8xz84odS9xkL1CPRwqAq8Ss6ZlSwZAu9s9DfkZDuiy
 /XVzBlWCe/955mb48jeKB3U51UPFsohSR8Duv6qLmZUbK9Hku6FLGMYq59ic2nRe3Yx2oapEZK3
 oMSz5S/coyWazQluAwouRoAfzfNG0xoC3sKsnpXjvvkAxKq5Kc06g1BMJhNrKZM12GTdbqbryu0
 t56GifN/hh4r0qZbl1QQ8l0eIGrHX/jvngxLXgyyoUZIEZNEPsQOG3M7QMcXumlLCGTdu8anCwf
 J4hcNEV+7omwRs2e6U1ncUXoP/wKnLZ2+f1WHddDAe4o9FHyT2gAqkczqJttRU2z/TJp2ouloVP
 GAmrqTWAA5GDGvNi+jJvWdS3BnzR/LBqDXx3Thx5FUFcPY5KpdLj+wVcNlEOIkbi0uCrAMB/
X-Proofpoint-GUID: GG_SdDC0GrctptlOmqHJ1Ibh5lUW4FSA
X-Proofpoint-ORIG-GUID: GG_SdDC0GrctptlOmqHJ1Ibh5lUW4FSA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=826
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506300065

On Mon, Jun 23, 2025 at 4:27=E2=80=AFAM Kang Yang <kang.yang@oss.qualcomm.c=
om> wrote:
>
> In rare cases, ath10k may lose connection with the PCIe bus due to
> some unknown reasons, which could further lead to system crashes during
> resuming due to watchdog timeout:
>
> ath10k_pci 0000:01:00.0: wmi command 20486 timeout, restarting hardware
> ath10k_pci 0000:01:00.0: already restarting
> ath10k_pci 0000:01:00.0: failed to stop WMI vdev 0: -11
> ath10k_pci 0000:01:00.0: failed to stop vdev 0: -11
> ieee80211 phy0: PM: **** DPM device timeout ****
> Call Trace:
>  panic+0x125/0x315
>  dpm_watchdog_set+0x54/0x54
>  dpm_watchdog_handler+0x57/0x57
>  call_timer_fn+0x31/0x13c
>
> At this point, all WMI commands will timeout and attempt to restart
> device. So set a threshold for consecutive restart failures. If the
> threshold is exceeded, consider the hardware is unreliable and all
> ath10k operations should be skipped to avoid system crash.
>
> fail_cont_count and pending_recovery are atomic variables, and
> do not involve complex conditional logic. Therefore, even if recovery
> check and reconfig complete are executed concurrently, the recovery
> mechanism will not be broken.
>
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
>
> Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

