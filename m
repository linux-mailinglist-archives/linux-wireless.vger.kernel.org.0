Return-Path: <linux-wireless+bounces-34254-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7Xx3LLiVzGkSUQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34254-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 05:49:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3828374851
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 05:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4464030115B9
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 03:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E68367F4A;
	Wed,  1 Apr 2026 03:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4iyB75C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F14935F5E2
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 03:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775015349; cv=pass; b=fQDOJhrZ6IMGx+EiS/zikSrXewrFXUeGNfj2ZGkebsBqRpXVz14EsEIrvlTpd7gNn0EZuttVa2DPlKDyAeZMFl7kIVN7XVfHFsKXlKiX40HefWkYp5ziraGMwPQssYB2qwv7nB7ya5Nogvp+YMJSzFziAK/9oOz38ngz3d94NuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775015349; c=relaxed/simple;
	bh=Uq0rAon/XHdmSSBnTga+GiKV88qppyF1UmfrhXcY238=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rv2/VVtMRasQ0hSVhwCSTR7dF89ffnhOtH0+ZjqxA18vuAZ+MaMBx192RkysktuHvLitiG7gM3kGUbHKOfu8P2lFahRsglXsh9r3o7B6N7Ocy72ky8a8myPV6F4bQM3w10wTm8r/0Ig1t4djCf16jksVIP3QssiPSRFJJgdZSAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4iyB75C; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4670676ba03so2091665b6e.1
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 20:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775015347; cv=none;
        d=google.com; s=arc-20240605;
        b=etxJqtlJfYcIWNQGXd3xMjTyr2r/Uo9nXOHP7YqPoIjmcM93opO+I08vRPRqCat3dj
         BmLRd+Q6RXT0KXQFUWPsb6mFXUxOv0FIUgWk5F5fZdMBNQmic49KAiSrfiNSKHaO140v
         ImAhsXZEdx3I/T+hTC9SUCj42BPgVXdNDhnqTmB1f+u9HVi9Y8g53rJgh3uu8vSSsAjY
         f31zNfkqoaT80JRdQdrbMASfEhfD01dvb3W6SV0fns9PgC675L57wLqNJ8JF8aMzbHfH
         Hrx/E8CjhtVES9vBJumhfZgW6JALGuLW/0WxezzrAryIe1zrtaQ/j1/oRHy3S+vt+7Oz
         6dbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0+OMXuhs/r/8PL00D986h01bobDw8jDu72xUXKqnjVQ=;
        fh=/K/5b9wNKNhl5g8dRDxNVAmjyyft9mx51QqFREFKokc=;
        b=Ysemtyo9tthfCveR24npCm+4cP7MpUhswPWhA9YB0TEpHfWpVU6XM7uG9YCHnzyhhX
         4OrRkcVfMUEhcbVjf+auQRS31ysccgeH4mlhxbtVQ9y5t1NAVXzBV6fz0po+06djQFlc
         hege14dtP+teyjUuOsyd0nBG1l2hgGAfV8M1BTzw+k7wFRjXW6jaeo/l57S5y8Y3lY7U
         41ZUvsZDoni/QqoO3bOEWzJisYNf4OZrHp+wFourqd7pIaPgk2oqCHEku3yivSvCzKam
         PIrjrQoc1rIgtHyeqTMuUilGA8b27QCg0+1VqYPZKVKiv3uP2FQS/GB9umOQAwpmlytG
         f8/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775015347; x=1775620147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+OMXuhs/r/8PL00D986h01bobDw8jDu72xUXKqnjVQ=;
        b=d4iyB75CzkvvBsICj2nOKenaGWHUbaFzrQYt8Y0OGdP+cTP/LrOLMv8/kUBfv02Bcz
         ftqEjLekOaNyHglyy1U0f9ffEj70WsqsU170kRbmFAr7WK+KqV4LzBMJJQjfUTXURsng
         OX2ag3D25elhiL1KwnamSpd2uc8vpMbPnL2CxhFuLMxGTQNStkutY5GpLbDUGD8xC5Xk
         1KWdCv9FdNUoTJUQCuBIefqh2MEnxox3L8zaWJ7KztfzZL4IsnV7snuHrBzev6H2gt6p
         qUZAJbYm/g570EHTONnFp0WkosjIgVjNwfSL3ERSJbG9X1cBaWR9kASQXnosHPnym5JM
         MqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775015347; x=1775620147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+OMXuhs/r/8PL00D986h01bobDw8jDu72xUXKqnjVQ=;
        b=PTc/it5oGBC9ykQpyxPBoUpnii4j2LABEw7GNyeoyIyZWh/4o1lmNhbHJSGV6BsPhM
         eMy3eBUaW6+2T0boQcwjQrRTuMIXk4KaO+UEJi5tZaxQ3ucZAUUuw5w6C6ZK0uw3aRcD
         q6tVKceuT+1tv6eA10YKZ4BvFRlHTz0qnkEa20Zep85PwMuc6EOKQ1lbyTOCvHZoTMIi
         ffMo4xPaAO0wp13Ndj/CyqlmTeYAphEADoFtQB3MLIQSpDQI11XgxvLHbqE389ZH9JlC
         bvNJH13QDA0fdeC46HFeu/M3t+Zc/xs9HOI7EDuunu6fB+o1QGoV3V2jTnlyLFZ32Ss5
         reDg==
X-Forwarded-Encrypted: i=1; AJvYcCWVNyDg3soBGI5LL8v5UjFZh0m3ySf3p3KlrWHia29xATeiRDBa7ikXT5wn51tAqxWl9n8g62hflCwi1lnV/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiU8tmPElDesu2NG/8Decf3amWXhrKUxqUkX1DHWzwpKXtB/zd
	NgCQZ6U+tkpHQrSgJkHUnSGmGQhqhnamg+fUZA1rXvPQGBDK3hM6Ie6rYp7w1UjLBkQzK6RHMrU
	dJgT1DPnpJgi2UxiBhvfJa3dGcuXvP7o=
X-Gm-Gg: ATEYQzzoOso1/MvOQVvzrAw4vlYHxxgg+1ymHIRmk2cH76sGaxHetROeuuwkbqtphG0
	eLxU0u0myDSas7d3Ood6OC3IpX1W2WVNSxdtbcmZsbgLr29geM7tR5G6OMZlrUQMFOVOyNYip6W
	k+e1/pnkhecUubec+/RWhuO12JT53GZJfZXJr1YAJyADk/eWCAYuWWwWji4Wi+nX1S+p5eNYx0P
	rKoGb+oCuyXcq0cdTNeaFkZepk7R5eJ/yys0tggC5yMm903dwZGqQaaJmXTgfIaL8zO614B3cMI
	qA3KmdiZ7AZkoOn2S2bLJS8j3WBNgppqWVu3
X-Received: by 2002:a05:6808:670a:b0:468:12a9:d54e with SMTP id
 5614622812f47-46ae01a4d6bmr959369b6e.44.1775015346973; Tue, 31 Mar 2026
 20:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-p14s-pm-quirk-v2-1-ef18ce07996b@gmail.com> <082b3d13-6fb1-4041-a187-fddec3b013e4@oss.qualcomm.com>
In-Reply-To: <082b3d13-6fb1-4041-a187-fddec3b013e4@oss.qualcomm.com>
From: Kyle Farnung <kfarnung@gmail.com>
Date: Tue, 31 Mar 2026 20:48:55 -0700
X-Gm-Features: AQROBzAgTA2ff2-kt_ct7XRR7Gwg-3n1Kuixh5FxrNWnH7tIskkJ04PtuD8AQf0
Message-ID: <CAOPSVF0VHR4BQsmfWFeFnANsQYBw-x7fHxH2JFNO=oWjgeS66Q@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath11k: apply existing PM quirk to ThinkPad P14s
 Gen 5 AMD
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-34254-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kfarnung@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,mail.gmail.com:mid,lenovo.com:url]
X-Rspamd-Queue-Id: F3828374851
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 7:08=E2=80=AFPM Baochen Qiang
<baochen.qiang@oss.qualcomm.com> wrote:
>
>
>
> On 3/31/2026 2:32 PM, Kyle Farnung via B4 Relay wrote:
> > From: Kyle Farnung <kfarnung@gmail.com>
> >
> > Some ThinkPad P14s Gen 5 AMD systems experience suspend/resume
> > reliability issues similar to those reported in [1]. These platforms
>
> how similar it is? can you describe the issue in details?

