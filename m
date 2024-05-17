Return-Path: <linux-wireless+bounces-7795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59E28C8AF2
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 19:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E32F7B2219F
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 17:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40C713DBBB;
	Fri, 17 May 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpNA2eJK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D0C38DD6;
	Fri, 17 May 2024 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966786; cv=none; b=BX/ZrpswPTuE8hQUzn7VFQxRnpqOEb6Au+VRrrjFngUfU7TMNkY+UtXtRAIuUAoJ8Kg0RSgvBmCs4OJ8/iS0IsNaKgwh5fqcJ+0jhyx4pxb1y3V3BXuW9axgK6lWQ0Mdh4qWNYN7yX+M7u7Qt2gJMA1QDcNyUZh2ufiySETZrrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966786; c=relaxed/simple;
	bh=072dFkS4d4tbkJvVvRwY+LhA/h9LLDGfty0cX3lcm2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbYtXcQSS5H+7VN7bNT5hKRdkbI2DYu8WzAEb4cWRTyw/98a5bHrKtpGQgGN8BPajIvF3BdV6116e8Ym9D4v8OipfgfYad5oOq5a3xrs1gUolFLv18UwhW2tXIZIkMrz+fIGrYWUd3C1oj19dtfBBGnS4Ez3aFEvpoJGGCCnKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpNA2eJK; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b273b9f1deso276146eaf.3;
        Fri, 17 May 2024 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715966784; x=1716571584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZGrmhkZn+JSkvkm9A1cwxxyX0MxkBYI3NcyHvf0LUk=;
        b=ZpNA2eJKHZSoLaiskIDMfqR/rB57hOzaZXBvfVLDNuq9Ml9Sisq+zo8GGWRGrwbFHh
         ETBRfxE+gaXqHkkHGt4bIaCfWJJnNPdNK7PECrobLVFH3kkjMmk/yIXZ5G+BwRubgTpO
         Z9ZZbLLvCk6qAovwncovPgH7734jUjhzpLq3cdXqe8Q00bGG8eiBdMdKWHb2mAUDpt4e
         Sp0IYmPSn3N0YkudUg1jiNouv931Qgc8uAk4kgyz8woyr9AdH7gFgg8HLuFg88YWCzNL
         abdMk93WSmMcO0p2L0u0iOAQWjyJcZKE/vhPlSMQvWMr9t9dK7Xl1A5nJtXTjFQphZtY
         Fwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715966784; x=1716571584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZGrmhkZn+JSkvkm9A1cwxxyX0MxkBYI3NcyHvf0LUk=;
        b=gg5DKu4zG9m84iNMGYfmkC6eNenDcCDFVODPBHi4zJE87j5onnxPsu2Ac5s21ow183
         +oQ5xVM1NoTqMOyOvw+5NbLB1Q7I83J9x0API8NCsdVMShlMNygtOY5KwgmiFPkFiNzO
         fG9lUACW1nooa8t49v5Z7tdECrLzzKz/b8q3TtJvQaDrtg/LQ5jeqXnRUUDq7rs5DERP
         LsgkzX/YuzW6/6Tj7eMTw28i4wOTXuTW/+l4PhPrvgke8pr2bThHih2xK0la3cwWyz6c
         DDWfURDKJ2g89LlfXVgqYEye842zGTfZ9p5DrobleewjsoG4W5QlU6f+WjGsP6ZJ0GrS
         IEaw==
X-Forwarded-Encrypted: i=1; AJvYcCUxzy79emLwyi868RteTdLBuIxtYAR5YAuRDu7BseltezPvz0wjAjgM745kJ8Eg+eRgxNQ10OENAcVyarNbHW3h3LS54foBSMalhi1x0/WqJlcZ/tM4s92DwCb8IbwxXtNRp9saoJj138BkQ38=
X-Gm-Message-State: AOJu0Yz2p4TbsAGM/4p+SnBvD2qMnmEEQ0VlUzClPK/cIetBI/bwKiAo
	FpLa9J8wfu6FES1HqTzXb6G2qX3O7Wx8QzVw+ey8Z8IDQQ6QIKyfmp6qvquZ6OfRQhwtOaqBWtj
	NiGY9UjGV5k5wLmh4HQLZv34M5Mv6WGOrihs=
