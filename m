Return-Path: <linux-wireless+bounces-668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1067680CF7E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 16:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A5BCB21472
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 15:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E2D4B5B5;
	Mon, 11 Dec 2023 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnegP7d6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD73E3;
	Mon, 11 Dec 2023 07:27:32 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d9f8578932so2190354a34.2;
        Mon, 11 Dec 2023 07:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702308452; x=1702913252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfbKV2/TY0MfyawkcDgwd2rGAqmms78JFhMnLhUszH0=;
        b=AnegP7d6FVHTiM1TWhKEHsbQoDWP4NFKLBYO0IsD2XFcJv61jCl4DERNyV2Qz+JKyw
         +lg7OOGgQ24lEMOEqvnN3ZBszrrE6s7I/LnSrXd6bXEqvJusEL6QohzD2k1UFiMdMh84
         RukRiQcQgHYkX8iT+YN8GwL7dSfBQibyYhoLBPd8RZP2eeZNhveC3+Q15T/iq3G/8mJt
         hD0zfHTq97xb7OtQR+eHi/9MND5EWYUpjzyfslTPfONmoDuMlkHpF+RoWIZuOqqhZufk
         EaqZzRufxYIwKh40avtIRctfmT8Z5+vplFqPPVpgdGb2+QTjB/f00KJHTOUAJrubBTlt
         GkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308452; x=1702913252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfbKV2/TY0MfyawkcDgwd2rGAqmms78JFhMnLhUszH0=;
        b=Wddb1DsuZ3OTJPVU6mbbaVkYarYp6O7ye8qLPBUm9RyJMoz7heeO5BEuIAZeR47IZY
         rymLeJEYNaq73RIqkZOvsNeaSNsSbGfDbMMKiZRqPe8ynpB0ciadDQfbti36jGjux5SY
         ki+D/aOIy8ocGcVIp/tg/KQCcFGH1WcfRAJpllxh5DA6HCsnzU2EqlYhvigBqhtYNh4X
         3iRDqVNpZskp05xvwYT0fkFilKazDdxfJd4su2t4ofjqTEt4EVC8LxYFCaOMZJvZlpYZ
         HD+qUmjMzcM9QwTliqekL9pOqdaBKm/HA3vahJLzJxaeGd4KWLozu+p7H3frvHav3eVH
         YKuQ==
X-Gm-Message-State: AOJu0Ywf3amesbTWRKtFbx2v9ygTzigRhByFcRzjuWhoimc0pDiVtEhk
	WWNK9JvGk4NqUpfs3Dc9IroJBTALcy3u2E+P9gw=
X-Google-Smtp-Source: AGHT+IG47sj6ougdG5tZAq3pwxJM83q+ankLP1ExYCnj8m+DGDohDP/ngyWyaNlX5BmakhSLo/EonuSm6eoGu5HEvI8=
X-Received: by 2002:a05:6870:350d:b0:1fb:1304:56b7 with SMTP id
 k13-20020a056870350d00b001fb130456b7mr5788311oah.7.1702308451822; Mon, 11 Dec
 2023 07:27:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
 <b2a4dfa9-e3ec-4c90-bb53-f2e6c70603b2@gmail.com> <23850b71-f530-4094-81cc-26cd762dc231@amd.com>
In-Reply-To: <23850b71-f530-4094-81cc-26cd762dc231@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Dec 2023 10:27:20 -0500
Message-ID: <CADnq5_OXRrGRH6iyFc_kfP2BARyav4uw3X0kuV3tP-7VXv3tMw@mail.gmail.com>
Subject: Re: [GIT PULL] mmutable branch between pdx86 amd wbrf branch and wifi
 / amdgpu due for the v6.8 merge window
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
	Hans de Goede <hdegoede@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Ma Jun <Jun.Ma2@amd.com>, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-wireless <linux-wireless@vger.kernel.org>, 
	amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 10:20=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/11/2023 08:47, Christian K=C3=B6nig wrote:
