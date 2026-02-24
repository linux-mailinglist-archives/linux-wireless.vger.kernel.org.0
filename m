Return-Path: <linux-wireless+bounces-32138-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KgnKVgSnWkGMwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32138-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 03:52:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD422181220
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 03:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45D2F300AD4C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 02:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B6A26B756;
	Tue, 24 Feb 2026 02:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="igbFCKoz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MwPWQuI8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F72248A0
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 02:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771901524; cv=none; b=Ft9689zfuxoqgUxjAMP8klnTTUC8eBzAVXI+G05imTrcF95fZPmI0/U4JbUg8wJb0MBDL6zCscVx8yrTXvAg7U+7y6Fz9Ge4KueCfumEqvBCanY8SbXtnsl0tURP6yGs+jGTJpYZHgG1pfxtg+Xm1s8sWGOsRhXH1JnPGHVUYLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771901524; c=relaxed/simple;
	bh=EG7Zem76rcri1wmu6SzU9bpWgufomZXMfyl8Nj9lbdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prTH/pg7QHpDb2CLFRVW4OuEWlynZN6DkVQpd9Nd1fW8R+5y9/IxzDYhvepmCkSnDVGttwoh8FcZaVmNFd8CW+s43ZOlcgjTBA8hN06Oz4RvTKijP1h1URTmV4IMMQR+5IBk8XZspGPdYVlOzthQxMYQ047MjVn7a257ZCq+7d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=igbFCKoz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MwPWQuI8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O2mF5O821508
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 02:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PMJp2dBVtqdUWCHncCX+tIj1sCsocWtenX7q64eQopk=; b=igbFCKoz30Xci/cW
	bs/R2HNQ+IwXCJIpslVh16nsZ9+x69s3ZxaZY0CefdA/DEQdy6CaSYwpBM+xObYd
	f/VCn2owWQYvK/4L6FqN1esG+O5YZjC44PXNAHY8cFNJygAZDZNCqlVFbKAgv7AA
	455tdyxyzBx9GJmvR4B5vbEQNmJyaFRZlNsi1P4yVZdLVbu8bcZRo5HkQRoVBo7l
	l1Pd4KKj6BJoEXwoRv7OcYPuyqtTRfA8kMkaVNrkyc36fr4R5MpmmJ3QPBOXL2if
	LQVEcCdv1t9Tj2bvLdzmPTmJ6a+rQsBDaYGC9tgLRnU5+stB2b1G6QSs2f5lySO9
	9QxzbQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgpj8ac15-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 02:52:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a90510a6d1so43620705ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 18:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771901520; x=1772506320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMJp2dBVtqdUWCHncCX+tIj1sCsocWtenX7q64eQopk=;
        b=MwPWQuI8pWkXh07bLfxBB83oymnE8H4ymDerfXTX+X9SJoeA39vbNyPcpr1fIjVtzv
         4zJBkj9Ui8xD/fegMAZ3NM5ZOEraVy9CMSJXPqkaYTXLN4w2SFDrjNU/ouG6kCK4313I
         bRIgukuOqQ1NnVhhXtZwpW6NDtJeCMptxsCKYB71/DPtuI8AMpWuu7mjUOSl0X5Tpyl1
         EX1cblyfDVoFtfgQaczouH2eZfZ5KPk2CJzi7cOsIUDGyLkiMrNAUSKv3FW4rXN8gB5I
         QbDIPLtutxrV/rjVFGNyk8Mkl8XBaDz6YHgR7GHpUs2tKG8UqTunTjx0HoEJlgpT5rGE
         BwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771901520; x=1772506320;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMJp2dBVtqdUWCHncCX+tIj1sCsocWtenX7q64eQopk=;
        b=nQHKtj9InbAGF36GG3/opHKv7XvAXHIJMzF+zneAxrEiQfSM0gBETGHhQ/AAMHYjm5
         aK3AscFQzpVwcnuuUVqPUWxOAV6NQYjBe5s8Yqlrt2kOp0cbfJ0dOXgwvjBFnTXQ/Luk
         pHNspUQdOa1sHNohOy4hyNNpK+NYARkzPtXMT0pCdPhYAbcZtrF2Ilbp+9goRFBOTfUY
         SHS3r6oUO952YnQXKlzIU9NoJNRnVATz3NyylaqqwG5gKfcIpAL4u+JWTKZE/9KI3fKy
         oORSsVtFIsDkAgBLiSYnt6uti2i/q0JUXZpJCwZLJntMOHfphGkcjv1nDcUcoyOPqzdA
         X0EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwafbhOCh92FmTIgl/Or9feg++aCnpCgKqj6lsq26ldZESUZfht+X73a+AvhoI/XEWTeRgzoaD/bmkp+cJkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxG0mcgeAiPkJO8k+Eux1BIVPSDvq2KTI99Rvxto+DrVJBHiFH8
	BBFjZGyRkuJu00TehiMhFO0VhlhqtFHc4E5YzeQYe28Rfbosg9exHMtK7LwPKIkntN70Mgv8w8y
	op94ONRCPpuZNazF5GALoIkI9Zpwhkn5eb190yq0TMSgD3KVZn8+v6SrP6Pg7fInIOYhElg==
