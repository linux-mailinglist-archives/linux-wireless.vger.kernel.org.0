Return-Path: <linux-wireless+bounces-31277-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AnXAV0uemlq3wEAu9opvQ
	(envelope-from <linux-wireless+bounces-31277-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 16:42:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 697FFA43A6
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 16:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E467F328385A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 15:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CD8242D7F;
	Wed, 28 Jan 2026 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HjlKuflm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MLJzPIkp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3BD248F72
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614249; cv=none; b=KMY3GfJmS3TI4rDq9pwKeNoL2rU3Z09NXnq2hyDIjiUI9BQQFNTouVA8hXEC3BgwFPhpHK1vhvVUgcyI4bMrE8K5cr/r8UPBLOSWS97yOdR5Hsn4K0SuYmgt0PBfOp3CbBWDkpiPUkuyVPgzriVOJhP6aU6cQ120pZ+5eJfTiIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614249; c=relaxed/simple;
	bh=XYAPBfBbLogIdfQzqy4JL/5bdxCR18ImMKIyx9mJGuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpptnklxyOcgOHbDt810CLY5oHwyjzzhtM617AZQQSy34wKbz244g3mJ9w1ZETpqwtKnW+gVetN1tbQt1s5Q5+tBr3UlLdjTa5tmIC1uSATlrmr9KeLd70O9Lwnov+ydcKBEPFxuNSWreflmSD76q6g8BA6BDg6As3/W0CF5tnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HjlKuflm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MLJzPIkp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S93K423255385
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 15:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cfAWH0J+bT1TfO8Eut9bd0nqaaFvU1SsEogfvfC3c/s=; b=HjlKuflmfSJLO7jW
	U0sgqjrUlREdzZtsYIYn4oXlvuPiiKP/hw0OvH9IR48pW7b6VM6oAUqB7FbRSaDc
	2mjpYeUwTEH5E88QsGplKLgQPD+FLR5ue4gDs9hlwsjMaAGmGGCdYII+u8XpzjA1
	zh/xhAoCJXrDjpzUNwJparQ1NaEpDE/GYk+pVR+wnTi/OuW4LsVB0gCEVpftkYtN
	AuXQ77v8xKMBEizGRp4DpajJ2zygZM6z09AdiWSew3Y046pXk+tA59TUuKA5o2GR
	BRcxGC3xdpxyX7MSqJMBx2nZCq875G01ik56H2SpulX+GsfsTIHHHAftdmNqV4Fp
	ieVBpQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bydfk1uvs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 15:30:46 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1248da4d2d6so6044282c88.0
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 07:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769614246; x=1770219046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfAWH0J+bT1TfO8Eut9bd0nqaaFvU1SsEogfvfC3c/s=;
        b=MLJzPIkpo4Lf34pb19Xj0FJPwdho1UvMnwH/i92twZIlQ/x5uzORYuT6WBebWcvxpZ
         qNWE5IXxprHxAqq7kqWbGrJt+EwyQiBOi1MMg0CGfMVt/xGi8BOiabibmZ8hNaSwFNKn
         WpAYJHtrDLyLl+SjfoqxP+4k3xtV3lx1pt01E1X3lLnzUZl6iCHBh1WEZ9q4dcPs6nKJ
         z2wQZkG7jzQbAWpB1zK1pMklMFRk0ojF6myPDvmaX+OpLQ7Qw65wv8LXBNc4h6tXV/dF
         peom58IKkAL9QZ0wdA8frTV1fHBQFMMyZ7bstSPtWKW26hxMvJ3402BBjRPIH+W1i1Gz
         b9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769614246; x=1770219046;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfAWH0J+bT1TfO8Eut9bd0nqaaFvU1SsEogfvfC3c/s=;
        b=TAe6XlEp9gaGRP2RjPT0Sf0VxLgzEg93mDDjK9QlkdyK0RsIFMwjMwmMOxnNAIWeLv
         qNUzoru5agcweLqGphCz1zFhqg1E1B+jr+Vt/qAYMeNAq0GQIkwfPaaDFcoFwwC8+Vz4
         kUpS0Nv9XQkdpylpfnLtDLGuC2CXDBchmAsPzhnF9dcfd60bpGscdgpEreGFXKkD1BKx
         Xgdetl4hFmdFeQV5DN7oNTjfaGxqOiRC5gRwM+jMzAGibpiePUKILZk6OzAl5qHfvH00
         rDiJed3LKYW4NVxDQx+uJlFTE1fRnXQDn6TAe/Hybx4Cig072kfbhT9Eprzg3F9eIIp+
         pLAA==
X-Forwarded-Encrypted: i=1; AJvYcCV5lDIZaU0O8H+CQBsNw/FIxnySPOzIGzQdfM6yMhqAWE9ptKfMkUuif0I3PHlhxhAy+YJkkQXuOWzXBvf+Pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKx+Nsx/Nuj0q+8NS0wXpwXmypAt8UXrU5MrOpYEZXFV3nIFIx
	HSuT8dqyt/Ieyc2N1eEVWe8rRvow/jttr/CoNBctoR4gXM1p0hyjcCw4tCJXTu+Zg9AHxc9NFMt
	yTQZFjleEXsjBSQNj4va33FRgetImOk40rmaDU5MJLTHDp+4hMgHHe8Ic3z/GIUyNO0OD8g==
X-Gm-Gg: AZuq6aI9xVddLUCapVXXC0wAXUdsaVvJrZGD2CVdovuGdECBZW0GpZZzgxFOzizIrp8
	y9hAK/lmAHzVpYVJu4W2b0ms7K1nRbHLw5pIDyprZcLSAnANNYsNsFUngxyduGr2c5jF6K/4qmC
	r4SzrPEhgYiXx0jSug3hJs2/99XKtNmaNkXNvJ3Z7n5uLq8kA42/fhSo5sSWsJbzr5hIGGW8idr
	Z5wUqQ1Y2fTpvx/OR4n0qo9Nv5k2+L1kNLn/T4nRIWUvM0Brf8hha8xTaPb+nBlBjhI5+qhhrN2
	Bt4sXag/rMp4VdAEO375TDGpm4Rw/CARgYGyt7KM9cEU03vKaJ2via3MDC1hp2TooW3Mlpsg/TR
	qQvGjxKgaqPvSmsTzrT9Nbf3DmfFpyaBN4IPVitiq7XtU2rw+ykJ153YEO0PRyiOqAVNi+w==
X-Received: by 2002:a05:7022:f97:b0:122:8d:3688 with SMTP id a92af1059eb24-124a00aad75mr3507986c88.22.1769614245538;
        Wed, 28 Jan 2026 07:30:45 -0800 (PST)
X-Received: by 2002:a05:7022:f97:b0:122:8d:3688 with SMTP id a92af1059eb24-124a00aad75mr3507956c88.22.1769614244895;
        Wed, 28 Jan 2026 07:30:44 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d6b906sm2993776c88.4.2026.01.28.07.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 07:30:44 -0800 (PST)
Message-ID: <9c2e80eb-1585-46eb-a0c4-95c0b50f25fd@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 07:30:43 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 ath-current 0/2] wifi: ath11k: add usecase firmware
 handling based on device compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org,
        johannes@sipsolutions.net, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jonas.gorski@gmail.com
