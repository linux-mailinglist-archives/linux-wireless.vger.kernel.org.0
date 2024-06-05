Return-Path: <linux-wireless+bounces-8589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D638FD6FC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 22:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE379B236E1
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 20:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D8E156F42;
	Wed,  5 Jun 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSwK/Wha"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCD215534A;
	Wed,  5 Jun 2024 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617767; cv=none; b=ELTLi4c1ufs52Po1P7S3dHujSjPk/bKB3gkvHOCZX3UsEPLPZ4FEPwTOZkUYVWjwb7RnSf//EhQeVjcN9IE4liG+f2uTbGMjD+cicaYo3GEo21Bt+UePcR0/rBpBdUu/0115NHrEu+LgOpa+iwbN2gRsWqzxCRu9jJLHUq0Ru/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617767; c=relaxed/simple;
	bh=MQsO5jA5Q4r/5sp8FObB1XchIEXn3DY4dlGB8caBI7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjDkg/VDHGTvcqjHv1PoNWLavbYqENYw8si8a630N05TUYRPdcQT28jvpfORoH0brkTQAwNp4haI3jUw4LXJBkIcK5LZ69rRPXafWVluSrF0PTwodT+t6ikhkAQxOoY2xU0LWpqafHNYnXcm/kLKbiCOMvuMyEm0n7JfFF127DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSwK/Wha; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79505987854so11065585a.0;
        Wed, 05 Jun 2024 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717617764; x=1718222564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wiejtDwNbnyUyDnMvFBVySvH2LKv57cz2j0YEQtBnXA=;
        b=DSwK/WhaSXnmDL61Ry71XwOnVqshuom2vVq5kCLdgzUxmYWXxhvrka+mJP2Y946Pdo
         cMa8vUqURMwnq8vubci5AgMbJJIZwmIQg1dk8bjyXKgQ02+MGpO2qAWKDNbcHDONONGk
         vZin6QihuKbgISy4rCl4oIqrnYgUklR54GX5u74AkSEjgCyCvB5lRYjQObD9QkbGNAOs
         OAGZdpcDfq8zU4sjJepRywvNDYVNicsvhGTB5OQjjrB0XqgxcntfgZFv+EK95LzqLKzM
         rR6dm77oqauynHbS+AI9jdMIZ3jX5mnlgxj8M2K2n13tP1sB0NWEc0UatX2EEEJzMbkB
         vRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717617764; x=1718222564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiejtDwNbnyUyDnMvFBVySvH2LKv57cz2j0YEQtBnXA=;
        b=U3X+Fg6pBzw/H3FayiBX4KtXxy3L/LcCXuTWgtTlGjkNlxXHmNYzEHjJubwPigyOjE
         xoydL6+/XZ6SxrywanygFt65tJ6f6WQxn7Yvyd7Z97MvJFY5xRSCBEVQ6Vgq45Np6rRi
         z0pgUWDasRr6B/oZfjCuw3Nn9KMmQ0LZAfvIOqlf9mH7fLUNlvPJUAy9As+rfIILkTfG
         sIgVqZqB7/JNyGKeDzdhteUdhGSZm/fIwmozeFPkYpIbVv2QeuEYL0kiUeBU37IPrqhr
         qXr2EZz0nabWp/DAaX6hVCvF1VDwiQ3F+36Y1CaSsWYq4P+7dwu4gfsOMCGMx8ZA76gK
         3dXg==
X-Forwarded-Encrypted: i=1; AJvYcCUW2sAtDyFa24/OEEysU4WnlqO5P4NTljqwlstRwCytbOrAWznuptN5yKMSC/Jr7gDCZ1bakLy4auXTptp7/Si5iSRm1tfl3S0akkePuOu99b/na9PTac5+afjnz/Yr5JAVeB67PwSJQsiME00=
X-Gm-Message-State: AOJu0Yx1HvsLbKrj5YsGvYMJkJ5o3+gSl69YdOOE7SxZuiGZJjdC/aIg
	uHa9abV9El6YWWplZn2t11JL48OVQxnGEiyt7zf6xDo+d4DNVtuGlsViOD7XVhseR5JPT32RwqE
	sLYJfAmH38CDyN2B7qBg51pCe4B0=
X-Google-Smtp-Source: AGHT+IHjUuG3kbeqDQdbdD9vQU8yIrvicjHcDH6huLyQZt3nVdwNW2YlnGttJVg23BsZqZyDbbHr/ZCaUVUUj5BITjw=
X-Received: by 2002:a05:620a:3192:b0:795:2302:249 with SMTP id
 af79cd13be357-79523fb8cb7mr450423085a.60.1717617764335; Wed, 05 Jun 2024
 13:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605195129.89353-1-trintaeoitogc@gmail.com> <621eb61c-87e1-417f-ad9f-f14d858ec8aa@intel.com>
In-Reply-To: <621eb61c-87e1-417f-ad9f-f14d858ec8aa@intel.com>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Wed, 5 Jun 2024 17:02:08 -0300
Message-ID: <CAM_RzfaikYvUFd3DqTMj9Qz+05SZAOZYJJpJAqPkYj9URh0HFQ@mail.gmail.com>
Subject: Re: [PATCH v3] iwlwifi: mvm: adding check if the thermal firmware is running
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: miriam.rachel.korenblit@intel.com, kvalo@kernel.org, 
	daniel.lezcano@linaro.org, johannes.berg@intel.com, dmantipov@yandex.ru, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Wysocki, Rafael J <rafael.j.wysocki@intel.com> write:
>
> On 6/5/2024 9:51 PM, Guilherme Giacomo Simoes wrote:
> > In the dmesg is showing the message "failed to read out thermal zone"
> > as if the temperature read is failed by don't find the thermal zone.
> >
> > After researching and debugging, I see that this specific error is
> > occurrenced because the thermal try read the temperature when is started,
> > but the firmware is not running yet.
> >
> > For more legibiliti i change the tt.c for return EAGAIN when this was occurrence.
> > After this change, in my computer I compile and install kernel in /boot
> > and in my dmesg the message "failed to read out thermal zone" is not show
> > any more.
> >
> > I would like to thanks for Rafael Wysocki <refael.j.wysocki@intel.com> ,
> > Kalle Valo <kvalo@kernel.org> and Johannes Berg <johannes@sipsolutions.net>
> > for your suggestions in my previous patch.
> >
> > Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> > ---
> >   drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > index 8083c4b2ab6b..9aa9e3be39b8 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > @@ -620,8 +620,14 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
> >
> >       mutex_lock(&mvm->mutex);
> >
> > -     if (!iwl_mvm_firmware_running(mvm) ||
> > -         mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
> > +     int res = iwl_mvm_firmware_running(mvm);
>
> Why do you need the res variable at all?  You can just call the function
> directly in the if () statement.
>
>
> > +
> > +     if (!res) {
> > +             ret = -EAGAIN;
> > +             goto out;
> > +     }
> > +
> > +     if (mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
> >               ret = -ENODATA;
> >               goto out;
> >       }

Yes, this makes sense, I only declare the "res" variable because
seeing some files in the linux kernel, I see this standard practice.
But I really don't need this variable. I will send a new patch v4
without this variable.
Thank you for your suggestion on my code.

