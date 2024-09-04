Return-Path: <linux-wireless+bounces-12509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B611996CB66
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 01:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E927F1C216EA
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 23:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DC017BEA7;
	Wed,  4 Sep 2024 23:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWrmfVCX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E321A14A4E1
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 23:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493995; cv=none; b=FKUcZ10cfhGFQYfII7LsWeG4QenyAsqFx8IScjWmlixbtms/Mnw3/btIwnaA6Gs6bRMLkhP/PPhSqoDFQhtREdNDVfuBHftWzAmnaSMTtqUvVe9lCiT7bcijp8siIj/PB0G7gPNEL0AvVjTAj8dgi803l5yPEf9WLOhLVU6jMk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493995; c=relaxed/simple;
	bh=qynKuEOj6zQA3kJ+DDKr9ddDtuuuEd6HBRuJ+VRZTf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8z5vZt24GqkDxJ9Y+o5cnv2RDEsry/jQa7Orp9AsjG+Bb5etMx4nCrxQWAk96CTloy9EOZAwjC5pzNdeY6Qv7KO7afY6pTuw303w9PXp8qUqoGNVzj/HqabMZyAOKDZpcBl0L90ssgjzjjEOoTx8BGBFjanj0ZDapyqqDVloa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWrmfVCX; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6d47d860fc4so887487b3.3
        for <linux-wireless@vger.kernel.org>; Wed, 04 Sep 2024 16:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725493993; x=1726098793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2ejdbN49UHiLxd/x/S5h8wJfzNJxKyIIvytJRPCcCQ=;
        b=kWrmfVCXDojJndMyVqWAFmDK4SuNZPqXp65DDwIoVEhVsD8j2ag1OSCUknbZLaMRx0
         +PFZLcwOxjrzjxPlR2bHbCWPouHq/tOfS7Dwf0nBc2YvUrTFe+Zuk3qpGU0qifyWOt/S
         kqUuLmWocZ3bynnGh9tBHd81fFaZjDBXrInL0ZBNd8zU/uiaf7YTOpRux3R4QLVTw4ra
         qWYywVdyrQQLfm8qhBm4y/I5d5x2/13L5QNqDSSr7+j+Ghz/aWiWOCxXSuxsNsTIGVgU
         +PrzNXXRr523lxYGgytH30o8xsz4sFUzsbVRMNNt3ooD6uC1bCmTHoM++2k9KiQjVHEw
         Cktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725493993; x=1726098793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2ejdbN49UHiLxd/x/S5h8wJfzNJxKyIIvytJRPCcCQ=;
        b=Erl1ufPXYvZXGJnpQfnWxd+GjTWwip5Z+4S59GwXAT+b/SlWPzGrs1bt+fmHnKf0Y7
         qaUrSQILgfpHhrtN7lINCiha9g1zHRdCoEKCP33dSZxdvMTiavVXcgIfGTX/V7tFXhdw
         E3k1nYPESlKbHR2CAy3UXFX7fpHVJf7cSK7+0IHh/BisEtTZGTR8a8aDwGslbFbIZsvS
         7JzN+9hkw26Ua2MDY6TY3wC1ldKoYtH7LpbBSzuBvqFGESOnzazMNAjQ2Gh6xtQJKDen
         oSBPtS0a364IJB0iKx0UHBPahHrrPGGSecQC8OAahhQUb3uvlGJ3gQE4XtOfEs1fdx6f
         ILXw==
X-Forwarded-Encrypted: i=1; AJvYcCWKv9EdvfsAspu59AwLpnGXgtTcwCJGavYzhy1Q7RwtgxzFaEI+KiMs8+lV6+weFYmjYNMaIyoMYaJ04GsU7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2PjPR4gWCWLY3kPcMEaih+C3gLJDZh//C9qzcJlcsaOZSexm
	pvKcHnPXjwcrxd5GzoTmnxIEEGWT3IbNrmO+uZzOQZtAUSBceLoR7Bti+NmBoJKvXoKlDkiqF0/
	xVvt/uadQUnGeqbsnpkuj28++Nuo=
X-Google-Smtp-Source: AGHT+IFqIFwtWIKu4TxsbE51oEOGkJjqobbwmh8dpVnW93JEGL+D/CtkToUYmp2hoi4tbzKBrgULMrZGx7kBuKVkV/I=
X-Received: by 2002:a05:690c:fd0:b0:65f:aa06:13ab with SMTP id
 00721157ae682-6d40d987cccmr216923677b3.1.1725493992896; Wed, 04 Sep 2024
 16:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903202713.471489-1-rosenp@gmail.com> <87jzfrkfn7.fsf@kernel.org>
 <0bab22f0-e5a4-49ac-8265-910ae9380add@quicinc.com> <CAKxU2N9QDRieOco0VRjTMQW2ywM-mOJp_vTyg+v_SKSBTPf+1g@mail.gmail.com>
In-Reply-To: <CAKxU2N9QDRieOco0VRjTMQW2ywM-mOJp_vTyg+v_SKSBTPf+1g@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 4 Sep 2024 16:53:01 -0700
Message-ID: <CAKxU2N_VKU2cMpPS0y7JJkuCzAimUP=h885RA58WqCB1CZj8ag@mail.gmail.com>
Subject: Re: [PATCH] wireless: ath9k: eeprom: remove platform data
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, toke@toke.dk, 
	nbd@nbd.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:56=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> On Wed, Sep 4, 2024 at 7:53=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicin=
c.com> wrote:
> >
> > On 9/4/2024 1:05 AM, Kalle Valo wrote:
> > > Rosen Penev <rosenp@gmail.com> writes:
> > >
> > >> There are no more board files defining platform data for this driver=
 and
> > >> eeprom support through NVMEM has already been implemented. No need t=
o
> > >> keep this old functionality around.
> > >>
> > >> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > >> ---
> > >>  As an aside, the last user of this functionality downstream in Open=
Wrt
> > >>  has been removed: https://github.com/openwrt/openwrt/commit/7ac8279=
bd
> > >>
> > >>  drivers/net/wireless/ath/ath9k/eeprom.c | 12 ------------
> > >>  1 file changed, 12 deletions(-)
> > >>
> > >> diff --git a/drivers/net/wireless/ath/ath9k/eeprom.c b/drivers/net/w=
ireless/ath/ath9k/eeprom.c
> > >> index efb7889142d4..df58dc02e104 100644
> > >> --- a/drivers/net/wireless/ath/ath9k/eeprom.c
> > >> +++ b/drivers/net/wireless/ath/ath9k/eeprom.c
> > >> @@ -15,7 +15,6 @@
> > >>   */
> > >>
> > >>  #include "hw.h"
> > >> -#include <linux/ath9k_platform.h>
> > >
> > > What about the file include/linux/ath9k_platform.h? That should be al=
so
> > > removed, right?
> >
> > That file is still used by other functionality (see init.c, btcoex.c)
> > But seems that at a minimum unused eeprom-related stuff should be remov=
ed from
> > struct ath9k_platform_data.
> That's why I kept my changes to a minimum. I don't yet want to axe the
> other stuff. OpenWrt has a ton of non upstreamed patches for ath9k,
> some probably relying on ath9k_platform_data. I need to do real
> careful analysis to remove the rest.
> >
> > Please review that all of the platform-related code in init.c is still =
needed,
> > especially code related to eeprom support.
That's handled with nvmem and OF (if applicable).

Anyway, I split up the removal in 4 patches. of_init needs some extra
functionality to match platform_device.

Does Documentation need to go in its own commit?
> >
> > /jeff
> >

