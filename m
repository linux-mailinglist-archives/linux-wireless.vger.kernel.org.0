Return-Path: <linux-wireless+bounces-26748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0680B39AB5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 12:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DEF1C2564C
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838D830DEAC;
	Thu, 28 Aug 2025 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cluFUnUX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0CB30DD32
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378435; cv=none; b=NIG80km0ZAntWUhtG2DhVUYfV8tToglKZDeK4T1erBDWvaGM/hjr1DaUx45XbqmOIfr469YWS/S+WW01JcVNgVB+fQFWnttqe1l1CIpjhSpy2DoqcQ+0NvTU4/acffCwCwGzxbDVd/NciEk+I/Hnaduc6UMILgSzbwwqM8KAHkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378435; c=relaxed/simple;
	bh=ZrZWyKSIpN3fHPvZS+wexArmhisTQRXyv1BVP3zFr7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLHA9ZVuz8uhJmu9APlqLucAQsTDETYAN333TNE993dU6GOfF9rc08AdXkCwaey8gAdz4uG2fDm2w1HexG18iTIkeNpTMgWqoAgt+pDReJdpnKw7l7wRP2PePc0JQOf2L+7/Xh9JPKE1HjLup32zvlgHJ5SqPMy+TWBaoabLDzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cluFUnUX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S6N7Go023046
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 10:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZrZWyKSIpN3fHPvZS+wexArmhisTQRXyv1BVP3zFr7A=; b=cluFUnUXsl7pZFW7
	DUVpp32Hjef/NlYR+5s0h8I+XkeYPusvLi6DRxms7vdpIwz1fY9OmixFqLNEb/6m
	9ZS0QuoYQ1UF2PendvtmUkpJf6MouJcbdmMtzSsY628sFmYYeT3AJbSS8JQJZbsO
	UdLlZXWCRiVkAGbi1Xrj5aTN0jjpJc0fGe6G/BG9hpI0YmSf1CZ/DsoGadJGKb6y
	FD7kFswo/nj2HOTjD0srd8/SaLX+hPLmT1AYSahke+nhI5qX0/+siwXztxN7LrvJ
	YYqernglwYkh63adGlYT559XCm6GfyjAgELvGv/leJ3BJ+QH29sypUA8y6OKp+sA
	YAEccA==
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5qque-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 10:53:52 +0000 (GMT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e6649d783bso20254695ab.3
        for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 03:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756378431; x=1756983231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrZWyKSIpN3fHPvZS+wexArmhisTQRXyv1BVP3zFr7A=;
        b=Url3bI+mZVOXX6gIz16g2qmxhAF2+rqxaGlRiN5itebThijQJcPECJ+4Pm5bMSxkYl
         dq+45cKS+/No70mauSWAGwaKrmWQov/iRED2vYwAZLn5Txr/u9HofRu+EUk2XUgtNy+h
         JyozCFO9Y4YfPHtxiuV+FakOYTl+Ah1DRKb+vg8HdYqpIshOOMLz1J3IxM/AeTBHBPf6
         Ej5TBJLJHav+KerubPT7YgtQkKI8RF4ryeuTAGulXRkj978gCd8VfgtY5XT6sCuURVoo
         Xl77PDzzyEbiO2wvO3RRnIH2XwX/RlKS+/yGvagrQ55CTDnFRMUgwhzKlwgPFdNopObn
         z9Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUeg2mbHGR1us+aZYN8Nl1kHZJSncVgIWZ8ZxqdL/2lBpVCXyxy3zOdcqtGfnM8MNDu5uIT5T+xYpOhJOgM5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ4H95snlb4L0S87kX/p+jjNFA1llvb16tkYQr/+RZyOWMhSqG
	6sA5byc+SvLW1QZRsJbKOMtt23NfFHbxL+7ol+tOG9obU4oB20bTwuAMt7FbVui5RIRdje5/YaU
	OKMC7GyEeR+lFNuHmo/N7K4l7d6hsZrgwfxualyxh1CIJQ74YTE3ouXIIiK261JiFZ5WeaBBEGY
	13j+UH1dyxkuiCXS0txC51zbsvMrf0ZSgdTmH9h2exMDa1
X-Gm-Gg: ASbGncvaPJ2Ssv3YoSE3F13LO4/OlhfcSgxrI84E43VrOKN+XwQi6bF1tysTUlR2C5n
	aHM9YMQvfeOx1Oy2p40BnC+T9pvR5Ih/dI401bcouqUX+yrweHepJZbDX/EetAQvCUHhVukBpyL
	BouYgOfhzP4N5I1I9+qXBE4w==
X-Received: by 2002:a05:6e02:2784:b0:3f1:258e:93cb with SMTP id e9e14a558f8ab-3f1258e9425mr33188905ab.14.1756378431428;
        Thu, 28 Aug 2025 03:53:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWip6GgXpziGKyShFLpHX9VExpi0oMLELisDegyMuJkoG6LMIQy7ZZK0UF3rrbyiAzGsjLX5kbcTgjRx8e4og=
X-Received: by 2002:a05:6e02:2784:b0:3f1:258e:93cb with SMTP id
 e9e14a558f8ab-3f1258e9425mr33188545ab.14.1756378431104; Thu, 28 Aug 2025
 03:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822050204.476919-1-quic_sarishar@quicinc.com> <6f1207c84db7663c646f0b1211ab7894c53f397e.camel@sipsolutions.net>
In-Reply-To: <6f1207c84db7663c646f0b1211ab7894c53f397e.camel@sipsolutions.net>
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 16:23:39 +0530
X-Gm-Features: Ac12FXzywfVSRZUcWDq7CpaqrgdL-OkDrTChakIp1am7kKdBLd4eWarzX7hFEJg
Message-ID: <CAD1Z1J+3Gvj_zt0C2OE9ksLzxB823gJsheWu1kQXxOukCsCgGg@mail.gmail.com>
Subject: Re: [PATCH wireless-next] wifi: cfg80211: Increase netlink buffer
 size to 4096 bytes in nl80211_get_station()
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Sarika Sharma <quic_sarishar@quicinc.com>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX8HLIl2do7jnL
 vDs1N2fmXxPaK2eZ5hv/c1W8y0SQmBzMrg4Cdk92NWBLYRGKqpovYKiljqjl9hoIwgvXfFG6lxf
 nlQoFv8VqmjWhvtTkzjzZ8t+LGOgCD6+xFlbqzASJy/xGYMrqIBIsp4k48wZOG4zk4yuFNrslSg
 yx/g6N+qaijHB6dWBRWjpI3WhWQWGuaqgVjncw7sPKq2+iGtqww0C0nXFQJcS+ed3pV9TxKkcbz
 s0+c5e35LX0eTETzLhLNO3HKDMWE4cWzsiM0WL8uDsOEWyIkAZTe1IbvdW4KoobBBXKhexx0/Ef
 fUaVwaD5RzIfMGgpMkNyzJKkTlUMkp1WgVCD/OyXGgCIiX5NvTGP1Q8HHPiGE/ujD4PXdroDXFx
 mdz2R8DA
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68b03540 cx=c_pps
 a=i7ujPs/ZFudY1OxzqguLDw==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=stkexhm8AAAA:8 a=COk6AnOGAAAA:8 a=2Oss0gyoXvF9IxNVPFUA:9 a=QEXdDO2ut3YA:10
 a=Ti5FldxQo0BAkOmdeC3H:22 a=pIW3pCRaVxJDc-hWtpF8:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: nCe4GnMXS48xhbaZGouYpemjQb4XVbEf
X-Proofpoint-ORIG-GUID: nCe4GnMXS48xhbaZGouYpemjQb4XVbEf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Mon, Aug 25, 2025 at 1:41=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Fri, 2025-08-22 at 10:32 +0530, Sarika Sharma wrote:
> > Currently, the buffer size allocated for the get_station command in
> > nl80211_get_station is NLMSG_DEFAULT_SIZE, which, in some cases, is
> > insufficient to send complete output to user space and results in
> > "no buffer space available" error. This is especially evident in
> > setups with 3 links, where the amount of station info exceeds the
> > default allocation, leading to underflows and incomplete netlink
> > messages.
> >
> > To fix this, increase the buffer size to 4096 bytes. This ensures
> > that the nl80211_get_station() command can return complete station
> > information for up to 3 links without allocation failure.
> >
> > Fixes: 82d7f841d9bd ("wifi: cfg80211: extend to embed link level statis=
tics in NL message")
> > Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
> > ---
> > While this static increase is a practical short-term solution
>
> We haven't released this code, so we don't really need a short-term
> solution? We could even just disable it from 6.17 instead.
>
> So please let's see how big a real fix would be, or maybe we revert
> 82d7f841d9bd in 6.17 and do some other fixes for 6.18?
>
> johannes
>

Sure Johanes. Will allow user space to optionally request link-level statis=
tics.
If this option is provided, we calculate the maximum message size and inclu=
de
link-specific stats along with the existing station information. Otherwise,
we use the standard message size to return only the default accumulated
station stats.

Best Regards,
Nithy.

