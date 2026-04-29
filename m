Return-Path: <linux-wireless+bounces-35642-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJcbLSto8mkBqwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35642-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 22:20:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 626E749A0FF
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 22:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C21FE30315DD
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 20:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12283932C6;
	Wed, 29 Apr 2026 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZJ1yil7R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T24P9Fi6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041403921E4
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494032; cv=pass; b=mFmXw9lh1zu4PtN47FC7ZnDA9quyb7AlkRx0nXtVbCsQq0VyoBhCK6Cu4YO7DsEkCQpGmH/GJq44pWp7KF31DIudoSU+triv2wmfv5hMqvlgjTFG5amP4nvZV/bPs4k3Q5C/h+hw2Xh08XOO0Cxm0SKuSOPKkaJ0J5eWdAscEyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494032; c=relaxed/simple;
	bh=4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gig7OppLseqxeLVJDQpfa7iVFrb34x4YUfKqLWiWpPRMV127AnzrFXiwP/eqlHxwmDsNNP349Mw9GfHDgghuehDOA8CCZJrm/y674tGS47xvKUOqbhlrJ8XXNQnwPZNgixqVK0G+WxsuuWO0p0SrYClYuigYO2R8r9q5POzw/PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZJ1yil7R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T24P9Fi6; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TFZGHO3067007
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 20:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=; b=ZJ1yil7RRd4FYxIp
	p7Iy/QHM4zbRhNpPA0hYLTXJPDkjEZpj0nlJd1/gcn1CaWRIma04TC5JKe3D81SW
	vVeiRZzWMnD6h1j+/NrrML/N1EdSQ9j/g1w/HfPjcjKblwHioKNVvbPOTS7wMt1g
	t0Gzh5vN5ormYORSYWNaDzPSF5QRW2Nn76i06d+SpiMnh38SIooyjOtYhh5AvjdN
	CZmgTmQB8ODoWqmGpsdbBkWvdolXxWGtqhvkZLbyynEZ4or8H895Tf9JexmnCUm7
	KfrnoxvQeAAeJ1xqAifF8YREdrGH3wXxomLatFCwx3CMWJQTzOX/W5W2A3BAs683
	leNRfg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sxceu0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 20:20:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50ff0bef198so3851251cf.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777494029; cv=none;
        d=google.com; s=arc-20240605;
        b=EjsV2ODS1ui1Aa4ZKKWe4ImEujhzXi5T0HKn/7g472DAqVj5rIuvToTPJmxWvnw0Nd
         +23hFG01v5fQMG8EnuXaHvc6w++YRV1jIPwrHZ1fqcZ8mYiZN2cPtbXqCSt68/vquU2b
         r1s5Mp6gqKHxidgh/qpr0hHmBCGD3K/WJaWy5xFIkg5crgzJ9aullFYUmM5V26JKOnNv
         DiOgVcezQAJB7M2O5/SzGM+hU2WW5Ts5wke+ensH+NmqQlkR9fS4QT4hwkf757/XjhGq
         Z4LZpVqdGbEEWPGt6jH6BN6JSkZql6lmYCqOuQKRzbAEBcG6boKgSJsHeAIOFST2gywH
         nl/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=;
        fh=7w7+8OZ/OWmuonY1H3AJjit8c/IWrmm08++JKXJQmPw=;
        b=Ti21S6dfopiO3Tz+fIXUVOaOzAPoICnRuAzLMEpIPURGas35IZAaJ6fE1E7y4IphkH
         vRLotFk8B6mlTgcX+FM9yImQnoXz/UEtrJyoYEl7YGV5gragYNKX825zsbZN6D2ci2AK
         jSWX19iEmb3TCT9neN4BAYmbtinRfNZ2pCiECFOYG8la+wbZZl3sEcQ9iB4EVyUqGxWl
         cvrfjrcyv9L73wWAdCQzx3JydE7VA+ddAcFWM/KZyNP8nC/45p/zacbH7GP7PUmSr1I4
         o3j6P6wqgzxgN+K30licWwdpccQHzldUB9PUOaa+GmXlnkSVjv7PAmsnN6/pNNkpNxvH
         CavA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777494029; x=1778098829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=;
        b=T24P9Fi6Gf9Zjk4iMavuKmXO+S0kBOW1j11fp+tN8dJeMhZ7AyIwSiSIil0oREiY7O
         aft2bmgLO5PlC+vWwAwD/jJscZIZdBXEOtHD1hbtYl1+yd33QyWzyFG8C+UyzydLmKAN
         ctxniHxGmG2dGtuWcGQ1RiUsyXYmdx+3Lq58ciWRCYw7n30BGnGWxPewjF7M0CB26raa
         n+CKzEGTcjioh1vWjBETZ2SAzyYVBB4IQvLZTAtHnk1MRQLSBN2P7EGZ6G2Hx2w8mHrq
         Bn0dIxMgTFx2Y7H3gtVcdOZq1Dsw1ffCJbqJUversd03uc+fk7UXUZM+4L94JeprgeeY
         ltUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777494029; x=1778098829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=;
        b=RdkgV7i5zxvbR2ddudhro402cTJEtemtAymGi2bISbsN9FA0kTMBvHy3MKkaYYWfug
         C2ROCq/KUvFlGScRbGzIdoSOGlOpue71LtoKvf5IZW1GJ+28zLILJ0/MS/npZ0SW0YiK
         P7axiwx034eiyWCGkLIo6bJ7sL0nhft2LNq2OAqiUMRfiaXfF+N7FuMs5WpVjTNxWpPG
         WEfn+5da7Efn2imuMPneHIc+b9GCgbt8ImWFLDLgiDUeC5VaYrz9k5fHCUYVgsGZkzkD
         Rpby0PctS5teJIRouytX/clG4T007dLyIObKuNNAM+0ehG/+5v3dzok00K3WdfD/2TP2
         bHTA==