References: <20260121095055.3683957-1-miaoqing.pan@oss.qualcomm.com>
 <74176aab-03d4-4095-890d-7ef1739b914b@oss.qualcomm.com>
 <32845805-5758-4c35-8818-ebccbfd9546a@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <32845805-5758-4c35-8818-ebccbfd9546a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEyNyBTYWx0ZWRfXy8CKHjIqiOgt
 zpMGsX7TJAOVTRkwm/azxrfjCUhbnSd2ap3tKazH1Ke6zC1JmRw9/DfpKTgMzwb43WK+4M51T7H
 YIWi3wc/liRAQctWULmuUuJ6EX50MrtsHEmbio0bnCdMhquyvFXX6QEehYmMQChZ97nAmQN5zSe
 jggUi5uS1Hcp5rL3k+51N1UH6JUpSkuzU1KqZtZH0fyjPy4LP9KP3/UgK/0s27ew7lZp/jS+3vp
 b03dOxSJ47dOOOJLn9XsNke7H6g66BjU/scI6OT2oYFyxLvfYHWqH8LCVc83nUmwbtXv/s/8YXx
 aFvvGE0Xir42gbcSEl6ltgaQyWfZqeEfQ6EdGLtqy0rfGgltrjZcndnelCEQ3n5jqd+kbhkPb+C
 LWDllfKTmVBF4QjoEe/HfZS0vPFcQl2w+yxoycwqEpij/N7WOIZISg6sLIQSYqAaAJp253nPbfw
 PAE6EbhcjPTiOICZ6rg==
