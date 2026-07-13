Return-Path: <linux-wireless+bounces-38932-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pd14D4NcVGpylAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38932-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 05:33:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A096B746F24
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 05:33:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=W7kzXzAX;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=di+jOHqF;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38932-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38932-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8661300E14D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 03:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691A529BD9A;
	Mon, 13 Jul 2026 03:33:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D492BD59C
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 03:33:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913599; cv=none; b=KHIb6axq8BUnVCysw1LwZLXyHd7dk1KsWP/zMDwKpeLfy+kK+tbZx67NZgvZIjG6Tob5a2CBVltFv7NlhuACAFYVQKhYlLM1nWwo0RStgMk5fvLNHSvvODcOJZU1RhkAnV4vMnwfDA1P3z4wmn5EkC16vQzlBg/FqHLRewmzDBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913599; c=relaxed/simple;
	bh=h6oOscAAguANCZDJxkWy8rFtuqFfu2tJ5MYQwBgxIJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZCPpFLzirCitB2nn/k678ceda2MbVENo1wNEHYjjLIAAm2nchHQ03AWw5JMVVpEPzqJQYO+6gonU4X1coAd+DIHW5lw2icxXlJigTAF6Oc56gK2sL1tyTMxZPsO3n94Wr8qrSwAyBK+LsT+KGdM8WP2Z8ubLP4n27nZM0rReOJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W7kzXzAX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=di+jOHqF; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3AKPG136801
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 03:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F8rJJgcg5hWvGHnmMlB/vJr/mhGZXs+mdRV5ZzRHmeU=; b=W7kzXzAXZluWWEvH
	JTbb6yvH1bVwlZFG+jGdqx7rRU0w9KsdWKvmG+eOClmVhveyEOEaT0svjCAR17MH
	R1EH8oqQNywTq3yyh31eHVSMoaK6oU3E6ABrSlfsSA75B3hMh0lQv66wC5Al43UK
	RXz2fUqPcv28zQCaPdljADNl7o9iBf/mEDjAQWU+kYOUulFX1nwuyVeZEGUBNzuO
	JKH/4fi5WIsIYO5AYxrY7GoSOIAhiGuT7FTKzhENzlc4l5jfRTZJSa8ckf+E4Qyh
	bP1YW7dHNWpuni+nYlmeWWtdZ28F+ZqF9puk/c0flttusWM51N65yoU0feAmkRg/
	AgKE/Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe9146ud-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 03:33:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca8aee88725so3771044a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 20:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783913596; x=1784518396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F8rJJgcg5hWvGHnmMlB/vJr/mhGZXs+mdRV5ZzRHmeU=;
        b=di+jOHqFVSWR8tqTDp6h+KDdfV47TwX/l/kqFhF0bTWsGXEkxMOjmqkdbw3w603H3J
         lFFxyFuc4s6qf1ZgzFDj6QkE35aHH4r/GkcQoyKv8j/CI/q829fOsfnUx1ev06eZ0txu
         hdhXcQogZMvCUMBiNRXrn1hpdJeRZcno96QV+0Wnf8gsMcaedXW1iBHnNA6MXp9s4rv9
         N4wkY88TDpS0VnfP8LPtwbMjZdkkBbhuCnHp74JbGqjRt3A5yi6zUpR7MrUuY5p/IqK8
         wiZ7sufAC4MKrpAf+AsDOnzoQoGkCxytXUpkTeuAyGm+sHj6DiB4CvZ55mzjR0AYWQeI
         saZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783913596; x=1784518396;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F8rJJgcg5hWvGHnmMlB/vJr/mhGZXs+mdRV5ZzRHmeU=;
        b=XNi/f9NQmFsy1wryv6qp2EQ50AdR5kz2ubH91rwG4i7rsGpLQG0BsYINjf6jUKcyUB
         WuzcMXMgN4Rdi1yCtL1MPa7xznpv2QMoZMFCI8cVT1z+tJIXuroUmeFI53YgY2u0NvUM
         8BYwoR7ZidIeYpIJXFYNEjjlmae2e4xege2gJSjjxnTYaKDd30PvpN7Ye8ym4+zhrILE
         k8n1RXwzifjBL7vOzZGmgnpRZLFTBIEjuz613cQiWahrJsgPxOAZrcBQDKd9Ja/BiIZS
         gwbHyUZ79bJVPZ/18xOlxKO4fQYi3ac4+nWawCC5X7E1rJNHlMA6aRsuLVGT9aKna5P4
         mrOw==
