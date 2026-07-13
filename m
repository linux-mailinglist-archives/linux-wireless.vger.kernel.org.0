Return-Path: <linux-wireless+bounces-38922-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CzUXGBlFVGoqkAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38922-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 03:53:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CFE746809
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 03:53:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=dopDccdr;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=B9TbnIT7;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38922-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38922-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 678E7300C58E
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 01:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC95528B4FA;
	Mon, 13 Jul 2026 01:53:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597D02701B6
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 01:53:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783907600; cv=none; b=cHicpRRG76C719obRPwwm1ijLwH7IAykfp4wy966iCCKx4j+5a9VHez8VVfBflgs7mGUNDCqXsY2sw3DzL/b3cKuXYEiX7f1MQHKV8HKV9XOzBhQ67sEe7ZSeAjFVLDP9cW3S8DGuxDaB7T6ufpp20U5CJJgzwtWHWLHeep1nUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783907600; c=relaxed/simple;
	bh=gzxxIqsvU1KhaRivGA4QzH338KWxGOr7GPNoDIaSxOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MnzGWW2KBdVpE7lTPZIxoPrqxXwEmTPoK+t2SDWT0SOIvuwxuypqmWUKswxKarnWo5pYdc/jaAH8ms6Z4QFoPI/z+QY6v3QL6+5R/ySQSewz7/UrmBGnS2oeBEIvLjN/m6cdItwlSMuUEwFsjfFF5mLUmKrK4RyugZXI17He1Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dopDccdr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B9TbnIT7; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D0kKMo4140023
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 01:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OgGp3BHgcEYylI7heUriqKMavChYYdvTveiO/QZuDII=; b=dopDccdrGv5THr1n
	XC2I8LPcaBuvA7X4bRd8/47QgjlS0pFVXHwSobmzc2ZSmDjCcdMqzHq45SpNBq9x
	uaYDqJlabS0AzJdPsCGY2F0O4WgG0bzkVgqRE/W1KZ1yEEoyUZncxRuNXAKapqEu
	I95Spbno89FGN5bR0kJW9GWLJVWCa1Ajr3/fL/M3jlen0bikbhMUNaxFwyimyP7g
	lEcMPSYBfDp3fsRwIsV8hA/MT8St01/LNNEfKfqIAVQ1aUDPmLgBiHuh2reFn/ab
	CpaQYZqgeLjiPMxWZnBxsDAd1oO3PUw4hUSI5CZcMuPO2sYmLL/AG2hHMBcvN9bx
	ETbi6Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe9hky9g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 01:53:18 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8924f4d0a4so3763573a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 18:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783907597; x=1784512397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OgGp3BHgcEYylI7heUriqKMavChYYdvTveiO/QZuDII=;
        b=B9TbnIT7YxCLxSgZ2pzol3m48QswA6EdHps8uXciBjr1O2uJUT5Ml436oCYbfpoaG+
         1lax2NokSdYhRmTWCqy3gTv9JgBlczau4OZvSAfjRhEjuXmuDt7/d70GYfGzyhCeoVlc
         aWFPDOkMDmcSCWBtELHR3DiH/W82tFTeRXEi6+5iz2sX8K9pCzwylVKWjMSY+GUcxOxk
         U7fR/z+5+MO8amOmPTsYPRahrwl6T6r9v/d2KiubvHJLGJMihUIf7RKBy24Gq/PWV8wH
         QzvV41e69bG8Rg6Mlp5ryj1zSngAqpbQIiM2yn8JK5SkN3/1Kv1kY0osviPAhxNfVF8e
         HhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783907597; x=1784512397;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OgGp3BHgcEYylI7heUriqKMavChYYdvTveiO/QZuDII=;
        b=cdxZoSe0zjRjWqPQH/AxeYFTM3mq4dD0Sar6S95i+f9DkkQFZkcx6BnNh3mbzZgZpo
         X2099DK7EvgizuemRIWKZ6L3MRsWr8sm5rz2FJjEv+m4HmFkr/8eDJvZQaZdDY82d5MH
         CwyjtYFIs/pyc3BFUpsO1Y2lYrQSSHNAZ4E8hzmxBHOlVbGaE+fa9rxsETVVDBLdadWs
         pKph12SLEiO8ypMsG/qO7hF9o6HVY74O5S/PazmOv6c4TwZl82kf9It93weoFsV5tqHo
         zB76wufkANJR8soWNSOqOjHQ70G+2tgtT5l1ybVzvtpYIyChDT+nskjqp7gfK3cmkN2P
         JJrA==
