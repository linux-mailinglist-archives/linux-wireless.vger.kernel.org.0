Return-Path: <linux-wireless+bounces-21520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DBBA88BEE
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 21:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83A077A5378
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 19:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B19C28DF12;
	Mon, 14 Apr 2025 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iqhBsErW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0A628DEEC
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744657482; cv=none; b=EV/8jHbCzO2319G+qSi5xRNTiApCULHegiF3Rv9cBN8XTGt5fF/bqAxp5PxENZt8KPDXAau1KWNLmqCKtlF495KbS81x1K5wMey9BJY7UBKio4EZjsEeOQZGJ5kDLprT1y8YAPjB3ghpSWzaINKaXyRbWMTBJXfcl0CZW1Z6oek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744657482; c=relaxed/simple;
	bh=DZJOc6WrSAEY9owB5FQgoe3x+B3vdTe1ADDIMIXhUG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRndxJTY6FXHdZZZLvruUTlqLF6XhUZ6xoUXe0UuJQ3y6qvVoSYqhUWfhZJkWXTQbzD0/xLCa6H1M6tHsovJCcfSf/C+hslDTwdvZUfPAkIFrB9eVZbswSHvmFw1ymKtZnLzY2Wl2hSRCPjdPCx0Mx155KVgML4tx8r1I8EayRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iqhBsErW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99qoL030614
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 19:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OETJdvcRlTDOC3wxrm7MGgDibXakzm2Chi5+CwgMXn0=; b=iqhBsErWeoSHj9J/
	E045fLrifvanLVRlAnodQyBohn4gGtolujIB2SUUzOB1CPk7IVZSQYJLnzv/sIky
	T2iI/EjCTc12ZsEw3TC+51CCdKIZky4cIvuF0PxxWJ1QdEfyWQMEx5WISqWTozZR
	rM11Ayg53i2c/y79QoXyGCeXXJCYsmEuQEnjWeFN86mEyLl/iwqpWJJJcrfgGAR6
	qGCdp3F3nWKNtGwdcWxpsSuW2WJBas6WpIyhrCDp1YII3DT/ZEGP1MKE8ClU1gvI
	E2U7vHGHi4J8dcbvE3dPLT6pWrPt/zwGTj7+8T2WshytoyYsSToeth72Ba53alWO
	gvdZZQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydvj5rb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 19:04:37 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8ffb630ffso68401026d6.1
        for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 12:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744657476; x=1745262276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OETJdvcRlTDOC3wxrm7MGgDibXakzm2Chi5+CwgMXn0=;
        b=LAeYBrVnwkl6ORQKwwKlBro9+Fl/52pjYrAID6IA0pIg6ywMq0o2njwyRWYrFbMm35
         5kp/3SolwhPYXCGAWAI3/hRmVlSDnVoCwHoxh86nuj3e6AZxHh7fmfPREUx00FtCxYIp
         B/an1o3QzeOQD7KoACnxlxG9aBu6kKXaHC+sXRVa1iDbQv8pC8BjjpZ3bzfNXEsWVoqk
         Io4g6ovu6nFuMxMO38dPdnIOoJmnsjrW7J0tTUtaDc95hsX9Xg993EEWuXuiD4ALDyAO
         tL98oacmVRWK2WhrcHij+qVQDWTBQ92KXar+f8bfgoZd7QEvOofQmcheJKRfaqw4IllW
         +yEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX93qaJRfkyWgpV0pOHY7LGx6Y1R3TqosM+eFutMQ1+QHhPdx1f6TJRrq1Hp822NvdUyzMv7J9X3Dc/YJr5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmQ5lyhFBiCYxTVT6dy1jjN2JKsocOMGDMx0IFSz9tG6FAisGz
	PnzNHY7cXdsGAAlp3yeDPqMkCDp68B6ixE57A1bOGl3+8QSQKrR87kheSKJ6+Bj2FV4mDeFygGn
	pANLLqJsagPAP/5O5TQaldUx6Hf5c7qlDdg0DE8JXmfVpVjDkb3X/cNYCHyCiXmSCJRKYtiQuNc
	jszi5aW8UvexcUDMzLeKUWchPcQAYqG33USTEOO08l
