Return-Path: <linux-wireless+bounces-34364-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMdSOEvl0mlecAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34364-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 00:42:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8212D3A0041
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 00:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69C77300F5DB
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Apr 2026 22:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AB5382F0E;
	Sun,  5 Apr 2026 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZYo+AyJT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QQg0THQw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB8E2DECA1
	for <linux-wireless@vger.kernel.org>; Sun,  5 Apr 2026 22:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775428922; cv=none; b=V9AldzY4ajnkcLd/m3lUh78+HYUwW/lVwBdmF5uCP0aqClp94wSUBYbS6vRrHFo8ylK0PJIbKOXqUKt9YPeAHVjR7XrNXyW2Mxg/tVpRPmQGkpmHqtO13IWa+va5mw/OT181grSJzAWpx3OcFNPQ51ry5uNP0wHu7TM1H6RJViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775428922; c=relaxed/simple;
	bh=ZYwBfPbzxvAcO9wNEIv1uS7MZg/5/tJ7dM0qM9V2B68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TreVnEyEXOD9sjQkRIFfBmNHsMsWQAQlUe9r9POW1VB07uxwQTqZ8IrEYIMJCftawwitK4nNI+RmzcesTua3eync8sQor3/sNfAnGkCmktsKK7OtfET641Vvlq3FMGprSyDCoT1RVmIapXiDU7D3G0l2YZ7b2DRVnPZ9UNaTdqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZYo+AyJT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QQg0THQw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635Le5aa767927
	for <linux-wireless@vger.kernel.org>; Sun, 5 Apr 2026 22:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nV0P98lyDdzdwF7jAXLCXCBbvBHVzZd/AEsYBJrQ12c=; b=ZYo+AyJTFEyylReX
	K5VtAcGHMnD7MaIrxRHkzfeKzMf5Z2goztsBRcsjDnR+NvO8x376SytupI13qs+B
	f/ce1Q9Mfx1bhD0TUv0vf4HhkhDVP8Hh7gJnmXzNOO4YVrdqjG/WpnT2I3wveLrU
	xEaoH94xG0hN3gzlXHizm57B22NnyjbnViPjssJoXrqM3KWjiEpsfwRX0rjIAjKw
	VznmM0QjVHU8adYqUDmgRhCH+9EB6mGMBispXgklJ/ohclERJT9Sp9q+kJWcT3GD
	phO0o2lOlEA++6A0qBt2GlYnV3i/b5meVRkwLGLPdQ+7F6SODjTrpNx/G9Og/Dtu
	vO+u1w==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dasyfkark-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 05 Apr 2026 22:41:58 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-12bfa367189so17320700c88.0
        for <linux-wireless@vger.kernel.org>; Sun, 05 Apr 2026 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775428918; x=1776033718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nV0P98lyDdzdwF7jAXLCXCBbvBHVzZd/AEsYBJrQ12c=;
        b=QQg0THQwJJ9xnRbHwQT8UYCEyTyb3gXioaU7N9UMZ8/IyYcS+5/I32wcWnYZL6J8wz
         WNCzOCPEZasHnpExhlHwBeKHsSSThgi2cZk2mElVJuEDaXp930vkcWABTGbBPA9Hmb6Z
         6QsKQND+HWcDcjUE8IMnerCllnYoN0uCTDt2hw4F1CEQzVcQyKnyAEdYoAG49ficRpOM
         /u4ksB6i4wuHnuRGsLNsX+Okw2bcEyJugv10yn88WIKZkmtqHTyoKUragHDuxDw/wrMD
         cjzwrMCw1N9Qp1sdeQfPN4Z3SpQPIs3Lva5qRLJiUZNww29Z6F+euiUzfH2MXdE6vRzV
         2KSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775428918; x=1776033718;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nV0P98lyDdzdwF7jAXLCXCBbvBHVzZd/AEsYBJrQ12c=;
        b=sUblQ3O5KTGLukjAbrqYqYax7lJjfaw1GGMJPntyFb4A6SFrRXfyTiBcdISiWYXmJU
         NeVkKB+2+5pS2EnW9IRkJVLVQ7HRjgaYumueU72IxX55G7lnJblOiWhNec5FgOsKmjDK
         mBaWZMnPIkZ2ABELFabEHnViM2ibz11j3NqTCJsSPU4nH12nWqgbeB2AKppMzz6KcLnB
         OA/r9X4+5KcoBqOVQ9WJ+YOtGZSnhg53V53d7S1ijkzVNqqCTK1AKWy/a8J6TCrs5FUi
         kd2NzjyNyzp4cQb2uUb37JqR+e05jVnBOZky2mtyglxoE0GAoC+ZUtyAStHOtgPeQtXh
         VbHw==