X-Forwarded-Encrypted: i=1; AHgh+RoGOqHTOd47BMMG+Lss/YxsqD8VSxaifDq7jDBQ0+KIVvcfWkEgTnLWYhxTe2UUoqCNDn8Jv/t1L14UMfSV5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKGaKXg1OBSSe+lBJONpVlV1TYgweverX4mh/3sC8mZCthXIGC
	jpYAiuEpJtAdswKKeujq1jFIfqLwqftddh4nTW060XtPpg1qxknfqdP38y94bxh18EPc5pP9sCF
	7R93QX5EdD33aG5hBrBZBFf1xrNcI2Xbx0LEiPeAs6ivPC26Wk/+St9l7OT9HcOpDTzrD/Q==
X-Gm-Gg: AfdE7cmWIdUhurWsxQ8yqNIFHnQ9QMpAtJUYbikjtDHh5bv/2SwaayoRcFUp0SjYTgw
	UCTdgDI/S8rGzw4i58mvaNjh6LNvMdCqzzyvmmqf0MSk31/LSf2IBdoDcjdtJkEGX1Yf3BFIvC2
	RwG8h+lHr5jh6QR0NEfV8TGIEBmOHGtiMwGuD5rixXgBW70r5HUf4UZ75NaqAysIoD0rnjsbh/G
	742BM1UWejHLpZlehrFUZI1Q5H3SdJoStpv0JEPYdGiO5/3GtD2vTdDAs2Mank6NnkcFXhva3Ap
	uJ25bmDeO2emHBXNk5pcFn/NyS7Qz/cAAhbaCmc+XFx7j8AyitL8vRQqA4WHoPbUypY1SAyPZe+
	st9NpVfEKvtQt5CqTpkFUUqEyVtS5JVSFbeSUy3sbbHybq+QJZa4bxYfaJ5aKbxmRO8CImIerW4
	VK3Qf6BDQ=
X-Received: by 2002:a05:6a00:3e18:b0:848:2f84:f426 with SMTP id d2e1a72fcca58-8488976b6b6mr6602483b3a.63.1783907597111;
        Sun, 12 Jul 2026 18:53:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e18:b0:848:2f84:f426 with SMTP id d2e1a72fcca58-8488976b6b6mr6602467b3a.63.1783907596664;
        Sun, 12 Jul 2026 18:53:16 -0700 (PDT)
Received: from [10.133.33.33] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a2cc397b2sm1524822b3a.0.2026.07.12.18.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 18:53:16 -0700 (PDT)
Message-ID: <36ddec64-7712-4749-b2b6-38553f6fa227@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 09:53:12 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: Drop redundant NULL check on devm_clk_get()
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260705172405.119084-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260705172405.119084-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: z3QQm8sy_LrDoN75gX-IRkj4ow4R5GZ6
X-Authority-Analysis: v=2.4 cv=SajHsPRu c=1 sm=1 tr=0 ts=6a54450e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=R6_wmNw2kjsSC7HTpZEA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: z3QQm8sy_LrDoN75gX-IRkj4ow4R5GZ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAxNyBTYWx0ZWRfXzKi0CYfKUjAy
 n9K/uk3Zjt9c6odKtsnImkFAnXJ0XMv6YnNktOVtlbOI4iKI6nJkwU4MEfQFBAUZjAj6XDMdvmC
 gqwJHKwkD797V4zpt0bQKIfC9y5ia9+rN9500mO8DIxN1vjcsRKpvOsZJVCnd7i1uDzUkckgi89
 4z9yeTou2x041axHuw+iH3dzgXSm3vOlg1Xuwton/AvK5R7JcnGIfIeBdsIpIOQIQVRb9Xa8QEt
 X+QEJ/XCnyBFwCHgxJVzaSYYJp/4Bih1C3A811+77+F+7g7AmABODC7ewhKCNbA/KDGwJo/JP+y
 CO80Q0QU+FpJnEIbVBMkZYME/1Q/uCoT7UdTpIz9RSxJl4Yg8ioLo2YpPbnhF84xYgqRKqfHx1o
 ljcQ24CD2sOA6tk5TiTutCmpXas50aS4WQKxce4aanFE7z2tso84Zeebb4C1Clk+aZ369GVObkK
 KLL6/xvp/VYQiOSVtsg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAxNyBTYWx0ZWRfX618C/Pu+E29X
 oOi1qwQ+2XmPw06DFaW80yL7RlaXZH42BxZZd8qUowJZzpVJCKDjMk4QEfDcwmLBvjWNjrPBO+O
 50gv4EbvCnc7uG3z3pwtqx54D8vEtkE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130017
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38922-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:krzysztof.kozlowski@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1CFE746809



On 7/6/2026 1:24 AM, Krzysztof Kozlowski wrote:
> devm_clk_get() does not return NULL (only valid clock or ERR pointer),
> so simplify the code to drop redundant IS_ERR_OR_NULL().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

