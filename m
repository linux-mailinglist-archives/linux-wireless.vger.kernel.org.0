Return-Path: <linux-wireless+bounces-36219-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHYtNuyrAWqdhwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36219-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 12:14:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AA750BAEA
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 12:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89A66303433B
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DC53C871D;
	Mon, 11 May 2026 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UIehRGaw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ciqq/VHX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7033C7E16
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494230; cv=none; b=VEALMJr+w4n29tcIesb/LzMyZvblWOq5J1WjuXdsndXLpcGKLE7CrYrX+PQblvYpOydOqd9cBZ1Z11l/WTCA1F35atqHH+XzytIR/AZXEeVM0T8bFXz5a8HvC5cqWBeYHS/fMoZDWv6jl7WUz3F2bPZuhfpbW3vr1EbWU1D1auY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494230; c=relaxed/simple;
	bh=t+TY9GeKI7ESDoIUR6ap2dZRQg5YL+zf5mxNPyjFr5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDbUXEhMy9epW946c+P8SrrFBMjE54VdAKWB7oJmPUjQPXB6qk9xcsg4uqPTCd/MDW8Q18rmx9yfpwfbzpgTWVlw/BVmXyDsh/o1sCVoITkFEMLOHRdQ9qzpwMdZD7D8B4Z8wPbC8Tdhua0Q2ug8X5KqthOenKEsBvYB8ZbOMZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UIehRGaw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ciqq/VHX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B6GmUl3539366
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 10:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZUj+PEXEnhPwdm03WlGHMPtDQ/zTM3yIYeQhwkua2E8=; b=UIehRGawFDkQBs8h
	YAOWeVrfyvUwPZsw+S10A8etj2Hyl7xpVQiPGgHwZH/JEWEjcabsFsWNP94TOh5j
	04it++pflt7QPTu1nFhm1+IUdHhbKBTqyq8wQtiKPqVbzY3E8lUGNdNQdaT5Bdxs
	lDJcAj3yzNARjemB9MNGDkhbVj4JUF/D11E9jQpxdq0BdWSL2gyU0Uk8g1y586Ic
	1Ov6wJO3smqJPTAEGTy0jI3aWFijsQNS6gcglGejSv1Rd+AcUGRs+Zig3cqKABNy
	pXfXHlw63wV0nNMFR63gqfcuE4E3fySnkfmPhQ6ATejijmsU3LOvWGujio2V1c0R
	tYPReQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e240h4rgx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 10:10:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-354c44bf176so5055100a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 03:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778494227; x=1779099027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUj+PEXEnhPwdm03WlGHMPtDQ/zTM3yIYeQhwkua2E8=;
        b=Ciqq/VHXMEhiWcXiiw3uaJ+oOo85WQV5y7SO2s/SSkhgi1sGci2rjhqfGxtoQSRCgW
         s6LwsxlqrPAwOQpybCs84c3v+ZD3DhZ8LqyTNa/yMt/6uHL5o9/DgJ46Bz3UllfTCZuo
         Y10JFmVABSN0GoIvlpWMPZqXF/JSBgDiD/idZeSZFoayLGd7n7cpSr0+sdpSunUuD6WH
         7T+wz15cfSzWOBVMMNfQR8tlaYXvGYSVOtIQqQYAHunRfzGK0AErEBYiJwKYdv7SyZzI
         4nSJCmTnRURTvLVvGUq7qshs1tMwM8/nmriIQpCKJjItigbJTy+KqxyGSuWh8rQ8WWzC
         uFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778494227; x=1779099027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUj+PEXEnhPwdm03WlGHMPtDQ/zTM3yIYeQhwkua2E8=;
        b=E+RaYEkNClyxKK3qeGfgOr6HtuZvgfUMcKlpUTarHwyS9RzSeVhdm7354N3hQugA7U
         tH2d6R4aH2DmtRYpKBBqyoT9wNS/OWz7FL9g8l7zHYwxBQZcaiorKcZiO7IVHRUrR2mL
         5FzNY1lcqjjVUzMXb2dXsAy8je1M2JdXMo9M83jGCvyUetaGOWXxwrNQLLd6TpK4n6I2
         gCEgmOgh12+99m6Nj34sXKZiLCTtbZvtvcZtkHS51jtDzJWa35u9IxLtF3E4KqhDGTGg
         e6LhTTABCvF8Ak7+O2fkj33Im3vVYE+OSg6lFlCGGLjaHy6czFnaUZKUWRKCCa49FsJ3
         phGg==
X-Gm-Message-State: AOJu0Yxh9xL42AwCRkmfLeQz8FXCJsimBmXnhQwJ8MU52XpAM6kdn7jV
	brMOh7b+QGozUr0fbffzbkZVbaM77ZuD+r2zkMSTsvxNOkccMGcTbWVCcDkap7vMyToYKef29rt
	o4cMfcii9jlXyJYAjyVnP1hVPMRhYzwKjpQQdUHuRJZkDAH8nn5Kf8XY8LmYY7H702XBNYg==
X-Gm-Gg: Acq92OE7fsZt7zs3UqZlyyV7l3ycq3DnQOtv89Zorx11xuXxDL5pyQjX1CqBUCAV1k3
	KTnj6jZVjRymOvC5RO8MqkmwEFqev4PDGkoWqBlo4Cc2c4Yf2MbN8ReeUZ0BMH/MnnfTpxzWukL
	VIi8Kt+tVrqrha4XDf0j8yInvoIG1cuK6CFWSlwQXS6/ar9IPilb0Qqg8UrLv2qDyRT4JScvsif
	uqplIJK9IX1youdQ3LbVQN/BeBfNb22zYzkJIxmb6sGhQRcGTkrcNhMvQZ3NsvwF5c9z/+uoBqm
	EsrxiwF8FzECXtaUJ/kgOUwN50fOfBPPynHxS2QTdVTeUFU986VwllWCh8jfbx29P2xtE7iOBiC
	/qv/mOemHYKAtMFuGbjlgq0/6lA+zh3gwqftQDnkfbdm2gRJqcIBxy0ry+ei2jfI=