X-Authority-Analysis: v=2.4 cv=XfWEDY55 c=1 sm=1 tr=0 ts=697a2ba6 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Zvf348k4SDH0cqSWWfIA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: zapudOx1HvLOFM6dCRCZOERut0r7AW2J
X-Proofpoint-ORIG-GUID: zapudOx1HvLOFM6dCRCZOERut0r7AW2J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280127
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-31277-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 697FFA43A6
X-Rspamd-Action: no action

On 1/28/2026 12:01 AM, Krzysztof Kozlowski wrote:
> On 27/01/2026 18:31, Jeff Johnson wrote:
>> On 1/21/2026 1:50 AM, Miaoqing Pan wrote:
>>> The 'firmware-name' property was introduced to allow end-users and
>>> integrators to select use-case-specific firmware for the WCN6855.
>>> But for M.2 WLAN chips, there is no suitable DTS node to specify
>>> the 'firmware-name' property. In addition, assigning firmware for
>>> the M.2 PCIe interface causes chips that do not use use-case-specific
>>> firmware to fail. Therefore, abandoning the approach of specifying
>>> firmware in DTS. As an alternative, propose a static lookup table
>>> mapping device compatible to firmware names.
>>>
>>> ---
>>> v2:
>>> - Drops `firmware-name` from completely.
>>> - Updates the commit message to clearly state that the property is
>>>   obsolete and the change is ABI-breaking but safe for upstream.
>>> v3:
>>>  - Deprecate 'firmware-name' property instead of obsolete.
>>>  - Keep the ABI backwards compatible.
>>> v4:
>>>  - Use of_machine_is_compatible() to simplify the code.
>>>  - Add back Acked-by tag. 
>>> ---
>>>
>>> Miaoqing Pan (2):
>>>   wifi: ath11k: add usecase firmware handling based on device compatible
>>>   dt-bindings: net: wireless: ath11k-pci: deprecate 'firmware-name'
>>>     property
>>>
>>>  .../net/wireless/qcom,ath11k-pci.yaml         |  1 +
>>>  drivers/net/wireless/ath/ath11k/core.c        | 27 +++++++++++++++++++
>>>  drivers/net/wireless/ath/ath11k/core.h        |  4 +++
>>>  3 files changed, 32 insertions(+)
>>>
>>>
>>> base-commit: d8e1f4a193101a72235416f189b01131a57e26e9
>>
>> Krzysztof,
>> Since you previously NAKed this series, can you confirm that your review
>> comments have been addressed?
> 
> 
> Binding looks fine, but I did not check the driver.

Thanks Krzysztof for your re-review.

Although tagged for ath-current, we are too far in the v6.19 release cycle for
this, so I'll be taking it through ath-next for the v7.0 merge window.

/jeff

