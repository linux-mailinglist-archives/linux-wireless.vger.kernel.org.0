Return-Path: <linux-wireless+bounces-37862-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DOgZG5Z9Mmr90gUAu9opvQ
	(envelope-from <linux-wireless+bounces-37862-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 12:57:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD7E698BA5
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 12:57:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NTFUW6Sy;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="j5THNKr/";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37862-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37862-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C8333329A13
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 10:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F9406287;
	Wed, 17 Jun 2026 10:46:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3F1346AC2
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 10:46:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693192; cv=none; b=dRA59wfykCtbAVTJKCxXKIq/+LMKQKeV+/5oikLxYSn6FuVPuxswJ7HIjvLeMQmafRg3yq5sj5oMfBFD8VxhAJ1IJJd9rE6JWvTIO7JC7vw7eYp9ubzyl6JiphfSy1BwRap9jLh0IXgci0JFNuhFWRCmkrwt8um+Ltqs2dCx7O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693192; c=relaxed/simple;
	bh=tkAEUA5OxX3j3Lit/V6dTiJdu6f/BbYFwiY/RkMX5zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=muQw5SwVZ1qfaVQgIjSEOhVSYJy9sM5Phr7MS5F6mVtLtkKboDunnS3X01q3O2YHM1FE7WuX/sILevLXbwJZrN8wBQz0p+4I11kUKyKjUhNtRNMkSz7h+ImaAdVKzfHANRXcfc5Sx9KIay55ijMTZofQ4I+iCPPyV+xJmLb84Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NTFUW6Sy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j5THNKr/; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8UlC61607951
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 10:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mNrGdDE5wIcEcKZAB2cOApd88y9gCStNjjCMJgqaBk4=; b=NTFUW6SyPyQlqpM0
	eRxetGpx0Bey2F8789sepoc5vGnzV3R7Dx7+FLDnTuOdjBPHhnNsgZB+7JD1TEu8
	GJlwJZN60NLoam4a7RpEGEE3ZgNyvQdrVnDvtkQ/rLidMlK4BctBb205w1lES0w/
	d4dtfR49OdnB4Qrljw66h+jbl8dPlP2vF7+gAiaJ5uNrucDP5YAVbouxWcOcmEKc
	GUKQmtHrZe0TC3bbL1QxAA/+ZlZ5V7ydPoqgzL4AyHu3WcWbEXSM9u+S0HYm7S/8
	EolR3DNKQU13xdeYJaupj0N9vZ+PzsyZQixtsJZQgqfuMJaqEZGtfpg295t97tXr
	ZvG+Ew==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef22p7y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 10:46:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-517741bcc53so13699631cf.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 03:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781693189; x=1782297989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNrGdDE5wIcEcKZAB2cOApd88y9gCStNjjCMJgqaBk4=;
        b=j5THNKr/wpOMaBJpNdFHoIbp8FoL8NXXaLN9mNfkOSUbw9ZWWoEwoVb0E8yS6+K0CC
         kLbny9kdieYkp434bKmssmr4sqY8YTkrjrCF6hDXO1CEiUtQuicgu43dNpmC1MO4Qvq4
         PSaTpkylN6ooXTEJ+Co6EmhQsxsDLD3/KphpNm4GiOSJENxT2N4sxyyz7cwVV7IwWTmz
         xwXBSUfylcOKW6HyPFHESKUy4b6ummFMaPqskoXrv+FmWOOo+5C+grEEAz+ab+IIrF6v
         WUZbaiKjk1oif2Znq+SdwSto4JwUDxn8Jin7x+PoAV5rPBAJFxbM1OejBeATdnfDh49E
         3DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781693189; x=1782297989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNrGdDE5wIcEcKZAB2cOApd88y9gCStNjjCMJgqaBk4=;
        b=ZH/UYHbKosQqX6Oh0NbfEEngfZYEuFmHcPUFnI4VsBlujfPUi8oIdNhOhw0EGr996m
         2jOK3nWW//VzBg0UIqCtoPZ9itCuBcAHvtvqGk5KSqjiXUOqcI6+GxQ9x/Ifiq2OxZpP
         Xatw+WQPyGNVwHuTYpVGWNa8rwgsCwnQylM5cJII4FBU0jE40DhtWWbVeDQFMqgaKQz5
         QIDWYUInNMTtlzwUqYsDsOKIaHZnNiR6JTa0+xrn4eWKblda138Ue+7OIrQjs6FV7QU8
         SD0wgvcyUxiTqoOVYjEqlJVG25p1iYbypE7zwwfqVkS2gyu4jjclFKogq3ks7+xzrGV3
         RP+w==
X-Forwarded-Encrypted: i=1; AFNElJ9aaxLGUu9lGVL3tLZDY2UnFN3mqXsD2FfU/kVF+nFjDcP3khn4wTLkAJHxIoEAhuwUNqsLgiY0VvmKtQ+F7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfwDjOoxaXSyiGhkdkINH7ov/OVGwYrsUxHaYN2oZumRHbQlZ7
	kQhGQF5pQHVlJ/FUfSe+QJfmI7aC4+qIxqdpxWGEdVMz//zZl+bOpICMippRdh/yD7I+7Z7TPvm
	aTi+RbrcBvS/8V00w8/JYb3i/nASflVjmlH5onFvL7dZ9wt1CYv+Lm3hDgdIyAIzAftMopg==
X-Gm-Gg: Acq92OHRsQ8fxKlUYBIhkeMPkI9bZcp08/7DwkKjGZX+D6hOyxMQ0QS2Xthg/k8dVSE
	4v2pPxegBVet9SPiu879rnPMSaSvwpxeIO2U+quUipWsHWRfTBdfIYeDx7acAvuyZfNIdBKTvZ3
	HQpyRHfArZjVasAx+VxtKMQwUf3n0+a/fDfTpBIjZNT9prVaouVKnbeY52JsalF8H+DjyowTF+J
	7h+HWNyxFAA8LFV46Vy+fvLTjeMojehVdrx0nw9HxCBuRkEyj6nNizMVxZtSpVYn80xiDmCkjMo
	Lku/qy109ckvttgZFZjTn+4LEMO6R2kMf5P3akW1kwmaFTQrV5Dj500B943iQIQ3iFKrOOsY7sJ
	3A4DkT/qwWI8PWpKDRPnTCrocZ/kUfsjZ+wU=
X-Received: by 2002:a05:620a:c4d:b0:916:10f6:765e with SMTP id af79cd13be357-91dbc5298c0mr258844285a.6.1781693189468;
        Wed, 17 Jun 2026 03:46:29 -0700 (PDT)
X-Received: by 2002:a05:620a:c4d:b0:916:10f6:765e with SMTP id af79cd13be357-91dbc5298c0mr258839885a.6.1781693189023;
        Wed, 17 Jun 2026 03:46:29 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937948ddfcsm6244840a12.21.2026.06.17.03.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 03:46:28 -0700 (PDT)
Message-ID: <7b5c713c-e00c-410c-968e-56b9f487211b@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 12:46:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-bluetooth@vger.kernel.org
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
 <20260601-sm8350-wifi-v1-7-242917d88031@oss.qualcomm.com>
 <955691e1-e40d-4584-861e-8f29db4ba8a9@oss.qualcomm.com>
 <dz4qovpquxgynnzviqg6g23oa2o3trlkznremnmlqfnlj3b62x@oqgcuvalfcph>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <dz4qovpquxgynnzviqg6g23oa2o3trlkznremnmlqfnlj3b62x@oqgcuvalfcph>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwMSBTYWx0ZWRfX1lRd8Bwountf
 Hi7dWYWQQxEl9BXMyMipOXNomoxLhQHr4HDAgioXYABjjFJDBbDt5OYyYP/45I8owe5UZV58esa
 xhfJWNOMZnpOP7GMjLdeloZ81coKRmo=
X-Proofpoint-ORIG-GUID: ne4SqHd6gQRg6Wg9Ihe4V_iFnuFF8-A4
X-Proofpoint-GUID: ne4SqHd6gQRg6Wg9Ihe4V_iFnuFF8-A4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwMSBTYWx0ZWRfX3gpTnyMConLr
 U8nHthiHx9AoTwFk+YhG2DX9yKMV7wEGPo+IdA1rxFgotHz60wliOgYMvNkrqRkxeKvQrfrXYMW
 AWD/Ebpz3tCQB9KZ/hx9yqS27amOHsCgAjqrZCUQfFigaEa4ucgXqhIK88htDHCvZTUwfDoSCFC
 k444wUuXr6Qw7mcSCGmGc/BjYoou8hhNjWUedfNs82BylbPzUKQ78G/QFJtFxCsy4ZhwJzILeXk
 TJ6J+04VFz24LBuXO1dPw3UHjd868o8yU+3D2byheOG04HYe9FkacpkDYWTvR7cuX7ucmpE0j5J
 D919QegT63/U2z8gtMHTL1Xi5+jEzc2uZ8SHKFdGiNWvdxcmjYfxIUuh0eTY+4P8dFuFuOJFmgu
 v8wdWJ4DK7XVyL7Xe9UNEi2uNfNy5Ru4CJ8AqiRInjCCHSSv0iQkAfmrubBI5wpcAx2tMmuFMQo
 eVEczlYgLz9H2icVI6Q==
X-Authority-Analysis: v=2.4 cv=acpRWxot c=1 sm=1 tr=0 ts=6a327b06 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KWhx9lE1SZ_w_DgzBjgA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-37862-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmitry.baryshkov@oss.qualcomm.com,m:mani@kernel.org,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:qiang.yu@oss.qualcomm.com,m:jjohnson@kernel.org,m:lgirdwood@gmail.com,m:broonie@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:devicetree@vger.kernel.org,m:brgl@bgdev.pl,m:linux-bluetooth@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com,vger.kernel.org,lists.infradead.org,bgdev.pl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BD7E698BA5

On 6/11/26 9:44 PM, Dmitry Baryshkov wrote:
> On Thu, Jun 11, 2026 at 02:09:27PM +0200, Konrad Dybcio wrote:
>> On 6/1/26 11:46 AM, Dmitry Baryshkov wrote:
>>> The SM8350 HDK has onboard WiFi/BT chip, WCN6851. It is an earlier
>>> version of well-known WCN6855 WiFI/BT SoC. Describe the PMU, BT and WiFI
>>> parts of the device.
>>
>> [...]
>>
>>> +	wcn6855-pmu {
>>> +		compatible = "qcom,wcn6851-pmu", "qcom,wcn6855-pmu";
>>> +
>>> +		pinctrl-0 = <&bt_en>, <&wlan_en>, <&swctrl>;
>>> +		pinctrl-names = "default";
>>> +
>>> +		wlan-enable-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
>>> +		bt-enable-gpios = <&tlmm 65 GPIO_ACTIVE_HIGH>;
>>> +		swctrl-gpios = <&tlmm 153 GPIO_ACTIVE_HIGH>;
>>> +
>>> +		vddio-supply = <&vreg_s10b_1p8>;
>>> +		vddaon-supply = <&vreg_s11b_0p95>;
>>> +		vddpmu-supply = <&vreg_s11b_0p95>;
>>> +		vddpmumx-supply = <&vreg_s2e_0p85>;
>>> +		vddpmucx-supply = <&vreg_s11b_0p95>;
>>> +		vddrfa0p95-supply = <&vreg_s11b_0p95>;
>>> +		vddrfa1p3-supply = <&vreg_s12b_1p25>;
>>> +		vddrfa1p9-supply = <&vreg_s1c_1p86>;
>>> +		vddpcie1p3-supply = <&vreg_s12b_1p25>;
>>> +		vddpcie1p9-supply = <&vreg_s1c_1p86>;
>>
>> [...]
>>
>>> @@ -373,6 +437,13 @@ vreg_l7e_2p8: ldo7 {
>>>  			regulator-name = "vreg_l7e_2p8";
>>>  			regulator-min-microvolt = <2800000>;
>>>  			regulator-max-microvolt = <2800000>;
>>> +
>>> +			/*
>>> +			 * This is used by the RF front-end for which there is
>>> +			 * no way to represent it in DT (yet?).
>>> +			 */
>>> +			regulator-boot-on;
>>> +			regulator-always-on;
>>
>> msm-5.4 maps this to bt-vdd-asd-supply (asd being a keyboard smash,
>> perhaps?) - what is its actual use?
> 
> WiFI/BT RF front-end, a separate chip containing amplifiers, couplers,
> etc.
> 
> It is a separate chip (or a module), it is not powered on by the PMU,
> etc.

Ah, that thing.. yeah I don't really know. Although it'd be a shame to
keep it powered forever, so maybe one day someone will revisit this

Konrad