X-Google-Smtp-Source: AGHT+IGOfKY+UBUaUm6h9GuOYIuW1nWsBC9NcJyqaZgUvLnYOjU5WP4uMThorKRVVc1YDztEugD+hNOi2jnSEFP/40Q=
X-Received: by 2002:a05:6359:4587:b0:18a:62fd:b874 with SMTP id
 e5c5f4694b2df-193bb63f000mr2904732855d.17.1715966783985; Fri, 17 May 2024
 10:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517141655.2797-1-trintaeoitogc@gmail.com> <a1cd16d2-1fbc-6543-c17c-a321ac72a2f3@gmail.com>
In-Reply-To: <a1cd16d2-1fbc-6543-c17c-a321ac72a2f3@gmail.com>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Fri, 17 May 2024 14:25:48 -0300
Message-ID: <CAM_Rzfb8f4ki4UB2+9EtnpJL8oMY6x0q=HmDm92mdbhLQafFOQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: adding check if the thermal firmware is running
To: Jonathan Bither <jonbither@gmail.com>
Cc: miriam.rachel.korenblit@intel.com, kvalo@kernel.org, 
	rafael.j.wysocki@intel.com, daniel.lezcano@linaro.org, 
	johannes.berg@intel.com, dmantipov@yandex.ru, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em sex., 17 de mai. de 2024 =C3=A0s 13:57, Jonathan Bither
<jonbither@gmail.com> escreveu:
>
>
> On 5/17/24 10:16, Guilherme Giacomo Simoes wrote:
> > In the dmesg is showing the message "failed to read out thermal zone"
> > as if the temperature read is failed by don't find the thermal zone.
> >
> > After researching and debugging, I see that this specific error is
> > occurrenced because the thermal try read the temperature when is starte=
d,
> > but the firmware is not running yet.
> >
> > For more legibiliti i change the tt.c for return EAGAIN when this was o=
ccurrence.
> > After this change, in my computer I compile and install kernel in /boot
> > and in my dmesg the message "failed to read out thermal zone" is not sh=
ow
> > any more.
> >
> > I would like to thanks for Rafael Wysocki <refael.j.wysocki@intel.com> =
for
> > your suggestions in mu first patch that results in this another patch.
> > ---
> >   drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/=
wireless/intel/iwlwifi/mvm/tt.c
> > index 8083c4b2ab6b..68ab9966330c 100644
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
> > +             ret =3D -EAGAIN;
> > +             goto out;
> > +     }
> > +
>
> You could skip using the res variable and move the mutex lock here and
> simplify the above a bit. Ex:
>
>          int temp;
>
> -       mutex_lock(&mvm->mutex);
> +       if (!iwl_mvm_firmware_running(mvm))
> +               return -EAGAIN;
>
> -       if (!iwl_mvm_firmware_running(mvm) ||
> -           mvm->fwrt.cur_fw_img !=3D IWL_UCODE_REGULAR) {
> +       mutex_lock(&mvm->mutex);
> +       if (mvm->fwrt.cur_fw_img !=3D IWL_UCODE_REGULAR) {
>                  ret =3D -ENODATA;
>                  goto out;
>          }
>
> > +     if (mvm->fwrt.cur_fw_img !=3D IWL_UCODE_REGULAR) {
> >               ret =3D -ENODATA;
> >               goto out;
> >       }

Hey Jonathan, Thank you for your suggestion.
I sended a v2 patch of this patch
https://patchwork.kernel.org/project/linux-wireless/patch/20240517171311.37=
05-1-trintaeoitogc@gmail.com/

If you want, you can send this suggestion in this patch v2.

Thanks.

