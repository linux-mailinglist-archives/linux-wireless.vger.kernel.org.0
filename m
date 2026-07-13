Return-Path: <linux-wireless+bounces-38930-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uJn/Et5YVGqxkwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38930-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 05:17:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AE1746E36
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 05:17:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="J/PMKQLh";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=cdMxSA6G;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38930-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38930-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEEAD301AF5C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 03:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52078306B08;
	Mon, 13 Jul 2026 03:17:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733F2F7EF6
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 03:17:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783912643; cv=none; b=sjLqwNBefSrNXJbPzQg0pHfP/WYXR/QKXD5qKSOgzNiH5ANxpTNZzFaEgcEuEuW80itFq2FCSRpmdKpjPvFcTQxmFUWLFVSQ5gfJLbZ5aJVGizx0kL0yBY/nzhEavgqh3qLZf1IQmyMqrmXsKUbI6g2bGlyIrvj7AgiBl+LrJ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783912643; c=relaxed/simple;
	bh=zJKHp9iCwjibEtIInY1UuB8YTsoROjceOoSY+LhflZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PnZR9zqcj7LUVA/6ww6UL51y61xyBqoPJrKzJI0Q6kbMfztkv9k/0pcYhLGatUedatjtMqdURExEguR9YfSk3sIjR1maNPROKogFLmpJp1hVjMkeyyeB68s71hHS26eZ8bPKzPiqhiZxYmFugUe44DwsAgGdfbdFyeCi54S7d3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J/PMKQLh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cdMxSA6G; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3AM3p039344
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 03:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s6UXAXxEYf1SyoIhABxkkWxNHAbHxvZk97YORSHe2A4=; b=J/PMKQLhV3BuVb8b
	va4ch5GmkcEg+e2TB0QAD4eywnjCh9Q6EQcnCwzJpqDJk1JUuXeuH8DQdgWdGm3c
	EYJzeJlOal2S5pltkEPZGL7kcux6G0PdU1sqzAiuctUQN+uwqLsnqtgUTgZ1wR/y
	0XN1Rj7LqKfsOLL0EviHyyDr3YS8LgXF9z9rAF14oqLA3d6EmewEnu1DjRayMyGp
	RHJEpSNe4GvozV8NGuGpfPgET7dCUpQrBTHB89TfhAZA2fL8xFETaQnas8z8qipi
	WkkaWq9IHTqXzoGTQ3XhqGBt3wfXn1XpC3iZiCvdMX6hMS7ruBKUvzbzMj70UEYk
	pgIJdQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbee9m63m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 03:17:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cce14a21faso45427825ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 20:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783912638; x=1784517438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s6UXAXxEYf1SyoIhABxkkWxNHAbHxvZk97YORSHe2A4=;
        b=cdMxSA6GUy5x+16Z00aY59EkY0iy+impV0rlByXzAmimeN2uE4cJN45xXXxuP8AOKG
         BnQwhkXDbCS5JtT3Exwz/ZEdXtuUlJJFA0ux+16qef/Bj3Xl+NI/NbwaR0aMUe2jYYL4
         P8pilp2d7kknO5v+EEMo9hvnixVWedI+UrFd6Ac56pEx7J9QeiNNe0FHfQytUB5Ftx9z
         8MbjbR8OBN/AMZ63coATpFWXLXf4dTqPujuer/ZYErg1gMnqXbq/YrudOYBeDKhTuVLX
         pyKtxnfP9uxSSCi6/CJC+8lvVb02y7uptWCmEJfwea1e7MbuBcBkuMxSgAZICAkoHf/a
         mnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783912638; x=1784517438;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s6UXAXxEYf1SyoIhABxkkWxNHAbHxvZk97YORSHe2A4=;
        b=FM+0MmT5L3eqU2YGtfb0dNkFNFtYsWbBQsfEHI28tphotjW2eg5JW+dN787aYCQMob
         sQ9fC/wCn8bsUe9vfBBfKCR5nss/XWXcUgCNEoB7pcSqdVqjcr6A4Q/dmDJ3rOcH6eLS
         dtIHYDprg0dJs5tWh93pL+eUp+Rz/jvbB/GkxK3a05/AVNt8l7it9xncwe+JuF3av7rH
         dOgbwekqYS3sgY1fGKravUohibDmYb96obEvrb1NR0yawfvgvWg5pMVdz50t2uRtNLhk
         FFvPanwM4exHXIudTU6qNJsLgDU/JWtQ2GIFbfvQavU3iSfjHSkOrTtLqcfDZ4fmJK/X
         BxNg==