X-Gm-Gg: ASbGncuRA6NJ4gd3JPqwaReBwGXz5GgCSvLs+yRFCm+O/bk/TEjUHAfGc3kEqfKrVf3
	u9wtI3WAGEXPKO9SeeDZNaN4wFz/6NvzsSyO4H3Ye7PNxzdnTV2LaDGqTFgepngNUHwxI614=
X-Received: by 2002:ad4:5aac:0:b0:6e8:f945:ec5 with SMTP id 6a1803df08f44-6f230d9f19dmr188265046d6.24.1744657476374;
        Mon, 14 Apr 2025 12:04:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzelK//k2TwD46eVAuZhiJNjDOOOFl3EoM1T+XqSjz0DyaIMYpfLn3sF+Nm6yY82gIZ0h6m/EK/PQS4Vwle6I=
X-Received: by 2002:ad4:5aac:0:b0:6e8:f945:ec5 with SMTP id
 6a1803df08f44-6f230d9f19dmr188264526d6.24.1744657475883; Mon, 14 Apr 2025
 12:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de> <20250414-restricted-pointers-net-v1-4-12af0ce46cdd@linutronix.de>
In-Reply-To: <20250414-restricted-pointers-net-v1-4-12af0ce46cdd@linutronix.de>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 21:04:25 +0200
X-Gm-Features: ATxdqUFggdvW0Cci0Y7dRfrjAmK6JyGKc4MbfrCN7JALN63x-K56mHIpeth7yd4
Message-ID: <CAFEp6-26mFztO-AfGrL0cScGFMR5Z3Sp1KOsUvH_FoJfK+8q2w@mail.gmail.com>
Subject: Re: [PATCH net-next 4/7] wifi: wcn36xx: Don't use %pK through printk
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Jeff Johnson <jjohnson@kernel.org>, Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=ZIrXmW7b c=1 sm=1 tr=0 ts=67fd5c45 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=ZS808JPYK9pMg9uJusAA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: B7vrYqZXYoifH3Rjjy9Houv5Lr6U75w0
X-Proofpoint-ORIG-GUID: B7vrYqZXYoifH3Rjjy9Houv5Lr6U75w0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=941
 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140138

On Mon, Apr 14, 2025 at 10:27=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). They can still unintentionally leak raw pointers or
> acquire sleeping looks in atomic contexts.
>
> Switch to the regular pointer formatting which is safer and
> easier to reason about.
> There are still a few users of %pK left, but these use it through seq_fil=
e,
> for which its usage is safe.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Acked-by:  Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wireless/ath/wcn36xx/testmode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/testmode.c b/drivers/net/wi=
reless/ath/wcn36xx/testmode.c
> index e5142c052985ddf629b93d7b9687e6ba63a48e8b..d7a2a483cbc486308032709a9=
9bba9a52ed0ff59 100644
> --- a/drivers/net/wireless/ath/wcn36xx/testmode.c
> +++ b/drivers/net/wireless/ath/wcn36xx/testmode.c
> @@ -56,7 +56,7 @@ static int wcn36xx_tm_cmd_ptt(struct wcn36xx *wcn, stru=
ct ieee80211_vif *vif,
>         msg =3D buf;
>
>         wcn36xx_dbg(WCN36XX_DBG_TESTMODE,
> -                   "testmode cmd wmi msg_id 0x%04X msg_len %d buf %pK bu=
f_len %d\n",
> +                   "testmode cmd wmi msg_id 0x%04X msg_len %d buf %p buf=
_len %d\n",
>                    msg->msg_id, msg->msg_body_length,
>                    buf, buf_len);
>
>
> --
> 2.49.0
>
>

