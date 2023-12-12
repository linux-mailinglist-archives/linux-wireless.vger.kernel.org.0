Return-Path: <linux-wireless+bounces-706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6973180F362
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 17:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A728B20D86
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073517A20D;
	Tue, 12 Dec 2023 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoXXAi3m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C139E1A5;
	Tue, 12 Dec 2023 08:41:52 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d9e756cf32so3645379a34.2;
        Tue, 12 Dec 2023 08:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702399312; x=1703004112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRdrB8cd28H/2/Izbx2aUiI9Yik6mjNLx89/vPRuiT0=;
        b=ZoXXAi3mpUl3oeyBMch/UAECcxQJpbO9afJ7Ce8m6dP1/id3jsOAtt2Q6QBR5N2TqX
         PrLlL1sKRs5DwWQjaZXQJZm+dUwCNRmWYOv32eZXPx0Xrrt5NBHhBeOy9qCKcsQAAUjk
         b8r+8Eup7tnPJKWdXKQOJ40lq7QSgbsvwpGF5caBJIsemKqxDwaox3ESmoIP9sV0lf9e
         2Qt4LslJK/huJ3CRzr/aLofH/VJGpGi8z88pm6/m3g1evE1cCqTkoNeGBoInRfRmUaTv
         yt7VCei2re7RnRGbA8cNHvgfj6PjOue6P7HPXFheO8VlnJwmvIZ1W92JGYD868uUrs3w
         5jSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702399312; x=1703004112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRdrB8cd28H/2/Izbx2aUiI9Yik6mjNLx89/vPRuiT0=;
        b=NU0Y4IoO9dqNbGqLfaV2h3qL0IO7wbDM2KE3EGm29OPQkH5oOS+/XhAH8Gqie17AAs
         KDymOCPwIpGk0N8Rupn/Kcurc0cTgi7mFz9d+WSR/69h4mWRXH4Rot+/cJdP6386Vw1B
         3gkpaDbB04njn7aqurTfT8nmV0Bhp1q2YecyrCtWz2gjcZrqUa/a7KnyAN0moaTLwq+V
         HRomHmJvhm8ynSsoYIeaD51wMsei4KdWnblU+O+p/UmqOx3jBUTE3zk+ODoD5OXWmUAp
         zJdD+GXaAQfPQr3+RkSzXWQIcUZh7Rv7TlOSjUs1LdMB8rFBOk7gCjVRzky4iY8dAtul
         h4Ug==
X-Gm-Message-State: AOJu0Yw+MbL+ZCA1zmx4VaKA+cNpWvDsKhe+JtVGSWS4xOIxorcFL3iL
	MkIg85uTjUdsroRdO8sh+c1UAbU14wIlMYI4gUk=
X-Google-Smtp-Source: AGHT+IE8T/ikLkFXi7N3tOYjDQb/4Wsf/bEp9kibW34I6ENqYarhzFArv5a//G8zYaNUisaAoNIG/cX0Su07oh64vTQ=
X-Received: by 2002:a05:6870:c1cf:b0:203:89b:4597 with SMTP id
 i15-20020a056870c1cf00b00203089b4597mr840428oad.40.1702399311894; Tue, 12 Dec
 2023 08:41:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
 <3a06ae67808800386117c90714637ef9a0267b37.camel@sipsolutions.net> <c4dc3d03-5241-4b2b-b0ff-6517f063ba29@amd.com>
In-Reply-To: <c4dc3d03-5241-4b2b-b0ff-6517f063ba29@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Dec 2023 11:41:40 -0500
Message-ID: <CADnq5_PEDDAjjMOKpeLAHoFVCgbo6Sg8iVWC7sX4Ntn-PHk90g@mail.gmail.com>
Subject: Re: [GIT PULL] mmutable branch between pdx86 amd wbrf branch and wifi
 / amdgpu due for the v6.8 merge window
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Hans de Goede <hdegoede@redhat.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Ma Jun <Jun.Ma2@amd.com>, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-wireless <linux-wireless@vger.kernel.org>, 
	amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 11:25=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/12/2023 03:46, Johannes Berg wrote:
> > On Mon, 2023-12-11 at 12:02 +0100, Hans de Goede wrote:
> >> Hi Wifi and AMDGPU maintainers,
> >>
> >> Here is a pull-request for the platform-drivers-x86 parts of:
> >>
> >> https://lore.kernel.org/platform-driver-x86/20231211100630.2170152-1-J=
un.Ma2@amd.com/
> >>
> >>  From my pov the pdx86 bits are ready and the platform-drivers-x86-amd=
-wbrf-v6.8-1 tag can be merged by you to merge the wifi-subsys resp. the am=
dgpu driver changes on top.
> >>
> >> This only adds kernel internal API, so if in the future the API needs =
work that can be done.
> >
> > OK, thanks! I've pulled this into wireless-next, and applied the two
> > wireless related patches on top.
> >
> > I guess if AMDGPU does the same, it will combine nicely in 6.8.
> >
> > johannes
>
> Yup, I've pulled the whole series into amd-staging-drm-next for now and
> I expect as long as we have no problems with it reported under our
> testing Alex or Christian will do the same include drm/amd portions of
> it in an upcoming drm-next pull request.

I've pushed out an updated -next branch as well:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/drm-next

Alex