X-Received: by 2002:a17:90b:270c:b0:35e:5723:85e3 with SMTP id 98e67ed59e1d1-365abce2dd2mr25914645a91.9.1778494227460;
        Mon, 11 May 2026 03:10:27 -0700 (PDT)
X-Received: by 2002:a17:90b:270c:b0:35e:5723:85e3 with SMTP id 98e67ed59e1d1-365abce2dd2mr25914603a91.9.1778494226965;
        Mon, 11 May 2026 03:10:26 -0700 (PDT)
Received: from [10.152.207.30] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d65ed459sm9291437a91.14.2026.05.11.03.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 03:10:26 -0700 (PDT)
Message-ID: <ffb9e313-fa81-4da7-8415-6713cfca3230@oss.qualcomm.com>
Date: Mon, 11 May 2026 15:40:23 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix ADDBA request rejection
 after MLD link removal
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
        Hari Naraayana Desikan Kannan <hnaraaya@qti.qualcomm.com>
References: <20260415-addba-req-v1-1-6eb9a33d8ca6@oss.qualcomm.com>
 <1f57207139c3fb955459425deda4d06c374ae212.camel@sipsolutions.net>
 <1d06b2a3-66d8-4c27-b965-6c21f80b7539@oss.qualcomm.com>
 <a5b6798819178dd2995c34ec817457e90985708e.camel@sipsolutions.net>
 <dbb28e3e-5022-4915-93e3-dd428ea59507@oss.qualcomm.com>
 <72b480830dee1489bc28246d13102048635de5db.camel@sipsolutions.net>
Content-Language: en-US
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
In-Reply-To: <72b480830dee1489bc28246d13102048635de5db.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDExMSBTYWx0ZWRfX277vO1QeIhcU
 Dh6sRrKwqE+7o1jsynx/kvYtU7+hVEUfsE81G75z6fTBPPohTYUgB3SUCFiWt0X7T85esWNbFO0
 ownaKmPotU44yXzoFczlGz5VVv5hkhHuh+xd6LjM44dBwJhHfZi5fRdjJe6DV69mVya6iXv1bbM
 8jnLPMV0Dr8Mh6nIQPjAZQxz6RKxrArQSxa0zmD1fEyE21KM5x3VCDaRKPr+hljNJLOTwDC0DjS
 RlNDoGHUIG1e94AXrkK8Sv6UZsbSbCW3tCgiQk6nCEeq1Cx6DPSyl+nUgdnyLb6YwQ50Ll+lA+b
 i8u49O9Y+wurWuh0qDhz445E+zf2Fp30XdPMdNheDXw3TlQjmOrWVYlHMN/VvFtW3gkVmiRnK7o
 FtmNvseR0+ywR3XPGFepYxrWWD+kwa76EBxkHtbrbC85RMFAHb17P2XsOThoJ4/tVe0PX/8olQv
 bWTswtXkrC18S8GxqhQ==
X-Proofpoint-GUID: mb65BwAFKL1_3vqeNVr9wux2m5MXwRpX
X-Authority-Analysis: v=2.4 cv=X5Bi7mTe c=1 sm=1 tr=0 ts=6a01ab14 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=stkexhm8AAAA:8 a=QX1JjQCzkZ97lfReT7YA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-ORIG-GUID: mb65BwAFKL1_3vqeNVr9wux2m5MXwRpX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110111
X-Rspamd-Queue-Id: 55AA750BAEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36219-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manish.dharanenthiran@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 5/11/2026 2:16 PM, Johannes Berg wrote:
> On Mon, 2026-05-11 at 11:56 +0530, Manish Dharanenthiran wrote:
>> No, there is no implementations that combine these two, but there are
>> cases where the update AddBA request can be received from the station
>> with link reconfiguration.
>>
>> For instance, if a station associated in 2 GHz, later with link
>> reconfiguration station can either move to 5 GHz or it can add 5 GHz (as
>> MLD). Station then can send a AddBA request to update the window size or
>> other related parameters.
> 
> Ah, well, OK - technically an implementation can do that all the time
> (and technically we can refuse it all the time), but I guess then that
> some implementations do it with link reconfiguration, and also don't
> like the refusal :)
> 
Yes :)

>>
>> We believe that a no-op update is not required (or at-least we couldn't
>> think of a case in which that is actually needed) as there can might be
>> an actual change in the subsequent AddBA request.
> 
> I just think that once we require an UPDATE call from the driver, that
> raises the question of whether we should even call it for a no-op. This
> seems a bit strange? And if we don't then we wouldn't require it for no-
> ops either, which is probably generally good for drivers that don't
> (immediately) implement the UPDATE.
> 
> johannes

Got it! Then, we should store the parameters differently as you 
mentioned in [1], which can be used to identify the no-op.

[1] 
https://lore.kernel.org/all/ab5b9eb76e4a94745c7cf1bfa886f067618a54b6.camel@sipsolutions.net/#t

Even-then, if there is a actual change, it goes to invoke the UPDATE. 
For the driver(s) which didn't implement the UPDATE yet, should we use 
additional flags to notify the UPDATE support or returning a failure 
from driver should be suffice?

