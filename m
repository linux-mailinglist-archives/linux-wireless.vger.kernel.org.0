Return-Path: <linux-wireless+bounces-32302-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDbLD87WoWlcwgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32302-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 18:39:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9591BB8AB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 18:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 404A9304274A
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 17:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9F2298CB2;
	Fri, 27 Feb 2026 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EpRn98Xu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TahYMuMP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696743E9D9
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772213963; cv=none; b=MOdxw9gbr2Dq5P1IwBqRb/ydHtNefQlBzKpwYZRwP6JHt6pzG6ZWRzLyUs3rR+glEKlxQy5sA/go+sQ6fykiX2gZNgHqbA6r2f/BuH1nBYmja5jzbuBpeCVbmyaAFA0hXsbJtFqGi8/+KAJL9EXAghM6Wo/Jj8rFj9i7f92YKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772213963; c=relaxed/simple;
	bh=SHutJmGIrGPQLQPnoEljl5D39U6FSWVQROvy2jPNeGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cidiWs5Af3RyX5yYOoqfpAX+4OFB4xgSdefvQkaGp9fIR+i8ZTLb2IID0wkNbcy2SzECpfEkmPJ4OiwJuzPESV+MRFCIPJqQFk/grSi9/fuhDrDJU5gQR0lDMJkkaWj6MxX+fdpiT3cfjk1kzMktLjp6FVl4nYhvrKOFSN5vzH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EpRn98Xu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TahYMuMP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RH0HUk527514
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 17:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	99hJgsGdZclQ1d/g6UcsGElD/1YGzCJLcKw5fVo+U9w=; b=EpRn98Xu1ZFYa5uS
	k+ovLEoB2g0QQru5Ymhwvv4oNmmraEW2PGj4+wI4CWv1bUb3aunuTo2OOdpdrV7D
	lLDFvQI+u3W+S3/FHidBixupJ1ipZoIVfSbXgteg81gRSA8P62JKprjReuSwWLYQ
	UNi8MVkqjO+gD0lBi4utsZ8M2SSnONk8WtwCRgvD4tZV6aTMFb1YP8mSMDZIkwa7
	BBomnT0IrUBjZ72vUbqlm74CfOO+PEjMGOSm44Jfgp2mUjYDTsdMHa08J7KODMdc
	VrpyLSXL3285dx1LRltBk3NWSXkMvJG4dzm/uN0pKMLkiNpsouNhqyz+AhSDlsqu
	ZqE53g==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjw23bqnk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 17:39:20 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-463a7f204a7so33199022b6e.0
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 09:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772213959; x=1772818759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=99hJgsGdZclQ1d/g6UcsGElD/1YGzCJLcKw5fVo+U9w=;
        b=TahYMuMPwI/t+NAvBKBbaqC/CQUobLKiVU3udWIbUwmND5JSdki3mPnRwANzkFBpqK
         XuB/WV2tT7vTxum2bD0hZwSQMfTkn9AiAQyEInXwgogcaLJC7KbH8HcJwtb0DeZ7av2M
         MaKgIwfaT0LvZrLRhzatDs5Ni5Iefyis56x/3Z2ZKrJALNz/cfrJndZpBfGdiJ/iJZbh
         JNhbHb8VH2ykWs4hRCUHCegDfUy3BmTnwCjEfQpDBC70ehbeK4hMuwVhTdD9L1izArCC
         JeieHR1Ikq6QIaDU9ie8sqWQJFw6z7j9vcdllzLty4vZ03iLaUoxflsk7n5EpoNh9e60
         P1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772213959; x=1772818759;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99hJgsGdZclQ1d/g6UcsGElD/1YGzCJLcKw5fVo+U9w=;
        b=DLLkUfLlZeiq9g3vkMYsb/RHbkZHEoKPD+QNnfTub5EDbpv0l8wHt78Ozj+RdKwTRW
         WoDbm2Fo+eId7S+ER41nnQJb25Suz/+d+IbAacmuZ84KKtDKBZyglsci+5kbFVDIAIvP
         rsCKH5b7hBN0zbyTnoKe5SsyEHpkpqtKYvaAfKz2825/PB8XD50QTnCI0M6KDsHJOgzC
         g43OWsQZzrsJqxQyYCExB3rQPJeS7DG4KsqxPLKrJs1tXLEnOJx2GCAjD43HTIgj8zVW
         /Y3GjaAr598Ig1VLTdxrLSXqtEpXViMpTiurqNiolusgPR8Hd0H7NT3d51JiQ4JpPGvI
         ncvg==
