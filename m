Return-Path: <linux-wireless+bounces-29637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0960CB3CBC
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 19:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2A0B30092B5
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 18:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB843242DC;
	Wed, 10 Dec 2025 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQxGO3n1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxSGmemB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732ED21D3CD
	for <linux-wireless@vger.kernel.org>; Wed, 10 Dec 2025 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765393026; cv=none; b=ZHrgz2IrlVe4w8q1oJrIVW/32isNabefgZCNRRhkMgXWPuLyTiAna39lWyeT3X+aUvNgKNwliA/exx7ZN5iBps7xOL2kKrBz7ECB9SmMifsUBibHytGjPa6ZLEoNaejY0i8vCn+JU/T/ekOzxSOa8+rw2NlS/bhe5gaa04l7nvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765393026; c=relaxed/simple;
	bh=pDLz2Z1cF8AZCFigE+HLvYTREQirLhzwRY/27Bc0jsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXaRoUKChdmHfTSGDSUp3fYPDvqLhx3Pala3+0rchRk6F4qij4vpiKDcBG6K9Crkme4PCFB7XBKeOdJbyPyI8a17woZYgqKdmxfaPmcTQeGRJckQAqvFSxFZH/5fxpMSMPl61RbDGtfX3seA8ItPbzz52GeFCYK2tGjTZdSEm4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQxGO3n1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GxSGmemB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765393023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STdZj/gTpU91q7iKikbx2iP+52KrVDrqIu6yjAf4Pwk=;
	b=ZQxGO3n1ioWjBdaCrEA4vyCzckNtdk03qaMNytQXxE6vF5otmeXOwBQuTTGaqTB0PZ3220
	JdUMf6JqN3lUmyONsF0m1ZZAajPSNkDSU7LIfke2ydPTazo/tAq9EZS5GELzGopx5GPnx6
	Rfg/6xHrEHU3ver/p64h9+mcA7h7JW4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-c8fE32tGNkeZ0gUzAz1ziA-1; Wed, 10 Dec 2025 13:57:02 -0500
X-MC-Unique: c8fE32tGNkeZ0gUzAz1ziA-1
X-Mimecast-MFC-AGG-ID: c8fE32tGNkeZ0gUzAz1ziA_1765393021
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-640b8087663so236161a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 10 Dec 2025 10:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765393020; x=1765997820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STdZj/gTpU91q7iKikbx2iP+52KrVDrqIu6yjAf4Pwk=;
        b=GxSGmemBJiJuYrAE0bhFN8j09WINbA7OsfG8npnq6SoPm1ZfReWiLuTJgiptk5/A3t
         pswZPpwIfFjQD+dn9BafHBTUUpLD3PdxLhbLYlIZB5keCjGN7dBebcgTun1X+Ob2736d
         Xe+fUlOw5isepaHbSWCV7rRV7sqkjX+/C8C224i7JtjetogPm8sopa0AzIsYDYGQinCg
         zvvYhkfL6lH4cY4jALqykeUvUkCKwAeSevs8sh1xzRwOelkme6kAV6HVIe+9Pc+Z4jEv
         G/rmNl1rURyraXHHpK/gmkDj26sAXViObQkMra2RmJLV7sxCtyg5ZK5MwIbaxJLgc9HS
         j/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765393020; x=1765997820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=STdZj/gTpU91q7iKikbx2iP+52KrVDrqIu6yjAf4Pwk=;
        b=q93rJUt1xdep47Ke2CuRghGbMeHKaapRAPv4mOn9b8+Ohr5PdVK0EnGMQ0uRZn3uM0
         5QfcIEvi9JBWFjvJOkzGBPRQDYP1YTZkobsak0cqk3ga6tsX9YROk14BB4Enntl6lWAV
         J81KsgeBW82CHjTINcsHDnwDG0GpbsfyB1t1o/fi/+6TBtD8QN+aFaqua7YxqNhvl9lP
         ibSclZUzEwVV4WEAjdI1PpLJ+j9+1NpoZbHsi1TR3HNQvqejfN6aUPAbohsxr0GeNKKD
         uT3DHtIB6nX68dHLeDwdngeKQ9KE0kiZFRn+hP1M6Z1ZnQs57qB8cbm30ILAJQl9CQPi
         AgiA==
X-Forwarded-Encrypted: i=1; AJvYcCVHZN1r9Szq1APvITgWCFDPs5ibUUCMl14FhLD7FgTnDRPHxDRdSXi2Poiw3ly1tVRJGuC8frb6K0Q/A+beKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIIJ917L3zj0Q3NQLCodod/2Ha+qSwTUGFBb5BpNdKdCZsTAJ4
	O6C54XSpf7eZy4azmOWYq0EBKbK6a55majtMinjO8HgU7Ebf+BIOADR6OGwVIB9FkL35gpyjrWx
	GeQ3bh61JGTAuyQ0qD3NQokoNw/1DO63ktsGbvpqmvRgDf4sDWwNpozL65HYbQNdCO8ZFiyFe3V
	tlO5eOIDA5Lkxsjr8GTerEOCXm3aSQGibluHgKuqTg6r3MZyq43UaS
