Return-Path: <linux-wireless+bounces-28310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC85C0D7F8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 13:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40F219A1FA3
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 12:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338A4301025;
	Mon, 27 Oct 2025 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hQQFjcNu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EBD2F9DAF
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567770; cv=none; b=kZirUTbSTM7wGHw4U6Kn1UfO6Ybc8VDyQp15QJbjSIG9UvUHeNWPp7Y8oagYQitLkNY3Sa3kGCMUCdNPoNJaeTMTvbIDAORYwKf6v7dNYyjpEzI7sxCnIwrQFe5t6ltTaVhjyxfokGDPntfVZpQ2h/eIVu+I/xKQSfpqCxmKdBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567770; c=relaxed/simple;
	bh=3muxG6MPxyrW/HfGoVTrDpf0zTKrmjAvX4xRLEsxaLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP/cjQrVaI3tv2VMBnBK199qPkMPvxr7ulIfrp5XhiKu1Cw+YR7uAz83SLXnTAzjDMIdHN9a8NNujf/Z5kO/de341G17QwSORA3pUNhVuuTX1TPpmT3SFvfcXuLfxz1EaCDB4oXSLfLwSfODq+mhqEO4+GezMgzCX/8y6CiQ2eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hQQFjcNu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R81hAe915959
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 12:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JncXzot9W1gow8/tUDBTV3mA
	gpfqF8x82foGvNCR8u8=; b=hQQFjcNu2DH5Lw59o1W3SMNAFQY0QXjO/ktVuC40
	hzC7YzQhGKGkCh1lCcdb/C/niKl0YCCv4pxGe/CTro0PzN3sR8SCaf+bRb1G1SzN
	q+VuVqXq66xW1wvCMEun5HJ81BTKuCA3TxV612EXGGbQdvrskchdpi2h51F/OUc0
	NSqKEbYWk4av6IrCCZHgQNu/VoFWqFXK3rMMy9vmJNTSf4zHBpVxvjY5YwkyfErW
	3Ps46xiotXAIzJnryRT7QeUNOyGxvZKYB+by7tQ7mfvn5y+2l69ZVBj3vtenKmSR
	dxdsKS6jQdPufQELxCcW3VKJ+HXMXz8y5LsPIIwe11cxCQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0px6mekd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 12:22:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ecf72a45f5so38793111cf.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 05:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761567766; x=1762172566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JncXzot9W1gow8/tUDBTV3mAgpfqF8x82foGvNCR8u8=;
        b=DvSH27GGynUg3Ow9/3VAd8M4BFv+Orjkb4gZTBo+83c9Q2mFqxAAriC2giixdqCkr2
         xA5B0Ti+hJVLhxLR1tmrAolaScsUdVPRuTqcuOis4JYtvj+aj3d7S79Ty5p+XcBbOMvD
         VaCvPwhxZfr0dNaLARaIEnpt96U/4uo6c7a+N1ipFIXR/vydPAmA9UwDYEn0DCrEB/VH
         riHXr1oSHjTm1rU6rEYHLBFkd5+IVJUqU4AEux2GLHEpvLgO7IkMoEKnIqA/ntm+mdms
         1iDgrEuFoZs6YlTmczXAF+fYtNL2DBaoV5hUEmUY9X4sn4PBs8S1QlcVg+aNPViCWx63
         4r/A==
X-Forwarded-Encrypted: i=1; AJvYcCUkunGSXs4ekX0+5RLXwlTKGh/onvBnK/ZJQ4Rwzq5L+oJWmTMTyDvp+/kOrJYLgPpUOYEtYqJnOy/rAGgerQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK36wdS4gUzIiHbSzozk049iJeUIdrYo9DcFmjQ22CaIYfJ+TI
	xn60tymDaVuq99NfDERQGnkzWNKdQAoZqrkhDp0RMPblJkByh8HgKIepCY5Da1v7nOnx+Cr3B8l
	Xs9/KIdyWf3rMRK8fyDsbbYDGWjilizsr3834qm4/IFhh0fLimXCZ/1W4TZR4POALfiNUbw==