X-Gm-Gg: ATEYQzy0zvjjkAryQbimv5Z7bDM5P5wUXGXBFx1rEZb9MSWIHO1u7J3VYIeoQiGhLQT
	IHXZ5YK8v5nCue5pH3M4OV+BluuTO+Af5tOMiRyAHwfsAFbiqRNNeIzP/cOhZVkLFnJyw6jvEFy
	5tzDoT21ak+WrYiZ16qb9URwopEQZ405KuHfuaHGTPpE35NR9TIpGF+xF2KrA0MmmsGQurPD5uM
	rOlDMjLberX4JPKItSmxtED+Wsi9wWKK8O+Lf8Ilp/7AmRpqCd8Ck5sJPAW3ctsPOgX7STH1WYt
	cyTbJ+0AzMOZMvSWJSKwk88+EWHxuSeuAJSWlCycjjOJjwSSyfJtuGNexG5nXY5by/Ti3PCOpBl
	hI4H/dn1LYXWJ+Pb6wxZ1sUZIDtnBRgQEiBJJjnqNS3jDhX4A5iXoZQ/L+ELWwhAbgACMFsQz6l
	VxUsoQ6B0CWUng9DvUABE=
X-Received: by 2002:a17:903:2f8f:b0:2aa:dc83:242c with SMTP id d9443c01a7336-2ad5f7b89c5mr131753925ad.26.1771901520589;
        Mon, 23 Feb 2026 18:52:00 -0800 (PST)
X-Received: by 2002:a17:903:2f8f:b0:2aa:dc83:242c with SMTP id d9443c01a7336-2ad5f7b89c5mr131753765ad.26.1771901520083;
        Mon, 23 Feb 2026 18:52:00 -0800 (PST)
Received: from [10.133.33.133] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f5dd7asm118909235ad.28.2026.02.23.18.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 18:51:59 -0800 (PST)
Message-ID: <8280b524-4e5b-45c9-ade4-337c3e86e936@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 10:51:54 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Silence remoteproc probe deferral prints
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260212-ath11k-silence-probe-deferr-v1-1-b8a49bb3c332@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260212-ath11k-silence-probe-deferr-v1-1-b8a49bb3c332@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAyMiBTYWx0ZWRfXzTkLB3ihpwbc
 Glz2nx6z59tMZpXSw/ZX5YuroJgMjbSQiesFlW6TSbwrREU2ZEwbX+LEdIMnWuXjoadhPo1h0fM
 iKkwS6xGLNljwNye+kVvLzYZzmPLkw6QYQwvbUCP2GWVSGj0cjv//GgMx/q153s5ypRLt+mV+V3
 MkpvnG4KIX+0txnxWeav9q9eU8UAawNEWyfjgmuMh1K3DoQg5i/n8wLGJQPgU6EylsdEFIGGR+Y
 PUwzZ/kWbnDVvVLSAfgSsPF7albUW1E5nbq5E59GlCKkUm9k7hLJou2WSGtanbUKLjFvi34uqzs
 hYVtXtMyYqozuKdRWjEZ4InFW06i/lygAioLryAd0BaFsoDz/JwSz2cRXwCAwSgvX191Q+Bw3mL
 5eX28fvH9qUd9QfXPLQJ7sZiBH9nk+RMrvVlWtqGKgXqKFlOrKiDl8ZGQPUjPs5mhStSNZdCTcd
 VT5qp8rQCKTAGqizCfA==
X-Proofpoint-GUID: 9B3WhmWzfShlENVyosg18Ysqq2hgOKUI
X-Authority-Analysis: v=2.4 cv=Z5Lh3XRA c=1 sm=1 tr=0 ts=699d1251 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=zcgs_DnFwR7u2ldiTvIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 9B3WhmWzfShlENVyosg18Ysqq2hgOKUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240022
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32138-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BD422181220
X-Rspamd-Action: no action



On 2/12/2026 10:52 PM, Bjorn Andersson wrote:
> Upon failing to resolve the remoteproc phandle one ath11k_dbg() and one
> ath11k_err() is used to tell the user about the (presumably) temporary
> failure.
> 
> Reduce the log spam by removing the duplicate print and switching to
> dev_err_probe(), in line with how ath12k handles this error.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath11k/ahb.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> index 8dfe9b40c12626649639fc1dd9da0e5e0c2dcaf1..08d3a0c8f105b26b1548c5d6006f6ea162fe58ff 100644
> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -807,10 +807,8 @@ static int ath11k_core_get_rproc(struct ath11k_base *ab)
>  	}
>  
>  	prproc = rproc_get_by_phandle(rproc_phandle);
> -	if (!prproc) {
> -		ath11k_dbg(ab, ATH11K_DBG_AHB, "failed to get rproc, deferring\n");
> -		return -EPROBE_DEFER;
> -	}
> +	if (!prproc)
> +		return dev_err_probe(&ab->pdev->dev, -EPROBE_DEFER, "failed to get rproc\n");
>  	ab_ahb->tgt_rproc = prproc;
>  
>  	return 0;
> @@ -1190,10 +1188,8 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
>  	ath11k_ahb_init_qmi_ce_config(ab);
>  
>  	ret = ath11k_core_get_rproc(ab);
> -	if (ret) {
> -		ath11k_err(ab, "failed to get rproc: %d\n", ret);
> +	if (ret)
>  		goto err_ce_free;
> -	}
>  
>  	ret = ath11k_core_init(ab);
>  	if (ret) {
> 
> ---
> base-commit: fd9678829d6dd0c10fde080b536abf4b1121c346
> change-id: 20260212-ath11k-silence-probe-deferr-28c2532bcc1d
> 
> Best regards,

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