The issue is that intermittently after suspend my WiFi adapter connects
successfully for a few minutes and then drops. It will then keep trying to
reconnect in a loop but never succeed. A reboot will fix it, but eventually
I found that reloading the module also resolves the issue
(modprobe -r ath11k_pci && modprobe ath11k_pci). Based on some searching, I
did try adding "ath11k_pci.disable_idle_ps=3D1" to my kernel arguments. At
first it looked like maybe it worked, but then I hit the same problem
again. At that point I decided to try building a custom module with the
ATH11K_PM_WOW override and so far I'm two days and 10 suspends in without
issue.

Looking through kernel logs, the issue appears to have started with kernel
version 6.17.4. It looks like my Fedora install jumped from 6.16.10 to
6.17.4 on October 22, 2025 and I started seeing the issue two days later.

Here are the logs from the most recent occurrence (filtered for brevity):

Mar 29 15:26:24 kjfp14sg5 kernel: PM: suspend exit
Mar 29 15:26:24 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: chip_id
0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
Mar 29 15:26:24 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: fw_version
0x11088c35 fw_build_timestamp 2024-04-17 08:34 fw_build_id
WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DUS
Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DUS
Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DUS
Mar 29 15:26:35 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-CONNECTED - Connection to 68:d7:9a:2a:94:f8 completed [id=3D0
id_str=3D]
Mar 29 15:26:49 kjfp14sg5 wpa_supplicant[2373]: wlp2s0: CTRL-EVENT-BEACON-L=
OSS
Mar 29 15:26:55 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: failed to
flush transmit queue, data pkts pending 9
Mar 29 15:26:55 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-DISCONNECTED bssid=3D68:d7:9a:2a:94:f8 reason=3D4
locally_generated=3D1
Mar 29 15:27:00 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-DISCONNECTED bssid=3D80:2a:a8:98:26:3e reason=3D6
Mar 29 15:27:05 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-DISCONNECTED bssid=3D74:ac:b9:df:54:36 reason=3D6
Mar 29 15:27:09 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-DISCONNECTED bssid=3D68:d7:9a:2a:94:f8 reason=3D2
Mar 29 15:27:09 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-SSID-TEMP-DISABLED id=3D0 ssid=3D"Batman" auth_failures=3D1
duration=3D10 reason=3DCONN_FAILED

>
> > were not previously included in the ath11k PM quirk table.
> >
> > Add DMI matches for product IDs 21ME and 21MF to apply the existing
> > ATH11K_PM_WOW override, improving suspend/resume behavior on these
> > systems.
> >
> > Tested on a ThinkPad P14s Gen 5 AMD (21ME) running 6.19.9.
> >
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219196
> > [2] https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/th=
inkpad-p-series-laptops/thinkpad-p14s-gen-5-type-21me-21mf/
> >
> > Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machin=
e model")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kyle Farnung <kfarnung@gmail.com>
> > ---
> > Changes in v2:
> > - Fix missing mailing list recipients (linux-wireless, ath11k, linux-ke=
rnel)
> > - Link to v1: https://lore.kernel.org/r/20260330-p14s-pm-quirk-v1-1-cf2=
fa39cc2d5@gmail.com
> > ---
> >  drivers/net/wireless/ath/ath11k/core.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wirel=
ess/ath/ath11k/core.c
> > index 3f6f4db5b7ee1aba79fd7526e5d59d068e0f4a2e..21d366224e75904feeae6cb=
9c93d9ef692d127fe 100644
> > --- a/drivers/net/wireless/ath/ath11k/core.c
> > +++ b/drivers/net/wireless/ath/ath11k/core.c
> > @@ -1041,6 +1041,20 @@ static const struct dmi_system_id ath11k_pm_quir=
k_table[] =3D {
> >                       DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
> >               },
> >       },
> > +     {
> > +             .driver_data =3D (void *)ATH11K_PM_WOW,
> > +             .matches =3D { /* P14s G5 AMD #1 */
> > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
> > +             },
> > +     },
> > +     {
> > +             .driver_data =3D (void *)ATH11K_PM_WOW,
> > +             .matches =3D { /* P14s G5 AMD #2 */
> > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "21MF"),
> > +             },
> > +     },
> >       {}
> >  };
> >
> >
> > ---
> > base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce
> > change-id: 20260330-p14s-pm-quirk-0a51ba19235f
> >
> > Best regards,
>

