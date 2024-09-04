Return-Path: <linux-wireless+bounces-12503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1DC96C5D5
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 19:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69034282618
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 17:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE3C1E00AF;
	Wed,  4 Sep 2024 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/UUQEDu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147132AE9F
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472595; cv=none; b=jdX8Qm/wDcDpD38OSTBdOc1R75Nm6eJQGFI0vPh1OaPqbL8HHFQQY9l1EnZz1ZJXKzLK1WcsD4GcqWwGFrgtSkXzIGA5sKdWrBXeTOC6V9aM4DnJRiidBrH08cNsdg9Z9whIMKlOrtpYRah0NREdnwkvO78w/yOQEIbHvWli/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472595; c=relaxed/simple;
	bh=QP+35boC58dZQW5aezYQ4w2Uoo9i6aylPAPmkWj12PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6wqFY211MW93mwSK2S5ZfwHHOGqGDNsrYGrgyLiB4g8rb4MlAhVNvXKBgotDEc28BPTQyGaSw+/IBh+j+K8xYOqLHz7OxxVTPZEbSLncmsxPpG4WKQE8WZ+/oWkOQvHMuHyjmvGkha13XkHW9YRPtLAw+D7iPPJ0oSFcsvqOkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/UUQEDu; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6b747f2e2b7so62224147b3.3
        for <linux-wireless@vger.kernel.org>; Wed, 04 Sep 2024 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725472593; x=1726077393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqURZJQezutpVkqJ5Iu+2X9yBKxiRkGJ3io0ZuY1FyI=;
        b=a/UUQEDuorAn/Yb2BT+e4ryFol+6Mr9tBqJ18DjSF9mYqkA3BfZKRvalzl5xTkeQlR
         /6CEXScJGGYltcHA4kl86xCmc61fUVxECc0pNdLbQRgNP/2QRS1Gr2Dcp44FPB2ICv2r
         2HxSS8JP5uc6BqcMY6Gt26skrFsQyE3or54XgEXDZ8mXdI1+0kM68n5ZEh6WiDI32OPn
         v0hWg6/MJahpY/N/mt9b2bnd9KV44vO6TsUy+E/5tdIVDHUH/IO6R8ShjayGKa0l4Ow+
         6PwJGGFj4ApAQx/S/e7+2zfbxDXGpVBMX5vvrWRAtJpzC/u4CgE772f64tR5dkzdOT6u
         dIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725472593; x=1726077393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqURZJQezutpVkqJ5Iu+2X9yBKxiRkGJ3io0ZuY1FyI=;
        b=LEGawiJ6FtvAy59z/Kn2qoQ+/x+TDpAOhoarTvSbdgnh1LlUBypYDYrwvHsrrxgTMl
         VT5psJD8uwSbm7y/tLq9RpcH/6IKBACUo2JOfjlpkFEksDKrcVBKjRn9A7w4H+gGJ6OE
         UWFEN+5+1lDz6YdKlN6g6tgtJxPpxXb17jcgt7bJyR+W/INB2A/Qd2JDx0Ur/Tote9rn
         c2Ey9QqXpY+mR+qhBo/B+lOwryGX/rUrOBCIQr2ogmbNu2bxAWfB1FmEtM++mLG9dlmj
         p1FtSrDGjcf7C947mxwbV59w5RMyNWkziP/MGLyUIv8U8GDXO2cVDuLfuKM71X7jAlsc
         YBXQ==
X-Forwarded-Encrypted: i=1; AJvYcCULlAEHNivuz4HPkpvZFUcYWbyw3TUz3jptGS/aL9xEVfPMI+r5RdJ8ENUuoaL9rbcnVM9SJ9jyYdTcu4Nyuw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq5bxI9RH7hJVdXqP/0j2xeZRRBTorVcR/FUbSmTvPl2extDNG
	GQcn6orHmlWfAs4mn8dqEEtEBzX+JAVkUGnoQR0/WCEY9saDPYaMuDnhuBXMBw2UX98Lx21P5et
	j2TZNOCTiof2NzTmYeJrQpSL5vjI=
X-Google-Smtp-Source: AGHT+IHSUX8H7W6ahhg0FJtXjvil8VtDylan5zsutIn+Yazw9sMHMA4GBQ52RbZ6usTVcP1ovSb+GpGhtsluRE+Eap4=
X-Received: by 2002:a05:690c:389:b0:646:fe8e:f03b with SMTP id
 00721157ae682-6d40ec605f0mr193145587b3.2.1725472593020; Wed, 04 Sep 2024
 10:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903202713.471489-1-rosenp@gmail.com> <87jzfrkfn7.fsf@kernel.org>
 <0bab22f0-e5a4-49ac-8265-910ae9380add@quicinc.com>
In-Reply-To: <0bab22f0-e5a4-49ac-8265-910ae9380add@quicinc.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 4 Sep 2024 10:56:21 -0700
Message-ID: <CAKxU2N9QDRieOco0VRjTMQW2ywM-mOJp_vTyg+v_SKSBTPf+1g@mail.gmail.com>
Subject: Re: [PATCH] wireless: ath9k: eeprom: remove platform data
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, toke@toke.dk, 
	nbd@nbd.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 7:53=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc.=
com> wrote:
>
> On 9/4/2024 1:05 AM, Kalle Valo wrote:
> > Rosen Penev <rosenp@gmail.com> writes:
> >
> >> There are no more board files defining platform data for this driver a=
nd
> >> eeprom support through NVMEM has already been implemented. No need to
> >> keep this old functionality around.
> >>
> >> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >> ---
> >>  As an aside, the last user of this functionality downstream in OpenWr=
t
> >>  has been removed: https://github.com/openwrt/openwrt/commit/7ac8279bd
> >>
> >>  drivers/net/wireless/ath/ath9k/eeprom.c | 12 ------------
> >>  1 file changed, 12 deletions(-)
> >>
> >> diff --git a/drivers/net/wireless/ath/ath9k/eeprom.c b/drivers/net/wir=
eless/ath/ath9k/eeprom.c
> >> index efb7889142d4..df58dc02e104 100644
> >> --- a/drivers/net/wireless/ath/ath9k/eeprom.c
> >> +++ b/drivers/net/wireless/ath/ath9k/eeprom.c
> >> @@ -15,7 +15,6 @@
> >>   */
> >>
> >>  #include "hw.h"
> >> -#include <linux/ath9k_platform.h>
> >
> > What about the file include/linux/ath9k_platform.h? That should be also
> > removed, right?
>
> That file is still used by other functionality (see init.c, btcoex.c)
> But seems that at a minimum unused eeprom-related stuff should be removed=
 from
> struct ath9k_platform_data.
That's why I kept my changes to a minimum. I don't yet want to axe the
other stuff. OpenWrt has a ton of non upstreamed patches for ath9k,
some probably relying on ath9k_platform_data. I need to do real
careful analysis to remove the rest.
>
> Please review that all of the platform-related code in init.c is still ne=
eded,
> especially code related to eeprom support.
>
> /jeff
>