X-Forwarded-Encrypted: i=1; AFNElJ/tY2hdYLMGukI2C1yq0oie2za1B8yWa7aSU5eOmGZoc0s1rOr1T5gOIMT1wFAKSya5hpHJ67KmCjRj48tYTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtyKL+eaA7sFLu5K2J+lkpBC71nhWLdrbFoTh+bmq+ltN7QQWs
	tP8fWPw5vbKlm2p+GTwalUs/JH8BFnPHQjthrB5cD7t9bNCyvpmAn2QbbLwkW5lJv2b0LVO8tKD
	hSp+qZv8YoRTJ34GxpoqyeyKGF5yEJEI1CSiiqR5u8HTR/NkH37mxzmizHAlqWfau4HWlm72bIO
	Ac8hPrUfMnlrAdOREr6VC9+aI6wcGTA2XLKR22xcptcA6K
X-Gm-Gg: AeBDieuCQYEch+TubPR+/E9hdVHLd1p/+HRq0sV37Xg12nJllZle14yBx0Efk6Sd81C
	0Y0sEfVgP4wo2wUXcY+fFxrutSfc/QQdKwVzJ1ojCD3Kl3Z82lcU8OeOT83FttvIjG0pbuGrsO3
	7y4GrkTL8fpGZF7NsH6G4rBlpW6t0oWJCa7LkxBXh/L3/LraTa2FyJHRkl9YQs0kWIa7c7i9Ci9
	Y88Bkq2JFObdr8goWt5O47dL3LDrxea6vxr0tdEv81Kc1Ae4w==
X-Received: by 2002:a05:622a:4cc6:b0:50e:89e9:271c with SMTP id d75a77b69052e-5100e10eb2fmr114762691cf.17.1777494029293;
        Wed, 29 Apr 2026 13:20:29 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc6:b0:50e:89e9:271c with SMTP id
 d75a77b69052e-5100e10eb2fmr114762001cf.17.1777494028820; Wed, 29 Apr 2026
 13:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com> <b4de6c89-dd89-4e02-8d79-911e4f9f0813@lunn.ch>