X-Forwarded-Encrypted: i=1; AHgh+Rqivll3/37/m6pBO3pYwAbjlsL1WJ6hCqtp0kZy+PimPZGB+zj913ihZfFNE0+nd/zVSZsConibevGoW6BOag==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPcqLqiFDfPIGclL5l6JGh15O5cASgwQCAnDv7XYtxxfHEc8vu
	NMtMzQAGtn89ToJFcAsLYYsO/MpHtiQqw8QXg3+StrTXtsNCQBdoT5GA66C+Zexv28df4frOKLh
	Up8FGQ+X1nJA1f8yLFuYCZdCbFTBCjrzb+k6XFQqU06b1Fm1uyssS3ghS1IXgWfhqLjNxqg==
X-Gm-Gg: AfdE7cn3F6mKpfujKR4ujf9tM46uucgD9sMwo6vlbBofiN+4mTqQDOkm0BorKeqKsCn
	qBu5Y0Z7BZOG6DL4RhqMMITFJmXvwmPAWrccLJaxCyTkqTg8JcChMyoSJ+7JNLNTWQgbcDFnI3m
	MjLEYQRvSex9ZAu4yj7OyV5K7UYWjYjK6NX81pHpaJbTUibMHuo9IcAgUM9zR6pSMck5k9wcJC1
	KGlymAs69tR4WFtShoz3JoujHkPbk+QYRAG3A6LLpEeiMW+0yh7iIiN0oyXw0s/RbCa0HxRkIzT
	p9Y1KaP7bD8b19e+miq3WfnVX7gGDgzMCYGmOZ7hCLu/4lQChSgiH3upL/84jK7hJQYx5EhU9YU
	u9qjN2vm+h1SNWPgACBSVvMt0a0aS0jrF8xTUFRPXWE4LosiF/Wg9iKkc02f7/F63/omFm1GAZj
	mfE+iahu8=
X-Received: by 2002:a17:902:d2c8:b0:2ca:ecfa:1308 with SMTP id d9443c01a7336-2ce9ead153emr73387205ad.20.1783913595837;
        Sun, 12 Jul 2026 20:33:15 -0700 (PDT)
X-Received: by 2002:a17:902:d2c8:b0:2ca:ecfa:1308 with SMTP id d9443c01a7336-2ce9ead153emr73386885ad.20.1783913595299;
        Sun, 12 Jul 2026 20:33:15 -0700 (PDT)
Received: from [10.133.33.33] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ce7b3755a3sm49385165ad.80.2026.07.12.20.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 20:33:15 -0700 (PDT)
Message-ID: <c7d7e6d5-88e6-4bcc-8c35-8fd48d8a5464@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 11:33:11 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: release QMI handle on late init failures
To: Guangshuo Li <lgs201920130244@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260708100924.744386-1-lgs201920130244@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260708100924.744386-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a545c7c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=BBdAH38HxtlORMPQ_CcA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAzMSBTYWx0ZWRfXyB6ZnxxbfR5d
 d1doc65LQhvjkMr8K4OdQRItMr9v9fYbP7lBbVUGXBpzB4B5WQmpu62B1DOaBApPlOrz+S7vKoT
 CKFcNdRDgO2iYlylNgai+RcnK3SqwS8=
