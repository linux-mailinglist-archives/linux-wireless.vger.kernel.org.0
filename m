Return-Path: <linux-wireless+bounces-33310-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QALeAsZhuGlbdAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33310-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 21:02:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D99C2A0007
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 21:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A89D3017AAC
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 20:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470A334F244;
	Mon, 16 Mar 2026 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lk0qSiLR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q5rNQVq4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE5232D45C
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691327; cv=none; b=JXDiTdJnc/sA7OzXd8DKpTRwETTkCl5qz2+8HE/sbm4k/x108K9rsjRyE2k6KUOLPmThaduqZX8krQJySAYGYUqC8eV1uc3DJRFFIr+4P45exK/Xwu1UQvLFoW0qzrZuudMC5vy5YA3HoRpEq92uciwrL9oGbI9ofWz7meRypD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691327; c=relaxed/simple;
	bh=36n0bi4fVRdSzw2/ckM1WfY6jFeDjYHWHstRyrD5L+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvKAi/gvnDlruAeL+YINA+Tf+k5SfACkywFhQYFs2utN6h8eDlZQm3Vx+wu4gn9hmGZweIQe2R68mjqrWz3Ppa9Tm4sfuH/maaLlpd/W5iKfbsyICso2rKMC5GyD2/BIzTx6SielYooHUbX3g8pO2zMqZL83HJ4PAcFiloFUcC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lk0qSiLR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q5rNQVq4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GE7wTM2375005
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 20:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HQ8WifFC2j/bvDha3tINklH6CxSce1xbV+4Y4V4qj7o=; b=lk0qSiLRMJR+ijD8
	XRuWzAePKAzhP1ahOeQuHNnkkSoq01jPC7DzvfeRxfSEgcSA8d2bjWGRaBolv5z0
	9unnHLgJ2z4Qw9dweFCnbVYjDY8lCHADkqQZt52fwL4rJxdDVa5LecOLd0ZnWBLY
	7oWaEhvHDviQMLrAAMg2Hw0QpRyDhjAXO6e4M6UVol54LL2PcndeXWFwsQQKdljD
	eg0OzttNu1OgWo4qLAZ7/6tUu9aUcDr96WrMf+zEBqgrbGBCchYpICxfjFAevJhw
	N0ayLZS3LLlC9ya6jtQ37T4r7z2uoslu6711qzKtjAMKb/3q8uPkUdaCAEN4T9UL
	CXfE2Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxkby19ek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 20:02:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c0cb775215so17504786eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 13:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773691324; x=1774296124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQ8WifFC2j/bvDha3tINklH6CxSce1xbV+4Y4V4qj7o=;
        b=Q5rNQVq41CRZz9TgI6WD1DfiJw3CMt9Yt2zq+wrgnt/xw2gpmNX8xzecmunM+rooJi
         ntrDE2jEA5phHqDq+2Rxx1lAFDLcFbMP8ntRKVxmavJAKU91JnFZQxvruN8Y5DL/fhU4
         KcO0aEuC0MvlZpTCxCQdeNraAs+caNtdy1ieitsV4qj/W9kOTnG54i8wzt1J7p/EDzmQ
         pZ3oXHCroQmW9TYJXa4iMfs5TCnguxvVLaKPihtWQkxjiHUvWo0BG/fWt1SA8MukcUP0
         stw4hkFHWGR7DYP3rYewcjDiG7GjhUxvb9WzY9Qgrf6lwxA88QoeOGDvD3vuC9qj3ULz
         gsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773691324; x=1774296124;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQ8WifFC2j/bvDha3tINklH6CxSce1xbV+4Y4V4qj7o=;
        b=L6ZjN0p5TJfgiWYpl5L3FuTyjm9CbkRFHx1u+KxP4D+Hg9BrIY/1Zgnw87w2Tst5je
         chPHM23gcpeyJMApgUdYkxzFWRv0s6folR4HzjN1iDyLI4GH2Id8AzHrIHTG6LNAMisR
         hmsIi3bMz/R6vImfQVM5ZLzgQQpTvjrQPfrRrPP1LegLbGEgGZACRzpXKtL2k3ZYW3oO
         Y38FvcBEklT6PBA80q7kne7rwYIZyytAuQbgKl4KjIueEqd7qaEfs03/FBCNprGJywGs
         80eERWhKSHWYh1s04K8ZN6igZ/Rnc/IwJiHJ7Z2jw04jhBx6a0cId5yolrKZZnkfRt0x
         wg4A==
X-Gm-Message-State: AOJu0YxjFw1k80RU91HH4I4Uy9mHpSkvQSTRBmpLsWOf8XO08jx9rkV4
	HjIMmjAnzs823m6ihPDiK7i5MXLJH63rbdjj+8Kf3U/g0PGQqlbIF9oT0+9MyGR0DBMPhU9HDk7
	eaO87WdGyRaHwog4z1XeBalLPmDsto5RDXGlep2dVw4wlc2ZbjKff5yolbvNK5/r39Gvl1stFBC
	aulw==
