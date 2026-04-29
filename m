Return-Path: <linux-wireless+bounces-35589-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABIqN9fb8WmnkwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35589-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 12:22:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68166492C42
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 12:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EDFC3034B3F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 10:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E363CF037;
	Wed, 29 Apr 2026 10:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="doydujjd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jZ7yTKm4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48B37A481
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458076; cv=pass; b=EP5abWtnywohIBRMR4DnXl1YIjaufLr3DIBfy//mvdF3FL5yU46xPD6NaQFuMfSETU6mSmRoFR0/88bDlkSZtp3aOgmgh1smhSNEF1WNOSmWT5FnbhtWOl71o5Ri1p1XBcfQhia5MOa3ZWjXvub7nIRoUs7UjDpu3jH8n0/zSmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458076; c=relaxed/simple;
	bh=nJOsaDRI9FyGGz3uUrkausUNU37d7Vwl97st4xCtCCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/wG7BZGE0+z12arlDzz3aOFQwGzh4ueBKdq+RbeNSnJvfF1UQpckzcCgws+Xjw32hp62Zx/0cdqDlEXijLgFoTwbA5IvC2vwoFXvQRCOMAt6zB19qwDsXBLWubs+iY4ZSPoNZjOfCWsDlS0sfYcNKbBau8Ft7RoK34ysgSWFj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=doydujjd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jZ7yTKm4; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8plcf3752353
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 10:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EqPXfsDldmKDtaexeIATflIY3d4tt42HuNRlmb0wOcg=; b=doydujjdk7ha7tAY
	TSfnhBDrmSGLrwfjnnmlyv/Wfjz4b5RiY6Y30BPBE311KdAreOIxVHXcDFjoz1W5
	25Lyc0lNvy91rdsaPOCcjsbeRkgsNWRi4+0I6rtEFl1ofMM882OBz2COQCCHvLjr
	SSvmxxYR7Cbpr01/sf0Pu/Ne8Hw26ou76GmH0mz7y4QRN8i6Hw/rsDhJe0xMTYdH
	viuP7GE1taUW5PtZFpHs5nVMQQKAgF0r7Gd/onRR4lVBpj5DKFpzXHKXZ77ib2EU
	hTUgNUeyKlTjR7kb7H88v09Qa6aK6a//m87Q7ZwwDRRiTNgoFSeSFNh96/nVBa8P
	heAFaQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duch1h26y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 10:21:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8d654ade33aso150577985a.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 03:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777458072; cv=none;
        d=google.com; s=arc-20240605;
        b=MQ3Y/nyBvkuTxkUaDCi8Yh4kSLzS0G5eyKiIj7OyhpH19IH82ilD+g9o6JRk00X51+
         SFYNVBVawTYXSGgnLqeJ0Xv35qAdBr38wtnS3fj79uB25NnfuFeqomHx31XIUoX6wtB+
         yrdB/54HI9YHSNKvDPI84JMWCXdW174Q7fc2t8hwY9y+WEuu8IxSB4h6uiFFTqd+lvxX
         eLDZHjHKDp9VqDwCAlowdNv9pnG4aOL+qSYl1pt058P2TJzJH97SM/wN8bqpXQdy8i/Q
         jwY7bN9m2urjdfVabI4FMJy9y6vDdRE4mA5x5XE7WzXfeO5SY7ODzYr4Z5s+PuedkU6n
         wUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EqPXfsDldmKDtaexeIATflIY3d4tt42HuNRlmb0wOcg=;
        fh=wPhW6r4yg0bGTuYN/F40S+Aj754G738Aechei6YzM+E=;
        b=GVHfE+94QbeCbjMY2RuP9M8/oFyxm5bTx3QrJpXt96ylP5q6buEP2fvGLuJk5xL7nQ
         uIe1IEw+FPq6mIsTMx30AfUQ7HTfB/g1xqbX6vF7W6jvva6MGEsxmZDu/Hdc08fmjc+6
         Vx/8l+Pe8Z0lfH1zMvQ1HX08J4GW9VqzjrpAK1O+6Sfxk7TLUxSPeZHUXfyUXN5fiAte
         QKreSrmovnXMgheHbos5T3+NHTqFvihZ1fFNCDikZ6RvsSvQfxVASmM0asIJO1lrpzeu
         cEJAQXs9xOrZdhZemLKQhoclOdwITINnXZ41T4sSYXHwZVX7pxxtJ6AeKuZMOObz47+N
         nZOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777458072; x=1778062872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqPXfsDldmKDtaexeIATflIY3d4tt42HuNRlmb0wOcg=;
        b=jZ7yTKm4SWzgT2qPDcgOUlu+6he/d5965nLC8kJJLFl8TCB9qaQVT4LvAADT5gNADp
         AJy0RTxm5w94z33lRrj/xUbW9iSCmyDLSO+iJX196VUD/7s0k+FVLrCZjfcymHR9PQ/m
         aAChsgigB8rtX/5YqDjO8BdMmFFMa012p3Sn7kDhA4KcwulrUz2oplTWGkQ3v3sxpz20
         zcvlWLPzgHo4lEyAi6LIseyxE6gIBvvKbu0o2PjwyijbBtMNm5YzlXucj2i6cx9Z713d
         8JsTrpCD5DbwH5CPd50pnSLVPAOZpe2Q8leVBYCnOVxfcbgAyeopUSWnEzrEnNtQ3Z9k
         drHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777458072; x=1778062872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EqPXfsDldmKDtaexeIATflIY3d4tt42HuNRlmb0wOcg=;
        b=j73FicAcLqni7YgFPBmM8kFujVjxGxdLcGCQ5Oamr8y+TyzzBJHkjQaLzWQCLdKesm
         eCFx7llaYmBQryBD83fpcMnij/wxFEuUWgr5U/T7FaH8Y9a19pO5Itgc/xuF5kGnKHDJ
         ov+G1Sp8sDtc6dcnC5Xo0kIsn2G4jJJPEnoVptjjyDN6UfJ4A8a2dtRWW/+Rtyw0mrJU
         uAam8nqBsRHpGAAprSe+7OG02Co/pK3kULSSq++dh5Qf1fv/SHggPKkb11ftZ8PEEo6O
         mrv4SZDZg2bogP4yTo4/9glw6TsC2iaJj5QA1tDrTUFmwrRh/RCDJA3Ild0mFtvPJriQ
         /Iaw==
