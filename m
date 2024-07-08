Return-Path: <linux-wireless+bounces-10082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FE092A9CE
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 21:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20CD7B21DEC
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 19:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D6F14C5BD;
	Mon,  8 Jul 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8IynfUL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DF914C58E
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jul 2024 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466841; cv=none; b=nTSItN3nP5hIs5LBMGFvfgGE86etZ6NZeFLRJ4y0kCwhBWsX2O9E1vt72OVbx0x+cZYSrWWzvvWAVGIacsncMuaJgcWsd8ZiDVgJat8SUVYCIB7goicrSHe66CXWn22ow4my32aexhLXwqZKIXCRvRJAJ/fOP4cveLGDmO1D4zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466841; c=relaxed/simple;
	bh=sE/TC7a66+gKH45F+CxcE03eguTRbInKlYcv+mCBwOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IITZRYGG9nOO1D+dC9SePwyh0JxXrWaEM38G46pQYx/IefNgGOSO+Eyx6BSWlikrT3GS7uDdYJnTgzWtFphSRX9r4nCl08pFzIHUgs/4/57hlppIaOo3EvpSRZLWn/GEfwRZd/iUDxK2Bt0zOVufrbmcwYsInOptWVlOTuWgBWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8IynfUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810CCC3277B
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jul 2024 19:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720466840;
	bh=sE/TC7a66+gKH45F+CxcE03eguTRbInKlYcv+mCBwOg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h8IynfULInkFZJZd+lKB7eRQXUHmYQx45MFJI59rKaCaZBSeaOfkIhK0Qsw1OMlxI
	 Xk1UQHYM10XvXRyJizfJ2ppkvQYmnXWpMkNsdy/rlxDNcQZbLTVJGsRKrKfJ0CrEbh
	 CJNLsK7cCqOLCx/GV2G8epiUuCyHKjfWCo7/tp3lNyfHO42ecABi6kEnsLmAFFlBhG
	 DsHP7lheA4hFTb9S/6nrkoAaxRlRHen6pAn+nGOd1xLNi5NyWvBYMUOBkKxCc/yFOS
	 cdF2+WRMEUe2Yh+4gXi2ERd36uhzfWswkfw1iWhL+jcu+ZzMV1dNrj/sNsTrdKqyYN
	 g9EHWOO2RA77A==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d0ea30e87so614857a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jul 2024 12:27:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YyoXR4XhuFxKZzo85V0kIn05mcNm+nnDBetLP0kT5bcDncUUmPS
	e3HmuSeEuJ0Nsf29+x6rmP48a4LqB8/OcgCtfzY33he65CAu5GI+Ph3+XuHEPt94Plv1VqGaLdr
	Rz9w3CnisWpMGUeHnlIFcTG4a/To=
X-Google-Smtp-Source: AGHT+IGlXPLDh/xUR0QdG6tUiooL/Ttl/jOvYiURoiIPZH5BiA3hT9s/QM9OzOCVdtjVxuogbkgdANQQSTTXuUU3wTI=
X-Received: by 2002:a17:907:1dcd:b0:a77:eb34:3b41 with SMTP id
 a640c23a62f3a-a780b69a2a2mr28190066b.2.1720466836912; Mon, 08 Jul 2024
 12:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f5e72ce2-11db-4f19-8aaf-8fd9b62e5a77@nbd.name> <87bk37dhpo.fsf@kernel.org>
In-Reply-To: <87bk37dhpo.fsf@kernel.org>
From: Sean Wang <sean.wang@kernel.org>
Date: Mon, 8 Jul 2024 12:27:05 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzp+1xoceuT3Fi=qXpgFyaQyoW_z=TSHrQepByfb6BR-Ow@mail.gmail.com>
Message-ID: <CAGp9Lzp+1xoceuT3Fi=qXpgFyaQyoW_z=TSHrQepByfb6BR-Ow@mail.gmail.com>
Subject: Re: pull request: mt76 2024-07-08
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi nbd,

I have fixed the build warnings for the patchset. The entire patchset,
including the fixes, has been pushed
to this repository https://github.com/objelf/wireless/commits/mt76/

The specific changes to fix the warnings are included in the following patc=
hes:

"wifi: mt76: mt7925: extend mt7925_mcu_uni_roc_event"
"wifi: mt76: mt7925: update mt7925_mcu_sta_mld_tlv for MLO"
"wifi: mt76: mt7925: add link handling in mt7925_txwi_free"

You can cherry-pick the respective patches or pull the tree as needed.

Best regards,
Sean

On Mon, Jul 8, 2024 at 8:30=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrote:
>
> Felix Fietkau <nbd@nbd.name> writes:
>
> > Hi Kalle,
> >
> > here's my first request for 6.11
> >
> > - Felix
> >
> > The following changes since commit 1b431ba4ef9a760e7643d6fbc53bf522d596=
50f3:
> >
> >   wifi: iwlwifi: mvm: re-enable MLO (2024-07-04 13:50:10 +0200)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2024-07-08
> >
> > for you to fetch changes up to 755db1b86ff49027cae37fc57ce8fef608432c4e=
:
> >
> >   wifi: mt76: mt792x: fix scheduler interference in drv own process (20=
24-07-08 12:23:23 +0200)
> >
> > ----------------------------------------------------------------
> > mt76 patches for 6.11
> >
> > - mt7925 MLO support
> > - mt7925 fix
> >
> > ----------------------------------------------------------------
>
> With this pull request I see (sparse?) warnings:
>
> drivers/net/wireless/mediatek/mt76/mt7925/mcu.c:365:19: warning: invalid =
assignment: +=3D
> drivers/net/wireless/mediatek/mt76/mt7925/mcu.c:365:19:    left side has =
type int
> drivers/net/wireless/mediatek/mt76/mt7925/mcu.c:365:19:    right side has=
 type restricted __le16
> drivers/net/wireless/mediatek/mt76/mt7925/mcu.c:1759:42: warning: incorre=
ct type in assignment (different base types)
> drivers/net/wireless/mediatek/mt76/mt7925/mcu.c:1759:42:    expected unsi=
gned char [usertype] bss_idx
> drivers/net/wireless/mediatek/mt76/mt7925/mcu.c:1759:42:    got restricte=
d __le16 [usertype]
> drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c:63:51: warning: Using=
 plain integer as NULL pointer
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>

