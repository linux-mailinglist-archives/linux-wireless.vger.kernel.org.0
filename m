Return-Path: <linux-wireless+bounces-11050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7085A949D85
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 03:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E561F2208E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 01:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7309518FC98;
	Wed,  7 Aug 2024 01:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpsQyYYo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED18FBE4E;
	Wed,  7 Aug 2024 01:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722995794; cv=none; b=kbZXxjehF9U3/XIub9xp3DDdYyeT+fYf6zOdto2mFBL/Y5SmGDuPrINh429p4YWHbvPDHYLCcmt8GjwJgG3qrSUpPXWPlrAAMyGJ1nt4o4K9DPY6qCIrcAQOa2U6lPx5kAie4g5pwop1cpuu5tH01zhrmRMcDKWU2LqKR6x1yHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722995794; c=relaxed/simple;
	bh=Ebnkc8J3OyrIaJUN0uV5CXLbOqdgKWgIkvwTTVeQPMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tb4gKUS5s8dZRKAlZ997e5P4dDhoVTsYflZ5dUwt2l0z4ygNHRJ8cpATj8WZDHAhYrwBDik8/pkZljDME6BNxIk53G7c+cUUnv2cFKfYxTfSDFMNJrPEiwi8x6xobOHuu/K8BL6fa7AdYmV2qcDkyNpe2jwiH0GL7luDVe9uafI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpsQyYYo; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-81fb419f77bso61599739f.2;
        Tue, 06 Aug 2024 18:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722995792; x=1723600592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jVm+6swf6LWA/IIm+YBvO4+w9T/WqsByVQwTv1ViuU=;
        b=WpsQyYYoHwEBGoEgqtIJVk88ue/cn1amUEQHC5rWFrSznfcUwhU9U7s4CgSnJrbP/O
         7My+d+Ar7wzFwpEOZStJvMYuFZEJzQdYTdzLjzhGuYkGcSj8lzHn7ympQfYIOv8qLQ5g
         Gw0P8By4revAxsavFnnZ8Y1IEXCCGCHk5533peoiLnjhSVunzAdgX6yXP1ZeaJjTZhyq
         olCBWhvdZZ0jEPjC0+oCBVaRG7b1pLOxT9FmdiJsMoooDlijZP0kJ/UyI/fLTVWAxLVY
         b5ttyZKIuR9y2p6A6a6n6FgK/6nXd6YRMlRCEeAvjEjzYzkqyWOvRhDW2Oq+6wnwPUnn
         7pIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722995792; x=1723600592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jVm+6swf6LWA/IIm+YBvO4+w9T/WqsByVQwTv1ViuU=;
        b=X9abmCMiVbH3ZLt6LoYVetBev9lFRCWVfYac6e3k+mEyjI9hHW5vIo41EoaJ2r0oZ8
         FYMtbQw4HXv6O/eioHVxC/z5lCI6Xpd1kLfQ/w6kVKWRs/vhfDtsYgD6oCvgiewWX+dE
         rXiIwCxK3XOLjLucuMKp45k8h0COsI9sW3OASHvH3POrjgJI1HwzVZz/r9AwUA8aSnxF
         LZOYfoFyqWbBLjtsUlD/Qirm3l+kZVNb3Aup/WVBSah1z1L8odqWOD0fta5okQ6NfaTs
         h4JDbA5UmDMwapwuMgoEJyDOeky9IUeJfRGv0epP5+jBDtIxsKTCvlFAKFujubKAldJ8
         TP2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFVX+qL5zxSZnfD/v2lRaK6dzGOU80Qh9pp10icO/Pk16u2z9P7u4j31+oPBrCCRr7b/7N46BdV18qpSmfnBi32TGAvDkS8P8s25/hG3+4ZlNnlA7lcKB/DShAAG2YXameDT+jOblKmo+mkBX6Jr8lMwLCgj1AK5Hjq30vBnrOOn1t1pcQ+7U=
X-Gm-Message-State: AOJu0YySYJFjlLDmL0kD4jGmEwXqbWsy4BgnA6krryJ728wT5TdfkdtG
	GgGF90Y0SVIZp0eNDwOgQoxezS5XCm5RJpQhV8+moOxTS7s9o+AjuB8/RhOfGiOPdYheLbSThC7
	08aaIMDgfBtXmPy494D3rtY2GEA==
X-Google-Smtp-Source: AGHT+IFU4WjJCDa0hUEEMOdiBTSpLeGBgrqYR3z7SaiW5hi8GqvIXvawMbLZNg1gdEbB7K9600mGNQrSps70tEMk2Sw=
X-Received: by 2002:a92:d683:0:b0:374:ac3a:e32c with SMTP id
 e9e14a558f8ab-39b1fb8885cmr187843315ab.16.1722995791981; Tue, 06 Aug 2024
 18:56:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024080359-getaway-concave-623e@gregkh> <20240806015904.1004435-1-wirelessdonghack@gmail.com>
 <bc57c8b3-4334-4595-8b5a-5233316edcfb@rowland.harvard.edu>
 <CAOV16XF8cEg7+HAFQiCUrt9-Dp4M+-TANjQqRXH87AAdgzmNMg@mail.gmail.com> <ffc826fe-4753-4e7b-92aa-080f58b73c39@rowland.harvard.edu>
In-Reply-To: <ffc826fe-4753-4e7b-92aa-080f58b73c39@rowland.harvard.edu>
From: color Ice <wirelessdonghack@gmail.com>
Date: Wed, 7 Aug 2024 09:56:21 +0800
Message-ID: <CAOV16XGffTEP4JUsm4hZW5YuOFtCk6_Yu0B9QeMKWb_BLH3KHw@mail.gmail.com>
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
	mark.esler@canonical.com, stf_xl@wp.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Alan, =E3=80=81
Thank you for your response. Yes, I am able to test patches. Please
provide the necessary patches, and I will conduct the tests to verify
their effectiveness. Best regards,

Alan Stern <stern@rowland.harvard.edu> =E4=BA=8E2024=E5=B9=B48=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=B8=89 02:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Aug 07, 2024 at 12:47:26AM +0800, color Ice wrote:
> > Hi,
> >
> > I'm glad that you can address this issue. I believe that this is indeed=
 a
> > vulnerability because the issue is caused by the rt2x00 driver's failur=
e to
> > properly shut down its async queues. While it requires sudo to execute,=
 it
> > is still a problem as it can trigger a kernel system exception. We can
> > imagine that this vulnerability could be executed without root permissi=
ons
> > in certain scenarios. For instance, in many embedded systems, configuri=
ng
> > udev rules might be necessary to ensure automated operations, and in su=
ch
> > scenarios, it can be triggered without root permissions.
> >
> > Therefore, I believe that from a vulnerability perspective, it should
> > indeed be eligible for a CVE, as it can be fixed and it is indeed a fla=
w.
> > If this vulnerability is not addressed, future driver processing and
> > adaptation may encounter robustness and security issues. I believe secu=
rity
> > issues should be handled with the corresponding seriousness.
> >
> > Thank you.
>
> You didn't answer my question.  Are you able to test patches?
>
> Alan Stern

