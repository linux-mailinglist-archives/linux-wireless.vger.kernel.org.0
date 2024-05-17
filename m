Return-Path: <linux-wireless+bounces-7784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2508C87CC
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 16:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA601C2271F
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 14:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC0161691;
	Fri, 17 May 2024 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jv8zOsE+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EE2612D3;
	Fri, 17 May 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955464; cv=none; b=utZKPLpEBXcJuBHXmGRr3BPjTYwOBKO/heRR43czv+eSQQ/mMcUxfY4KRrAnEsodkf+0qk35eIe7tYNMQwEBJ7cCF3hjBmMNGaQvUZKqv2nfe45t3v/iLMf4MP/WNycTJeERwDXaev1iPcD1QmWCtZX47ljC2E/yB+DNQ/RPv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955464; c=relaxed/simple;
	bh=RJcdHWsgVmudxo5Ii03KSrwM1eS+IcvT6rxsAh2xct4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzlCo4haRdTnl/uBwofj4GxH46GtOcj/AeMfBOdbIFXl/ugu+eQUZeStkWUedvbzR/1pWgTVOyTZJTwGGS5KI6xmdResmH0YkLTHFoa2UDzuBGL7V63ko+80t0mGxJbUS0nl9ANJXh1ZjC53Yw5f1mkrgm8J8ezguEBKLm6UC7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jv8zOsE+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43e1581e81cso3944401cf.3;
        Fri, 17 May 2024 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715955461; x=1716560261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2+7azor6WQpFz1/oIf8SceIbsGl7GvqQfbu88b7F+Y=;
        b=Jv8zOsE+AO0W8w/JZBINT7XYcpPabtTYEw7btCKo2bJJC9i47WukmRIYCvOuFPp809
         0fjo4jz92J03buKGZj+yOo3xJf/mTk8yubVX+1623AruFUBAnUfe8mRgmYFsCGelnYuV
         ZsNPkhqJhL5jWuSx0R87NF+0BPH1/gldAcCIIc4B+WupMRKp14gu/094F9EwcQOoxYL+
         N+kVU5hjKkS/GPJGBDrm6cjj5wvQrES2ZN5TbPGvNRsQPSHOpCxr5ZyIk9QPTFBbtMEJ
         1zvDeVjlGJUQUwc4RAGyciNxMPj4s15HUyDWrjI8xHfnKW2mhM1eQfKNQKp5a/IdliW6
         Wh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715955461; x=1716560261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2+7azor6WQpFz1/oIf8SceIbsGl7GvqQfbu88b7F+Y=;
        b=DMCuP3sRcncZj2LSJs5HsbYwRA418RZ1DJigUZZV8L3spHcWsW89Iq+di5iyMGx88Q
         G57KQc4tpoGHTGxM5sXIQ+kxv3jsmk1L67AgsuGBsUj6MvyUmIkestFjtZ42aOokT698
         sy5lcGfCsy3sAHkYwWDT+BWc0TVyNh+SD+qFdKPEcTXoLeg0PYRhTaGtbjNmtaNuMxIR
         LFueHoOzYs4ZYq23Np8m+fRWHkna2MNde4i0KWXqrqFlzVvhwyy+ed/hfe/nPmra+Tnk
         P27pb65buByKs/u2rSdMjFzBxluNeC1iJDXXqDd+mTeMVi/Jb8eGdw8kTTNk3POoW+YX
         oYRw==
X-Forwarded-Encrypted: i=1; AJvYcCVw57qv13ZDcjfknK2cbPfXU7EuS0gFGbXj6eV88z35t/hAhoqfbywxOONtja/VFueXrRd8WxSlfayH9i8ygr1S1ngBAWtXMIcGZbxiKZJDGaxSYdk4LlHIW7yP4bZdrti3g5zFhiF88sXYdo8=
X-Gm-Message-State: AOJu0Ywe/2xze3s9T8zdBk18IMfz8rL7s8TywMEfRqMUZaTEl+YSkPtu
	1AyZjaRc92dA58dFToj631ANfiKHVCoK9q+sFnp5M5JcSpu8ApyYtH/SCQZ9VJWc5y2OfqCJeu1
	lYWLKwGRkggilemqcttzbHVouDVg=
X-Google-Smtp-Source: AGHT+IHN8Kp1/VkT5oyi0m1EyuG/uUr3+Wv+1mxw6Ycbqs5VhXotZ+5PXP3Zam5SdgP6WbfaX7OUhMdgfu5zbn/1RDY=
X-Received: by 2002:ac8:7dd6:0:b0:43a:df49:f8b7 with SMTP id
 d75a77b69052e-43dfdb0a4cfmr230092981cf.36.1715955461593; Fri, 17 May 2024
 07:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516200555.33982-1-trintaeoitogc@gmail.com> <8b50e09b-560a-4a16-b9e7-7535ba5eedf8@intel.com>
In-Reply-To: <8b50e09b-560a-4a16-b9e7-7535ba5eedf8@intel.com>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Fri, 17 May 2024 11:17:05 -0300
Message-ID: <CAM_RzfbhiM0Z4O7v2mwS4ws-Eb-OavU1ZwqSqc55T1W2Gi1QPQ@mail.gmail.com>
Subject: Re: [PATCH] [thermal] adding check if the thermal firmware is running
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: miriam.rachel.korenblit@intel.com, kvalo@kernel.org, 
	daniel.lezcano@linaro.org, johannes.berg@intel.com, dmantipov@yandex.ru, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Okay, this makes sense.
I will send a new patch with your suggestions.

Thanks


Em sex., 17 de mai. de 2024 =C3=A0s 07:20, Wysocki, Rafael J
<rafael.j.wysocki@intel.com> escreveu:
>
>
> On 5/16/2024 10:05 PM, Guilherme Giacomo Simoes wrote:
> > in the dmesg is showing the message "failed to read out thermal zone"
> > as if the temperature read is failed by don't find the thermal zone.
> >
> > After researching and debugging, I see that this specific error is
> > occurrence because the thermal try read the temperature when is started=
,
> > but the firmware is not running yet.
> >
> > For more legibiliti i create the NOTLOAD error code in the errno-base.h=
,
> > and in the iwl_mvm_tzone_get_temp() on tt.c i check if firmware is
> > running and I set the NOTLOAD code for ret variable and goto out.
> >
> > After this, in the update_temperature() in the thermal_code.c i receive=
d
> > the return of thermal_zone_get_temp() and check if return is NOTLOAD,
> > because if it is, I print the warning message "firmware yet not load"
> > and return for caller
> >
> > The thermal_core.c i think that is generic for any thermal drivers and
> > not only used for tt.c of course.
> > But if this ipotetic driver not check if firmware is running before rea=
d
> > the temperature, the thermal_code.c is work as a before this change.
> >
> > After this change, in my computer I compile and install kernel in /boot
> > and in my dmesg the message "failed to read out thermal zone" is not
> > show any more. In your place the warning messafe "Firmware yet not
> > load" is showing.
> >
> > I would like to thank you in advance for any contribution, suggestion
> > or criticism of my patch suggestion.
> > ---
> >   drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 10 ++++++++--
> >   drivers/thermal/thermal_core.c              | 10 +++++++---
> >   include/uapi/asm-generic/errno-base.h       |  1 +
> >   3 files changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/=
wireless/intel/iwlwifi/mvm/tt.c
> > index 8083c4b2ab6b..dd5725db06d2 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > @@ -620,8 +620,14 @@ static int iwl_mvm_tzone_get_temp(struct thermal_z=
one_device *device,
> >
> >       mutex_lock(&mvm->mutex);
> >
> > -     if (!iwl_mvm_firmware_running(mvm) ||
> > -         mvm->fwrt.cur_fw_img !=3D IWL_UCODE_REGULAR) {
> > +     const int res =3D iwl_mvm_firmware_running(mvm);
> > +
> > +     if (!res) {
> > +             ret =3D -NOTLOAD;
> > +             goto out;
> > +     }
> > +
> > +     if (mvm->fwrt.cur_fw_img !=3D IWL_UCODE_REGULAR) {
> >               ret =3D -ENODATA;
> >               goto out;
> >       }
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> > index 34a31bc72023..4116d312d4a1 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -414,10 +414,14 @@ static void handle_thermal_trip(struct thermal_zo=
ne_device *tz,
> >
> >   static void update_temperature(struct thermal_zone_device *tz)
> >   {
> > -     int temp, ret;
> > -
> > -     ret =3D __thermal_zone_get_temp(tz, &temp);
> > +     int temp;
> > +     int ret =3D __thermal_zone_get_temp(tz, &temp);
> >       if (ret) {
> > +             if (ret =3D=3D -NOTLOAD) {
> > +                     pr_warn("Firmware yet not load");
> > +                     return;
> > +             }
> > +
>
> The thermal core doesn't need to be modified for this.
>
> Please print the new message from the driver and you may as well return
> -EAGAIN from it in all cases when the issue is expected to be
> intermittent to prevent the core from printing the (existing) warning
> message.
>
> Thanks!
>
>
> >               if (ret !=3D -EAGAIN)
> >                       dev_warn(&tz->device,
> >                                "failed to read out thermal zone (%d)\n"=
,
> > diff --git a/include/uapi/asm-generic/errno-base.h b/include/uapi/asm-g=
eneric/errno-base.h
> > index 9653140bff92..8b92c41f7993 100644
> > --- a/include/uapi/asm-generic/errno-base.h
> > +++ b/include/uapi/asm-generic/errno-base.h
> > @@ -36,5 +36,6 @@
> >   #define     EPIPE           32      /* Broken pipe */
> >   #define     EDOM            33      /* Math argument out of domain of=
 func */
> >   #define     ERANGE          34      /* Math result not representable =
*/
> > +#define      NOTLOAD         35      /* Firmware yet not load */
> >
> >   #endif

