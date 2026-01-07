Return-Path: <linux-wireless+bounces-30432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05461CFCDF4
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 10:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9828530010F1
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19E1220F49;
	Wed,  7 Jan 2026 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I8mBeAl3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EKXSiga5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6C49659
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778410; cv=none; b=sw8QKhUhyx2HbPoPv2Hz0qTbQrhasLGxfCZa2mF6NdCkRKpwTeE/AUCzdaRTbwIeZBhKsCCJ8lgyzQqgpf8jkZdJZ1peLwxBY+KNIvfFpp+/sTjfD4k1TppeMp/bcY+RxDv6zsg8764L+Ly7LbZNEmbjgdYJUe5HZq8mhZDsjOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778410; c=relaxed/simple;
	bh=HNO9vUkHY4v3dnmwBlvpNmCbFmzrDmucDMh9/oBX+hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJuGnUSbMTYStC+WCVeuCwlzKdocOA8cZRywH91d5FkdoOCVlP2rG38PBopsOIglOH+Q3aQbuXcGzg621EBVK1o3WD9qaaIgTI5guDgWyi5Fso8Lr/72J+5si85B+nQKevKuLZLpfX7ty7JJCkDr1nENk/joE4Ew4W9i6omOF6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I8mBeAl3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EKXSiga5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6073fUDP3888927
	for <linux-wireless@vger.kernel.org>; Wed, 7 Jan 2026 09:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eMYZdTg34RMH77d5gdBja5Nhi18mHj2wV+z+0Bzfhf4=; b=I8mBeAl3zcBMOfBq
	AJAh2EZuFu4Gx0mBem4v9uvcPQBztygh5mlP6pnCP7Ai1zkgMMMwsA2bki4ixVL5
	75HVvLwZAtQOZjLKQ4lvFHLtoKjnYqM89JQTpJmvnJZ3zgx7XknCJoBRTet42SsZ
	Vm/jEwCTjVwHx9aMnfBq3BEI6ZUPbH5jiOP0V6rRnkrGBKB6YtEIAbMFazjmYAfM
	nnck03sz8NmbUt6oUgdEVVKmIejVMaD6kAF6QmLDkBHyHDBARQ8KTQ2dTifXDmOv
	phIqj/WYVGQSThSr//HljY0Yl+Y+S24/wfoJ/6z+RvBIGJJXiG0JR6K6sKTTXGX6
	V5EfiQ==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh6a0jry5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 09:33:27 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-6455532d07bso2619214d50.3
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 01:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767778407; x=1768383207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMYZdTg34RMH77d5gdBja5Nhi18mHj2wV+z+0Bzfhf4=;
        b=EKXSiga5aS2uFx9XrQU1JTrOmgNnE7RfuShkv6ZWaKKMohJuQKZBoQrXm4JviVn/+8
         wreA1MvFQZej+ZHnQL320mUHIVL47B4WMfA+wZHjjX+GI2w4fInKsj1K8Gqyj33zgMpg
         ByTtQNhEp4d7zebmA2TYHLOTvaxH7UM+njdv93ZBIYpOkjocuKbDFwAN7mqaQpHtLxKV
         PVccFgPNHdg4e+wJTGZOzNuH+ZgzIZU4OjcB9vTp0hSMxr5YLlcQRut7IbDRNDG3bz8c
         LBE+MnOGTVvdR62KbZQWWkf2X1RQKzJRzvqWekKilwsVHX5w0vg8p/iuCgDGIsnSO385
         8ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767778407; x=1768383207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eMYZdTg34RMH77d5gdBja5Nhi18mHj2wV+z+0Bzfhf4=;
        b=LQHFCZTVv70ix1sp/lW8pXvfCkp+MHYf/6AEd4RLdQ2mg+B/e9yqJbuyVz1JVPHPMZ
         S3wDDrM2SdJD7QlDs50rH2VsbHpPQ1Vl/+ICusSYRvgpgX654mvq5+IMYPG5p2pqXOfq
         sHlftUAzJkyjW4WN11n7CtAtqRgsYutozWj3kZ1qNadAxQFET5+VgwZ+pLnV2peBPw8d
         rVNs27LkJ8HDdZSchc23DubINCXtJ0M2T+dKWnpyOoypKbj+Ddbp54idOn5bqWuhhzTI
         qx3m4nLfg6ITlBB543QnGH6saMin6jcFztJuv2bx+SsjbmVnA/Pf172Errlhgvb+tD68
         MVbA==
X-Forwarded-Encrypted: i=1; AJvYcCXq7kCwSjZE0ouUtglEtD4FdEXj883pLcNQR/s2CLPdTHjPgOHQy/G+jHi1Pt2QeKvwOcE66hFabMfqPVfv8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFfrvaAH20u6XSrfnOzIdkOcPov7Il908ePOtZMwmIrlQg33zN
	t5ajRVHuIxsTnER+3UB7Fi+ZaiFFlzHGP8K1AXJhQSoVeIKv56aaZDf/n6uqHPAzWlF8UkA9Jm2
	hZPMUfB5ENAC/m+GyWeYrMLeBB3qtd+oA4mLf8Z9lL9rGwe82EWuIAx3nt1Y0cPT19N87rRpErh
	JTStOxv9ZY/s7CFn97R8Go05Mk6PXXG3k+kngesG0yaB8Yh10GsscNKFD8nA==
X-Gm-Gg: AY/fxX4ffNKsMzdQbpilMnNNS2do8taEkcvRvu4ws8FQsOV25TIg2HLxVdsSs2oy8tT
	fldummkvLxCZwagbKEWNRM+qwoMN/6aA53pnZS35fLxdkjZUDK/ABIsEF7VfcZ4WTkcpi4rPueE
	rDAFz2tW7pczEFfGh17zGeb9vkK0hBumIkjKD2YVGYR3WmrHfIsZACmaASZR102Sp3Who=
X-Received: by 2002:a05:690e:c4c:b0:644:3850:9062 with SMTP id 956f58d0204a3-64716c75477mr1636631d50.72.1767778406845;
        Wed, 07 Jan 2026 01:33:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEq1EGKxxOKY9SqQLetB8ui0F5aG3xTK7PeyFnFZYnXgSQufziUQ9lPHo3ZFsDFzoa4TcIswNhJITi/kIsNyyY=
X-Received: by 2002:a05:690e:c4c:b0:644:3850:9062 with SMTP id
 956f58d0204a3-64716c75477mr1636607d50.72.1767778406424; Wed, 07 Jan 2026
 01:33:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107060255.29530-1-qian.zhang@oss.qualcomm.com>
 <bac6e271-5bd8-42be-ac20-6873d88c16a3@oss.qualcomm.com> <51010173-0d95-4a21-88a4-fca1ca23d3fe@oss.qualcomm.com>
In-Reply-To: <51010173-0d95-4a21-88a4-fca1ca23d3fe@oss.qualcomm.com>
From: Qian Zhang <qian.zhang@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 17:32:49 +0800
X-Gm-Features: AQt7F2q0BkxeSGdfv5GdyURbuY5wr2E8_yiisTEzM6VLbrXj4lPsYZiq_SedRsc
Message-ID: <CALC2J1OYe8RYPhDH1vneFp+F_oFjgDVFMp0i-1wjyzWO=TmJ7Q@mail.gmail.com>
Subject: Re: [PATCH ath-next v1] wifi: ath11k: Fix failure to connect to a 6
 GHz AP
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: XuRqqILF1aEp2GUOcCjPZ-9SRe32O2CP
X-Proofpoint-GUID: XuRqqILF1aEp2GUOcCjPZ-9SRe32O2CP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA3NyBTYWx0ZWRfX9BpsFe8SmAkP
 pQbn2L/RJnl0cKdoKK/c7mr0JQb0usQtyJwBpZ8w5ZgQgPeDKkw2gY4O5c1SWiDxMm5rWsqoh+6
 bLZOyT5SxXQBQHHp4ZZj2lgq4dtSy2JIstoztI7oTXKmL5KgYlZIbiWsXyPba1vaa3LY2jEUiRM
 tqvAZWR3bYyp+x8Y7cXIsHlypWrOaknsXUEZa4bRFWBq2Lp9mwmFZeF4IrAyuELaVwLorR+c92I
 FrDZWe2XX27ZYTVrmPCVH+0Hbzf6pv4AGIW7vkkYkwYiMZj59pv0Jd99RpZ3Mte1pnVyb1ODfk6
 hgVTphpezlTczJnta3fCNzSxOtOeQFq52VtpCNV+qN2FsH1YNzJL7a+ud8Wu3PNSHzhBDegTkn7
 4T9vML4dvrc3FRf8YYJWskgGPr9SiF5twIY+LqaQvxLihljFx9BGtPAOQbW3lC6UWX7qWikS3GW
 nbeB8poCUN137f7uJbw==
X-Authority-Analysis: v=2.4 cv=MtdfKmae c=1 sm=1 tr=0 ts=695e2867 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=-qEL4iWKF586AChQK2UA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070077

On Wed, Jan 7, 2026 at 4:31=E2=80=AFPM Baochen Qiang
<baochen.qiang@oss.qualcomm.com> wrote:
>
>
>
> On 1/7/2026 4:23 PM, Baochen Qiang wrote:
> >
> >
> > On 1/7/2026 2:02 PM, Qian Zhang wrote:
> >> STA fails to connect to a 6 GHz AP with the following errors:
> >>  ath11k_pci 0000:01:00.0: failed to handle chan list with power type 1
> >>  wlp1s0: deauthenticating from c8:a3:e8:dd:41:e3 by local choice (Reas=
on: 3=3DDEAUTH_LEAVING)
> >>
> >> ath11k_reg_handle_chan_list() treats the update as redundant and
> >> returns -EINVAL. That causes the connection attempt to fail.
> >>
> >> Avoid unnecessary validation during association. Apply the regulatory
> >> redundant check only when the power type is IEEE80211_REG_UNSET_AP,
> >> which only occurs during core initialization.
> >>
> >> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILIC=
ONZ_LITE-3.6510.41
> >>
> >> Signed-off-by: Qian Zhang <qian.zhang@oss.qualcomm.com>
> >> ---
> >>  drivers/net/wireless/ath/ath11k/reg.c | 9 ++++++---
> >>  1 file changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wirel=
ess/ath/ath11k/reg.c
> >> index d62a2014315a..8786ca3870fc 100644
> >> --- a/drivers/net/wireless/ath/ath11k/reg.c
> >> +++ b/drivers/net/wireless/ath/ath11k/reg.c
> >> @@ -1,7 +1,7 @@
> >>  // SPDX-License-Identifier: BSD-3-Clause-Clear
> >>  /*
> >>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> >> - * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All right=
s reserved.
> >> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> >>   */
> >>  #include <linux/rtnetlink.h>
> >>
> >> @@ -926,8 +926,11 @@ int ath11k_reg_handle_chan_list(struct ath11k_bas=
e *ab,
> >>       */
> >>      if (ab->default_regd[pdev_idx] && !ab->new_regd[pdev_idx] &&
> >>          !memcmp((char *)ab->default_regd[pdev_idx]->alpha2,
> >> -                (char *)reg_info->alpha2, 2))
> >> -            goto retfail;
> >> +                (char *)reg_info->alpha2, 2)) {
> >> +            if (power_type =3D=3D IEEE80211_REG_UNSET_AP)
> >> +                    ath11k_reg_reset_info(reg_info);
> >> +            return 0;
> >> +    }
> >>
> >>      /* Intersect new rules with default regd if a new country setting=
 was
> >>       * requested, i.e a default regd was already set during initializ=
ation
> >>
> >> base-commit: e33fc1c6d54ee1569a57255e11c2978ba9a42ffc
> >
> > Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>
> Withdraw my above tag as the code has some issues.
>
> We should only return in IEEE80211_REG_UNSET_AP cases. For other types we=
 should go on to
> build a new regdomain.
>
Will fix the issue in a new patch.

Thanks,
Qian
> >
>