X-Proofpoint-GUID: Bw5dnvDbTSdmIfhm2HFBn3Iw0Sm_od57
X-Proofpoint-ORIG-GUID: Bw5dnvDbTSdmIfhm2HFBn3Iw0Sm_od57
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAzMSBTYWx0ZWRfX3wsIcD4zPcgC
 G4lOpGyxy3yM2v42IsHyhFqlkUOBXrDbdflzgCCoYJsIORMyOVzkcSE/ACTy7eDLijPGKs4knIk
 h1gTX8xH9TKrYW/kj9sLNg1jBbLBvNrErq3RHC6/LclTbP9UP0w9h4GgLFFcvab7p2rWvGkuGWi
 rrNtHqodjy3k0KWvRRxkxJDTmIg02RgLH9T8OcuXBZvjDJMSpwRj7r3biMx8HMCY7t/uU3Rec86
 Yj0GF1z+lt677dBFenBvzf10dB1jkkhhhrPZOBvyDrckMBG6IG66Uk0ZQs1AIMBf69eDnuvrNZs
 +mRp1KxaMG0LWWMSYM1hqKuLqDHXTAvdECl0aHGOc7AfQxclqrQOfExX5i7RkPVg+z7hooT0MSA
 OsskoSuDgcKcd4tbgDXIii+2MkgUUU7vudKBsRYJTBNTe93UP/dbVyFceU7tQPIdHhyQcAR6Wab
 UYY7OaDVr8AB+6nDhlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130031
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38932-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:jjohnson@kernel.org,m:vasanthakumar.thiagarajan@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,oss.qualcomm.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A096B746F24



On 7/8/2026 6:09 PM, Guangshuo Li wrote:
> The change referenced by the Fixes tag makes hardware group creation
> skip the device whose ath12k_core_soc_create() failed, and only destroys
> devices that were created successfully before it.
> 
> That avoids releasing an uninitialized QMI handle when qmi_handle_init()
> fails, but it also means that ath12k_qmi_init_service() must clean up any
> resources it has already acquired before returning an error.
> 
> qmi_handle_init() can succeed before later initialization steps fail. If
> the QMI event workqueue allocation fails, or qmi_add_lookup() fails, the
> function returns an error without releasing the already initialized QMI
> handle. Since the failed device is now skipped by the hardware group
> rollback path, that handle is leaked.
> 
> Release the QMI handle on those late failure paths and clear ab->qmi.ab
> so the failed device is left in the same state as the qmi_handle_init()
> failure path.
> 
> Fixes: 088a099690e4 ("wifi: ath12k: fix error handling in creating hardware group")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/qmi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
> index fd762b5d7bb5..31e9fa9a62be 100644
> --- a/drivers/net/wireless/ath/ath12k/qmi.c
> +++ b/drivers/net/wireless/ath/ath12k/qmi.c
> @@ -4054,7 +4054,8 @@ int ath12k_qmi_init_service(struct ath12k_base *ab)
>  	ab->qmi.event_wq = alloc_ordered_workqueue("ath12k_qmi_driver_event", 0);
>  	if (!ab->qmi.event_wq) {
>  		ath12k_err(ab, "failed to allocate workqueue\n");
> -		return -EFAULT;
> +		ret = -EFAULT;
> +		goto err_release_qmi_handle;
>  	}
>  
>  	INIT_LIST_HEAD(&ab->qmi.event_list);
> @@ -4067,9 +4068,15 @@ int ath12k_qmi_init_service(struct ath12k_base *ab)
>  	if (ret < 0) {
>  		ath12k_warn(ab, "failed to add qmi lookup\n");
>  		destroy_workqueue(ab->qmi.event_wq);
> -		return ret;
> +		goto err_release_qmi_handle;
>  	}
>  
> +	return ret;
> +
> +err_release_qmi_handle:
> +	qmi_handle_release(&ab->qmi.handle);
> +	ab->qmi.ab = NULL;

since ath12k_qmi_deinit_service() NULL-checks ab->qmi.ab to determine whether qmi service
init succeeds, does it make more sense to move ab->qmi.ab initialization in
ath12k_qmi_init_service() to the last step? This achieves symmetry and also avoids reset
in the failure path.

> +
>  	return ret;
>  }
>  