X-Forwarded-Encrypted: i=1; AFNElJ/WLEZnVqruRJtAaNk40zEnb+4pQ0IAVujff+gwuckKLgibpHBBE9Y7h83o1qpsc9rgEseaQuLSeUozhSzbjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUIXQwYLWFWGJxsm5NjQfiYoODCbK+JJhVhBYDntkTAjiVLDs3
	CiHlwYI89hwUOp+u3AJviOCbuRe3OXeQXILkg2rjK3+jP0LyF2wequuEGhSDXYNC2FG9MmSR+4S
	RaSnVQisYtFb9vLrvD/WvIze2g6oDy4JJyfNzPryE5EKZPvFg0qzRGnv0fOYwsohCjuBZDLB4IO
	dix63hEXrk8hBojjz+OFyzJdgmACtRRDnrFhkwH/6lvpqZ
X-Gm-Gg: AeBDiesyj4dYgkJOocoIyWFm/XjSGX7rtVevsW8x4XR9WHNcRmIUznU8UQFab72zT3n
	NVrZD9xtc++pJZ8pQn+wcnUzob6BmIzeQrebajzHpM+BJVf3dRdw6G1ODWAVSUnzUNCEoJ05KR7
	HV20LtPmu32O6n+zlJ1oA2BttkRqL2+aPdxbrcQk2YPiamUJ0zKHI16ptT+TYGa7DTdRwHURUxr
	7hQe8IVWyMQgS2w22ChbL/L+crc0NCdBif08B53XtaU7Da1mw==
X-Received: by 2002:ad4:5ece:0:b0:8ac:a266:ce34 with SMTP id 6a1803df08f44-8b3ee94eb56mr37705066d6.3.1777458072388;
        Wed, 29 Apr 2026 03:21:12 -0700 (PDT)
X-Received: by 2002:ad4:5ece:0:b0:8ac:a266:ce34 with SMTP id
 6a1803df08f44-8b3ee94eb56mr37704726d6.3.1777458071852; Wed, 29 Apr 2026
 03:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428162955.614739-1-arnd@kernel.org>