In-Reply-To: <b4de6c89-dd89-4e02-8d79-911e4f9f0813@lunn.ch>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 22:20:17 +0200
X-Gm-Features: AVHnY4IQns7j5YMIXICXGX8mkvbJAvEU7QYVILcU5HpEGI8Bxfo-jvWggVlQrrA
Message-ID: <CAFEp6-1GdaJd6Ua15TsyQC07QDbArXO2JZa9nKVFoCG=4xBpWQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Support for block device NVMEM providers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: BGV-8_Wv79C9ERHcPTevTgS6FK3iuK1h
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f2680e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=P-IC7800AAAA:8 a=ICsrgdoeZ6IjgJzXnBsA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIwMiBTYWx0ZWRfX++IULGj1/Ca6
 7o2nvYADHFKDRv9S0ptaINJViRf7MqlhKpHkTfhQlcg3asqOYGp5EfHEVljikuoKtfH62eaeBHP
 HAgZiLzwq1jLx1+Iq/BmBOJWHpKUGA+mdHNVdJXwzpQAlqnxq+Jvl6HzisjRXdj1dRGpLu3sMOI
 qRijUM5SoLd6ChIx6J0E/in9KqYSbNf642eJimxS8txTBSsYMnpf1QaTIemf0fVcECmQGpfSnVm
 U0O4hk40PlK+5DTcGClmSVMsJwqJjXpRy7Qz0ISTW1XBxdJFGCTCr7jhB6wayCF2xNnlSVHhX2X
 8HA6WDYw1SJxUpGRLvmeIT4z7pg58NAR2eCPKGDnWyoLrmbbToVqCLs4t6h+u09HYY6G5Mgenf+
 v49eqhEDEf66WJ4kpHzlJOx82j9atA9HyrtF8XaTF9hfKXIVUIHqblZsHcjza3kmkjXTvP0cmsN
 jRbyJAn5fGUJfZDjalw==
X-Proofpoint-ORIG-GUID: BGV-8_Wv79C9ERHcPTevTgS6FK3iuK1h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290202
X-Rspamd-Queue-Id: 626E749A0FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,makrotopia.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35642-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]

Hi Andrew,

On Wed, Apr 29, 2026 at 3:06=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Note that this is currently limited to eMMC-backed block devices, as
> > only the eMMC core associates a firmware node with the block device
> > (add_disk_fwnode). This can be easily extended in the future to
> > support additional block drivers.
>
> Would this be
>
> https://elixir.bootlin.com/linux/v7.0.1/source/drivers/mmc/core/block.c#L=
2641
>
> Looking at that function, mmc_blk_alloc_req() i don't see it doing
> anything different between an eMMC and MMC.

Yes, that=E2=80=99s correct, in the previous sentence I should have referre=
d
to MMC-backed storage rather than specifically eMMC, since the MMC
scope also includes removable MMC/SD cards. That said, eMMC is more
likely to be used as an NVMEM area.

>
> An eMMC you don't expect to go away, since it is soldered
> down. However an MMC can be ejected. Is the code prepared for that?

I was about to say this wouldn=E2=80=99t be an issue, since the NVMEM devic=
e
would be unregistered along with the MMC card removal. However,
looking at nvmem_unregister(), it simply performs a kref_put(). This
means that if a consumer still holds a reference, e.g. through an
nvmem_cell, it might still be able to access the NVMEM reg_read
callback after the NVMEM device has been unregistered and the
NVMEM provider data (bnv) has been freed...

I guess I need to try and dig into this but at first glance it seems to be =
a
general NVMEM issue, since even though most NVMEM providers are
not hard-removable, there is nothing that fundamentally prevents them
from being logically removed/unbound at runtime.

Regards,
Loic