X-Gm-Gg: ATEYQzz5AmDGNGjJqETkbMd3TLy+khmKckNN+m3Go5A2cI+fzfpT343f/SIWI03lg6u
	onvEW+XUq73zactxb8VCw6pyC7n86BuOP7xF4Bk8jLMlAM5qdlKSJCJ4dYxui4imYQX6xbkAdE/
	bQeLT9CfHlLdBGorRtb/nepwa2vOK3Zs6mOU+VtyTth+Ns7S8jIscE2SqxsCtSG8VQ7FIeTh0eq
	oDo0w+TKFoplbQQhJhNZRntLAVJjLEp3Hhfc54r5qECQ4Bac5pQP/edMn16CP2xgC3lX87S04wQ
	9SotJkeBaomAy3fu5nsj1xoUfCjzk62XXSZekJ9YP+BZTuuWjdql0EFGThEnnF79uB2NJQ5Jqex
	OJlCMGyyhbw5pRuesHr+nzhLWBlWoY9vY6gObTrnTLXj1qLy6uasAlPfSen2Fje6iOsVhtrFDbC
	FYGPuJriMoqxZeIw==
X-Received: by 2002:a05:7301:d8c:b0:2b9:80c1:bb5 with SMTP id 5a478bee46e88-2bea572a4aemr6611023eec.33.1773691324261;
        Mon, 16 Mar 2026 13:02:04 -0700 (PDT)
X-Received: by 2002:a05:7301:d8c:b0:2b9:80c1:bb5 with SMTP id 5a478bee46e88-2bea572a4aemr6610997eec.33.1773691323712;
        Mon, 16 Mar 2026 13:02:03 -0700 (PDT)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab526d61sm18944609eec.17.2026.03.16.13.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 13:02:03 -0700 (PDT)
Message-ID: <3c3a6273-1b4f-40c6-ae59-11a4706ac86b@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 13:02:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: ath9k: Obtain system GPIOS from descriptors
To: Linus Walleij <linusw@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Alban Bedel <albeu@free.fr>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@toke.dk>,
        =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?=
 <kernel@kempniu.pl>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        linux-gpio@vger.kernel.org
References: <20260313-descriptors-wireless-v4-1-07ab47c89a98@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260313-descriptors-wireless-v4-1-07ab47c89a98@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VW-KOVJUyIljCL2M0aNKoVdxmkf9LCf-
X-Proofpoint-ORIG-GUID: VW-KOVJUyIljCL2M0aNKoVdxmkf9LCf-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE2MSBTYWx0ZWRfX+V7ZksJxLZrh
 fhmiRqZcJEJXPySEIp/8c33r7MfFabsqhEyoocFix/yuiVbwCi5B4lp7zaDGoamVFjhARszuugp
 ARWwPygNLWI4fn+cvJ1fbeM1kSB2WK9sEXvrHhxaENSXyQuIhkPTJOTK6u1/ixmafefr4kHfiaF
 dZPqBTzYk90hDqWYcI1ULQKm65hvP11imYYaOAJBkl0+fXYetvWZKsooL1auNECzZKyVXs5enQ3
 SawCBc2xQI3B51P8NRP87wRhTiPe3RyYnlCNeCR5aGor2IoK35r/ek/7Ky9e8QoXwX33c7eu8D1
 1Rdh4mlisahu6rNx18xeXZPU9jKybR8fRZIiiX3iuSgPWfmupYyILiFxlELg7bj5HsbtK/wjIz4
 mvkHpsB29VdfmTnzSVJN3nxApp5UVkPppH1wHFqY7tiQsbFjQbl2Dc9G435QSJxtq4jSnsm1iuM
 kA5IeEV0Pwn3RNsr3Qw==
X-Authority-Analysis: v=2.4 cv=ZpLg6t7G c=1 sm=1 tr=0 ts=69b861bd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=vSgz8sLpNFa1Q4fVfdwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160161
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-33310-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,linaro.org:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,arndb.de,free.fr,bgdev.pl,toke.dk,kempniu.pl];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4D99C2A0007
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/2026 2:53 PM, Linus Walleij wrote:
> The ath9k has an odd use of system-wide GPIOs: if the chip
> does not have internal GPIO capability, it will try to obtain a
> GPIO line from the system GPIO controller:
> 
>   if (BIT(gpio) & ah->caps.gpio_mask)
>         ath9k_hw_gpio_cfg_wmac(...);
>   else if (AR_SREV_SOC(ah))
>         ath9k_hw_gpio_cfg_soc(ah, gpio, out, label);
> 
> Where ath9k_hw_gpio_cfg_soc() will attempt to issue
> gpio_request_one() passing the local GPIO number of the controller
> (0..31) to gpio_request_one().
> 
> This is somewhat peculiar and possibly even dangerous: there is
> nowadays no guarantee of the numbering of these system-wide
> GPIOs, and assuming that GPIO 0..31 as used by ath9k would
> correspond to GPIOs 0..31 on the system as a whole seems a bit
> wild.
> 
> Register all 32 GPIOs at index 0..31 directly in the ATH79K
> GPIO driver and associate with the NULL device (making them
> widely available) if and only if we are probing ATH79K wifi
> from the AHB bus (used for SoCs). We obtain these offsets from
> the NULL device if necessary.
> 
> These GPIOs should ideally be defined in the device tree
> instead, but we have no control over that for the legacy
> code path.
> 
> Testcompiled with the ath79 defconfig.
> 
> Reported-by: Michał Kępień <kernel@kempniu.pl>

Are all of the reported issues fixed? I cab add either a Link or Fixes tag,
presumably referencing:
https://lore.kernel.org/all/Z3t6coHFgd9PBCeb@larwa.hq.kempniu.pl/

> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> This patch set is a long standing attempt to get rid of the global
> GPIO numbers from the ath9k Wireless driver.
> 
> Maybe Kalle can merge this to the Wireless tree if we agree on this
> hack solution.

-Kalle since he hasn't been a mainainer for a year now. I can take this
through the ath tree, but would love to have a Tested-by from Michał to verify
that the issues he saw have been addressed.

> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>