> > Am 11.12.23 um 12:02 schrieb Hans de Goede:
> >> Hi Wifi and AMDGPU maintainers,
> >>
> >> Here is a pull-request for the platform-drivers-x86 parts of:
> >>
> >> https://lore.kernel.org/platform-driver-x86/20231211100630.2170152-1-J=
un.Ma2@amd.com/
> >>
> >>  From my pov the pdx86 bits are ready and the
> >> platform-drivers-x86-amd-wbrf-v6.8-1 tag can be merged by you to merge
> >> the wifi-subsys resp. the amdgpu driver changes on top.
> >
> > The few comments I had for the amdgpu patches were addressed and I
> > honestly don't have time to take a detailed look at the general framewo=
rk.
> >
> > So perfectly fine to merge that stuff from my side. Alex or Mario might
> > have some additional comments, but I think they will give their go as w=
ell.
>
> My feedback has been taken into account already, I'm happy with the
> series now.
>
> I'm a bit confused how exactly the drm/amd patches get applied though.
> Is it like this:
> 1) immutable branch for platform-x86
> 2) immutable branch for platform-x86 merged into wlan-next
> 3) immutable branch for platform-x86 merged into drm-next?
> 4) wlan-next and drm-next come together for 6.8
>
> Normally stuff from amd-staging-drm-next is put into the drm-next branch
> and then merge through the drm.
>
> amd-staging-drm-next tracks a much older tree so I'm thinking merging
> the immutable branch for platform-x86 won't work.
>
> Maybe the right answer is that the "immutable branch gets merged into
> drm-next" and we just have some cherry-picks for all the commits into
> amd-staging-drm-next so we can compile but Alex doesn't put them as part
> of the next PR to drm-next.  When ASDN rebased to 6.8 or newer they
> would drop off.

amd-staging-drm-next is just our development branch, the actual
amdgpu-next branch is:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/drm-next
I'll merge the platform branch there and then apply the amdgpu patches on t=
op.
For amd-staging-drm-next, we can just apply the whole set since that
branch is just for development so there won't be any conflicts with
upstream.

Alex

>
> >
> > Regards,
> > Christian.
> >
> >>
> >> This only adds kernel internal API, so if in the future the API needs
> >> work that can be done.
> >>
> >> I've not merged this branch into pdx86/for-next yet, since I see
> >> little use in merging it without any users. I'll merge it once either
> >> the wifi or amdgpu changes are also merged
> >> (and if some blocking issues get identified before either are merged I
> >> can prepare a new pull-request fixing the issues).
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >>
> >>
> >> The following changes since commit
> >> b85ea95d086471afb4ad062012a4d73cd328fa86:
> >>
> >>    Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> >>
> >> are available in the Git repository at:
> >>
> >>
> >> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x=
86.git tags/platform-drivers-x86-amd-wbrf-v6.8-1
> >>
> >> for you to fetch changes up to 58e82a62669da52e688f4a8b89922c1839bf100=
1:
> >>
> >>    platform/x86/amd: Add support for AMD ACPI based Wifi band RFI
> >> mitigation feature (2023-12-11 11:33:44 +0100)
> >>
> >> ----------------------------------------------------------------
> >> Immutable branch between pdx86 amd wbrf branch and wifi / amdgpu due
> >> for the v6.8 merge window
> >>
> >> platform-drivers-x86-amd-wbrf-v6.8-1: v6.7-rc1 + AMD WBRF support
> >> for merging into the wifi subsys and amdgpu driver for 6.8.
> >>
> >> ----------------------------------------------------------------
> >> Ma Jun (2):
> >>        Documentation/driver-api: Add document about WBRF mechanism
> >>        platform/x86/amd: Add support for AMD ACPI based Wifi band RFI
> >> mitigation feature
> >>
> >>   Documentation/driver-api/index.rst |   1 +
> >>   Documentation/driver-api/wbrf.rst  |  78 +++++++++
> >>   drivers/platform/x86/amd/Kconfig   |  14 ++
> >>   drivers/platform/x86/amd/Makefile  |   1 +
> >>   drivers/platform/x86/amd/wbrf.c    | 317
> >> +++++++++++++++++++++++++++++++++++++
> >>   include/linux/acpi_amd_wbrf.h      |  91 +++++++++++
> >>   6 files changed, 502 insertions(+)
> >>   create mode 100644 Documentation/driver-api/wbrf.rst
> >>   create mode 100644 drivers/platform/x86/amd/wbrf.c
> >>   create mode 100644 include/linux/acpi_amd_wbrf.h
> >>
> >
>

