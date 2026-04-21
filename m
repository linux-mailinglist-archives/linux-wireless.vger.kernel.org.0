Return-Path: <linux-wireless+bounces-35190-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ9hK3gC6GlJEAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35190-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 01:04:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65948440669
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 01:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3EEB3072E11
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 23:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D03838422F;
	Tue, 21 Apr 2026 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C08Wgs/D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KHIK0NjT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8D037AA9E
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812622; cv=none; b=iHNuhx3oMg2uUo02X5r+Y9qEPIlOXnxlE4EN0ao84MTDWi6xSvD1sr70j+q53xqQhQPi90gVKPgucEF0vWnXujPb6QcvmHuo/hneDZJp+oP/OGWxW413dK55YHwHv4ykV+wKxp+IwAtDVZkPKLfKvBXx5Hdh6yqoDaLEy+Ptf54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812622; c=relaxed/simple;
	bh=WeQlN7/klHm/dv0uvUwPM0q8joCUvLWnJ3Sz9EmDYX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hciKZxtWPWDx4GrdZVjHCaXm3TEKcQdM/ufNKPImv4gER3PYOIUp5pbUrgC9kNzTQ0dgEZiUruGGoTA0Qs9UYiej/ydlsebsfTEUo8hxnY6Y9Lws5Ts952Ay+XNCd/uDXJ5nHKbQs+7fdn8Lrd1Eq01+YwY1oQNr7KWWvXcj5ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C08Wgs/D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KHIK0NjT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIZtEK4051189
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 23:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HQZP7gTwR4SY+QJKGb719xKlN345DJF+yiTx3Ot0K6U=; b=C08Wgs/D5BxxsDTG
	uPClNrUhhIVtPGrJtfKL2LUB588QQ8kyDjstsGbE4UXFhsASAYMSh+JZHy5SJ2vB
	aN5NgCAvsYOpIN8NCVVQzct3pAQ6vgiek9Z1JozcJ4v1qU4JsVKQLRYSeU3J8OJj
	ogfCl5FopAB4xHRwv1y7e6G2RHwTOjDVwMeqSxAnBbWp+Qkc+Vg100pm0li5U+cD
	GfDOUcO316dvWAgurOWU/ivbbLjhlvN87AS7Vv486IVRmd99WnnqUzdKGsGnmg+A
	vIPW8FiDoTl6FTo5i1+5q5iWah3MsWL/kOkURIBUNY9g42wysoGYnOlCF5dQrzJ8
	GD2Gaw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfgr03-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 23:03:40 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12c21dbc9c1so13917917c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 16:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776812618; x=1777417418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQZP7gTwR4SY+QJKGb719xKlN345DJF+yiTx3Ot0K6U=;
        b=KHIK0NjTw2nSDeRPS9Tf2RD81Wru29NeE1dlkQLq0tI4K4Z/PAT1GJHkA/kXUfjxoM
         coknaeAwGwlb0pP0KuD9crYctyju3mIBje7fE/5MyuFlzCIwjPa5mRH9FlEFJPvRF6t4
         EUwcdcjT5OK2IEa6vvDSBEC+NYS06FTc7eIFhfckzuG3zZatAneoX9PJc9+ep/z51Tn9
         83lsOiEOdm1NLtwtxQegX3EIIIQn8rb2hYJu75bt5BrqSJ6JtV3wDDbyNpTEtlgHQ7oK
         b8tRFRnJOXDUTpbv52OS/DQDQF9x8DPYPA5xUCU56lgnluRLMhrcm4HHHKzFZ4fnNuwg
         A/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776812618; x=1777417418;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQZP7gTwR4SY+QJKGb719xKlN345DJF+yiTx3Ot0K6U=;
        b=K1oNckWtn7V0tGqiqgtsHMVZwppNZZKWNA7Aeout/H8V4lZJ1XlZI+pxuyyo2ZgOhF
         MrYZdvXJKF55yERUEbEJZaGKwoOhr+RGQfhDGsduFJjxE114ScjzL8pcI5NKpkx42JHC
         ktMH4HjglnhGj9DL1OEC8+XxB2w3SLcBbAlS7V0pYJL5ljD5Jb4Z5lm4qhQivSBoSuwy
         ikfUuqN6eaXrOvRLLSHVIwYUkN+vKNQYrGFI/7RC1QpJ2RxpYTlcKZOQSlRy4OcM7Xpx
         qVLMizeE4PPz/9sI9vZLJgc7abmUKaiKiYxOAdBkzLdVLlKHATkYDEo7S9DtEVFux87j
         SsIA==
