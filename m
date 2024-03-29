Return-Path: <linux-wireless+bounces-5528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D17C891538
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 09:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8291C21C26
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F3FA936;
	Fri, 29 Mar 2024 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dVgzRPm+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A3BA4D
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711701350; cv=none; b=TNuNQIkdg2eRhZnpw3vrEN+GrOIoO51GOqNi+KEb7Z/t0Z+cPYBGrWyw9FJoX1SvBlBeVQErszDT886S9AOysdXgSL2YahJV8MQYcEUbqZLtL2u80YDQzgJk+PiLzOFVRLqcG+nlSxsND5yTBEUYNZcGQfFJdElT6GKUQgdRw+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711701350; c=relaxed/simple;
	bh=inFqEp+XcIGqFbbLq/PKqD5u5PKktYkf+UyYTcnAtq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmeHcjJUIPxvdQKwLWS+KWH+cbOo1n6vYDR07c5iUN07C0b9W7fWwZoSMJ8lhLj58VKlOec6WWUFG+OjhJ+4rNL5zb9ROz6/Ws9I1Ad0twuxuKyMpPZqOOHftAetjNJo/Y0j2meH4Ixs+5G/O8G25RDYexJxMYUtuvoCRlOZRHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dVgzRPm+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0411c0a52so15967335ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 01:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1711701348; x=1712306148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inFqEp+XcIGqFbbLq/PKqD5u5PKktYkf+UyYTcnAtq4=;
        b=dVgzRPm+vYyEfbFczT6twYdrj3Ou0ivWHQWJ2UCVm+ObYRveKF9Z/p0tFqEJkIGTz+
         fv++JAhstRTI14uIRF0K7I9W1O4UtVGLCvNPWnKQ/Ac4ghWkc6HVdgVjGN1446dRYs6V
         jpu0IRVPfjGayhSaVEQ3V7kG9C6ngP4LvsOITgWq+3ZDzJm9oyvq2X7z29v3aeT0WKBG
         UZIuTrPT3vwT4BdYUMnI3igKnveARU+W9aUwQ/YJQK0R1vozI3p5pGdw4peOUI7oFsWi
         2LswdB7HL7Row8ADiQ7XaazplrYLzwwh2/t6jYAHUa0MfsYGmeVcPrnJ9qq+VMxIyQiT
         0D/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711701348; x=1712306148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inFqEp+XcIGqFbbLq/PKqD5u5PKktYkf+UyYTcnAtq4=;
        b=rwtNYUnKq3i3obn9x3Zbo5q/KgxFxPicUpNAfen1E58cbm2tPu/c9RJDGnsFqxO3yF
         EoTF7ovNKbI97B9EZO2D8bljB7F8EBPnXPrh9/TewfLer9HUfutpx88RpCznB66E0neI
         FGqgTzxjgTBX20aDmWNBiU3a7j/axC1w14VHigUmS7RamnHi2axFXXwRYpahq4RbKnLe
         t84X1lPjXwQRvEGF7vpXPOLNRg2z/RUIvmBVdw5/2cDlauWluU/9IaGZ0EeKBTTCNh2j
         iqO5BqIQdSgb5y7PlvXRRPH/Ua5CyyVqf5lus70pRxcyk5goOh5ld3goWSpnfoBU9oNj
         86ig==
X-Gm-Message-State: AOJu0YwuYW376/CkS91ewYuyizm/MZc+DPrrhIXJj1I72hZYpnOv8sCB
	WnOSiGrpxkNu2Es9HuCQ04RlfYL/rf8HKmC1TiU8Uyz33docZj6bzaXLZ+cPaA/JAgBDqg5uWh1
	75ujLyO/o1u05V4ZbsXhVUw0zlwtSOy3ie1w=
X-Google-Smtp-Source: AGHT+IHIc62QO/c7tahmzmgMRJne8DnNdiEopRjzdIipj7T0Qx4qCkzF6hD9zns4+Lp4wksiWYWS3voRfKKtZ2R7mz8=
X-Received: by 2002:a17:902:e5d2:b0:1dd:5ba0:e0ee with SMTP id
 u18-20020a170902e5d200b001dd5ba0e0eemr2116527plf.9.1711701348138; Fri, 29 Mar
 2024 01:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327004155.7172-1-pkshih@realtek.com> <CAFBinCB5SiP3r-iK3ENUSxsdzaKQ+ZEjAcY0Mn7di54rABRewA@mail.gmail.com>
 <0be24bf38d23307be2a0dc8ccf1101575c2cff29.camel@realtek.com>
In-Reply-To: <0be24bf38d23307be2a0dc8ccf1101575c2cff29.camel@realtek.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 29 Mar 2024 09:35:37 +0100
Message-ID: <CAFBinCCufGhag6N6skzk3MR7=17vnog2H04kXcjz=2ALMb0TKQ@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: rtw88: station mode only for SDIO chips
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 2:53=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> On Wed, 2024-03-27 at 23:11 +0100, Martin Blumenstingl wrote:
> >
> > On Wed, Mar 27, 2024 at 1:43=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.co=
m> wrote:
> > > Since only station mode has been tested on SDIO chips, only keep it s=
upport
> > > for SDIO chips to reflect correct supported features.
> > >
> > > Link: https://lore.kernel.org/linux-wireless/87wmpu1do6.fsf@kernel.or=
g/T/#t
> > > Link: https://lore.kernel.org/linux-wireless/36972ff5-0c48-4bd2-8f9a-=
9649bfa24225@lexina.in/
> > > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Thanks for the ack.
>
> Normally Acked-by is added by maintainer, so I will change to Reviewed-by
> when applying this patch.
Apologies for my late reply.
That's fine for me - so just for reference (since you already applied it):
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin

