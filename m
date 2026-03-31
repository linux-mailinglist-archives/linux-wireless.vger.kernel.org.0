Return-Path: <linux-wireless+bounces-34219-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDzKK5Dty2m5MgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34219-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 17:51:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 564A936C20E
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 17:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EA093096828
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF20411627;
	Tue, 31 Mar 2026 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkOO1ubW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F793A1E8C
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971618; cv=pass; b=Xq/2ACyylg8Y7KyGMzIuoHVTAnJF5fMV2o6FvJXB7h39kFcp0TVXyACgv+2tYdA1oOxSBVUSzIMqC63URR8ZaekmBQCRZ1BG04Ys/ZFL+LNXKqX4otgVFAz7xCqopBXLLHJkEuuS9KG/O7nxTxADfud9yxkmaMQB9jce5juuViE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971618; c=relaxed/simple;
	bh=M86POBW/a3TsEts6tVZ7TB0EfrjJxMIvFGo4HhkDcK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvzUGTRtLC2KRjOSTkZuhzg2QNIarIDPRMTvJZbJVJqELfQl1w532YE2ivTs2UjaVclBzh4OqJ5MTzT27glK0XkpQMIiWrV2LaufAatkria+JoC+qBE+z3UX2LeDUQxIp0p2Gi4n9njkhndZqiXB4MkwvmmVad7gZZoTm2XfHqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkOO1ubW; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-46703fb602fso1912873b6e.0
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 08:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774971616; cv=none;
        d=google.com; s=arc-20240605;
        b=fXo4NR/DaT0cLU/qTKj4A3bCb4JTubVKfx7n5NRDArUzValoXRVBluhlxzm87swpI3
         aalriC7F1EZlxmei4nKv9oTl80K7iJq4VgAhtzRZWti9t7ZjDtykxaLxAq0Dm81QE23k
         m6+ufS+XpmOM7seLJqu0cTR2Oti/lSIFC/Nfmukkz3tM+qbQ0cKCGKmQ+wO9FCEDwbt5
         7mgSPXSWHuH6hjlVLGk2sJsbeikgv5pbcZHyADv8A3J67RJM4ZKtnVmHPlXbMlaq7vGk
         Ul+/NBoFw9CZlUeXbxaupaKkcwG+/0xrBEpHyZNzI6UQ3NY+N66y8tDFOeDk+x0I8dX+
         yA/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u8qcruLr1TaN4a3nPxJC8zeje2SUnWQJ8J8aOZ6a6Fo=;
        fh=NicHWZbL8t99aLQEuJkfaapDVZ+3fW/5NJE5ikCz+u0=;
        b=IqiRKIXEJKpsM+ZwKYT+Om5Fw0fQKexyZwR4u30Ei5URIDhmUgsThwt+hhRR6kCn0f
         MSrVpB/VsQhCzTSzQzvYSQsqacu9Gof5sHTK4gbGecRfVctfR4o/FHW3wq8hkUZR/g27
         tbv3usJF5WASxSbZlyfCE8r737vkbH6bT0ye59GP6PNQCA2mDFHyUTQ4bnaO+auDSHuB
         dzMXYRG31o7cJw6OuBkGS/fHpxEgA2AwFJ9jibLL94Bt0UQgf7MhGje/n69r38IOV5mN
         KWA1AsWzYt95k287CG7kKKxxEDm6HPpLUyXTPrQJjmzm9QlSH6u6Dua+0lDa27+5fME7
         24cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774971616; x=1775576416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8qcruLr1TaN4a3nPxJC8zeje2SUnWQJ8J8aOZ6a6Fo=;
        b=nkOO1ubWeSgBynejD6YjsUMf4rGxqUG52/z/ZMrxG8uCSmw+eUI0nRSh6ranGg7xjA
         zliEmUdzHmYndZvYeOoDTCTqQV6YtkKQI8Rnmf5fPEXX7mMhcQoZyGpEYT57WMAf5M8p
         /GOTZ8DxjEy4Yf92ts63IfA0BrZEvshDztmLNQoQ1zFzhxslHxcE55TNepseMr7TTjJU
         MgLjevZbRop1ZLsN1V0uGh/mMoDei9iXcetugblwbhv8ARWQcF0AQPFS+IhHnPxyX19S
         ytE1bpXUTWJ99bEuKIbTUGW57qbJjQTft/dziHHrKkdB7NsRazbpj+sKVoUHjUX5PGbe
         Ch4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971616; x=1775576416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u8qcruLr1TaN4a3nPxJC8zeje2SUnWQJ8J8aOZ6a6Fo=;
        b=WlAICfTe5caLET5CVB8UnViTPMidrk2IfuG3liv48DsPFU2p43Zloi8YmhP2iYFjvL
         wzotvhW0uZNSbuK3OXTK/G7sh6yCjU2aB3CqWu+Aub9f6ErIewY2VCiG31jSJYgfE6z8
         LPlXawsXoB86GkwI6pF0KtvO/QaKn7UjdCczn51ssRmsuTEyhkZUcxNynDOoDqtWuiqz
         uwLyV4b4R7P1dXx3nXtM/iY7mOQcVPWLXcm5Lq7gL5VaTPLuGTrw6ObsZH/gLT5U4qUs
         C02tgqicz9vOta1A4U1WLcZc+jPRkfQ47e7FfXkXKOp1bhfEwHEy+xGMcWFNnbQNBVgh
         42Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUtNx7n2+B5+pCCpcJbyEbqfMdiG2mI0122iM++JnmOhCC2q6m5K8BI7i9KRdyLcZqU/dA5M16TBE0x6gUgdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg5SxR1ksomTzkRqEjT/JI9vNHcIDhPul9JUjyPf1mblvLhbl8
	fPGVXwadqrPpv7xqmgD5VMcXMfaDnFBd2a4E8wN/1QjfHl9qCp+83lQsylgAn+sTFgQpUzx/0WC
	WDlksF595yVnx6U6AiSBIAHP4ANbEmdE=