X-Forwarded-Encrypted: i=1; AFNElJ8mG9s5fz+qS6eefsfph6ldo4rORG2zYDRUz7f92hgcjan4geOcaTvM3odRiP+TcUvbZXZXLkbrhml05+oHkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNMKrY9tEWeUnTbWLHlNv6b2/hmiciqKoLTbiwRB5xDuZg1lNp
	gFxxyoiUYus5Fg/uvj3SOooSqgOwsi1MqsONkGe/bU9HUqMVSydbDDppICcPluE2bT8kYXytkkB
	RV1JX6+QszsVlcbA+Dm1AK11CYSzMVG24dslQEHQOUPKR4Tq4V1JeiC0f3A/wKKmocf/X7E4aoC
	JxVA==
X-Gm-Gg: AeBDietDYhxGpbeDEgvK6xREk4b4XU7OacpYRHoXX5QjJu0y5BEZcmCEclebzRL/bx4
	9AddOmWK/D4EkaAdkMPaDd7F3CQdy8lfAxiciZN2ZERJUDmnLD4x2a9+Orvb4WFa9EV5ZhAwLEr
	/xNuhYIml8ZgkE0a/Tx/Bc6/FcOwOgbSx5omre5wWlwzSYpeg6acuenIO4eJvCww2xKBtasErku
	khE34gyc1yfJIfm2CM8JwssY6z9ymqS5onEhz3lA1dTSFjMIYttlnR10NmLW8j4TLY48lSTk9Bk
	jalQgbNG3B+uTD9UCWkwlMEcmJSinnah8cALdLWkX0c8v9soWtwEkHLgSri/SdApKKQ2+ONeGEg
	yCA3JojVaiPvZCSBw+SHLntGDs3SVvSwvXQASJf91/QZAvZbqIaAgf2V637i3w1Rde8q6MZM6j2
	mZZc+qWX7ifRbcXHvj5WT8dBvY
X-Received: by 2002:a05:7022:4586:b0:12d:b7bb:4f54 with SMTP id a92af1059eb24-12db7bb5581mr1624405c88.3.1776812618060;
        Tue, 21 Apr 2026 16:03:38 -0700 (PDT)
X-Received: by 2002:a05:7022:4586:b0:12d:b7bb:4f54 with SMTP id a92af1059eb24-12db7bb5581mr1624380c88.3.1776812617542;
        Tue, 21 Apr 2026 16:03:37 -0700 (PDT)
Received: from [192.168.1.47] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b944bsm21141603eec.28.2026.04.21.16.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 16:03:36 -0700 (PDT)
Message-ID: <ebca61af-7873-4a6a-aae7-151e81b328e5@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 16:03:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath11k: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER"
 <ath11k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260313001608.118294-1-rosenp@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260313001608.118294-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDIyOSBTYWx0ZWRfXxDd02lzBESlq
 pGqU3jeZcHx+xWnAdcrpWWPoPx5dOgFFCb/EGBXyH//a3eiyBCuw1Z2EknBu9KR/H1/nsOZVEEo
 oUfePGBjaRj6JdtEUwS152oI5T4L18tasNA9ttZ40AQeeN+D5FWHFNl9Si0NzeSTPVIWKXv36gG
 6kGnSc81HNdeDLSm6WByf/k7FwssmzhCebea6FegFe+O80DmAQlYSPEwVoh9MUF50fl7GSoOI1s
 N1NiqqwJUSMvZZffRHPDqCgjB1nTpJAWGkEy3eOPvrblLl/xvAuNS10LgXOZFcA9etzBXVPs/vr
 omfHZLFfxtFFX2umMKLRIbL7+awYrzCOZRlMYqY6bJu2UkM9BPraM1QFD0iIWX5yC97/EaSdrR9
 3In9niQv1QU9u666N6y2Q5CZQAXlyLMKI4Of6x4PPcWaFPq0Ct1ZSHmEOxl4Pmp6omXtGQK+SOF
 ylCCG22mHVfqEqwNLpw==
X-Authority-Analysis: v=2.4 cv=VMrtWdPX c=1 sm=1 tr=0 ts=69e8024c cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=rJ_IYOnZYG8bJ-BjWygA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: HxjlBcTy7D55wLa5O32Lph2jqK2tL3r5
X-Proofpoint-ORIG-GUID: HxjlBcTy7D55wLa5O32Lph2jqK2tL3r5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604210229
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-35190-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 65948440669
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/2026 5:16 PM, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation as required by __counted_by.

can you update this like you did for the ath12k patch?


