Return-Path: <linux-wireless+bounces-10545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C65393D25A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 13:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319231F212E3
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 11:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B7217A580;
	Fri, 26 Jul 2024 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCrNa0lP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F7C17838B
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2024 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721993575; cv=none; b=GqF4N4EJGL4IjO/A/zeYHXY3uVxD5TE/ONOEh8qSwbTmkoVttaoRwu4ms8/X66T/x/nUPbou+GvWjzxhQs1niIGc+Xjxv+yuupEELSwSbLfXwT7JPl+D3S3ME7oA2hgDh5P52T/YdleOYXSwzcpD6s1FQG7YTRsnjkg31LOlNoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721993575; c=relaxed/simple;
	bh=w9xFYhmu1Bzy8WoLpg3H1kMbSk/5sIlDqvltcKRXSjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwVfOOoblorDk298pfXT1tF1hWw5Evqhgb73SkVXfK5zNC7Z+xz3Zs6BBAbhQZAe5b6bTyVCsHli1fGeBzwO7WRIzph0Eg35lVFwI3jGvukHWY7HH0tFWQbgzVrT6Fbtuiu413LZCRwpUL34PXPIcbTg9KpIYStsxT+2QRXeRiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCrNa0lP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8331C4AF07
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2024 11:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721993574;
	bh=w9xFYhmu1Bzy8WoLpg3H1kMbSk/5sIlDqvltcKRXSjk=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=XCrNa0lPj6JYDGkcffcr8HqmBpkFlGZvRONm0y+KfnHqmS7PqY0PcgL6w9UmOi28z
	 /DmbzLEGj9qnpqYxxOZjVprRiZ9gyTl1QQ8nvtFI5q2IArWTdxp7KiENHy78nakMmu
	 rZlvRO8hSITVFnbD3J/Vq5pEurBqyZvVy63VsRxsgzxJq+SgQcfSVJ8fDqYYKdFM0n
	 Bd21qN2/dpjoTunQEx7bmQGNhUnJlJ0PCxkY1aWbc9/u9sUfyh7M9/Y0nuN9ZJrWH/
	 WrWx/qhvg5awNP47+Jc0kavKvOPx53gcZcXM6IOsBg20z0lBvOO1HGWoBFtKlqShuE
	 x7f1WHZWAmMGA==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-66493332ebfso17336097b3.3
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2024 04:32:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPuagkYNsSn0i1XZg0nNDs3Ebke3gwSEWIZE3ZAWdFkFhaMe9EWXMV9iEUjLcgRwZ2djv+l8d2cCxTsIpcmiNmby6FpbI2ryxYA4vPtRY=
X-Gm-Message-State: AOJu0YzTyptG0VfMnrbaROQInLJTT8ehul2tYie6sz6FWvWO+G6kWrxQ
	yz1dKeKtbLxTo0oDxUVNW+3Q9XSnHpWLsOdW59sqVKSW227xVPNZDIm0yLXyDSsKj+AYxll0j0d
	xFfP5dIonGeOJRti7AzoxxlWdKO0=
X-Google-Smtp-Source: AGHT+IF66Xsb6EysU8CaIQd6YwLPPit8Un4f+snzvBgCraLWhDTxmNy/Mm4ivO8x82y9XaSWvGJ9JPT+WlaNZXOEn1E=
X-Received: by 2002:a81:8a82:0:b0:652:d0a9:87de with SMTP id
 00721157ae682-675b70fbf95mr54199737b3.35.1721993574096; Fri, 26 Jul 2024
 04:32:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW5PR11MB581002D586D332CACEB335BAA3AB2@MW5PR11MB5810.namprd11.prod.outlook.com>
 <CA+5PVA6zGFMsV16BhmbB9QnZQ9UsUw1-44MK6gOc84MnhroDXA@mail.gmail.com> <92696aa1704e43897cbed421136845745e023127.camel@sipsolutions.net>
In-Reply-To: <92696aa1704e43897cbed421136845745e023127.camel@sipsolutions.net>
From: Josh Boyer <jwboyer@kernel.org>
Date: Fri, 26 Jul 2024 07:32:42 -0400
X-Gmail-Original-Message-ID: <CA+5PVA4zbkNYyigULrcOons7bCx2yL+Jgg7jWjo7AOn3d0bOGw@mail.gmail.com>
Message-ID: <CA+5PVA4zbkNYyigULrcOons7bCx2yL+Jgg7jWjo7AOn3d0bOGw@mail.gmail.com>
Subject: Re: pull request: iwlwifi firmware updates 2024-07-25
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Josh Boyer <jwboyer@kernel.org>, 
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, 
	"linux-firmware@kernel.org" <linux-firmware@kernel.org>, "kyle@infradead.org" <kyle@infradead.org>, 
	"Hutchings, Ben" <ben@decadent.org.uk>, "Ben Ami, Golan" <golan.ben.ami@intel.com>, 
	"Yang, You-Sheng" <vicamo.yang@canonical.com>, Wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 4:46=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Thu, 2024-07-25 at 16:03 -0400, Josh Boyer wrote:
> > >
> > >   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmwa=
re.git tags/iwlwifi-fw-2024-07
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux=
-firmware.git
> > tags/iwlwifi-fw-2024-07
> > fatal: couldn't find remote ref tags/iwlwifi-fw-2024-07
> >
> > Did you forget to push the tag out?
> >
>
> That's ... curious :)
>
> Seems like the day ("-25") got cut off at the end, we've always used
> dated tags here, and there is one from today around the time Miri and I
> were discussing this issue, named "iwlwifi-fw-2024-07-25", which also
> matches the subject. No idea how it got cut off in the email though.

OK, thanks for the info.

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/261

josh

