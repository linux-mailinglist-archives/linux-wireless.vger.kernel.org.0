Return-Path: <linux-wireless+bounces-26544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5F2B30906
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 00:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA78760868F
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 22:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC412EA731;
	Thu, 21 Aug 2025 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4xTpQiB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404CA2D3ECD;
	Thu, 21 Aug 2025 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814766; cv=none; b=SVyvUMI02pKxE6yLczoFyA3bledk74NTsq0x7UyEPDOVj+1VGMEp6RQyVXLw943KIwOawfztjweP4tzMqtZXdzb1xGPwpnfYoS/6YCC7p+ZRuIAIcnKzd/qXoyvgYY8DKk8RUrNyY6fBBKu4Bufgq114jpkUlDhwYyJ0FQw1Uqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814766; c=relaxed/simple;
	bh=fF23zyIdRPW43EvOlSuYRDivhwben8KUMEiQ1BRdHl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9WvqSZoYb50tjInKufoanZtyvT2zzgd+PbiY7Thj1u6ZddPQ7fcY1SgFFuTfET8vYBLwkwKNxm52byenTbEHzhKXl6DT9d2GsExHyjzoavOx53BI1+5+AA3TiEeGpS0/jZXxBRJyuxmUfkBCFiT6D/qstCSemYQ3ViwOsuwiwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4xTpQiB; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e93498d435cso1575995276.1;
        Thu, 21 Aug 2025 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755814764; x=1756419564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2aKpri2llVUHBtLde+z+I7G/BKEzBp3VqPywh8sbrA=;
        b=S4xTpQiBjz++Cst3JhjWqmX4MAOlDcBrJ6+srt5BdgVOkOGGvIbJfQx88erCu5t3/2
         JgySQpXuhj22Kkab4XQkEnWOsYYGo9tc6KM6Xsxs3tGez7AYDO+RRBlJBsApAXDioh/N
         jx1akIUr6mDhvPjSVckWo4H7xXUp+HUNrxIZ4B3G0VIyhOEPbbxlFEcfH+rcyKHSQLbY
         RXOulVMZXwakNiVK1FBi46KE/EvtXI/ByKhP8FvB/pzkZF9rFf0KkSDMzRJN86by/o7b
         O6nMF25myqvo2b016fP/QEf/a6ccckuEMBR/XeyyWp8nLmYwQ89zax3bbxqJLjoJCAc5
         iiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755814764; x=1756419564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2aKpri2llVUHBtLde+z+I7G/BKEzBp3VqPywh8sbrA=;
        b=lBmaZW8GuwYrWiE+mGcugBXZ/SRI2P9la1Q8B4Lnb3f9GSH+UpYI6vEoQQLynRE5Jq
         RJEcmISLTlBarB8nj5QP8mVLIJekT+ngOshfIrnX41FlMR7BvlnvDIJjDK6k6mCSalPV
         ZzNooIy55qzSbQ0AcO/mz1rjfQysxngSzz4uz6Jh9i/4v/RWd6Vi77M38jbUgGTIOUUM
         Cdh45Fr/hTWOHMVFmryHkgzTi7v4d5uEkgmY8tr2l41lPNy0F3NUq+v625w19RHzQz0Z
         22F0Wgev4o+K+QrPPcVBz9ZYj0hOnIHMCy1hgYsmuPwuXakuTAhR+QiCN3Oh9jwv2Txi
         twCg==
X-Forwarded-Encrypted: i=1; AJvYcCUgmYkEnFTBch8Ek4vMeJIWQ0voIFEPov39rzzgoGgo3BZWE21H0fmU9l0oOPS3HpgV6eeAKyFrTsqt5s8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ewKpVdaEwz277nAwqtISR1VyHhjjEHu8uuHq4EnPqUQuKrxI
	OdTy9udiAFzHfprly8XPqsL9jULo7kGezCfFDQ1LLMeAS5N/lHvCgbul3rsqMPQdy5ZHk1oUZNu
	Aei5rM7wssolJ97U2VrmU28GmNTZiXgPxDmmD
X-Gm-Gg: ASbGncu4t1D05Xyp6CFbhH93G2ouvsaJNU+HHd+BS7jkOchEyHP0lopP4s466qZaATp
	GxbGjXuScO1TbDVpD8fbx4ZGJZ1f/JXyyKwi7NrVmQXtYfac4dzWIIRd/FzKmnpD0pDuSsmu3HO
	VL/jl/0iSNv5tU0WM2wIWVDRfT110JL42Ky6FkzayS7GbpNktMVXPIY4aBhATYinz8g5rE3na4Q
	4Gsz7jcKuBeU+AIItxzkeSreVn75gX5zAWP6c11zP4DRUKspKS4s4+bs/U+SRwvaqLPsWgeHFHO
	lsy9mA==