X-Gm-Gg: AY/fxX50lMuxCOQ7bjPOLHRqaN/nMbTMmemDfos9h2LkZmx68vLXl+Nm/85e7f4UloU
	HWTTM3gOkTq1wGJTIhtR6VmXVENkbVglVTWpIOSJWfCHHqb6KYOAw77MoyAvoFhg9IpwXiZxz2z
	RXQDD/8N/9xba5MT3J4RabXBhpTahWrnoalE/aCEH0der9aAY+KH2VpLGZk/1M5EpmsMAm+3Wij
	sWuhUDjLIhqfL9n8aEVXcnKyg==
X-Received: by 2002:a05:6402:2707:b0:649:634d:64b5 with SMTP id 4fb4d7f45d1cf-6496db7a496mr3031425a12.31.1765393020506;
        Wed, 10 Dec 2025 10:57:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRpD70Pboqj8Pr3O0GPbJ66JhF1XWz6eeK3aQznoRMaVALTPPAHbUYnbG0zvpBA68/T0fQVCi+8A94PRVaoJw=
X-Received: by 2002:a05:6402:2707:b0:649:634d:64b5 with SMTP id
 4fb4d7f45d1cf-6496db7a496mr3031413a12.31.1765393020141; Wed, 10 Dec 2025
 10:57:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6cc422bb9525be529c6b0d2d25f9869ca41ec77d.camel@sipsolutions.net>
 <20251206173345.356068-1-dkarn@redhat.com> <3012de51f1dd363d1ba8f34bd1252add2977f608.camel@sipsolutions.net>
In-Reply-To: <3012de51f1dd363d1ba8f34bd1252add2977f608.camel@sipsolutions.net>
From: Deepak Karn <dkarn@redhat.com>
Date: Thu, 11 Dec 2025 00:26:49 +0530
X-Gm-Features: AQt7F2oyEd-qr4k-viZUWP8A6XhwvBsVrS6IuvlMidUJTG3bCXV9mmdQRM9XGl0
Message-ID: <CAO4qAq+jhorTvi=Y9iFvF-4x3SWq2Rf7PE+rA+uN1Au+e03T-g@mail.gmail.com>
Subject: Re: [PATCH] mac80211_hwsim: fix divide error in mac80211_hwsim_link_info_changed
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	shaul.triebitz@intel.com, 
	syzbot+5bb5f06f99924ea0cf86@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 2:00=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Sat, 2025-12-06 at 23:03 +0530, Deepakkumar Karn wrote:
> >
> >
> > Thank you for your response Johannes. cfg80211 already have validation
> > in cfg80211_validate_beacon_int().
>
> Oh OK.
>
> > The problem seems to occur in
> > case of interface shutdown which calls ieee80211_do_stop() that makes
> > beacon_int =3D 0 or set_tsf which causes divides by zero.
>
> Why would that call set_tsf()?
>
> And yeah that should make beacon_int=3D0, but not have beaconing enabled.
>
> > What if we:
> > 1. Handle off-channel operation:
>
> >                 if (test_and_clear_bit(SDATA_STATE_OFFCHANNEL_BEACON_ST=
OPPED,
> >                                        &sdata->state)) {
> > -                       sdata->vif.bss_conf.enable_beacon =3D true;
> > -                       ieee80211_link_info_change_notify(
> > -                               sdata, &sdata->deflink,
> > -                               BSS_CHANGED_BEACON_ENABLED);
> > +                       if (sdata->vif.bss_conf.beacon_int) {
> > +                               sdata->vif.bss_conf.enable_beacon =3D t=
rue;
> > +                               ieee80211_link_info_change_notify(
> > +                                       sdata, &sdata->deflink,
> > +                                       BSS_CHANGED_BEACON_ENABLED);
> > +                       }
>
> don't follow, that only does it when beacon was actually stopped ...
> maybe do_stop() needs to clear that bit if there's a possibility of this
> happening in the wrong order, but I don't see how there could be a race
> since off-channel must also be stopped at that point anyway, unless that
> is in the wrong order.
>
> > 2. Handle case where debugfs is written after shutdown or any race cond=
ition during disable beaconing:
> >
> > diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/ne=
t/wireless/virtual/mac80211_hwsim.c
> > index 551f5eb4e747..8363cdd17a97 100644
> > --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
>
> first of all, I really do think you should *not* (need to) modify hwsim
> at all
>
> >         conf =3D link_conf_dereference_protected(vif, data->link_data[0=
].link_id);
> > -       if (conf && !conf->enable_beacon)
> > +       if ((conf && !conf->enable_beacon) || !bcn_int)
> >                 return;
>
> But this also makes no sense, it shouldn't be possible to have beacon
> enabled and beacon interval =3D=3D 0.
>

Thank you Johannes. As you highlighted I searched for a code path if
there is any place that has the
invariant condition of beacon being enabled and beacon int is 0 but
none seems to be having that.

Regards,
Deepakkumar Karn