X-Forwarded-Encrypted: i=1; AHgh+RpeilMlklTgwPWZhHnRFs6/2koo+/j+8d9JBBVahxffBoklqqPShYaxIljDkTsMd9WqPmlrx+qMiXr9Yad4zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YybfgscUhVm5fosBC+gT3oEvGPKEiNuaB17zWGHX58V2eUKxRkD
	hFSFSfYkyknWUie2V2XSyK7jgVMPLcFXVUl5PloygLB3yCu+DwD0CzEcLc7du/h3yejXaFzbdTA
	KD71+USihviBvbuOrm04weCNAKLLlvfvvgAQC/a/wcZYgVf8AsBMH7kQho4Ht0Ik+7W7BZQ==
X-Gm-Gg: AfdE7cno8SjdhtWnnv/fcF2MSXgcvMZWiy9msWh2OgFTrQj9ZFXnxeSHYQIAPudlAWi
	d3F6+VTw8aJ0qv5gyvpBWIGO1uIQ9q1bBiZHzdOb6d9PCQQt1361hl7UN8myBZ073pILefx3CnT
	YzE9nQsLjFIbuqphcrNKyShcJTDVnG0yU15OOiQs77NLQQI1KT3Wd/vVLxMtIm9Kehd8oKitqd4
	yKmcLAT9cH9OgBheeK+XFMcS1x9NjHa2ajKU7VJYqLopvX2G3PicG4gb59dJFCeQ+k3T6EElyFL
	XoNMjZX5GlFVzgJyMFG7os12uogGDm20AX+zyHBp5d69gyVAJ/ZV+OZGyZNZBRZeQtGqU94cNeZ
	MErmyy1pFssMWfZw+tXY9zPECgjAGZWn3+05yzdVMEh5VwiQYD/VTaWdgE8fVKOGsC6gm4I9eWH
	L6nkvJreE=
X-Received: by 2002:a17:902:d2c7:b0:2c9:994c:9a5 with SMTP id d9443c01a7336-2ce8298a501mr112386165ad.30.1783912638374;
        Sun, 12 Jul 2026 20:17:18 -0700 (PDT)
X-Received: by 2002:a17:902:d2c7:b0:2c9:994c:9a5 with SMTP id d9443c01a7336-2ce8298a501mr112385915ad.30.1783912637929;
        Sun, 12 Jul 2026 20:17:17 -0700 (PDT)
Received: from [10.133.33.33] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf7858sm92067285ad.23.2026.07.12.20.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 20:17:17 -0700 (PDT)
Message-ID: <8133bce1-2b7e-46fb-8989-f5946ff341a8@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 11:17:14 +0800
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAyOSBTYWx0ZWRfX6WTeQRMCXxlU
 GHpjgqXWLZwO0VoYQoyQlDCQLsJ+3n4O1hMadt1T4YySLZRlESQxYX1zzitDwJ8dF/hRD+pvpzU
 U7TGYvY5sifMaYFCga9Lwm9kHy0cxQA=
X-Proofpoint-GUID: _wqvT6iv7-8E3OdAAjx90izZYGGZKg1a
X-Authority-Analysis: v=2.4 cv=a7UAM0SF c=1 sm=1 tr=0 ts=6a5458bf cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=BBdAH38HxtlORMPQ_CcA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAyOSBTYWx0ZWRfX9H6yNzAtqokg
 KL3QB0G3hdtud1S1S8wLHHCu2meWlwZaxStbYKnRvOuV8wJKA+BBoz7vcAK+Wm3LjAV2A25S9Wq
 Yak0hHqXd46QGmt7dQyplRDgff9s3yy5yI63X+OqZh1UneJqAC/nBHBmvzBqHszONGypGmhbAoh
 jY2WdtbvExREY0BU/jEoxphxAJY247H+2fUqjFzG6j/+fog1mLLIa2xAcTi18SCUEwuC9/0h/4H
 pA8obRx2UkjdFcFUVCMbeA6RVXnd6Hew+i+D/ZyWo/i6XoJFXaeHfZlbvNhCk7K/U948PNKn+Jy
 l1qg6NTvLghhm+kiCgmvuEthaD0yA1Dq4bqNaD9bWNbgP7hrELXPsTUs4Nc4hp8731TxL65F2Ej
 oat9Fiu65+KqHYklPoEo/2lTGQQ+WEy70w0CR3iFd5KoEGMJHU21PLeuKcUYgv4VxSKKb68k/Pg
 O4/8Y8mvju/+RNkmegg==
X-Proofpoint-ORIG-GUID: _wqvT6iv7-8E3OdAAjx90izZYGGZKg1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130029
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38930-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:jjohnson@kernel.org,m:vasanthakumar.thiagarajan@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,oss.qualcomm.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: B0AE1746E36



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

should this be ?

	ab->qmi.handle = NULL;

> +
>  	return ret;
>  }
>  