X-Google-Smtp-Source: AGHT+IG+LqpI50Q9RX8ALIbLBIj3bBhJYLmE/MSU+FtkFR5lC7OQcze9NAs58ajLXelaB8jMBatAgjnNrQyy+PuMrDc=
X-Received: by 2002:a05:690c:6104:b0:71f:c6c7:e238 with SMTP id
 00721157ae682-71fdc40714dmr10005827b3.37.1755814763977; Thu, 21 Aug 2025
 15:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821032755.636661-1-rosenp@gmail.com> <86ddae9a-4931-b160-51a2-f89d45d4038d@oss.qualcomm.com>
 <CAKxU2N-0Q2uxw=-v-XP8g=Y=yBb2ufv+T0yk7dmaszwUy8Z6tg@mail.gmail.com> <b711072b-11fa-ea33-3a47-d16ad5a9cc62@oss.qualcomm.com>
In-Reply-To: <b711072b-11fa-ea33-3a47-d16ad5a9cc62@oss.qualcomm.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 21 Aug 2025 15:19:12 -0700
X-Gm-Features: Ac12FXwFmlpwHkriynt0Q17VriPJkfjZxkf8YcQBw75aS0rjb3Lu87eEwnmzcjc
Message-ID: <CAKxU2N_=mqneTUSxaaeN=i_DpQB_ejCb37588bUqagj9_TmdMg@mail.gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath11k: switch to of_get_mac_address
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>, 
	"open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER" <ath11k@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 12:44=E2=80=AFAM Vasanthakumar Thiagarajan
<vasanthakumar.thiagarajan@oss.qualcomm.com> wrote:
>
>
>
> On 8/21/2025 12:21 PM, Rosen Penev wrote:
> > On Wed, Aug 20, 2025 at 10:55=E2=80=AFPM Vasanthakumar Thiagarajan
> > <vasanthakumar.thiagarajan@oss.qualcomm.com> wrote:
> >>
> >>
> >>
> >> On 8/21/2025 8:57 AM, Rosen Penev wrote:
> >>> This is needed to support nvmem defined MAC addresses in DTS.
> >>>
> >>> In addition, check if the probe should be deferred as nvmem can load
> >>> after ath11k.
> >>>
> >>> For brevity, ACPI is not a factor here. ath11k is too new for that.
> >>
> >> This may not be accurate, pcie devices are widely used on x86 where
> >> ACPI is not certainly new.
> > No way ACPI is used to define MAC addresses.
> >>
> >>>
> >>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >>> ---
> >>>    drivers/net/wireless/ath/ath11k/mac.c | 5 ++++-
> >>>    1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wire=
less/ath/ath11k/mac.c
> >>> index 1fadf5faafb8..801db15ca78b 100644
> >>> --- a/drivers/net/wireless/ath/ath11k/mac.c
> >>> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> >>> @@ -9,6 +9,7 @@
> >>>    #include <linux/etherdevice.h>
> >>>    #include <linux/bitfield.h>
> >>>    #include <linux/inetdevice.h>
> >>> +#include <linux/of_net.h>
> >>>    #include <net/if_inet6.h>
> >>>    #include <net/ipv6.h>
> >>>
> >>> @@ -10434,7 +10435,9 @@ int ath11k_mac_register(struct ath11k_base *a=
b)
> >>>        if (ret)
> >>>                return ret;
> >>>
> >>> -     device_get_mac_address(ab->dev, mac_addr);
> >>> +     ret =3D of_get_mac_address(ab->dev->of_node, mac_addr);
> >>
> >> I still think it is better to keep the generic API and add the the one=
 specific
> >> to nvmem when the generic one fails.
> > I don't. ath10k and ath11k are the only modern drivers using
> > device_get_mac_address
> >>
> >>> +     if (ret =3D=3D -EPROBE_DEFER)
> >>> +             return ret;
> >>
> >> Please note that this error does not impact the device probe as this i=
s
> >> being done in the event path after probe returns withis complete.
> >> Also, this will result in device registration failure even when
> >> the device is not really looking for mac_addr from nvmem (or it is not
> >> there) as firmware can also provide the mac_addr from the hardware.
> >
> > Does probe not handle EPROBE_DEFER?
>
> right
I looked further into this. The function ends up being called in
_probe as ath11k_core_init , which doesn't seem to pass the return
code of of_get_mac_address as it currently stands. Unfortunate.