X-Gm-Gg: ASbGncuUI7Kjs2oUV8lh4HKHMM2ykT16LqTdiTOZKbHZqsztFV1JwZ52ThYiTFWLKWK
	IjZ8kjLa7EvDTPT1So0Y5rKG2mK/m0K/plIaCL4Lwl6pntnD9CJpxn+UCs1amWtkI21410dQ6c9
	ly60fiXiXfIRjDe3J9sYYIo41VW/f9w2VcRDZT8tQYv39qRUnfsJ0qxzAz0OzeSPHglamo4gzYh
	Tkc+PPV0umo1isuRrGsonpiOw6uLPnI2GNJGIwUV1l0i2I9bHJ+iTdanVv4im5xLr7SuEJekvQk
	VKXEc9LMtg7TlKbAHuHuu0ztRx5wPev9pUsQO+Xw5Dnms7lPXy61YsZNy2IvANlC+fm/x6W7uon
	lRYB56HeCTHl87ExGFj5w694hswNLkerepWKG8r7gVHaMvgFloo/0Q8BgnPYbpy/fHUCMAoUoeR
	OChqDh9G4tit8r
X-Received: by 2002:a05:622a:353:b0:4e8:9f87:1f42 with SMTP id d75a77b69052e-4eb94922adcmr152956141cf.69.1761567766376;
        Mon, 27 Oct 2025 05:22:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH79d7Do90KoVZ1tYBoBY55fSIjzc3SaetN68K8JqBrkVyDzQwzXI4DnjU4YyJIchWS9APnNA==
X-Received: by 2002:a05:622a:353:b0:4e8:9f87:1f42 with SMTP id d75a77b69052e-4eb94922adcmr152954761cf.69.1761567765265;
        Mon, 27 Oct 2025 05:22:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0e0246sm19655221fa.49.2025.10.27.05.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:22:44 -0700 (PDT)
Date: Mon, 27 Oct 2025 14:22:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Paul Barker <paul@pbarker.dev>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>, Alex Elder <elder@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Michael Nemanov <michael.nemanov@ti.com>,
        Kalle Valo <kvalo@kernel.org>, Andreas Kemnade <andreas@kemnade.info>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RESEND 2/4] net: ipa: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <g4ryfonkdpnsgqo4brx2dymo7o35jkndc5kkhdybhyvwo5rust@jwsivdbievvi>
References: <20251027115022.390997-1-sakari.ailus@linux.intel.com>
 <20251027115022.390997-2-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027115022.390997-2-sakari.ailus@linux.intel.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDExNSBTYWx0ZWRfX5qqA2B1Fep24
 2UPTgdVKK65fdcxJh4BJPBJDq8gHuQYqbFNwoCT7Ou9O9DIZ8UAFm/JsHG5jdRyzNs1t0tpmdjf
 Fi/G4RcydudDJraTRys9SIZblIjmjgXeW0Ixlm61chZD/R2KQpntUQJbHHZ5NsQLgQ5nn/6XHG3
 MlkrGyK49awP6FGeyLn4Vo4XtT9pe5mF+k5sV9wNs7aiQSQCQrZtxQta1VcG90sxlc4uKkclEqr
 kIaMHd8LXxgwU1b2tcNDBnKJr8ZTG67zVOP9lxe7WDop0yZ7o5kIwlsMXihZr9g7JxmVI7W5Ykq
 AIOqTqqJ2/jnZrfL4pegnmRBYJI39iCPnyzcuv6L2gkd/8OZmrB2HMFRbTzQ+bFTJ5MZ+eTF+y7
 Fz53MrkkYPLHtpfx3ILol2Nq+zkdvQ==
X-Proofpoint-ORIG-GUID: -wt30fdyR_d22qXFo_i-JEz-Cu5cslFN
X-Proofpoint-GUID: -wt30fdyR_d22qXFo_i-JEz-Cu5cslFN
X-Authority-Analysis: v=2.4 cv=WqMm8Nfv c=1 sm=1 tr=0 ts=68ff6417 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=QXDDecBx9f-8Df5VMo8A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270115

On Mon, Oct 27, 2025 at 01:50:20PM +0200, Sakari Ailus wrote:
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/net/ipa/ipa_interrupt.c | 1 -
>  drivers/net/ipa/ipa_main.c      | 1 -
>  drivers/net/ipa/ipa_modem.c     | 4 ----
>  drivers/net/ipa/ipa_smp2p.c     | 2 --
>  drivers/net/ipa/ipa_uc.c        | 2 --
>  5 files changed, 10 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

