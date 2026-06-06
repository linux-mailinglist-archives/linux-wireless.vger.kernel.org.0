Return-Path: <linux-wireless+bounces-37450-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id THVuMJogJGrW3QEAu9opvQ
	(envelope-from <linux-wireless+bounces-37450-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 15:28:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFB064DA1B
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 15:28:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=aHcOv7jj;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=fwnjbo8+;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37450-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37450-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3257E30188A0
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2026 13:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F14D14A4F0;
	Sat,  6 Jun 2026 13:28:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BF13B14BD
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jun 2026 13:28:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752507; cv=pass; b=NJp0BkxG39J3Vx0pCsFn2zRp+7HxE19aqZ0eEwuT7BF/nM4XiUmlTM55X5YIyNFfkNrQ/2J4aH4XWuXuEdLunY3pV9+OdYpZalB2QmQhIuiYOQLAts/WEQubuDBbCx83V/u30wSfPsA4zYLoWq+7Dh6+3/z5jRHf9uWBJ8vPTYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752507; c=relaxed/simple;
	bh=IkivCiuOB+h9Dp1AGchU/FX0kdqjmZmvFbSh/95INTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mew8wsbytOo20XldUxG05YcIhJWafFKSa7p5+WaZ3KviuPUqZORtp3Kx2+7+pgtLkiRRk37aldtMjlFiL2sMwXuxNwb/GQXOIZ/AEGDIhwchLd6J9IiNINaJBGTyJsEJGsjyRFHzU0goNTecBB0n8bp/He4hh6lvAMWrgSSmTdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aHcOv7jj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fwnjbo8+; arc=pass smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656BGRSe1290912
	for <linux-wireless@vger.kernel.org>; Sat, 6 Jun 2026 13:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ftpvwrbIZe1H2l1L1G2BWdwwGf3+rjIyItX9McWhd2Q=; b=aHcOv7jjS3ev6GxN
	4HCbzdp2W1WHBOGwH9cfMRCFny8S44oNxuvECZm4IMY6zMMbfsZ9vjG4ahROxg2Q
	3A1KJ+G9F0AsGR5vA/tMXt69p/LA3vEZBzU+zdM7xkxyG0OVGjPVaPInOtN+YD0b
	RVn0rKcm8wR5vDbGJZgKIW6gEOl2XZ8Gg3NbYF0jHxKoHzv0mZoj6wcwu76xwRzQ
	7dCmsH7l6ezZIXaYkHC+5qx5xS5U/HFIV4ZohJSvzzNSHNON/p3wtGe5W5BkNiNk
	csmZrfR60qJdq5SW56NbR26hl1lvSRdkTEUYDK7vpQQakpyX4BYps5Z9QbpFiJnQ
	EWpgmA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embmr965r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 13:28:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-915757be497so565684885a.2
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 06:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780752502; cv=none;
        d=google.com; s=arc-20240605;
        b=BFH/io6413YFYuNe5B6H6wytKtM//Y0s7Xsu33sLyK+ACYRC1o8KsWCRb1tPlY3RjN
         1kb9UD9chLrt5hmCXQ2ucMWLAeI8hQprRag+Yzl41zpmJlxgNtG+iJApfvkg+MttPbhN
         sbSHcGaUqLJt0amua1flhm9a27yh42PlIHS2B10UGvR8Bu8mmliJTxFIhWxxMHNWdRN2
         OK/oxSel3NTxK6znC2ZpddblVWSKqwupTd70sZJDgmg0WfqX0+NwPfV4UFMk4QmNhnuR
         ofL6SWRB3rBfPeFCIGVsO/m5IfkKZ4dp7t/ItY5N3DVAdwwuZ1yGdShGMOCHMkJz/oPD
         TABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ftpvwrbIZe1H2l1L1G2BWdwwGf3+rjIyItX9McWhd2Q=;
        fh=sRZqwOqEJsXlaKMW5JUEYaktFchZ9V2BVMHBgo8G4Uo=;
        b=REApGif1OBD2CvMnNGg9SlzBjUIgWZ2HH55ktryrZc96Uvi6dkQ0ZV7rGcW2XfGT2n
         pJA4wGKhocDV+HQpkWPCAkugA/Ay0Fsz3p7jCRPGAFqqq6fLP8RHrptkAO1rNSvJIVhg
         vDTCj1HXORgNXmDV776lOeRUTT4uSMNwRZJnq/DmlCbvbfApCICcYdM+7nNOLslHsI8w
         WSpZu+oH4hLfKK3eMrXd4fARrUf8iuN5hAL70tIb0x1QTNmIBKhdU2y11GeWAWlt9+WZ
         s5MCQ9JH4Zw84DOqOd7wB5+64rcCfJQUTwhOGsHnT0nml7K/7mPJAx901wrIiV8esZ9+
         A6fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780752502; x=1781357302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftpvwrbIZe1H2l1L1G2BWdwwGf3+rjIyItX9McWhd2Q=;
        b=fwnjbo8+tgDy/gssZiPKughL0oBbgJWJlJ5FimmpMQ66b2aAVuHeqb7W4p8ir9PULS
         841tJ0i/dMmvQGAIAPXnrmPNnWZldBSHdVDWCi2YsDmdb9mWbxG0/WywHAxyYE8Ca/mf
         DpWOGRvbe3kbalWU876HGMOJwcYAFmnwgXBvHI0mSRtCYfiLfDbIrLoezdw6hQmylGFO
         XXMSShHHGCubv5hjLdY6wHtHgfvij/V8hwTfvm7QPfUQTbWpdDTtIv0Wfo4gPqRtZToN
         KDPh463nMN8I0mR9P+TsNFjuC8kquX5HtkE6zh8ZFGmduF7hkFrPmYeWb5Ehq9Kx+Dg7
         qUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780752502; x=1781357302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ftpvwrbIZe1H2l1L1G2BWdwwGf3+rjIyItX9McWhd2Q=;
        b=LUZKszDUJXaxXTBmQRALs7z6eA3HSSud9Nh8IEYgkVGAGSus1W9ymVaWCSOQMuBiFP
         k/nGVkqSLvpAPvrM+LZMOuU4Lo9bE7167KLVr8LE/Tmw/W2qWsnQlYqIVdUsWPBHD3l9
         7rXSuYPhmhR98W4mxa54I/J7AmZwL3KAfSQFB9facBFoGxfsvxO/l2Kq35Esia214mN8
         OsP0oY7AOCkKS80X6YckgRp4mPPAuqab+pb4aPESfAW92gPaHw9ZWErtAUrKwZDgdJbN
         Jo7TOmMGmXZveFPbbBcRk3RAK4ucPoO+jJpC+6KEp9AR/tqmDxKSUTgfD62gh/8mNSG0
         TeGQ==
X-Gm-Message-State: AOJu0Yzv/i16TC6FfdG8IlUPc8BG845qur7H3SzhmtYvyGKxvPjvdHwT
	/TGlm8rAg0o8ZTUkuWzU5abC7nzvKr8Ey2VAeHFrejunSa7tJbPZey+swm0kZnnpW/FfzhNUEdx
	Ong+Eyv9vPpqsiVBhdkMQS684F6eY34DE+DsU+NMSi907YjhhdkMybeoCcEHcVl9QbhIRqZzc3x
	4v1X1JwmSAWpCz6NrVj8HEE51mA1761GbvCJKIIAWOrGGz
X-Gm-Gg: Acq92OEJPXxMGmF8g8Pw36LjAMZX1UuQza0MGsv/DZ0a35o1pdoYVAiDm9+7ueAbF3g
	RLKlYrlZ9WHezZNzSx4vafJXl93vT04AJyd80XSnhqsK85YpHvB+tTuG0X32L1CzXGdnEiRJ//4
	0FN6imp96n0uh1OPpXSTe9HJdZnO0/kdOqtR0RSi9bL7cc6GQbbCH5BqhPiDK+F+Nn8YCzB2Xry
	gK9f1OclatMe9pK9hNenCPbacbcK6/XYvz5cIU6AX8kqXTQEInOwxGj2k2FA16LKEQGoCHPk4hK
	KC4/Sras9YH/1YWYfzv664nhihE9Zt2J
X-Received: by 2002:a05:620a:1a1b:b0:912:671b:d09f with SMTP id af79cd13be357-915a9db8eedmr1307055785a.47.1780752502199;
        Sat, 06 Jun 2026 06:28:22 -0700 (PDT)
X-Received: by 2002:a05:620a:1a1b:b0:912:671b:d09f with SMTP id
 af79cd13be357-915a9db8eedmr1307052985a.47.1780752501778; Sat, 06 Jun 2026
 06:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519020317.635011-1-rosenp@gmail.com>
In-Reply-To: <20260519020317.635011-1-rosenp@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sat, 6 Jun 2026 15:28:10 +0200
X-Gm-Features: AVVi8Cfov0hJtM1RaLauIlXQw3yxi5-k1jaHlKmzIXfQPLeg2buRwJdbtRSJN4I
Message-ID: <CAFEp6-0G2SYg0v2xJHjTAekPkBbris7RiFbfBddc3iw3DvCdOg@mail.gmail.com>
Subject: Re: [PATCH wireless-next] wifi: wcn36xx: allocate chan_surveys with
 main struct
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,
        "open list:QUALCOMM WCN36XX WIRELESS DRIVER" <wcn36xx@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEzNiBTYWx0ZWRfX1cS3O7Vv/Rai
 a9WTWXhWiQ0BWtFp04MumKIhQYRuGvOzxy9A5hapRgWqDQHRVq7XxrvBtKOui0I8vzDGOBXD+rw
 cYQ1Yk/Ke0qAXC1vqUjuvyDCR/Lh9O+FQ9OLDclmbb0OkD01jVijpcH3JeSd+ZPsYOkpJd8A0Q5
 qXFRpbWuQg+XHXelOT4C9D+kjFv+ajaZ9tiTOZdXe0L3e5KmNQN9qw8juICxU62GN8Eop/J1u0e
 TSUBpSSrx5FusUWb9TIlb2Z4EQREqzbq0TV+AAL031rr1Xx7rOGsyojbbBaQV6XoJJt23VFCr9F
 Ak/lZV16nMYadzBg1MxysFGILcySSeT0TmzbKSxv1ZN+Wqnr11S8bBFNgKEF79EWhVgHxv4xLFf
 EaPuiFFmBsFh/HZHvd1zL0rVu6DHRDsBWU7HxeB0bUUL0WvViEpuaScbgizB5/RbWYLi/+fbwtj
 axf2BtqwqBkeI/KJleA==
X-Authority-Analysis: v=2.4 cv=B5eJFutM c=1 sm=1 tr=0 ts=6a242076 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=ai5p6xNhIYTwrweCe2kA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: WyrJpDRP9aB8RIgsU6QZx5qu2-invhM5
X-Proofpoint-ORIG-GUID: WyrJpDRP9aB8RIgsU6QZx5qu2-invhM5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060136
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37450-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:wcn36xx@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FFB064DA1B

On Tue, May 19, 2026 at 4:03=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> Avoid allocating separately with a flexible array member. Simplifies
> allocation slightly.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


> ---
>  drivers/net/wireless/ath/wcn36xx/main.c    | 13 ++-----------
>  drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  2 +-
>  2 files changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wirele=
ss/ath/wcn36xx/main.c
> index c3f0860873de..ad8a4bd910d2 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -1568,7 +1568,8 @@ static int wcn36xx_probe(struct platform_device *pd=
ev)
>
>         wcnss =3D dev_get_drvdata(pdev->dev.parent);
>
> -       hw =3D ieee80211_alloc_hw(sizeof(struct wcn36xx), &wcn36xx_ops);
> +       n_channels =3D wcn_band_2ghz.n_channels + wcn_band_5ghz.n_channel=
s;
> +       hw =3D ieee80211_alloc_hw(struct_size(wcn, chan_survey, n_channel=
s), &wcn36xx_ops);
>         if (!hw) {
>                 wcn36xx_err("failed to alloc hw\n");
>                 ret =3D -ENOMEM;
> @@ -1590,16 +1591,6 @@ static int wcn36xx_probe(struct platform_device *p=
dev)
>                 goto out_wq;
>         }
>
> -       n_channels =3D wcn_band_2ghz.n_channels + wcn_band_5ghz.n_channel=
s;
> -       wcn->chan_survey =3D devm_kcalloc(wcn->dev,
> -                                       n_channels,
> -                                       sizeof(struct wcn36xx_chan_survey=
),
> -                                       GFP_KERNEL);
> -       if (!wcn->chan_survey) {
> -               ret =3D -ENOMEM;
> -               goto out_wq;
> -       }
> -
>         ret =3D dma_set_mask_and_coherent(wcn->dev, DMA_BIT_MASK(32));
>         if (ret < 0) {
>                 wcn36xx_err("failed to set DMA mask: %d\n", ret);
> diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wir=
eless/ath/wcn36xx/wcn36xx.h
> index 7ee79593cd23..8c43f67bd780 100644
> --- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
> +++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
> @@ -298,7 +298,7 @@ struct wcn36xx {
>         struct ieee80211_channel *channel;
>
>         spinlock_t survey_lock;         /* protects chan_survey */
> -       struct wcn36xx_chan_survey      *chan_survey;
> +       struct wcn36xx_chan_survey      chan_survey[];
>  };
>
>  static inline bool wcn36xx_is_fw_version(struct wcn36xx *wcn,
> --
> 2.54.0
>

