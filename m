Return-Path: <linux-wireless+bounces-31776-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC/hMDAEjmlf+gAAu9opvQ
	(envelope-from <linux-wireless+bounces-31776-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 17:47:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA3F12F95D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 17:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F80E301CC74
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1829535DD01;
	Thu, 12 Feb 2026 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pZJdJCzN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PucafZsl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB993329C48
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914850; cv=none; b=uzggyJMsMhV3JAZqSGzmY90EyLStNhLf8z22/3dL/QhG+xHeiWz1IkvB+w48ysK7hJzdsmxDd9gihcJ0cw7xebRq+JV4qn/qEP4RK5orvDmuqnMkNcocDHm3g0TYevVPAuj7dU8Iybzew1Lu1We/GWCcyRID4RSDIZ4fP5TWHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914850; c=relaxed/simple;
	bh=eCvQ9+FhkpmI0Csl0IUjz3P+aVPIgGcZlI8zxNcQlaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDNa/keRoVpHhqxYSUghFlHFPNMJMr16L1UN8B0F7rRUe9D8oUcyjRL7wB/QZrK/UeE8Si3IlO8Jsv3uvixQ10pSgFQjUUF/Vp50kyikdfB+s3GhZXzvz9hXmWIca6dBn/pVCQXZac8nHOfpzzJ/9nNi6MbsJ1aygJ8jzxA/xOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pZJdJCzN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PucafZsl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CDRhRC588759
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 16:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/Edg0w2ze2KH98C5uf/kSLeqd54gdqfT3xdKaOUqquU=; b=pZJdJCzNJ4qUiZyN
	D9Z4V6CXieu/eQnPEEVjMMiY1fPnETK3sTk9KV8ZnE+mmmNBoi4aqxEl+G3lipWm
	fMXsKlYM9nJtEDYY2Gc5eu1pN07/v4TKBpEPvBp/C3zRB7Xq0WLhqDE8h19ezcgq
	YnPrpejae/5q7u8cSp1tcXy+EEsAy+SZ4HaMRbAdcdM8uDtX+3jTyozRk521qIZz
	A+rpjKTNH2YvNdlUY5//xt83S5QwDSCpzJli/vYDLWlYdw+QhBN6kR1EFCfVPpUt
	yKhqxxhqgzXBDeZ1Eg58VBxicXSVSAayOiXu46eaqrsr0mV/efdgteRF/0Ih+yWk
	Z/vMrQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c93snk1fn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 16:47:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ba8a461dd9so32262eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 08:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770914847; x=1771519647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Edg0w2ze2KH98C5uf/kSLeqd54gdqfT3xdKaOUqquU=;
        b=PucafZslXw+xjaEVf3LaeB4VcCk3jJVe7nUNyBLgSBQuU1clhYQyGz9wV3B71seAV5
         ty+++2orR48QDHyJ0fimGCZLyvQGjkA73lUVHO7VtPTAyzR2yseEZv5//JFqEMEVQFU0
         G5F9jQ82h07/V5TAkmamtMSxrqC7R542WTsqA3MAHr/04I24ivJlMmTFbKrip/v85pfd
         6h652cwUFXYL1peM9Oc/0zRTIkbA699gXRS0af5gbs4gWX89E9zwSEMd1nyFYds/VCTP
         9hRUrv6W4tOIKd2yXGDnu3g9dBXpUfd9WJH2KulXxB42y8r+9mkHWf07pu6JOm1by4M9
         luRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770914847; x=1771519647;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Edg0w2ze2KH98C5uf/kSLeqd54gdqfT3xdKaOUqquU=;
        b=rNmsRo/edO1UJzlwPee5EfoH/B0ncvcaRWLx6ci6RjePDoxjlJVicfQkmaAbh4euBw
         k1dIWW/WRWTa/wptDLaIDFoGm0DAKPIMlluVZ3tJoRvZML41BRqIV+3YXFOSnK0fliXd
         /nDlAscFznvsYfDMQ1A0bZAnuy43WrgrEhyAOc16lNaHP7o44jBKfoQIgbOzKkmL7TPo
         ypGOCPXxKk4yQH8vzka2QdOH96bhndOomFcQVgPLTPUTqmqu3Q7kD6dIkeLTQAJg3E9T
         1BJGe8vicxfma2q8SPoSIzcnfyNvjLaejJf2NmHRquTG9AbuCLB0vaYVpJPlqSJtIsft
         q3og==
X-Gm-Message-State: AOJu0YzLX0ACROVITiS7KfMzwtp+WQFB6/fQ2LTOAinq19XIpJiROh1K
	mtPelzexwxDS2grhVBtxJQDHWYvw6ljRkGUoRfIretpl66RCr63rGhqMG9upJc+y5r4pR7uVbD5
	9lP03zIYJIKsm9Ou9bZNRgua7ZAJTpSKSXTMchXNBUEGtSyABpq7PTm+7lAnz9ZNhlGcSJw==
X-Gm-Gg: AZuq6aJgzHZYCShsmX6yhNCeRXNayn5Ec8GlEmIiffEQXm+X4NFc55c5zyal+9wyTP2
	v50YCMiABHmbrgvIVdgOLfEU4XOQQkg/Rk/MHDjJNYUH7jX/6Ahom/d7GmPnhtFb5IBQeK8tnN8
	NNRjhjC3tz6+09nPse7tbZPBUGGZyTq9Eed2hdDVhoj8us+9w+HZqXkJyecpvvWKK5WZ+GQQW1l
	IksZH6seSkDEX+jogObak7FjOceRyoR/a8b4C1W7T6iljkNb/6LclL5n1rfFiJpRbOLL3uho2jk
	1Vm+2Gf0dUd0CMfseNzeCuei79Ljaq2D761InGYVmnqgpCEdYsjwz0bSC3BHMSQRxOPl0pJexw8
	R7X05DjpjWYe3ZG5S0TCK8MW8su+ZWDUgLY7ngAxq/hXBSeBn4KVNznmpr1Q7l9Bo0SfPr6D8nX
	VD3nIWVH5RH9wzBQ==
X-Received: by 2002:a05:7300:3211:b0:2b7:ee0e:e9ba with SMTP id 5a478bee46e88-2baac5939c1mr911243eec.10.1770914847363;
        Thu, 12 Feb 2026 08:47:27 -0800 (PST)
X-Received: by 2002:a05:7300:3211:b0:2b7:ee0e:e9ba with SMTP id 5a478bee46e88-2baac5939c1mr911231eec.10.1770914846776;
        Thu, 12 Feb 2026 08:47:26 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcfde2csm3915084eec.30.2026.02.12.08.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 08:47:26 -0800 (PST)
Message-ID: <8d244744-9897-4c12-8590-423b6a8b1f0c@oss.qualcomm.com>
Date: Thu, 12 Feb 2026 08:47:25 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/4] wifi: ath12k: validate survey index when
 frequency is not found
To: =?UTF-8?B?0JzQuNGF0LDQuNC7INCb0LjQvNCw0YDQtdC90LrQvg==?=
 <m.limarencko@yandex.ru>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        "jjohnson@kernel.org" <jjohnson@kernel.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260209030243.1530075-1-m.limarencko@yandex.ru>
 <20260209030243.1530075-2-m.limarencko@yandex.ru>
 <a4d404da-c8c0-45c5-9097-42280c4891d6@oss.qualcomm.com>
 <1277331770898332@mail.yandex.ru>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1277331770898332@mail.yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEyOSBTYWx0ZWRfX0M+L2Mdnvtng
 IGl1oXQkFDS9zBwqctCa7kMiAMQX4F3oILefwJzOTzqqHb0ZcoS53G9TtNPgdS9QOd4ufe9yPTU
 DwinV+Wkp1xmUr575D9dFSf35hmat3DS7JbEhDAvaqWeOpkGQ8NVcbuP+xgclC0XvGyJWSh6UxI
 FyHThcVbBuDkxKItvltsvW+4ninuYTKhWLrn732c+a6Fu3VY7vaK90GK4KfwjrMi2KudMGG5zhL
 FtJo6jILVdznbWC9ilnyckWkW7O4FbFGVfFz79JQnmDoEwBPf1xQEeZfJ1MtoRglljSt9M9wgdZ
 wobNuL6UT4kfhuthOzPdliLXtFD5HpU7VgpMIMCaEGTMv1Roa1mSkrnDOniRlLi9nIn+eKHmD4T
 yKkyPsPqj3VU40uPMrwV/TD9F7BAUOu4MaO47x5cvJ2gayI3gdJHPYAmGM2oCfzm3ku+vPwEFRe
 5ywAbdOpsnq6KoMRHsQ==
X-Proofpoint-ORIG-GUID: f3eqZVvrwK_USINM4yn-3myGir2pVRhy
X-Authority-Analysis: v=2.4 cv=dLCrWeZb c=1 sm=1 tr=0 ts=698e0420 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=vaJtXVxTAAAA:8 a=IME338mV30oL0--k6f8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: f3eqZVvrwK_USINM4yn-3myGir2pVRhy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yandex.ru,oss.qualcomm.com,kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31776-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4EA3F12F95D
X-Rspamd-Action: no action

On 2/12/2026 4:12 AM, Михаил Лимаренко wrote:
> 
>  Hi Baochen,
> 
>  Thanks for the review, good point.
> 
>  You are right that the current callers already check
>  idx >= ARRAY_SIZE(ar->survey), so a direct OOB write is blocked there.
> 
>  My intent is to make the "frequency not found" case explicit in freq_to_idx(),
>  instead of returning a synthetic index, and have callers reject negative values.
>  I will respin v2 with corrected commit message/subject (no OOB claim).
> 
>  Thanks,
>  Mikhail

https://subspace.kernel.org/etiquette.html

Please don't top post and don't send HTML e-mail.

Note that lore.kernel.org doesn't archive HTML e-mails...
https://lore.kernel.org/all/1277331770898332@mail.yandex.ru/

/jeff