X-Gm-Message-State: AOJu0Yx79SGDQZDh6OjeHxMj6RE9gGZgMbBHfzi6NRcrPVBbirBlm5n2
	1e5RLhVjuWUEl789nXYJgOWkeA0tIw/IJw21PPI2QMI6oRaULIBCx9tcx4M3YE1JH3f3KmpbGIu
	bTCfgFdKK4hAu3XrjS1rNE0dqsF+OGEPsSVH+qRTSZy7wYqMexijZxc/PHQuRBr7iZ1BowvtI3h
	5MtQ==
X-Gm-Gg: ATEYQzwhhCdU5lUhnodKhAObm80kSacghnib0gGfebZp7E+TbMYG0Wl7gcsfROP02X1
	zfM5S5heEm0Sb29SqZBP9O55WyJYPWL+th2KiRW+xsEXh82ODUzwpYGuvbdFxfAt4VRYeAfDsQB
	Azu886dWyfgHe8/IjF7KwvEYDJDgV8c09OC7yfjy+bSlFj3si/FPZ9qpMJWpqUEgDWjIBEtru3p
	/ApC3u9c66gnrdFRyGFj9KIozBkiz7rzxz3IUUlBWqvC15XhERYijkw3HOpJ5NxJFT6a/0pdlOZ
	tle2kQqOqwJvZc4z0CTC3rtBMklBeWMGqAvDAvh7O5pjoAEwQzhs+EiArKBVr5OD5LLROqNFO9c
	NiiJ6HbPhsSWQ55/PtUK7seFiHFda7rs5M+2G/c2kf0PKu8OHn4xrDY8AxztkYTAGWhENvKGoPM
	2Z2ZDfXLi3/lIk1Q==
X-Received: by 2002:a05:6808:22a1:b0:463:efb4:f9a2 with SMTP id 5614622812f47-464be9e59cdmr2134309b6e.28.1772213959511;
        Fri, 27 Feb 2026 09:39:19 -0800 (PST)
X-Received: by 2002:a05:6808:22a1:b0:463:efb4:f9a2 with SMTP id 5614622812f47-464be9e59cdmr2134290b6e.28.1772213959071;
        Fri, 27 Feb 2026 09:39:19 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb3a78b0sm2429245b6e.5.2026.02.27.09.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 09:39:18 -0800 (PST)
Message-ID: <ee1155fb-013c-475c-a403-0a46f4b3559e@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 09:39:16 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath11k: Pass the correct value of each
 TID during a stop AMPDU session
To: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>,
        ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260227095609.3691546-1-reshma.rajkumar@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260227095609.3691546-1-reshma.rajkumar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: w9SjVsnqy7qRmYixp-h1P76rNWnx-azY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE1NyBTYWx0ZWRfX/xsGioe7MscG
 /VbsB5OjXFN329Bci+qTx+Y56ouew50Rs1pt5y41Tercpq2ZlOgJO/1/hFFTJe9yYdx4ZsMHFaz
 +YjVsEvVY/GDtk0KFMfXufhd5UrB2khPl+sSN4Cm+8Jts6jWEK5UVuBn61ixMAUoMU2vfM74YEP
 k2E5Q4SQWNOnwrRaByQ2buWq7wCRdsu/ti1a9bSmhStcJZ4yv7kiFUn8eq6HXjZM8s/9d9o5+gl
 Qi+eWu6t/LFoY5Gftyxmm2a8mFUc+cuWzEVSy0L/VSz2cz8VY3HXYLYlZiiTL+HVh2V3kyQSc5S
 kKCgXdVMdnU5hPeAVLQmmEZMzcrgA5VVqdZ/Nl3RUDsexUO7l1VGa90T08Zl6NKYvXhbJ33CMcl
 i9C/i6MkpJyfcwIDWUVLH6Jwj9voDmO/6bAk6ue6CmolUx+CuMxO8owSV6E93Ozr9vN3wlG1CgG
 0REGke6e4LzS0sUeXOQ==
X-Authority-Analysis: v=2.4 cv=cJHtc1eN c=1 sm=1 tr=0 ts=69a1d6c8 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=vkfXM0Oplov9zySb:21 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=HumaBrn5Rs-DvhBvfgMA:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: w9SjVsnqy7qRmYixp-h1P76rNWnx-azY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270157
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32302-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AB9591BB8AB
X-Rspamd-Action: no action

On 2/27/2026 1:56 AM, Reshma Immaculate Rajkumar wrote:
> v2:
> * Added QTI yearless copyright
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index b9e976ddcbbf..00d27e0053b2 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
>   * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.

Per current guidance, which I shared privately, you should have removed the
Qualcomm Innovation Center copyright since it is now covered by the QTI one.

> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */


