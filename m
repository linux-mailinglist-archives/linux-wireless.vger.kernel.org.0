Return-Path: <linux-wireless+bounces-27826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B56BBEBE9
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Oct 2025 18:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 135324E9F70
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Oct 2025 16:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913062DE6F8;
	Mon,  6 Oct 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OAHgZjwI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C372DCBF8
	for <linux-wireless@vger.kernel.org>; Mon,  6 Oct 2025 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769518; cv=none; b=AHC14FSPfv1um63Bus0nRHgX0yP+WENNhRQt8w5pzx1Vaiw3JK7SxVa4ymAKMdLQzq2oNUy26ahxQJ6uqwXEnKUQNkb0k2yIE3KVA3AwOhhVLVs/cxkYT+DJKvtiHoxsW2MIEbDb0lD3KTgkoWY2snx/9JYNskcW9feURdvliSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769518; c=relaxed/simple;
	bh=SZVE1z5dxZ0vOYUETass84Vmql3EkDibGvWEREA1fOs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oAmaqIJHELfPpDhoHSACN16npXvfg3h4Lf0NtIhunu2zO/0yG8/G9TSMe8UsiXvL/43rsYslF14aWrIiH8ipOEOBz3lzChykA+1gdqNUGZtLZrCvjHex6IcDdMFlaPNpAScL1c9U/UDvzMxgKKD5FPvgjo4yQR0OHW7qUdLUxZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OAHgZjwI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596Ef7Ga017633
	for <linux-wireless@vger.kernel.org>; Mon, 6 Oct 2025 16:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lz799N4xrdExjbwvywVoVoJu07M1y5K/Gx4zQPeH1uo=; b=OAHgZjwIMknSUrYj
	dtHQWhDmGoGqoWQvEHp8CmWqIv7V6exUTNjIF1sTD1jBW4ziZ941PkRrXp7CM+jW
	dRyGQDzS+4qDQZLDo3U1JWZJZCEG422c/EZ/Q64XpOXxKDh8Ntu3C92VTrr8y9MP
	5fstlHL+HroOqMXSNZWpieeY+c4BrjB5b4E8gdxiBc/kgUZEKLo1l6Dfaq45OEJc
	ECW3zYGol5VVZvFmEWvSrgWZERJ7DaX+oi1MA2MjIpGBuALqvTFujp/D+kpwchMu
	LgZmeI//rS0Iu4LhNmwYfIzchsqsX2Tx//nEwg5fsAOhPV7tLd+gb2SXElvM+AHE
	jzW/4g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvrhmbt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 06 Oct 2025 16:51:56 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77f2466eeb5so4792043b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Oct 2025 09:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769515; x=1760374315;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lz799N4xrdExjbwvywVoVoJu07M1y5K/Gx4zQPeH1uo=;
        b=XIB7S8Zst3RC2w3+sXlMld/bDKq02ixy47Y0PHaQl6TXz7iVMx4/bO+HoRkxlwZLN+
         nn+JozIYVsaOIPrTCTiJzPNu6D4f0RHH2lxMfx0CzjKfEIfr3e1dEH/45Y5og+60bYV3
         WPR9LKh1ZXv5YOyIJy0LXPQ4l5JnRFxHJ7z+IGlS18YG/4JcCWDK1H5T7VP3GULEhTo3
         Fg1iV/hucdQKpmoeMRlWtVD80nIYZBEvT+8guDp5FNysJDQyZc7usZAIuoJksDiEA3Zb
         jx1bMOZRqCJzMARV6G8v+22Gxs4/tMRXmrdC8uqxXjl7tzPYsegOK5Fddcp38xd1wlVF
         17Xw==
X-Gm-Message-State: AOJu0YwsOf3A2Drfltpddmg+Fx/BSHCCsF95tbzv3raY34XYEgQlQ7/Q
	c+mO3GwLD1Aep8L3LGGH4HSZ+zK76bVs5gYhVOnuNWk2MRaJwg2JZgofA/a7OoAyMxtEFO3b5NQ
	uc+5VxqEgAfv5iykm63qz7/MxhTOpH4iKWJIMV+ZaV+s2YuAJXANFCj3r6HLBvpnHsdDAg3iINU
	azYQ==
