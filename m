Return-Path: <linux-wireless+bounces-4376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C99B871D7D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 12:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8926D1C22B6B
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 11:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C205EE91;
	Tue,  5 Mar 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxSRBNgy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E45EE66
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637584; cv=none; b=lvUZIJTcGDLZuAUNLye4/lBU8bnFQm15BxxrVmiJaDFt2z4PhdMQSMxEeEJ7No82qvYF7LtqQQ/zku21ZT0Ji0eq3ObpCMYgOjKvCGgEPRjasRgrTxZPpWRrQ0Ejkqv/YzCb1QV3WHmTa7nYc9zgOfDXnru7Qy7O7BAM6ntwUF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637584; c=relaxed/simple;
	bh=6xIiNqMvE0lVvmHIiJVWObLROUZ5wRXUd69SlezNj/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEiuqLKeSEmczN0Mhp5HnXrMt7Xb41eywu8ITp0W/CP/lWUx1EZma8rf1eQsEVwEuRviZYAe8W1JfrZZVm8UVcovbUsn5BE6UheWsmtqfZvN5ai8p19K67459m8FGaKOYNX1b3h14drGoro0ut7AnWI3xi3MBR0ovdGHQToJWHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxSRBNgy; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so5342490276.0
        for <linux-wireless@vger.kernel.org>; Tue, 05 Mar 2024 03:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709637581; x=1710242381; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ydwbN+Sy9YXJT7SqQiBWRDfaLr+wNxx7voo7Gz98xVE=;
        b=CxSRBNgy5fN+Jq6T7rF4xguMV9DZZGIdmGSdH5Q8GglvEqypHnus92K/JxOh3TbOdV
         9SIGlkk2wcK1QzY7lANsQQcapzDsvMIRdN40lq7aLVj10sLWLhpt1Zgy6IxC/yzVKEBn
         XdGzr1DIxCMoUq703Xw99UU53YK8F6UvY5va/aGue1bOAGtVI09MjJIEUgBNzVv87YPJ
         mwf0wughqrcfkalRHSPTWXT2lAPa+dy8El5nSKYtXCfDsMm1Jp0COlQU+COmpsCagAZ7
         QD/AduBndmJ6NEjOq4jd9QGbyxv61VbLwEibLTuQyCj7o7bAUMbl7G31qyBSRY5M4aRx
         Lnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709637581; x=1710242381;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydwbN+Sy9YXJT7SqQiBWRDfaLr+wNxx7voo7Gz98xVE=;
        b=qENIQYJ+YEBrdoJfsEkpOgtX1ynBRU6rIUsf8Jgp77mNz5edFQxTFpMpYNkVIwFgHc
         ROYuTNTHAkvOUBE1r6/34yf64xl4N4nsAbE00iC6wiyFvnaE58k1GZvxyuQJV/MYzM+s
         eGlPE+8oyXfsgC/n3oFs479QLNuDaJhV4oFKM+ztrhFM+yj4F+dQ3NdW0gw/XS10Gyev
         2FLn5oOnGg76xD/mTBug81/vy9BtC/M8pGQLE5SxKuo/gvI5xUr1QJdUu2G6IW2pinG8
         cjWTBFRKCyMxBFcJdFATsk5mi3EDUsLSZE7aAg6m2BeYq7BrwszOsTEtMwUwUIvM9ZBx
         7SHg==
X-Forwarded-Encrypted: i=1; AJvYcCVGw/nQSM9LEhwGGJIpMoZmOMav/aNNWMhIbKxAJfAqhOuVFRqSORHagDaQkRX/gZrYYSkF2a7suIoChwP70lB6lgTXFGaYWtPP2kGPmQY=
X-Gm-Message-State: AOJu0YyHWFgbnZn8PadmvBA3jRQrDvJt8cFlPqgvcjuyJee/7nB3FhTn
	7yYLgKdAgXZCX8VAJsC95PGQbIA9GkLSyZvZSvY5NgKki9M9I/3IcVyCo422ipHuko09Aa/FkDd
	5iCH2OS1QNRtcA2QPvu7tcp+njp7vhxmZr5nQvabI1D0=
X-Google-Smtp-Source: AGHT+IEmS91c0mltAjjfWZdrOpU8cVXUdn/BQ1R07DrHAmacS8F0MS6UHi01L0SGk5PRhBeQFyYYJjWdDCLrVba6KEA=
X-Received: by 2002:a25:2692:0:b0:dd0:972b:d218 with SMTP id
 m140-20020a252692000000b00dd0972bd218mr2273119ybm.41.1709637581543; Tue, 05
 Mar 2024 03:19:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5c5be485dcfceb44fc731e47758d6be3.legale.legale@gmail.com>
 <12f91b008d6f2b4e6241794d2852c1c84fe6c12c.camel@sipsolutions.net> <CZLQMMSSUWBF.1NPJJYDRIXGIR@gmail.com>
In-Reply-To: <CZLQMMSSUWBF.1NPJJYDRIXGIR@gmail.com>
From: Isaev Ruslan <legale.legale@gmail.com>
Date: Tue, 5 Mar 2024 14:19:30 +0300
Message-ID: <CACDmYyd7Sw9nFZe3A8--1nU7c6-aTSY6c-+Zfq20T4T_9826WQ@mail.gmail.com>
Subject: Re: [PATCH v5] Add JSON output options to 'iw' for scan results
To: Nicolas Escande <nico.escande@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 13:17, Nicolas Escande <nico.escande@gmail.com> wrote:
>
> On Tue Mar 5, 2024 at 10:41 AM CET, Johannes Berg wrote:
> [...]
> >
> > I'm generally not going to look into these files for now, but including
> > them internally means we have to maintain them. I'd almost prefer a
> > library that can be used.
>
> For what it's worth jansson has been very good to me. It has printf() like
> object creation which usually integrates well with c programs.
>
> >
> > However, with that said,
> >
> > > +/*
> > > + * json_print.c            "print regular or json output, based on json_writer".
> > > + *
> > > + *             This program is free software; you can redistribute it and/or
> > > + *             modify it under the terms of the GNU General Public License
> > > + *             as published by the Free Software Foundation; either version
> > > + *             2 of the License, or (at your option) any later version.
> >
> >
> > This doesn't work well with the ISC license of iw. Which is another
> > reason to prefer an existing library, I suppose.
>
IMHO jansson library is more complicated than stream jsonw which is
simple as a hatchet.
I can rewrite json_print.c with any LiCENCE we need.