X-Forwarded-Encrypted: i=1; AJvYcCVw+QJT1LTSshgaCnzNDMLCWBOO91CKz5GD6HgZPLJliVfdJUKGOqcFTMilqYcLB8wQef0MjXXfKrWsNm37yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWf9rh0DKuiB0YeYh+b0pIbAkfMZc0bR+WENOS0W51qyDXrpE1
	k3yVHLjR1YKhb9NclOSPMT+vrbO/vmVZehfD03tVLijp4CDjyawZ0xijHniiN1sKUHFzqJWD7tR
	bHwr6Rx5sRIJR8novbhtuNrpmGd6Rct0s2spYzRrHzb2TIm2QjBDp0d+v0LImLYmJ1NedOA==
X-Gm-Gg: AeBDietem9eX32qsHe+9IxRz384xbD4Kxb2hw+rr+PQpjFivAnSXnG7iqQmeXmFgnQh
	syiezlSMld43JBANFQBwiPY3+oqFwTbhG7XreleFMXZVQH1+3KkLiofH+dy3AsacAoApZgVui7j
	mw2InrCWdW4bEcOh3GT++enQ7pFJYXMpHBgo0ZD0hceAj1Y4QTOFPJj3psslt7xrnRY3/J236U8
	nDyv9KoI4U7JQJUoqSa0D5HDGIwO8Rk7ZbMz1V8l0HZUXkuABVMwMg9l5dC9jW12cBgr19loSAs
	+5HjNj2OPSGERI26vFExTzk7te1zwjcK1hnacFdhThjMjpTaD4hLcozFkJ6sVhyhEXtFZe0JdWB
	w8VkSokU9guHIwDq6+U/oN1ABCRepjcNn7KoCOQLHg+uH9xdsVF3YhP3sZcDeDDfWziuC1w/h/Z
	tkSB2PhDEGpMl2Ug==
X-Received: by 2002:a05:7022:ec17:b0:119:e569:fbb4 with SMTP id a92af1059eb24-12bfb770b25mr5167891c88.35.1775428917882;
        Sun, 05 Apr 2026 15:41:57 -0700 (PDT)
X-Received: by 2002:a05:7022:ec17:b0:119:e569:fbb4 with SMTP id a92af1059eb24-12bfb770b25mr5167878c88.35.1775428917420;
        Sun, 05 Apr 2026 15:41:57 -0700 (PDT)
Received: from [192.168.1.44] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c07a8703esm4325942c88.8.2026.04.05.15.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 15:41:56 -0700 (PDT)
Message-ID: <9a3cbef9-5599-48cf-8307-3114ac2de704@oss.qualcomm.com>
Date: Sun, 5 Apr 2026 15:41:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 4/6] wifi: ipw2x00: Depend on MAC80211
To: Eric Biggers <ebiggers@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <20260405052734.130368-1-ebiggers@kernel.org>
 <20260405052734.130368-5-ebiggers@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260405052734.130368-5-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDIzNiBTYWx0ZWRfX9qeW1Te1DxXv
 Y/HxNxv6Q0g/wkkYsEE7FqkOzDfidQ/343vpWv/Mk3DrVnl2GHeBYtE9gcLvpASjbUnhGuqnleW
 PflbzWQIuGqfZAmSR9A9O5jcjyL3djllX7yISnYclRDxrLSnhudAyzJIVfTJqVgbYJndQM5eIdP
 O3ylECTbtEREfIrLQs3aR/7udFfBgRxXhfEYruUC3taN4FlnCbvMKh5z8Kafg/htuDx+QiAlIFA
 mJWuONcIjudXhz1ZYD6tMEke4Rvy8yv7aLzr+rWxH2THuMLuKuo76IHmuCc2CI1YzxC+RMRvk8d
 QSUuiapXYMeuxvAg3pKtJg0z6WYxxCRaGqh65n6YY0DrZdojK0HgP4VhUOrZOuWWswp8EZB77DB
 7wL36I2KsyQpHK9oQPA/cGvjxh9bXeQeL9MmXn/RRyLSrKL83wNgpLjYPsRoIsguSJbrDwqhv83
 Nzvgi3t3godV6hOjTrQ==
X-Authority-Analysis: v=2.4 cv=U5qfzOru c=1 sm=1 tr=0 ts=69d2e536 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NS484S8f6nxxdAqyviwA:9 a=QEXdDO2ut3YA:10 a=nGxtSMqkhFwA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: 05zuJeM68IZOpQk9jvp8Eb3br_n_ETkf
X-Proofpoint-GUID: 05zuJeM68IZOpQk9jvp8Eb3br_n_ETkf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604050236
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34364-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8212D3A0041
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/4/2026 10:27 PM, Eric Biggers wrote:
...
> @@ -149,11 +149,11 @@ config IPW2200_DEBUG
>  
>  	  If you are not sure, say N here.
>  
>  config LIBIPW
>  	tristate
> -	depends on PCI && CFG80211
> +	depends on PCI && MAC80211
>  	select WIRELESS_EXT
>  	select CRYPTO
>  	select CRYPTO_MICHAEL_MIC

remove??

>  	select CRYPTO_LIB_ARC4
>  	select CRC32


