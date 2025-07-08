Return-Path: <linux-wireless+bounces-24912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0C1AFC53E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 10:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422293AD551
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 08:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F47242D84;
	Tue,  8 Jul 2025 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4d2MmHb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F7618024
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962636; cv=none; b=fmpXe4w9xt7rPKpQks8WhRAoRmbbgHb1xRLiFremdja3epbivmqO0GHUP3mvdG5+PAtweBB8F6guRjyy4aCTHmZPH6ucBK8UpW+aFYba+xUcn9e1eWZHoZEeXBm2bfTz1yniZP+dAmtGEjBHxjTHewXHD3AKd2rIaZm7KJU6a6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962636; c=relaxed/simple;
	bh=blPw/yc4VZHM6zJf/RilVwmyL6mOylS/kcJWUNpZZsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+qTOSeC476UQ+zmAlSRI/se1xumIkd1AO/GUW0m0K4McLnE0+49biIqhQ/+FpV6qis92lxq1Z59+Fo0y6SFI/A+AQZUAHWaDlSk/rj+j/MkcH1Lv9G+WUdewHS9TviUkOWFsWmBAG5Pwcj+7H5NaxojZb1oUX6cGHm+7H72ZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4d2MmHb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so701401366b.2
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 01:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751962633; x=1752567433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HI6uy3/VA9ODWgnMqFTSxnicfikmsNzPdv5EuvAouoU=;
        b=f4d2MmHbhnc0eSxdigO6zjy6RotrJzklfWaFRSrPri1gVWz8iPldlks8AqoZaYCOK9
         hS498GTkYfYtWQEA9fXeAM4aKzFHwCsJx6oTPZOc1RS8SsEh+M1huO78HdhJOVv+yOVH
         AqOKk5YflA6Q4zr9NDvTeg8jUVjy3w64RlT/ctotc+5FWl9AOsEDxUXAHnFWhbWmV8hr
         hR2h9o4Ru/mhKxgQDl5SxNupC3AgS9p5Ob9JuaaOQX5kT9vMVweIwrWhN73mM9xoAtB/
         U27iYGIZ4WF3RFnK2I4NZqumRxmnQrSbxJovuHL1JIugFWdPz8h8uoH6Y3NnkUz1Cj8Z
         wWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751962633; x=1752567433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HI6uy3/VA9ODWgnMqFTSxnicfikmsNzPdv5EuvAouoU=;
        b=LnUFKbbAuy/VpjeWz7AV5pUCR22vkjNGQJYvLQh7FQB/A0tl4TouXwd6W0sJZRjzAC
         aRRgpXTWwClqWzxn4xcpnr9J3Fd2kpqYIRcYgnMC8ZnpdJ+LKeRzg+r/91S0TtVzsjAW
         hGfkTA4tQDNdbs1sA7Mn5SNElpPa9vKGPuKbXYSP+JlQchhXkZWCQmI2oxnM/c44F6sb
         MdwowDVhgXlUTYfHBT+soed8QWxV0HWbKrX+G7CpifPwG3AeWkPz1SM69l07GdmtjahN
         f+t9yUSAtbh9AOFOnIQnuqbKGLV08eMNbx6rqwfV4VuRsklLdPP9bCxvCwYDTOehUMJV
         VvEg==
X-Gm-Message-State: AOJu0Yzs6lghOmW17A+qGBPAH8FVJjIIp7Y6+vuj7sD6cxTGFIsl/6EC
	VlxHdH05oOw3kyMLVVtH9jYxwDCesKybxTVoqOKkPYIfOFiMtNK67d9dMDQPhIjRPE/ffOIwUQS
	TzUdgQBT0PrK/PdI9tjjt61HNroikEBw=
X-Gm-Gg: ASbGncuB5UsnlsRB9Ycg9fmxAeejpEcghmGprYaqeDrKXl2hWSA/7ADsNNb8my0X21M
	BgpGC1zKh6FtMmR9CJoyTwhaYbFTQ7saWx8eVtZMpA+9JYB1o16oGJ2D6QzbY/GLciUTwYX+oNt
	S+QJGzHxlonVnD3GBrByclzvCiTNyy/8U3JOfNlZYdTiw=
X-Google-Smtp-Source: AGHT+IEmWCLMD3Tas03el2MROEquJ/ls6tdQP9T7z9a0b5GgjOI02bv1CITiE/ML+H5CRU9PQbtqjE+hJArr3fhhtpA=
X-Received: by 2002:a17:906:6a16:b0:ae3:c780:b883 with SMTP id
 a640c23a62f3a-ae3fe82d4d8mr1633925566b.54.1751962632684; Tue, 08 Jul 2025
 01:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708015005.6470-1-pkshih@gmail.com> <CAGb2v67YNZG_-MtJT_pncaqeQULj3FGLj7jpSUSOGTXe2ipGag@mail.gmail.com>
In-Reply-To: <CAGb2v67YNZG_-MtJT_pncaqeQULj3FGLj7jpSUSOGTXe2ipGag@mail.gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Tue, 8 Jul 2025 16:17:30 +0800
X-Gm-Features: Ac12FXw5cCDxyXC22kgmT8lPlGYC45ldlFXO_SGEEYiTvFw45_ycYDRtycdSzl4
Message-ID: <CAHrRpu=rcXQzBO-NdDYBxj02WpMAHyP8ZdQhU=ScO=bOQXk9Tw@mail.gmail.com>
Subject: Re: [PATCH v3] wireless-regdb: Update regulatory info for CEPT
 countries for 6GHz listed by WiFi Alliance
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chen-Yu Tsai <wens@kernel.org> wrote:
>
> On Tue, Jul 8, 2025 at 9:50=E2=80=AFAM Ping-Ke Shih <pkshih@gmail.com> wr=
ote:
> >
> > From: Ping-Ke Shih <pkshih@realtek.com>
> >
> > The regulations enabling 6GHz WiFi [1] of WiFi Alliance lists CEPT
> > countries including
> >  - Albania (AL)
> >  - Andorra (AD)
> >  - Austria (AT)
> >  - Belgium (BE)
> >  - Georgia (GE)
> >  - Iceland (IS)
> >  - Liechtenstein (LI)
> >  - Macedonia, The Former Yugoslav Republic of (MK)
> >  - Moldova, Republic of (MD)
> >  - Monaco (MC)
> >  - Montenegro (ME)
> >  - Norway (NO)
> >  - Switzerland (CH)
> >  - T=C3=BCrky (TR)
> >  - Ukraine (UA)
> > Add 6 GHz frequency entry if not being added yet.
> >
> > The following are skipped as they do not have corresponding entries in
> > the database yet. Adding an entry just for 6 GHz would cause 2.4 GHz an=
d
> > 5 GHz bands from the world domain to stop working.
> >  - Faroe Islands (FO)
> >  - Gibraltar (GI)
> >  - Isle of Man (IM)
> >  - San Marino (SM)
> >  - Holy See (Vatican City State) (VA)
>
> I also went through the whole list, and it seems "Bosnia and Herzegovina"=
 (BA)
> is missing a 6 GHz entry. Could you send a followup patch to add it?
>

Sure. I will go through whole CEPT countries for 6 GHz entries.