X-Gm-Gg: ASbGncu9x7j/Kx08Bgino00R+RGB0eB7XUk0rCaUGK0F506N4eNFfL1FXX+vpThQdVm
	L9154LJhSqUfOYdfh2Db0Qv21a/D2j56PTI9EfZha1OKUqdWhGah6wHI7ILXqbg9kgUkHqSDkil
	CCa7RdoKi4icjSc3qnpK/vZvwe8+UVYHNpcRvq5TDqqqLMEtw3ghMQmp6hFgyACLbHDqBMiyoub
	hMhcwm+s6tZHokHrCqGvrq6HYOYpHbwFu4bwhuIJttnAcknGC+n1Sse0NTSJ4TlgeLp7SQ1tHl6
	UoZ80kcFJuu6gPjtWmg1YeMSg0PECNU3LGUGDDlG2Wcg7Kul+jm2g02UrF6fLHud67MpFcbYIgz
	bNdLT2Q==
X-Received: by 2002:a05:6a00:b55:b0:781:1f28:eadd with SMTP id d2e1a72fcca58-78c98dc4e18mr11481306b3a.20.1759769515058;
        Mon, 06 Oct 2025 09:51:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKnTqK7utLH7t0B/x3loJRJDnLWhxeQ3OXZfJ6zNNM9+cIiFqvwHnpqLaeppi6QQA004orog==
X-Received: by 2002:a05:6a00:b55:b0:781:1f28:eadd with SMTP id d2e1a72fcca58-78c98dc4e18mr11481288b3a.20.1759769514601;
        Mon, 06 Oct 2025 09:51:54 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0205336csm13293176b3a.45.2025.10.06.09.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:51:54 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath11k@lists.infradead.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20251003092158.1080637-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20251003092158.1080637-1-rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] wifi: ath11k: avoid bit operation on key
 flags
Message-Id: <175976951398.3451922.5845347165162023297.b4-ty@oss.qualcomm.com>
Date: Mon, 06 Oct 2025 09:51:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNiBTYWx0ZWRfXx1kWV7+5DQPQ
 j70m1WDsVAHB09RbqbbAkFBzohlItz1//+/6wdKcn1L45Zx5Yt6UMhr/pVLXmUdQOyBImr9g2pS
 hKPFKET8jqYYzADV8ifSEL1zqIDKY2gq1I7U3RCyKCuKZ/2L31XQdz7nc6PycNyRlpFVqlt0kJ8
 h2VVPxXTh7Cyse/PdK5DhTzpzdoC47jM7fFLHl+sRzpp4J7N6y+SixDXkrbDtOAp480+ji4oOp5
 ClCWIWFGL04aKRn/C+FHjpRmJ9LQipTVDHdo7Pp8SpVT7Wqi8H7CMwYDeKRnCU+IndIorJjx6jJ
 tun+FRN9mveDT/W43QbQrmfmOliCYTv5/UauLbo6VuU97ct3FZxbwD7pSWZfUI4VAD1qCWyUnYj
 gJGug3YQIJ3L6kziTmMwL+IV+rgpfw==
X-Proofpoint-GUID: pvQF4Q6dGJManbMaY_z2joXxwCQsQonp
X-Authority-Analysis: v=2.4 cv=XIQ9iAhE c=1 sm=1 tr=0 ts=68e3f3ac cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=r6rug0q3oUuyHVY6sCAA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: pvQF4Q6dGJManbMaY_z2joXxwCQsQonp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040036


On Fri, 03 Oct 2025 14:51:58 +0530, Rameshkumar Sundaram wrote:
> Bitwise operations with WMI_KEY_PAIRWISE (defined as 0) are ineffective
> and misleading. This results in pairwise key validations added in
> commit 97acb0259cc9 ("wifi: ath11k: fix group data packet drops
> during rekey") to always evaluate false and clear key commands for
> pairwise keys are not honored.
> 
> Since firmware supports overwriting the new key without explicitly
> clearing the previous one, there is no visible impact currently.
> However, to restore consistency with the previous behavior and improve
> clarity, replace bitwise operations with direct assignments and
> comparisons for key flags.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: avoid bit operation on key flags
      commit: 9c78e747dd4fee6c36fcc926212e20032055cf9d

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