In-Reply-To: <20260428162955.614739-1-arnd@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 12:21:00 +0200
X-Gm-Features: AVHnY4KAGHRU3K2zVLZUPjwJZ2lqVuCedzWL56hrWlGIvT5eUNqk-96KAVnrdVw
Message-ID: <CAFEp6-3Ubj+MSvF-4G6OnVY9gdvfzq2Cmcr+OjzgSB6omGAWCw@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath10k: drop gpio_led reference
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Kang Yang <kang.yang@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Sumanth Gavini <sumanth.gavini@yahoo.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=arGCzyZV c=1 sm=1 tr=0 ts=69f1db99 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=g4MlGQxAURbjKKzBZy8A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEwNCBTYWx0ZWRfXx9e39hTKNv/q
 ATb9eLYTZYUF37JOp4mXNJwCOyUTh5LUxnbq7tPosJSZMNJlL9uke2aG9N/TMxdyt91/HH0WbYw
 P1P+H6mGQaJeqjv6GNxA6XocYDOUVgbmcoeslMhob0RqsHbFy/2L0dJGqxg+iJShg+pMYf8XlGy
 zmcHupWxrnH5XGvs5pSe2/SN+W4bPr5ArHn3BoILvJzFJ3K5rABnGAfBpkT2F8lpejv+rXHKHVE
 x5idYSigD85GUgwp3av9j7AMNWj+0btq4BaLDadfxdvQCRPYLcnEsAXZgnOY6sMdqzp4CHcFiNg
 Z76kLcYF35YXJJE9wVz57Y1b+YiXXhWPc5ztuKgxdBHyFMR10QbCqiOVG/0ZsSxkLroMLiUrED8
 nuVOyvHhOWvIJivydnpfyw/bKN5fy72ECkwUAxBVAxdx5Byaz9gUFUcBTB/mLFs/u81+XoqNAOd
 h6SPnnwZh1EgFv1uk6A==
X-Proofpoint-GUID: zsbocUz6AbXjE2cx3k0AJVE4w9MvmeBs
X-Proofpoint-ORIG-GUID: zsbocUz6AbXjE2cx3k0AJVE4w9MvmeBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290104
X-Rspamd-Queue-Id: 68166492C42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,oss.qualcomm.com,yahoo.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-35589-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,mail.gmail.com:mid,arndb.de:email]

On Tue, Apr 28, 2026 at 6:30=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The driver uses a 'struct gpio_led' internally, but does not actually int=
eract
> with the gpio_led driver, in particular it does not actually use gpiolib =
here.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wireless/ath/ath10k/core.h | 1 -
>  drivers/net/wireless/ath/ath10k/leds.c | 8 +-------
>  2 files changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireles=
s/ath/ath10k/core.h
> index 73a9db302245..dfee432615eb 100644
> --- a/drivers/net/wireless/ath/ath10k/core.h
> +++ b/drivers/net/wireless/ath/ath10k/core.h
> @@ -1269,7 +1269,6 @@ struct ath10k {
>         } testmode;
>
>         struct {
> -               struct gpio_led wifi_led;
>                 struct led_classdev cdev;
>                 char label[48];
>                 u32 gpio_state_pin;
> diff --git a/drivers/net/wireless/ath/ath10k/leds.c b/drivers/net/wireles=
s/ath/ath10k/leds.c
> index 3a6c8111e7c6..a3961e7760a5 100644
> --- a/drivers/net/wireless/ath/ath10k/leds.c
> +++ b/drivers/net/wireless/ath/ath10k/leds.c
> @@ -19,15 +19,13 @@ static int ath10k_leds_set_brightness_blocking(struct=
 led_classdev *led_cdev,
>  {
>         struct ath10k *ar =3D container_of(led_cdev, struct ath10k,
>                                          leds.cdev);
> -       struct gpio_led *led =3D &ar->leds.wifi_led;
>
>         mutex_lock(&ar->conf_mutex);
>
>         if (ar->state !=3D ATH10K_STATE_ON)
>                 goto out;
>
> -       ar->leds.gpio_state_pin =3D (brightness !=3D LED_OFF) ^ led->acti=
ve_low;
> -       ath10k_wmi_gpio_output(ar, ar->hw_params.led_pin, ar->leds.gpio_s=
tate_pin);
> +       ath10k_wmi_gpio_output(ar, ar->hw_params.led_pin, brightness =3D=
=3D LED_OFF);
>
>  out:
>         mutex_unlock(&ar->conf_mutex);
> @@ -63,13 +61,9 @@ int ath10k_leds_register(struct ath10k *ar)
>
>         snprintf(ar->leds.label, sizeof(ar->leds.label), "ath10k-%s",
>                  wiphy_name(ar->hw->wiphy));
> -       ar->leds.wifi_led.active_low =3D 1;
> -       ar->leds.wifi_led.name =3D ar->leds.label;
> -       ar->leds.wifi_led.default_state =3D LEDS_GPIO_DEFSTATE_KEEP;
>
>         ar->leds.cdev.name =3D ar->leds.label;
>         ar->leds.cdev.brightness_set_blocking =3D ath10k_leds_set_brightn=
ess_blocking;
> -       ar->leds.cdev.default_trigger =3D ar->leds.wifi_led.default_trigg=
er;
>
>         ret =3D led_classdev_register(wiphy_dev(ar->hw->wiphy), &ar->leds=
.cdev);
>         if (ret)
> --
> 2.39.5
>