X-Gm-Gg: ATEYQzysPzJnQFlc3rOBhMfhQQh3BmPZC8TytahrTRUm6pvm7i7d/Cqew8iJF5TGKgV
	sjDqV19xiClhy2JXDMS2ZQXKZkdCnHiAeL1GjjED/uZ/QDw56u/aWYpC9OguxeJqKHNAfJQPcfh
	oB4oLBSCMGRmSiltoYn/Ara7SYFQci2hA8FmMgDdpnHzNFAkLbmSbKDlaJbEtWB97Ci5+tKgrVa
	dzFGvdDP8uInZl2ot34aQo4nAt6U0fiyOZzlXTIaZxQfpL7uYy5bCWIMKSRTlupj46MqjgyQSaS
	Gv+U8FK6aNY9UoJfmFBsxZxl/UPVoBWo/Wu4PQlaKtvINh8=
X-Received: by 2002:a05:6808:1718:b0:468:48d:8075 with SMTP id
 5614622812f47-46a8a395fb3mr7995552b6e.8.1774971616516; Tue, 31 Mar 2026
 08:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-p14s-pm-quirk-v1-1-cf2fa39cc2d5@gmail.com>
In-Reply-To: <20260330-p14s-pm-quirk-v1-1-cf2fa39cc2d5@gmail.com>
From: Kyle Farnung <kfarnung@gmail.com>
Date: Tue, 31 Mar 2026 08:40:05 -0700
X-Gm-Features: AQROBzAt-wrDIMtX7p-AOcDjVXjahzEybmuxfvEKnbowGjaS1uRal6qZfRUGMgw
Message-ID: <CAOPSVF3tbkTVjW1o1NfrgbOA9v163n_QuDR4ay2ggdMs5f9Z0g@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: apply existing PM quirk to ThinkPad P14s
 Gen 5 AMD
To: kfarnung@gmail.com
Cc: jjohnson@kernel.org, mpearson-lenovo@squebb.ca, stable@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34219-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kfarnung@gmail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,lenovo.com:url]
X-Rspamd-Queue-Id: 564A936C20E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 11:18=E2=80=AFPM Kyle Farnung via B4 Relay
<devnull+kfarnung.gmail.com@kernel.org> wrote:
>
> From: Kyle Farnung <kfarnung@gmail.com>
>
> Some ThinkPad P14s Gen 5 AMD systems experience suspend/resume
> reliability issues similar to those reported in [1]. These platforms
> were not previously included in the ath11k PM quirk table.
>
> Add DMI matches for product IDs 21ME and 21MF to apply the existing
> ATH11K_PM_WOW override, improving suspend/resume behavior on these
> systems.
>
> Tested on a ThinkPad P14s Gen 5 AMD (21ME) running 6.19.9.
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219196
> [2] https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thin=
kpad-p-series-laptops/thinkpad-p14s-gen-5-type-21me-21mf/
>
> Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machine =
model")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Farnung <kfarnung@gmail.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireles=
s/ath/ath11k/core.c
> index 3f6f4db5b7ee1aba79fd7526e5d59d068e0f4a2e..21d366224e75904feeae6cb9c=
93d9ef692d127fe 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -1041,6 +1041,20 @@ static const struct dmi_system_id ath11k_pm_quirk_=
table[] =3D {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
>                 },
>         },
> +       {
> +               .driver_data =3D (void *)ATH11K_PM_WOW,
> +               .matches =3D { /* P14s G5 AMD #1 */
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
> +               },
> +       },
> +       {
> +               .driver_data =3D (void *)ATH11K_PM_WOW,
> +               .matches =3D { /* P14s G5 AMD #2 */
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "21MF"),
> +               },
> +       },
>         {}
>  };
>
>
> ---
> base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce
> change-id: 20260330-p14s-pm-quirk-0a51ba19235f
>
> Best regards,
> --
> Kyle Farnung <kfarnung@gmail.com>
>
>

Apologies to everyone, I realized that I lost my CC list in the sending
process. I wasn't sure what the right fix was so I ended up posting a v2
patch [1] instead.

[1] https://lore.kernel.org/linux-wireless/20260330-p14s-pm-quirk-v2-1-ef18=
ce07996b@gmail.com/

Thanks,
Kyle

